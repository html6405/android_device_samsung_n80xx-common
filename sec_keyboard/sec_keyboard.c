
/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Should you need to contact me, the author, you can do so either by
 * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
 * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
 */

#include <linux/serio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <errno.h>

void setline(int fd, int flags, int speed)
{
	struct termios t;

	tcgetattr(fd, &t);

	t.c_cflag = flags | CREAD | HUPCL | CLOCAL;
	t.c_iflag = IGNBRK | IGNPAR;
	t.c_oflag = 0;
	t.c_lflag = 0;
	t.c_cc[VMIN ] = 1;
	t.c_cc[VTIME] = 0;

	cfsetispeed(&t, speed);
	cfsetospeed(&t, speed);

	tcsetattr(fd, TCSANOW, &t);
}
struct input_types {
	char name[16];
	char name2[16];
	int speed;
	int flags;
	unsigned long type;
	unsigned long id;
	unsigned long extra;
	int flush;
	int (*init)(int fd, long *id, long *extra);
};


#define KEYBOARD_PID_FILE "/data/vendor/sec_keyboard/pid"
#define KEYBOARD_PID_TEMP "/data/vendor/sec_keyboard/pid.new"

/* Publish atomically: the helper must never observe a partially written PID. */
static int publish_keyboard_pid(void)
{
    char buf[32];
    int len = snprintf(buf, sizeof(buf), "%d\n", (int)getpid());
    int fd = open(KEYBOARD_PID_TEMP,
                  O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC | O_NOFOLLOW, 0600);
    if (fd < 0)
        return -1;
    if (fchmod(fd, 0600) < 0)
        goto fail;
    for (int done = 0; done < len;) {
        ssize_t n = write(fd, buf + done, len - done);
        if (n < 0 && errno == EINTR)
            continue;
        if (n <= 0)
            goto fail;
        done += n;
    }
    if (close(fd) < 0) {
        unlink(KEYBOARD_PID_TEMP);
        return -1;
    }
    if (rename(KEYBOARD_PID_TEMP, KEYBOARD_PID_FILE) < 0) {
        unlink(KEYBOARD_PID_TEMP);
        return -1;
    }
    return 0;
fail:
    {
        int saved_errno = errno;
        close(fd);
        unlink(KEYBOARD_PID_TEMP);
        errno = saved_errno;
    }
    return -1;
}

int main(int argc, char **argv)
{
	char c = 0;
	int ldisc = 0;
	int type = 0;
	int flags = 0;
	int speed = 0;
	int fd = 0;
	long id = 0;
	long extra = 0;
	unsigned long devt = 0;
	int ret= 0;

	flags = CS8;
	speed = B9600;
	type = 0x3c;

	if ((fd = open(argv[1], O_RDWR | O_NOCTTY | O_NONBLOCK)) < 0) {
		perror("err : serio attach failure");
		return 1;
	} else
		fprintf(stderr, "%s is opened\n", argv[1]);

	setline(fd, flags, speed);

	ldisc = N_MOUSE;
	ret = ioctl(fd, TIOCSETD, &ldisc);
	if(ret) {
		fprintf(stderr, "can't set line discipline - %d\n", ret);
		return 1;
	}

	devt = type | (id << 8) | (extra << 16);

	if(ioctl(fd, SPIOCSTYPE, &devt)) {
		fprintf(stderr, "can't set device type\n");
		return 1;
	}

    if (publish_keyboard_pid() < 0) {
        perror("sec_keyboard: cannot publish PID");
    }

	while(1) read(fd, NULL, 0);

	return 0;
}


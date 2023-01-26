/****************************************************************
* Record via SoundBlaster (source from John Dyson of FreeBSD)   *
*                                                               *
* Usage : record 5 > wavfile                                    *
*                                                               *
* Geoff Martindale - gjm@rmsq.com                      14.11.96 *
****************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <machine/soundcard.h>


#define DSP "/dev/dsp"
#define MIXER "/dev/mixer"

int     dspfd;
int     mixfd;
int     filefd;


main(int argc, char *argv[])
{
  char buffer[256];
  int readcount;
  int toread;
  int parm;
  int len;

  if (argc > 1) len = atoi(argv[1]);
  if (len < 1) len = 5;

  dspfd = open(DSP, O_RDWR);
  if (dspfd < 0) {
    perror("dspopen");
    exit(1);
  }

  mixfd = open(MIXER, O_RDWR);
  if (mixfd < 0) {
    perror("mixopen");
    exit(1);
  }

  parm = 0;
  if (ioctl(dspfd, SOUND_PCM_RESET, &parm)) {
    perror("ioctlreset");
    exit(1);
  }

  parm = 0;
  if (ioctl(mixfd, SOUND_MIXER_READ_RECSRC, &parm)) {
    perror("ioctlrdsrc");
    exit(1);
  }

  parm = SOUND_MASK_MIC + SOUND_MASK_LINE;
  if (ioctl(mixfd, SOUND_MIXER_WRITE_RECSRC, &parm)) {
    perror("ioctlwrsrc");
    exit(1);
  }

  parm = 0;
  if (ioctl(mixfd, SOUND_MIXER_READ_VOLUME, &parm)) {
    perror("ioctlrdvol");
    exit(1);
  }

  parm = 0x2d2d;
  if (ioctl(mixfd, SOUND_MIXER_WRITE_VOLUME, &parm)) {
    perror("ioctlwrvol");
    exit(1);
  }

  parm = 0;
  if (ioctl(mixfd, SOUND_MIXER_READ_MIC, &parm)) {
    perror("ioctlrdmic");
    exit(1);
  }

  parm = 0x5a5a;
  if (ioctl(mixfd, SOUND_MIXER_WRITE_MIC, &parm)) {
    perror("ioctlwrmic");
    exit(1);
  }

	parm = 16;
	if (ioctl(dspfd, SOUND_PCM_READ_BITS, &parm)) {
		perror("ioctlrd16");
		exit(1);
	}

	parm = 16;
	if (ioctl(dspfd, SOUND_PCM_WRITE_BITS, &parm)) {
		perror("ioctlwr16");
		exit(1);
	}

	parm = 1;
	if (ioctl(dspfd, SOUND_PCM_READ_CHANNELS, &parm)) {
		perror("ioctlrd2");
		exit(1);
	}

	parm = 1;
	if (ioctl(dspfd, SOUND_PCM_WRITE_CHANNELS, &parm)) {
		perror("ioctlwr2");
		exit(1);
	}

	parm = 16000;
	if (ioctl(dspfd, SOUND_PCM_READ_RATE, &parm)) {
		perror("ioctlsp16000");
		exit(1);
	}

	parm = 16000;
	if (ioctl(dspfd, SOUND_PCM_WRITE_RATE, &parm)) {
		perror("ioctlsp16000");
		exit(1);
	}

	filefd = dup(1);

	toread = len * 16000 * 2;
	fprintf(stderr,"%d samples\n", toread);
	while ( toread > 0) {
		readcount = sizeof buffer;
		if (readcount > toread)
			readcount = toread;
		readcount = read(dspfd, buffer, readcount);
		if (readcount < 0) {
			perror("dspread");
			exit(1);
		}		
		write(filefd, buffer, readcount);
		toread -= readcount;
	}

  close(dspfd);
  close(mixfd);
  close(filefd);
}


static char     rcsid[] = "$Id: sb_rec.c,v 1.1 2000/01/30 18:01:36 mark Exp mark $";
/****************************************************************
* Record via SoundBlaster (source from John Dyson of FreeBSD)     *
*                                                               *
* Geoff Martindale - gjm@rmsq.com                      14.11.96 *
* Revised for GASP Mark Terry 4.2.97                           *
****************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#if __linux__
#include <sys/soundcard.h>
#else
#include <machine/soundcard.h>
#endif
#include "df.h"
#include "sp.h"

#define DSP "/dev/dsp"
#define MIXER "/dev/mixer"

#define OFLAG (O_RDWR | O_CREAT)
#define FMODE  0660	

int             dspfd;
int             mixfd;
int             filefd;
int             Fd;
channel         i_chn[2];
channel         df, o_df;
int             N_bufs;
int             header = 1;
int Freq = 16000;

main(int argc, char *argv[])
{
	char            def_file[64];
	char            buffer[512];
	int             writecount;
	int             toread;
	int             parm;

	int             sfptr;
        int             close_it = 1;
	char           *readb;
	struct stat     statbuf;

	float           start = 0.0;
	float           play_time = 0.0;	/* length in secs of speech
						 * segment */

	char            start_date[40];
   channel o_vox;
   float    rec_time = 20.0;
   int sod_posn = 0;
float Max_da;
float  Min_da;
int out_vox_fd;
int len;
int readcount;
int mix_para = 0x5a5a;
int mic_amp = 0x5a5a;

   char tag[10];
	float           S_factor = 1.0;
	float           max_dur;
	int             fposn;
	int             fpos, wrcnt, rdcnt, i;
	int             job_nu = 0;
	int             scale = 0;
	int             debug = 0;
	int             Nchans = 1;
	int             Fchan;
	int             set_play_time = 0;
	int             head_stat = 0;
	int             ipc = 0;
	int             overide_freq = 0;
   int   error, fsize, rem;
   int in_len;
   int total = 0;
   int Mixer_write = 0;

/* defaults */
	strcpy(def_file,"stdout");

	/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}
	strcat(o_df.source, "\0");

	for (i = 1; i < argc; i++) {
		switch (*argv[i]) {
		case '-':
			switch (*(argv[i] + 1)) {

			case 'e':
				set_play_time = 1;
				sscanf(argv[++i], "%f", &rec_time);
				break;
			case 'f':
				sscanf(argv[++i], "%d", &Freq);
				overide_freq = 1;
				break;

			case 'o':
				strcpy(def_file, argv[++i]);
				break;
			case 'b':
				sscanf(argv[++i], "%d", &Fchan);
				break;
			case 'c':
				sscanf(argv[++i], "%d", &Nchans);
				break;

			case 'N':
				header = 0;
				break;

			case 'A':
	                        sscanf (argv[++i], "%x", &mic_amp);
				break;
			case 'M':
				Mixer_write = 1;
	                        sscanf (argv[++i], "%x", &mix_para);
				break;

			case 'S':
				/*
				 * use files as signals between recording
				 * process and application process
				 */
				ipc = 1;

				break;
			case 'Y':
				chk_argc(i,argc,argv) ;
				debug = atoi(argv[++i]);
				break;

			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;
			case 'v':
				show_version();
				exit(-1);
				break;
			case 'H':
			case 'h':
				debug = HELP;
				break;
			default:

				break;
			}
			break;
		default:
			break;
		}
	}


	if (debug == HELP)
		sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

               in_len = (int) (rec_time * Freq);

/* create new sample data header */

        if (header) {

	        strcpy (o_vox.name,"A/D_RECORDING") ;
       	        strcpy (o_vox.type,"CHANNEL") ;

        	o_vox.f[STR] = 0.0; 
	        o_vox.f[STP] = rec_time;   		

		o_vox.f[N] = 1.0 * Nchans;

		gs_o_df_head(def_file,&o_vox);

       	        strcpy(o_vox.dtype,"short");
      	        strcpy(o_vox.dfile,"@");

      		o_vox.f[SF] = (int) Freq;
      		o_vox.f[FS] = 1.0/ Freq;
      		o_vox.f[FL] = 1.0 / Freq;
		o_vox.f[SOD] = 0.0;
      		o_vox.f[N] = 1.0 * in_len / Nchans ;


      		o_vox.f[UL] = Max_da;
      		o_vox.f[LL]=  Min_da;

	/* write out headers */

  		for (i = 0; i < Nchans ; i++) {
		o_vox.f[CN] = 1.0 * i;
		o_vox.f[SKP] = 1.0 * (Nchans-1);		
        	sprintf(tag,"%f",(float) i);
		strcpy(o_vox.name,tag);

		gs_w_chn_head(&o_vox);

/*   write each channel head */
	        }

        sod_posn = gs_pad_header(o_vox.fp);
	o_vox.f[SOD] = 1.0 * sod_posn;

        fsize = (in_len * 2) + sod_posn;

   /* fsize is total size in bytes of file */

   if (fsize > 3e7) {		
      dbprintf (0,"ERROR disk space ");
      return (-1);
   }				
              fflush(o_vox.fp);

	      }

/* out to stdout ? */
   if (strcmp(def_file,"stdout") == 0)
         out_vox_fd = 1;
   else if (( out_vox_fd = open (def_file, OFLAG, FMODE)) < 0) {
      exit (-1);
   }				

/* set file pointer */

	lseek(out_vox_fd,sod_posn,0);

 /* multiply sample freq by Nchans to * allow
   for sequential conversion */
   
   Fd = out_vox_fd;

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

  /*  parm = SOUND_MASK_MIC + SOUND_MASK_LINE; */

  parm = SOUND_MASK_MIC ; 
  if (ioctl(mixfd, SOUND_MIXER_WRITE_RECSRC, &parm)) {
    perror("ioctlwrsrc");
    exit(1);
  }

  parm = 0;  

  if (ioctl(mixfd, SOUND_MIXER_READ_VOLUME, &parm)) {
    perror("ioctlrdvol");
    exit(1);
  }

  dbprintf(0,"mixer read volume %x \n",parm);


  if (Mixer_write) {
   parm = mix_para; 
  }
  else {
  parm = 0; 
  }

  if (ioctl(mixfd, SOUND_MIXER_WRITE_VOLUME, &parm)) {
    perror("ioctlwrvol");
    exit(1);
  }

  parm = 0;
  if (ioctl(mixfd, SOUND_MIXER_READ_MIC, &parm)) {
    perror("ioctlrdmic");
    exit(1);
  }

  parm = mic_amp;

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

	parm = Freq;
	if (ioctl(dspfd, SOUND_PCM_READ_RATE, &parm)) {
		perror("ioctlsp16000");
		exit(1);
	}

	parm = Freq;
	if (ioctl(dspfd, SOUND_PCM_WRITE_RATE, &parm)) {
		perror("ioctlsp16000");
		exit(1);
	}

	sfptr = 0;

	toread = (int) (rec_time * Freq * 2);

	dbprintf(0,"%d samples\n", toread);

	while (toread > 0) {

		readcount = sizeof buffer;

		if (readcount > toread)
			readcount = toread;
		readcount = read(dspfd, buffer, readcount);

		if (readcount < 0) {
			perror("dspread");
			exit(1);
		}		

		write(Fd, buffer, readcount);

		toread -= readcount;
	}


	close(dspfd);
	close(mixfd);
	close(Fd);

	if (job_nu) {
		dbprintf(0, "%s \n", o_df.source);
		job_done(job_nu, start_date, o_df.source);
	}

/* close it */
   if (close_it) {
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
	if (ioctl(mixfd, SOUND_MIXER_READ_VOLUME, &parm)) {
		perror("ioctlrdvol");
		exit(1);
	}

  parm = 0x1010;
  if (ioctl(mixfd, SOUND_MIXER_WRITE_VOLUME, &parm)) {
    perror("ioctlwrvol");
    exit(1);
  }

      }

}


/* USAGE & HELP */

sho_use()
{

	printf("Usage: sb_rec  -o <signal voxfile> -e secs\n");
	printf("Usage: sb_rec  -e secs -N > raw \n");
	fprintf(stderr, "-e stop time secs [EOF] \n");
	fprintf(stderr, "-c number of channels [1]\n");
	fprintf(stderr, "-f sampling frequency [16000] \n");
	fprintf(stderr, "-M mixer on (listen to rec via speaker) \n");
	fprintf(stderr, "-A mic amp %x \n");
	fprintf(stderr, "-N write no header \n");
	exit(-1);
}


show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}

chk_argc(i,argc,argv) 
char           *argv[];
{
  if (i < argc -1)
      return;
  printf("arg missing after %s\n",argv[i]) ;
  exit(-1);
}

static char     rcsid[] = "$Id: sb_play.c,v 1.1 2000/01/30 18:01:36 mark Exp mark $";
/****************************************************************
 * Play via SoundBlaster (source from John Dyson of FreeBSD)     *
*                                                               *
* Geoff Martindale - gjm@rmsq.com                      14.11.96 *
* Revised for GASP Mark Terry 20.12.96                           *
****************************************************************/

#include <gasp-conf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <math.h>


#if __linux__
#include <sys/soundcard.h>
#else
#include <machine/soundcard.h>
#endif

#include "df.h"
#include "sp.h"

#if __linux__
#define DSP "/dev/dsp"
#else
#define DSP "/dev/dsp0"
#endif

#define MIXER "/dev/mixer"

#define SB_BUF_SZ 65536  /* must be an exact multiple of two, no less than 4096 */


/*#define SBPRO 1 */

#ifdef SBPRO
#define NBITS 8
#define SB16 0
#else
#define NBITS 16
#define SB16 1
#endif

static void parse_time_args (int use_samples, int end_adds, char *start_arg, char *end_arg,
			     int head_stat, int set_play_time, const channel *df,
			     int Freq, int fsize,
			     int *Nchans, int *head_size, int *in_len);
static void show_use(int exit_status);
static void show_version(void);
static void gate_buffer(char *buff);
static void scale_buffer(char *buff, float sfactor, int n);

static void set_sound_parms (int dspfd, int mixfd, int freq, int channels);
static void restore_sound_parms (int dspfd, int mixfd);

static void play_sound (int dspfd, int pcmfd, float scale_factor, int freq, int channels,
			int chars_played, int chars_to_play);
static void interactive_message (long samples, int freq);

int filefd;
int Fd;
channel i_chn[2];
channel df, o_df;
int N_bufs;
int header = 1;
FILE *fp;

extern char GS_WORK[];

static int interactive_mode = 0;
static double interactive_gap_seconds = 5.0;

/* I am not sure the waiting for dsp to be free works reliably */
#define TOSECS 60
int kwait;

int
main(int argc, char *argv[])
{
    int dspfd, mixfd;
    char def_file[1024] = "";
    int dowrite = 1;
    int kk = 0;
    int n_plays = 1;
    int Freq = 16000;
    int OVR_Freq = 16000;
    int close_it = 0;

    char start_date[40];

    float S_factor = 1.0;
    int fposn = 0;
    int fpos, head_size, i;
    int job_nu = 0;
    int debug = 0;
    int Nchans = 1;
    int F_chan;
    int set_play_time = 0;
    int head_stat = 0;
    int ipc = 0;
    int override_freq = 0;
    int fsize;
    int in_len;
    int waitforit = 0;
    int pid;
    char pidfile[120];
    int opt;

    char *start_point_arg = 0, *end_point_arg = 0;
    int points_are_samples = 0, end_is_addition = 0;

    /* COPY COMMAND LINE TO OUTPUT HEADER */

    strcpy(o_df.source, "\0");
    for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
	strcat(o_df.source, " ");
    }
    strcat(o_df.source, "\0");

    while ((opt = getopt (argc, argv, "A:CHIJ:NST:WXY:b:c:e:f:hi:n:p:s:tv")) != -1)
	switch (opt)
	{
	case 's':
	    start_point_arg = optarg;
	    break;
	case 'e':
	    set_play_time = 1;
	    end_point_arg = optarg;
	    break;
	case 'p':
	    set_play_time = 1;
	    end_point_arg = optarg;
	    end_is_addition = 1;
	    break;
	case 't':
	    points_are_samples = 1;
	    break;
	case 'i':
	    strcpy (def_file, optarg); /* XXX: hope def_file is `big enough' */
	    break;
	case 'f':
	    sscanf (optarg, "%d", &Freq);
            override_freq = 1;
            OVR_Freq = Freq;
	    break;
	case 'n':
	    sscanf (optarg, "%d", &n_plays);
	    break;
	case 'A':
	    sscanf (optarg, "%f", &S_factor);
	    break;
	case 'b':
	    sscanf (optarg, "%d", &F_chan);
	    break;
	case 'c':
	    sscanf (optarg, "%d", &Nchans);
	    break;
	case 'C':
	    close_it = 1;
	    break;
	case 'N':
	    header = 0;
	    break;
	case 'W':
	    waitforit = 1;
	    break;
	case 'S':
	    /* Use files as signals between recording process and
	     * application process */
	    ipc = 1;
	    break;
	case 'T':
	    if (sscanf (optarg, "%lf", &interactive_gap_seconds) != 1)
		show_use (1);
	    break;
	case 'Y':
	    sscanf (optarg, "%d", &debug);
	    break;
	case 'X':
	    dowrite = 0;
	    break;
	case 'J':
	    sscanf (optarg, "%d", &job_nu);
	    gs_get_date (start_date, 1);
	    break;
	case 'v':
	    show_version ();
	    exit (0);
	    break;
	case 'H': case 'h':
	    debug = HELP;
	    break;
	case 'I':
	    interactive_mode = 1;
	    break;
	case '?':
	    show_use (1);
	}

    if (debug == HELP)
	show_use(0);


    if (optind < argc)		/* args remaining? */
    {
	if (strcmp (def_file, "") != 0 || optind+1 < argc)
	{
	    fprintf (stderr, "Garbage at end of option arguments\n");
	    show_use (1);
	}
	strcpy (def_file, argv[optind]); /* XXXX: hope def_file is `big enough' */
    }

    if (strcmp (def_file, "") == 0)
    {
	fprintf (stderr, "No signal file specified\n");
	show_use (1);
    }

    if (debug > 0)
	debug_spm(argv[0], debug, job_nu);

    pid = getpid();
    get_gs_work();
    sprintf(pidfile,"%s/sb_play_pid",GS_WORK);
    fp = fopen(pidfile,"wb");
    if ( fp != NULL) {
	fprintf(fp,"%d",pid);
	fclose(fp);
    }

    dbprintf(0, "%s my pid is %d\n",pidfile, pid);

    head_stat = 0;
    head_size = 0;

    if (header) {

	if ((fposn = read_sf_head(def_file, &df, &i_chn[0])) == -1) {
	    dbprintf(0, "can't read header\n");
	    header = 0;
	} else
	    head_stat = 1;
    }



    if ( header) {
	Freq = (int) df.f[SF];
        if (Freq == 0.0)
	Freq = (int) i_chn[0].f[SF];
        if (Freq == 0.0 && i_chn[0].f[FS] > 0.0)
	Freq = (int) (1.0/i_chn[0].f[FS]);
        if (Freq == 0.0) Freq = (int) DEFAULT_SF;

    }

    dbprintf(0, "head_stat %d freq %d fposn %d\n", head_stat, Freq,fposn);

    if (Freq > 64000) {
	dbprintf(0, "sb_play: sampling frequency too high for # of channels\n");
	return 1;
    }

    if ((fsize = df_stat(def_file, 0)) <= 0)
    {
	dbprintf (0, "couldn't df_stat the input file\n");
	return 1;
    }

    dbprintf (0, "df_stat size %d\n",fsize);

    parse_time_args (points_are_samples, end_is_addition,
		     start_point_arg, end_point_arg,
		     head_stat, set_play_time, &df, Freq, fsize,
		     &Nchans, &head_size, &in_len);

    if ((Fd = open(def_file, O_RDONLY)) < 0) {
	dbprintf(0, "Can't open file %s\n", def_file);
	return 1;
    }


    dbprintf(0, "sb_play: seek in %d\n",head_size);

    if (head_stat) head_size += fposn;

    fpos = lseek(Fd, head_size, 0);

    dbprintf(0, "sb_play: seek in %d fpos %d\n", head_size, fpos);

    dbprintf(0, "sb_play: play %d Nchans %d\n",in_len,Nchans);

    if (override_freq)
	/* do this now so header freq is used to compute start index from
	 * start time if header Freq is present OVR_Freq is used for play
	 * speed */
	Freq = OVR_Freq;
    /* lets have a time out option */
    kwait = 0;
    do
    {
	dspfd = open (DSP, O_RDWR);
	if (dspfd == -1)
	{
	    dbprintf (1, "dspfd waiting: %s\n", strerror (errno));
	    if (waitforit && kwait < TOSECS) 
		wc_wait (1.0);
	    else
		exit (1);
            kwait++;
	}
    } while (dspfd == -1);


    mixfd = open(MIXER, O_RDWR);

    if (mixfd < 0) {
	perror("mixopen");
	exit(1);
    }

    set_sound_parms (dspfd, mixfd, Freq, Nchans);

    dbprintf(0,"ready to read\n");

    /* wc_wait(1.0); */

    if (kk > 0)
	fpos = lseek(Fd, head_size, 0);

    dbprintf(0,"fpos %d\n",fpos);

    play_sound (dspfd, Fd, S_factor, Freq, Nchans, head_size, in_len);

    if (job_nu) {
	dbprintf(0, "%s \n", o_df.source); 
	job_done(job_nu, start_date, o_df.source);
    }

    /* close it */

    if (close_it) {

	/* don't close before system is finished playing out sound */

	close(Fd);

        dbprintf(0,"dspds %d\n", dspfd);

	restore_sound_parms (dspfd, mixfd);

	close(dspfd);
	close(mixfd);
    }


    return 0;			/* if we got here, we were successful */
}

/* USAGE & HELP */

static void
show_use(int exit_status)
{
    fprintf(stderr, "Usage: sb_play [OPTIONS]... [SIGNAL-FILE]\n");
    fprintf(stderr, "  -i specify signal file\n");
    fprintf(stderr, "  -s start time secs [0]\n");
    fprintf(stderr, "  -e stop time secs [EOF]\n");
    fprintf(stderr, "  -p play no more than the given number of seconds\n");
    fprintf(stderr, "  -t start and end times are in samples, not seconds\n");
    fprintf(stderr, "  -c number of channels [1]\n");
    fprintf(stderr, "  -b start channel [0]\n");
    fprintf(stderr, "  -f sampling frequency [16000]\n");
    fprintf(stderr, "  -N no header use flags or defaults\n");
    fprintf(stderr, "  -A amplification factor\n");
    fprintf(stderr, "  -W wait till device free\n");
    fprintf(stderr, "  -X no write to dsp device (test)\n");
    fprintf(stderr, "  -I interactive mode (show times)\n");
    fprintf(stderr, "  -T time (in seconds) between interactive mode messages [5.0]\n");
    exit(exit_status);
}

static void
show_version(void)
{
    printf(" %s \n", rcsid);
}

static void
gate_buffer(char *buf)
{
    short *buff = (short *) buf;
    buff[0] = 0.0;
    buff[1] *= 0.25;
    buff[2] *= 0.5;
    buff[3] *= 0.75;
}

static void
scale_buffer(char *buf, float sfactor, int n)
{
    short *buff = (short *) buf;
    int i;
    for (i = 0 ; i < n ; i++)
	buff[i] *= sfactor;
}

static int
seconds_to_samples (float secs, int Nchans, int Freq)
{
    return secs * Freq * Nchans;
}

static int
get_arg_as_samples (char *arg, int use_samples, int Freq)
{
    int i;

    if (use_samples)
	sscanf (arg, "%i", &i);
    else
    {
	float f;
	sscanf (arg, "%f", &f);
	i = seconds_to_samples (f, 1, Freq);
    }

    return i;
}

static void
parse_time_args (int use_samples, int end_adds, char *start_arg, char *end_arg,
		 int head_stat, int set_play_time, const channel *df,
		 int Freq, int fsize,
		 int *Nchans, int *head_size, int *in_len)
{
    int max_dur = -1;

    if (head_stat)
    {
	*Nchans = (int) df->f[N];
	max_dur = seconds_to_samples (df->f[STP] - df->f[STR], *Nchans, Freq);
	dbprintf (0, "Nchans %d max_dur %d %f  %f\n",*Nchans,max_dur,df->f[STR],df->f[STP]);
    }

    if (*Nchans < 1 || *Nchans > 2)
    {
	dbprintf (0, "sb_play # of channels out of range\n");
	exit (1);
    }

    *head_size = 0;

    *in_len = -1;

    if (start_arg)
	*head_size = get_arg_as_samples (start_arg, use_samples, Freq);

    if (*head_size < 0) {
	/* want to offset from end of file */
	dbprintf(0," head_size %d fsize %d\n", *head_size, fsize);
	*head_size = fsize/2 + *head_size;
    }

    dbprintf(0," head_size %d\n",*head_size);

    if (set_play_time && end_arg)
    {
	*in_len = get_arg_as_samples (end_arg, use_samples, Freq);
	if (end_adds)
	    *in_len += *head_size;
    }

    dbprintf(0," in_len %d\n",*in_len);

    if (*in_len < 0)
	*in_len = (max_dur >= 0) ? max_dur : fsize / 2;

    dbprintf(0," in_len %d\n",*in_len);

    if (*head_size >= *in_len)
    {
	fprintf (stderr, "start sample %d > stop sample %d\n", *head_size, *in_len);
	exit (1);
    }

    *head_size *= *Nchans * 2;
    dbprintf(0," head_size %d\n",*head_size);

    *in_len *= *Nchans * 2;
    dbprintf(0," in_len %d\n",*in_len);

    *in_len -= *head_size;
    dbprintf(0," in_len %d\n",*in_len);
}

static void
set_sound_parms (int dspfd, int mixfd, int freq, int channels)
{
    int parm;

    if (ioctl(dspfd, SOUND_PCM_RESET, &parm)) {
	perror("ioctlreset");
	exit(1);
    }

    if (ioctl(dspfd, SOUND_PCM_RESET, &parm)) {
	perror("ioctlreset");
	exit(1);
    }

    parm = 0x1010;
    if (ioctl(mixfd, SOUND_MIXER_READ_VOLUME, &parm)) {
	perror("ioctlrdvol");
	exit(1);
    }

    dbprintf(0,"mixer_read_vol %x\n",parm);

    parm = SOUND_MASK_MIC + SOUND_MASK_LINE;
    dbprintf(0,"mixer_para %x\n",parm);

    parm = ~SOUND_MASK_IGAIN & ~SOUND_MASK_MIC & ~SOUND_MASK_LINE;

    /* parm = 0; */

    dbprintf(0,"mixer_para %x\n",parm);

    if (ioctl(mixfd, SOUND_MIXER_WRITE_RECSRC, &parm)) {
	perror("ioctlwrsrc");
	exit(1);
    }

    /* I want to turn off the mic so no feedback how ? set line vol = 0 */

    parm = 0;
    if (ioctl(mixfd, SOUND_MIXER_WRITE_LINE, &parm) == -1) {
	perror("ioctlwrsrc");
	exit(1);
    }

    parm = 95;
    if (ioctl(mixfd, SOUND_MIXER_WRITE_VOLUME, &parm)) {
	perror("ioctl_mixer_write_vol");
	exit(1);
    }

    parm = 0;
    if (ioctl(mixfd, SOUND_MIXER_WRITE_MIC, &parm)) {
	perror("ioctl_mixer_write_mic");
	exit(1);
    }

    dbprintf(0,"mixer_write_mic %x\n",parm);

    if (SB16) {
	parm = 0x1010;
	dbprintf(0,"SB16 %x\n",parm);
	if (ioctl(mixfd, SOUND_MIXER_WRITE_IGAIN, &parm)) {
	    perror("ioctl_mixer_write_igain");
	    exit(1);
	}

	dbprintf(0,"mixer_read_mic %x\n",parm);
	parm = 0x1010;
	if (ioctl(mixfd, SOUND_MIXER_WRITE_OGAIN, &parm)) {
	    perror("ioctl_mixer_write_ogain");
	    exit(1);
	}
    }

    parm = NBITS;
    if (ioctl(dspfd, SOUND_PCM_READ_BITS, &parm)) {
	perror("ioctl_pcm_read_bits");
	exit(1);
    }

    parm = NBITS;
    if (ioctl(dspfd, SOUND_PCM_WRITE_BITS, &parm)) {
	perror("ioctl_pcm_write_bits");
	exit(1);
    }

    parm = channels;
    if (ioctl(dspfd, SOUND_PCM_READ_CHANNELS, &parm)) {
	perror("ioctl_pcm_read_channels");
	exit(1);
    }

    parm = channels;
    if (ioctl(dspfd, SOUND_PCM_WRITE_CHANNELS, &parm)) {
	perror("ioctl_pcm_write_channels");
	exit(1);
    }

    parm = freq;
    if (ioctl(dspfd, SOUND_PCM_READ_RATE, &parm)) {
	perror("ioctl_pcm_read_rate");
	exit(1);
    }

    parm = freq;
    if (ioctl(dspfd, SOUND_PCM_WRITE_RATE, &parm)) {
	perror("ioctl_pcm_write_rate");
	exit(1);
    }
}

static void
restore_sound_parms (int dspfd, int mixfd)
{
    int parm;

    parm = 0;
    if (ioctl(dspfd, SOUND_PCM_RESET, &parm)) {
	perror("ioctl_pcm_reset");
	exit(1);
    }

    parm = 0;
    if (ioctl(mixfd, SOUND_MIXER_READ_VOLUME, &parm)) {
	perror("ioctl_read_vol");
	exit(1);
    }

    parm = 0x1010;
    if (ioctl(mixfd, SOUND_MIXER_WRITE_VOLUME, &parm)) {
	perror("ioctl mixer_write_vol");
	exit(1);
    }
}

static void
interactive_message (long samples, int freq)
{
    static long last_message_point = 0;

    if (samples - last_message_point >= (long) (interactive_gap_seconds * freq))
    {
	double secs = samples / freq;
	printf ("Played %.0f seconds\n", secs);
	last_message_point = samples;
    }
}

static void
play_sound (int dspfd, int pcmfd, float scale_factor, int freq, int channels,
	    int chars_played, int chars_to_play)
{
    static char buffer[SB_BUF_SZ];
    ssize_t buffer_size;
    ssize_t buflen;
    int first_buffer = 0;
    ssize_t did_read = SB_BUF_SZ, did_write;
    long samples_played = chars_played / (2 * channels);

    buffer_size = (freq * channels * 2) / 2; /* a half second sounds good */
    if (((size_t) buffer_size) % 1 != 0)
	buffer_size -= 1;
    if (buffer_size < 4096)
	buffer_size = 4096;
    else if (buffer_size > SB_BUF_SZ)
	buffer_size = SB_BUF_SZ;

    if (interactive_mode)
	interactive_message (samples_played, freq);

    while (did_read != 0 && chars_to_play > 0)
    {
	/*
	 * Step 1: PRODUCE
	 */

	buflen = 0;
	while (buflen < buffer_size)
	{
	    ssize_t to_read = buffer_size - buflen;
	    if (to_read > chars_to_play)
		to_read = chars_to_play;
	    did_read = read (pcmfd, buffer + buflen, to_read);
	    if (did_read == -1)
	    {
		fprintf (stderr, "failed reading from the signal file: %s\n", strerror (errno));
		exit (1);
	    }
	    if (did_read == 0)
		break;
	    buflen += did_read;
	    chars_to_play -= did_read;
	}

	/*
	 * Step 2: CONSUME
	 */

	/* I'm not prepared to handle odd-sized buffers of 16-bit sound.  If
	 * this could happen in the middle of a signal file, the remainder
	 * of the file would be played incorrectly, as we'd be out of phase
	 * by half a sample.  Fortunately, it's almost impossible to get
	 * smaller reads than you wanted unless you're at the end of a file. */
	if ((buflen & 1))
	    buflen--;

	/* Ramp up from zero if this is the first buffer */
	if (first_buffer)
	{
	    gate_buffer (buffer);
	    first_buffer = 0;
	}

	if (scale_factor != 1.0)
	    scale_buffer (buffer, scale_factor, buflen / 2);

	did_write = write (dspfd, buffer, buflen);
	if (did_write != buflen)
	{
	    fprintf (stderr, "failed writing to the dsp: %s\n", strerror (errno));
	    break;
	}

	if (interactive_mode)
	{
	    static int total_samples = 0;
	    struct count_info info;
	    if (ioctl (dspfd, SNDCTL_DSP_GETOPTR, &info) != -1)
		interactive_message (samples_played + info.bytes / (2 * channels), freq);
	    else
	    {
		/* FreeBSD loses again!  It doesn't grok SNDCTL_DSP_GETOPTR,
		 * even though it's documented in the OSS API and mentioned
		 * in the headers.  So we just have to wait until the sound
		 * has been played, and suffer some clicking on playback in
		 * interactive mode.  --Aaron. */
		total_samples += did_write / (2 * channels);
		if (ioctl (dspfd, SNDCTL_DSP_SYNC, 0) == -1)
		{
		    fprintf (stderr, "failed ioctl SNDCTL_DSP_SYNC: %s\n", strerror (errno));
		    exit (1);
		}
		interactive_message (samples_played + total_samples, freq);
	    }
	}
    }
}

static char     rcsid[] = "$Id: crbs.c,v 1.7 1998/05/12 05:31:06 mark Exp $";

/*
 * crbs critical band spectrum Freq-to-Bark Mark Terry  87
 */

#include <stdio.h>
#include <math.h>
#include "df.h"
#include "sp.h"
#include "trap.h"


#define TRIANGULAR 1
#define RECTANGULAR 2

int             debug = 0;

float           sm[8192];
float           In_buf[8192];
double          pow();

float power_to_dB(), dB_to_power();

float Low_slope = -96.0;
float High_slope = -200.0;

rb(In_buf,lower_fft_bin,upper_fft_bin,the_power)
float In_buf[];
float *the_power;
{
int k;
float the_db;
int n_fcs;

                        n_fcs = upper_fft_bin - lower_fft_bin  + 1;
			*the_power = 0.0;
		for (k = lower_fft_bin; k < upper_fft_bin; k++) {
			the_db = In_buf[k];
			*the_power += dB_to_power(the_db);
			}

			*the_power = *the_power / (float) n_fcs;                     

}


tri_filt(In_buf,freq,fqr,bwn,nfb,the_power)
float In_buf[];
float *the_power;
float freq,fqr;
{
int k,cfb;
float bfreq;
float gain;
float the_db;
float foct;

/* for each point in fft dB spec wt contribution to filter-bank */

	cfb = (int) ( freq / fqr) ;
	*the_power = In_buf[cfb];

/* db/Oct slopes */

		for (k = 1; k < cfb; k++) {
                        bfreq = k * fqr;
                        foct = log10 (freq/bfreq) / log10(2.0);
                        gain = foct * Low_slope;
			the_db = In_buf[k] + gain;
			*the_power += (float) dB_to_power(the_db);
			}

		for (k = cfb+1; k < nfb; k++) {
                        bfreq = k * fqr;
                        foct = log10 (bfreq/freq) / log10(2.0);
                        gain = foct * High_slope;
			the_db = In_buf[k] + gain;
			*the_power += dB_to_power(the_db);
			}
                        *the_power = *the_power/bwn;                     

}

 


main(argc, argv)
	int             argc;
	char           *argv[];
{
	double          atof();


	float           am_phon60(), Hz_Bark(), Bark_Hz();

	char            in_file[120], out_file[120];

	float           start, stop, length, amp, da, freq, fqr, st_bark, fn_bark, bark_inc, bark, the_db, the_power, sf, nf, minall, maxall, winms;

	int             i, j, k, eof, fposn, ic, nu_chn, nframes, n_crbs = 8, lower_fft_bin, upper_fft_bin, infd, outfd, winpts, spec_bytes, totpts, loop, shfpts, shfbyts, nbytes;

        int 		n_fcs = 0;
	int             job_nu = 0;
        int             bwn;
	char            start_date[40];

	data_file       o_df, i_df;

	char            sd_file[80];

	int             npts, fp, win_size, win_shft;

	int             loud = 0;

	/* initialise file specifiers */

	int             i_flag_set = 0;
	int             o_flag_set = 0;
        int             ftype = RECTANGULAR;

	/* parse command line variables */

	infd = outfd = 0;
	winms = sf = 0.;


	/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}
	strcat(o_df.source, "\0");


	for (i = 1; i < argc; i++) {

		if (debug == HELP)
			break;

		switch (*argv[i]) {

		case '-':
			switch (*++(argv[i])) {
			case 'i':
				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;
			case 'o':
				o_flag_set = 1;
				strcpy(out_file, argv[++i]);

				break;
			case 'n':
				n_crbs = atoi(argv[++i]);
				break;
			case 'l':
				loud = 1;
				break;
			case 'L':
				Low_slope = atof(argv[++i]);
				ftype = TRIANGULAR;
				break;
			case 'H':
				High_slope = atof(argv[++i]);
				ftype = TRIANGULAR;
				break;

			case 'h':
				debug = HELP;
				break;
			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;
			case 'v':
				show_version();
				exit(-1);
				break;
			case 'Y':
				debug = atoi(argv[++i]);
				break;

			default:
				printf("%s: option not valid\n", *argv[0]);
				debug = HELP;
				break;
			}
		}
	}

	if (debug == HELP || argc == 1)
		show_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	if (!i_flag_set)
		strcpy(in_file, "stdin");

	if (!gs_open_frame_file(in_file, &i_df))
		exit(-1);

	fposn = ftell(i_df.fp);

	dbprintf(1, "end head at %d\n", fposn);

	length = i_df.f[STP] - i_df.f[STR];

	nframes = (int) i_df.f[N];

	dbprintf(1, "duration %f\n", length);

	sf = i_df.f[SF];

	nu_chn = (int) i_df.f[VL];

	dbprintf(0, "sample_freq %f nu_chn %d\n", sf, nu_chn);

	/* write headers to output file */

	fqr = sf / (nu_chn * 2);

	st_bark = (float) Hz_Bark((double) fqr);
	fn_bark = (float) Hz_Bark((double) sf / 2);

	bark_inc = fn_bark / n_crbs;

	/* copy across some data from input to output headers */

	gs_init_df(&o_df);

	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = o_df.f[STR] + length;
	o_df.f[BO] = i_df.f[BO];
	strcpy(o_df.name, "CRBS");
	strcpy(o_df.type, "FRAME");

	o_df.f[N] = 1.0;

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	gs_o_df_head(out_file, &o_df);

	o_df.f[VL] = n_crbs;
	o_df.f[FS] = i_df.f[FS];
	o_df.f[FL] = i_df.f[FL];
	o_df.f[SF] = sf;
	o_df.f[MX] = Hz_Bark(i_df.f[MX]);
	o_df.f[MN] = Hz_Bark(i_df.f[MN]);
	strcpy(o_df.x_d, "Bark");
	strcpy(o_df.y_d, "dB");
	o_df.f[LL] = 0;
	o_df.f[UL] = 100.0;
	o_df.f[N] = i_df.f[N];
	gs_w_frm_head(&o_df);

	fposn = gs_pad_header(o_df.fp);

	loop = 0;

	/************* main loop for analysis *************/

	dbprintf(0, "freq-to-Bark TRANSFORM\n");

	while (1) {

		/* read the dB spectrum */

		eof = gs_read_frame(&i_df, In_buf);

		if (eof == 0) {
			dbprintf(1, "END_OF_FILE\n");
			break;
		}

		bark = bark_inc;

		/*
		 * for each CRB sum power of FFT points & calculate output
		 */

		lower_fft_bin = 0;

		for (j = 0; j < n_crbs; j++) {

			freq = (float) Bark_Hz((double) bark);

			upper_fft_bin = freq / fqr;
                        bwn = upper_fft_bin - lower_fft_bin + 1;
  if (loop == 0)
  dbprintf(0, "freq %f bark %f ufftb %d \n", freq, bark, upper_fft_bin);

			bark += bark_inc;

/* assuming rectangular band-pass 
 * add in option tri-filter -12/200 db/Octave
 * slopes
 */
              
                if (ftype == RECTANGULAR)
                rb(In_buf,lower_fft_bin,upper_fft_bin,&the_power);

                if (ftype == TRIANGULAR)
                tri_filt(In_buf,freq,fqr,bwn,nu_chn,&the_power);

			amp = power_to_dB(the_power);

			lower_fft_bin = upper_fft_bin;

			if (loud) amp = amp + am_phon60(freq);
                        if (amp < 0) amp = 0.0;
			sm[j] = amp;
		}

		/* Write Output */

		gs_write_frame(&o_df, sm);

		loop++;
	}

	/************** end of main loop *****************/

	/* Close input speech data file */

	if (i_flag_set)
		gs_close_df(&i_df);
	if (o_flag_set)
		gs_close_df(&o_df);

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}

	dbprintf(0, "freq-to-Bark conversion COMPLETED: %6d loops\n", loop);
}


show_use()
{
	printf("Usage: crbs  -i infile -o outfile -n bands -l\n");
	printf("-n bands (Hz-Bark transform) input is m-point FFT\n");
	printf("-l apply phon-like loudness contour default is none\n");
printf("-L Low_slope (e.g. -24 dBoct)  set to simulate auditory filter shapes\n");
	printf("-H High_slope (e.g. -100 )\n");
	show_version();
	exit(-1);
}


show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}

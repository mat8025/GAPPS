static char     rcsid[] = "$Id: rms_zx.c,v 1.1 2000/01/31 03:57:35 mark Exp mark $";
/********************************************************************************
*			RMS_ZX							 *


	This program will take as input a vox file
	 and compute a number of parameters useful for voicing decisions
*										 *
*	Modified for pipelining & ascii headers by M.T. Dec 88			 *
*********************************************************************************/

#include <gasp-conf.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include "defs.h"
#include "df.h"
#include "sp.h"
#include "trap.h"


#define NCHANS 20

int             debug = 0;
float           In_buf[MAXWIN];

main(argc, argv)
	int             argc;
	char           *argv[];
{

	data_file       o_df, i_df;
	channel         i_chn[2];
	char            sd_file[80];
	int             fposn, posn, nc;
	int             job_nu = 0;
	char            start_date[40];
	char            in_file[120];
	char            out_file[120];

	channel  o_chn,chn_0;

	int             last_sample_read = 0;
        int             nread;
	int             new_sample = 0;
	int             j, n, eof;

	int             nsamples, npts, win_shift;

	int             winpts, i, loop, nloops;
	int             poflg, nbytes, totpts;
	int             db_flag_set = 0;
        int             pkamp,last_pkamp,deltapts;
        int             pki, dpi,last_pki;
        float           sf;
	float           params[NCHANS];

	float           start, stop, length, h_len;
	float           maxamp,env;
	float           R0, R1, Rdiff, xmin, xmax, zc;
        float           delta,last_env;
	int             x, x1, xdiff;
        int zxdiff = 0;

	double          r0, rms, sqrt();


	/* DEFAULT SETTINGS */
	int             i_flag_set = 0;
	int             o_flag_set = 0;
	float           winms = 20.0;
	float           shfms = 10.0;
        float           deltams = 5.0;
	float           fs = 16000.0;
        last_env = 0.0;

	/* parse command line variables */

	for (i = 1; i < argc; i++) {

		if (debug == HELP)
			break;

		switch (*argv[i]) {

		case '-':

			switch (*(argv[i] + 1)) {

			case 'l':
				chk_argc(i,argc,argv) ;
				winms = atof(argv[++i]);
				break;
			case 't':
				chk_argc(i,argc,argv) ;
				zxdiff = atoi(argv[++i]);
				break;
			case 'd':
				chk_argc(i,argc,argv) ;
				deltams = atof(argv[++i]);
				break;
			case 's':
				chk_argc(i,argc,argv) ;
				shfms = atof(argv[++i]);
				break;
			case 'i':
				chk_argc(i,argc,argv) ;
				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;
			case 'o':
				chk_argc(i,argc,argv) ;
				o_flag_set = 1;
				strcpy(out_file, argv[++i]);
				break;

			case 'D':
				db_flag_set = 1;
				break;

			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;

			case 'Y':
				chk_argc(i,argc,argv) ;
				debug = atoi(argv[++i]);
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
				printf("%s: option not valid\n", argv[i]);
				debug = HELP;
				break;

			}
		}
	}

	if (debug == HELP || argc == 1)
		sho_use();


	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	strcpy(o_df.source, "\0");

	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}

		dbprintf(0,"%s \n", o_df.source);

	if (!i_flag_set)
		strcpy(in_file, "stdin");

	if (read_sf_head(in_file, &i_df, &i_chn[0]) == -1) {
		dbprintf(0, "not header file\n");
		exit(-1);
	}



	nc = 0;

	if ((int) i_df.f[N] > 1) {

		dbprintf(1, "There are %d channels;\n", (int) i_df.f[N]);
	}

	length = i_df.f[STP] - i_df.f[STR];

	dbprintf(0, "str %f stp %f\n", i_df.f[STR], i_df.f[STP]);

	nsamples = (int) i_chn[0].f[N];

        sf = i_df.f[SF];

        if (sf == 0.0)
        sf = i_chn[0].f[SF];

        if (sf == 0.0 && i_chn[0].f[FS] > 0.0)
        sf = 1.0/i_chn[0].f[FS];

        if (sf == 0.0) sf = DEFAULT_SF;

	h_len = nsamples / sf;

	if (h_len < length) {
		o_df.f[STP] = h_len;
		o_df.f[STR] = 0.0;
	}
	if (length <= 0.0) {
		length = h_len;
		o_df.f[STP] = length;
	}

	if (((int) i_chn[nc].f[SOD]) > 0)
		fposn = (int) i_chn[nc].f[SOD];



	/* else start reading where header ends */
	/* sampling frequency */

	fs = sf;

	gs_init_df(&o_df);
	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = i_df.f[STP];


	strcpy(o_df.name, "RMS_ZX");
	strcpy(o_df.type, "CHANNEL");
	strcpy(o_df.x_d, "Time");

	o_df.f[N] = 4.0;

	/* copy across some data from input to output headers */

	/* sampling frequency */

	chn_0.f[SF] = fs;

	/* window size and shift params */

	winpts = (int) (winms * fs / 1000.0 + 0.5);
	deltapts = (int) (deltams * fs / 1000.0 + 0.5);

	chn_0.f[FL] = (float) winpts / fs;

	if (winpts < 1 || winpts > MAXWIN) {
		dbprintf(0, "%s: window size out of range\n", argv[0]);
		exit(-1);
	}

	win_shift = (int) (shfms * fs / 1000.0 + 0.5);

	chn_0.f[FS] = (float) win_shift / fs;

	if (win_shift < 1) {
		dbprintf(0, " window shift out of range vp\n");
		exit(-1);
	}

	totpts = nsamples;

	nloops =  (int) (( (totpts - winpts) / (float) win_shift ) + 1);

	totpts = winpts + (nloops - 1) * win_shift;

dbprintf(0,"totpts %d nloops %d\n",totpts , nloops);

	chn_0.f[N] = nloops;

	chn_0.f[STP] = chn_0.f[STR] + (float) totpts / fs;

	/* write out headers */
	/* write general header */

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	gs_o_df_head(out_file, &o_df);

	/* write channel headers */

	chn_0.fp = o_df.fp;

	strcpy(chn_0.dtype, "float");
        strcpy(o_chn.dtype, "float");

	strcpy(chn_0.name, "RMS");
	chn_0.f[BRK_VAL] = -666666.666666;
	chn_0.f[CN] = 0.0;
	chn_0.f[LL] = 0.0;
	chn_0.f[UL] = 1.0;
	strcpy(chn_0.dfile, "@");

	gs_w_chn_head(&chn_0);

	/* make copy of channel 0 */
        for ( i = 0 ; i < DOF; i++) {
        o_chn.f[i] =chn_0.f[i];
	}
	o_chn.fp = chn_0.fp;
	strcpy(o_chn.dfile, "@");

	strcpy(o_chn.name, "ZC");
	o_chn.f[CN] = 1.0;
        dbprintf(0,"name %s \n", o_chn.name);
	gs_next_chn_head(&o_chn,&chn_0);
 
	strcpy(o_chn.name, "ENV");
	o_chn.f[CN] = 2.0;
	o_chn.f[LL] = -32700.0;
	o_chn.f[UL] = 32700.0;
        dbprintf(0,"name %s \n", o_chn.name);
	gs_next_chn_head(&o_chn,&chn_0);
 
	strcpy(o_chn.name, "DELTA");
	o_chn.f[CN] = 3.0;
	o_chn.f[LL] = 0.0;
	o_chn.f[UL] = 1000.0;

        dbprintf(0,"name %s \n", o_chn.name);

	gs_next_chn_head(&o_chn,&chn_0);

        dbprintf(0,"N %d \n", (int) o_chn.f[N]);

	posn = gs_pad_header(o_df.fp);

	maxamp = i_chn[0].f[UL];

	if (maxamp <= 0.0)
		maxamp = 32768.0;	/* 16bit DA */


        dbprintf(0,"maxamp is %f\n",maxamp);

	/******* main while loop for analysis ********/

        last_env = 1.0;
	dbprintf(0, "RMS_ZX IN PROGRESS...\n");
	npts = winpts;

	j = 0;
	n = npts;
        last_pkamp = 1;

	while (1) {

		nread = gs_read_chn(&i_chn[0], &In_buf[j], n);
		last_sample_read += nread; 

		if (GS_EOF) {
			dbprintf(1, "END_OF_FILE\n");
			break;
		}
		/* dbprintf(0, "lsr %d ns %d %d\n", last_sample_read, nsamples,nread); */
		if (nsamples > 0 && last_sample_read > nsamples) {
			dbprintf(1, "lsr %d ns %d\n", last_sample_read, nsamples);
			break;
		}

		R0 = zc = 0.0;

		for (i = 0; i < winpts; i++) {
			x = In_buf[i];
			R0 += x * x;
		}
 
                env = 0.0;		

		for (i = 0; i < winpts; i++) {
			x = fabs (In_buf[i]);
			if (x > env) env = x;
		}

                zc = zx_detect(In_buf,winpts,zxdiff);

		if (R0 <= 0.0) {
			rms = 0.0;
			zc = 0.0;
		} else {
			r0 = sqrt((double) (R0 / (winpts * 1.0)));
			if (db_flag_set)
				rms = 20 * log10(r0);
			else
				rms = 3.0 * (r0 / maxamp);
		}

                pkamp = 0.0;		
                pki = 0;

		for (i = 0; i < deltapts; i++) {
			x = fabs (In_buf[i]);
			if (x > pkamp) {
			  pkamp = (int) x;
			  pki = i;
                        }
		}

                dpi = ((pki+deltapts) -(last_pki)) ;
/* look ahead to see */
                if (pkamp > last_pkamp && pkamp > 200) {
            delta = ( log((pkamp /last_pkamp)) * fs )/ (float) dpi;
	        }
                else 
		  delta = 0.0;

		/*dbprintf(0,"delta %f pkamp %d last_pkamp %d dpi %d\n",delta,pkamp,last_pkamp ,dpi); */

                last_pkamp = pkamp;
                last_pki = pki;
      
		if (last_pkamp == 0) last_pkamp = 1;  
		params[0] = rms;
		params[1] = zc / (float) winpts;
		params[2] = pkamp;
		params[3] = delta;

		/* store results as parallel tracks in output file */
		fwrite(params, sizeof(float), 4, o_df.fp);
		new_sample += win_shift;

                gs_chn_ip_buf(&i_chn[0], In_buf, new_sample, &last_sample_read, &j, &n, npts);

		loop++;
	}

	/* end of main loop */

	dbprintf(0, "RMS_ZX FINISHED...%d\n", loop);

	if (i_flag_set)
		gs_close_df(&i_df);
	if (o_flag_set)
		gs_close_df(&o_df);

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
}


sho_use()
{
	printf("Usage: rms_zx -l msec  -s msec -i infil -o outfile -d msec\n");
	printf("-l msec window length [20]\n");
        printf("-s msec window shift [10]\n");
        printf("-t zx threshold [100]\n");
        printf("-i infile\n");
        printf("-o outfile\n");
        printf("-d msec delta window msec[5]\n");
	show_version();
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

static char     rcsid[] = "$Id: apm.c,v 1.1 1997/04/12 17:57:56 mark Exp $";
/********************************************************************************
*			APM							 *

	This program will take as input:
	a spectrum file
	or a coefficient file e.g. from lpc analysis

       and produce an all_pole model each frame
*      Mark Terry 1988
*										 *
*	Modified for pipelining & ascii headers by M.T. Dec 88			 *
*********************************************************************************/

#include  <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

int             debug = 0;
float           In_buf[8192];
float           Spec[512];

float           Results[MAXWIN];
float           r[256], cc[256 + 1][256 + 1];
float           a[256], rc[256], error[256];
float           real[MAXWIN], imag[MAXWIN];
float           cosin[640], cb[10000];
int             nscb[256], necb[256];

main(argc, argv)
	int             argc;
	char           *argv[];
{
	data_file       o_df, i_df;
	char            sd_file[80];
	static channel  o_chn;
	int             fposn, posn, nc;
	int             pid, fsize;
	char            in_file[120];
	char            out_file[120];
	int             m_order = 5;
	char            data_type[20];
	int             no_header = 0;
	int             offset = 0;
	float           sf = 16000.0;
	float           g_factor;
	float           length;
	float           expon = 0.6;
	int             gain = 0;
	int             n_coeffs = 5;
	int             spectrum_out = 0;
	int             spec_pwr2 = 8;
	int             spec_pts = 0;
	int             nsp_in;
	int             mode = 1;
	int             time_shift = 0;
	int             nloops;
	int             coef_in = 0;
	int             eof, nsamples, n_frames;
	int             i, j, n, k;
	int             loop;
	int             norm = 0;
	int             warp = 0;
	int             do_log = 0;
	int             eh = 0;

	int             job_nu = 0;
	char            start_date[40];

	double          atof();

	int             nframes;
	char            buf[32];
	float           ex = 1.0 / 3.0;

	/* DEFAULT SETTINGS */

	int             i_flag_set = 0;
	int             o_flag_set = 0;


	/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}
	strcat(o_df.source, "\0");

	/* PARSE COMMAND LINE  */


	for (i = 1; i < argc; i++) {
		if (debug == HELP)
			break;

		switch (*argv[i]) {
		case '-':

			switch (*(argv[i] + 1)) {

			case 'm': /* order of auto_regressive model */
				m_order = atoi(argv[++i]);
				break;
			case 'n':
				spectrum_out = 1;
				spec_pts = atoi(argv[++i]);
				spec_pts *= 2;	/* chk pwr of 2 */
				break;
			case 'g':
				gain = 1;
				break;
			case 'L':
				do_log = 1;
				break;
			case 'i':
				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;

			case 'o':
				o_flag_set = 1;
				strcpy(out_file, argv[++i]);
				break;
			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;
			case 'Y':
				debug = atoi(argv[++i]);
				break;

			case 'C':
				coef_in = 1;
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
			break;
		default:
			printf("%s: option not valid\n", argv[0]);
			break;
		}
	}


	if (debug == HELP)
		sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);


	signal(SIGFPE, fpe_trap);

	if (!i_flag_set)
		strcpy(in_file, "stdin");

	if (!gs_open_frame_file(in_file, &i_df))
		exit(-1);

	/* NB necessary to position file pointer at end of header */

	eh = ftell(i_df.fp);

	length = i_df.f[STP] - i_df.f[STR];

	nframes = (int) i_df.f[N];

	dbprintf(1, "duration %f\n", length);

	if (coef_in)
		m_order = (int) i_df.f[VL];

	sf = 1.0 * (int) i_df.f[SF];

	nsp_in = (int) i_df.f[VL] - 1;

	dbprintf(1, "nsp_in %d\n", nsp_in);

	if (spec_pts <= 0)
		spec_pts = 2 * nsp_in;

	dbprintf(1, "spec_pts %d\n", spec_pts);

	/* copy across some data from input to output headers */

	gs_init_df(&o_df);

	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = o_df.f[STR] + length;
	strcpy(o_df.name, "APM");
	strcpy(o_df.type, "FRAME");

	o_df.f[N] = 1.0;

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	gs_o_df_head(out_file, &o_df);

	if (spectrum_out)
		o_df.f[VL] = (float) (spec_pts / 2 + 1);
	else
		o_df.f[VL] = (float) m_order + 1;

	o_df.f[FS] = i_df.f[FS];
	o_df.f[FL] = i_df.f[FL];
	o_df.f[SF] = sf;

	if (spectrum_out) {
		o_df.f[MX] = sf / 2.0;
		o_df.f[MN] = 0.0;
	} else {
		o_df.f[MX] = (float) m_order;
		o_df.f[MN] = 0.0;
	}

	strcpy(o_df.x_d, "channel_nu");
	strcpy(o_df.y_d, i_df.y_d);

	if (spectrum_out) {
		o_df.f[UL] = i_df.f[UL];
		o_df.f[LL] = i_df.f[LL];
	} else {
		o_df.f[LL] = 0.0;
		o_df.f[UL] = 1.0;
	}
	o_df.f[N] = i_df.f[N];
	gs_w_frm_head(&o_df);
	posn = gs_pad_header(o_df.fp);

	/* sampling frequency */

	eh = ftell(i_df.fp);

	dbprintf(1, "APM IN PROGRESS... pos %d \n", eh);
	nloops = 0;

	while (1) {

		/* input  */

		eof = gs_read_frame(&i_df, In_buf);

		if (eof == 0) {
			dbprintf(2, "END_OF_FILE\n");
			break;
		}

		if (!coef_in) {

			/* INVERSE FFT 	 */

			dbprintf(1, "read spec in %d %d\n", nsp_in, nloops);

			for (i = 0; i <= nsp_in; i++) {
				if (do_log)
					real[i] = pow(10.0, (In_buf[i] / 10.0));
				else
					real[i] = In_buf[i];

				dbprintf(1, "%d %f %f\n", i, In_buf[i], real[i]);

			}

			/* assumes 0 is DC and nsp_in is Nyquist */

			/* reflect coeff */

			dbprintf(1, "reflect coeff \n");

			for (i = 1; i < nsp_in; i++) {
				real[nsp_in + i] = real[nsp_in - i];
			}

			for (i = 0; i < 2 * (nsp_in + 1); i++) {
				imag[i] = 0.0;
			}

			dbprintf(1, "do fft \n");

			gs_fft(&real[0], &imag[0], 2 * (nsp_in + 1), -1);

			/* COMPUTE AUTOREGRESSIVE MODEL */
			/* real array now contains autocorrelation coeffs */
			/* m  is order 2* poles + 1 */
			/* rc  reflection coeff */
			/* error error terms */
			/* a is auto_regressive coeffs */

			for (i = 0; i < m_order; i++)
				dbprintf(2, " %f\n", real[i]);

			dbprintf(1, "@ Durbin \n");

			durbin(real, m_order, error, a, rc);

			for (i = 0; i < m_order; i++)
				dbprintf(1, "durbin out %d %f %f %f\n", i, real[i], a[i], rc[i]);

			g_factor = 0.0;

			for (i = 1; i < m_order; i++) {
				g_factor += a[i] * real[i];
			}

			g_factor = real[0] + g_factor;

			/* g_factor = 1.0 / error[m-1]; */

			dbprintf(1, "g_factor %f %f\n", g_factor, real[0]);

			/*
			 * if (gain && error[m-1] != 0.0) for (i=0; i<m ;i++)
			 * { a[i] /= error[m-1]; }
			 */

		} else {

	dbprintf(1, "read coeff \n");
			for (i = 0; i < m_order; i++) {
				a[i] = In_buf[i];
				/* dbprintf(1,"coeff i %d cf %f \n",i,a[i]); */
				g_factor = a[0];
				a[0] = 1.0;
			}
		}

	if (spectrum_out) {

			dbprintf(1, "produce spec m %d spec_pts %d\n", m_order, spec_pts);

			do_fft(a, m_order, spec_pts, &Results[0]);

			if (gain) {
				for (i = 0; i < spec_pts / 2 + 1; i++)
					Results[i] *= g_factor;
			}
			if (do_log)
				for (i = 0; i < spec_pts / 2 + 1; i++)
					Results[i] = 10.0 * log10(Results[i]);

			gs_write_frame(&o_df, Results);
		} else
			gs_write_frame(&o_df, a);

		/* write out the results */
		dbprintf(1, "loop %d\n", nloops);
		nloops++;
	}

	/************** end of main loop *****************/

	if (i_flag_set)
		gs_close_df(&i_df);
	if (o_flag_set)
		gs_close_df(&o_df);

	dbprintf(1, "APM COMPLETED: %6d loops\n", nloops);

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
}

do_fft(bufin, npts, nfft, bufout)
	int             npts, nfft;
	float           bufin[];
	float           bufout[];
{
	int             i;
	float           y;
	/* load into real buf and zero fill */

	for (i = 0; i < npts; i++) {
		real[i] = bufin[i];
		imag[i] = 0.0;
	}

	for (i = npts; i < nfft; i++) {
		real[i] = 0.0;
		imag[i] = 0.0;
	}

	/* compute the fft */

	gs_fft(&real[0], &imag[0], nfft, 1);

	for (i = 0; i <= nfft / 2; i++) {
		real[i] = real[i] * real[i];
		imag[i] = imag[i] * imag[i];

		y = (real[i] + imag[i]);
		/* y = y * 1.0 / (float) nfft;  */
		/* invert signal */
		if (y > 0.0)
			bufout[i] = 1.0 / y;
	}
}



sho_use()
{
	printf("Usage: apm -m [int]   -n [int]  -i infil -o outfil\n");
	printf("m order  2 * poles + 1 [5] \n");
	printf("C input are coefficients  \n");
	printf("L log spectrum  \n");
printf("g restore spectrum power via a[0] coefficent else normalise \n");
	printf("n number of spectral pts \n");
	exit(-1);
}

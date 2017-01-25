/*
 * NLSM
 * 
 * Non-linear smoother based on Rabiner L.R., Sambur M.R. and Schmidt C.E.
 * (1975);
 * 
 * Applications of a non-linear smoothing algorth. to speech processing. IEEE
 * ASSP-23, 552-557.
 */

#include <gasp-conf.h>

#include <stdio.h>

#include "df.h"
#include "sp.h"
#include "trap.h"


#define DEFMED 5
#define LHAN 3
#define MAXMED 127

int             debug = 0;
float           buffer[1024];
float           output[1024];

main(argc, argv)
	int             argc;
	char           *argv[];
{
	data_file       o_df, i_df;
	channel         i_chn;

	int             job_nu = 0;
	int             ksf;
	char            start_date[40];
	char            in_file[120];
	char            out_file[120];

	int             kout, kin;
	int             infd, outfd, sod, pos, sof, psflg;
	int             posn, eof;
	int             i, nread, loop, c1, c2, c3, c4, first;
	int             C1, C2, C3, C4;
	int             twice, hanning, extrap, ntrk, poflg;
	int             delay, delx, dely, lmed1, lmed2, mid1, mid2;
	int             Nchns;
	int             flush = 0;
	double          medval1, medval2, vatn, watn, xatn, yatn, zatn,
	                ans;
	double          xdel[(MAXMED + LHAN) / 2 + 2], ydel[(MAXMED + LHAN) / 2 + 2];
	double          medbuf1[MAXMED], medbuf2[MAXMED];
	double          hanbuf1[LHAN], hanbuf2[LHAN];
	double          han(), median();


	float           fs;
	float           breaker;


	/* DEFAULT SETTINGS */

	int             i_flag_set = 0;
	int             o_flag_set = 0;

	lmed1 = lmed2 = 0;



	for (i = 1; i < argc; i++) {

		if (debug == HELP)
			break;

		switch (*argv[i]) {
		case '-':
			switch (*(argv[i] + 1)) {

			case 'd':
				twice = 1;
				break;
			case 'l':
				hanning = 1;
				break;
			case 'e':
				extrap = 1;
				break;
			case 'f':
				lmed1 = atoi(argv[++i]);
				break;
			case 's':
				lmed2 = atoi(argv[++i]);
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

			case 'H':
			case 'h':
				debug = HELP;
				break;
			default:
				debug = HELP;
				break;
			}
		}
	}

	if (debug == HELP)
		sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}


	if (!i_flag_set)
		strcpy(in_file, "stdin");


	/* open file */

	ksf = gs_read_channel_head(in_file, 0, &i_chn);

	if (!gs_open_chn(&i_chn))
		exit(-1);

	/* how many channels */
	dbprintf(1, "NC %d skp %f blk %f \n", (int) i_chn.f[CN], i_chn.f[SKP], i_chn.f[BLK]);

	/* smooth which channel? */


	fs = i_chn.f[SF];

	Nchns = 1;

	gs_init_df(&o_df);

	o_df.f[STR] = i_chn.f[STR];
	o_df.f[STP] = i_chn.f[STP];
	o_df.f[FS] = i_chn.f[FS];
	o_df.f[FL] = i_chn.f[FL];


	dbprintf(1, "str %f stp %f\n", i_chn.f[STR], i_chn.f[STP]);

	dbprintf(1, "FS %f FL %f\n", i_chn.f[FS], i_chn.f[FL]);

	strcpy(o_df.name, "NLSM");
	strcpy(o_df.type, "CHANNEL");
	strcpy(o_df.x_d, "Time");

	o_df.f[N] = 1.0 * Nchns;

	/* copy across some data from input to output headers */


	/* write out headers */


	/* write general header */

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	gs_o_df_head(out_file, &o_df);

	/* write channel headers */



	strcpy(o_df.dtype, "float");
	strcpy(o_df.name, "SM_PITCH");


	for (i = 0; i < Nchns; i++) {
		o_df.f[CN] = i * 1.0;
		o_df.f[LL] = 0.0;
		o_df.f[UL] = fs / 2.0;
		o_df.f[N] = i_chn.f[N];
		strcpy(o_df.dfile, "@");
		gs_w_chn_head(&o_df);
	}


	posn = gs_pad_header(o_df.fp);

	/* sort out command string varibles */

	C1 = C2 = C3 = C4 = 0;

	lmed1 = (lmed1 == 0) ? DEFMED : lmed1;

	if (lmed1 < 3 || lmed1 > MAXMED) {
		dbprintf(1, "Length of first median filter out of range.\n");
		return (-1);
	}
	if ((lmed1 / 2 * 2) == lmed1) {
		dbprintf(1, "Order of first median filter must be odd.\n");
		return (-1);
	}
	mid1 = lmed1 / 2;
	C1 = -lmed1;
	delay = lmed1 / 2;
	if (hanning) {
		C2 = -LHAN;
		delay = (lmed1 + LHAN) / 2 - 1;
	}
	if (twice) {
		lmed2 = (lmed2 == 0) ? DEFMED : lmed2;
		if (lmed2 < 3 || lmed2 > MAXMED) {
			dbprintf(1, "Length of second median filter out of range.\n");
			return (-1);
		}
		if ((lmed2 / 2 * 2) == lmed2) {
			dbprintf(1, "Order of second median filter must be odd.\n");
			return (-1);
		}
		mid2 = lmed2 / 2;
		C3 = -lmed2;
		if (!hanning) {
			delx = lmed1 / 2 + 1;
			dely = lmed2 / 2 + 1;
		} else {
			C4 = -LHAN;
			delx = (lmed1 + LHAN) / 2;
			dely = (lmed2 + LHAN) / 2;
		}
		delay = delx + dely - 2;
	}
	dbprintf(1, "total delay = %6d delx %6d dely %6d\n", delay, delx, dely);


	dbprintf(1, "NON-LINEAR SMOOTHING IN PROGRESS...\n");


	c1 = C1;
	c2 = C2;
	c3 = C3;
	c4 = C4;


	breaker = 0.0;
	first = 1;
	kout = kin = 1;

	while (1) {

		loop++;

		/* input value x(n) */

		eof = gs_read_chn(&i_chn, buffer, 1);

		if (eof <= 0) {
			dbprintf(1, "END_OF_FILE\n");
			/*
			 * now flush through using zero as input for next
			 * delay inputs
			 */
			flush++;
			if (flush > delay)
				break;
		}
		dbprintf(1, "loop %d in %d %f\n", loop, kin, buffer[0]);

		kin++;


		if (flush)
			buffer[0] = 0.0;

		xatn = buffer[0];

		/* store input value if double smoothing */

		if (twice) {

			for (i = 0; i < delx; i++)
				xdel[i] = xdel[i + 1];
			xdel[delx] = xatn;
		}
		/* first median smoothing */

		medval1 = median(&c1, xatn, &medbuf1[0], lmed1, mid1);

		if (c1 >= 0) {
			ans = medval1;

			/* first hanning window (optional) */

			if (hanning) {
				yatn = han(&c2, medval1, &hanbuf1[0], breaker, extrap);
				if (c2 >= 0)
					ans = yatn;
				else
					continue;
			}
			/* procedures for double smoothing (optional) */

			if (twice) {

				/* compute rough component z(n) */
				zatn = xdel[0] - ans;

				/* store results of first smoothing */

				for (i = 0; i < dely; i++)
					ydel[i] = ydel[i + 1];

				ydel[dely] = ans;

				/* second median smooothing */

				medval2 = median(&c3, zatn, &medbuf2[0], lmed2, mid2);

				if (c3 >= 0) {	/* 4 */
					ans = medval2;

					/*
					 * second hanning smoothing
					 * (optional)
					 */

					if (hanning) {
						vatn = han(&c4, medval2, &hanbuf2[0], breaker, extrap);

						if (c4 >= 0)
							ans = vatn;
						else
							continue;
					}
					/* double smoothed results w(n) */

					watn = ydel[0] + ans;
					ans = watn;

				}
				 /* 4 */ 
				else
					continue;
			}	/* 3 */
			/* if first time in track, extrapolate backwards */
			if (first) {
				for (i = 0; i < delay; i++) {
					if (extrap)
						output[0] = ans;
					else
						output[0] = breaker;
					fwrite(output, sizeof(float), Nchns, o_df.fp);
					dbprintf(1, "out %d %f\n", kout, output[0]);
					kout++;
				}
				first = 0;
			}
			/* write filtered result */

			output[0] = ans;
			fwrite(output, sizeof(float), Nchns, o_df.fp);
			dbprintf(1, "out %d %f\n", kout, output[0]);
			kout++;

		} else
			continue;
	}

	/* last time in track, extrapolate forwards */


	for (i = 0; i < delay; i++) {
		if (extrap)
			output[0] = ans;
		else
			output[0] = breaker;
		fwrite(output, sizeof(float), Nchns, o_df.fp);
		dbprintf(1, "out %d %f\n", kout, output[0]);
		kout++;
	}


	dbprintf(1, "NLSM FINISHED...%d\n", loop);

	if (i_flag_set)
		gs_close_df(&i_chn);

	if (o_flag_set)
		gs_close_df(&o_df);

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
}


sho_use()
{
	printf("Usage: nlsm -i in_file -o out_file\n");
	exit(-1);
}



/*
 * calculate median for small number of values
 * 
 * Arguments:	counter	# of inputs to filter valin	input value valbuf
 * buffer of values in median calc. lmed	length of median mmed
 * pointer to middle of median filter
 */


double 
median(counter, valin, valbuf, lmed, mmed)
	int            *counter, lmed, mmed;
	double          valin, valbuf[];
{
	int             i, j;
	double          tmp, filmed[127];

	/* store new value with previous values */

	for (i = 0; i < lmed - 1; i++)
		valbuf[i] = valbuf[i + 1];

	valbuf[lmed - 1] = valin;

	/*
	 * if buffer full then transfer data to median buffer and calculate
	 * the median
	 */

	if (++(*counter) >= 0) {

		for (i = 0; i < lmed; i++)
			filmed[i] = valbuf[i];

		for (j = lmed - 1; j > 0; j--)
			for (i = 0; i < j; i++)
				if (filmed[i] > filmed[i + 1]) {
					tmp = filmed[i + 1];
					filmed[i + 1] = filmed[i];
					filmed[i] = tmp;
				}
		return (filmed[mmed]);
	}
}


/*
 * Arguments:	counter	# of inputs to filter valin	input value valhan
 * buffer of medians in hanning calc.
 */


double 
han(counter, valin, valhan, breaker, extrap)
	int            *counter, extrap;
	float           breaker;
	double          valin, valhan[3];
{
	int             i, k;
	double          valout;
	static double   coefs[3] = {
		0.25, 0.50, 0.25
	};

	valout = 0.0;

	/* store new median in hanning filter */

	valhan[0] = valhan[1];
	valhan[1] = valhan[2];
	valhan[2] = valin;

	/* process when hanning window full */
	if (++(*counter) >= 0) {

		/*
		 * count break #'s;
		 * 
		 * if there are no break #'s in buffer then han data; else if
		 * there is one break # and extrapolation set then average
		 * data; otherwise return just break #'s
		 */

		for (k = 0, i = 0; i < 3; i++)
			if (valhan[i] == breaker)
				k++;

		if (k == 0)
			for (i = 0; i < 3; i++)
				valout += coefs[i] * valhan[i];

		else if (k == 1 && extrap > 0)
			for (i = 0; i < 3; i++) {
				if (valhan[i] != breaker)
					valout += coefs[1] * valhan[i];
			}

		else
			valout = breaker;

		return (valout);
	}
}

static char     rcsid[] = "$Id: afb.c,v 1.2 1996/11/17 22:51:18 mark Exp mark $";
/****************************************************************************************
 *	Multi-channel FIR filter bank							*
 *	Time-domain filtering								*
 *	Inputs:	  Vox file 	plus							*
 *	DATA file FRAME containing frequency responses of all filters			*
 *	or										*
 *      file containing impulse response coefficients					*
 *											*
 *	Outputs: 	file containing  filter frequency responses			*
 *      & or										*
 *	Multi-channel Vox file containing filtered data					*
 *	serial version							*
 *											*
 *	 Authors: Mark Terry & Clive Summerfield 					*
 ****************************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/* Define default constants */

#define MIN         10.0e-11

#define MAXAPADR 128000

#define CONST 0.7237

#define FORWARD 1
#define INVERSE -1
#define OPBUFSIZE 512


int             Data, Coeff, Out_vec, Dot1, Dot2, Rads, aprv, idx, Sine,
                Cosine;
int             in_vec_ptr, out_vec_ptr, filter_ptr;
int             Src, Tmp, Result, Ctab, Sv, Pwr2;
int             Scalep;
float           Scaleio[2];

short           Fil_bank_vox[1024];
float           Fil_bank_op[1024];
float           sample, real[1024], imag[1024], rad[1024];
float           Va[MAXAPADR];

float           pi2 = 6.283185307;
float           I0pi2 = 1.0;
float           Scale = 1.0;
float           ss, cc;

int             Opbufsize;
int             debug = 0;

float           In_buf[4096];
float           Window[4096];
int             vox_file_out = 0;
int             out_vox_set = 0;
double          atof();

main(argc, argv)
	int             argc;
	char           *argv[];
{

	data_file       o_df, i_df;
	channel         i_chn[2];
	char            sd_file[80];

	int             fposn = 0;
        int  posn, nc;
	int             fsize;

	int             job_nu = 0;
	char            start_date[40];
	char            in_file[120];
	char            out_file[120];

	char            data_type[20];
	int             no_header = 0;
	int             offset = 0;

	float           length;
	int             mode = 1;
	int             time_shift = 0;

	int             last_sample_read = -1;
	int             new_sample = 0;

	int             eof, nsamples, n_frames;
	int             i, j, n, k;
	int             loop;
        int             total_nw = 0;
        int             nread;

	/* DEFAULT SETTINGS */

	int             i_flag_set = 0;
	int             o_flag_set = 0;
	float           sf = 16000.0;

	int             ii, jj, ns, size;
	int             Dflg = 0, Bwflg = 0, Rflg = 0;
	int             pow2 = 9;
	int             bytes;
	int             u_chn = -1, l_chn = -1;
	int             bufnu = 0;
	int             vap;

	int             last_chn = 0;
	int             npts;


	float           u_freq = 16000.0 / 4.0;
	float           l_freq = 16000.0 / 8.0;

	float           start_time, time;
	float           chn_min, chn_max, chn_inc;
	int             filt_coef_nu;
	int             more_input;
	int             chn_set = 0;
	int             delay = 0;
	int             init = 1;
	int             st_offset;
	int             nbnk;
	int             nbnks = 1;

	int             nu_filters = 1;

	int             infd, outfd, desfl, resfl;
	int             do_filter = 1;
	int             coef_in = 0, coef_out = 0;
	int             c_in, c_out;
	int             var, start_bytes, rbytes;

	char            tag[80];

	char            window_type[40];
	char            filter_type[40];
	char            coef_infile[80], coef_outfile[80];
	char            desfile[80], resfile[80];

	/* Header structures */

	static frame    i_fr;	/* frequency response of filter(s) */
	static frame    o_fr;	/* save actual frequency response of
				 * filter(s) */
	static frame    i_co;	/* coefficient of filter(s) */
	static frame    o_co;	/* save coefficient of filter(s) */


	static channel  chn[2];

	Scaleio[0] = 1.0;
	Scaleio[1] = 1.0;

	/* scale needed to prevent floating point overflow in AP ? */

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
			switch (*++(argv[i])) {

			case 'U':
				chk_argc(i,argc,argv) ;
				u_freq = atof(argv[++i]);
				break;

			case 'L':
				chk_argc(i,argc,argv) ;
				l_freq = atof(argv[++i]);
				break;

			case 'u':
				chk_argc(i,argc,argv) ;
				u_chn = atoi(argv[++i]);
				if (u_chn > 0)
					chn_set = 1;
				break;

			case 'l':
				chk_argc(i,argc,argv) ;
				l_chn = atoi(argv[++i]);
				if (l_chn >= 0)
					chn_set = 1;
				break;
			case 'd':
				chk_argc(i,argc,argv) ;
				strcpy(desfile, argv[++i]);
				Dflg = 1;
				break;
			case 'r':
				chk_argc(i,argc,argv) ;
				strcpy(resfile, argv[++i]);
				Rflg = 1;
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
			case 'v':
				show_version();
				exit(-1);
				break;
			case 'c':
				chk_argc(i,argc,argv) ;
				strcpy(coef_infile, argv[++i]);
				coef_in = 1;
				break;
			case 'D':
				delay = 1;
				break;
			case 'C':
				chk_argc(i,argc,argv) ;
				strcpy(coef_outfile, argv[++i]);
				coef_out = 1;
				break;
			case 's':
				chk_argc(i,argc,argv) ;
				pow2 = atoi(argv[++i]);
				break;
			case 'S':
				chk_argc(i,argc,argv) ;
				sf = atof(argv[++i]);
				break;
			case 'I':
				chk_argc(i,argc,argv) ;
				Scaleio[0] = atof(argv[++i]);
				break;
			case 'O':
				chk_argc(i,argc,argv) ;
				Scaleio[1] = atof(argv[++i]);
				break;
			case 'V':
				chk_argc(i,argc,argv) ;
				vox_file_out = atoi(argv[++i]);
				out_vox_set = 1;
				break;
			case 'N':
				do_filter = 0;
				break;
			case 'w':
				chk_argc(i,argc,argv) ;
				strcpy(window_type, argv[++i]);
				break;
			case 't':
				chk_argc(i,argc,argv) ;
				Bwflg = 1;
				strcpy(filter_type, argv[++i]);
				break;




			case 'Y':
				chk_argc(i,argc,argv) ;
				debug = atoi(argv[++i]);;
				break;

			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
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
		}
	}

	if (debug == HELP)
		show_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	/* use design file channel subset if chn_set = 1 */
	if (u_chn == -1 || l_chn == -1)
		chn_set = 0;

	dbprintf(1, "%s in progress \n", argv[0]);

	/* set default flags */

	if (!coef_out)
		strcpy(coef_outfile, "fir.cof");

	/* Open sampled data files */


	if (do_filter) {

		if (!i_flag_set)
			strcpy(in_file, "stdin");

		if (no_header == 1) {

			/* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file, offset, data_type, sf, &i_df, &i_chn[0]))
				exit(-1);
		} else {
			if (read_sf_head(in_file, &i_df, &i_chn[0]) == -1) {
				dbprintf(1, "not header file\n");
				exit(-1);
			}
dbprintf(1, "input data type %s stop %f \n", i_chn[0].dtype, i_df.f[STP]);
		}

		nc = 0;

	dbprintf(1, "input data type %s\n", i_chn[0].dtype);

		if ((int) i_df.f[N] > 1) {
		dbprintf(1, "There are %d channels;\n", (int) i_df.f[N]);
			exit(-1);
		}
		length = i_df.f[STP] - i_df.f[STR];
		nsamples = (int) i_chn[0].f[N];

		dbprintf(1, "ns %d sf %f\n", nsamples, i_chn[0].f[SF]);

		if (length <= 0.0) {
			length = nsamples / i_chn[0].f[SF];
			o_df.f[STP] = length;
		}

		if (((int) i_chn[nc].f[SOD]) > 0)
			fposn = (int) i_chn[nc].f[SOD];

		/* sampling frequency */

		sf = 1.0 * (int) i_chn[0].f[SF];

		/* Get sample start and stop times */
		o_df.f[STR] = i_df.f[STR];
		o_df.f[STP] = o_df.f[STR] + length;
	}
	/*
	 * DESIGN Read track file for filter specification Open fir filter
	 * response file               and                             Create
	 * output  coefficient file
	 */

	if (Dflg)
		gs_d_filters(desfile, coef_outfile, sf, l_chn, u_chn);

	if (Bwflg)
		gs_d_bw_filters(filter_type, coef_outfile, sf, l_freq, u_freq, pow2);


	/******************************************************/
	/* Read coefficient file             */
	/* Read impulse response tracks to AP vector memory  */
	/******************************************************/

	/* CALIBRATE				     */

	if (!coef_in)
		strcpy(coef_infile, coef_outfile);

	nu_filters = gs_load_calibrate(coef_infile, window_type, resfile, Rflg, &size);

	/* OUTPUT FILE HEADER INFO */

	/*************************************************/
	/* set up output  file            */
	/* write out as headers for  parallel track file */
	/*************************************************/
	if (!do_filter) {
		if (job_nu) {
			job_done(job_nu, start_date, o_df.source);
		}
		exit(0);
	}

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	strcpy(o_df.name, "FIR");
	strcpy(o_df.type, "CHANNEL");
	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = i_df.f[STP];
	o_df.f[N] = 1.0 * nu_filters;

	gs_o_df_head(out_file, &o_df);

	strcpy(o_df.name, "FILTER_BANK");
	/* op data type should same as input data type */
	/* by default */

	if (strcmp(i_chn[0].dtype, "short") == 0
	    && out_vox_set == 0)
		vox_file_out = 1;

	if (vox_file_out)
		strcpy(o_df.dtype, "short");
	else
		strcpy(o_df.dtype, "float");

	dbprintf(1, "in %s  out %s\n", i_chn[0].dtype, o_df.dtype);

	strcpy(o_df.dfile, "@");

	o_df.f[SF] = sf;
	o_df.f[FS] = 1.0 / sf;
	o_df.f[FL] = 1.0 / sf;
	o_df.f[SOD] = 0.0;
	o_df.f[N] = 1.0 * nsamples;
	o_df.f[LL] = i_chn[0].f[LL];	/* 12 bit da range default */
	o_df.f[UL] = i_chn[0].f[UL];

	/* write out headers */

	for (i = 0; i < nu_filters; i++) {
		o_df.f[CN] = 1.0 * i;
		sprintf(tag, "%f", i * chn_inc + chn_min);
		strcpy(o_df.name, tag);
		dbprintf(1, "chn %s\n", tag);
		gs_w_chn_head(&o_df);
		/* write each channel head */
	}

	posn = gs_pad_header(o_df.fp);
	o_df.f[SOD] = 0.0;

	/* FILTER					     */

	if (debug)
		gs_time_ticks(time, 0.1, 1);


	/* Convolver routine for fir filter operation */
	/* should read in a block of at least 512 pts */
	Opbufsize = size;

	dbprintf(1, "size %d Opbufsize %d Data %d\n", size, Opbufsize,Data);
/* Out_vec set via firinit */
	out_vec_ptr =Out_vec;

	more_input = 1;

	j = 0;
	n = Opbufsize;
	more_input = 1;

	if (!delay) {
		nread = gs_read_chn(&i_chn[0], &In_buf[j], n);
		last_sample_read += nread;
dbprintf(0,"no delay read_chn j %d n %d nread %d\n",j,n,nread);
		vap = Data;
		/* could apply input scaling here if overflow */

		for (k = 0; k < size; k++)
			Va[vap + k] = In_buf[k];

		new_sample += Opbufsize;
 gs_chn_ip_buf(&i_chn[0], In_buf, new_sample, &last_sample_read, &j, &n, Opbufsize);
	}


	while (more_input) {

		/* READ INPUT DATA */
		nread = gs_read_chn(&i_chn[0], &In_buf[j], n);

		last_sample_read += nread;

		dbprintf(1, "lsr %d %d\n", last_sample_read, nread);

		if (GS_EOF) {
			dbprintf(1, "END_OF_FILE\n");
			for (k = j+nread ; k < j + n; k++)
				In_buf[k] = 0.0;
			more_input = 0;
		}

		in_vec_ptr = Data;
		filter_ptr = Coeff;
		/*
		 * if (delay) vap = Data + (size/2); else vap = Data + size;
		 * delay = 0;
		 */

		vap = Data + size;
		/* could apply input scaling here if overflow */

		for (k = 0; k < size; k++)
			Va[vap + k] = In_buf[k];

		/*
		 * for each filter obtain  output value by calculating  DOT
		 * PRODUCT of filter coefficient vector and input time vector
		 */

		for (j = 0; j < size; j++) {

			for (i = 0; i < nu_filters; i++) {

				Va[out_vec_ptr] = 0.0;
				for (k = 0; k < size; k++)
					Va[out_vec_ptr] += (Va[in_vec_ptr + k] * Va[filter_ptr + k]);
				filter_ptr += size;
				out_vec_ptr++;
			}

			/* write filter output sample value */

			/* buffer Out_vec to suitable size before writing */

			if ((out_vec_ptr - Out_vec) >= Opbufsize) {
			total_nw += afb_op(o_df.fp, (out_vec_ptr - Out_vec));
				out_vec_ptr = Out_vec;
				bufnu++;
			}
			/* update input vector  ptrs   */

			filter_ptr = Coeff;
			in_vec_ptr++;
		}
		in_vec_ptr = Data;
dbprintf(0,"ovp %d out_vec %d\n",out_vec_ptr,Out_vec);
		/* swop buffers       */

		for (k = 0; k < size; k++)
			Va[Data + k] = Va[Data + size + k];

		if (debug > 1) {
			npts += size;
			time = (float) npts / sf;
			if (gs_time_ticks(time, 0.1, 0))
				dbprintf(1, "npts %d time %f\n", npts, time);
		}

		new_sample += Opbufsize;
if (more_input)
gs_chn_ip_buf(&i_chn[0], In_buf, new_sample, &last_sample_read, &j, &n, Opbufsize);

	}			/* finished ?  */

	/* flush output buffer */

	n = out_vec_ptr - Out_vec;
dbprintf(0,"flush n %d %d %d\n",n,out_vec_ptr,nread);
 	      if (nread > 0) {
		total_nw += afb_op(o_df.fp, nread);
	      }

	if (i_flag_set)
		gs_close_df(&i_df);
	if (o_flag_set)
		gs_close_df(&o_df);

	dbprintf(1, "%s FINISHED wrote %d\n", argv[0],total_nw);

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
}



/***************/
/* Initialise AP */
/***************/

firinit(size, nu_filters)
	int             size, nu_filters;
{
	int             ap_end, vap, k;
	/* Set-up AP memory mapping */

	Data = 0;		/* Data */

	Out_vec = Data + 3 * size + 2;	/* Output vector base pointer */

	Coeff = Out_vec + OPBUFSIZE + 10;	/* Coefficients */

	Scalep = MAXAPADR - 3;

	/* initialise fir array */
	ap_end = Coeff + nu_filters * size;

	if (ap_end > MAXAPADR - size) {
		dbprintf(1, "array memory limit exceeded\n");
		return (-1);
	}
	vap = Data;

	for (k = 0; k < (2 * size); k++)
		Va[vap + k] = 0.0;
	return (1);
}



afb_op(fp, npts)
	FILE           *fp;
{
	int             i, var, k, j;
	/* scale  results 	 */
        int nw;
	for (k = 0; k < npts; k++)
		Fil_bank_op[k] = Va[Out_vec + k];

	if (vox_file_out) {
		for (k = 0; k < npts; k++) {
			if (Fil_bank_op[k] > 32767.0)
				Fil_bank_vox[k] = 32767;
			else if (Fil_bank_op[k] < -32767.0)
				Fil_bank_vox[k] = -32767;
			else
				Fil_bank_vox[k] = (short) Fil_bank_op[k];
		}
		nw =fwrite(Fil_bank_vox, sizeof(short), npts,fp);

	} else
		nw =fwrite(Fil_bank_op, sizeof(float), npts,fp);

dbprintf(0,"afb_op %d %d\n",nw,npts);
        return nw;
}

gs_time_ticks(time, tick, reset)
	float           time, tick;
{
	static float    last_time = 0.0;
	if (reset)
		last_time = 0.0;
	if ((time - last_time) > tick) {
		last_time += tick;
		return (1);
	} else
		return (0);
}




gs_load_calibrate(coef_infile, window_type, resfile, Rflg, filter_size)
	char            coef_infile[], resfile[], window_type[];
	int            *filter_size;
{
	int             nu_filters;
	int             size, posn;
	frame           o_fr, i_co;
	int             i, j, ii, jj;
	float           sf;
	int             k, vap, filt_coef_nu;

	i = gs_open_frame_file(coef_infile, &i_co);

	if (i == -1)
		exit(-1);

	nu_filters = i_co.f[N];
	size = i_co.f[VL];
	*filter_size = size;
	if (debug > 1)
		printf("size %d\n", size);
	sf = i_co.f[SF];
	/***************************************************/
	/* Test design of filter (if design test flag set) */
	/***************************************************/


	if (Rflg == 1) {
		gs_init_df(&o_fr);
		o_fr.f[N] = 1.0;
		strcpy(o_fr.source, "FIR_filter_FRQ_RESP");
		strcpy(o_fr.name, "FIR_filter_FRQ_RESP");
		strcpy(o_fr.type, "FRAME");
		gs_o_df_head(resfile, &o_fr);
		o_fr.f[VL] = 1.0 * size;
		o_fr.f[FS] = 0.05;
		o_fr.f[FL] = 2 * size / sf;
		o_fr.f[LL] = -100.0;
		o_fr.f[UL] = 10.0;
		o_fr.f[BRK_VAL] = -100000.0;
		o_fr.f[SF] = sf;
		o_fr.f[MX] = sf / 2.0;
		o_fr.f[N] = (float) nu_filters;
		strcpy(o_fr.x_d, "Frequency_(Hz)");
		strcpy(o_fr.y_d, "amplitude_(dB)");

		gs_w_frm_head(&o_fr);
		posn = gs_pad_header(o_fr.fp);
	}
	/* Open fir filter response file */

	nu_filters = (int) i_co.f[N];

	if (firinit(size, nu_filters) == -1) {
		printf("Not enough memory\n");
		exit(-1);
	}
	size = (int) i_co.f[VL];
	filt_coef_nu = Coeff;

	for (i = 0; i < nu_filters; i++) {
		gs_read_frame(&i_co, imag);

		if (debug > 1)
			for (j = 0; j < size; j += 4)
				printf("%d %f\n", j, imag[j]);

		/* Apply  weighting                     */

		if (i == 0)
			gs_window(window_type, size, Window);
		for (j = 0; j < size; j++)
			imag[j] = imag[j] * Window[j];

		/* place in  vm      */

		if (debug > 1)
			printf("loading filter coef %d into AP %d\n", i, filt_coef_nu);

		vap = filt_coef_nu;

		for (k = 0; k < size; k++)
			Va[vap + k] = imag[k];

		filt_coef_nu += size;
	}

	if (Rflg) {

		filt_coef_nu = Coeff;
		if (debug > 1)
			printf("CALIBRATING FIR\n");

		for (jj = 0; jj < nu_filters; jj++) {

			for (i = 0; i < size; i++) {
				/* Calculate Radians */

				for (ss = cc = 0.0, ii = 0; ii < size; ii++)
					rad[ii] = ((float) (ii * i) * pi2) / (float) (2 * size);

				for (ss = cc = 0.0, ii = 0; ii < size; ii++) {
					ss = ss + imag[ii] * sin((double) rad[ii]);
					cc = cc + imag[ii] * cos((double) rad[ii]);
				}

				ss = ss * ss + cc * cc;

				if (ss < MIN)
					ss = MIN;

				real[i] = 10.0 * log10(ss);

			}
			/*
			 * Write response into file and increment coefficent
			 * array pointer
			 */

			gs_write_frame(&o_fr, real);

			if (debug > 1)
				printf(" Calibrated channel %d coefficient pointer %d\n",
				       jj, filt_coef_nu);
			filt_coef_nu += size;
		}
	}
	if (Rflg)
		gs_close_frame(&o_fr);
	return (nu_filters);
}

show_use()
{
	printf("-d :design file containing auditory filter bank frequency responses\n");
	printf("-l :lower channel to use default use first channel in design file:\n");
	printf("-u :upper channel to use default use last channel in design file\n");
	printf("-r :if ON the save frequency response of each filter to file\n");
	printf("-w :type of window used in filter\n");
	printf("-t :type of  filter e.g. low_pass high_pass band_pass band_stop\n");
	printf("-L :if -t option specifies lower cut-off frequency\n");
	printf("-U :if -t option specifies upper cut-off frequency\n");
	printf("-s :resolution of filter power of 2 default 9\n");
	printf("-c :coefficient input file name\n");
	printf("-C :coefficient output file name\n");
	printf("-I :input scaling factor:\n");
	printf("-O :output scaling factor:\n");
	printf("-V : [1]; 1 output is short int; 2 output is float :\n");
	printf("-i :input filename:\n");
	printf("-o :output filename:\n");
	printf("-N : no filtering use if only filter coefficients required\n");
	exit(-1);
}

chk_argc(i,argc,argv) 
char           *argv[];
{
  if (i < argc -1)
      return;
  printf("arg missing after %s\n",argv[i]) ;
  show_use();
}
 
show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}

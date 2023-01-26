static char     rcsid[] = "$Id: scale.c,v 1.4 1997/04/12 17:38:52 mark Exp mark $";
/********************************************************************************
*			scale							 *

	This program will take as input  a channel file
       and scale to fit within DA range

*********************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/* Define default constants */

#define SMALL   0.00000001

float           Fbuf[4096];
float           Pi2 = 6.283185307;

main(argc, argv)
	int             argc;
	char           *argv[];
{
	FILE           *gs_wrt_sf(), *sfp;
	data_file       o_df, i_df;

	char            sd_file[80];

	int             fposn, posn, nc;
	int             fsize;
        int             nw = 0;
	char            in_file[120];
	char            out_file[120];
	char            scale_file[120];

	int             job_nu = 0;
	char            start_date[40];


	char            data_type[20];
	int             no_header = 0;
	int             offset = 0;

	float           length;

	int             mode = 1;
	int             time_shift = 0;
        int 		nread;
	int             last_sample_read = 0;
	int             new_sample = 0;

	int             eof, nsamples, n_frames;
	int             i, j, n, k, l;
	int             loop;
	float           factor;
	int             op_short = 1;
	double          atof();

channel         i_chn[128];
int             debug = 0;
float           In_buf[8192];
float           Op_buf[8192];
short           Op_sbuf[1024];

float           Scales[256];
int             vox_file_out = 1;
float           Range = 32000.0;
int             print_mm = 0;


	/* DEFAULT SETTINGS */

	int             i_flag_set = 0;
	int             o_flag_set = 0;
	int             s_flag_set = 0;
	int             m_flag_set = 0;
	int             win_length = 256;
	float           sf = 16000.0;
	int             start = 0;

	float           min = 0.0;
	float           max = 1.0;
        float 		scale_by;
	float           tim;
	char            tag[4];
	short           iodata;

	/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}
	strcat(o_df.source, "\0");


	/* PARSE COMMAND LINE  */


	for (i = 1; i < argc; i++) {

		switch (*argv[i]) {

		case '-':
			switch (*++(argv[i])) {

			case 'R':

				s_flag_set = 1;
				Range = atof(argv[++i]);
				break;

			case 'M':

				m_flag_set = 1;
				scale_by = atof(argv[++i]);
				break;

			case 'i':

				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;

			case 'o':

				o_flag_set = 1;
				strcpy(out_file, argv[++i]);
				break;

			case 'F':

				vox_file_out = 0;
				break;

			case 'm':

				print_mm = 1;
				break;

			case 'Y':

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

			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;

			default:
				fprintf(stderr, "invalid options %s %s\n", argv[0], argv[i]);

			}
			break;
		}
	}

	if (debug == HELP) sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	signal(SIGFPE, fpe_trap);

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
	}

	dbprintf(1, "UL %f LL %f\n", i_chn[0].f[UL], i_chn[0].f[LL]);

	nc = (int) i_df.f[N];

	if ((int) i_df.f[N] > 1) {
		dbprintf(1, "There are %d channels;\n", (int) i_df.f[N]);
		i_chn[0].f[SKP] = i_df.f[N] - 1;
	}

	length = i_df.f[STP] - i_df.f[STR];

	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = i_df.f[STP];

	nsamples = (int) i_chn[0].f[N];

	if (length <= 0.0) {
		length = nsamples / i_chn[0].f[SF];
		o_df.f[STP] = length;
	}

	if (((int) i_chn[0].f[SOD]) > 0)
		fposn = (int) i_chn[0].f[SOD];

	/* else start reading where header ends */
	/* sampling frequency */

	sf = i_chn[0].f[SF];

	/* Get sample start and stop times */

	gs_init_df(&o_df);

	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = o_df.f[STR] + length;

	strcpy(o_df.name, "SCALE");
	strcpy(o_df.type, "CHANNEL");
		o_df.f[N] = 1.0;

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	strcpy(o_df.name, "SCALE");
	strcpy(o_df.type, "CHANNEL");
	o_df.f[N] = 1.0;
	o_df.f[STR] = 0.0;
	o_df.f[STP] = nsamples / sf;

	gs_o_df_head(out_file, &o_df);

	i_chn[0].f[N] = (float) nsamples;


	if (!vox_file_out)
		strcpy(o_df.dtype, "float");
	else
		strcpy(o_df.dtype, "short");

	strcpy(o_df.dfile, "@");

	o_df.f[SF] = sf;
	o_df.f[FS] = 1.0 / sf;
	o_df.f[FL] = 1.0 / sf;
	o_df.f[SOD] = 0.0;
	o_df.f[N] = 1.0 * nsamples;
	o_df.f[LL] = i_chn[0].f[LL];	/* 12 bit da range default */
	o_df.f[UL] = i_chn[0].f[UL];

	/* write out headers */

	/* all channels are same except for tag so write first only */


	o_df.f[CN] = (float) (nc - 1);

	sprintf(tag, "%f", o_df.f[CN]);

	strcpy(o_df.name, tag);

	gs_w_chn_head(&o_df);

	/* write each channel head */

	posn = gs_pad_header(o_df.fp);

	/* set up mix scale  factors */

	for (j = 0; j < nc; j++) {
		Scales[j] = 1.0 / (1.0 * nc);
	}

	/* INITIALISE FOR FIRST READ */

	loop = 0;
	j = 0;
	n = 16;

	/* MAIN LOOP */
	/* get max min */

	posn = ftell(i_chn[0].fp);

	dbprintf(1, "%d\n", posn);
        if ( ! m_flag_set) {

	while (1) {

		/* READ INPUT DATA ONCE */

		nread = read_m_chn(&i_chn[0], &In_buf[0], n);

		if (GS_EOF || nread <= 0) {
			dbprintf(1, "LOOP 1 END_OF_FILE %d\n",nread);
			break;
		}

		if (loop == 0) {
			max = In_buf[0];
			min = In_buf[0];
		}


		for (j = 0; j < nread; j++) {
			Op_buf[j] = 0;
			for (k = 0; k < nc; k++) {
				l = j * nc + k;
				if (max < In_buf[l])
					max = In_buf[l];
				if (min > In_buf[l])
					min = In_buf[l];
			}

		}

		/* CHECK FOR END OF DATA */
		loop++;
	}


	if (print_mm)
		printf("min %f max %f\n", min, max);

	dbprintf(0, "min %f max %f\n", min, max);

	fseek(i_chn[0].fp, posn, 0);
        }

        if (m_flag_set)
	        min = scale_by;
        else
		min = Range / max;

	loop = 0;
	j = 0;
	n = 16;

	posn = ftell(i_chn[0].fp);
	dbprintf(1, "%d\n", posn);

	last_sample_read = 0;
	

	while (1) {

		/* READ INPUT DATA */

		nread = read_m_chn(&i_chn[0], &In_buf[0], n);


		if (GS_EOF || nread <= 0) {
			dbprintf(1, "END_OF_FILE\n");
			break;
		}
	
		if (op_short) {

			for (j = 0; j < nread ; j++) {
				Op_sbuf[j] = 0;
				for (k = 0; k < nc; k++) {
					l = j * nc + k;

					Op_sbuf[l] = (int) (In_buf[l] * min);
				}
			}

			nw += fwrite(Op_sbuf, sizeof(short), nread, o_df.fp);
		} else {

			for (j = 0; j < nread; j++) {
				Op_buf[j] = 0;
				for (k = 0; k < nc; k++) {
					l = j * nc + k;

					Op_buf[l] = In_buf[l] * min;
				}
			}

			nw +=fwrite(Op_buf, sizeof(float), nread, o_df.fp);
		}


	dbprintf(1, "wrt_op %d  %d\n", loop, nw);

		/* CHECK FOR END OF DATA */
		loop++;
	}

	dbprintf(1, "DONE wrt_op %d  %d\n", loop, nw);
/*
	if (i_flag_set)
		gs_close_df(&i_df);
	if (o_flag_set)
		gs_close_df(&o_df);
*/

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
}


sho_use()
{
	fprintf(stderr,
		"Usage: scale [-R -F -i channel file -o channel file ] \n");
	fprintf(stderr, "-M  Multiply by \n");
	fprintf(stderr, "-R  scale to range [+/- 32000] \n");
	fprintf(stderr, "-F  produce float output [short] \n");
	fprintf(stderr, "-m  print min max of input file [noprint] \n");
	show_version();
	exit(-1);
}



show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}


chk_argc(i, argc, argv)
	char           *argv[];
{
	if (i < argc - 1)
		return;
	printf("arg missing after %s\n", argv[i]);
	sho_use();
}

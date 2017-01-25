static char     rcsid[] = "$Id: thres.c,v 1.3 1997/04/12 17:40:25 mark Exp mark $";
/********************************************************************************
*			scale							 *

	This program will take as input  a channel file
         and apply thres to give binary op

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
	int             nread;
	int             last_sample_read = 0;
	int             new_sample = 0;

	int             eof, nsamples, n_frames;
	int             i, j, n, k, l;
	int             loop;
        int             last_on = 0;
        int             smooth = 0;
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
	int             the_chan = 0;

	/* DEFAULT SETTINGS */

	int             i_flag_set = 0;
	int             o_flag_set = 0;
	int             s_flag_set = 0;
	int             t_flag_set = 0;
	int             win_length = 256;
	float           sf = 16000.0;
	int             start = 0;

	float           min = 0.0;
	float           max = 1.0;
	float           thres_by;
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


			case 'T':
				t_flag_set = 1;
				thres_by = atof(argv[++i]);
				break;

			case 'S':
				smooth = 1;
				break;

			case 'i':
				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;

			case 'o':
				o_flag_set = 1;
				strcpy(out_file, argv[++i]);
				break;

			case 'Y':

				debug = atoi(argv[++i]);
				break;

			case 'c':
				the_chan = atoi(argv[++i]);
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

	if (debug == HELP)
		sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	signal(SIGFPE, fpe_trap);

	if (!i_flag_set)
		strcpy(in_file, "stdin");

/*	gs_read_channel_head(in_file, the_chan, &i_df); */

        nc = gs_chk_data_file_type(in_file,&i_df,&i_chn[0]);

	dbprintf(1, " chk_data return %d \n",nc);

	nc = (int) i_df.f[N];

	dbprintf(1, "There are %d channels\n", (int) i_df.f[N]);

	dbprintf(1, "There are samples in chn 0 %d\n", (int) i_chn[0].f[N]);

	dbprintf(1, "str %f stp %f \n", i_df.f[STR],i_df.f[STP]);

	if ((int) i_df.f[N] > 1) {
		i_chn[0].f[SKP] = i_df.f[N] - 1;
	}

	gs_read_channel_head(in_file,the_chan,&i_chn[0]);

	dbprintf(1, "str %f stp %f \n", i_chn[0].f[STR],i_chn[0].f[STP]);

	dbprintf(1, "open  %s\n", (int) i_chn[0].dfile);

	posn = gs_open_chn(&i_chn[0]);

	dbprintf(1, "posn = %d\n", posn);

	dbprintf(1, "UL %f LL %f\n", i_chn[0].f[UL], i_chn[0].f[LL]);
	dbprintf(1, "FS %f FL %f\n", i_chn[0].f[FS], i_chn[0].f[FL]);

	length = i_df.f[STP] - i_df.f[STR];

	nsamples = (int) i_chn[0].f[N];

	dbprintf(1, "There are samples in chn %d %d\n", (int) i_chn[0].f[N],the_chan);


	if (((int) i_chn[0].f[SOD]) > 0)
		fposn = (int) i_chn[0].f[SOD];

	/* else start reading where header ends */
	/* sampling frequency */

        sf = i_df.f[SF];

        if (sf == 0.0)
        sf = i_chn[0].f[SF];

        if (sf == 0.0 && i_chn[0].f[FS] > 0.0)
	         sf = 1.0/i_chn[0].f[FS];

        if (sf == 0.0) sf = DEFAULT_SF;

	/* Get sample start and stop times */

	gs_init_df(&o_df);

	strcpy(o_df.name, "THRES");
	strcpy(o_df.type, "CHANNEL");

	o_df.f[N] = 1.0;
	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = i_df.f[STP];

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	o_df.f[N] = 1.0;

	gs_o_df_head(out_file, &o_df);

	strcpy(o_df.dtype, "float");

	strcpy(o_df.dfile, "@");

	o_df.f[SF] = sf;
	o_df.f[FS] = i_chn[0].f[FS];
	o_df.f[FL] = i_chn[0].f[FL];
	o_df.f[SOD] = 0.0;
	o_df.f[N] = 1.0 * nsamples;
	o_df.f[LL] = 0.0;	
	o_df.f[UL] = 1.0;

/* write out headers */

/* all channels are same except for tag so write first only */

	o_df.f[CN] = 0.0;

	sprintf(tag, "%f", o_df.f[CN]);

	strcpy(o_df.name, tag);

        o_df.f[BRK_VAL] = -2.0;

	gs_w_chn_head(&o_df);

	/* write each channel head */
   
	posn = gs_pad_header(o_df.fp);

	/* set up mix scale  factors */

	/* INITIALISE FOR FIRST READ */

	loop = 0;

	/* MAIN LOOP */
	/* get max min */

	posn = ftell(i_chn[0].fp);

	dbprintf(1, "posn = %d\n", posn);

	loop = 0;

	while (1) {

		/* READ INPUT DATA */

		nread = fread(&In_buf[0], sizeof(float), nc, i_chn[0].fp);

		if (nread <= 0) {
			dbprintf(1, "END_OF_FILE\n");
			break;
		}
/* the open_chn postions at first data point for the specified channel */

/* dbprintf(1,"%f %f \n",In_buf[0], thres_by); */
                                Op_buf[0] = 0.0;
				 if (In_buf[0] >= thres_by)  {
                                        if (last_on || ! smooth)
					Op_buf[0] = 1.0;
                                        last_on = 1;
	                         }
				 else
                                 last_on = 0;
                       


		fwrite(Op_buf, sizeof(float), 1, o_df.fp);

		/* CHECK FOR END OF DATA */
		loop++;
	}

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
}


sho_use()
{
	fprintf(stderr,

        "Usage: thres [-T [1.0]   -i channel file -o channel file ] \n");
	fprintf(stderr, "-T  thres [1.0 if above 0.0 else] \n");
	fprintf(stderr, "-c  channel number \n");
	fprintf(stderr, "-S  smooth \n");

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

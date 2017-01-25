static char rcsid[] = "$Id: pcon.c,v 1.5 1998/05/23 16:11:39 mark Exp mark $";
/*
 * pcon
 * 
 * classifies  pitch contour output will be feature type
 * 
 * n_samples in local pitch contour start time stop time slope const contour
 * shape (level,rise,fall, ...) ave pitch
 * 
 * Mark Terry
 */

#include <stdio.h>
#include <stdlib.h>
#include "df.h"
#include "sp.h"
#include "trap.h"
#include "quasi.h"

char           *quasi_rule();
int             debug = 0;
float           *buffer;
float           *spsbuffer;
float           output[4096];

/*
 * #define P_RISE 1 #define P_FALL -1 #define P_LEVEL 0
 * 
 * typedef struct { float start_time; float stop_time; float ave; float sd;
 * float max; float min; float slope; float const; float dur; int nps; int
 * type; } P_con;
 */

P_con           Pcon[1000];

float           pitch_ave = 0.0;
float           Min_pitch_duration =0.80;
float           Max_pitch_gap =0.80;
int             Lcon, Fcon;
float           High_rise, High_rise_dur, Ldur, Fdur;
float           Fave, Lave;

main(argc, argv)
	int             argc;
	char           *argv[];
{

	data_file       o_df, i_df;
	channel         i_chn;

	char            ans[120];
	int             print_ans = 0;
	int             job_nu = 0;
	int             ksf;
	char            start_date[40];
	char            in_file[120];
	char            out_file[120];
	char            lab_file[120];

	int             k;
	int             infd, outfd, sod, pos;
	int             posn, eof;
	int             i, nread, loop, first;
	int             Nchns;
	int             do_loop;
	int             n_syll = 0;

	float           fs;
	float           breaker;

	/* DEFAULT SETTINGS */

	int             i_flag_set = 0;
	int             o_flag_set = 0;
	int             l_flag_set = 0;

	for (i = 1; i < argc; i++) {

		if (debug == HELP)
			break;

		switch (*argv[i]) {
		case '-':
			switch (*(argv[i] + 1)) {

			case 'i':
				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;

			case 'o':
				o_flag_set = 1;
				strcpy(out_file, argv[++i]);
				break;
			case 'l':
				l_flag_set = 1;
				strcpy(lab_file, argv[++i]);
				break;
			case 'P':
				print_ans = 1;
				break;
			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;
			case 'd':
				Min_pitch_duration = atof(argv[++i]) / 1000.0;
                                
				break;
			case 'g':
				Max_pitch_gap = atof(argv[++i]) /1000.0;
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

dbprintf(0,"min_pitch_dur %f max_pitch_gap %f\n",Min_pitch_duration,Max_pitch_gap);


	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}


	if (!i_flag_set)
		strcpy(in_file, "stdin");

	/* open file */
	dbprintf(1, "opening %s\n", in_file);
/* channel 1 is smooth pitch */

	ksf = gs_read_channel_head(in_file, 1, &i_chn);

	if (!gs_open_chn(&i_chn)) {
		dbprintf(1, "error opening channel %s\n", in_file);
		exit(-1);
	}

	/* how many channels */

	/* which channel? */

	fs = i_chn.f[SF];

	Nchns = 1;

	gs_init_df(&o_df);

	o_df.f[STR] = i_chn.f[STR];
	o_df.f[STP] = i_chn.f[STP];
	o_df.f[FS] = i_chn.f[FS];
	o_df.f[FL] = i_chn.f[FL];

	dbprintf(1, "str %f stp %f\n", i_chn.f[STR], i_chn.f[STP]);
	dbprintf(1, "FS %f FL %f\n", i_chn.f[FS], i_chn.f[FL]);

	strcpy(o_df.name, "PCON");
	strcpy(o_df.type, "CHANNEL");
	strcpy(o_df.x_d, "Time");

	o_df.f[N] = 1.0 * Nchns;

	/* copy across some data from input to output headers */
	/* write out headers */
	/* write general header */

	if (!o_flag_set)
		strcpy(out_file, "stdout");

	k = gs_o_df_head(out_file, &o_df);

	if (!k) {
		dbprintf(1, "cant open %s\n", out_file);
		exit(-1);
	}
	/* write channel headers */

	strcpy(o_df.dtype, "ascii");
	strcpy(o_df.name, "PITCH_CON");


	o_df.f[CN] = 0.0;
	o_df.f[LL] = 0.0;
	o_df.f[UL] = fs / 2.0;
	o_df.f[N] = i_chn.f[N];


        loop = (int)o_df.f[N];
	dbprintf(1, "N %d\n", loop);

        spsbuffer = (float *) calloc(5*loop,sizeof(float));
        buffer = (float *) calloc(5*loop,sizeof(float));
	if (buffer == NULL) {
	dbprintf(0,"can't calloc enough %d\n",loop);
        }
	strcpy(o_df.dfile, "@");

	gs_w_chn_head(&o_df);

	dbprintf(1, "done w_chn \n");

	posn = gs_pad_header(o_df.fp);
	dbprintf(1, "posn %d \n", posn);

	breaker = 0.0;
	first = 1;

	eof = gs_read_chn(&i_chn, &buffer[0], loop);

	if (eof <= 0) {
			dbprintf(1, "END_OF_FILE\n");
			buffer[loop] = 0.0;
	}

	dbprintf(1, "in %d read %d %f %f\n", loop,eof, buffer[0],buffer[loop]);

        gs_close_chn(&i_chn);

	ksf = gs_read_channel_head(in_file, 2, &i_chn);

	if (!gs_open_chn(&i_chn)) {
		dbprintf(1, "error opening channel %s\n", in_file);
		exit(-1);
	}

	eof = gs_read_chn(&i_chn, &spsbuffer[0], loop);

	if (eof <= 0) {
			dbprintf(1, "END_OF_FILE\n");
			spsbuffer[loop] = 0.0;
	}


	dbprintf(1, "in %d read %d %f\n", loop,eof, spsbuffer[0]);

	n_syll = c_pcon(buffer, loop, Pcon, o_df.f[FS], o_df.fp);

	fprintf(o_df.fp, "phrase_ave %f\n", Pcon[n_syll].ave);

	strcpy(ans, quasi_rule(n_syll, Pcon));

	fprintf(o_df.fp, "N_SYLL %d\n", n_syll);
	fprintf(o_df.fp, "ANS %s\n", ans);

	dbprintf(1, "PCON FINISHED...n_syll %d %s\n", n_syll, ans);

        if (l_flag_set) 
	       pcon_label_file(lab_file,n_syll,fs);

	if (i_flag_set)
		gs_close_df(&i_chn);

	if (o_flag_set)
		gs_close_df(&o_df);

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}
	if (print_ans)
		printf("%s \n", ans);

}

sho_use()
{
	printf("Usage: pcon -i in_file -o out_file\n");
	fprintf(stderr, "-g	gap to smooth across	msecs\n");
	fprintf(stderr, "-d	smallest significant pitch segment msecs\n");
	fprintf(stderr, "-l     label file name\n");
	exit(-1);
}

pcon_label_file(name,n_syll,sf)
char *name;
float sf;
{
 FILE *fp;
 int i;
        fp = fopen(name, "w");

	if (fp != NULL ) {

        for (i = 0 ; i < n_syll ; i++ ) {
        fprintf(fp,"%d     ",(int)(Pcon[i].sp_start_time * sf));     	 	
	fprintf(fp,"%d     ",(int)(Pcon[i].sp_stop_time * sf ));     	 		
	fprintf(fp,"%d     \n",Pcon[i].type);     	 		
        }
	}

}

show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}

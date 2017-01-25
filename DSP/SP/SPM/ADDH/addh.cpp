/*********************************************************************************
 *			addh							 *
 *	converts data_files							 *
 * 	default output type short integer					 *
 *	Mark Terry 								 *
 *	Modiifed for pipelining  Dec 88						 *
 *********************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <stdlib.h> 
#include <fcntl.h>
#include "defs.h"
#include "df.h"
#include "sp.h"
#include "dsp.h"
#include "pf.h"
#include "trap.h"
#include "debug.h"


// quick convert to cpp -- so we can use the 'new' C++ ds,df,stats lib 


char            ip_data_type[20] = "short";
char            op_data_type[20] = "short";
char		coding[32] = "linear16";

void sho_use();
void
show_version()
{
  char rcs[32];
  //	char           *rcs;
  //	rcs = &rcsid[0];
  strcpy(rcs,"v1.0");
  printf(" %s \n", rcs);

}

void
chk_argc(int i, int argc, char *argv[])
	
{
/*	printf("arg %d %s %s\n", i,argv[i],argv[i+1]); */
	if (i < argc - 1)
		return;
	printf("arg missing after %s\n", argv[i]);
	sho_use();
}





int             debug = 0;
extern int      M_BO;
int
main(int argc,char *argv[])

{
	FILE           *gs_wrt_sf();
	FILE           *ifp, *ofp, *fopen();

	int             i, j;
	char            infile[120];
	char            outfile[120];
        char tag[10];
	float           value;

	data_file       df, d_ob;
	int             posn;
	int             job_nu = 0;
	char            start_date[40];
	int             k;
        int             sod_posn;
        int             update_chn_posn;
	int             Dtype;
	int             min_max = 0;
	float           min;
	float           max;
	int             first = 1;
	int             op_d_type = SHORT;
	int             ip_d_type = SHORT;

	int             read_head, eof;
	float           data[2048];
	short           buf[1024];
        short		*bp;
	int             nu_chn = 1;
	int             fsize = 0;
	int             nsamples = 0;
	int             offset = 0;
	float           sf = 16000.0;

        int             do_max_min = 0;
	int             i_flag_set = 0;
	int             o_flag_set = 0;
	int             scale_on = 0;
	int             word_sz = 16;
	int             byte_order = M_BO;
        int 		header_only = 0;
        int 		swap_bytes = 0;
	float           da_range;
	float           scale = 1.0;

	data_file       o_df, i_df,o_db;
	channel         n_chn[0];

	/* process command line for specifications */


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
				chk_argc(i, argc, argv);
				i_flag_set = 1;
				strcpy(infile, argv[++i]);
				break;

			case 'o':
				chk_argc(i, argc, argv);
				o_flag_set = 1;
				strcpy(outfile, argv[++i]);
				break;

			case 'f':
				chk_argc(i, argc, argv);
				sf = (float) atof(argv[++i]); 
				break;

			case 'S':
				chk_argc(i, argc, argv);
				scale = atof(argv[++i]);
				scale_on = 1;
				break;

			case 'n':
				chk_argc(i, argc, argv);
				sscanf(argv[++i], "%d", &nu_chn);
				break;

			case 'O':
				chk_argc(i, argc, argv);
				offset = atoi(argv[++i]);
				break;
			case 'B':
			        swap_bytes = 1;
				break;
			case 'M':
			        do_max_min = 1;
				break;

			case 'b':
				byte_order = atoi(argv[++i]);
				break;
			case 'W':
				chk_argc(i, argc, argv);
				word_sz = atoi(argv[++i]);
				break;
			case 'T':
				chk_argc(i, argc, argv);
				strcpy(ip_data_type, argv[++i]);
				break;
			case 'H':
				header_only = 1;
				break;
			case 'C':
				chk_argc(i, argc, argv);
				strcpy(op_data_type, argv[++i]);
				break;
			case 'c':
				chk_argc(i, argc, argv);
				strcpy(coding, argv[++i]);
				break;
			case 'J':
				chk_argc(i, argc, argv);
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;
			case 'Y':
				chk_argc(i, argc, argv);
				debug = atoi(argv[++i]);
				break;
			case 'v':
				show_version();
				exit(-1);
				break;
			default:
				debug = HELP;
				break;
			}
			break;
		}
	}

	if (debug == HELP || argc == 1)
		sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	/* set default flags */
	/* open input file  & seek (read in offset bytes) */

	if (!i_flag_set)
		strcpy(infile, "stdin");
	else {
		/*
		 * get file size minus offset and work out n_samples & STP
		 * time
		 */
		posn= gs_chk_data_file_type(infile,&df,&d_ob);
                offset += posn;
		fsize = df_stat(infile, 0);
		fsize -= offset;
		dbprintf(1, "fsize %d\n", fsize);
	}

        min = max = 0.0;

	if ( ! read_no_header(infile, offset, ip_data_type, sf, &i_df, &n_chn[0]))
		exit(-1);

	da_range = pow(2.0, (double) (word_sz - 1));

dbprintf(0,"word_sz %d da_range %f %d\n", word_sz, da_range, header_only);

dbprintf(0,"offset %d sf %f ip_type %s op_type %s\n", offset, sf, ip_data_type, op_data_type);

	/* positions @ start_of_data determines data_type */

	if (strcmp(ip_data_type, "float") == 0)
		Dtype = FLOAT;
	if (strcmp(ip_data_type, "ascii") == 0)
		Dtype = ASCII;
	if (strcmp(ip_data_type, "short") == 0)
		Dtype = SHORT;
	if (strcmp(ip_data_type, "int") == 0)
		Dtype = INT;

	if (strcmp(op_data_type, "float") == 0)
		op_d_type = FLOAT;
	if (strcmp(op_data_type, "short") == 0)
		op_d_type = SHORT;
	if (strcmp(op_data_type, "ascii") == 0)
		op_d_type = ASCII;
	if (strcmp(op_data_type, "int") == 0)
		op_d_type = INT;

	strcpy(n_chn[0].dtype, op_data_type);

	nsamples = fsize / (get_data_size(&n_chn[0]) * nu_chn);

	set_byte_order(byte_order);

	dbprintf(0, "byte_order set to %d\n", byte_order);
	dbprintf(0, "num of channels %d\n", nu_chn);

	if (!o_flag_set)
		strcpy(outfile, "stdout");

	strcpy(o_df.name, "ADDH");
	strcpy(o_df.type, "CHANNEL");

	o_df.f[NOB] = nu_chn;
	o_df.f[SF] = sf;
	o_df.f[STR] = 0.0;
        o_df.f[BO] = byte_order;
	o_df.f[STP] = nsamples / sf;
	o_df.f[FS] = 1.0 / sf;
	n_chn[0].f[BRK_VAL] = -666666.666666; 
	n_chn[0].f[UL] = da_range;
	n_chn[0].f[FS] = 1.0 / sf;
	n_chn[0].f[LL] = -1 * da_range;
	n_chn[0].f[NOB] = (float) nsamples;

        if (header_only) {
	strcpy(n_chn[0].dfile,infile);
	o_df.f[SOD] = (float) offset;
        }
        else
	strcpy(n_chn[0].dfile,"@");
dbprintf(0,"dfile %s %d\n",n_chn[0].dfile,o_df.f[SOD]);

        strcpy(o_df.y_d,coding);

	gs_o_df_head(outfile,&o_df);
        update_chn_posn = ftell(o_df.fp);
        n_chn[0].fp = o_df.fp;

  		for (i = 0; i < nu_chn ; i++) {
		n_chn[0].f[CN] = 1.0 * i;
                n_chn[0].f[BO] = byte_order;
		n_chn[0].f[SKP] = 1.0 * (nu_chn-1);		
        	sprintf(tag,"%d", i);
		strcpy(n_chn[0].name, tag);
		gs_w_chn_head(&n_chn[0]);
		/* dbprintf(0,"tag %s\n",n_chn[0].name); */
	        }

        sod_posn = gs_pad_header(o_df.fp);

dbprintf(0,"sod_p %d\n",posn);

	k = 1;

        fflush(o_df.fp);

        ofp = o_df.fp;

	while ( ! header_only  || do_max_min ) {

		if (Dtype == FLOAT) {

			eof = fread(data, sizeof(float), 1, i_df.fp);

			if (eof <= 0)
				break;

			if (scale_on)
				data[0] = scale * data[0];

                        if (data[0] < min) min = data[0];
                        if (data[0] > max) max = data[0];

                       if ( ! header_only) {

			if (op_d_type == ASCII) {
				fprintf(ofp, "%f\n", data[0]);
			}
			if (op_d_type == FLOAT)
				fwrite(data, sizeof(float), 1, ofp);

			if (op_d_type == SHORT) {
				buf[0] = (short) data[0];
				fwrite(buf, sizeof(short), 1, ofp);
			}
		      }

		} 

		else if (Dtype == SHORT) 

			{
			eof = fread(buf, sizeof(short), 1, i_df.fp);

		/*      dbprintf(0,"eof %d %d \n",eof,buf[0]); */

			if (eof <= 0) break;

                        if (swap_bytes) {	                 
                        swab(&buf[0],&buf[1],2);
                        bp = &buf[1];
                        buf[0] = buf[1];
                        }
                        else 
			bp = &buf[0];

			/*              dbprintf(0,"%d \n",buf[0]); */

			if (scale_on)
				*bp = scale * (float) *bp;

                        if (*bp < min) min = *bp;
                        if (*bp > max) max = *bp;

                       if ( ! header_only) {
			if (op_d_type == SHORT)
				fwrite(bp, sizeof(short), 1, ofp);

			if (op_d_type == FLOAT) {
			data[0] = (float) *bp;
				fwrite(data, sizeof(float), 1, ofp);
                        }

			if (op_d_type == ASCII) {
				fprintf(ofp, "%d\n", bp);
			      }
		}

		} else if (Dtype == ASCII) {
			eof = fscanf(i_df.fp, "%f", &data[0]);
			if (eof <= 0)
				break;
			if (scale_on)
				data[0] = scale * data[0];

                        if (data[0] < min) min = data[0];
                        if (data[0] > max) max = data[0];


                       if ( ! header_only) {
			if (op_d_type == FLOAT)
				fwrite(data, sizeof(float), 1, ofp);
			if (op_d_type == SHORT) {
				buf[0] = (short) data[0];
				fwrite(buf, sizeof(short), 1, ofp);
			}
			if (op_d_type == ASCII) {
				fprintf(ofp, "%f\n", data[0]);
			}
                      }
		}
	}

/* max - min - rewrite header */

        if ( (! header_only) || do_max_min) {
dbprintf(0,"min %f max %f\n",min,max);
/* update header */
        if (do_max_min) {
	n_chn[0].f[UL] = max ;
	n_chn[0].f[LL] = min ;
        fseek(o_df.fp,update_chn_posn,0);
        n_chn[0].fp = o_df.fp;
  		for (i = 0; i < nu_chn ; i++) {
		n_chn[0].f[CN] = 1.0 * i;
		n_chn[0].f[SKP] = 1.0 * (nu_chn-1);		
        	sprintf(tag,"%d", i);
		strcpy(n_chn[0].name,tag);
		gs_w_chn_head(&n_chn[0]);
	        }
        }
        fclose(ofp);
        }

	if (job_nu) {
		job_done(job_nu, start_date, o_df.source);
	}

}

/* USAGE & HELP */
void
sho_use()
{
	fprintf(stderr,
		"Usage: addh [-T datatype -C datatype -f [16000.0]  -O [0] -S [1.0] -i infile -o outfile] \n");

	fprintf(stderr, "addh prefixes a header and converts a signal datafile    	\n");
	fprintf(stderr, "Default output is ascii header & short integer data     	\n");
	fprintf(stderr, "-T	input data_type [short] (short,float,ascii) \n");
	fprintf(stderr, "-C	converted to data_type [short]  \n");
	fprintf(stderr, "-f	sampling frequency  of signal \n");
	fprintf(stderr, "-O	offset from start of datafile in bytes  \n");
	fprintf(stderr, "-S	scale factor [1.0] \n");
	fprintf(stderr, "-W	AD word size [16] (8,12,14,16)  \n");
	fprintf(stderr, "-B	swap_bytes (short-short,only)  \n");
	fprintf(stderr, "-M	determine max-min values and write to header UL,LL  \n");
	fprintf(stderr, "-b	byte-order [1234] (4321 (sun) ,1234 (intel) )  \n");
	fprintf(stderr, "-H     header file points to data (no-conversion)  \n");
	fprintf(stderr, "-o	output data file  \n");
	fprintf(stderr, "-i	input data file  \n");
	fprintf(stderr, "-n	number of channels[1]  \n");
	show_version();
	exit(-1);
}


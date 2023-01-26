static char     rcsid[] = "$Id: dfc.c,v 1.2 1999/09/07 19:04:09 mark Exp mark $";
/*********************************************************************************
 *			dfc							 *
 *	converts  data_files						         *
 * 	default output type ascii						 *
 *	Mark Terry 								 *
 *	Modiifed for pipelining  Dec 88						 *
 *********************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"


extern int FPE;

union Buff {
	char  cbuf[64];
	short buf[32];
	float data[16];
        int   idata[16];
	double dbdata[8];
} iob ;

int debug = 0;
main (argc, argv)
int   argc;
char *argv[];
{

	FILE *ifp, *hfp, *ofp, *fopen();

	int i,j;
        int nwords,kw;
   
	char in_file[120];
	char out_file[120];
	char head_file[120];
	int job_nu = 0;
	char start_date[40];

	data_file o_df,i_df;
	float value;
	int Iflg = 0;
	int Oflg = 0;
	data_file df,d_ob;
	int posn;
	int pick_col = -1;
	int col =1;
	int k;
	int Dtype = ASCII;
	int out_header =1;
	int in_header =1;
	int join_files = 0;
	int header_point = 0;	
	int min_max =0;
	float min;
	float max;
	int first = 1;
	int op_data_type = ASCII;
	int swap_bytes = 0;
	int read_head,eof;
	int open_at =0;
	int quit_at =0;
	int quit_at_record =0;
        int nrecords = 0;
	long int start_of_data = 0;
        long int seek_sod = 0;

	char hex_string[4];

	float data[10];
	int idata[10];
	double dbdata[10];

	short buf[10];

	unsigned char  us_cbuf[10];
	char  cbuf[10];

	int nu_chn;
	char line[120];


	if (signal(SIGFPE, SIG_IGN) != SIG_IGN)
		signal(SIGFPE, fpe_trap);

        FPE = 0;
/* process command line for specifications */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}
	strcat(o_df.source, "\0");

	for (i = 1 ; i < argc; i++) {

		switch (*argv[i]) {
		case '-':
			switch (*++(argv[i])) {

			case 'i':
				Iflg = 1;
				strcpy (in_file,argv[++i]);
				break;

			case 'o':
				Oflg = 1;
				strcpy (out_file,argv[++i]);
				break;

			case 'O':
				open_at  = atoi( argv[++i]);
				break;

			case 'Q':  /* at item number */
				quit_at  = atoi( argv[++i]);
				break;

			case 'q':  /* at item number */
				quit_at_record  = atoi( argv[++i]);
				break;

			case 'h':
				out_header = 2;
				if (argv[i+1] != NULL)
				strcpy (head_file,argv[++i]);
				else
				debug = HELP;
				break;

			case 'j':
				join_files = 1;
				strcpy (head_file,argv[++i]);
				break;

			case 'c':
				Dtype = CHAR;
				break;
				
			case 'u':
				Dtype = UNSIGNED_CHAR;
				break;			
			case 'x':
				Dtype = HEX;
				break;
			case 't':
				Dtype = INT;
				break;
			case 'd':
				Dtype = DOUBLE;
				break;
			case 'X':
				op_data_type = HEX;
				break;
			case 'C':
				op_data_type = CHAR;
				break;
			case 'A':
				op_data_type = ASCII;
				break;
			case 'l':
				col= atoi( argv[++i]);
				break;
			case 'p':
				pick_col = atoi(argv[++i]);
				break;
			case 'F':
				op_data_type = FLOAT;
				break;

			case 'D':
				op_data_type = DOUBLE;
				break;

			case 'f':
				Dtype = FLOAT;
				break;

			case 's':
				Dtype = SHORT;
				break;

			case 'I':
				op_data_type = INT;
				break;

			case 'S':
				op_data_type = SHORT;
				break;

			case 'B':
				swap_bytes = 1;
				break;

			case 'N':
				out_header = 0;
				break;

			case 'n':
				in_header = 0;
				break;

			case 'k':
				seek_sod  = atoi( argv[++i]);
				break;
			case 'Y':
				debug = atoi( argv[++i]) ;
                                debug = check_debug_level(debug);
				break;
			case 'J':
				job_nu = atoi( argv[++i]) ;
				gs_get_date(start_date,1);
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

	if (debug == HELP)
		sho_use();

	if ( debug > 0)
		debug_spm(argv[0],debug,job_nu) ;

	/* set default flags */

	if (Iflg) {
		/* 	open data file */

		if (in_header) {
			posn= gs_chk_data_file_type(in_file,&df,&d_ob);
		/*	positions @ start_of_data determines data_type */
			if(strcmp(d_ob.dtype,"float") ==0)
				Dtype = FLOAT;
			else 	if(strcmp(d_ob.dtype,"double") == 0)
				Dtype = DOUBLE;
			else 	if(strcmp(d_ob.dtype,"short") ==0)
				Dtype = SHORT;
			else 	if(strcmp(d_ob.dtype,"char") ==0)
				Dtype = CHAR;				
			else 	if(strcmp(d_ob.dtype,"int") ==0)
				Dtype = INT;				
			else 	if(strcmp(d_ob.dtype,"unsigned_char") ==0)
				Dtype = UNSIGNED_CHAR;								
		}

		if ( (ifp = fopen(in_file,"rb")) == NULL)
			exit(-1);

/*  seek start_of_data */

		fseek(ifp,0,0);
	} else 
		ifp = stdin;


	if (join_files) {
		if ( (ifp = fopen(head_file,"rb")) == NULL)
			exit(-1);
	}

	if (out_header == 2) {
		if ( (hfp = fopen(head_file,"wb")) == NULL)
			exit(-1);
	}

	if (Oflg) {
		if ( (ofp = fopen(out_file,"wb")) == NULL)
			exit(-1);
	} else
		ofp = stdout;

	if (out_header != 2)
		hfp = ofp;

	if (in_header) {

		while ( (nwords = get_wrds(ifp,line)) != -1) {

			if (strcmp(Word[0],"dtype") == 0) {

				if (strncmp(Word[1],"short",5) == 0)
					Dtype = SHORT;
				else if (strcmp(Word[1],"float") == 0)
					Dtype = FLOAT;
				else if (strcmp(Word[1],"double") == 0)
					Dtype = DOUBLE;
				else if (strcmp(Word[1],"int") == 0)
					Dtype = INT;
				else if (strcmp(Word[1],"ascii") == 0)
					Dtype = ASCII;
				else if (strcmp(Word[1],"char") == 0)
					Dtype = CHAR;					
				else 	if(strcmp(Word[1],"unsigned_char") ==0)
				Dtype = UNSIGNED_CHAR;				
				else 	if(strcmp(Word[1],"hex") ==0)
				Dtype = HEX;				

				if (join_files)
					op_data_type = Dtype;

				if (op_data_type == ASCII)
					strcpy(Word[1],"ascii");
					
				if (op_data_type == HEX)
					strcpy(Word[1],"hex");

				if (op_data_type == SHORT)
					strcpy(Word[1],"short");

				if (op_data_type == FLOAT)
					strcpy(Word[1], "float");

				if (op_data_type == DOUBLE)
					strcpy(Word[1], "double");

				if (op_data_type == INT)
					strcpy(Word[1],"int");

			}

			if (strcmp(Word[0],"SOD") == 0) {
				sscanf(Word[1],"%d",&start_of_data);
                        if (start_of_data < 0) {
			           start_of_data = 0;                    
                                   strcpy(Word[1],"0");
					       }
			}
			
			if (strcmp(Word[0],"dfile") == 0) {

				if (strncmp(Word[1],"@",1) != 0) {
					header_point = 1;
					strcpy(in_file,Word[1]);
					strcpy(Word[1],"@");
			        }
				if (out_header == 2)
					strcpy(Word[1],out_file);
				if (join_files) {
					strcpy(in_file,Word[1]);
					strcpy(Word[1],"@");
				}
			}

			if (out_header >= 1) {
			  if (nwords > 0) {
			    for (kw = 0 ; kw < nwords ; kw++) {
  			      fprintf(hfp,"%s ",Word[kw]);
		             }
  			   fprintf(hfp,"\n");
		          }
		      }

			if ( check_eh()) {
			fseek(ifp,start_of_data,1);
				break;
                        }
		}
	}

	if (out_header == 2)
		fclose(hfp);

	if (join_files || header_point) {
		fclose(ifp);
dbprintf(1,"jf %d hp %d data_file %s\n",join_files,header_point,in_file);
		if ( (ifp = fopen(in_file,"rb")) == NULL)
			exit(-1);
			fseek(ifp,start_of_data,0);
	}


        if (seek_sod > 0)
			fseek(ifp,seek_sod,0);

	k = 1;

	dbprintf(1,"in_data type %d out_data_type %d  sod %d\n",
	    Dtype,op_data_type,start_of_data);


	while (1)
	{

		if ( k > quit_at && quit_at > 0)
			break;

/* SWAB BYTES  */

		if (swap_bytes) {
			if ( Dtype == SHORT ) {
				eof = fread (buf,sizeof(short), 1, ifp);
				if ( eof <= 0)
					break;
				swab(&buf[0],&buf[1],2);
				if ( k >= open_at)
					fwrite(&buf[1],sizeof(short), 1, ofp);
			}
			else if ( Dtype == FLOAT ) {
				eof = fread (&iob.buf[0],sizeof(float),1, ifp);
				if ( eof <= 0)
					break;
				swap_float(iob.buf);
			
				if ( k >= open_at)
				fwrite(&iob.buf[3],sizeof(short),2,ofp);
			}
			else if ( Dtype == INT ) {
				eof = fread (&iob.buf[0],sizeof(int),1, ifp);
				if ( eof <= 0)
					break;
				swap_int(iob.buf);
				if ( k >= open_at)
				fwrite(&iob.buf[3],sizeof(short),2,ofp);
			}
		}

/*  DOUBLE CONVERSION */

		else if ( Dtype == DOUBLE)  {

			eof = fread (dbdata,sizeof(double), 1, ifp);

			if (eof <= 0) break;

			if ( op_data_type == ASCII && ( k >= open_at) ){

				if (pick_col == -1) {
					fprintf(ofp,"%e	",dbdata[0]);
					if (k % col == 0)
						fprintf(ofp,"\n");
				}
				else {
				if ((k + (col - (pick_col+1))) % col == 0)
					fprintf(ofp,"%e\n",dbdata[0]);
				}

			}

			if ( op_data_type == FLOAT && ( k >= open_at) ){
				fwrite(dbdata,sizeof(float), 1, ofp);
			}

			if ( op_data_type == SHORT && ( k >= open_at) ){
				if (dbdata[0] > 32767.0)
					dbdata[0] = 32767.0;
				else if (dbdata[0] < -32767.0)
					dbdata[0] = -32767.0;
				dbprintf(1,"%lf\n",dbdata[0]);
				buf[0] = (short) dbdata[0];

				fwrite(buf,sizeof(short), 1, ofp);
			}
		}

/*  FLOAT CONVERSION */

		else if ( Dtype == FLOAT)  {

			eof = fread (data,sizeof(float), 1, ifp);

			if (eof <= 0) break;

			if ( op_data_type == ASCII && ( k >= open_at) ){

				if (pick_col == -1) {
					fprintf(ofp,"%e	",data[0]);
					if (k % col == 0)
						fprintf(ofp,"\n");
				}
				else {
				if ((k + (col - (pick_col+1))) % col == 0)
						fprintf(ofp,"%e\n",data[0]);
				}

			}

			if ( op_data_type == FLOAT && ( k >= open_at) ){
				fwrite(data,sizeof(float), 1, ofp);
			}

			if ( op_data_type == SHORT && ( k >= open_at) ){
				if (data[0] > 32767.0)
					data[0] = 32767.0;
				else if (data[0] < -32767.0)
					data[0] = -32767.0;
				dbprintf(1,"%f\n",data[0]);
				buf[0] = (short) data[0];

				fwrite(buf,sizeof(short), 1, ofp);
			}

		}


/*  INT CONVERSION */

		else if ( Dtype == INT)  {

			eof = fread (idata,sizeof(int), 1, ifp);

			if (eof <= 0) break;

			if ( op_data_type == ASCII && ( k >= open_at) ){

				if (pick_col == -1) {
					fprintf(ofp,"%d	",idata[0]);
					if (k % col == 0)
						fprintf(ofp,"\n");
				}
				else {
				if ((k + (col - (pick_col+1))) % col == 0)
					fprintf(ofp,"%d\n",idata[0]);
				}
			}

			if ( op_data_type == FLOAT && ( k >= open_at) ){
                                data[0] = (float) idata[0];
				fwrite(data,sizeof(float), 1, ofp);
			}

			if ( op_data_type == SHORT && ( k >= open_at) ){
				if (idata[0] > 32767.0)
					idata[0] = 32767.0;
				else if (idata[0] < -32767.0)
					idata[0] = -32767.0;

				buf[0] = (short) idata[0];
				fwrite(buf,sizeof(short), 1, ofp);
			}
		}
		else if ( Dtype == SHORT ) {

			eof = fread (buf,sizeof(short), 1, ifp);

			if (eof <= 0) break;

			if ( op_data_type == SHORT && ( k >= open_at) ){
				fwrite(buf,sizeof(short), 1, ofp);
			}

			if ( op_data_type == FLOAT && ( k >= open_at) ){
				data[0] = (float) buf[0];
				fwrite(data,sizeof(float), 1, ofp);
			}

			if ( op_data_type == ASCII && ( k >= open_at) ){
				fprintf(ofp,"%d	",buf[0]);
				if (k % col == 0)
					fprintf(ofp,"\n");

			}
		}

		else if ( Dtype == UNSIGNED_CHAR ) {

			eof = fread (us_cbuf,sizeof(char), 1, ifp);

			if (eof <= 0) break;

			if ( op_data_type == SHORT && ( k >= open_at) ){

				buf[0] = (short) us_cbuf[0];

				fwrite(buf,sizeof(short), 1, ofp);
			}

			if ( op_data_type == FLOAT && ( k >= open_at) ){

				data[0] = (float) us_cbuf[0];

				fwrite(data,sizeof(float), 1, ofp);
			}

			if ( op_data_type == ASCII && ( k >= open_at) ){
				fprintf(ofp,"%d	",(int) us_cbuf[0]);
				if (k % col == 0)
					fprintf(ofp,"\n");

			}
			
			if ( op_data_type == HEX && ( k >= open_at) ){
				sprintf(hex_string,"%x",us_cbuf[0]);
				if (strlen(hex_string) == 1)
				fprintf(ofp,"0%x ",us_cbuf[0]);
				else
				fprintf(ofp,"%x ",us_cbuf[0]);
				if (k % col == 0)
					fprintf(ofp,"\n");

			}		
		}


		else if ( Dtype == CHAR ) {
			eof = fread (cbuf,sizeof(char), 1, ifp);

			if (eof <= 0) break;

			if ( op_data_type == SHORT && ( k >= open_at) ){
				buf[0] = (short) cbuf[0];
				fwrite(buf,sizeof(short), 1, ofp);
			}
			
		
			if ( op_data_type == CHAR && ( k >= open_at) ){
				fwrite(cbuf,sizeof(char), 1, ofp);
			}

			if ( op_data_type == FLOAT && ( k >= open_at) ){

				data[0] = (float) cbuf[0];

				fwrite(data,sizeof(float), 1, ofp);
			}

			if ( op_data_type == ASCII && ( k >= open_at) ){

				fprintf(ofp,"%d	",(int) cbuf[0]);

				if (k % col == 0)
					fprintf(ofp,"\n");

			}

		}

		else if ( Dtype == ASCII ) {

			eof = fscanf (ifp,"%f",&data[0]);

			dbprintf(1,"eof %d %f\n",eof,data[0]);

			if (eof <= 0) break;

			if ( op_data_type == FLOAT && ( k >= open_at) ){
				fwrite(data,sizeof(float), 1, ofp);
			}

			if ( op_data_type == SHORT && ( k >= open_at) ){
				buf[0] = (short) data[0];
				fwrite(buf,sizeof(short), 1, ofp);
			}

			if ( op_data_type == ASCII && ( k >= open_at) ){

				if (pick_col == -1) {
					fprintf(ofp,"%e	",data[0]);
					if (k % col == 0)
						fprintf(ofp,"\n");
				}
				else {
				if ((k + (col - (pick_col+1))) % col == 0)
						fprintf(ofp,"%e\n",data[0]);
				}
			}
		}
		k++;

             if ((k % col) == 0)   nrecords++;
             if ((quit_at_record > 0) && (nrecords >= quit_at_record))
                 break;
	}

	dbprintf(1,"exit k %d\n",k);

        if (FPE) fprintf(stderr,"FPE errors have occurred %d \n",FPE);
	if (job_nu) {
		job_done(job_nu,start_date,o_df.source);
	}


}



/* USAGE & HELP */

sho_use ()
{
	fprintf (stderr,
  "Usage: dfc [-N -F -S -B -f -s -d -x -c  -h h_file -i in_file -o out_file] \n");
	fprintf(stderr,"Default output is ascii header & ascii data     	\n");
	fprintf(stderr,"-N	No output header -n	No input header	\n");
	fprintf(stderr,"-B	swap bytes  \n");
	fprintf(stderr,"-f	input data_type float,-d double, -s short, -c char, -x hex \n");
	fprintf(stderr,"-u	input data_type unsigned char  \n");	
	fprintf(stderr,"-F	converted to data_type float, -D double, -S short, -I integer, -X hex \n");
	fprintf(stderr,"-h	header file separate (but points) to data file  \n");
	fprintf(stderr,"-o	output data file  \n");
	fprintf(stderr,"-l  [1]	output in n columns     \n");
	fprintf(stderr,"-p  	pick nth column only cols numbered 0,...,n-1    \n");	
	fprintf(stderr,"-k      seek in n bytes before reading data (overrides header info) \n");		
	fprintf(stderr,"-O      [first]	open file at  nth item     \n");		
	fprintf(stderr,"-Q      [last]	quit transfer at  nth item     \n");			
	fprintf(stderr,"-q      quit at  n records (if -l has set record length)     \n");			
	fprintf(stderr,"-i	input data file  \n");
	fprintf(stderr,"-j 	header file  joins header and data file pointed to by header\n");
	exit (-1);
}


show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}

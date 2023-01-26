/* combf : comb filter two pulse filter */

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"


int debug = 0;
short    Sbuf[1024];

main (argc, argv)
int   argc;
char *argv[];

{
   FILE *fp,  *gs_wrt_sf();
   data_file o_df,i_df;
   channel n_chn[2];   
   channel   i_chn[2];
   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   
   int enp = 2;
   int job_nu = 0;   
   int i,k;
   int   eof, nsamples; 
   int npts = 512;
   long int seek_bytes;
   
   char start_date[40];
   char in_file[120];
   char out_file[120];
   char outfile[120];
   char data_type[20];
   int no_header = 0;
   int offset = 0;
   int i_flag_set = 0;
   int o_flag_set = 0;  
   int vox_file_out = 1;   
   int more_input;  
   float  length;
   float sf;
   int polarity = -1;
   int delay_n;
   float delay_msec = 5;
/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1 ; i < argc; i++) {
     if (debug == HELP)     
     	 break;

      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {
	          	          
	      case 't':
		  enp = atoi (argv[++i]);

		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

	       case 'S':
		   sf= atof (argv[++i]);
		   break;
		   
	       case 'D':
		   delay_msec = atof (argv[++i]);
		   break;		  
		   
	       case 'P':
		   polarity = atoi (argv[++i]);
		   break;		  		  

	      case 'Y':
	      	  debug = atoi (argv[++i]);;
	      	  break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);

		  break;

	       case 'H':
	       case 'h':
	          debug = HELP ;
	          break;	          

	       default: 
		  printf ("%s: option not valid\n", argv[i]);
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

/* header stuff */

   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
dbprintf(1,"not header file\n");
   	exit(-1);
   	}
dbprintf (1,"input data type %s stop %f \n",i_chn[0].dtype,i_df.f[STP]);
   }
   
   nc = 0;
dbprintf (1,"input data type %s\n",i_chn[0].dtype);

      if ( (int) i_df.f[N] > 1) {
dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
     exit(-1);
   }
 
   length = i_df.f[STP] - i_df.f[STR];

   nsamples = (int) i_chn[0].f[N];
   
dbprintf(1,"ns %d sf %f\n",nsamples,i_chn[0].f[SF]); 
   
   if (length <=0.0) {
   	length = nsamples / i_chn[0].f[SF];
   	o_df.f[STP] = length;
   }

   if ( ((int) i_chn[nc].f[SOD]) > 0)

   fposn = (int) i_chn[nc].f[SOD];

   if (strcmp(i_chn[nc].dfile,"@") != 0) {

dbprintf(1,"dfile %s\n",i_chn[nc].dfile);

	strcpy(sd_file,i_chn[nc].dfile);
	fclose(i_df.fp);

   	i_df.fp = fopen( sd_file,"r");
   	fseek (i_df.fp, fposn, 0); 
   }  

   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

   /* Get sample start and stop times */
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;

       delay_n =  ((sf * delay_msec / 2000.0 + 0.5) / 2)   * 2 ;

       seek_bytes = -2 * delay_n * sizeof(short);

		if ( vox_file_out )
	        strcpy(o_df.dtype,"short");
		else
	        strcpy(o_df.dtype,"float");

dbprintf(1,"in %s  out %s\n",i_chn[0].dtype,o_df.dtype);

      	        strcpy(o_df.dfile,"@");

        n_chn[0].f[SF] = sf;
        n_chn[0].f[N] = (float) nsamples;        
        n_chn[0].f[UL] = i_chn[0].f[UL];
        n_chn[0].f[LL] = i_chn[0].f[LL];

	if (vox_file_out)
	strcpy(n_chn[0].dtype,"short");
	else
	strcpy(n_chn[0].dtype,"float");

	/* write out headers */

        if (!o_flag_set) 
	strcpy(out_file,"stdout");

        strcpy(o_df.name,"COMB");        	
 	o_df.f[N] = 1.0;
 	
       	fp = gs_wrt_sf(out_file,&o_df,n_chn);

	dbprintf(1,"done headers \n");    

/* single_channel file ? */

        more_input = 1;

/* must be even */

       while ( more_input) {
dbprintf(1,"loop %d \n",more_input);
	   eof = fread(Sbuf,sizeof(short), npts, i_df.fp);
dbprintf(1,"read %d \n",eof);

	  if ( eof <= 0)  {
	  dbprintf(1,"END_OF_FILE\n"); 
	   more_input = 0;
	  } else
	  more_input++;

	  for (k = delay_n ; k < eof-delay_n ; k++) {
		if (polarity > 0)
	  	Sbuf[k] = Sbuf[k-delay_n] + Sbuf[k+delay_n] ;
		else
	  	Sbuf[k] = Sbuf[k-delay_n] - Sbuf[k+delay_n] ;
	 }
	
	   eof = fwrite(Sbuf,sizeof(short), eof-2*delay_n, fp);
		fseek(fp,seek_bytes,1);

	}


   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    	fclose(fp);

	dbprintf(1,"%s FINISHED \n",argv[0]);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}


sho_use()
{
    fprintf(stderr," comb filter two pulse\n");
    fprintf(stderr,"-D pulse interval (msec) [5]\n");
    fprintf(stderr,"-P polarity (1/-1) [-1]\n");    
    fprintf(stderr,"-o  output file name\n");
    exit(-1);
}


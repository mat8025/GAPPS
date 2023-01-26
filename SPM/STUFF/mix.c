 /********************************************************************************
 *			mix							 *
 
 	This program will take as input  a multichannel file
 	and mix the channels into one 
 
 *********************************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */

#define SMALL   0.00000001



float Fbuf[2048];
float    Pi2 = 6.283185307;
double   pow(),sin (), cos (), log (), log10 ();
channel   i_chn[128];
int debug = 0; 
float    In_buf[8192];
float    Op_buf[8192];
short    Op_sbuf[512];

float Scales[256];
int vox_file_out = 0;

main (argc, argv)
int   argc;
char *argv[];
{
   FILE *gs_wrt_sf(), *sfp;
   data_file o_df,i_df;

   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   

   char in_file[120];
   char out_file[120];
   char scale_file[120];   

   int job_nu = 0;   
   char start_date[40];


   char data_type[20];
   int no_header = 0;
   int offset = 0;
     
   float  length;

   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read =0;
   int new_sample = 0;
   
   int   eof, nsamples, n_frames;
   int i,j,n,k;
   int  loop;
   float factor;
   int op_short = 1;
   double   atof ();


/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;
   int s_flag_set = 0;   

   int  win_length = 256;
   float     sf = 16000.0;
   int start = 0;

   float min = 0.0;
   float max = 1.0;
   float tim;
   char tag[4];
   short iodata;

/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1 ; i <= argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 's': 
  		  s_flag_set = 1;		  
		  strcpy(scale_file,argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]) ;
	          break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       default: 
  fprintf (stderr, "invalid options %s %s\n",argv[0],argv[i]);

	    }
	    break;
      }
   }

if (debug == HELP)
	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

        signal (SIGFPE, fpe_trap);


	
   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (no_header == 1) 
   { 
   /* open input file  & seek (read in offset bytes) */

    if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	dbprintf(1,"not header file\n");
   	exit(-1);
   	}
   }

   dbprintf(1,"UL %f LL %f\n",i_chn[0].f[UL],i_chn[0].f[LL]);   

   nc = (int) i_df.f[N];

   if ( (int) i_df.f[N] > 1) {
        dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
	i_chn[0].f[SKP] = i_df.f[N] -1;
   }
 
   length = i_df.f[STP] - i_df.f[STR];

   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = i_df.f[STP];   

   nsamples = (int) i_chn[0].f[N];

   if (length <=0.0) {
   	length = nsamples / i_chn[0].f[SF];
   	o_df.f[STP] = length;
   }


   if ( ((int) i_chn[0].f[SOD]) > 0)
   fposn = (int) i_chn[0].f[SOD];

   /* else start reading where header ends */
   /* sampling frequency */

   sf = i_chn[0].f[SF];

   /* Get sample start and stop times */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;

       strcpy(o_df.name,"MIX");
       strcpy(o_df.type,"CHANNEL"); 
       o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");


        strcpy(o_df.name,"MIX");
 	strcpy(o_df.type,"CHANNEL"); 
 	o_df.f[N] = 1.0;
        o_df.f[STR] = 0.0;
	o_df.f[STP] = nsamples / sf ;


		gs_o_df_head(out_file,&o_df);
		
	i_chn[0].f[N] = (float) nsamples;


	        if (!vox_file_out)
	        strcpy(o_df.dtype,"float");
		else
	        strcpy(o_df.dtype,"short");
      	        strcpy(o_df.dfile,"@");

      		o_df.f[SF] = sf;
      		o_df.f[FS] = 1.0 / sf;
      		o_df.f[FL] = 1.0 / sf;
		o_df.f[SOD] = 0.0;
      		o_df.f[N] = 1.0 * nsamples;
      		o_df.f[LL] = i_chn[0].f[LL]; /* 12 bit da range default */
      		o_df.f[UL]= i_chn[0].f[UL];

	/* write out headers */
/* all channels are same except for tag so write first only */


		o_df.f[CN] = (float) (nc - 1);
        	sprintf(tag,"%f",o_df.f[CN]);
		strcpy(o_df.name,tag);

		gs_w_chn_head(&o_df);

/*   write each channel head */
	
	posn = gs_pad_header(o_df.fp);


/* set up mix scale  factors */

	for ( j = 0 ; j < nc ; j++) {
	Scales[j] = 1.0 / (1.0 * nc );
        }

   if ( s_flag_set ) {
/* open file */
    sfp = fopen(scale_file,"r");
    if ( sfp == NULL ) {
    	dbprintf(1,"scale file error");
    	exit (-1);
   }
   eof = 0;

   while ( eof != 1 ) {
    /* read channel number  & scale */
     eof = fscanf(sfp,"%d %f",&i,&factor);
     if ( eof != 1 )
     Scales[i] = factor;
     eof = feof( sfp);
     dbprintf(1,"scales %d %f %d\n",i,factor,eof);
    }

   }

/* INITIALISE FOR FIRST READ */
        
        loop = 0;
	j = 0;
	n = 1;

/* MAIN LOOP */

   while ( 1 ) {

/* READ INPUT DATA */

          eof = read_m_chn(&i_chn[0],&In_buf[j],n);

          last_sample_read += n;

	  if ( eof == 0)  {
	  dbprintf(1,"END_OF_FILE\n"); 
	 	break;
	  }

	if (op_short ) {
		
        for (j = 0; j < n ; j++) {
	Op_buf[j] = 0;
	for (k = 0; k < nc ; k++ ) {	
	Op_buf[j] += In_buf[(j*nc)+ k] * Scales[k]  ;
	        }
	}

	        fwrite(Op_buf,sizeof(float), n, o_df.fp);
        }


	dbprintf(1,"wrt_op %d %d\n",loop,new_sample);
/* CHECK FOR END OF DATA */	      
              loop++;

/* INPUT BUFFER & POSITION FOR NEXT READ */

	 new_sample += n;

	 m_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);

	}	


   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


}


sho_use ()
{

fprintf (stderr, "mix -i multi_channel file -o single_channel file  -s scales\n");

fprintf (stderr, "scales file containing scale factors\n");
fprintf (stderr, " for each channel e.g.\n");
      fprintf (stderr, "0 0.5 \n");
      fprintf (stderr, "1 0.3 \n");
      fprintf (stderr, "2 0.7 \n");      
      fprintf (stderr, "3 0.0 \n");            
fprintf (stderr, " by default mix using a factor of 1/num_chans \n");
      exit (-1);
}


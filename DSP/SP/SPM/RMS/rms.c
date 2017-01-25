
 /********************************************************************************
 *			rms							 *
 *	Author: 	Mark Terry 1987						 *
 
 	This program will take as input either a multichannel or single 
 	file and compute the rms value for a specified frame
 	at a specified shift
 

 *										 *
 *	Modified for pipelining & ascii headers by M.T. Dec 88			 *
 *********************************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */

#define SMALL   0.00000001

#define B_size  8192

float Rms[B_size];

float Fbuf[B_size];

float    Pi2 = 6.283185307;
double   pow(),sin (), cos (), log (), log10 ();
channel   i_chn[128];
int debug = 0; 
float    In_buf[B_size];

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;

   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   

   char in_file[120];
   char out_file[120];

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

   double   atof ();


/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;
   int frame_shift_set = 0;
   int frame_length_set = 0;   
   int  win_length = 256;
   float     sf = 16000.0;

   int start = 0;

   float min = 0.0;
   float max = 1.0;
   float tim;
   float frame_start = 0.0;
   float frame_shift = .005;
   float frame_length = .005;
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



   for (i = 1 ; i < argc; i++) {



     if (debug == HELP)     
     	 break;

      switch (*argv[i]) {

	 case '-': 
	    switch (*++(argv[i])) {

	       case 's': 
		  frame_shift_set = 1;
		  frame_shift = atof (argv[++i]);
		  time_shift = 1;
		  frame_shift *= .001;
		  break;

	       case 'l': 
		  frame_length_set = 1;		  
		  frame_length = atof (argv[++i]);
		  frame_length *= .001;
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


	       case 'H':
	       case 'h':
	          debug = HELP ;
	          break;	          

	       default: 
		  printf ("%s: option not valid\n", argv[i]);
		  debug = HELP;
		  break;

	    }
      }
   }




	fflush(stdout);

if (debug == HELP)
	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


        signal (SIGFPE, fpe_trap);

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
   }
   

   nc = (int) i_df.f[N];


   if ( (int) i_df.f[N] > 1) {
      if (debug > 1)
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

      win_length = sf * frame_length;
      
      n_frames = (int) ( (length - frame_length) / frame_shift);

   /* Get sample start and stop times */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;

 strcpy(o_df.name,"RMS");
 strcpy(o_df.type,"FRAME"); 
 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);
   
   o_df.f[VL] = (float)    nc;
   o_df.f[FS] = frame_shift;
   o_df.f[FL] = frame_length;
   o_df.f[SF] = sf;
   o_df.f[MX] = (float)( nc -1);
   strcpy (o_df.x_d, "channel_nu");
   strcpy (o_df.y_d, "rms_(dB)");
   o_df.f[LL] = -20.0;
   o_df.f[UL] = 70.0;
   o_df.f[N]= (float) n_frames;
   gs_w_frm_head(&o_df);   
   posn = gs_pad_header(o_df.fp);

/*    find rms for each channel */

	if (debug)
	dbprintf(1,"rms analysis wl %d \n%",win_length);

/* INITIALISE FOR FIRST READ */
        
        loop = 0;
	j = 0;
	n = win_length;

/* MAIN LOOP */


   while ( 1 ) {

/* READ INPUT DATA */

          eof = read_m_chn(&i_chn[0],&In_buf[j],n);

          last_sample_read += n;

	  if ( eof == 0)  {
	  dbprintf(1,"END_OF_DATA loop %d %d\n",loop,n_frames); 
	 	break;
	  }


	/* zero rms array */

	for (k =0 ; k < nc ; k++)
	Rms[k] = 0.0;


		for (k = 0; k < nc ; k++ ) {
	        for (j = 0; j < win_length; j++) {
		Rms[k] += In_buf[(j*nc)+ k] * In_buf[(j*nc)+ k] ;
	/*	compute square & sum */
	        }

	}

	/* compute mean and get root for each channel */

	for (k=0 ; k < nc ; k++) {
	Rms[k] = Rms[k] / (float) win_length;

	if (Rms[k] > SMALL) {
	Rms[k] = sqrt (Rms[k]);
	Rms[k] = 20.0 * log10(Rms[k]);
	}
	else Rms[k] = 0.0;
	}

/*	update max and min */


/*
	for (k=0 ;k < nc ; k++) {
	if (Rms[k] < min ) min = Rms[k];
	if (Rms[k] > max ) max = Rms[k];
	}
*/


/* WRITE DATA  either to stdout or file */


       gs_write_frame (&o_df, Rms);

/* CHECK FOR END OF DATA */	      
              loop++;
/*
	      if (loop > n_frames) 
	      	      break;
*/

/* INPUT BUFFER & POSITION FOR NEXT READ */

	 new_sample = (int) (loop * frame_shift * sf);

  m_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);

	}	


   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   dbprintf(1,"rms analysis finished %d\n%",loop);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}


sho_use ()
{
      fprintf (stderr, "rms  -l -s  -i [vox|track] -o sdtfile\n");
      fprintf (stderr, " -l msec frame length [5 msecs]\n");
      fprintf (stderr, " -s msec frame shift  [5 msecs]\n");

      exit (-1);
}


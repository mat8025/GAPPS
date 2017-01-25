
 /********************************************************************************
 *			FOP							 *

 
 	This program will take as input a spectrum file
	and normalise each frame
 *										 *
 *	Modified for pipelining & ascii headers by M.T. Dec 88			 *
 *********************************************************************************/


#include <gasp-conf.h>

#include  <stdio.h>
#include  <signal.h>
#include "df.h"
#include "sp.h"
#include  "trap.h"



int debug = 0;
float In_buf[8192];
float L_buf[8192];

main (argc, argv)
int   argc;
char *argv[];
{

   int job_nu = 0;   
   char start_date[40];
   
   data_file o_df,i_df;
   char sd_file[80];      

   int fposn =0;
   int posn,nc;
   int pid ,fsize;   
   char in_file[120];
   char out_file[120];


   char data_type[20];
   int no_header = 0;
   int offset = 0;
   float sf = 16000.0;     
   float  length;

   int   mode = 1;
   int   time_shift = 0;
   int nloops;
   
   int   eof, nsamples;
   int n_frames =0;
   int i,j,n,k;
   int  loop;
   int norm = 0;
   int warp = 0;
   int do_log = 0;
   int do_mul = 0;
   int do_adapt = 0;   
   float m_fac;
   
   double   atof ();

   int nframes;



/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;


/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {

	       case 'N':
	          norm = 1;
	          break;

	       case 'S':
	          warp = 1;
	          break;
	       case 'L':
	       	  do_log =1;
	       	  break;
 	       case 'M':
	       	  do_mul =1;
		  m_fac = atof (argv[++i]);		  
	       	  break;
 	       case 'A':
	       	  do_adapt =1;
		  m_fac = atof (argv[++i]);		  
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;



	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]) ;
	          break;

	       default: 
		  printf ("%s: illegal option\n", argv[0]);
		  break;
	    }
	    break;
	 default: 
	    printf ("%s: illegal option\n", argv[0]);
	    break;
      }
   }


if (debug == HELP)
	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


   
   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (! gs_open_frame_file(in_file,&i_df))
   	exit(-1);

   	fposn = ftell(i_df.fp);


   	dbprintf(1,"end head at %d\n",fposn);

   
 
   length = i_df.f[STP] - i_df.f[STR];


   nframes = (int) i_df.f[N];



   	dbprintf(1,"duration %f\n",length);


   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_df.f[SF];
 
/* copy across some data from input to output headers */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


 strcpy(o_df.name,"FOP");
 strcpy(o_df.type,"FRAME"); 

 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);
   
   o_df.f[VL] = i_df.f[VL];
   o_df.f[FS] = i_df.f[FS];
   o_df.f[FL] = i_df.f[FL];
   o_df.f[SF] = sf;
   o_df.f[MX] =  i_df.f[MX];
   o_df.f[MN] =  i_df.f[MN];   
   strcpy (o_df.x_d, "channel_nu");
   strcpy (o_df.y_d, i_df.y_d);
   o_df.f[LL] = 0.0;
   o_df.f[UL] = 1.0;
   o_df.f[N]= i_df.f[N];
   gs_w_frm_head(&o_df);   

   posn = gs_pad_header(o_df.fp);

/* sampling frequency */


   dbprintf (1,"FOP IN PROGRESS...\n");

	if (do_adapt) 
	for ( i =0 ; i < (int) i_df.f[VL] ; i++ )
	L_buf[i] = 0.0;

   while (1) {

/* read the spectrum */

	eof = gs_read_frame(&i_df,In_buf);


	  if ( eof == 0)  {

	  dbprintf(1,"END_OF_FILE\n"); 
	 	break;
	  }


	n = (int) i_df.f[VL];

	
	 n_frames++;

/* transform */

	if (do_log)
	f_log(In_buf, (int) i_df.f[VL]);

	if (do_mul)
	f_mul(m_fac,(int) i_df.f[VL]);

	if (do_adapt)
	f_adapt(m_fac,(int) i_df.f[VL]);
	
	if (norm)
	f_norm(In_buf, (int) i_df.f[VL]);



/* write out the results */
       gs_write_frame (&o_df, In_buf);




   }

/************** end of main loop *****************/

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


   dbprintf (1,"FOP COMPLETED: %6d loops\n", nloops);

}

f_norm(buf,n)
float buf[];
{
float max,min;
int i;
	max = buf[0];
	min = buf[0];
	for (i = 0; i < n ; i++ ) {
	if( buf[i] > max ) max = buf[i];
	if( buf[i] < min ) min = buf[i];
        }
	max = max - min;

	for (i = 0; i < n ; i++ ) 
	buf [i] -= min;
	if (max != 0.0)
	for (i = 0; i < n ; i++ ) 
	buf [i] /= max;	
}
 
f_warp(buf,n)
float buf[];
{
float ave;
int i;
	ave = 0.0;
	
	for (i = 0; i < n ; i++ ) {
	ave += buf[i];
        }
	ave /= (float) n;

/* add or sbutract ave */

	for (i = 0; i < n ; i++ ) {
	if (buf[i] > ave) buf[i] -= ave;
	if (buf[i] < ave) buf[i] += ave;	
        }
}

 
f_log(buf,n)
float buf[];
{
float ave;
int i;
	
	for (i = 0; i < n ; i++ ) 
	if (In_buf[i] > 0.0)
	In_buf[i] = log10(In_buf[i]);
	
}

 
f_mul(f,n)
float f;
{
float ave;
int i;
	for (i = 0; i < n ; i++ ) 
	In_buf[i] = f  * In_buf[i];
}
 
f_adapt(f,n)
float f;
{
float y;
int i;
	for (i = 0; i < n ; i++ ) {
	y = In_buf[i] + f * ( In_buf[i] - L_buf[i]) ;
	L_buf[i] = In_buf[i];
        In_buf[i] = y;	
        }
}
 


sho_use()
{
      printf ("Usage: f_norm [-N] -i infil -o outfil\n");
      printf ("-N normalise each frame between 0.0 and 1.0\n");
      printf ("-M multiple by factor\n");
      exit (-1);
}


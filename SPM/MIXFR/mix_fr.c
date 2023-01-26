 /********************************************************************************
 *			MIX							 *

 
 	This program will take as input a data files
	and make up a new frame file from subsets of each data file
 *										 *
 *	Modified for pipelining & ascii headers by M.T. Dec 88			 *
 *********************************************************************************/


#include <gasp-conf.h>

#include  <stdio.h>
#include  <signal.h>

#include "df.h"
#include "sp.h"
#include "trap.h"


int debug = 0;
float In_buf[8192];
float Mix_buf[8192];

main (argc, argv)
int   argc;
char *argv[];
{
   int job_nu = 0;   
   char start_date[40];
   
   data_file o_df,i_df,m_df;
   char sd_file[80];      
   static  channel o_chn;   
   int fposn =0;
   int posn,nc;
   int pid ,fsize;   
   char mix_file[120];
   char in_file[120];
   char out_file[120];

   char data_type[20];
   int no_header = 0;
   int offset = 0;
   float sf = 16000.0;     
   float  length;
   channel  chn_x;
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
   double   atof ();
   int s1_s,s2_s,s1_n,s2_n;
   int nframes;
   char  buf[32];


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


	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'm':
	       	  strcpy(mix_file,argv[++i]);
		  break;

	       
	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

	       case 's':
	          s1_s = atoi( argv[++i]) ;
	          break;


	       case 'S':
	          s2_s = atoi( argv[++i]) ;
	          break;

	       case 'N':
	          s2_n = atoi( argv[++i]) ;
	          break;

	       case 'n':
	          s1_n = atoi( argv[++i]) ;
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


   
   posn = gs_chk_data_file_type(mix_file,&chn_x,&m_df);
   
   if (strcmp(chn_x.type,"CHANNEL") != 0)  {
     if (! gs_open_frame_file(mix_file,&m_df))
   	exit(-1);
   }
   else {
   gs_read_channel_head(mix_file,0,&m_df);
   gs_open_chn(&m_df);
   m_df.f[VL] = chn_x.f[N];
   dbprintf(1,"CHANNEL m_df VL %f %f\n",chn_x.f[N],m_df.f[VL]);
   }


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


 strcpy(o_df.name,"MIX");
 strcpy(o_df.type,"FRAME"); 

 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);
   
   o_df.f[VL] = (float) (s1_n + s2_n );
   o_df.f[FS] = i_df.f[FS];
   o_df.f[FL] = i_df.f[FL];
   o_df.f[SF] = sf;
   o_df.f[MX] =  i_df.f[MX];
   o_df.f[MN] =  i_df.f[MN];   
   strcpy (o_df.x_d, "mixed frame");
   strcpy (o_df.y_d, i_df.y_d);
   o_df.f[LL] = 0.0;
   o_df.f[UL] = 1.0;
   o_df.f[N]= i_df.f[N];
   gs_w_frm_head(&o_df);   

   posn = gs_pad_header(o_df.fp);

/* sampling frequency */



   dbprintf (1,"MIX IN PROGRESS...\n");

   while (1) {

/* read the spectrum */

	eof = gs_read_frame(&i_df,In_buf);

	for ( i =0 ; i < s1_n ; i++) {
	Mix_buf[i] = In_buf[s1_s +i];
	if (debug)
	printf("%f\n",Mix_buf[i]);
        }
	  if ( eof == 0)  {
	  if (debug > 1)
	  printf("END_OF_FILE\n"); 
	 	break;
	  }

	eof = gs_read_frame(&m_df,In_buf);

	  if ( eof == 0)  {
	  if (debug > 1)
	  printf("END_OF_FILE\n"); 
	 	break;
	  }

	for ( i =0 ; i < s2_n ; i++) {
	Mix_buf[s1_n + i] = In_buf[s2_s +i];
	if (debug)
	printf("%f\n",Mix_buf[s1_n+i]);
        }
	 n_frames++;

/* transform */

       gs_write_frame (&o_df, Mix_buf);

/* write out the results */


   }

/************** end of main loop *****************/

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);


   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}
 


sho_use()
{
      printf ("Usage:mix  -i infil -o outfil\n");
      exit (-1);
}


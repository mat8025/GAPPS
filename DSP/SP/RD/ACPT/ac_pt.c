 /********************************************************************************
 *			AC_PT							 *
 
 	This program will take as input:
 	a auto_correlatio file 
        and locate the the predominant peak
 *      Mark Terry 1992
 *										 *
 *	Modified for pipelining & ascii headers by M.T. Dec 88			 *
 *********************************************************************************/

#include <gasp-conf.h>

#include  <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

int debug = 0;
float In_buf[8192];
float Spec[512];

float Results[MAXWIN];
float Mave[40][5];
main (argc, argv)
int   argc;
char *argv[];
{
   data_file o_df,i_df;
   char sd_file[80];      
   static  channel o_chn;   
   int fposn,posn,nc;
   int pid ,fsize;   
   char in_file[120];
   char out_file[120];
   int m_order;
   int start_at =0;
   int finish_at =0;
   int in_region;
   char data_type[20];
   int no_header = 0;
   int offset = 0;
   float sf = 16000.0;     
   int ch_num = 0;
   int start_isp , step_isp, finish_isp;
   int sort_it;
         
   float g_factor;
   float  length;
   float old_pp;
   float expon = 0.6;
   int gain = 0;

   int n_spts;   
   int   mode = 1;
   int   time_shift = 0;
   int nloops;

   int   eof, nsamples, n_frames;
   int i,j,n,k;
   int  loop;
   int norm = 0;
   int warp = 0;
   int eh = 0;

   int pka,pkb;   
   int m_ave = 0;
   int get_n_peaks;
   int n_peaks = 3;
   int n_vals =0;
   int pk,isp;

   float pk_pos,pk_amp,pk_bw,delta,floor;
   float tmp;
   int smooth = 0;
   int add_floor =0;
   int aclag_hz = 0;
   int job_nu = 0;   
   int  reverse_search = 0;
   char start_date[40];
   
   double   atof ();

   int nframes;
   char  buf[32];
   float ex  = 1.0 / 3.0 ;
   float dt =1.0;
   
/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;
   int peaks_dips_only = 0;

/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1; i < argc; i++) {
     if (debug == HELP)     
     	 break;

      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {
	       case 'p': 
		  n_peaks = atoi (argv[++i]);
		  break;
	       case 'v':
		  n_vals = atoi (argv[++i]);
	       	  break;
	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'A': 
		  m_ave = 1;
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

	       case 'F':
		  add_floor = 1;
	          floor = atof( argv[++i]) ;
	          break;	          

	       case 'P':
		  peaks_dips_only = 1;
	          break;	          	          

	       case 'R':
		  reverse_search = 1;
	          break;	          	          
	       case 'L':
		  aclag_hz = 1;
	          break;	          	          
	       case 'S':
		  smooth = 1;
	          break;	 
       	       case 's':
	          start_at = atoi( argv[++i]) ;
	          break;	          
       	       case 'f':
	          finish_at = atoi( argv[++i]) ;
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
	 default: 
	    printf ("%s: option not valid\n", argv[0]);
	    debug = HELP;
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

   if (! gs_open_frame_file(in_file,&i_df))
   	exit(-1);

   /* NB necessary to position file pointer at end of header */
   
   eh = ftell(i_df.fp);
 
   length = i_df.f[STP] - i_df.f[STR];

   nframes = (int) i_df.f[N];

   dbprintf(1,"duration %f\n",length);

   sf = 1.0 * (int) i_df.f[SF];
   
   n_spts = i_df.f[VL];

/* copy across some data from input to output headers */

   delta = i_df.f[MX] / (float) (n_spts-1);
   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;
   strcpy(o_df.name,"PK_VAL");

  strcpy(o_df.type,"CHANNEL"); 
  strcpy(o_df.x_d,"Time"); 
if (peaks_dips_only)
  o_df.f[N] = n_peaks + n_vals ;
else
  o_df.f[N] = 3.0 * n_peaks + 3.0 * n_vals ;
  if(aclag_hz) {
  	dt = 1.0/ sf;
}

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);

/* write channel headers */

   o_chn.fp = o_df.fp;

   o_chn.f[SF] = sf;   
   o_chn.f[FS] = i_df.f[FS];   
   strcpy(o_chn.dtype,"float");
   ch_num = 0;

   for (i = 0 ; i < n_peaks ; i++, ch_num++) {
   strcpy(o_chn.name,"FREQ");
   o_chn.f[CN] = ch_num ;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = sf/2.0;   
   strcpy(o_chn.dfile,"@");
   gs_w_chn_head(&o_chn);
   }


   strcpy(o_chn.name,"N_PKS");
   o_chn.f[CN] = ch_num++;
   o_chn.f[LL] = 0;
   o_chn.f[UL] = 100;   
   gs_w_chn_head(&o_chn);      
   
   strcpy(o_chn.name,"LOG_ENERGY");
   o_chn.f[CN] = ch_num++;
   o_chn.f[LL] = 0;
   o_chn.f[UL] = 120;   
   gs_w_chn_head(&o_chn);      


   posn = gs_pad_header(o_df.fp);

/* sampling frequency */

   eh = ftell(i_df.fp);

   dbprintf (1,"PK_VAL IN PROGRESS... n_peaks %d  n_vals %d to \n",n_peaks,n_vals);

   nloops = 0;

   if (reverse_search) {

   start_isp = 	n_spts -3;
   finish_isp = 2;

   step_isp = -1;
   
   }
   else {
	   start_isp = 	2;
	   finish_isp = n_spts -3;
   
   step_isp = 1;   	
   }

/* input  */
   while (1) {

	   eof = gs_read_frame(&i_df,In_buf);

	  if ( eof == 0)  {
	  dbprintf(2,"END_OF_FILE\n"); 
	 	break;
	  }

/* parabolic interpolation */
		pk = 0;
		mode = -2; /* peaks no interpolation */
		get_n_peaks = 0;

	        if (floor)
	        for (isp = 0; isp < n_spts ; isp++) 
	        	In_buf[isp] += floor;	
	        	
	        if (smooth)
	        for (isp = 0; isp < n_spts ; isp++) 
        	In_buf[isp] = (In_buf[isp] + In_buf[isp+1])/2.0;	


for (k= 0; k < (3* n_peaks) ; k++) {
	    Results[k] = 0.0;
}


for (k= 0; k < (n_peaks + n_vals) ; k++) {
	    Results[k] = start_at * delta;
}


for (isp = start_isp ; isp != finish_isp ; isp = isp + step_isp ) {

if ( (In_buf[isp-1] < In_buf[isp]) 
	&& (In_buf[isp] > In_buf[isp+1])) {

	
	parabolic_ip (In_buf[isp-1],In_buf[isp],In_buf[isp+1],
	      isp,delta,mode, &pk_pos, &pk_amp, &pk_bw);

	in_region = 0;
	if (reverse_search) {
	if (isp <= start_at && isp >= finish_at)
	in_region = 1;
 	}
	else {
	if (isp >= start_at && isp <= finish_at)
	in_region = 1;		
	}

       if (get_n_peaks < n_peaks && in_region) {

	Results[pk] = pk_pos;
	Results[pk+n_peaks] = In_buf[isp];	        
	Results[pk+2*n_peaks] = pk_bw;	        
	pk++;

dbprintf(1," %f ",pk_pos);
		} 

	 get_n_peaks++;

/* store num of peaks */

	        }
	   }


/* store results as parallel tracks in output file */
/* sort in amp order  */

	sort_it = 1;
		
	while(sort_it) {

		sort_it = 0;

	  for (k= 0; k < n_peaks ; k++) {
	  if (Results[k+n_peaks] < Results[k+1+n_peaks]) {
	  tmp = Results[k];
	  Results[k] = Results[k+1];
	  Results[k+1] = tmp;
	  tmp = Results[k+n_peaks];
	  Results[k+n_peaks] = Results[k+1+n_peaks];
	  Results[k+1+n_peaks] = tmp;	  
	  sort_it = 1;
	  }
	 
	  }

        }

if (aclag_hz)  {

  for (k= 0; k < n_peaks ; k++) {
  Results[k] = (float) ( (int) (1.0/ (Results[k] * dt) +0.5)) ;
  dbprintf(1," %f ",Results[k]);
  }
            dbprintf(1," \n");
}
	Results[n_peaks] = get_n_peaks;


fwrite (Results, sizeof(float), n_peaks + 1, o_df.fp);

	old_pp = Results[0];
	      
        /* write out the results */
        dbprintf(1,"loop %d\n",nloops);
    nloops++;
   }

/************** end of main loop *****************/

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

dbprintf (1,"PK_VAL COMPLETED: %6d loops\n", nloops);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}

sho_use()
{
      printf ("Usage: pk_val -p [int]   -v [int]  -i infil -o outfil\n");
      printf ("p number of peaks to find \n");
      printf ("v number of valleys to find \n");
      printf ("F float add floor \n");      
      printf ("L lag-to-hz \n");            
      exit (-1);
}

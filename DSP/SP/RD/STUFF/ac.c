 /********************************************************************************
 *	MULTI_CHANNEL	ac							 *
 *	auto-correlation								 *
 *	serial version						 *
 *	Mark Terry
 *********************************************************************************/

/* Modification for compatibility:-
I have put an extra condition in the scaling application.
The scaling flag must be set to greater than 0 for scaling to
be applied. Scaling is only applied to forward transforms
in any case (see gs_fft for details) */

#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

#define FORWARD 1
#define BACKWARD -1
#define NO_SCALING 0

int debug = 0; 

float    In_buf[16*2048];
float    Window[2048];
float    Real[2048], Imag[2048];

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;
   channel   i_chn[2];
   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   
   int chan;
   int do_all_chns = 0;   
   int job_nu = 0;   
   int n_lag;
   int norm = 0;
   int smooth = 0;
   char start_date[40];

   char in_file[120];
   char out_file[120];

   int start_channel = 0;
   int num_chans = 1;
     
   float  length,h_len;
   double power;
   
   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read = -1;
   int new_sample = 0;
   
   int   eof, nsamples, n_frames;
   int i,j,n,k;
   int  loop;

   double   atof ();


/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;

   float     sf = 16000.0;

   int ebw_set = 0;
   int fft_size_set = 0;
   int frame_shift_set = 0;
   int frame_length_set = 0;   

      int win_shift_set = 0;
   
/* DEFAULT VALUES */

   int   fft_size = 256;
   int  win_shift = 128;
   int  win_length = 256;
 
   float    pre = 0.0;
   float    small = 0.0000001;
   float    scale_factor = 1.0;
   float    ebw;
   float    frame_length = 0.020;
   float    frame_shift = 0.010;   
   int   dBflag = 1;

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

	    switch (*++(argv[i])) {

	       case 'c': 
		  
		  start_channel =  atoi (argv[++i]);	  
		  break;

	       case 'n': 
		  fft_size_set = 1;
		  fft_size = atoi (argv[++i]);
		  break;

	       case 'w': 
		  win_length = atoi (argv[++i]);
		  break;
	       case 'N': 
		  norm = 1;
		  break;		  
	       case 'S':
		  smooth = 1;
	          break;	  
	       case 'O': 
		  win_shift_set = 1;
		  win_shift = atoi (argv[++i]);
		  break;

	       case 'p': 
		  pre = atof (argv[++i]);
		  pre = pre *.01;
		  break;
	       case 'M': 
		  dBflag = 0;
		  break;

	       case 'f': 
		  sf = atof (argv[++i]);
		  break;

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


	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]) ;
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


if (debug == HELP)
	sho_use();

    if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

        signal (SIGFPE, fpe_trap);
 
  
   if (!i_flag_set)
             strcpy(in_file,"stdin");

        dbprintf(1,"infile %s\n",in_file);

      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	dbprintf(1,"not  header file\n");
   	exit(-1);
   	}
   
   nc = 0;

   num_chans = (int) i_df.f[N] ;
   if ( (int) i_df.f[N] > 1) {

      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
	i_chn[0].f[SKP] = i_df.f[N] -1;
   }

 
   length = i_df.f[STP] - i_df.f[STR];

   gs_init_df(&o_df);

   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = i_df.f[STP];   

/* check poss that header points to a datafile */

   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];

   nsamples = (int) i_chn[0].f[N];
   dbprintf(1,"n_samples %d\n",nsamples);


   h_len = nsamples / i_chn[0].f[SF];

   if ( h_len < length ) {
   	o_df.f[STP] = h_len;
	o_df.f[STR] = 0.0;   	
     }
  
   if (length <=0.0) {
        length = h_len;
   	o_df.f[STP] = length;
   }


   /* else start reading where header ends */
/* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

/* Get sample start and stop times */

/*  WORK OUT PARAMETER VALUES  according to precedence & Header information */

   if (frame_length_set)
   	win_length = (int) (sf * frame_length +0.5) ;

   if (!fft_size_set)
       fft_size = compute_fft_size ( win_length) ;
             else
       win_length = fft_size/2 ; 
      
   if ( fft_size < win_length)
       fft_size = compute_fft_size ( win_length ) ;

   if (fft_size < 2 || fft_size > 2048) {
      dbprintf (1,"%s: fft size out of range\n", argv[0]);
      exit (-1);
   }

   if( !win_shift_set)
   win_shift = win_length /2;

   if (win_shift <= 0) {
      dbprintf (1,"window shift not valid %d must be > 0\n", win_shift);
      exit (-1);
   }

   if ( !frame_shift_set) {
      frame_shift = (float) win_shift / sf;
      frame_length = win_length / (1.0 *sf) ;
   }
   else {
      win_shift = (int) (frame_shift * sf + 0.5);
      n_frames = (int) (length / frame_shift +0.5);
   }


      n_frames = (nsamples-win_length) / win_shift  + 1 ;

      if (((n_frames-1) * win_shift) > (nsamples-win_length))
	 n_frames--;

/* SHOW PARAMETER VALUES */

   n_lag = fft_size/2;
   win_length = n_lag;

 strcpy(o_df.name,"AC");
 strcpy(o_df.type,"FRAME"); 

 dbprintf (1,"num chans%d \n", num_chans);
 if (num_chans > 1.0 & start_channel == 0) {
 	do_all_chns = 1;
        o_df.f[N] = num_chans; 	
 }  else

 o_df.f[N] = 1.0;


   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);

   o_df.f[VL] = n_lag;
   o_df.f[FS] = frame_shift;
   o_df.f[FL] = frame_length;
   o_df.f[SF] = sf;
   o_df.f[MX] = n_lag * 1.0;
   strcpy (o_df.x_d, "lag");
   strcpy (o_df.y_d, "correlation");
   o_df.f[LL] = -1.0;
   o_df.f[UL] = 1.0;
   o_df.f[N]= (float) n_frames;

   gs_w_frm_head(&o_df);   
   posn = gs_pad_header(o_df.fp);


/* INITIALISE FOR FIRST READ */
        
        loop = 0;
	j = 0;
	n = win_length;


/* COMPUTE SCALE FACTOR  & SMOOTHING WINDOW*/

        scale_factor = 1.0 / (1.0 * fft_size);
  
        gs_window("Hanning",win_length,Window);

dbprintf(1,"wl %d n_lag %d \n",win_length,n_lag);
/* MAIN LOOP */

   dbprintf (1,"SPECTROGRAM -- COMPUTING\n");
/* if input number of samples set break when that many have been used */

   while ( 1 ) {

/* READ INPUT DATA */

	  if ( num_chans == 1)
          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
          else
          eof = read_m_chn(&i_chn[0],&In_buf[j],n);

          last_sample_read += n;

  	dbprintf(1,"lsr %d ns %d\n",last_sample_read,nsamples); 
	  	
	  if ( nsamples > 0 && last_sample_read > nsamples) {
	  	dbprintf(1,"lsr %d ns %d\n",last_sample_read,nsamples); 
		break;
	  }


/* CHECK FOR END OF DATA */	      	  

	  if ( eof == 0)  {
	  dbprintf(1,"END_OF_FILE\n"); 
          break;
	  }

   for ( chan = 0 ; chan < num_chans ; chan ++ ) {
/* CLEAR  FFT ARRAYS */
/* pad zeros */
      for (i = 0; i < fft_size; i++) {
	 Imag[i] = 0.0;
	 Real[i] = 0.0;
         }

/* LOAD REAL INPUT */
dbprintf(1,"load input  pad %d\n",fft_size -win_length);

      for (i = 0; i < win_length; i++) 
	Real[i] = In_buf[chan +(i*num_chans)];

/* PREEMPHASIS   */

      if (pre != 0.0)
	 for (j = 0; j < win_length -1; j++)
	    Real[j] = Real[j] -  (Real[j+1] * pre);


/* APPLY SMOOTHING WINDOW TO INPUT */

	for (j = 0; j < win_length; j++)
		Real[j] *= Window[j];


/* FFT */
dbprintf(1,"apply fft \n");

      gs_fft(Real, Imag, fft_size, FORWARD);
      mode = 0;

/* MAGNITUDE SPECTRUM */

      for (i = 0; i < fft_size ; i++) {
         Real[i] = ( Real[i] * Real[i] + Imag[i] * Imag[i])
         		 * scale_factor;
	}


/* NOW INVERT */
      
      for (i = 0; i < fft_size; i++) {
	 Imag[i] = 0.0;
      }

      power = 0.0;

      if (norm)
      for (i = 0; i < fft_size/2 ; i++) {
      	power += Real[i];
      }
	power *= 2.0;

      gs_fft(Real, Imag, fft_size, BACKWARD);

/*  divide by linear function  to obtain unbiased results */


      for (i = 0; i < n_lag; i++) {
	Real[i] = Real[i] / ( (float) (n_lag -i) / (float) n_lag);
      }


      if (norm)
      for (i = 0; i < n_lag; i++) 
	Real[i] = Real[i] / power;

      if (smooth)
      for (i = 0; i < n_lag-1 ; i++) 
	Real[i] = (Real[i] +Real[i+1])/ 2.0;


/* WRITE DATA  either to stdout or file */
dbprintf(1,"write data \n");



       gs_write_frame (&o_df, Real);

}


/* INPUT BUFFER & POSITION FOR NEXT READ */
      loop++;
      
      if (time_shift)       
	 new_sample = (int) (loop * frame_shift * sf);
         else
      	 new_sample += win_shift;

         if (num_chans == 1)
       	 gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);
	 else
	 m_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);


   }




/************** end of main loop *****************/


/*  CLOSE FILES    */

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

   dbprintf(1,"ac finished %d frames \n",loop);

}


/* USAGE & HELP */

sho_use () 
{
      fprintf (stderr,
    "Usage: ac [-b -n -l -s -w -O -f -p -D  -i in_file -o out_file] \n");

      fprintf(stderr,"-n	fft_size [256]	max 2048  \n");     
      fprintf(stderr,"-l	frame_length    msecs  \n");        
      fprintf(stderr,"-s	frame_shift	    msecs  \n");    
      fprintf(stderr,"-w	win_length	sample_points  \n");
      fprintf(stderr,"-O	win_shift	sample_points  \n");
      fprintf(stderr,"-f	sampling frequency 	Hz  \n");
      fprintf(stderr,"-N	normalize 	  \n");            
      fprintf(stderr,"N.B. Header information (if present) will overide flag settings\n"); 
      exit (-1);
}



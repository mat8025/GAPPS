
 /********************************************************************************
 *			sgt							 *
 *	spectrograph								 *
 *	fast table fft      serial version						 *
 *	Mark Terry Sep 86							 *
 *	Modified for pipelining  Dec 88						 *
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

#define FORWARD 1
#define BACKWARD -1
#define NO_SCALING 0

int debug = 0; 
float    In_buf[1024];
float    Window[1024];
float    S[1024][9], C[1024][9];
float    Real[1024], Imag[1024];

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;
   channel   i_chn[2];
   char sd_file[80];      

   int job_nu = 0;   
   char start_date[40];


   int fposn,posn,nc;
   int pid ,fsize;   

   char in_file[120];
   char out_file[120];

   char data_type[20];
   int no_header = 0;
   int offset = 0;

     
   float  length;

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
   float    dbcmp = 0.33;	/* scale factor for 16 grey level */
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
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 'n': 
		  fft_size_set = 1;
		  fft_size = atoi (argv[++i]);
		  break;
	       case 'w': 
		  win_length = atoi (argv[++i]);
		  break;

	       case 'O': 
		  win_shift_set = 1;
		  win_shift = atoi (argv[++i]);
		  break;
	       case 'D':
	          no_header =1;
	          offset = atoi (argv[++i]);
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


	       case 'b': 
		  ebw_set = 1;
		  ebw = atof (argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;


	       case 'T' :
	          strcpy (data_type,argv[++i]);
	          break;

	       case 'Y':
	          debug = atoi( argv[++i]) ;
	          break;


	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       default: 
		  printf ("%s: illegal option\n", argv[i]);
		  exit (-1);
	    }
      }
   }

if (debug == HELP)
	sho_use();

   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!gs_read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( gs_read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	printf("not AUDLAB header file\n");
   	exit(-1);
   	}
   }
   
   nc = 0;

   if ( (int) i_df.f[N] > 1) {
      if (debug > 1)
      printf ("There are %d channels;\n", (int) i_df.f[N]);
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


   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];

   if (strcmp(i_chn[nc].dfile,"@") != 0) {
	if (debug > 1)
	printf("dfile %s\n",i_chn[nc].dfile);
	strcpy(sd_file,i_chn[nc].dfile);
	fclose(i_df.fp);
   	i_df.fp = fopen( sd_file,"r");
   	fseek (i_df.fp, fposn, 0); 
   }  

   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

   /* Get sample start and stop times */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


/*  WORK OUT PARAMETER VALUES  according to precedence & Header information */

/* effective bandwidth highest precedence */

   if (ebw_set) {
   win_length = (int) ((1.5 *sf) / ebw);
   frame_length = win_length / (1.0 *sf) ;
   time_shift =1;
   }


   if (frame_length_set)
   	win_length = sf * frame_length;

   ebw = 1.5 * sf / (float) win_length;

   if (!fft_size_set)
       fft_size = compute_fft_size ( win_length) ;

   if (fft_size < 2 || fft_size > 1024) {
      printf ("%s: fft size out of range\n", argv[0]);
      exit (-1);
   }

   if( !win_shift_set)
   win_shift = win_length /2;

   if (win_shift <= 0) {
      if (debug)
      printf ("window shift not valid %d must be > 0\n", win_shift);
      exit (-1);
   }

   if ( !frame_shift_set) {
      n_frames = nsamples / win_shift;
      if ((n_frames * win_shift) < nsamples)
	 n_frames++;
      frame_shift = (float) win_shift / sf;
   }
   else {
      n_frames = (int) (length / frame_shift);
      win_shift = (int) (frame_shift * sf);
   }

/* SHOW PARAMETER VALUES */

   if (debug == 2) {
   printf("str %f stp %f sf %f \n",i_df.f[STR],o_df.f[STP],sf);
   printf ("win_length %d fft_size %d w shift %d \n", win_length, fft_size, win_shift);
   printf ("filter bw %f Hz frame shift %f msec n_frames %d\n", ebw, frame_shift, n_frames);
   } 



 strcpy(o_df.name,"S_GRAPH");
 strcpy(o_df.type,"FRAME"); 
 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);

   

   o_df.f[VL] = (float) fft_size / 2.0;
   o_df.f[FS] = frame_shift;
   o_df.f[FL] = frame_length;
   o_df.f[SF] = sf;
   o_df.f[MX] = sf / 2.0;
   strcpy (o_df.x_d, "Frequency_(Hz)");
   strcpy (o_df.y_d, "amplitude_(dB)");
   o_df.f[LL] = -20.0;
   o_df.f[UL] = 70.0;
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

/* MAIN LOOP */

   while ( 1 ) {

/* READ INPUT DATA */

          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
          last_sample_read += n;
	  if ( eof == 0)  {
	  if (debug > 1)
	  printf("END_OF_FILE\n"); 
	 	break;
	  }


/* CLEAR  FFT ARRAYS */

      for (i = 0; i < fft_size; i++) {
	 Imag[i] = 0.0;
	 Real[i] = 0.0;
         }

/* LOAD REAL INPUT */

      for (i = 0; i < win_length; i++) 
	Real[i] = In_buf[i];

/* PREEMPHASIS   */

      if (pre != 0.0)
	 for (j = 1; j < win_length; j++)
	    Real[j] = Real[j] -  (Real[j-1] * pre);


/* APPLY SMOOTHING WINDOW TO INPUT */

	for (j = 0; j < win_length; j++)
		Real[j] *= Window[j];

/* FFT */

      gs_fft_table (Real, Imag, fft_size, FORWARD, mode, NO_SCALING);
      mode = 0;


/* MAGNITUDE SPECTRUM */

      for (i = 0; i < fft_size / 2; i++) {
	 Real[i] = ( Real[i] * Real[i] + Imag[i] * Imag[i]) *scale_factor;

/* Db SPECTRUM */	
	if (dBflag) {
            if (Real[i] < small)  Real[i] = small;
		 Real[i] = 10.0 * log10 ( Real[i]);
	}
      }


/* WRITE DATA  either to stdout or file */

       gs_write_frame (&o_df, Real);


/* INPUT BUFFER & POSITION FOR NEXT READ */
      loop++;
      
      if (time_shift)       
	 new_sample = (int) (loop * frame_shift * sf);
         else
      	 new_sample += win_shift;

	 gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);

             

/* CHECK FOR END OF DATA */	      

	      if (loop > n_frames -1)
	      break;

   }

/************** end of main loop *****************/


/*  CLOSE FILES    */

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);


   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

   if (debug >= 1)
       fprintf(stderr,"s_sg finished %d frames \n",loop);

}


/* USAGE & HELP */

sho_use () 
{
      fprintf (stderr,
	    "Usage: sgt [-b -n -l -s -w -O -f -p -D  -i in_file -o out_file] \n");

      fprintf(stderr,"-b	effective bandwidth     Hz\n");
      fprintf(stderr,"-n	fft_size	max 1024  \n");      
      fprintf(stderr,"-l	frame_length    msecs  \n");            
      fprintf(stderr,"-s	frame_shift	    msecs  \n");                  
      fprintf(stderr,"-w	win_length	sample_points  \n");                        
      fprintf(stderr,"-O	win_shift	sample_points  \n");                              
      fprintf(stderr,"-f	sampling frequency 	Hz  \n");                                    
      fprintf(stderr,"-p	pre_emphasis	 	%  \n");                                          
      fprintf(stderr,"-M	magnitude Spectrum else dB\n");                                                


      fprintf(stderr,"N.B. Header information (if present) will overide flag settings\n"); 

      exit (-1);
}



/***********************************************************
 *	Serial Processor Fast Fourier Transform		   *
 *      Table version					   *
 ***********************************************************/
 
gs_fft_table (real, imag, size, fr, mode, scaling)
float    real[];
float    imag[];
int   size, fr, mode, scaling;
{
/* Working variables */
   int   i, ii, iii, j, jj, jjj, j1, j2;
   int   np, lix, lmx;
   float    ang, xang, t1, t2;
   float    pi2 = 6.283185307;
   static int  p2;
   double fsize;
   
/* Determine transform size */
   np = size;
   xang = pi2 / (float) np;
   lmx = np;


/* Construct Sine and Cos tables for transform */
   if (mode > 0) {
/**************************/
/*INITIALISATION PROCEDURE*/
/**************************/
/* Set transform scaling factor depending on forward or reverse */

      fsize = 1.0 / (double) size;
      p2 = (int) (0.5 + (log ((double) size)) / log (2.0));

/* Set variables for table construction */
      lmx = np;
      xang = pi2 / (float) np;
      for (i = 0; i < p2; i++) {
	 lmx = lmx / 2;
	 for (ii = 0, ang = 0.0; ii < lmx; ii++) {
	    C[ii][i] = cos (ang);
	    S[ii][i] = (float) fr * sin (ang);
	    ang += xang;
	 }
	 xang = 2.0 * xang;
      }
   }


/******************/
/*TRANSFORM STARTS*/
/******************/
/* Compute each stage of the transform */
   lmx = np;
   for (i = 0; i < p2; i++) {
      lix = lmx;
      lmx = lmx / 2;

/* Compute for each butterfly */
      for (ii = 0; ii < lmx; ii++) {

/* Compute for each point */
	 for (iii = lix; iii <= np; iii = iii + lix) {
	    j1 = iii - lix + ii;
	    j2 = j1 + lmx;

/* Butterfly calculation */
	    t1 = real[j1] - real[j2];
	    t2 = imag[j1] - imag[j2];
	    real[j1] = real[j1] + real[j2];
	    imag[j1] = imag[j1] + imag[j2];
	    real[j2] = (C[ii][i] * t1 + S[ii][i] * t2);
	    imag[j2] = (C[ii][i] * t2 - S[ii][i] * t1);
	 }
      }
   }

/* Apply scaling if forward transform applied */
   if (fr == 1 && scaling > 0)	/* modification for applying scaling */
      for (j = 0; j < np; j++) {
	 real[j] = fsize * real[j];
	 imag[j] = fsize * imag[j];
      }

/* Bit reversal for implace transform */
   j = 0;
   jj = np / 2;
   for (i = 0; i < (np - 1); i++) {
      if (i < j) {
	 t1 = real[j];
	 t2 = imag[j];
	 real[j] = real[i];
	 imag[j] = imag[i];
	 real[i] = t1;
	 imag[i] = t2;
      }
      jjj = jj;
      while (jjj < (j + 1)) {
	 j = j - jjj;
	 jjj = jjj / 2;
      }
      j = j + jjj;
   }
}


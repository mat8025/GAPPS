 /********************************************************************************
 *			sg_va						 *
 *	spectrograph								 *
 *	Array processor version						 *
 *	Modified for pipelining  Dec 88						 *
 *********************************************************************************/

#include <stdio.h>
#include <fcntl.h>
#include "/usr/.attinclude/aplib.h"
#include "df.h"
#include "sp.h"
#include "trap.h"

/* areas which are locked down by the ap */
float    Fscale[10];

int   Pwr2, Nfft, Nfft2;
int   Src = 0;
int   Ctable;
int   Fftscal;
int   Flr, Maxv;
int   Aptop, Avnumber, Tv;
int   Minv, K1;

char s_win_type[120];
int   Hwp, Prev, Spch, Tmp,  Ham, Coef, DBfactor, Fft, Maxv;

float    S_window[2048],  Papa[8192];
double   pow ();


int debug = 0;

float    In_buf[16*2048];
float    Window[2048];
float Real[2048];

float    pre = 0.0;

#define MAXM 100

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;
   channel   i_chn[2];
   char sd_file[80];      
   
   int fposn,posn,nc;
   int chan;
   int do_all_chns = 0;
   int job_nu = 0;   
   char start_date[40];

   int start_channel = 0;
   int num_chans = 1;

   char in_file[120];
   char out_file[120];

   float    start, stop, length,h_len;
   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read = -1;
   int new_sample = 0;
   
   int   eof, nsamples, n_frames;
   int   n,j;

   int   i,  loop;


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
 

   float    small = 0.0000001;

   float    scale_factor = 1.0;
   float    ebw;
   float    frame_length = 0.020;
   float    frame_shift = 0.010;   

   int   dBflag = 1;


   int   AP_SPflag, cflg;
   int   hanflg;
   int   meanspec;
   int  mspecaploc = 0;
   double   dfft, fs, fsms, atof ();

   int   hammw;
   int   avg = 1;




   K1 = 1;


/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */
   strcpy(s_win_type,"Hanning");
   
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

	       case 'T': 
		  strcpy(s_win_type,argv[++i]);
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


if (debug == HELP)
	sho_use();


   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

/* get VA */

      if (i = mapinit (1)) {
	 dbprintf (1,"VA init failed: %d\n", i);
	 exit (-1);
      }
      i = maprndze ();
      mapsync (i);
   

   if (!i_flag_set)
             strcpy(in_file,"stdin");


   if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	dbprintf(1,"not header file\n");
   	exit(-1);
   }

   nc = 0;
   num_chans = (int) i_df.f[N] ;
   
   if ( (int) i_df.f[N] > 1) {
      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
   }

   gs_init_df(&o_df); 

   length = i_df.f[STP] - i_df.f[STR];
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = i_df.f[STP];   

   nsamples = (int) i_chn[0].f[N];

   h_len = nsamples / i_chn[0].f[SF];

   if ( h_len < length ) {
   	o_df.f[STP] = h_len;
	o_df.f[STR] = 0.0;   	
     }
  
   if (length <=0.0) {
        length = h_len;
   	o_df.f[STP] = length;
   }



   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];


   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

   /* Get sample start and stop times */

   start = o_df.f[STR];
   stop =  o_df.f[STP] ;

/*  WORK OUT PARAMETER VALUES  according to precedence & Header information */

/* effective bandwidth highest precedence */

   if (ebw_set) {
   win_length = (int) ((1.5 *sf) / ebw);
   frame_length = win_length / (1.0 *sf) ;
   time_shift =1;
   }


   if (frame_length_set)
   	win_length = (int) (sf * frame_length +0.5) ;

   if (!fft_size_set)
       fft_size = compute_fft_size ( win_length) ;
       else
       win_length = fft_size ;

   if ( fft_size < win_length)
       fft_size = compute_fft_size ( win_length ) ;

   Pwr2 = (int) ((log10 (fft_size * 1.0) / log10 (2.0)) + 0.5) ;

   if (fft_size < 2 || fft_size > 2048) {
      dbprintf (0,"%s: fft size out of range\n", argv[0]);
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
   ebw = 1.5 * sf / (float) win_length;

   dbprintf(1,"str %f stp %f sf %f \n",start,stop,sf);
   dbprintf (1,"win_length %d fft_size %d w shift %d \n", win_length, fft_size, win_shift);
   dbprintf (1,"filter bw %f Hz frame shift %f msec fl %f n_frames %d\n",
    ebw, frame_shift, frame_length,n_frames);



 strcpy(o_df.name,"SG_VA");
 strcpy(o_df.type,"FRAME"); 

 
 if (num_chans > 1.0 & start_channel == 0) {
 	do_all_chns = 1;
        o_df.f[N] = num_chans; 	
 }  else

 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);

   
   
   o_df.f[VL] = (float) fft_size / 2.0 +1 ;
   o_df.f[FS] = frame_shift;
   o_df.f[FL] = frame_length;
   o_df.f[SF] = sf;
   o_df.f[MX] = sf / 2.0;
   strcpy (o_df.x_d, "Frequency_(Hz)");
   strcpy (o_df.y_d, "amplitude_(dB)");
   o_df.f[LL] = -20.0;
   o_df.f[UL] = 70.0;
   o_df.f[STR] = start;
   o_df.f[STP]= stop;
   o_df.f[N]= (float) n_frames;

   gs_w_frm_head(&o_df);   
   posn = gs_pad_header(o_df.fp);

/* INITIALISE FOR FIRST READ */
        
        loop = 0;
	j = 0;
	n = win_length;

/* COMPUTE SCALE FACTOR  & SMOOTHING WINDOW*/

	va_fftsetup (fft_size, win_length);

/* MAIN LOOP */

   dbprintf (1,"SPECTROGRAM -- COMPUTING\n");

   while ( 1 ) {
/* READ INPUT DATA */

	  if ( num_chans == 1) {
          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
	  dbprintf(1,"sc %d %d \n",j,n);
	  }
          else {
          eof = read_m_chn(&i_chn[0],&In_buf[j],n);
	  dbprintf(1,"loop %d mc %d %d \n",loop,j,n);
          }
          last_sample_read += n;


	  if ( nsamples > 0 && last_sample_read > nsamples) {
	  	dbprintf(1,"lsr %d ns %d\n",last_sample_read,nsamples); 
		break;
	  }

/* CHECK FOR END OF DATA */	      	  
	  if ( eof == 0)  {
	  dbprintf(1,"END_OF_FILE\n"); 
          break;
	  
	  }

/* LOAD REAL INPUT */


   for ( chan = 0 ; chan < num_chans ; chan ++ ) {

      va_window (fft_size, win_length,chan,num_chans);

      va_dofft (fft_size, win_length, dBflag);

/* WRITE  FILES */
/* zero Nyquist*/

       Papa[fft_size/2] = 0.0;
       gs_write_frame (&o_df, Papa);
        
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

/*  CLOSE FILES    */

   dbprintf(1,"SG_VA FINISHED number of frames %d\n",loop); 

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   /* release VA */
   mapfreeva(-1);
   
   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}



/***********************************************************/
/* 
	fft-based spectrogram 
*/

/*  make sure any values to be loaded into ap are locked in core 
*	since it is a DMA transfer otherwise use maphlodfv 
*	host load routines 
*/


va_fftsetup (n_fft, win_length)

int   n_fft, win_length;

{

   int   swf;
   int   i, idx;
   int   n_fft2;

   n_fft2 = n_fft / 2;

   Fscale[0] = 1.0 / (2.0 *  n_fft);   
   Fscale[1] = 10.0;
   Fscale[2] = 0.0;
   Fscale[3] = 1 / (1.0 * n_fft2);

/*   map        */

   Src = n_fft;
   Tmp = Src + 2 * n_fft + 2;
   Ctable = Tmp + 2 * n_fft + 2;
   Hwp = Ctable + n_fft + 2;
   Maxv = Hwp + n_fft;
   Flr = Maxv + 2;
   Fftscal = Flr + n_fft;

   Aptop = Fftscal + 2;

   dbprintf(1,"Src %d Tmp %d aptop %d fft_size %d\n",Src,Tmp,Aptop,n_fft); 
   
   /* generate sample window  */
        gs_window(s_win_type,win_length,S_window);          


   idx = maplodfv (S_window, 4, Hwp, 1, n_fft);
   mapbwaitpkt (idx);

   idx = maprffttab (Ctable, Pwr2);
   mapsync (idx);

  idx = maplodfv (Fscale, 4, Fftscal, 1, 10);
   mapbwaitpkt (idx);

   swf = Pwr2 % 2;
   if (swf != 0)		/* i.e. odd */
      Tv = Tmp;
   else
      Tv = Src;

/*  dbprintf(1,"ODD %d %d\n",swf,Pwr2); */
  
}

va_dofft (n_fft, npts, logpower)

int   n_fft, npts, logpower;

{
   int   i, idx, n_fft2;

   /* 		real fft version		 */

   n_fft2 = n_fft / 2;

   /* 		compute fft	 */

   idx = maprfftnc (Src, 1, Ctable, 2, Tmp, 1, n_fft);
   mapsync (idx);

   /* prepare scale */

   idx = mapmulfvv (Tv, 1, Tv, 1, Tv, 1, n_fft);
   mapsync (idx);

   idx = mapaddfvv (Tv, 2, Tv + 1, 2, Tv, 1, n_fft2);
   mapsync (idx);

   /* scale fft results 	 */
   idx = mapmulfsv (Fftscal, Tv, 1, Tv, 1, n_fft);
   mapsync (idx);

   if (logpower) {
      idx = maplog10fv (Tv, 1, Tv, 1, n_fft2+1);
      mapsync (idx);
      /* 	dB spectrum */
      idx = mapmulfsv (Fftscal + 1, Tv, 1, Tv, 1, n_fft2+1);
      mapsync (idx);
   }

   idx = mapstrfv (Tv, 1, Papa, 4, n_fft2+1);
   mapbwaitpkt (idx);

}


va_window (n_fft, npts,chan,nc)	/* 	windows time-amp sample before
				   spectrum processing  */
int   n_fft, npts;		/* give host copy of windowed ouptut */

{
 
   int   idx,i,j;
   /* clear input array in ap */

   idx = mapclrfv (Src, 1, n_fft);
   mapsync (idx);

   /* load in npts samples pts & effectively pad out with n_fft -npts zeroes 
   */

/* pre ??*/
  if (pre != 0.0) {
      for (i = 0; i < npts; i++) 
	Real[i] = In_buf[ chan +(i*nc)];

/* PREEMPHASIS   */

	 for (j = 0; j < npts -1; j++)
	    Real[j] = Real[j] -  (Real[j+1] * pre);
	    idx = maplodfv (&Real[0], 4  , Src, 1, npts);
            mapbwaitpkt (idx);
	   } else 
	   {
	  idx = maplodfv (&In_buf[chan], 4 * nc , Src, 1, npts);
	   mapbwaitpkt (idx);
	}

  /* 	window input */

   idx = mapmulfvv (Src, 1, Hwp, 1, Src, 1, n_fft);
   mapsync (idx);

}


/* USAGE & HELP */

sho_use () 
{
      fprintf (stderr,
	           "Usage: sg_va [-b -n -l -s -w -O -f -p -D  -i in_file -o out_file] \n");

      fprintf(stderr,"-b	effective bandwidth     Hz\n");
fprintf(stderr,"-n	fft_size[256]	max 2048  \n");      
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



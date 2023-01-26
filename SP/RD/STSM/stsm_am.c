/*
 *	stsm_am
 *	Fourier transform filtering
 *      overlap & add		
 *      Mark Terry Oct 1992		
 *
 *      takes as input am spectra
 */
 

#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include <math.h>
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
float    Filter[2048];
float    Asw[2048];
float    op_buf[4096];
float    ring_buf[8192];
float    *p1,*p2,*p3,*p4;
float    *tmp_p;
float    F_slope[2048];
float    F_thres[2048];
short    vox_buf[4096];

float Bark_Hz();
float Hz_Bark();


main (argc, argv)
int   argc;
char *argv[];
{
   FILE *fp,  *gs_wrt_sf();
   
   data_file o_df,i_df,i_fr,asw_fr;
   
   channel   i_chn[2],n_chn[2];

   int asw_err;
   int asw_fn =0;   
   int tran;
   int n_shift;   
   int fposn,posn,nc;
   int fsize,sb;   
   int vox_file_out = 0;
   int job_nu = 0;   
   int f300i;
   char start_date[40];
   char s_win_type[120];
   char in_file[120];
   char fe_file[120];   
   char out_file[120];
   char fec_file[120];   
   char asw_file[120];      
 
   int asw_flag = 0;
   int ova =0;
   int start_channel = 0;
   int num_chans = 1;
   int asw_shift;
   int fpk1,fpk2;
   
   float f1,f2;
   float slope;
   float e_floor = 50.0;
   int f2ki;
      
   int print_fe, print_asw,print_ase,print_aswx;

   float boost_gain,boost_level;     
   float  length;
   float max,min = 0.0;
   float pre;
   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read = -1;
   int new_sample = 0;
   
   int   eof, nsamples, n_frames;
   int i,j,n,k;
   int  loop;
   int  low_cfi, upper_cfi;
   float scale_factor, amp, dB_in, dB_out;
   float amp_factor = 1.0;
   float delta_bark,delta;
   
   double   atof ();


/* DEFAULT SETTINGS */
   int do_filter = 0;
   int do_shift = 0;   
   int i_flag_set = 0;
   int fec_flag_set = 0;   
   int o_flag_set = 0;
   int fe_flag_set = 0;   
   

   float     sf = 16000.0;

   int ebw_set = 0;
   int fft_size_set = 0;
   int frame_shift_set = 0;
   int frame_length_set = 0;   
   int simulate = 0;
   
      int win_shift_set = 0;
   
/* DEFAULT VALUES */

   int   fft_size = 256;
   int  win_shift = 128;
   int  win_length = 256;
   int  shift_by;
   
    
   int asw_vl;    
   int cvr = 0;
   int f2f1 =0;
   
   float tot_ame;   
   float low_cf = 0.0;
   float upper_cf = -1.0;
   float shift_c = 1.0;
   float out_scale_f = 1.0;
   float    small = 0.0000001;
   float dbs,db_down,lf;

   float    frame_length = 0.020;
   float    frame_shift = 0.010;   

       strcpy(s_win_type,"Hamming");

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

	       case 'c': 
		   cvr =1;
		  break;

	       case 'n': 
		  fft_size_set = 1;
		  fft_size = atoi (argv[++i]);
		  break;

	       case 'w': 
		  win_length = atoi (argv[++i]);
		  break;

	       case 'O': 
		  ova = 1;
		  break;
		  
	       case 'f': 
		  sf = atof (argv[++i]);
		  break;
		  
	       case 'V': 
		  vox_file_out = 1;
		  break;
		  
	       case 'L': 
		  do_filter = 1;
		  low_cf = atof (argv[++i]);
		  break;		 

	       case 'U': 
		  do_filter = 1;
		  upper_cf = atof (argv[++i]);
		  break;

	       case 'S': 
		  do_shift = 1;
		  shift_c = atof (argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'd': 
  		  fe_flag_set = 1;		  
		  strcpy(fe_file,argv[++i]);
		  break;

	       case 'C': 
  		  fec_flag_set = 1;		  
		  strcpy(fec_file,argv[++i]);
		   break;
		  
	       case 'a': 
  		  asw_flag = 1;		  
		  strcpy(asw_file,argv[++i]);
		  break;		 

	       case 'F':
	          f2f1 = 1;
	      	  break;

	       case 'A':
		  amp_factor = atof (argv[++i]);
	      	  break;

	       case 's':
		  out_scale_f = atof (argv[++i]);
	      	  break;	      	  

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;

	       case 'T': 
		  strcpy(s_win_type,argv[++i]);
		  break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]) ;
	          break;

	       default: 

		  printf ("%s: flag not recognised \n",argv[i]);
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
   	dbprintf(0,"not  header file\n");
   	exit(-1);
   	}

   
   nc = 0;

   num_chans = (int) i_df.f[N] ;

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


   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];

   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_chn[0].f[SF];

   /* Get sample start and stop times */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


/*  WORK OUT PARAMETER VALUES  according to precedence & Header information */
      
   if ( fft_size < win_length)
       fft_size = compute_fft_size ( win_length ) ;


   if (fft_size < 2 || fft_size > 2048) {
      dbprintf (1,"%s: fft size out of range\n", argv[0]);
      exit (-1);
   }

   if( !win_shift_set)
   win_shift = win_length /4;

   if (win_shift <= 0) {
      dbprintf (1,"window shift not valid %d must be > 0\n", win_shift);
      exit (-1);
   }


      frame_shift = (float) win_shift / sf;
      frame_length = win_length / (1.0 *sf) ;

      n_frames = (nsamples-win_length) / win_shift  + 1 ;

      if (((n_frames-1) * win_shift) > (nsamples-win_length))
	 n_frames--;

/* SHOW PARAMETER VALUES */
	
	if ( ova )
	win_shift = win_length / 4;
	else
	win_shift = win_length;
	
 dbprintf (1,"str %f stp %f sf %f \n",i_df.f[STR],o_df.f[STP],sf);
 dbprintf (1,"win_length %d fft_size %d w shift %d \n", win_length, fft_size, win_shift);

        if (!o_flag_set) 
	strcpy(out_file,"stdout");

        o_df.f[STR] = 0.0;
        o_df.f[STP] = (float) (nsamples / sf);        
        strcpy(o_df.name,"STSM");
 	strcpy(o_df.type,"CHANNEL"); 
 	o_df.f[N] = 1.0;
        n_chn[0].f[SF] = sf;
        n_chn[0].f[N] = (float) nsamples;        
        n_chn[0].f[UL] = i_chn[0].f[UL] ;                
        n_chn[0].f[LL] = i_chn[0].f[LL] ;                        


	if (vox_file_out)
	strcpy(n_chn[0].dtype,"short");
	else
	strcpy(n_chn[0].dtype,"float");

        fp = gs_wrt_sf(out_file,&o_df,n_chn);

/* INITIALISE FOR FIRST READ */
        
        loop = 0;
	j = 0;
	n = win_length;
	
	for ( i = 0; i < 4* win_length ; i++ )
	ring_buf[i] = 0.0;

	p1 = &ring_buf[0];
	i = win_length ;
	p2 = &ring_buf[i ];
	p3 = &ring_buf[2 * i];	
	p4 = &ring_buf[3* i];		
 
	tmp_p = p1;

	for ( i = 0; i < win_length ; i++ ) {
	dbprintf(2,"p1 %d %f\n",i,*tmp_p);
	tmp_p++;
        }

	tmp_p = p3;

	for ( i = 0; i < win_length ; i++ ) {
	dbprintf(2,"p3 %d %f\n",i,*tmp_p);
	tmp_p++;
        }

/* COMPUTE SCALE FACTOR  & SMOOTHING WINDOW*/

        scale_factor = 1.0 / (1.0 * fft_size);
  
        gs_window(s_win_type,win_length,Window);          


/* asw size should be fft_size/2 /
 * not for am spectra going to warp to lin & inter */
	if (asw_flag) {

	for ( j = 0 ; j < fft_size ; j++ )
	Asw[j] = 1.0;
			
        k=gs_open_frame_file(asw_file,&asw_fr);
dbprintf(0,"open %s k %d\n",asw_file,k);
	asw_shift  = (int) (asw_fr.f[FS] * sf) ;

/*	gs_reflect_array(Asw,fft_size/2); */
	asw_vl = (int) asw_fr.f[VL];
	
dbprintf(0,"asw vl %d %f pts %d\n",asw_vl,
asw_fr.f[FS],asw_shift);

   delta_bark = Hz_Bark(8000.0);
dbprintf(1,"delta_bark %f \n",delta_bark);  

   delta_bark = delta_bark / (float) asw_vl;

dbprintf(1,"delta_bark %f \n",delta_bark);  

   delta = sf/ (fft_size);
dbprintf(1," lin delta %f \n",delta);     
       	f300i = (int) (300.0 /delta); /* tel bass cutoff */
       	 
       }


if ( upper_cf < 0.0)
	upper_cf = sf/ 2.0;

if ( do_shift ) {
	
	shift_by = (fft_size / sf) * shift_c;
	dbprintf(2,"shift %d %f\n",shift_by,shift_c);
}

if ( fe_flag_set ) {

	for ( j = 0 ; j < fft_size ; j++ )
	Filter[j] = 0.0;

        gs_open_frame_file(fe_file,&i_fr);

		 if (gs_read_frame(&i_fr,Filter) <= 0) {
		 printf ("Error reading frq spec file\n");
		 gs_close_df(&i_fr);
		 exit (-1);
		}
		/* Convert dbs to absolute values */

		gs_dB_abs(Filter,fft_size /2);
	
	/* reflect real frequency around Nyquist _ DC point goes out of array bounds 
	 * i.e. size * 2  so not used during IFFT
	 */

	gs_reflect_array(Filter,fft_size/2);
	
	for ( j = 0 ; j < fft_size ; j++ )
	dbprintf(2,"fe %d %f \n",j,Filter[j]);

}


if ( fec_flag_set ) 
{
                 gs_open_frame_file(fec_file,&i_fr);


/***************************************************************************************
 * read in threshold curve + number means increased threshold i.e. amplification requ. *
 ***************************************************************************************/

		 if (gs_read_frame(&i_fr,F_thres) <= 0) {
		 printf ("Error reading fe&comp spec file\n");
		 gs_close_df(&i_fr);
		 exit (-1);
		}

/**************************************************************************************		
 * read in loudness balence curve for 90 dB  SPL                                      *
 * if threshold is increased and 90 dB curve is close to normal                       *
 * the loudness recruitment and need to compress signal to compensate for reduced     *
 * dynamic range                                                                      *
 **************************************************************************************/

	 if (gs_read_frame(&i_fr,F_slope) <= 0) {
	 printf ("Error reading fe&comp spec file\n");
	 gs_close_df(&i_fr);
		 exit (-1);
		}

	for ( j = 1 ; j < fft_size/2 ; j++ ) {
	        dbprintf(2,"%d  lb %f thr %f\n",j,F_slope[j],F_thres[j]); 

	if ( ! simulate  ) {
	/* compute slope & intercept */
		F_slope[j] = (F_slope[j] - F_thres[j])/ 90.0 ;
        }
	else { /* simulate the increased thres & abnormal loudness growth */
		
	F_slope[j] =  90.0 / (F_slope[j] - F_thres[j]) ;
	F_thres[j] = -1.0 * F_slope[j] * F_thres[j] ;
        }
        dbprintf(2,"%d  slope %f inter %f\n",j,F_slope[j],F_thres[j]); 
      }

}


if ( do_filter ) {
	
/*  set all_pass */
	for ( j = 0 ; j < fft_size ; j++ )
	Filter[j] = 0.0;

/* set band_reject */
	low_cfi = (((fft_size/2)+1) / (sf/2)) * low_cf;
	upper_cfi = (((fft_size/2)+1)/ (sf/2)) * upper_cf;	

	dbprintf(1," low %f %d upper %f %d \n",low_cf,low_cfi,upper_cf,upper_cfi) ;

	for ( j = low_cfi ; j <= upper_cfi ; j++ ) {
	Filter[j] = 1.0;
        }

	gs_reflect_array(Filter,fft_size/2);
	
	for ( j = 0 ; j < fft_size ; j++ )
	dbprintf(2,"%d %f \n",j,Filter[j]);
}



   scale_factor = 1.0 / (float) fft_size;
   
/* MAIN LOOP */

   dbprintf (1,"ASW -- COMPUTING\n");
   
   while ( 1 ) {

/* READ INPUT DATA */

	  if ( num_chans == 1)
          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
          else
          eof = read_m_chn(&i_chn[0],&In_buf[j],n);

          last_sample_read += n;

/* CHECK FOR END OF DATA */	      	  

	  if ( eof == 0)  {
	  dbprintf(1,"END_OF_FILE\n"); 
          break;
	  }

/* READ SPECTRAL WTS */

    if (asw_flag) {
	 print_ase = 0;

if ( ( (int) (last_sample_read / asw_shift)) > asw_fn ) {
	 	asw_fn++;

	for ( j = 0 ; j < fft_size ; j++ ) 
	Asw[j] = 0.0;

        asw_err=gs_read_frame(&asw_fr,Asw) ;


dbprintf(1,"read am ase %d\n",asw_err);

	tot_ame = 0.0;

	for ( j = 0 ; j < asw_vl ; j++ )  {
if (print_ase) 
	dbprintf(1,"j %d ase %f\n",j,Asw[j]);
	tot_ame += Asw[j];
        }

     dbprintf(1,"total ame fr_n %d %f\n",asw_fn,tot_ame);

/* where is f2 peak */

	fpk1 = 0 ; fpk2 = 0;
	
	for ( j = 1 ; j < asw_vl-1 ; j++ )  {

	if ((Asw[j] < Asw[j+1] ) &&
	     (Asw[j+1] > Asw[j+2] ) ) {
	     	fpk1 = j + 1;
		break;
	}
	
        }

	f1= Bark_Hz(fpk1*delta_bark);

	dbprintf(1,"ame fpk1 @ %d  %f\n",fpk1,f1);

	if ( fpk1 < asw_vl -3) {
	for ( j = fpk1 ; j < asw_vl-1 ; j++ )  {

	if ((Asw[j] < Asw[j+1] ) &&
	     (Asw[j+1] > Asw[j+2] ) ) {
	     	fpk2 = j + 1;
		break;
	   }
        }
        
	}

	f2= Bark_Hz(fpk2*delta_bark);

	dbprintf(1,"ame fpk2 @ %d %f\n",fpk2,f2);

/* default do nothing */

	for ( j = 0 ; j < fft_size/2 ; j++ ) {
	Asw[j] = 1.0;	
        }
        
       	for ( j = 0 ; j < f300i ; j++ ) {
	Asw[j] = 0.0;	/* no dc */
        }


	if (f2 > 800 && f2 < 2500.0 && tot_ame > 350 ) {
dbprintf(1,">>>fn %d f2/f1 enh f2 bass_cut @ %f i%d ame %f\n",asw_fn,f2,f2ki,tot_ame);

/* wts for f2/f1 enhance */

	f2ki = f2/ delta;

        slope = 2.0/ (f2ki -f300i);

dbprintf(1,"f2ki %d slope %f \n",f2ki,slope);


/* use -24 db/oct bass cut */

        dbs = -6.0;

	for ( j = f300i ; j < f2ki ; j++ ) {
	lf = j * delta;
	db_oct(f2,lf,dbs,&db_down,&Asw[j]);
	dbprintf(1,"j %d lf %f db_down %f amp %f\n",
			j,lf,db_down,Asw[j]);
        }
        
       	for ( j = f2ki ; j < fft_size/2 ; j++ ) {
	Asw[j] = 2.0;	
        }

        }


/* or if fricative pattern */

/* apply overall boost */

	boost_level = 400;

	if (tot_ame < boost_level  && tot_ame > e_floor ) {
dbprintf(1,">>>fn %d overall boost by  6 ame %f\n",asw_fn,tot_ame);	

	boost_gain =  (boost_level - tot_ame)/(boost_level- e_floor) * 6.0;

	for ( j = 0 ; j < fft_size/2 ; j++ ) {
	Asw[j] = boost_gain;	
        }

        }


/*	gs_dB_abs(Asw,fft_size /2); */


print_asw = 0;

	for ( j = 0 ; j < fft_size/2 ; j++ ) {

if (print_asw)
dbprintf(1,"aswts j %d pre %f final ASW wt %f\n",j,pre,Asw[j]);
        }	

dbprintf(0,"asw read fr_nu %d ok %d\n",asw_fn,asw_err);

/* reflect */

	gs_reflect_array(Asw,fft_size/2);
	
/* pick f2 enhance */

        }

	}


/* CLEAR  FFT ARRAYS */

      for (i = 0; i < fft_size; i++) {
	 Imag[i] = 0.0;
	 Real[i] = 0.0;
         }

/* LOAD REAL INPUT */

  if ( num_chans == 1) {
      for (i = 0; i < win_length; i++) 
	Real[i] = In_buf[i] * amp_factor;
  } 
  else {

  for (i = 0; i < win_length; i++) 
  Real[i] = In_buf[start_channel +(i*num_chans)]  * amp_factor ;
  }

/* APPLY SMOOTHING WINDOW TO INPUT */

  for (j = 0; j < win_length; j++)
		Real[j] *= Window[j];

/* FFT */
	tran = 1;

	if ( tran ) {
      dbprintf(2,"FFT\n");

      gs_fft(Real, Imag, fft_size, FORWARD);


/* APPLY SPECTRAL TRANSFORM */

if ( do_filter || fe_flag_set ) {
		
print_fe = 1;	
    for (j = 0; j < fft_size; j++) {
/* dbprintf(2,"fft> j %d R %f I %f F %f\n",j,Real[j],Imag[j],Filter[j]); */
	Real[j] *= Filter[j];	
	Imag[j] *= Filter[j];			

if (print_fe && (j % 16 == 0))
dbprintf(1,"fe j %d R %f I %f F %f\n",j,Real[j],Imag[j],Filter[j]); 
        }

 }


if ( asw_flag ) {
print_aswx = 1;		
    for (j = 0; j < fft_size; j++) {
	Real[j] *= Asw[j];	
	Imag[j] *= Asw[j];			

if (print_aswx && (j % 16 == 0))
dbprintf(1,"asw x j %d R %f I %f F %f\n",j,Real[j],Imag[j],Asw[j]);
        }
 }


if ( fec_flag_set) {

/* for each component except DC & NYQUIST */	

        for (j = 1; j < fft_size/2 ; j++) {

/* compute spec component dB value  */

	dB_in = (Real[j] * Real[j] + Imag[j] * Imag[j] ) * scale_factor ;
	amp = 1.0;

	if (dB_in > small ) {

	dB_in = 10 * log10 ( dB_in ) ;

/* compute required db out value using compression slope & inter */

	dB_out = F_slope[j] * dB_in + F_thres[j];

/* db diff -> amp factor */
	amp = ( dB_out - dB_in ) / 20.0;
	amp = pow ( 10.0 , ( double) amp );

/* mult amp factor to spec component */

 	Real[j] *= amp;
 	Real[fft_size-j] *= amp;

 	Imag[j] *= amp;
 	Imag[fft_size-j] *= amp; 	

        }

    dbprintf(1,"comp %d dB_in %f dB_out %f amp %f\n",j,dB_in,dB_out,amp );

        }
}


	if ( do_shift ) {
	
	if ( shift_by > 0 ) {
	  k = fft_size /2  - shift_by -1;
	  n_shift = k;
	  for ( j = 0 ; j < n_shift ; j++ ) { 	

	  Real[k+shift_by] = Real[k];
	  Imag[k+shift_by] = Imag[k];	  

	  Real[fft_size -(k+shift_by)] = Real[fft_size-k] ;

 	  Imag[fft_size -(k+shift_by)] = Imag[fft_size-k] ;

dbprintf(1,"%d shft  %d  %d N %d  %d\n",j,k+shift_by,k,
	  fft_size-(k+shift_by),(fft_size-k));
	  k--;
          }

	  for ( j = 0 ; j <= shift_by ; j++ ) { 	
	  Real[j] = 0.0;
	  Imag[j] = 0.0;	  
	  Real[fft_size-j] = 0.0;
	  Imag[fft_size-j] = 0.0;	  	  
dbprintf(1," j %d n %d\n",j,fft_size-j);
	  }


         }	
	
        }
/* IFFT   */
      dbprintf(2,"IFFT\n");
      gs_fft(Real, Imag, fft_size, 0);

	for ( i = 0 ; i < fft_size ; i++ ) 
		Real[i] /= (1.0* fft_size );
		
     }

/* OVERLAP & ADD */

	if ( ova ) {



	for ( i = 0 ; i < 2 * fft_size ; i++ ) 
		op_buf[i] = 0.0;


dbprintf(2,"p1 %d p2 %d p3 %d p4 %d\n",p1,p2,p3,p4);

/* load  to most recent */

	tmp_p = p4;
	
	for ( i = 0 ; i < win_length ; i++ )  {
		*tmp_p++ = Real[i];
/*	dbprintf(2,"%d %f\n",i,Real[i]);		 */
        }

/*  add op section in all buffers to op buffer */

	tmp_p = p4;

	for ( i = 0 ; i < win_shift ; i++ )  {
	op_buf[i] = *tmp_p;

/*	dbprintf(2,"%d %f  %f\n",i,op_buf[i],*tmp_p);   */

	tmp_p++;
        }

	tmp_p = p3;
	for ( i = 0 ; i < win_shift ; i++ ) 
	tmp_p++;


	for ( i = 0 ; i < win_shift ; i++ )  {
	op_buf[i] += *tmp_p;

/*	dbprintf(2,"%d %f  %f\n",i,op_buf[i],*tmp_p); */

	tmp_p++;

        }

	tmp_p = p2;
	for ( i = 0 ; i < 2*win_shift ; i++ ) 
	tmp_p++;


	for ( i = 0 ; i < win_shift ; i++ ) {
	op_buf[i] += *tmp_p;
/*	dbprintf(2,"%d %f  %f\n",i,op_buf[i],*tmp_p); */
	tmp_p++;

	}

	tmp_p = p1;
	tmp_p += (3*win_shift) ;

	for ( i = 0 ; i < win_shift ; i++ )  {
	op_buf[i] += *tmp_p;
/*	dbprintf(2,"%d %f  %f\n",i,op_buf[i],*tmp_p); */
	tmp_p++;

        }

/*  rotate buffers */

	tmp_p = p4;

	p4 = p1;
	p1 = p2;
	p2 = p3;
	p3 = tmp_p;

  }
   else {
        for ( i = 0 ; i < fft_size ; i++ ) 
		op_buf[i] = Real[i];
        }

dbprintf ( 2,"loop %d sb %d new_sample %d asw_fn %d\n",loop,sb,new_sample,asw_fn);

/* WRITE DATA  either to stdout or file  op is float */

	if (out_scale_f != 1.0)
        for ( i = 0 ; i < win_shift ; i++ ) {
	op_buf[i] =  out_scale_f * op_buf[i];
	if (op_buf[i] > max)
	max = op_buf[i];
	if (op_buf[i] < min)
	min= op_buf[i];
	}

	if (vox_file_out) {
        for ( i = 0 ; i < win_shift ; i++ ) {
	vox_buf[i] = (short) op_buf[i];
	}
	fwrite(&vox_buf[0],sizeof(short), win_shift ,fp);
        }
        else
	fwrite(&op_buf[0],sizeof(float), win_shift ,fp);




/* INPUT BUFFER & POSITION FOR NEXT READ */

        loop++;
      
      	 new_sample += win_shift;

         if (num_chans == 1)
       	 gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);
	 else
	 m_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,win_length);

   }

/************** end of main loop *****************/

/*  CLOSE FILES    */

   if (i_flag_set)    gs_close_df(&i_df);
/*   if (o_flag_set)    gs_close_df(&o_df); */
   if (o_flag_set)      fclose(fp); 


   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

   dbprintf(0,"stsm  finished %d frames max %f min %f\n",loop,max,min);
   printf("stsm max %f min %f\n",max,min);
   
}

/* delivers  weighting for filter given
*  upper frequency, current frequency and slope
*  in dB oct 
*/


db_oct(fu,fl,dbs,db,gain)
float fu,fl,dbs,*db,*gain;
{
double a1;
float amp;

dbprintf(1,"in db_oct u %f l %f\n",fu,fl);

	if (fl > fu ) return(-1);

	if (fl == fu ) {
/*
dbprintf(1,"in db_oct 2 u %f l %f\n",fu,fl);
*/
		*db = 0.0 ;
		*gain = 1.0;
		return 1;
	}


	if (fl <= 0.0 ) {

	*db = -100.0 ;
	*gain = 0.0;
	return 0;
	}


	a1 =  log10 (fu/fl) / log10(2.0);
	*db = a1 * dbs;
/*	
dbprintf(1,"in db_oct 4 %f\n",a1);
*/
	if ( *db < -100)
	*gain = 0.0;
	else
        *gain = (float) pow (10.0,(double) (*db/20.0));	

	return(1);
}




/* USAGE & HELP */

sho_use () 
{
      fprintf (stderr,
	    "Usage: stsm [-i in_file -o out_file ] \n");


      fprintf(stderr,"-n	fft_size [256]	max 2048  \n");      
      fprintf(stderr,"-w	window length	sample_points  \n");                        
      fprintf(stderr,"-O	overlap & add  \n");                              
      fprintf(stderr,"-f	sampling frequency 	Hz  \n");                                    
      fprintf(stderr,"-C	file containing freq response for equalisation 	& compression\n"); 
      fprintf(stderr,"-d	file containing freq response for equalisation \n");       
      fprintf(stderr,"-a        file containing adaptive spectral wts \n");       
      fprintf(stderr,"-A        Amplify input [1.0]) \n");             
      fprintf(stderr,"-s        scale output [1.0]) \n");                   
      fprintf(stderr,"-T        Input Smoothing Window [Hanning]\n");             
      exit (-1);
}

	

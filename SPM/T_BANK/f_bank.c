/*
  This program will produce a bank of trapezoidal shaped filters
  with variable low and high frequency slopes dB/Octave
  with log , linear or Bark spacing between a specified centre freq
  for the first filter upto a specified upper frequency or
  by default the Nyquist frequency
 
  the 0dB pass_band bandwidth can be specified
  
  output of the frequency response of the filters is to sent to
  to file for use with FIR filter programs afb
 
      Flags
 
	-S  sampler frequency
 	-s filter separation Hz Bark or Octave
 	-l low frequency slope dB/octave
	-h high frequency slope dB/octave
	-n number of filters
	-f first filter frequency
	-u upper filter frequency
 	-r resolution pwr of 2 for FFT FIR design
 	-T Type of spacing OCTAVE,LINEAR,BARK
    	-c apply 60dB Phon loudness contour
    	-o output file name 
 */

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */
#define DEF_SAMPLER 16000.0


#define OCTAVE  1
#define BARK    2
#define LINEAR  0

#define MAX_DB_DOWN -200.0


short Sbuf[16000];

float  F_resp[1024];
float    Pi2 = 6.283185307;
double   pow(),sin (), cos (), log (), log10 ();
int debug = 0;
int spacing =0;
   
main (argc, argv)
int   argc;
char *argv[];
{
   int   i, k, j,  n, size,ob_size;
   int track = 0;
   int Oflg= 0;


   int n_spec_pts = 256;
   int lc = 0;
   int posn;

   int job_nu = 0;   
   char start_date[40];


   int fil_nu;
   int nu_filters =1;
   float sf = 16000.0;
   float l_freq = 100.0;
   float u_freq = 8000.0;   
   float cf;
   float lf,hf;

   float bw_0db = 0.333333 ;  /* 1/3 octave */
   float l_dbo= MAX_DB_DOWN;
   float h_dbo= MAX_DB_DOWN;
   float bark;
   float f_sep = 0.0;
   float Hz_Bark(),Bark_Hz();
   float phon60();

   
   char tag[4];
   char *infile, *outfile;
   char *spacing_type ;
   short iodata;

/* Header structures */

   static frame   o_df;
	
/* process command line for specifications */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");


   for (i = 1 ; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {
	      case 'B':
		  bw_0db = atof(argv[++i]);
		  break;
	      case 'b':
		  l_freq = atof(argv[++i]);
		  break;
	      case 'u':
	      	  u_freq = atof(argv[++i]);
	      	  break;
	      case 's':
		  f_sep = atof(argv[++i]);
		  break;
	      case 'f':
		  sf = atof(argv[++i]);
		  break;
	      case 'l':

		  l_dbo = atof(argv[++i]);
		  break;
	      case 'r':
		  n_spec_pts = atoi(argv[++i]);
		  n_spec_pts = n_spec_pts/2 *2;
		  break;
             case 'c':
		/* loudness compensation on */
		  lc = 1;
		  break;
	     case 'h':
		  h_dbo  = atof(argv[++i]);
		  break;
	     case 'n':
		  nu_filters  = atoi(argv[++i]);
		  break;
	     case 'T':
		  spacing_type = argv[++i];

	          if (!strcmp(spacing_type,"OCTAVE"))
	          spacing = OCTAVE;
		  else if
	           (!strcmp(spacing_type,"BARK"))
	          spacing = BARK;
		  else
		  spacing = LINEAR;

		  break;
	       case 'o': 
	          Oflg=1;
                  outfile = argv[++i];
		  break;

	       case 'Y':
	          debug = atoi(argv[++i]);
	          break;


	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       default: 
		  fprintf (stderr, "illegal option %s %s\n",argv[--i],argv[++i]);
		  return (-1);
	    }
	    break;
      }
   }


if (debug == HELP)
	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

        signal (SIGFPE, fpe_trap);

	dbprintf(1,"sf %f %d\n",sf,n_spec_pts);
	
/* set default flags */

/* Set default if vox not selected */

	if (u_freq > sf / 2.0)
		u_freq = sf / 2.0;

/*	contruct  filter_bank freq. responses    */

	cf = l_freq;
	
/*	how many filters */

/*	check frequency spacing */

	if (f_sep <= 0.0) {

	switch ( spacing) {

	case OCTAVE:
	f_sep = 0.333;
	dbprintf(1," %f Octave spacing \n",f_sep);
	lf = 1.0;
	hf =  log10 (u_freq/l_freq) / log10(2.0);
	break;

	case LINEAR:
	if (nu_filters > 1)
	f_sep = (u_freq  - cf) /(float) (nu_filters -1);
	else
	f_sep = (u_freq  - cf) ;
	dbprintf(1,"Linear spacing %f\n",f_sep);
	lf = l_freq;
	hf = u_freq;
	break;

	case BARK:
	if (nu_filters > 1)
	f_sep = ( Hz_Bark(u_freq) - Hz_Bark(cf)) / (float) (nu_filters -1);
	else
	f_sep = (u_freq  - cf) ;

	lf = Hz_Bark(l_freq);
	hf = Hz_Bark(u_freq);	


        dbprintf(1,"Bark spacing %f\n",f_sep, lf, hf);

	break;

	}

       }

        bark = Hz_Bark(l_freq);


	if (!Oflg) return(0);

/*  fill out  header */

/*  check first & last cf & nu_filters */
	
        fil_nu = 0;

	for (k =1; k <= nu_filters; k++) {

/*	centre freq     = ? */

	dbprintf(1,"spacing %d cf %d %f\n",spacing,k, cf);

        fil_nu++;

	hf = cf;

	switch (spacing) {

		case OCTAVE:	
			cf = cf* pow(2.0,(double)f_sep);
		break;
		case LINEAR :
			cf += f_sep;
		break;
		case BARK:
			bark += f_sep ;
			cf = Bark_Hz( bark);
		break;
	}

	if ( cf >= ((sf /2.0) + 1.0) && k < nu_filters) {
		if (debug > 1)
			printf("limit reached cf %f\n",cf);
		break;
	}


      }

	if (debug > 1)
	printf("filter num %d\n",fil_nu);
  	
	/* write out headers */
	gs_init_df(&o_df);
	o_df.f[N] = 1.0;
        o_df.f[STR] = l_freq;
        o_df.f[STP] = hf;        
	strcpy(o_df.type,"FRAME");
        gs_o_df_head(outfile,  &o_df);

      	o_df.f[VL] = 1.0 * n_spec_pts;
      	o_df.f[FS] = f_sep;
      	o_df.f[FL] = f_sep;
      	o_df.f[LL] = -100.0;
      	o_df.f[UL] = 10.0;
      	o_df.f[BRK_VAL] = -100000.0;
      	o_df.f[SF] = sf;
      	o_df.f[MX] = sf / 2.0;
	o_df.f[N] = (float) fil_nu;      	
      	strcpy (o_df.x_d, "Frequency (Hz)");
      	strcpy (o_df.y_d, "amplitude (dB)");
	     o_df.f[N] = 1.0 * nu_filters;

     	     gs_w_frm_head(&o_df);
	   posn = gs_pad_header(o_df.fp);   /* closes the header file */
	
        fil_nu = 0;

	cf = l_freq;
        bark = Hz_Bark(l_freq);
        	
	for (k =1; k <= nu_filters; k++) {


	dbprintf(1,"cf %d %f\n",k, cf);
/*	work out response	*/


	set_up_filt(F_resp,cf, l_dbo, h_dbo, bw_0db, n_spec_pts,sf, lc);


	dbprintf(2,"%d %f\n",fil_nu,F_resp[10]);
	
        gs_write_frame(&o_df,F_resp);
        fil_nu++;

	switch (spacing) {
		case OCTAVE:	
			cf = cf* pow(2.0,(double)f_sep);
		break;
		case LINEAR :
			cf += f_sep;
		break;
		case BARK:
			bark += f_sep ;
			cf = Bark_Hz( bark);
		break;
	}



	if ( cf >= ((sf /2.0) + 1.0) && k < nu_filters) {
		if (debug > 1)
			printf("limit reached cf %f\n",cf);
		break;
	}

      }



/*	number of filters written */


	dbprintf(1,"nu filters written %d\n",fil_nu);


	 gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}
	




db_oct(fu,fl,dbs,db,gain)

/* delivers dB weighting for filter given
*  upper frequency, current frequency and slope
*  in dB oct 
*  gain can be +ve/-ve 
*/


float fu,fl,dbs,*db,gain;

{
	double a1;
	
	if ( dbs <= MAX_DB_DOWN ) { 
	*db = MAX_DB_DOWN; 
	return (1);
        }
	
	if (fl > fu ) return(-1);
	if (fl == fu ) *db = gain ;
	else
	if (fl <= 0.0 ) *db = MAX_DB_DOWN ;
	else
	{
	a1 =  log10 (fu/fl) / log10(2.0);
	*db = gain + (a1* dbs);
	}
	return(1);
}


/* sets up a trapezoidal  filter frequency response 
*  given CF of filter and low-frequency slope
*  and high frequency slope and pass_band band_width
*/

set_up_filt(fr_rsp,cf, low_dbo, high_dbo, bw, n_spec_pts,sf,lc)

float fr_rsp[];
float cf, low_dbo, high_dbo, sf, bw;
int n_spec_pts;
int lc;
{

	float db,fr,resol,gain;
	int i;
	float low_cf, high_cf;
	
	if (lc)
		gain = phon60(cf);
		else gain = 0.0;

/* compute pass_band */

	high_cf = cf;
	low_cf = cf;
if ( spacing == LINEAR) {
	high_cf = cf + bw /2.0;
	low_cf = cf - bw /2.0;
}	

	dbprintf(1,"lcf %f hcf %f\n",low_cf,high_cf);
	
	resol = sf/ (2.0 *n_spec_pts); /* frequency resolution */

        for (i = 0 ; i < n_spec_pts; i++ ) {
	fr = resol * i ;

	if (fr <= low_cf)   db_oct(low_cf,fr,low_dbo,&db,gain);
	if (fr >= high_cf)  db_oct(fr,high_cf,high_dbo,&db,gain);
        
        if ( (fr > low_cf) && (fr < high_cf) ) db = 0.0;
        
	if (db < MAX_DB_DOWN) db = MAX_DB_DOWN;

	fr_rsp[i]= db;

	}
}




float
phon60 ( freq)

float freq;

{
	float amp;

	static float phon[20][2] = {
	{0.0, 200.0},
	{20.0, 100.0},
	{30.0, 90.0},
	{40.0, 85.0},
	{60.0, 75.0},
	{80.0, 72.0},
	{100.0, 68.0},
	{200.0, 60.0},
	{300.0, 57.0},
	{400.0, 56.0},
	{600.0, 57.5},
	{800.0, 59.0},
	{1000.0, 60.0},
	{2000.0, 58.0},
	{3000.0, 54.0},
	{4000.0, 51.0},
	{6000.0, 60.0},
	{8000.0, 67.0},
	{10000.0, 65.0},
	{15000.0, 61.0}
	};

	int i;
	float da,df;

	amp = phon[19][1] - 60.0;

	for (i = 0; i < 19 ; i++ ) {

	if (freq < phon[i][0]) {
	da = phon[i][1] - phon[i-1][1];
	df = phon[i][0] - phon[i-1][0];

	amp = da/ df * ( freq - phon[i-1][0]);
	amp = amp + phon[i-1][1] -60.0; 
	break;
	}

	}
	return (-1.0 *amp);

}


sho_use()
{

    fprintf(stderr,"Flags \n-f  sampler frequency\n-s separation\n");
    fprintf(stderr,"-l low freq slope dB/octave\n-h high frequency slope dB/octave\n");
    fprintf(stderr,"-n number of filters\n-b base filter frequency\n");
    fprintf(stderr,"-u last filter frequency\n");
    fprintf(stderr,"-B pass band band_width \n");    
    fprintf(stderr,"-r frequency resolution must be a power of 2\n");
    fprintf(stderr,"-c apply 60dB Phon loudness contour\n");
    fprintf(stderr,"-T OCTAVE or BARK or LINEAR  spacing [default linear]\n");
    fprintf(stderr,"-o  output file name\n");
    exit(-1);

}



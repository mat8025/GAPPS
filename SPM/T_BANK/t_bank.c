static char     rcsid[] = "$Id: t_bank.c,v 1.2 1997/04/12 17:40:52 mark Exp mark $";
/*
  This program will produce a bank of triangular shaped filters
  with variable low and high frequency slopes dB/Octave
  with log , linear or Bark spacing between a specified centre freq
  for the first filter upto a specified upper frequency or
  by default the Nyquist frequency
 
  output of the frequency response of the filters is to sent to
  a file for use with FIR filter programs afb or fir_bnk.


	Author Mark Terry  1987
 */

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"

/*Define default constants */
#define DEF_SAMPLER 16000.0


#define OCTAVE  1
#define BARK    2
#define LINEAR  0


short Sbuf[16000];
float  F_resp[1024];
float    Pi2 = 6.283185307;
double   pow(),sin (), cos (), log (), log10 ();
int debug = 0;
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

   int spacing =0;
   int fil_nu;
   int nu_filters =1;
   float sf = 16000.0;
   float l_freq = 100.0;
   float u_freq = 8000.0;   
   float cf;
   float lf,hf;

   float l_dbo= -24.0;
   float h_dbo= -24.0;
   float bark;
   float f_sep = 0.0;
   float Hz_Bark(),Bark_Hz();
   float am_phon60();

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
     if (debug == HELP)     
     	 break;
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {
	      case 'b':
		  l_freq = atof(argv[++i]);
		  break;
	      case 'U':
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
	     case 'u':
		  h_dbo  = atof(argv[++i]);
		  break;
	     case 'n':
		  nu_filters  = atoi(argv[++i]);
		  break;
	     case 'v':
				show_version();
				exit(-1);
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
      }
   }


if (debug == HELP)
	sho_use();

	if (debug) {
	printf("sf %f %d\n",sf,n_spec_pts);
	printf("t_bank\n");
	}
	
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
	printf(" %f Octave spacing \n",f_sep);
	lf = 1.0;
	hf =  log10 (u_freq/l_freq) / log10(2.0);
	break;

	case LINEAR:
	if (nu_filters > 1)
	f_sep = (u_freq  - cf) /(float) (nu_filters -1);
	else
	f_sep = (u_freq  - cf) ;
	printf("Linear spacing %f\n",f_sep);
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

	if (debug)
        printf("Bark spacing %f\n",f_sep, lf, hf);

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
	if (debug)
	printf("spacing %d cf %d %f\n",spacing,k, cf);
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

	if (debug > 1)
	printf("cf %d %f\n",k, cf);
/*	work out response	*/

	am_set_up_filt(F_resp,cf, l_dbo, h_dbo, n_spec_pts,sf, lc);

	if(debug > 2)
	printf("%d %f\n",fil_nu,F_resp[10]);
	
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

	if(debug ) {
	printf("nu filters written %d\n",fil_nu);
        }

	 gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}
	

am_db_oct(fu,fl,dbs,db,gain)

/* delivers dB weighting for filter given
*  upper frequency, current frequency and slope
*  in dB oct 
*  gain can be +ve/-ve 
*/

float fu,fl,dbs,*db,gain;

{
	double a1;
	if (fl > fu ) return(-1);
	if (fl == fu ) *db = gain ;
	else
	if (fl <= 0.0 ) *db = -100.0 ;
	else
	{
	a1 =  log10 (fu/fl) / log10(2.0);
	*db = gain + (a1* dbs);
	}
	return(1);
}


am_set_up_filt(array,cf, low_dbo, high_dbo, n_spec_pts,sf,lc)
/* sets up a triangular filter frequency response 
*  given CF of filter and low-frequency slope
*  and high frequency slope
*/
float array[];
float cf, low_dbo, high_dbo,sf;
int n_spec_pts;
int lc;
{
	float db,fr,resol,gain;
	int i;
        int up_co =1;
        int down_co = 1;
        float lcf,ucf,bw;
        lcf = 0.0;
        ucf = sf/2.0;
	if (lc)
		gain = am_phon60(cf);
		else gain = 0.0;

	resol = sf/ (2.0 *n_spec_pts); /* frequency resolution */
        for (i=0; i< n_spec_pts; i++ ){
	fr = resol * i ;
	if (fr < cf) {
               am_db_oct(cf,fr,low_dbo,&db,gain);
        if (debug > 1)
               if (db > -3.0 && up_co) {
                 printf("lc_fr %f db %f \n",fr,db);
                 lcf = fr;
                 up_co = 0;
               }
          }
	else 
          {
           am_db_oct(fr,cf,high_dbo,&db,gain);
            if (debug > 1)
                 if (db < -3.0 && down_co) {
                 printf("uc_fr %f db %f \n",fr,db);
                 ucf = fr;
                 down_co = 0;
               }
	   }

	if (db < -120.0) db = -120.0;
	array[i]= db;
	}

        if (debug > 1) {
              printf("cf %f lcf %f ucf %f bw %f \n",cf,lcf,ucf,ucf-lcf);
        }
}


sho_use()
{
    fprintf(stderr,"Flags \n -f  sampler frequency\n-s separation\n");
    fprintf(stderr,"-l lower freq slope dB/octave \n");
    fprintf(stderr,"-u upper frequency slope dB/octave\n");
    fprintf(stderr,"-n number of filters\n-b base filter frequency\n");
    fprintf(stderr,"-U last filter frequency\n");
    fprintf(stderr,"-r frequency resolution must be a power of 2\n");
    fprintf(stderr,"-c apply 60dB Phon loudness contour\n");
    fprintf(stderr,"-T OCTAVE or BARK or LINEAR  spacing [default linear]\n");
    fprintf(stderr,"-o  output file name\n");
    exit(-1);
   }


show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}


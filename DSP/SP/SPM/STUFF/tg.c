
/****************************************************************************************
 *			TG								*
 *   	makes multi_component signal  				       			*
 *	Author Mark  Terry   								*
 *	modified	for pipelining & ascii headers    Dec 1988			*
 ****************************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

#define NTONES  10
#define OP_BUFSIZE 512

int   i, j, idx, nsamples, maxv, nsamples2, l2, ln2, tv, sw;
int debug = 0;
int vox_file_out = 0;
char  name[10];
float    Fbuf[512];
short    Sbuf[512];

float    pi2s, pi;

float cos_gate_on ();
float cos_gate_off ();
   
main (argc, argv)
int   argc;
char *argv[];

{
   FILE *fp,  *gs_wrt_sf();
   double   alm_rad ();
   double   sin ();
   float    sf = 16000.0;
   float ga;
   int on;
   int gate =0;
   
   float g_msec;
   
   float    fr[7], amp[7], ph[7];
   int job_nu = 0;   
   char start_date[40];
   int   ip = 0;
   int   ia = 0;
   int   ifr = 0;
   int   bp = 0;
   float    scale = 1.0;
   float max_scale = 2045.0;
   
   float y;
   char outfile[120];
   int continous = 0;
   int i_flag_set = 0;
   int o_flag_set = 0;
   int scale_signal = 0;
   int ntones = 0;
        data_file o_df;
	channel n_chn[2];

   for (i = 0; i < NTONES; i++) {
      fr[i] = 100.0;
      amp[i] = 0.0;
      ph[i] = 0.0;
   }



	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");


   for (i = 1; i < argc; i++) {

     if (debug == HELP)     
     	 break;
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 't': 
		  fr[ifr] = atof (argv[++i]);
		  ifr++;
		  ntones++;
		  break;
	       case 'a': 
		  amp[ia] = atof (argv[++i]);
		  ia++;
		  break;
	       case 'p': 
		  ph[ip] = atof (argv[++i]);
		  ip++;
		  break;
	       case 'f': 
		  sf = atof (argv[++i]);
		  break;
	       case 'n': 
		  nsamples = atoi (argv[++i]);
		  break;

	       case 'G':
	         gate = 1;
		 g_msec =  atof(argv[++i]);
	         break;	         

	      case 'C':
	      	  continous = 1;
	      	  break;

	      case 'o': 
		  o_flag_set = 1;
                  strcpy (outfile,argv[++i]);
		  break;

	      case 'S':
	      	  max_scale = atof (argv[++i]);
		  scale_signal = 1;
		  break;

	      case 'V':
		  vox_file_out =1;
		  break;

	      case 'Y':
	         debug = atoi (argv[++i]);
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
		  fprintf (stderr, "illegal options\n");
		  debug = HELP;
		  break;
	    }
	    break;
      }
   }


 if (debug == HELP)
 	sho_use();
 	

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

	if (continous == 1) {
		nsamples = -1;
		o_flag_set = 0;
	}

        if (!o_flag_set) 
	strcpy(outfile,"stdout");

        o_df.f[STR] = 0.0;
        o_df.f[STP] = (float) (nsamples / sf);        
        strcpy(o_df.name,"TG_GENERATOR");
 	strcpy(o_df.type,"CHANNEL"); 
 	o_df.f[N] = 1.0;
        n_chn[0].f[SF] = sf;
        n_chn[0].f[N] = (float) nsamples;        
        n_chn[0].f[UL] = amp[0];                
        n_chn[0].f[LL] = -1.0 *amp[0];                        

	if (vox_file_out)
	strcpy(n_chn[0].dtype,"short");
	else
	strcpy(n_chn[0].dtype,"float");

        fp = gs_wrt_sf(outfile,&o_df,n_chn);

      pi = 4.0 * atan (1.0);

   for (i = 0; i < ntones; i++)


/*	convert degrees to radians */

   scale = 0;

   for (i = 0; i < ntones; i++) {
      ph[i] = alm_rad (ph[i]);
      scale += amp[i];
   }


      scale = max_scale / scale;

   if (!scale_signal) 
       scale = 1.0;
       
   pi2s = 2 * pi / sf;

/*	compute value */


        bp =0;
	j= 0;

	on = (int)  g_msec / 1000.0  * sf;
	
	while (1) {

      y = 0.0;

      for (i = 0; i < ntones; i++) {
	 if (amp[i] > 0.0)
	    y = y + amp[i] * sin (pi2s * fr[i] * j + ph[i]);
      }


/* if gate on */

	if (gate && j < on ) {
	    ga = cos_gate_on(g_msec, sf,j);	
	    y *= ga;
	}

/* if gate off */
	
	if (gate && j > (nsamples - on) ) {
	    ga = cos_gate_off(g_msec, sf,(j-(nsamples-on)));	
	    y *= ga;
	}

	   
      	if (vox_file_out)
            Sbuf[bp] = (short) (scale * y);
	else
	    Fbuf[bp] =  (scale * y);
            bp++;

      if (bp == OP_BUFSIZE) {
	if (vox_file_out)
		fwrite(Sbuf,sizeof(short), OP_BUFSIZE,fp);
		else
		fwrite(Fbuf,sizeof(float), OP_BUFSIZE,fp);
	 bp = 0;
      }
	j++;
	if (j == (nsamples -1))
	break;
   }

	/* flush buffer */

	if (vox_file_out)
	fwrite(Sbuf,sizeof(short), bp,fp);
	else
	fwrite(Fbuf,sizeof(float), bp,fp);

	if (o_flag_set)
	fclose(fp);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}

/*
 *	alm libray function
 *      degrees to radians
 *
 */

double
         alm_rad (deg)
double   deg;

{
   double   dr = 0.0174532;
   int   ncyc;
   if (deg > 360.0 || deg < -360.0) {
      ncyc = deg / 360.0;
      deg = deg - (ncyc * 360);
   }
   return (dr * deg);
}



sho_use() {

      printf ("Usage [-t float -a float  -p float  -f float  -n int -C -V -o]:\n");
      printf ("-t tone frequency in Hz\n");
      printf ("-a amplitude\n");
      printf ("-p phase in degrees\n");
      printf ("-f sample frequency in Hz\n");
      printf (" t a f p can be repeated to specify up to 10 different tones\n");
      printf ("-n number of samples (n < 80000)\n");
      printf ("-S amp whole signal will be scaled to max amp \n");      
      fprintf( stderr,"-C continous (infinite number of samples) \n");      
      fprintf( stderr,"-V output is short integer file [float]\n");            
      printf ("-o output file name\n");
      exit (0);

}


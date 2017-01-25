/***************************************************************************************
 *			FGEN								*
 *   	makes signals for testing purposes						*
 *	Author Mark  Terry   								*
 *	date	june 1985 								*
 *	modified	for pipelining & ascii headers    Dec 1988			*
 ****************************************************************************************/
#include <gasp-conf.h>

#include <stdio.h>
#include <errno.h>
#include <math.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

#define BUF_SIZE 8192

#define SINE 1
#define SWEEP 2
#define SQUARE  3
#define RAMP 4
#define AM 5
#define FM 6
#define TRI 7
#define TWO_TONE 8

double fr_rad(); 
float tri();
extern int errno;

int   i, j, maxv;
double    swp, scal, sclm, amp, mamp, max, max2,  pi;
char  name[10];
int   clamp;
short    sbuf[BUF_SIZE];
float    fbuf[BUF_SIZE];
int debug = 0;

main (argc, argv)
int   argc;
char *argv[];

{

	FILE *fp,  *gs_wrt_sf();
	int vox_file_out = 0;

/* DEFAULT SETTINGS */

	double rf = 0;
	double b_fr = 100.0;
	double bt_fr,top_fr;
	double sf = 16000.0;
	double usf = 160000 / 3.0;
	double f1 = 0.0;
	double frc = 0.0 ;
	double tmp_fr,old_fr;
	double mf;
	int seed = 1;
        int nsamples = 16000;
        int ns2;
	char wave_type[120];
	char sweep_type[120];
	char fixed_type[120];		
        char outfile[120];
        int bp;
        int type = 0;
        int track = 0;
	int dir = 1;
	int ncf,nfix,k1;	
        int i_flag_set = 0;
        int o_flag_set = 0;
	double f_swp = 2.0 ;
	double dt;
	double ff[4];
	double f1f[4];
        data_file o_df;
	channel n_chn[2];

   int job_nu = 0;   
   char start_date[40];
 
   double    f2 = 0.0;
   double    a2 = 0.0;
   double    period_half;
   double fpi;   
   double    scale = 1.0;
   double max_scale = 32000.0;
   int scale_signal = 0;
   
   int w_type =  SINE;
   int s_type =  SINE;   
   int f_type =  SINE;      

   int   nc,k;


   strcpy(wave_type,  "SINE");
   strcpy(fixed_type, "SINE");
   strcpy(sweep_type, "SINE");      


   /* DEFAULT SETTINGS */

   b_fr = 1000.0;
   amp = 1000.0;
   nfix = 1;

	ff[0] = ff[1] = ff[2] = 0.0;
	f1f[0] = f1f[1] = f1f[2] = 0.0;
	
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

	       case 'b': 
		  b_fr = atof (argv[++i]);
		  break;
	       case 'a': 
		  amp = atof (argv[++i]);
		  break;
	       case 'u':
	       	  usf =  atof (argv[++i]);
	       	  break;

	       case 'F': 
		  f2 = atof (argv[++i]);
		  break;
	       case 'A': 
		  a2 = atof (argv[++i]);
		  break;
	       case 'f': 
		  sf = atof (argv[++i]);
		  break;
	       case 'c': 
		  f_swp = atof (argv[++i]);
		  break;		  
	       case 'n': 
		  nsamples = atoi (argv[++i]);
		  break;

              case 'N': 
		  nfix = atoi (argv[++i]);
		  break;		  

	      case 'o': 
		  o_flag_set = 1;
                  strcpy (outfile,argv[++i]);
		  break;
              
              case 't': 
		  strcpy (sweep_type,argv[++i]);
		  break;

              case 'T': 
		  strcpy (fixed_type,argv[++i]);
		  break;

              case 'w': 
		  type = 1;
		  strcpy (wave_type,argv[++i]);
		  break;

	      case 'V':
		  vox_file_out = 1;
		  break;

	      case 'S':
	      	  max_scale = atof (argv[++i]);
		  scale_signal = 1;
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
		  printf ("%s: option not valid\n", argv[i]);
		  debug = HELP;
		  break;

	    }
      }
   }

    if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

dbprintf(1,"para %f\n",sf);

        signal (SIGFPE, fpe_trap);

 if (debug == HELP)
 	sho_use();

/*	open non_header file */

        if (!o_flag_set) 
	strcpy(outfile,"stdout");

        o_df.f[STR] = 0.0;
        o_df.f[STP] = (float) (nsamples / sf);        
        strcpy(o_df.name,"F_GEN");
 	strcpy(o_df.type,"CHANNEL"); 
 	o_df.f[N] = 1.0;
        n_chn[0].f[SF] = sf;
        n_chn[0].f[N] = (float) nsamples;        
        n_chn[0].f[UL] = max_scale;                
        n_chn[0].f[LL] = -1.0 * max_scale;                        
	
	if (vox_file_out)
	strcpy(n_chn[0].dtype,"short");
	else
	strcpy(n_chn[0].dtype,"float");

	fp = gs_wrt_sf(outfile,&o_df,n_chn);


      scale = amp + a2;
      scale = max_scale / scale;

/*    set default flags */

   if (!scale_signal) 
       scale = 1.0;
       
      pi = 4.0 * atan (1.0);



      dt = 1.0 / sf ;

      fpi = 2.0 * pi * dt ;      

dbprintf(1,"pi = %f  dt %f  sf %f\n",pi,dt,sf);	

      max = fpi * b_fr;

      max2 = fpi * f2;

      swp = (usf - b_fr) / (float) (nsamples)  * f_swp;

      swp = nfix * swp ;

	mf = usf - b_fr;

	if (nfix <= 1)
	mf /= 2.0;

	if (usf >= b_fr ) {
		bt_fr = b_fr;
		top_fr = usf;
	        f1 =bt_fr;
	top_fr = bt_fr + mf;
	}
	else {
		bt_fr = usf;
		top_fr = b_fr;
	        f1 =top_fr;
		swp *= -1;
	bt_fr = top_fr + mf;
	}


      ncf = nsamples/f_swp;
      
dbprintf(0,"swp  bt_fr %f tp_fr %f swp %f f_swp %f f1 %f\n",bt_fr,top_fr,swp,f_swp,f1);
dbprintf(0,"scale %f fpi %f\n",scale,fpi);

   if (!strcmp (sweep_type, "sine") )
   	s_type = SINE;

   if (!strcmp (sweep_type, "tri") )
   	s_type = TRI;

   if (!strcmp (wave_type, "sine") || (!strcmp (wave_type, "SINE"))) {
   	w_type = SINE;
   }
   else    if (! strcmp (wave_type, "sweep") || (!strcmp (wave_type, "SWEEP"))) {
   	w_type = SWEEP;
   }
   else    if (!strcmp (wave_type, "ramp") || (!strcmp (wave_type, "RAMP"))) {
   	w_type= RAMP;
   }
   else if (!strcmp (wave_type, "square") || (!strcmp (wave_type, "SQUARE"))) {
   	w_type= SQUARE;
   }
    else if (!strcmp (wave_type, "am") || (!strcmp (wave_type, "AM"))) {
   	w_type= AM;
   }
   else if (!strcmp (wave_type, "fm") || (!strcmp (wave_type, "FM"))) {
   	w_type= FM;
   }
      j = 0;


/* change frequency 0 to Nyquist  to 0 to pi  ?? */

	k = 0;
	k1 = 0;
	
	old_fr = top_fr;


   for (i = 0; i < nsamples ; i++) {

	  switch (w_type) {
	  	
	  case SINE:

		    if (s_type == SINE)
	    	    fbuf[j] =  (amp * sin (i * max));
    		    else if (s_type == TRI) 
    		    fbuf[j] = amp * tri (i * max );

		 if (a2 != 0.0)
		    fbuf[j] +=  a2 * sin (i * max2);
	
	  	break;

	  case SWEEP:

		    f1 = bt_fr + swp * i;

		    if (s_type == SINE)
    		    fbuf[j] = amp * sin (f1 * i * fpi );
    		    else if (s_type == TRI) 
    		    fbuf[j] = amp * tri (f1 * i * fpi );
    		    
    		    fbuf[j] += a2 * sin (i * max2);

		break;

	  case AM:

	    if (a2 >= 1.0) a2 = 0.5;
	    if (a2 < 0.0) a2 = 0.0;
		if (s_type == SINE)
                fbuf[j] = amp * sin (2 * pi * f1 * i * dt) ;
                else if (s_type == TRI) 
                fbuf[j] = amp * tri (2 * pi * f1 * i * dt) ;

		fbuf[j] *= ( a2 * sin (i * max2) + 0.5) ;
		break;

	  case FM:

		if (k >= 2) {
		ff[2] = sin(fpi * (k-2)*f2);
  		ff[1] = sin(fpi * (k-1)*f2);
	        }

	        if ( k >= 2) {
	       	mf  = 2.0*cos( fpi * f2) * (ff[1] - ff[2]);
	        }

		rf = f1 + a2 * mf;

		k1++;
		
		if (rf == f1)
dbprintf(1," k %d k1 %d ff %f rf %f\n",k,k1,mf,rf);
	
		if ( rf > (f1 +a2) || rf < (f1-a2) ) {
		dbprintf(1,"rf %f f1 %f a2 %f\n",rf,f1,a2);
		}

		if (k >= 2) {
		f1f[2] = sin(fpi * (k-2)* rf);
  		f1f[1] = sin(fpi * (k-1) * rf);
	        }

	        if ( k >= 2) {
	       	mf  = 2.0*cos( fpi * rf) * (f1f[1] - f1f[2]);
	        }
		
		fbuf[j] =  (amp * mf );

		k++;

		break;

	 case RAMP:

 	         if ( f1 >= top_fr ) {
		    dir = -1;
		    f1 = top_fr;
        	dbprintf(1,"f1 %f %d %f\n",f1,dir,frc);
		    rf = f1;
		  /* k = 0; */
		   }

	    	    if (f1 <= bt_fr) {
	    	    dir = 1 ;
		  dbprintf(1,"f1 %f %d %f\n",f1,dir,frc);
		    f1 = bt_fr;
		    rf = f1;
	    	   }
	    
	   	   if ( ! (k % nfix) ) {
		    f1 += dir * swp ;
	            rf += dir * swp/2.0;
		   }
	          
	            frc = fpi * f1 * k; 

		    frc = fr_rad(frc,pi); 
		    if (s_type == SINE)
		    fbuf[j] = amp * sin (frc) ;
		    else if (s_type == TRI)
    		    fbuf[j] = amp * tri (frc) ;
		    fbuf[j] += a2 * sin (i * max2);  

 if ( ! ( k % 100))
 dbprintf(1,"f1 %f swp %f frc %f %f j %d %d\n",f1,swp,frc,fbuf[j],j,k);

		if (errno == ERANGE) {
		 perror("fgen ");
		dbprintf(1,"errno = ERANGE");
	        }

		 k += dir;

		 k1++;
		 
		break;

	case SQUARE:

		 if (sin (i * max) > 0.0)
		    fbuf[j] = amp;
		 else
		    fbuf[j] = -1.0 * amp;
		 if (a2 > 0.0)
		    fbuf[j] += a2 * sin (i * max2);
	        break;

	}

	fbuf[j] = scale * fbuf[j];
	
/*        dbprintf(1,"j %d  %f\n",j,fbuf[j]); */

	if (vox_file_out)
		sbuf[j] =  (short) fbuf[j];

	 j++;

	 if (j == BUF_SIZE) {
		if (vox_file_out)
		    fwrite(sbuf,sizeof(short), j,fp);
		    else
		    fwrite(fbuf,sizeof(float), j,fp);	    
		    j = 0;
	 }

      }

/* flush buffer */

	if (vox_file_out)
	    fwrite(sbuf,sizeof(short), j,fp);
	    else
	    fwrite(fbuf,sizeof(float), j,fp);	    

	if (o_flag_set)
	fclose(fp);

   if (debug)
   dbprintf (0,"function generation completed \n");

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
}

double fr_rad(f,pi)
double f,pi;
{
int k;
double r;
	r = 2.0*pi;
	k = f/(r);
	return( f - (k * r));	
}


sho_use() 
{
      printf ("Usage [-t string -f float -a  float -u float \n");

      printf ("-b lower frequency of sweep tone in Hz\n");
      printf ("-u upper frequency of sweep tone in Hz\n");
      printf ("-a amplitude  \n");
      printf ("-t sweep tone type (sine,tri) [sine]  \n");

      printf ("-F second frequency in Hz\n");
      printf ("-A second tone amplitude  \n");
      printf ("-T fixed tone type (sine,tri) [sine]  \n");

      printf ("-V produce a file of short int and scale to a max amp [2045]\n");
      printf ("-f sample frequency in Hz\n");
      printf ("-S scale signal to a max amp [2045]\n");
      printf ("-n number of samples \n");
      printf ("-w function type (sine,sweep,square,ramp, AM ,FM ) [sweep] \n");
      printf ("-c number of cycles of sweep/ramp tone  \n");
      printf ("-o output file name\n");
      exit (-1);   
}


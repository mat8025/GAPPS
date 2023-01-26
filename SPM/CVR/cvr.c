/****************************************************************************************
 	CVR
 
	Author 	Mark Terry 1993
 
 	This program will take as input either a multichannel vox 
 	and compute a apply AGC to achieve a greater CVR value for
	speech signals
 
******************************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include "math.h"
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */



int Vox;

float Rms[512];
float Fbuf[2048];
short agc_buf[8192];
short Sbuf[8192];

float    Pi2 = 6.283185307;
double   pow(),sin (), cos (), log (), log10 ();

int debug = 0; 
float    In_buf[MAX_IP_BUF];
channel   i_chn[128];

main (argc, argv)
int   argc;
char *argv[];
{
   FILE *fp,  *gs_wrt_sf();

   data_file o_df,i_df;
   channel n_chn[2];
   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   
   int n_agc = 20;
   int do_agc = 0;
   int kk;
   int no_output_header = 0;
   float max_scale;
   
   char in_file[120];
   char out_file[120];


   int job_nu = 0;   
   char start_date[40];

   char data_type[20];
   int no_header = 0;
   int offset = 0;
   int swab_it = 0;     
   float  length;

   int   mode = 1;
   int   time_shift = 0;

   int last_sample_read =0;
   int new_sample = 0;
   
   int   eof, nsamples, n_frames;
   int i,j,n,k;
   int  loop;

   double   atof ();


/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;
   int frame_shift_set = 0;
   int frame_length_set = 0;   
   int  win_length = 256;
   float     sf = 16000.0;
   float factor,limit_gain,delay;

   int start = 0;
   int more_input;
   int opbufsize;    
   int l_chn;
   int u_chn;
   float min = 0.0;
   float max = 1.0;
   float r = 20.0;
   float v = 0.33;
   float sampler;
   char tag[4];
   float amp;
   short iodata;

/* DEFAULTS */

	delay = 0.006; /* msec */
	factor = 0.2;
	limit_gain = 3.0;
	max_scale = 30000.0;


/* COPY COMMAND LINE TO OUTPUT HEADER */

	        
/* PARSE COMMAND LINE  */


   for (i = 1 ; i < argc; i++) {



     if (debug == HELP)     
     	 break;

      switch (*argv[i]) {
	 case '-': 
	
	    switch (*(argv[i] + 1)) {

	       case 'f':
		  factor = atof(argv[++i]);
		  do_agc = 1;
		  break;

	       case 'd':
		  delay = atof(argv[++i]);
		  delay *= .001; /* msec */
		  break;
	
	       case 'l':
		  limit_gain  = atof(argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;

	       case 'N': 
  		  no_output_header = 1;		  
		  no_header = 1;
		  break;

	       case 'S': 
  		  swab_it = 1;		  

		  break;

	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
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
		  fprintf (stderr, "illegal options %s %s\n",argv[0],argv[i]);
		  debug = HELP;
		  break;
	    }
      }
   }


if (debug == HELP)
	sho_use();

   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


	strcpy(o_df.source,"\0");

	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }

        strcat(o_df.source, "\0");


/*      signal (SIGFPE, fpe_trap); */

   if (!i_flag_set)
             strcpy(in_file,"stdin");

dbprintf(0,"cvr start\n");

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	dbprintf(1,"not GASP header file\n");
   	exit(-1);
   	}
   }
   
   nc = (int) i_df.f[N];

      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
      
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


   if ( ((int) i_chn[0].f[SOD]) > 0)
   fposn = (int) i_chn[0].f[SOD];


   /* else start reading where header ends */
   /* sampling frequency */

   sf = i_chn[0].f[SF];

   /* Get sample start and stop times */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


 	o_df.f[N] = 1.0;

        n_chn[0].f[SF] = sf;
        n_chn[0].f[N] = (float) nsamples;        
	amp = 32767.0;
        n_chn[0].f[UL] = amp;                
        n_chn[0].f[LL] = -1.0 *amp;                        
	strcpy(n_chn[0].dtype,"short");

   if (!o_flag_set) 
       strcpy(out_file,"stdout");


	        o_df.f[SF] = sf;
      		o_df.f[FS] = 1.0 / sf;
      		o_df.f[FL] = 1.0 / sf;

      		o_df.f[LL] = -32767.0; /* 12 bit da range default */
      		o_df.f[UL]= 32767.0;


	if (no_output_header) {
	   if (o_flag_set) {
		if ( (fp = fopen(out_file,"w")) == NULL)
			exit(-1);
		} else
		fp = stdout;
	}
	else
        fp = gs_wrt_sf(out_file,&o_df,n_chn);

/*	MAIN LOOP   */

	opbufsize = 8192;

	loop = 0;

        more_input =1;

	dbprintf(1,"cvr start %d \n",opbufsize);

	n_agc = (int) (delay * sf);
	n = opbufsize;

dbprintf(0,"n_agc %d n %d\n",n_agc,n);

	while (more_input)  {

    eof = fread(Sbuf,  sizeof(short), opbufsize, i_df.fp); 

	  if ( eof == 0)  {
	   more_input = 0;

	  dbprintf(1,"END_OF_FILE\n"); 
	 	break;
	  }
	loop++;

dbprintf(0,"loop %d %d %d %d %d\n",loop,Sbuf[0],Sbuf[32],Sbuf[1024],Sbuf[2048]);
/*
	 for (kk = 1; kk < 256; kk += 10)
dbprintf(0,"kk %d %d \n",kk,Sbuf[kk]);
*/
	if (do_agc)
	gs_agc(Sbuf,opbufsize,n_agc,factor,limit_gain,max_scale,swab_it);

dbprintf(0,"loop %d %d %d %d %d\n",loop,Sbuf[0],Sbuf[32],Sbuf[1024],Sbuf[2048]);

/*
	 for (kk = 1; kk < 256; kk += 10)
dbprintf(0,"kk %d %d \n",kk,Sbuf[kk]);
*/

	 fwrite(&Sbuf[0], sizeof(short), opbufsize, fp);

	}	

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    close (fp);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


}

/* puts input signal from first filter thru a non-linearity */

am_nonl (array,r,v,npts)
float array[],r,v;
{
     int i;
	double k,base,v_pow;
	v_pow = (double)  v;
        for (i = 0; i< npts; i++) {
	if ( array[i] < 0.0 ) k = -1.0;
	else k = 1.0;
	base = k*array[i];
	if (base == 0.0)
	array[i] = 0.0;
	else
	array[i] = k * r * pow (base, v) ;
	}
}


int
gs_agc(sbuf,n,n_agc,factor,limit_gain,max_scale,swab_it)
short sbuf[];
int n,n_agc;
float factor;
float limit_gain;
float max_scale;
{
	static int init_state = 1;
	static int k = 0;
	int i,k2,jj;
	float gain;

	float lower_limit_gain = 0.01;
	float upper_limit, lower_limit;
	float floor = 0.000001;
	float new_value;

	short new_sbuf[16];


	static short *db;
	static float last_value = 0;
	int n_d1;
	static float rms;
	static double ss =0.0;
	
	FPE =0;
	
	dbprintf(0,"gs_agc %d %d %f\n",n,n_agc,factor) ;

dbprintf(0,"n %d %d %d %d %d\n",n,sbuf[0],sbuf[32],sbuf[1024],sbuf[2048]);


	if (n_agc >= 8192)
		n_agc = 8192; /* max size */

	if (n_agc <= 0)
		n_agc = 1;

	if (n <=0)
		return 0;

	gain = 1.0;


        if (init_state == 1) {
	for ( i= 0 ; i < n_agc ; i ++)
		agc_buf[i] = 0;
	k = 0;
	init_state = 0;
	db = &agc_buf[0];

	}

		upper_limit= (0.9 * max_scale);
		lower_limit = -1.0 * upper_limit;

/* keep running rms average use as wt for next point */

	for (i = 0; i < n ; i++) {

		if (swab_it) {
			swab(&sbuf[i],&new_sbuf[0],2);

			new_value = new_sbuf[0];
		}
		else
			new_value = sbuf[i];

		ss -= *db *  *db;

		ss +=   new_value * new_value ;

		*db++ = new_value;

dbprintf(2,"i %d ss %f f %f sbuf[i] %d \n",i,ss,gain,sbuf[i]);

		new_value =  gain * new_value;


		if (new_value > upper_limit ) {
dbprintf(1,"i %d ss %f f %f sbuf[i] %d %f\n",i,ss,gain,sbuf[i],last_value);
			new_value = upper_limit;
		}
		else if (new_value < lower_limit ) {
dbprintf(1,"i %d ss %f f %f sbuf[i] %d %f\n",i,ss,gain,sbuf[i],last_value);
			new_value = lower_limit;
		}

		sbuf[i] = (short) new_value;

		last_value = new_value;		
		k++;

		if ( k >= n_agc) {
			k = 0;
			db = &agc_buf[0];

dbprintf(2,"buffer wrap round\n");

	        }	

		rms = ss/ (float) n_agc;

		rms = sqrt(rms);

/* scale to max scale typically that for a 12 or 16 (32767) bit range */

		rms /= (float) (0.7 * max_scale);

		rms /= factor;

		if ( rms <= 0.0 )
				gain = 1.0;
		else {
				if ( rms < floor )
					gain = 0.0;
				else {
					gain = 1.0/rms;
				}
			}


			if ( gain > limit_gain)
				gain = limit_gain;

			else if ( gain < lower_limit_gain)
				gain = lower_limit_gain;

		}


dbprintf(1,"nrms %f f %f  %f\n",rms,gain,limit_gain);

	if (FPE)
	return 0;
	return 1;
}


sho_use ()
{
      fprintf (stderr, "-i [input_signal file (short int)] \n");
      fprintf (stderr, "-o [output_signal file (short int)] \n");
      fprintf (stderr, "-f multiplier\n");      
      fprintf (stderr, "-l max_gain\n");      
      fprintf (stderr, "-d window size (msec)\n");      
      fprintf (stderr, "-S swab bytes on input( for files written on different machines\n");      
      exit(-1); 
}






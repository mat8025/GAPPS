/****************************************************************************************
 	CNL
 
	Author 	Mark Terry 1987
 
 	This program will take as input either a multichannel vox or
 	track file and compute a compressive non_linear function
 
 	output to a multi_chn vox or multi_chn track  file
 	usage:   cnl -i [vox|track] -o outfile
 	-r  multiplier [20.0]
 	-v  power      [0.33]
	-i  vox or trk file input
	-o  trk (default) or Vox file
******************************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/*Define default constants */



int Vox;
float Rms[512];
float Fbuf[2048];
float    Pi2 = 6.283185307;
double   pow(),sin (), cos (), log (), log10 ();

int debug = 0; 
float    In_buf[MAX_IP_BUF];
channel   i_chn[128];

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;

   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   

   char in_file[120];
   char out_file[120];


   int job_nu = 0;   
   char start_date[40];

   char data_type[20];
   int no_header = 0;
   int offset = 0;
     
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

   short iodata;


/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   for (i = 1 ; i <= argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 'r':
		  r = atof(argv[++i]);
		  break;
	       case 'v':
		  v  = atof(argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
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



	       default: 
		  fprintf (stderr, "illegal options %s %s\n",argv[0],argv[i]);
		  exit (-1);
	    }
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

   if (no_header == 1) { 
   
   /* open input file  & seek (read in offset bytes) */

	if (!read_no_header(in_file,offset, data_type, sf, &i_df, &i_chn[0]))
	   exit(-1);
    }
   else {
      	if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	dbprintf(1,"not AUDLAB header file\n");
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

 strcpy(o_df.name,"CNL");
 strcpy(o_df.type,"CHANNEL"); 
 o_df.f[N] = 1.0 * nc;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);


	        o_df.f[SF] = sf;
      		o_df.f[FS] = 1.0 / sf;
      		o_df.f[FL] = 1.0 / sf;
      		o_df.f[N] = 1.0 * nsamples;
      		o_df.f[LL] = -2048.0; /* 12 bit da range default */
      		o_df.f[UL]= 2048.0;

	dbprintf(1,"headers \n");

		o_df.f[CN] = (float) (nc - 1);
        	sprintf(tag,"%f",o_df.f[CN]);
		strcpy(o_df.name,tag);

		gs_w_chn_head(&o_df);

/*   write each channel head */
	
	posn = gs_pad_header(o_df.fp);


/*	MAIN LOOP   */


	opbufsize = MAX_DF_BUF / nc;

	loop = 0;
        more_input =1;

	dbprintf(1,"cnl start %d \n",opbufsize);
	
	while (more_input)  {
	

          eof = read_m_chn(&i_chn[0],&In_buf[0],opbufsize);

	  if ( eof == 0)  {
	   more_input = 0;

	  dbprintf(1,"END_OF_FILE\n"); 
	 	break;
	  }
	loop++;
	dbprintf(1,"loop %d\n",loop);

	/*	compute non_lin */

        am_nonl(&In_buf[0],r,v,nc*opbufsize);

	    fwrite(In_buf, nc * opbufsize, sizeof(float),o_df.fp);

	}	

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);



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



sho_use ()
{
      fprintf (stderr, "-i [vox|track]  -o outfile\n");
       fprintf (stderr, "-r multiplier\n");      
      fprintf (stderr, "-v power\n");
	exit(-1); 
}


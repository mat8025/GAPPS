/*			LI

	simple lateral inihibitory simulation
	      serial version
	can specify left and right neighbour gains spacings
	and excitation gain of units in second layer
		 Mark Terry  87
*/


#include <gasp-conf.h>

#include  <stdio.h>
#include  <signal.h>
#include "df.h"
#include "sp.h"
#include  "trap.h"


float frand();

float Op[1024],Ip[1024];
double pow();
float ssr();

int debug = 0;
float In_buf[8192];
float L_buf[8192];


main(argc,argv)
int argc;
char *argv[];
{
   int job_nu = 0;   
   char start_date[40];
   
   data_file o_df,i_df;
   char sd_file[80];      

   char in_file[120];
   char out_file[120];

	float start, stop;
	float gain = 1.0;
	float l_gain = -0.5;
	float r_gain = -0.5;
        float sf,nf;
	float floor = 0.0;
	float noise_amp = 0.0;
	float rate;
	int nu_on = 1;
	int  nu_r_off= 1;
	int nu_l_off = 1;
	int apply_flr = 0;
	int n_li = 1;
	int q, j, k,m  ,nu_chn;
        int fposn =0;
        int i, posn;
   float  length;
   int eof;
   int loop = 0;
   int nframes;
   
	double pwr2,atof();
	float gs_g_noise();
	float minall,maxall,winms;
	float max =1.0;
	float min = 0.0;
        int   outfd ;
        int loud = 0;
        int nu_ic,npts,fp;
        int win_size,win_shft;


/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;


/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */
          
     for (i = 1; i < argc; i++)  {
     if (debug == HELP)     
     	 break;

		  switch(*argv[i])
			  {
			  case '-':
				  switch(*++(argv[i]))
				    {



				    case 'l':
				    	nu_l_off = atoi( argv[++i]);
				    	break;
				    		
				    case 'r':
				        nu_r_off = atoi (argv[++i]);
				        break;
				        	
				    case 'e':
				        nu_on = atoi (argv[++i]);
				        break;
				        
				    case 'L':
				        l_gain = atof (argv[++i]);
				        break;
				        
				    case 'R':
				        r_gain = atof (argv[++i]);
				        break;

				    case 'E':
				        gain = atof (argv[++i]);
				        break;
				    case 'N':
				        noise_amp = atof (argv[++i]);
				        break;
				    case 'F':
					apply_flr = 1;
				        floor = atof (argv[++i]);
				        break;

				    case 'I':
				    	n_li = atoi (argv[++i]);
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
			                        
	srand(7);
	
if (debug == HELP)
	sho_use();

   
  if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


   
   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (! gs_open_frame_file(in_file,&i_df))
   	exit(-1);

   	fposn = ftell(i_df.fp);


   	dbprintf(1,"end head at %d\n",fposn);

    
   length = i_df.f[STP] - i_df.f[STR];


   nframes = (int) i_df.f[N];



   	dbprintf(1,"duration %f\n",length);


   /* else start reading where header ends */
   /* sampling frequency */

   sf = 1.0 * (int) i_df.f[SF];
 
/* copy across some data from input to output headers */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


 strcpy(o_df.name,"LI");
 strcpy(o_df.type,"FRAME"); 

 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);
   
   o_df.f[VL] = i_df.f[VL];
   o_df.f[FS] = i_df.f[FS];
   o_df.f[FL] = i_df.f[FL];
   o_df.f[SF] = sf;
   o_df.f[MX] =  i_df.f[MX];
   o_df.f[MN] =  i_df.f[MN];   
   strcpy (o_df.x_d, "channel_nu");
   strcpy (o_df.y_d, i_df.y_d);
   o_df.f[LL] = 0.0;
   o_df.f[UL] = 1.0;
   o_df.f[N]= i_df.f[N];
   gs_w_frm_head(&o_df);   

   posn = gs_pad_header(o_df.fp);


/************* main loop for analysis *************/
	dbprintf(1,"lateral -inhibition  transformation\n");

   nu_chn = (int) i_df.f[VL];
   
   while (1) {

/* read the spectrum */

	eof = gs_read_frame(&i_df,In_buf);

	  if ( eof == 0)  {

	  dbprintf(1,"END_OF_FILE\n"); 
	 	break;
	  }


	
	for ( j = 0; j < nu_chn; j++ ) {

	for ( q = 0 ; q < n_li ; q++ ) {

	if (noise_amp > 0.0) 
	   In_buf[j] = noise_amp * gs_g_noise() + In_buf[j];

	if (apply_flr)
		if (In_buf[j] <= floor)
			  In_buf[j] = 0.0;

		rate = 0.0;
		m = j - nu_on / 2;

		if (m < 0 ) m = j;
		for ( k = 0 ; k < nu_on ;  k++ ) 
			rate += In_buf[m+k] *gain;
		/*	left off center */
			m= j - nu_on /2 - nu_l_off;

		if (m < 0 ) m = j;
		for ( k = 0 ; k < nu_l_off; k++)
			rate += In_buf[m+k] * l_gain;
		
	/*      right off center  */
			m= j + nu_on /2 ;
	        
	       if (m + nu_r_off > nu_chn -1) m = nu_chn -1 - nu_r_off;
	        
		for ( k = 0 ; k < nu_r_off; k++)
			rate += In_buf[m+k] * r_gain;
		Op[j] = rate;		

		if (apply_flr)
			if (Op[j] < floor)
				Op[j] = floor;
		if (Op[j] > max) max = Op[j];
		if (Op[j] < min) min = Op[j];
		
	}
	}
	


/* write out the results */
       gs_write_frame (&o_df, Op);


           ++loop;
	   }
/************** end of main loop *****************/


/*	CLOSE FILES    */

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


   dbprintf (1,"LI COMPLETED: %6d loops\n", loop);


}




sho_use()  
{
	  printf( " Usage: \n");
          printf(" -l left offset number[1]\n");
          printf(" -L left neighbour weighting [-0.5]\n");
          printf(" -r right offset number [1] \n");
          printf(" -R right neighbour weighting [-0.5]\n");
          printf(" -e on center number [1]\n");
          printf(" -E excitatory weighting [1.0]\n");
          printf(" -N noise floor amp [1.0]\n");
	  printf(" -F Floor  [0.0]\n");
	  printf(" -I  num of iterations of li  f\n");	  
	  printf(" -i infile -o outfile  \n");
	  exit (-1);
}


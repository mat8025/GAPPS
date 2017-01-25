/****************************************************************************************
        CETS
 
	Author 	Mark Terry 1989
 
 	This program will take as input  a multichannel file
	scale each channel
	apply threshold
	expand or compress
	rescale
 
 	output to a multi_channel file

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
channel   i_chn[32];

struct cet {
	float pre;
	float thres;
	float ce_pow;
	float post;
};

struct cet Scales[32];

main (argc, argv)
int   argc;
char *argv[];
{
   FILE *gs_wrt_sf(), *sfp;
   float cep();
   data_file o_df,i_df;

   char sd_file[80];      

   int fposn,posn,nc;
   int fsize;   

   char in_file[120];
   char out_file[120];
   char scale_file[120];   

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
   int i,j,n,k,l;
   int  loop;

   double   atof ();


/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;

   int  win_length = 256;
   float     sf = 16000.0;

   int start = 0;
   int more_input;
   int opbufsize;    
   int l_chn;
   int u_chn;
   int s_flag_set = 0;   
   float min = 0.0;
   float max = 1.0;
   float pre_factor = 20.0;
   float post_factor = 20.0;   
   float ce_pow = 0.33;
   float thres;

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

	       case 's': 
  		  s_flag_set = 1;		  
		  strcpy(scale_file,argv[++i]);
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
		     gs_get_date(start_date);
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
   	dbprintf(1,"not  header file\n");
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

 strcpy(o_df.name,"CETS");
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

		o_df.f[CN] = (float) (nc - 1);
        	sprintf(tag,"%f",o_df.f[CN]);
		strcpy(o_df.name,tag);

		gs_w_chn_head(&o_df);

/*   write each channel head */
	
	posn = gs_pad_header(o_df.fp);

/* set up mix scale  factors */




   if ( s_flag_set ) {
/* open file */
    sfp = fopen(scale_file,"r");
    if ( sfp == NULL ) {
    	dbprintf(1,"scale file error");
    	exit (-1);
   }
   eof = 0;

   while ( eof != 1 ) {
    /* read channel number  & scale */
     eof = fscanf(sfp,"%d %f %f %f %f",&i, &pre_factor, &thres, &ce_pow,&post_factor);
     
     if ( eof != 1 ) {

     Scales[i].pre = pre_factor;
     Scales[i].thres = thres;
     Scales[i].ce_pow = ce_pow;     
     Scales[i].post = post_factor;          

     }
     
     eof = feof( sfp);
     dbprintf(1,"scales %d pre %f t %f ce %f post %f %d\n",i,Scales[i].pre,thres,ce_pow,post_factor,eof);

    }

   }



/*	MAIN LOOP   */


	opbufsize = MAX_DF_BUF / nc;

        opbufsize = 16;
        
        n = opbufsize;

	
	loop = 0;
        more_input =1;

	
	dbprintf(1,"cnl start %d  nc %d\n",opbufsize,nc);

	
	while (more_input)  {
	

      eof = read_m_chn(&i_chn[0],&In_buf[0],opbufsize);

	  if ( eof == 0)  {
	   more_input = 0;

	  dbprintf(1,"END_OF_FILE\n"); 
	 	break;
	  }
	loop++;

	/* pre_scale */
		
        for (j = 0 ; j < n ; j++) {
	for (k = 0 ; k < nc ; k++ ) {	
	l = j * nc +k;
	dbprintf(1,"pre in %d %f %f\n",l,In_buf[l] ,Scales[k].pre  );
	In_buf[l] = In_buf[l] * Scales[k].pre  ;
	dbprintf(1,"pre out %d %f\n",l,In_buf[l]);
	        }
	}

        /* thres */

        for (j = 0 ; j < n ; j++) {
	for (k = 0 ; k < nc ; k++ ) {	
	l = j * nc +k;
	dbprintf(1,"cep in %d %f\n",l,In_buf[l]);
	if ( In_buf[l] > Scales[k].thres || In_buf[l] < ( -1.0 * Scales[k].thres)) {
	In_buf[l] = cep(In_buf[l],Scales[k].ce_pow)  ;
        }
	dbprintf(1,"out %f\n",In_buf[l]);	
        }
	}
	

	/* post_scale */
		
        for (j = 0 ; j < n ; j++) {
	for (k = 0 ; k < nc ; k++ ) {	
	l = j * nc +k;

	In_buf[l] = In_buf[l] * Scales[k].post  ;
	        }
	}
	

        fwrite(In_buf, nc * opbufsize, sizeof(float),o_df.fp);

	}	

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);



   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }


}


float
cep (a,v)
float a,v;
{
     int i;
	double k,base,v_pow;
	v_pow = (double)  v;
        
	if ( a < 0.0 ) k = -1.0;
	else k = 1.0;
	base = k*a;
	if (base == 0.0)
	a = 0.0;
	else
        a = k * pow (base, v_pow) ;

	return a;
}



sho_use ()
{


      fprintf (stderr, "cets -i multi_channel file -o single_channel file  -s scales\n");
      fprintf (stderr, "scales file containing scale factors for each channel e.g.\n");
      fprintf (stderr, "channel pre_scale thres pow_ratio post_scale e.g.\n");      
      fprintf (stderr, "0 0.5 1000.0 0.333 10.0\n");

	exit(-1); 
}


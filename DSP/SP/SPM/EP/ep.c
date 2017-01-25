
/*******************************************************************/

/*    This program detects the begining and end of actual speech   */
/*			in an utterance				   */

/*******************************************************************/

/*			Description of Parameters		   */
/*			-------------------------		   */


/*******************************************************************/



#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#define NPARAMS 3


/***	functions called    ***/

float min();
float av_energy();
float z_cross();



/**  define the constant parameters  **/

#define LENGTH 50000
#define FRAM_SIZE 100
#define FREQ 8000
#define SHIFT 50
#define SIL_DUR 1000
#define MAX_FRAMS 600
#define IF 25.



    
 /*-----------------------------------------------------------------*/


int debug = 0;
float In_buf[MAXWIN];

main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df,i_df;
   channel   i_chn[2];
   char sd_file[80];      

   int fposn,posn,nc;

   int job_nu = 0;   
   char start_date[40];


   char in_file[120];
   char out_file[120];
   char lab_file[120];
   char trk_file[120];   

   static  channel o_chn;   

   int last_sample_read =0;
   int new_sample = 0;
   int j,n,eof;

   int nsamples , npts , win_shift;
   
   int   winpts,  i,  k, loop, nloops, dp;
   int   nbytes, totpts;

   double   atof (), log10 ();
   float    params[NPARAMS], mins[NPARAMS], maxs[NPARAMS];


   float    start, stop, length; 

	int lab_num;
	char vgs_string[60], label[60], datafile[120];
   
	float data[LENGTH], s[SIL_DUR];
	int sil_frams, sil_pts;
	int m1, m2, n1, n2;
	float av_z_c, av_enrg, z_c[MAX_FRAMS], e[MAX_FRAMS];
	float speech[MAX_FRAMS];
	float tot_zc, tot_e, sqr_zc, mean_zc, sd_zc, mean_e;
	float i1, i2, izct, min_e, max_e, low_trh, high_trh;
	int begin_fram, end_fram, begin_samp, end_samp;
	float x1, x2, x[SIL_DUR];

	FILE *ofp;


/* DEFAULT SETTINGS */
   int i_flag_set = 0;
   int o_flag_set = 0;
   float    winms = 10.0;
   float  shfms = 10.0;
   float sil_dur = 125.;
   float     fs = 8000.0;
   


/*-----------------------------------------------------------------*/

/* parse command line variables */

   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {

	       case 'l': 
		  winms = atof (argv[++i]);
		  break;
	       case 'f': 
		  shfms = atof (argv[++i]);
		  break;
	       case 's': 
		  sil_dur = atof (argv[++i]);
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
	          debug = atoi( argv[++i]);
	          break;
	       default: 
		  fprintf (stderr, "illegal options %s %s\n",argv[0],argv[i]);
		  exit (-1);

	    }
	    break;
	 default: 
		  fprintf (stderr, "illegal options %s %s\n",argv[0],argv[i]);
		  exit (-1);
	    break;
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

   
   if (!i_flag_set)
             strcpy(in_file,"stdin");


   if ( read_sf_head(in_file,&i_df,&i_chn[0]) == -1) {
   	printf("not header file\n");
   	exit(-1);
   }


/*-----------------------------------------------------------------*/

/*   printf("df %d chn %d\n",i_df.fp,i_chn[0].fp);  */

   nc = 0;

   if ( (int) i_df.f[N] > 1) {

      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);

   }
 
   length = i_df.f[STP] - i_df.f[STR];
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = i_df.f[STP];   

   nsamples = (int) i_chn[0].f[N];

   if (length <=0.0) {
   	length = nsamples / i_chn[0].f[SF];
   	o_df.f[STP] = length;
   }

 
   	dbprintf(1,"duration %f\n",length);


   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];
/*
   if (strcmp(i_chn[nc].dfile,"@") != 0) {
	printf("dfile %s\n",i_chn[nc].dfile);
	strcpy(sd_file,i_chn[nc].dfile);
	fclose(i_df.fp);
   	i_df.fp = fopen( sd_file,"r");
   	fseek (i_df.fp, fposn, 0); 
   }  
*/
   /* else start reading where header ends */
   /* sampling frequency */

   fs = 1.0 * (int) i_chn[0].f[SF];
 
   gs_init_df(&o_df);
 
   o_df.f[STR] = 0.0;
   strcpy(o_df.name,"EP");
   strcpy(o_df.type,"CHANNEL"); 
   strcpy(o_df.x_d,"Time"); 
   o_df.f[N] = 1.0 * NPARAMS ;

/* copy across some data from input to output headers */

/* sampling frequency */

   o_chn.f[SF] = fs;
   
/* window size and shift params */

   winpts = (int) (winms * fs / 1000.0  + 0.5);

    dbprintf(1,"winpts: %d \n", winpts);

   o_chn.f[FL] = (float) winpts / fs;
   if (winpts < 1 || winpts > MAXWIN) {
      printf ("%s: window size out of range\n", argv[0]);
      exit (-1);
   }

   win_shift = (int) (shfms * fs /1000.0  + 0.5);

   o_chn.f[FS] = (float) win_shift / fs;

   if (win_shift < 1 ) {
      printf (" window shift out of range ep\n");
      exit (-1);
   }

   totpts = nsamples;
   sil_pts = sil_dur*fs/1000.;

   nloops = (totpts - winpts) / win_shift + 1;
   sil_frams = (sil_pts)/win_shift;
   totpts = winpts + (nloops - 1) * win_shift;
   o_chn.f[N] = nloops;
   

   o_chn.f[STP] = o_chn.f[STR] + (float) totpts / fs;

   
/* write out headers */

/* write general header */

	
   if (!o_flag_set) 
       strcpy(trk_file,"stdout");
   else{
   	strcpy(trk_file, out_file);
   	strcat(trk_file,".trk");
   }
   gs_o_df_head(trk_file,&o_df);

/* write channel headers */

   o_chn.fp = o_df.fp;
   
   strcpy(o_chn.dtype,"float");
   strcpy(o_chn.name,"RMS");
   o_chn.f[CN] = 0.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 1000.0;   
   strcpy(o_chn.dfile,"@");
   gs_w_chn_head(&o_chn);

   o_chn.f[CN] = 1.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 500.0;   
   strcpy(o_chn.name,"ZC");
   gs_w_chn_head(&o_chn);      

   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 1.0;   
   o_chn.f[CN] = 2.0;
   strcpy(o_chn.name,"speech");
   gs_w_chn_head(&o_chn);         

   posn = gs_pad_header(o_df.fp);


/*-----------------------------------------------------------------*/


/******* main while loop for analysis ********/


   dbprintf (1,"ENDPTS IN PROGRESS...\n");


   dbprintf (2,"winpts %d\n",winpts);

   npts = winpts;
   
	j = 0;
	n = npts;


/* FIRST PASS COMPUTE ENERGY & ZX */

   dp = 0;
   for (loop = 0; loop < nloops; loop++) {
	  
          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);
          last_sample_read += n;


/*   copy only new samples to data */
	  for ( i = 0 ; i < n ; i++) {
	  data[dp] = In_buf[j+i];
	  dp++;
	  }

	    z_c[loop] = z_cross(In_buf, winpts);   
            e[loop] = av_energy(In_buf, winpts);


       	 new_sample += win_shift;
	 gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,npts);

   }


/*-----------------------------------------------------------------*/


/* SET THRESHOLDS FOR WHOLE SIGNAL */


	
	for(i=0; i< sil_frams; i++){
	   tot_zc += z_c[i];	
	   tot_e += e[i];
	}
	
	mean_zc = tot_zc/((float) sil_frams); 
	mean_e = tot_e/((float) sil_frams);
	
	for(i=0; i<sil_frams; i++){
	   sqr_zc += (z_c[i]-mean_zc)*(z_c[i]-mean_zc);
	}
	sd_zc = sqr_zc/((float) sil_frams);
	sd_zc = sqrt((double) sd_zc);



/*-----------------------------------------------------------------*/


	/***	find the peak energy value   ***/
	
	max_e = 0.;
	for(i=0; i< nloops ; i++){
	    if(max_e < e[i])
	    	max_e = e[i];
	}

	/***  set the thresholds for zero crossings and energy  ***/


	    min_e = mean_e;
	    izct = min(IF, mean_zc+2.*sd_zc);
	    i1 = 0.03*(max_e - min_e) + min_e;
	    i2 = 4.*min_e;
	    low_trh = min(i1,i2);
	    high_trh = 5.*low_trh;

	if(low_trh > 250.){
	    low_trh = 250.;
	    high_trh = 1250.;
	    izct = 1.;	    
	}
	

	dbprintf(1,"izct: %f   low: %f   high: %f \n",izct,low_trh,high_trh);


/*-----------------------------------------------------------------*/

	/***	initial estimates of begining and end points	***/
	/***	based on enregy thesholds	***/
	

	/***	begining point	 ***/
	
	k = 0;			

	if(e[k] < high_trh){
	    
	    while(e[k] < low_trh){
		k = k+1;
	    }
	    begin_fram = k;
	    i = k+1;


	    while(e[i] < high_trh){
		
		if(e[i] < low_trh){
		    i = i+1;
		}
		else{
		    k = i;
		    while(e[k] < low_trh){
			k = k+1;
		    }
		    begin_fram = k;
		    i = k+1;
	   
		}
		
	    }


	}
	else{
	    
	    begin_fram = 0;
	    low_trh = 250.;
	    high_trh = 1250.;
	    izct = 1.;

	}



    dbprintf(1,"b_f: %d  l_t: %f  h_t: %f, zc_t: %f \n",begin_fram,low_trh,high_trh,izct);


	/***	end point     ***/


	k = nloops;

	if(e[k] < high_trh){

	    while(e[k] < low_trh){
		k = k-1;
	    }
	    end_fram = k;
	    i = k-1;


	    while(e[i] < high_trh){
		
		if(e[i] < low_trh)
		    i = i-1;
		else{
		    k = i;
		    while(e[k] < low_trh){
			k = k-1;
		    }
		    end_fram = k;
		    i = k-1;
	   
		}
		
	    }
			

	}
	else{
	    end_fram = nloops;
	}


	begin_samp = begin_fram*winpts;
	end_samp = end_fram*winpts;

/*------------------------------------------------------------------*/


	/**  SECOND PASS  **/


	/*** refine the end points using z-crossing threshold   ***/

	n1 = begin_fram - 10;
	n2 = end_fram + 10;
	m1 = 1;
	m2 = 1;


	/****	begining point	****/

	for(i=begin_fram; i>=n1; i--){
	    if(z_c[i] > izct){
		k = i;
		m1++;
	    }
	}

	if(m1 >= 3){
	    begin_fram = k;
	}


	/****	end point    ****/

	for(i=end_fram; i<n2; i++){
	    if(z_c[i] > izct){
		m2++;
		k = i;
	    }
	}

	if(m2 >= 3){
	    end_fram = k;
	}



/*------------------------------------------------------------------*/


	/**	set the speech array	 **/
	
	for(i=0; i<nloops; i++){
	    if(i<=end_fram && i>=begin_fram)
		speech[i] = 1.;
	    else
	    	speech[i] = 0.;		
	}
	
/*------------------------------------------------------------------*/
	
	begin_samp = (begin_fram)*winpts;
	end_samp = (end_fram)*winpts;
	

	dbprintf(1," %d     %d  \n",begin_samp,end_samp);

	for ( i = 0 ; i < nloops; i++ ) {

	params[0] = e[i];
	params[1] = z_c[i];
        params[2] = speech[i];
        	 
     fwrite ( params, sizeof(float), 3, o_df.fp); 

}


/*------------------------------------------------------------------*/
		
	
/* WRITE OUT LABEL FILE */


	/*	wrt label header */


	
	if (o_flag_set){
		strcpy(lab_file, out_file);
		strcat(lab_file,".lab");
		ofp = fopen(lab_file,"w");
	}
	else
		ofp = stdout;
		
	fprintf(ofp,"AL GENERIC 1.0\n");
	
	strcpy(datafile, in_file);
        gs_wrt_lab(ofp,"datafile",datafile,"*");	
        gs_wrt_lab(ofp,"start_of_data","384","bytes");
	sprintf(vgs_string,"%f",fs);
        gs_wrt_lab(ofp,"sample_freq",vgs_string,"Hz");
        gs_wrt_lab(ofp,"labeller","automatic"," ");        


    	/*	label   */
	lab_num = 1;
	strcpy(label,"s");
	sprintf(vgs_string,"%d",lab_num);
	gs_wrt_lab(ofp,"label",label,vgs_string);
	
    	/*	start_sample  */
	sprintf(vgs_string,"%d",begin_samp);
       	gs_wrt_lab(ofp,"s1",vgs_string,"H");

    	/*	stop_sample   */
	sprintf(vgs_string,"%d",end_samp);
       	gs_wrt_lab(ofp,"s2",vgs_string,"H");

  	
   if (o_flag_set)    
   	fclose(ofp);


/*------------------------------------------------------------------*/



/* end of main loop */

   dbprintf (1,"EP FINISHED...\n");


   if (i_flag_set)
   gs_close_df(&i_df);
      if (o_flag_set)
   gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}


/*******************************************************************/




/*******************************************************************/

/***		Function to compute the average energy		 ***/

/*******************************************************************/


float av_energy(x, num_samp)

    float x[];		/**  speech samples  **/
    int num_samp;	/**  number of samples per frame  **/



{
    

	int i, j;
	float avrag, sum;
	float xabs;
    	float ae;		/**  average energy returned	 **/


	/***	find the energy    ***/

	sum = 0.;

	for(i=0; i<num_samp; i++){
	    sum = sum + fabs((double) x[i]);

	}

	ae = sum/((float) num_samp);
	
	return(ae);
	

}


/*******************************************************************/




/*******************************************************************/

/***		Function to compute the average magnitude	 ***/

/*******************************************************************/


float av_mag(x, num_frams, fram_siz)

    float x[];		/**  speech samples  **/
    int num_frams;	/**  number frames for averaging  **/
    int fram_siz;	/**  number of samples per frame  **/



{
    

	int i, j, num_samp;
	float sum, avrag;
    	float am;		/**  average magnitude returned	 **/


	/***	find the average    ***/

	num_samp = num_frams*fram_siz;
	sum = 0.;

	for(i=0; i<num_samp; i++)
	    sum += x[i];

	avrag = sum/((float) num_samp);

	
	/***	find the average adjusted magnitude     ***/

	for(i=0; i<num_samp; i++)
	    am += fabs((double)(x[i]-avrag));
	am = am/((float) num_samp);

	
	return(am);
    	
}


/*******************************************************************/



/*******************************************************************/

/***		Function to compute the zero crossings		 ***/

/*******************************************************************/


float z_cross(x, num_samp)

    float x[];		/**  speech samples  **/
    int num_samp;	/**  number of samples per frame  **/



{
    
	int i, j;
	double x1, x2;
    float z_c = 0.0; /**  rate of zero crossings returned  **/


	for(j=0; j<num_samp; j++){

	     dbprintf(2,"sample %d %f\n ",j,x[j]);
	    if(x[j] != 0.0)
	    	x1 = (double) (x[j]/fabs((double) x[j]));
	    else
	    	x1 = 0.;
	    if(x[j+1] != 0)
	    	x2 = (double) (x[j+1]/fabs((double) x[j+1]));
	    else
	    	x2 = 0.;
	    z_c += fabs(x1- x2);
	}
/*	z_c = z_c/((float) (num_samp)); */

	return(z_c);

}



/********************************************************************/


    /****    Function to find the minimum    ****/


float min(x,y)

    float x,y;

{

    float minimum;

    if(x < y)
       minimum = x;
    else
      minimum = y;

    return(minimum);

}


/********************************************************************/










sho_use ()
{   
      printf ("Usage: ep [-l -f -s ] -i infile -o outfile \n");
      exit (-1);
}
   

/*********************************************************************/






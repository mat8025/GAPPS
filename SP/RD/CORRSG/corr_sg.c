

/*************************************************************************/

/**   This program computes the correlation between two spectrograms	**/

/*************************************************************************/

/*			Description of Parameters		   	 */
/*			-------------------------		   	 */

/*
	spec1[][]  -->  spectrogram 1  (2-d array)
	spec2[][]  -->  spectrogrma 2  (2-d array)
	spec_n1[][]  -->  normalized spectrogram 1  (2-d array)
	spec_n2[][]  -->  normalized spectrogram 2  (2-d array)
	corr[]  -->  correlation function  (1-d array)
	corr_peak  --> maximum value (peak) of correlation function (scalar)
	delay  -->  time delay between two signals i.e. time at peak
		    correlatin  - scalar
	
	start, finish  --> time interval to correlate (scalar)
	time_off  --> time offset to correlate
	max_freq  --> maximum frequency in Hz. of the sprectrum considered
	low_freq, high_freq  --> frequency range in Hz. of the spectrum used
	

									 */

/****	rest of the variables are dummy variables    ****/

/*************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <signal.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

/**  define the constant parameters  **/

#define NPARAMS 2
#define Max_Fram 1000
#define Max_FFT 256


    FILE *fopen(), *ofp, *sfp;

    int debug = 0;
    float In_buf[8192];
    

/*-----------------------------------------------------------------------*/


main (argc, argv)
int   argc;
char *argv[];
{

   data_file o_df, i1_df, i2_df;
   channel   i_chn[2];
   static  channel o_chn;   
      
   char s1_file[120];
   char s2_file[120];
   char out_file[120];
   char trk_file[120];   
   char corr_file[120];   
   float    params[NPARAMS];
   
   int nframes,n_frames;
   int fposn,posn,nc;
   int pid ,fsize;   

   int job_nu = 0;   
   char start_date[40];



/*-------------------------------------------*/


   int nloops;
   int n_temp_frames, n_targ_frames;
   int nsamples , npts;
   int   nbytes, totpts;

   float fram_shift;
   float  length;
   
   double   atof (), log10 ();
   int eof;



/*--------------------------------------------*/



/* DEFAULT SETTINGS */

   int s1_flag_set = 0;
   int s2_flag_set = 0;
   int o_flag_set = 0;
   int s_flag_set = 0;
   int f_flag_set = 0;
   int t1_flag_set = 0;
   int t2_flag_set = 0;
   int t_flag_set = 0;   

   int last_sample_read =0;
   int new_sample = 0;
   int   mode = 1;
   int   time_shift = 0;
   int sp_cnt = 0;
   float sf = 16000.0;     

   float k_f = 1.0;
   float low_freq = 0.;
   float high_freq = 8000.;
   float max_freq = 8000.;
   int fft_size = 256;



/*--------------------------------------------*/


   int i, j, k, n, t, ioff;
   int i1, i2;
   int nscale1, nscale2, scale1[Max_Fram], scale2[Max_Fram];
   float avg1, avg2, rms1, rms2, sum;
   float fq_bin_sz;
   float start, finish, time_off;
   float sc_factor, sc_fac1, sc_fac2, corr_peak, delay;
   int low_fq_bin, high_fq_bin, num_fq_bins;
   int max_offset, num_tm_bins;
   int start_fram, end_fram, seg_len;
   int first_fram, last_fram;
      
   float t1, t2;
   float sf1, sf2;

   float spec1[Max_Fram][Max_FFT], spec2[Max_Fram][Max_FFT];

/*   float spec_n1[Max_Fram][Max_FFT], spec_n2[Max_Fram][Max_FFT]; */

   float corr[2*Max_Fram];
   
  

/*******************************************************************/


/* parse command line variables */

   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {


	       case 'i': 
  		  s1_flag_set = 1;		  
		  strcpy(s1_file,argv[++i]);
		  break;
	       case 's': 
  		  s2_flag_set = 1;		  
		  strcpy(s2_file,argv[++i]);
		  break;		  
	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;
		  
	       case 'k': 
		  k_f = atof (argv[++i]);
		  break;
	       case 'l': 
		  low_freq = atof (argv[++i]);
		  break;
	       case 'h': 
		  high_freq = atof (argv[++i]);
		  break;		 
	       case 'b':  /* template start */
		  start = atof (argv[++i]);
		  s_flag_set = 1;
		  break;		 
	       case 'e': /* template end */
		  finish = atof (argv[++i]);
		  f_flag_set = 1;
		  break;
	       case 't': 
		  time_off = atof (argv[++i]);
		  t_flag_set = 1;
		  break;		 
	       case 'x': /* target */
		  t1 = atof (argv[++i]);
		  t1_flag_set = 1;
		  break;		 
	       case 'y': 
		  t2 = atof (argv[++i]);
		  t2_flag_set = 1;
		  break;
		  
	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date);
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
	debug_spm(argv[0], debug, job_nu);

        signal (SIGFPE, fpe_trap);

/*------------------------------------------------------------------*/


   /**	check for two spectral files   **/
   
   if (s1_flag_set)
       sp_cnt++;
   if (s2_flag_set)
       sp_cnt++;
      
   if (sp_cnt != 2){ 
	fprintf (stderr, " **** needs two spectrograms  ***\n");
	exit (-1);      
   }
   
              
/*------------------------------------------------------------------*/


   /**	read the header for the first Spec. file  
    **  i.e target
    **/
   
   if (! gs_open_frame_file(s1_file,&i1_df))
   	exit(-1);


   fposn = ftell(i1_df.fp); 
   length = i1_df.f[STP] - i1_df.f[STR];
   n_targ_frames = (int) i1_df.f[N];

   /* sampling frequency */

   sf1 = 1.0 * (int) i1_df.f[SF];
	      
   /**	read the header for the second Spec. file
    **  i.e. template 
    **/


   if (! gs_open_frame_file(s2_file,&i2_df))
   	exit(-1);


   fposn = ftell(i2_df.fp); 
   length = i2_df.f[STP] - i2_df.f[STR];
   n_temp_frames = (int) i2_df.f[N];
   fft_size = (int) i2_df.f[VL];
   fft_size = 2*(fft_size-1);
   fram_shift = i2_df.f[FS];


   /* sampling frequency */

   sf2 = 1.0 * (int) i2_df.f[SF];
   
   /**   check for the sampling frequencies  **/
            
   if (sf1 != sf2){ 
	fprintf (stderr, " **** unequal smapling frequencies  ***\n");
	exit (-1);      
   }
   else
   	sf = sf1;
 
/*-------------------------------------------------------------------*/


   /**	 headers for OUTPUT FILE   **/
   
   strcpy(o_df.source,"\0");
   for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
   }
   strcat(o_df.source, "\0");


   /**  write out headers  **/

	if(t_flag_set == 1){
	    max_offset = time_off/fram_shift;
	}
   
 
	/**	compute the first and last frames of spec # 1	**/
	
	start_fram = start/fram_shift;

	if(start_fram < 0. || s_flag_set != 1)
	   start_fram = 0;

	end_fram = finish/fram_shift;
	if(end_fram > n_targ_frames || f_flag_set != 1)
	   end_fram = n_targ_frames - 1;
	   
	seg_len = end_fram - start_fram;

	if (max_offset >= n_targ_frames)
	    max_offset = start_fram;	   

	if(t1_flag_set == 1){
	    first_fram = t1/fram_shift;
	}
	else{
	    first_fram = -max_offset + start_fram;
	}

	if(first_fram < 0){
		first_fram = 0;
	}
	
	if(t2_flag_set == 1){
	    last_fram = t2/fram_shift;
	}
	else{
	    last_fram = max_offset+start_fram;
	}
	
	if(last_fram > n_temp_frames){
		last_fram = n_temp_frames - 1;
	}
	    

   gs_init_df(&o_df);
 

   o_df.f[STR] = (first_fram -start_fram ) * fram_shift;
   o_df.f[STP] = (last_fram - start_fram) * fram_shift;


   strcpy(o_df.name,"CORR");
   strcpy(o_df.type,"CHANNEL"); 
   strcpy(o_df.x_d,"Time"); 
   o_df.f[N] = 1.0 * NPARAMS ;


   /**  write general header **/
	
   if (!o_flag_set) 
       strcpy(trk_file,"stdout");
   else{
   	strcpy(trk_file, out_file);
   	strcat(trk_file,".trk");
   }
   gs_o_df_head(trk_file,&o_df);


   /**  write channel headers  **/

   o_chn.fp = o_df.fp;
   
   strcpy(o_chn.dtype,"float");
   strcpy(o_chn.name,"X");
   o_chn.f[CN] = 0.0;
   o_chn.f[LL] = first_fram;
   o_chn.f[UL] = last_fram;
   o_chn.f[N] = 2*max_offset+1;
   o_chn.f[FS] = 1.0;
   o_chn.f[FL] = 1.0;
   strcpy(o_chn.dfile,"@");
   gs_w_chn_head(&o_chn);

   o_chn.f[CN] = 1.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 2.0;   
   strcpy(o_chn.name,"Y");
   gs_w_chn_head(&o_chn);      


   posn = gs_pad_header(o_df.fp);


/*************************************************************************/



/* set floating point exception trap */


    n_frames = 0;
    while (1) {

	/**  read the spectrum  **/

	eof = gs_read_frame(&i1_df,In_buf);


	  if ( eof == 0)  {
	    dbprintf(2,"END_OF_FILE\n"); 
	 	break;
	  }

	n = (int) i1_df.f[VL];
	
	for(i=0; i<n; i++)
	    spec1[n_frames][i] = In_buf[i];
	
        n_frames++;

	for(i=0; i<n; i++)
            dbprintf(2," %f   %f \n",In_buf[i], spec1[n_frames-1][i]);

    }
    
    nframes = n_frames;    

/*-------------------------------------------------------------------*/

    n_frames = 0;
    while (1) {

	/**  read the spectrum  **/

	eof = gs_read_frame(&i2_df,In_buf);


	  if ( eof == 0)  {
	     dbprintf(2,"END_OF_FILE\n"); 
	 	break;
	  }

	n = (int) i2_df.f[VL];
	


	for(i=0; i<n; i++)
	    spec2[n_frames][i] = In_buf[i];
	n_frames++;

	for(i=0; i<n; i++)
            dbprintf(2," %f   %f \n",In_buf[i], spec2[n_frames-1][i]);

    }
    
    nframes = n_frames;    


/*-------------------------------------------------------------------*/


	dbprintf (1,"CORR IN PROGRESS...\n");


/*------------------------------------------------------------------*/


	/***	compute the frequency range of intersect	***/
	

	max_freq = k_f*sf/2.;
	
	    
	if(high_freq < low_freq || high_freq > max_freq)
	    high_freq = max_freq;

	if(low_freq > max_freq)
	    low_freq = 0.;

	/***	compute the number of frequncey bins	***/
	
	fq_bin_sz = sf/(float) fft_size;
	low_fq_bin = low_freq/fq_bin_sz;
	high_fq_bin = high_freq/fq_bin_sz;


	num_fq_bins = high_fq_bin - low_fq_bin;
	

	dbprintf(1,"freq_bin: %d \n",num_fq_bins);

/*------------------------------------------------------------------*/

	/***	Normalize the spectrum along the freq.   ***/

	
	/***	initialize   ***/

	nscale1 = 0;
	nscale2 = 0;
	for(i=0; i<nframes; i++){
	    scale1[i] = 0;
	    scale2[i] = 0;
	}
	    

	for(i=0; i<nframes; i++){
	

	    /***   subtract the average value	***/
	    	
	    avg1 = 0.;
	    avg2 = 0.;
	    for(j=low_fq_bin; j<high_fq_bin; j++){
		avg1 += spec1[i][j];
		avg2 += spec2[i][j];
	    }
		
	    avg1 = avg1/(float) num_fq_bins;
	    avg2 = avg2/(float) num_fq_bins;
	    
	    for(j=low_fq_bin; j<high_fq_bin; j++){
	    	spec1[i][j-low_fq_bin] = spec1[i][j] - avg1;
	    	spec2[i][j-low_fq_bin] = spec2[i][j] - avg2;
	    }
	    	
	    
	   
	    /***   scale by the rms value   ***/
	    	  
	    rms1 = 0.;
	    rms2 = 0.;
	    for(j=0; j<num_fq_bins; j++){
		rms1 += spec1[i][j]*spec1[i][j];
		rms2 += spec2[i][j]*spec2[i][j];
	    }
		
	    rms1 = rms1/(float) num_fq_bins;
	    rms2 = rms2/(float) num_fq_bins;
	    
	    if(rms1 > 0.000001){
	    	nscale1++;
	    	scale1[i] = 1;
	    	rms1 = sqrt((double) rms1);
	    	
	    	for(j=0; j<num_fq_bins; j++)
	    	   spec1[i][j] = spec1[i][j]/rms1;
	    }
	    

	    
		
		
	    if(rms2 > 0.000001){
	    	nscale2++;
	    	scale2[i] = 1;
	    	rms2 = sqrt((double) rms2);
	    	
	    	for(j=0; j<num_fq_bins; j++)
	    	    spec2[i][j] = spec2[i][j]/rms2;
	    }
	    

	

	}
	


	/***	check for null frequency columns    ***/
	
	if(nscale1 == 0){
	   printf(" ***** First spectrum is Null Spectrum  ***** \n");
	   exit(-1);
	}
	
	if(nscale2 == 0){
	   printf(" ***** Second spectrum is Null Spectrum  ***** \n");
	   exit(-1);
	}
	


	/***	scale for unity autocorrelation	  ***/
	
	sc_fac1 = ((float) nframes)/((float) nscale1);
	sc_fac1 = sqrt((double) sc_fac1);
	sc_fac2 = ((float) nframes)/((float) nscale2);
	sc_fac2 = sqrt((double) sc_fac2);
	
	
	for(i=0; i<nframes; i++){
		
	    if(scale1[i]){
	    	for(j=0; j<num_fq_bins; j++)
	    	    spec1[i][j] = sc_fac1*spec1[i][j];
	    }
	    
	    if(scale2[i]){
	    	for(j=0; j<num_fq_bins; j++)
	    	    spec2[i][j] = sc_fac2*spec2[i][j];
	    }
	    
	}
	


/*------------------------------------------------------------------*/




  
/*------------------------------------------------------------------*/



	/***  find the correlation between two spectra	 ***/
	


	/***	initialize    ***/
	
	for(t=0; t<2*nframes; t++)
	    corr[t] = 0.;


	/**	compute the first and last frames of spec # 2	**/
	    	    
	/***   compute the correlation array   ***/ 
	    

	for(ioff= first_fram; ioff<=last_fram; ioff++){
		
	    i1 = start_fram;	
	    i2 = ioff;

	    if(i2 < 0)
	       i2 = 0;
	    if(i2 > nframes)
	       i2 = nframes;
	       	    
	    num_tm_bins = seg_len;


	    dbprintf(1,"time_bins: %d \n",num_tm_bins);
	    
	    
	    sum = 0.;
	    for(i=0; i<num_tm_bins; i++){
	    	for(j=0; j<num_fq_bins; j++)
	    	    sum += spec1[i+i1][j]*spec2[i+i2][j];
	    }


	    t = ioff - first_fram;
	    sc_factor = (float) num_tm_bins * (float) num_fq_bins;
	    if(sc_factor != 0)
	    	corr[t] = sum/sc_factor;
	    else
	    	corr[t] = sum;
	}
	


/*------------------------------------------------------------------*/



	/***	find the correlation peak   ***/
	
	
	corr_peak = 0.;	
	for(i= first_fram; i<=last_fram; i++){
		
	    t = i - first_fram;
	    if(corr_peak <= corr[t]){
	    	corr_peak = corr[t];
	    	delay = i - start_fram;
	    }
	    
	}
	    	


/*------------------------------------------------------------------*/








/*-------------------------------------------------------------------*/



/* WRITE OUT RESULT FILE */


	for ( i = first_fram; i <= last_fram; i++ ) {
	    params[0] = (float) (i-start_fram) * fram_shift;
	    params[1] = corr[i-first_fram];
	    
     	    fwrite ( params, sizeof(float), 2, o_df.fp); 
	}
        	 




	/*  write the result of recognition  */


	if (o_flag_set){
		strcpy(corr_file, out_file);
		strcat(corr_file,".dat");
		ofp = fopen(corr_file,"w");
	}
	else
		ofp = stdout;
		
	fprintf(ofp," corrlation peak:  %f \n",corr_peak);
	fprintf(ofp," delay at peak corr.:  %f  secs. \n",delay*fram_shift);

	

	if (o_flag_set){
	    fclose(ofp);	    
	}


/*------------------------------------------------------------------*/



/* end of main loop */


   dbprintf (1,"CORR FINISHED...\n");


   if (s1_flag_set)
      gs_close_df(&i1_df);
   if (s2_flag_set)
      gs_close_df(&i2_df);

   if (o_flag_set)
      gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }




}


/*******************************************************************/



 




sho_use ()
{   

 printf("Usage: corr [-k -l -h -t -b -e -x -y] -i spec_file1 -s spec_file2 -o outfile \n");


   fprintf(stderr,"-t   offset (secs) +/- template start \n");
fprintf(stderr,"use -t as  alternative to specifying x & y flags \n");   
   fprintf(stderr,"-l   lowest frequency (Hz) \n");
   fprintf(stderr,"-h   highest frequency (Hz) \n");
   fprintf(stderr,"-b	template start secs\n");
   fprintf(stderr,"-e	template end   secs\n");   
   fprintf(stderr,"-x	target start   secs\n");
   fprintf(stderr,"-y	target end     secs\n");   
      exit (-1);
}


/*********************************************************************/





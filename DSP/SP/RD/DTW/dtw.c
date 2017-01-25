

/***************************************************************************/

/**   This program implements the Dynamic Time Warping algorithm for
		    isolated word recognition.				 **/

/**************************************************************************/

/*			Description of Parameters			  */
/*			-------------------------			  */


/*	    Num_Temp --> Number of templates to be matched with 
			 input pattern (scalar)
	    Max_Fram --> Number of frames in the longest template
			 (scalar)
	    Input_Frames --> Number frames in the input pattern (scalar)
	    Num_Feature --> Number of entries in each feature vector
			    (scalar)					 
	    num_tmp_fram --> Number of frames in each template
			     (a one-dimensional vector)
	    templ --> feature vectors for all the templates
		      (a three-dimensional array)
	    input --> input feature vectors (a two-dimensional array)
	    accum_dist --> accumulated distances along the warping paths
			    (a two-dimensional array)
	    temp_score --> score for the templates (a one-dim. array)
	    d --> distance between any two frames (a two-dim. array)
	    path_i, path_j --> coordinates of the optimum warping path
				(two-dimensional arrays)
	    min_score --> minimum score (score for best matching template)
	    temp_opt --> best matching template number saclar)		   */

	    /***	rest of the variables are dummy variables   ***/



/*************************************************************************/



#include <gasp-conf.h>

#include <stdio.h>
#include <signal.h>
#include "df.h"
#include "sp.h"


/***	functions called    ***/

float min();
float dist();



/**  define the constant parameters  **/

#define NPARAMS 2
#define Num_Temp 11
#define Num_Input 500
#define Max_Fram 200
#define Input_Fram 400
#define Num_Feature 6
#define Num_Dig 11
#define Dig_Temp 1
#define Large 100000.
#define Index 0
#define ERROR -1




static char digit[11]={
    '1','2','3','4','5','6','7','8','9','o','z'
};
char dig[Num_Temp], dig_strng[20];
int i,j,k,kk,Nt,M,itemp,in_temp,i1,i0,last;
int num_tmp_fram[Num_Temp],input_fram, num_input,repeat;
int num_feature;
float templ[Num_Temp][Max_Fram][Num_Feature];
float input[Input_Fram][Num_Feature];
float ratio,diff,slop_1,slop_2,s_0,s_1,s_2,l,u,sum;
float accum_dist[Input_Fram][Max_Fram];
float temp_score[Num_Temp],min_score;
float d[Input_Fram][Max_Fram],f_i[Num_Feature],f_j[Num_Feature];
int j_opt,Nt_opt, temp_opt,k_max,range[Max_Fram];
int path_i[Num_Temp][Input_Fram],path_j[Num_Temp][Input_Fram];
int indicate;

FILE *fopen(), *data_temp, *ofp, *sfp;

void   breaker (int sig);
int brktrp;
int debug = 0;
float In_buf[8192];
    

/*-----------------------------------------------------------------------*/



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

/*----------------------------------------*/


   int pid ,fsize;   

   char data_type[20];
   int no_header = 0;
   int offset = 0;
   float sf = 8000.0;     
   float  length;

   int   mode = 1;
   int   time_shift = 0;
   int nloops;
   

   int nframes, n_frames;
   char  buf[32];


/*--------------------------------------------*/

   char in_file[120];
   char out_file[120];
   char path_file[120];
   char dig_file[120];
   char score_file[120];   

   static  channel o_chn;   

   int last_sample_read =0;
   int new_sample = 0;
   int j,n,eof;

   int nsamples , npts;
   int   nbytes, totpts;

   double   atof (), log10 ();
   float    params[NPARAMS];



/* DEFAULT SETTINGS */

   int i_flag_set = 0;
   int o_flag_set = 0;
   int num_coefs = 6;
   float     fs = 8000.0;
   



/*-----------------------------------------------------------------*/


/* parse command line variables */

   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {

	       case 'n': 
		  num_coefs = atoi (argv[++i]);
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
   	debug_spm(argv[0],debug,job_nu) ;




/*********************************************************************/

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");
	        
/* PARSE COMMAND LINE  */


   
   if (!i_flag_set)
             strcpy(in_file,"stdin");

   if (! gs_open_frame_file(in_file,&i_df))
   	exit(-1);

   	fposn = ftell(i_df.fp);
 
   length = i_df.f[STP] - i_df.f[STR];


   nframes = (int) i_df.f[N];




   /* else start reading where header ends */
   /* sampling frequency */

   fs = 1.0 * (int) i_df.f[SF];
 
/*------------------------------------------------------------------------*/
 
/* write out headers */


 gs_init_df(&o_df);
 
 o_df.f[STR] = 0.0;
 strcpy(o_df.name,"DTW");
 strcpy(o_df.type,"CHANNEL"); 
 strcpy(o_df.x_d,"Time"); 
 o_df.f[N] = 1.0 * NPARAMS ;

/* write general header */

	
   if (!o_flag_set) 
       strcpy(path_file,"stdout");
   else{
   	strcpy(path_file, out_file);
   	strcat(path_file,".trk");
   }
   gs_o_df_head(path_file,&o_df);


/* write channel headers */

   o_chn.fp = o_df.fp;
   
   strcpy(o_chn.dtype,"float");
   strcpy(o_chn.name,"X");
   o_chn.f[CN] = 0.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 200.0;   
   o_chn.f[N] = nframes;
   o_chn.f[FS] = 1.0;
   o_chn.f[FL] = 1.0;
   strcpy(o_chn.dfile,"@");
   gs_w_chn_head(&o_chn);

   o_chn.f[CN] = 1.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 200.0;   
   strcpy(o_chn.name,"Y");
   gs_w_chn_head(&o_chn);      


   posn = gs_pad_header(o_df.fp);


/*************************************************************************/


/* set floating point exception trap */

   brktrp  = 0;
   signal (SIGFPE, breaker);


   dbprintf (1,"DTW IN PROGRESS...\n");

    n_frames = 0;
    while (1) {

/* read the spectrum */

	eof = gs_read_frame(&i_df,In_buf);


	  if ( eof == 0)  {

	  dbprintf(2,"END_OF_FILE\n"); 
	 	break;
	  }

	n = (int) i_df.f[VL];
	


	for(i=0; i<n; i++)
	    input[n_frames][i] = In_buf[i];
	n_frames++;



    }
    
    input_fram = n_frames;    




/*-------------------------------------------------------------------------*/


   /********  read the data from the file *********/

	/***	template data	 ***/

   	if((data_temp = fopen("temp.dat", "r")) == NULL){
	    printf("\n\n ---- Can not open file 'temp.dat' ---- \n\n");
	    return(ERROR);
	}

   	for(i=0; i<Num_Temp; i++) {
	    fscanf(data_temp, "%d", &num_tmp_fram[i]);
	    for(j=0; j<num_tmp_fram[i]; j++){
	        for(k=0; k<Num_Feature; k++){
		    fscanf(data_temp, "%f", &templ[i][j][k]);
		}
	    }
	}

   	fclose(data_temp);




/*-------------------------------------------------------------------------*/


	for(i=0; i<Num_Dig; i++){
	    for(j=0; j<Dig_Temp; j++)
		dig[i*Dig_Temp+j] = digit[i];
	}


 /*-----------------------------------------------------------------------*/


    /***    Start the Dynamic Time Warping   ***/


    num_feature=Num_Feature-1;


      min_score = Large;
      M = input_fram;

      for(itemp=0; itemp<Num_Temp; itemp++){ 


	
	/***	check the criteria for skipping the templates   ***/
	
	Nt = num_tmp_fram[itemp];
	ratio = ((double) Nt)/((double) M);
	diff = (((double) Nt)-((double) M));


/*	
	if(ratio >= 2.){
	    printf(" \n\n --- digit spoken is too short ! --- \n\n");
	    exit(ERROR);
	}

	if(ratio <= 0.5){
	    printf(" \n\n --- digit spoken is too long ! --- \n\n");
	    exit(ERROR);
	}
*/


	if(ratio>=1.978 || ratio<=.505){
	    l=0.15;
	    u=20.0;
	}
	else{
	    l=0.5;
	    u=2.0;
	}
	if(ratio>=2.0)
	    repeat = 5;
	else
	    repeat = 2;



	/***	Initialization	 ***/

	accum_dist[0][0] = 0.;
	for(i=1; i<Nt; i++)
	    accum_dist[i][0] = Large;
	for(j=1; j<M; j++)
	    accum_dist[0][j] = Large;
	temp_score[itemp] = Large;
	path_i[itemp][0] = 0;
	path_j[itemp][0] = 0;


	/***	Find the optimum path	***/
   
	for(i=1; i<Nt-1; i++){

	    k=0;
	    for(j=1; j<M-1; j++){


		/***	Find the area for warping path	 ***/

		temp_score[itemp] = Large;
		slop_1 =((double) j)/((double) i);
		slop_2 = ((double) (M-1-j))/((double) (Nt-1-i));


		
		if(slop_1>=l && slop_1<=u && slop_2>=l && slop_2<=u){
		    range[k] = j;
		    k = k+1;
		}
		else

		    accum_dist[i][j] = Large;

	    }

	    k_max = k-1;



	    /***    compute the accumulated distance	***/
	    
	    for(j=range[0]; j<=range[k_max]; j++){
		    

		for(k=0; k<num_feature; k++){
		    f_j[k] = input[j][k+1];
		    f_i[k] = templ[itemp][i][k+1];
		}


		d[i][j] = dist(f_i,f_j,num_feature);
	    
		s_0 = accum_dist[i-1][j] + d[i][j];
		if((j-1)>=0)
		    s_1 = accum_dist[i-1][j-1] + d[i][j];
		else
		    s_1 = Large;
		if((j-2)>=0)
		    s_2 = accum_dist[i-1][j-2] + d[i][j];
		else
		    s_2 = Large;

		accum_dist[i][j] = min(min(s_0,s_1),s_2);



		/***	determine the optimum path   ***/

		kk = path_j[itemp][i-1];
		if(ratio>=1.985 || ratio<=0.495)
		    last = M-2;
		else
		    last = kk+2;

		if(j>=kk && j<=last){

		    if(i>=repeat){
			
			if(path_j[itemp][i-1] == j){
			    if(path_j[itemp][i-repeat] != j)
				indicate = 1;
			    else
				indicate = 0;
			}
			else
			    indicate = 1;
		    
		    }
		    else 
			indicate = 1;

			
		    if(indicate == 1){
			
			if((temp_score[itemp]-accum_dist[i][j]) > 0.)
			    j_opt = j;
			temp_score[itemp] = min(temp_score[itemp],accum_dist[i][j]);

		    }


		}


	    }

	    path_i[itemp][i] = i;
	    path_j[itemp][i] = j_opt;

	}


	path_i[itemp][Nt-1] = Nt-1;
	path_j[itemp][Nt-1] = M-1;



	/***	find the minimum total score and matched template   ***/

	temp_score[itemp] = temp_score[itemp]/((float) Nt);
	if((min_score-temp_score[itemp]) > 0.){
	    temp_opt = itemp;
	    Nt_opt = Nt;
	}
	min_score = min(min_score,temp_score[itemp]);



	
    }	    





/*-------------------------------------------------------------------------*/



/* WRITE OUT RESULT FILE */


	for ( i = 0 ; i < Nt_opt; i++ ) {
	    params[0] = (float) path_i[temp_opt][i];
	    params[1] = (float) path_j[temp_opt][i];
	    
     	    fwrite ( params, sizeof(float), 2, o_df.fp); 
	}
        	 




	/*  write the result of recognition  */


	if (o_flag_set){
		strcpy(dig_file, out_file);
		strcat(dig_file,".dat");
		ofp = fopen(dig_file,"w");
		strcpy(score_file, out_file);
		strcat(score_file,".sc");
		sfp = fopen(score_file,"w");
	}
	else
		ofp = stdout;
		
	fprintf(ofp,"%c\n",dig[temp_opt]);

	
	fprintf(sfp,"Score for all the digits:   \n\n");
	kk = 1; 
	for(itemp=0; itemp<Num_Temp; itemp++){
	    if(kk == 4){
		fprintf(sfp,"  %f   \n",temp_score[itemp]);
		kk = 1;
	    }
	    else{
		fprintf(sfp,"  %f  ",temp_score[itemp]);
		kk = kk + 1;
	    }
	}
	fprintf(sfp,"\n");
	fprintf(sfp,"Min_Score:  %f      Digit:  %c   \n\n",min_score,dig[temp_opt]);
  	
	if (o_flag_set){
	    fclose(ofp);	    
	    fclose(sfp);
	}


/*------------------------------------------------------------------*/



/* end of main loop */


   dbprintf (1,"DTW FINISHED...\n");


   if (i_flag_set)
   gs_close_df(&i_df);
      if (o_flag_set)
   gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }




}


/*******************************************************************/





	   



/************************************************************************/


    /****   Function to compute the Eucledian Distance between 
	    two feature vectors (input & reference)		****/


float dist(in,test,nf)

    int nf;
    float in[],test[];

{

    int i;
    float d;
    
    d = 0;
    for(i=0; i<nf; i++){
	d = d + (in[i]-test[i])*(in[i]-test[i]);
    }

    return(d);
}



/************************************************************************/


    /****   Function to find the minimum of two numbers	    ****/

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


/***********************************************************************/


 

/* return negative value if floating point exception trapped */

void
breaker (int sig)
{
   brktrp = -1;
   signal (sig, breaker);
}


sho_use ()
{   
      printf ("Usage: dtw [-n ] -i infile -o outfile \n");
      exit (-1);
}


/*********************************************************************/





/*********************************************************************************
 *	im_op								         *
 *      image operator				Mark Terry	1993	 	 *
 *********************************************************************************/


#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

float pic[512][512];
float opic[512][512];
char vec[512];
char h_vec[512];
float f_vec[512];
float T[10];

int debug;

main (argc, argv)
int   argc;
char *argv[];
{

FILE *ifp, *hfp, *ofp, *tfp,*fopen();
int header =1;
int i,j,m;
int half_tone = 0;
char in_file[120];
char out_file[120];
char transform_file[120];

float value;
float scale = 1.0;
float the_const = 0.0;

   int job_nu = 0;   
   char start_date[40];
/* DEFAULT SETTINGS */
   
   int i_flag_set = 0;
   int o_flag_set = 0;
   
data_file i_df, o_df;
int trans_flag = 0;
int do_a_trans = 0;
int opera_flag = 0;
int posn;
int high_pass_set = 0;
int Dtype = CHAR;
int op_data_type = CHAR;
int k,row_nu;
int read_head,eof;
int col_nu = 512;
float min,max;
int header_out = 1;

int half_level = 128;

char transform_type[60];

/* DEFAULT VALUES */



/* COPY COMMAND LINE TO OUTPUT HEADER */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");



/* PROCESS COMMAND LINE */

   for (i = 1 ; i < argc; i++) {

     if (debug == HELP)     
     	 break;
     	 
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {
	       case 'i': 
		  i_flag_set = 1;
                  strcpy (in_file,argv[++i]);
		  break;
	       case 'o': 
		  o_flag_set = 1;
                  strcpy (out_file,argv[++i]);
		  break;
	       case 'F':
	          op_data_type = FLOAT;
	          break;
	       case 'f':
	          Dtype = FLOAT;
	          break;	          
	       case 'C':
	          op_data_type = CHAR;
	          break;	          
	       case 'H':
		  half_tone = 1;
	          half_level = atoi( argv[++i]) ;
		  break;
	       case 'h':
	          debug = HELP ;
	          break;	          
	       case 'O': 
		  opera_flag = 1;
                  strcpy (transform_file,argv[++i]);
		  do_a_trans = 1;
		  break;
	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'T':
		  trans_flag = 1;
		  do_a_trans = 1;
		  strcpy(transform_type,argv[++i]);
		    break;

	      case 'N':
		  header_out = 0;
		  break;
	      case 'c':
		  header = 0;
	          col_nu = atoi( argv[++i]) ;
	          break;
	      case 'Y':
	          debug = atoi( argv[++i]) ;
	          break;
	  
	      default: 
		  fprintf (stderr, "illegal options\n");
		  return (-1);
	    }
	    break;
      }
   }

if (debug == HELP)
	sho_use();


    if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;

        signal (SIGFPE, fpe_trap);

	   laplace();
	/* laplace default transform */
	if ( trans_flag) {
		if(strcmp(transform_type,"point") == 0)
			point();
		if(strcmp(transform_type,"bilaplace") == 0)
			bilaplace();
		if(strcmp(transform_type,"laplace") == 0)
			laplace();			
		if(strcmp(transform_type,"sobel") == 0)
			sobel();						
        
        }

	/* read in and set operator */
	if (opera_flag) {
		
	 	if ( (tfp = fopen(transform_file,"r")) != NULL)	 {
	 		
		for (i = 0 ; i < 9 ; i++) 
			fscanf(tfp,"%f",&T[i]);	 	
	 		}
		else
		dbprintf(0,"can't open transform file\n");
        }

/* set default flags */


	if (!i_flag_set) 
		strcpy(in_file,"stdin");

	i_df.fp = stdin;

   if (header) {
   	 gs_open_frame_file(in_file,&i_df);   
	 col_nu = (int) i_df.f[VL];

	 dbprintf(1,"col_nu %d type %s %s\n",col_nu,i_df.dtype,i_df.dfile);
	 if (strcmp(i_df.dtype,"float") == 0)
	 Dtype = FLOAT;
	 else
	 Dtype = CHAR;
        }

	dbprintf(1,"ifp %d %d \n",i_df.fp,stdin);
	

	
 	row_nu = 0;

/* INPUT FROM CHAR FILE */ 


while (1) {
	
	if ( Dtype == CHAR)   {
		eof = fread (vec,sizeof(char), col_nu , i_df.fp);

/* printf("eof %d %d\n",eof,vec[0]); */

		if (eof <= 0) break;
		for (k = 0 ; k < col_nu ; k++)
		pic[row_nu][k] = (float) vec[k];
	        }

	if ( Dtype == FLOAT)   {
		eof = fread (f_vec,sizeof(float), col_nu , i_df.fp);
		if (eof <= 0) break;

/* printf("eof %d %f\n",eof,f_vec[0]); */

		for (k = 0 ; k < col_nu ; k++)
		pic[row_nu][k] =  f_vec[k];
	        }

		row_nu++;		
}


	dbprintf(1,"rn %d\n",row_nu);

/* TRANSFORM */
/*
		if (high_pass_set)
		high_pass(col_nu,row_nu);
		low_pass(col_nu,row_nu);
*/

		if (do_a_trans)
	        do_transform(col_nu,row_nu) ;
	        else {
	        for (j = 0; j < row_nu ; j++) {
		for (k = 0; k < col_nu ; k++) 
	       		opic[j][k]  = pic[j][k];
	        }
		}
/* get MIN_MAX */

		min = max = opic[0][0];

		for (j = 0; j < row_nu ; j++)
		for (k = 0; k < col_nu ; k++) {
		
		if (opic[j][k] > max ) max = opic[j][k];
	        if (opic[j][k] < min ) min = opic[j][k];		
	        }
		
dbprintf(1,"max %f min %f\n",max,min);

/* if char output normalize  ?*/

	scale = 255.0/(max-min);
	the_const = -1.0 * min;

/* OUTPUT */

   o_df.f[STR] = 1.0;
   o_df.f[STP] = (float) row_nu;   

/* HEADER */

 if ( !o_flag_set && ! header_out)  {
	 	 ofp = stdout;
 }
 else if (header_out ) {

 strcpy(o_df.name,"IM_OP");
 strcpy(o_df.type,"FRAME"); 
 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);
   
   o_df.f[VL] = (float) col_nu;
   o_df.f[FS] = 1.0;
   o_df.f[FL] = 1.0;
   o_df.f[CN] = 0.0;
   o_df.f[NP] = 0.0;   
   o_df.f[SF] = 1.0;
   o_df.f[MN] = 1.0;
   o_df.f[MX]= (float) col_nu;
   strcpy (o_df.x_d, "col_pix");
   strcpy (o_df.y_d, "row_pix");
   o_df.f[LL] = min;
   o_df.f[UL] = max;
   o_df.f[N]= (float) row_nu;
   o_df.f[SOD] = 0.0;

   strcpy(o_df.dfile,"@");
   if (op_data_type == FLOAT) 
   strcpy(o_df.dtype,"float");      
   else {
   strcpy(o_df.dtype,"unsigned_char");      
   o_df.f[LL] = 0;
   o_df.f[UL] = 255;
   }
   gs_w_frm_head(&o_df);   
   posn = gs_pad_header(o_df.fp);
	ofp = o_df.fp;
   }
   else {
   ofp = fopen(out_file,"w");   
   }

	if (ofp == NULL)
		exit(-1);
		
/* 
DATA */

		for (j = 0; j < row_nu ; j++) {

		for (k = 0; k < col_nu ; k++) {
		        if (op_data_type == CHAR)
				vec[k] = (unsigned char ) (scale * opic[j][k] + the_const) ;
				if (op_data_type == FLOAT)		
				f_vec[k] =opic[j][k];
	        }

	        if (op_data_type == CHAR) {
		if (half_tone) {
/*		dbprintf(0,"row %d\n",j); */
			v_half_tone(vec,half_level,col_nu);
					for (k = 0; k < col_nu/8 ; k++) {
					comp_to_char(&vec[k*8],&h_vec[k],8);	
				        }
		
		fwrite(h_vec,sizeof(char), col_nu/8, ofp);	
	    
	        }
		else
		fwrite(vec,sizeof(char), col_nu, ofp);	

	        }
		else
		fwrite(f_vec,sizeof(float), col_nu, ofp);	

	    }

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }
	fclose(ofp);

	exit(0);
}


high_pass(col_nu,row_nu)
{
int j,k;
		for (j = 0; j < row_nu ; j++)
		for (k = 1; k < col_nu; k++)
		opic[j][k] = pic[j][k] - (pic[j][k-1] *0.9);

}

low_pass(col_nu,row_nu)
{
int j,k;
		for (j = 0; j < row_nu ; j++)
		for (k = 0; k < col_nu -1; k++)
		opic[j][k] = (pic[j][k+1] + pic[j][k]) /2.0;
}

/* transform pix according to neighbouring pix values and transform values */

do_transform(col_nu,row_nu)
{
int i,k,k1,j,m,kk;
float sum;

  for(i=1; i < (row_nu - 1); i++) {

	dbprintf(1,"row %d\n",i);

      for(j=1; j < (col_nu - 1); j++) {

		dbprintf(1,"col %d \n",j);

	  sum =0;

	   for  (m = 0, kk = j-1; m < 3 ; m++,kk++) {
	  	   sum +=  pic[i-1][kk] * T[m];
	   }
	   
	  for  (m = 3, kk = j-1; m < 6 ; m++,kk++) {
	  	   sum +=  pic[i][kk] * T[m];
	   }
	   
	   for  (m = 6, kk = j-1; m < 9 ; m++,kk++) {
	  	   sum +=  pic[i+1][kk] * T[m];
	   }
	  opic[i][j] = sum;
	}	
    }
}


/* USAGE & HELP */

sho_use () 
{
      fprintf (stderr,
	    "Usage: im_op [-c -F -f -i in_file -o out_file] \n");

      fprintf(stderr,"Default output is ascii header & char data     	\n");
      fprintf(stderr,"if input file without header use flags     -c [-f] \n");
      fprintf(stderr,"-F	output to data_type float [default is char] \n");      
      fprintf(stderr,"-f	input data_type float  [default char] \n");            
      fprintf(stderr,"-c	specify number of pixels in row (512)   \n");                  
      fprintf(stderr,"-O	operator file  ascii file containing nine weights  \n");                  
      fprintf(stderr,"-T  operator type [laplace,bilaplace,lowpass]  excludes -O option \n");                        
      fprintf(stderr,"-H	produce half_tone pic [128]   \n");                  
      fprintf(stderr,"-N	no header on output file   \n");                  
      exit (-1);
}


point()
{
		T[0] = -1;
		T[1] = -1;
		T[2] = -1;
		T[3] = -1;
		T[4] = 8;		
		T[5] = -1;		
		T[6] = -1;
		T[7] = -1;
		T[8] = -1;
}

laplace()
{
		T[0] = 0;
		T[1] = 1;
		T[2] = 0;
		T[3] = 1;
		T[4] = -4;		
		T[5] = 1;		
		T[6] = 0;
		T[7] = 1;
		T[8] = 0;
}

bilaplace()
{
		T[0] = 1;
		T[1] = -2;
		T[2] = 1;
		T[3] = -2;
		T[4] = 4;		
		T[5] = -2;		
		T[6] = 1;
		T[7] = -2;
		T[8] = 1;
}

sobel()
{
		T[0] = -1;
		T[1] = -2;
		T[2] = -1;
		T[3] = 0;
		T[4] = 0;		
		T[5] = 0;		
		T[6] = 1;
		T[7] = 2;
		T[8] = 1;
}


v_half_tone(vec,level,n)
unsigned char vec[];
int level,n;
{
int i;
/* dbprintf(0,"half_tone level %d vec[1] %d %d \n",level,vec[1],vec[n-1]); */
	for (i = 0; i < n; i++) {
	if (vec[i] <= level)
		vec[i] = 0;
	else 
		vec[i] = 1;
	}

}

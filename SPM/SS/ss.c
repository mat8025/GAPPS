 /********************************************************************************
 *			SS							 *

 	speech synthesiser
	given (di_phoneme) sequence produces parameters
	for speech synthesiser
	( also useful for testing recognizers )
 *										 *
 *	Modified for pipelining & ascii headers by M.T. Dec 88			 *
 *********************************************************************************/


#include <gasp-conf.h>

#include  <stdio.h>
#include  <signal.h>

#include "df.h"
#include "sp.h"
int N_ADF = 4;

float get_noise ();

int N_frames = 32;

FILE *fp;
void breaker (int sig);
int brktrp;
int debug = 0;
float In_buf[8192];
data_file o_df,i_df;
main (argc, argv)
int   argc;
char *argv[];
{

   char sd_file[80];      
   static  channel o_chn;   
   int fposn =0;
   int posn,nc;
   int pid ,fsize;   
   char in_file[120];
   char out_file[120];

   char data_type[20];
   int no_header = 0;
   int offset = 0;
   float sf = 16000.0;     
   float  length;

   int   mode = 1;
   int   time_shift = 0;
   int nloops;
   
   int   eof, nsamples;
   int n_frames =0;
   int i,j,n,k;
   int  loop;
   double   atof ();
   char ph1[4];
   char ph2[4];
   
   int nframes;
   char  buf[32];


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


   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {


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

	       default: 
		  printf ("%s: illegal option %s\n", argv[0],argv[i]);
		  break;
	    }
	    break;
	 default: 
	    printf ("%s: illegal option\n", argv[0],argv[i]);
	    break;
      }
   }

   
   if (!i_flag_set)
             strcpy(in_file,"stdin");
   else
   fp = fopen(in_file,"r");


   sf = 16000.0;
 
/* copy across some data from input to output headers */

   gs_init_df(&o_df);
      
   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = o_df.f[STR] + length;


 strcpy(o_df.name,"SS");
 strcpy(o_df.type,"FRAME"); 

 o_df.f[N] = 1.0;

   if (!o_flag_set) 
       strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);
   
   o_df.f[VL] = 4.0;
   o_df.f[FS] = 10.0;
   o_df.f[FL] = 10.0;
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

/* sampling frequency */

/* set floating point exception trap */

   brktrp  = 0;
   signal (SIGFPE, breaker);


   if (debug)
   printf ("SS IN PROGRESS...\n");

   while (1) {

/* read diphone */

	  strcpy(ph1,"sil");

  	  strcpy(ph2,"sil");

	  eof = fscanf(fp,"%s %s",ph1,ph2);
	  if (debug)
	  printf("ph1 %s ph2 %s %d\n",ph1,ph2,eof);
	  
	  if ( eof <= 0)  {
	  if (debug > 1)
	  printf("END_OF_FILE\n"); 
	 	break;
	  }

          ss(ph1,ph2);

	  loop++;

/* write out the results */


   }

/************** end of main loop *****************/

   if (i_flag_set)    gs_close_df(&i_df);
   if (o_flag_set)    gs_close_df(&o_df);

   if (debug)
   printf ("SS: %d dp\n", nloops);

}
 

/* phoneme table */

#define P	1
#define T	2
#define K	3
#define B	4
#define D	5
#define G	6
#define AA	7
#define IY	8
#define UW	9


#define F1 	0
#define F2 	1
#define VO       2
#define NS       3
#define RD      4

p_t(phon, adf)
char phon[];
float adf[];
{
int i;
float get_noise();

	if ( strcmp(phon,"P") == 0)
	i = P;
	else 	if ( strcmp(phon,"B") == 0)
	i = B;
	else 	if ( strcmp(phon,"T") == 0)
	i = T;
	else 	if ( strcmp(phon,"D") == 0)
	i = D;
	else 	if ( strcmp(phon,"K") == 0)
	i = K;
	else 	if ( strcmp(phon,"G") == 0)
	i = G;
	else 	if ( strcmp(phon,"AA") == 0)
	i = AA;
	else 	if ( strcmp(phon,"IY") == 0)
	i = IY;
	else 	if ( strcmp(phon,"UW") == 0)
	i = UW;
	
	if (debug)
	printf("phon %s %d\n",phon,i);

	switch(i) {


 	case P :
		adf[F2] = 0.3 + get_noise(0.2) ;
		adf[F1] = 0.1 + get_noise (0.1); 
		adf[VO]= 0.0+ get_noise (0.1) ;
		adf[NS]= 1.0+ get_noise (0.1) ;
		adf[RD] = 0.4+ get_noise (0.1) ;
/* relative duration */
		break;
		
 	case B :
		adf[F2] = 0.3+ get_noise (0.1) ;
		adf[F1] = 0.1+ get_noise (0.1) ;
		adf[VO]= 1.0+ get_noise (0.1) ;
		adf[NS]= 0.0+ get_noise (0.1) ;
		adf[RD] = 0.3+ get_noise (0.1) ;
/* relative duration */
		break;

 	case T :
		adf[F2] = 0.5+ get_noise (0.1) ;
		adf[F1] = 0.1+ get_noise (0.1) ;
		adf[VO]= 0.0+ get_noise (0.1) ;
		adf[NS]= 1.0+ get_noise (0.1) ;
		adf[RD] = 0.4+ get_noise (0.1) ;
/* relative duration */
		break;
		
 	case D :
		adf[F2] = 0.5+ get_noise (0.1) ;
		adf[F1] = 0.1+ get_noise (0.1) ;
		adf[VO]= 1.0+ get_noise (0.1) ;
		adf[NS]= 0.0+ get_noise (0.1) ;
		adf[RD] = 0.3+ get_noise (0.1) ;

		break;

 	case K :
		adf[F2] = 0.7+ get_noise (0.1) ;
		adf[F1] = 0.1+ get_noise (0.1) ;
		adf[VO]= 0.0+ get_noise (0.1) ;
		adf[NS]= 1.0+ get_noise (0.1) ;
		adf[RD] = 0.3+ get_noise (0.1) ;

		break;
		
 	case G :
		adf[F2] = 0.7+ get_noise (0.1) ;
		adf[F1] = 0.1+ get_noise (0.1) ;
		adf[VO]= 1.0+ get_noise (0.1) ;
		adf[NS]= 0.0+ get_noise (0.1) ;
		adf[RD] = 0.2+ get_noise (0.1) ;


		break;
	
 	case AA :
		adf[F2] = 0.5+ get_noise (0.1) ;
		adf[F1] = 0.2+ get_noise (0.1) ;
		adf[VO]= 1.0+ get_noise (0.1) ;
		adf[NS]= 0.0+ get_noise (0.1) ;
		adf[RD] = 0.5+ get_noise (0.1) ;

		break;

 	case IY :
		adf[F2] = 0.8+ get_noise (0.1) ;
		adf[F1] = 0.3+ get_noise (0.1) ;
		adf[VO]= 1.0+ get_noise (0.1) ;
		adf[NS]= 0.0+ get_noise (0.1) ;
		adf[RD] = 0.6+ get_noise (0.1) ;

		break;

 	case UW :
		adf[F2] = 0.4+ get_noise (0.1) ;
		adf[F1] = 0.1+ get_noise (0.1) ;
		adf[VO]= 1.0+ get_noise (0.1) ;
		adf[NS]= 0.0+ get_noise (0.1) ;
		adf[RD] = 0.7+ get_noise (0.1) ;
/* relative duration */
		break;


        }
        if (debug)
	printf("adf %f %f %f\n",adf[0],adf[1],adf[2]);
}

ss( ph1,ph2) 
char ph1[4];
char ph2[4];
{
int k,j,i,p;
float adf1[10];
float adf2[10];

	/* zero token */

	

	p_t(ph1,adf1);

	p_t(ph2,adf2);

	k = adf1[RD] * N_frames/ 2;
	j = (N_frames/2) -k;
	
/*	printf("%f %d %d\n",adf1[RD],k,j); */

	/* write lead in frames */
	/* add noise ? */

	for ( p = 0; p < j ; p++) {
        for ( i = 0 ; i < N_ADF ; i++)
	In_buf[i] = 0.15 + get_noise (0.1) ;
        gs_write_frame (&o_df, In_buf);        
        }

	

	
        /* write phone */
	for ( p = 0; p < k-1 ; p++) {
        for ( i = 0 ; i < N_ADF ; i++)
	In_buf[i] = adf1[i] + get_noise(0.05);
        gs_write_frame (&o_df, In_buf);        

        }
/* transition */

	adf1[F2] = (adf2[F2] - adf1[F2]) / 2.0 + adf1[F2];
	adf1[F1] = (adf2[F1] - adf1[F1]) / 2.0 + adf1[F1];

	for ( i = 0 ; i < N_ADF ; i++)
	In_buf[i] = adf1[i] + get_noise(0.1) ;
        gs_write_frame (&o_df, In_buf);        
        
     	
	k = adf2[RD] * N_frames/2;
	
	for ( p = 0; p < k ; p++) {
        for ( i = 0 ; i < N_ADF ; i++) {
	In_buf[i] = adf2[i] + get_noise( 0.07) ;
        }
        gs_write_frame (&o_df, In_buf);        

        }
	j = (N_frames/2) -k;

	

	for ( p = 0; p < j ; p++) {
        for ( i = 0 ; i < N_ADF ; i++)
	In_buf[i] = 0.1 + get_noise (0.5);
        gs_write_frame (&o_df, In_buf);        

        }
}
/* return negative value if floating point exception trapped */

float
get_noise ( range )
float range;
{
float y;	
    y = 2 * range * ( (rand() % 1000 ) / 1000.0 ) -  range; 
	return (y);
	
}

void
breaker (int sig)
{
   brktrp = -1;
   signal (sig, breaker);
}


sho_use()
{
      printf ("Usage: SS -i infil -o outfil\n");
      exit (-1);
}


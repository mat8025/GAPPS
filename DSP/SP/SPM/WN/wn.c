static char     rcsid[] = "$Id: wn.c,v 1.1 1996/06/20 01:55:33 mark Exp $";

/****************************************************************************************
 *			WN								*
 *   	makes noise for 								*
 *	Author Mark  Terry   								*
 *	date	may 31 1985 								*
 *	modified	for pipelining & ascii headers    Dec 1988			*
 ****************************************************************************************/
 
#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

#define UNIFORM 1
#define GAUSSIAN 2
#define RAYLEIGH 3

#define OP_BUFSIZE 512

int debug = 0;
int vox_file_out = 0;
int i, j,   maxv,  l2, ln2, sw ;
float y, fr,  pi;
char name[10];

short    Sbuf[OP_BUFSIZE];
float    Fbuf[OP_BUFSIZE];
double atof();

main (argc, argv)
int   argc;
char *argv[];

{

	FILE *fp,  *gs_wrt_sf();
        int rand();
	float gs_u_noise();
	float gs_g_noise();

/* DEFAULT SETTINGS */

	float sf = 16000.0;
	float amp = 2045.0; /* 12 bit da range -2 */
	int seed = 1;
        int nsamples = 16000;
        
	char noise_type[120];
        char outfile[120];
        int bp;
        int type = 0;

        int continous = 0;

        int i_flag_set = 0;
        int o_flag_set = 0;

   int job_nu = 0;   
   char start_date[40];


        data_file o_df;
	channel n_chn[2];

/* DEFAULT SETTINGS */
	strcpy(noise_type,"Gaussian");


	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");


   for (i = 1 ; i < argc; i++) {

     if (debug == HELP)     
     	 break;
     	 
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {
	      case 'r':
		  seed = atoi(argv[++i]);
		  break;
	      case 'a':
		  amp = atof(argv[++i]);
		  break;
	      case 'f':
		  sf = atof(argv[++i]);
		  break;
	      case 'n':
		  nsamples  = atoi(argv[++i]);
		  break;

	      case 'C':
	      	  continous = 1;
	      	  break;

	      case 'o': 
		  o_flag_set = 1;
                  strcpy (outfile,argv[++i]);
		  break;

	      case 'V':
		  vox_file_out =1;
		  break;

	      case 't': 
	          type = 1;
                  strcpy(noise_type,argv[++i]);
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
	    break;
      }
   }


 if (debug == HELP)
 	sho_use();
 	
 
   if ( debug > 0)
   	debug_spm(argv[0],debug,job_nu) ;


	if (continous == 1) {
		nsamples = -1;
		o_flag_set = 0;
	}


        if (!o_flag_set) 
	strcpy(outfile,"stdout");

        o_df.f[STR] = 0.0;
        o_df.f[STP] = (float) (nsamples / sf);        
        strcpy(o_df.name,"NOISE_GENERATOR");
 	strcpy(o_df.type,"CHANNEL"); 

 	o_df.f[N] = 1.0;

        n_chn[0].f[SF] = sf;
        n_chn[0].f[N] = (float) nsamples;        
        n_chn[0].f[UL] = amp;                
        n_chn[0].f[LL] = -1.0 *amp;                        

	if (vox_file_out)
	strcpy(n_chn[0].dtype,"short");
	else
	strcpy(n_chn[0].dtype,"float");

        fp = gs_wrt_sf(outfile,&o_df,n_chn);


/*******************************************************************************/

	srand(seed);

	pi = 4.0 * atan(1.0) ;

	if (!strcmp(noise_type,"uniform"))	
	    type = UNIFORM;
	if (!strcmp(noise_type,"Gaussian"))	
	    type = GAUSSIAN;

        bp =0;
	j= 0;

	while (1) {
	

	if (type == UNIFORM)
	y = gs_u_noise();
	if (type == GAUSSIAN)
	y = gs_g_noise();

	if (vox_file_out)
	Sbuf[bp] = (short) (amp * y);
	else
	Fbuf[bp] =  (amp * y);
        bp++;


	if (bp == OP_BUFSIZE){
	if (vox_file_out)
		fwrite(Sbuf,sizeof(short), OP_BUFSIZE,fp);
		else
		fwrite(Fbuf,sizeof(float), OP_BUFSIZE,fp);
		bp =0;
	}	
	j++;
	if (j == (nsamples -1))
	break;
	}

	/* flush buffer */

	if (vox_file_out)
	fwrite(Sbuf,sizeof(short), bp,fp);
	else
	fwrite(Fbuf,sizeof(float), bp,fp);

	if (o_flag_set)
	fclose(fp);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}


sho_use ()
{
      fprintf (stderr, "Usage [-r int -a float -f float -n int  -C -t string -o string ]:\n");
      fprintf( stderr,"-r random seed [1] \n");
      fprintf( stderr,"-a amplitude [2045.0] \n");
      fprintf( stderr,"-f sample frequency in Hz\n");
      fprintf( stderr,"-n number of samples \n");
      fprintf( stderr,"-C continous (infinite number of samples) \n");      
      fprintf( stderr,"-t noise type [uniform Gaussian ]\n");
      fprintf( stderr,"-V produce short integer file \n");            
      fprintf( stderr,"-o output file name \n");
      exit(-1);
}


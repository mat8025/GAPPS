static char     rcsid[] = "$Id: mtone.c,v 1.3 1999/01/18 17:57:22 mark Exp mark $";
/****************************************************************************************
 *			MTONE								*
 *   	makes multi_channel  for testing 
 *	Author Mark  Terry   								*
 *	date	may 31 1985 								*
 *	modified	for pipelining & ascii headers    Dec 1988			*
 ****************************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include "df.h"
#include "sp.h"

/*Define default constants */
#define OP_BUFSIZE 512

short    Sbuf[OP_BUFSIZE];
float    Fbuf[OP_BUFSIZE];

float    Pi2 = 6.283185307;
double   pow (), sin (), cos (), log (), log10 ();
int debug = 0;
int vox_file_out = 0;

main (argc, argv)
int   argc;
char *argv[];
{

	FILE *fp,  *gs_wrt_sf();


   int job_nu = 0;   
   char start_date[40];

        int continous = 0;

        int i_flag_set = 0;
        int o_flag_set = 0;
	char outfile[120];
        data_file o_df;
	channel n_chn[64];

/* DEFAULT SETTINGS */

	float sf = 16000.0;
	float amp = 32767.0; /* 12 bit da range -2 */
	int seed = 1;
        int nsamples = 16000;

   int   i, k, j, n, size, ob_size;
   int   nu_ch = 1;
   float    u_freq, l_freq;
   float    tim = 1.0;
   float    df = 100.0;
   float    freq = 100.0;
   int header = 1;
   char  tag[4];

/* Header structures */

	strcpy(o_df.source,"\0");
	for (i = 0; i < argc; i++) {
	strcat(o_df.source, argv[i]);
        strcat(o_df.source, " ");
        }
        strcat(o_df.source, "\0");



   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 'f': 
		  sf = atof (argv[++i]);
		  break;
	       case 's': 
		  df = atof (argv[++i]);
		  break;
	       case 'a': 
		  amp = atof (argv[++i]);
		  break;
	       case 'l': 
		  freq = atof (argv[++i]);
		  break;
	       case 'c': 
		  nu_ch = atoi (argv[++i]);
		  break;
	       case 'n': 
		  nsamples = atoi (argv[++i]);
		  break;
	      case 'C':
	      	  continous = 1;
	      	  break;

	      case 'N':
	      	  header = 0;
	      	  break;
	      case 'o': 
		  o_flag_set = 1;
                  strcpy (outfile,argv[++i]);
		  break;

	      case 'V':
		  vox_file_out =1;
		  break;
	       case 'H':
	       case 'h':
	          debug = HELP ;
	          break;	          
		  
	      case 'Y':
	         debug = atoi (argv[++i]);
	         break;

	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;
			case 'v':
				show_version();
				exit(-1);
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

	if (continous == 1) {
		nsamples = -1;
		o_flag_set = 0;
	}

	dbprintf(1,"amp %f\n",amp);

        if (!o_flag_set) 
	strcpy(outfile,"stdout");

        o_df.f[STR] = 0.0;
        o_df.f[STP] = (float) (nsamples / sf);        
        strcpy(o_df.name,"MTONE");
 	strcpy(o_df.type,"CHANNEL"); 
 	o_df.f[N] = 1.0 * nu_ch;
        strcpy(o_df.y_d,"linear");        
	for (j = 0; j < nu_ch ; j++ ) {
	strcpy(n_chn[j].dfile,"@");
	if (vox_file_out)
	strcpy(n_chn[j].dtype,"short");
	else
	strcpy(n_chn[j].dtype,"float");

        n_chn[j].f[SF] = sf;
        n_chn[j].f[N] = (float) nsamples;        
        n_chn[j].f[UL] = amp;                
        n_chn[j].f[LL] = -1.0 *amp;                        
        }

        if (header)
        fp = gs_wrt_sf(outfile,&o_df,n_chn);

        else {
	if (strcmp(outfile, "stdout") == 0)
		fp = stdout;
	else {
		fp = fopen(outfile, FO_WM);
	}
        }


/*	contruct  tracks    */

   tim = Pi2 / sf;

   k = 0;

   if (vox_file_out) {

	while (1) {
	 for (j = 0; j < nu_ch; j++)
	    Sbuf[ j] = (short) amp * sin ((freq + (j * df)) * tim * k);
		fwrite(Sbuf,sizeof(short), nu_ch,fp);
	 k++;
	if (k== nsamples )
	break;
      }

   }
   else {

	while (1) {
	 for (j = 0; j < nu_ch; j++)
	    Fbuf[ j] =  amp * sin ((freq + (j * df)) * tim * k);
		fwrite(Fbuf,sizeof(float), nu_ch,fp);
	 k++;
	if (k== nsamples )
	break;
      }
   }

  if (o_flag_set)
	fclose(fp);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}


sho_use ()
{
      printf ("mtone [-l -f -a -s -n -c -T -o]:\n");
      printf ("-l base frequency in Hz\n");
      printf ("-s increment(separation) frequency in Hz\n");
      printf ("-a amplitude [1-32767]\n");
      printf ("-f sample frequency in Hz\n");
      printf ("-n number of samples (n < 80000)\n");
      printf ("-c number of channels for tones\n");
      printf ("-V create samplefile (short int) else datafile (float) \n");
      printf ("-N no output header \n");
      printf ("-o output file name \n");
      exit (0);
}

show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}


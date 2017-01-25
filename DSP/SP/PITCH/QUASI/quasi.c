/* QUASI  
 *
 * pitch track plus prosidic analysis for query/acknowledgement decision
 *
 * Mark Terry 
 * March 1993
 *
 * pitch xtraction is cepstral based
 * decision is rule based using pitch contours and pitch stats
 *
 */
 

#include <stdio.h>
#include <fcntl.h>
#include <math.h>
#include <signal.h>
#include "quasi.h"

char * quasi_rule();

P_con Pcon[200];
PTP Ptp;
int q_fpe_trap();

FILE   *fp, *fopen();
short Vox[30 * 8000];

char * quasi_rule();
extern int Debug;

main (argc, argv)
int   argc;
char *argv[];
{
char in_file[120];
char out_file[120];
int n_syll;
char ans[1024];
float buffer[3000];
int nvs,nps;	
float frame_shift = .01; 
float sf = 8000;


float pow_thres = 65;
float min_pow_thres = 50;
float cep_thres = 2.0;
float start_at_hz = 80.0;
float finish_at_hz =400.0;

int n_peaks = 10;
int fft_size = 512;
int smooth = 3;
int nxps;
int i_flag_set = 0;
int o_flag_set = 0;
int i,k,j;
/* SET PARAMETERS & THRESHOLDS */


	/* PARSE COMMAND LINE  */

	for (i = 1; i < argc; i++) {



		switch (*argv[i]) {

		case '-':

			switch (*++(argv[i])) {

			case 'k':
				n_peaks = atoi (argv[++i]);
				break;

			case 'n':
				fft_size = atoi (argv[++i]);
				break;

			case 'S':
				smooth = atoi (argv[++i]);
				break;

			case 'f':
				sf = atof (argv[++i]);
				break;

			case 's':
				frame_shift = atof (argv[++i]);
				frame_shift *= .001;
				break;

			case 't':
				cep_thres = atof( argv[++i]) ;
				break;

			case 'P':
				pow_thres = atof( argv[++i]) ;
				break;

			case 'M':
				min_pow_thres = atof( argv[++i]) ;
				break;

			case 'Y':
				Debug = atoi( argv[++i]) ;
				break;

			case 'i':
				i_flag_set = 1;
				strcpy(in_file,argv[++i]);
				break;

			case 'o':
				o_flag_set = 1;
				strcpy(out_file,argv[++i]);
				break;

			default:
				printf ("%s: option not valid\n", argv[i]);
				break;
			}
		}
	}


/* READ SIGNAL INTO BUFFER */
	if ( ! i_flag_set) {
	dbprintf(-1,"specify input file\n");
	exit(-1);	
        }

	nvs = read_the_signal(in_file,Vox);
	dbprintf(0,"nvs %d\n",nvs);

	if (nvs == -1)
		exit(-1);

	printf("%s ",in_file);


/* PITCH TRACKER PARAMETERS */

	Ptp.sf = sf;
	Ptp.smooth = smooth;
	Ptp.frame_shift = frame_shift;
	dbprintf(0,"ptp %f %f\n",Ptp.sf,Ptp.frame_shift);

	if (o_flag_set) {
	signal (SIGFPE, q_fpe_trap);

	nps = ((nvs * 1.0) / sf ) / frame_shift;

	nxps = q_xpitch(Vox,buffer,nps,&Ptp);

	n_syll = c_pcon(buffer,nxps,Pcon,frame_shift,NULL);
	fp = fopen (out_file,"w");
	for (k = 0 ; k < nps; k++)
	fprintf(fp,"%f\n",buffer[k]);	
	fclose(fp);
	strcpy(ans,quasi_rule(n_syll,Pcon));	
	printf("%s\n",ans);
        }
	else {

	n_syll = q_si(Vox,nvs,&Ptp,Pcon);

		if (n_syll > 0) {
		printf("%s %f %f %f %f",Pcon[n_syll].rule,Pcon[n_syll].start_time,
		Pcon[n_syll].stop_time,Pcon[n_syll].clevel,Pcon[n_syll].ave);
	        }
		else {
		printf("ERROR TOO LONG OR NO SPEECH\n")	;
	        }
        }

}


read_the_signal(fname,vox)
char fname[];
short vox[];
{
int nb;
int nir,ns;
	
		fp = fopen (fname,"r");
	        if (fp == NULL) {
	        printf("file error\n");
	        return -1;
	        }
		nb = fsize(fname,0);
		nb -= 384;
	        fseek (fp, 384, 0); /* assume this is a vox file: header size is 384 */
                nir = fread(vox,sizeof(short),nb/2,fp);  

		ns = nir;
		dbprintf(0,"%s size %d nbr %d ns %d\n",fname,nb,nir,ns);
		return (ns);
}

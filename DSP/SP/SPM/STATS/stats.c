static char     rcsid[] = "$Id: stats.c,v 1.5 1999/01/17 18:43:45 mark Exp mark $";
/*********************************************************************************
 *			stats							 *
 *	computes some simple stats       					 *
 *********************************************************************************/

#include <gasp-conf.h>

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <math.h>
#include "sp.h"

int             debug = 0;
main(argc, argv)
	int             argc;
	char           *argv[];
{

	FILE           *ifp, *hfp, *ofp, *fopen();
        int             dp =2;
	int             i, j;
	char            in_file[120];
	char            out_file[120];
	int             k;
        int             ni = 0;
	int             job_nu = 0;
	char            start_date[40];

	float           value;
	float           ave = 0.0;
	int             Iflg = 0;
	int             Oflg = 0;
	int             Rflg = 0;
	int             Gflg = 0;
	int             Lflg = 0;

	int             min_max = 0;
	int             min_n = 0;
	int             max_n = 0;
        float           sum = 0.0;
        float           rms = 0.0;
	float           min = 0.0;
	float           max = 0.0 ;
	float           y;
	float           ss = 0.0;
	float           rej_num = 0.0;
	float           g_num = 0.0;
	float           l_num = 0.0;

	int             first = 1;


	int             read_head, eof;
	float           data[513 * 513];

	int             nu_chn;
	int             pass;

	/* process command line for specifications */

	for (i = 1; i < argc; i++) {
		switch (*argv[i]) {
		case '-':
			switch (*++(argv[i])) {

			case 'i':
				Iflg = 1;
				strcpy(in_file, argv[++i]);
				break;

			case 'o':
				Oflg = 1;
				strcpy(out_file, argv[++i]);
				break;
				/* reject number */
			case 'R':
				Rflg = 1;
				rej_num = atof(argv[++i]);
				break;
			case 'G':
				Gflg = 1;
				g_num = atof(argv[++i]);
				break;
			case 'L':
				Lflg = 1;
				l_num = atof(argv[++i]);
				break;
			case 'Y':
				chk_argc(i,argc,argv) ;
				debug = atoi(argv[++i]);
				break;
			case 'v':
				show_version();
				exit(-1);
				break;
			case 'd':
				chk_argc(i,argc,argv) ;
				dp = atoi(argv[++i]);
				break;

			case 'H':
			case 'h':
				debug = HELP;
				break;

			default:
				fprintf(stderr, "illegal options\n");
				return (-1);
			}
			break;
		}
	}

	/* set default flags */
	if (debug == HELP)
		sho_use();

	if (debug > 0)
		debug_spm(argv[0], debug, job_nu);

	if (Iflg) {


		if ((ifp = fopen(in_file, "r")) == NULL)
			exit(-1);
		fseek(ifp, 0, 0);
	} else
		ifp = stdin;


	if (Oflg) {
		if ((ofp = fopen(out_file, "w")) == NULL)
			exit(-1);
	} else
		ofp = stdout;

	k = 0;
	first = 1;
	ave = 0.0;
	ss = 0.0;

	while (1) {

		pass = 1;
		eof = fscanf(ifp, "%f", &y);

		if (eof <= 0)
			break;

                ni++;
		if (Rflg) {
			if (y == rej_num)
				pass = 0;
		}

		if (Gflg) {
			if (y <= g_num)
				pass = 0;
		}

		if (Lflg) {
			if (y >= l_num)
				pass = 0;
		}

/*   dbprintf(1,"pass %d y %f g_num %f\n",pass,y,g_num); */

		if (pass) {

			k = k + 1;

			/* MAX _ MIN */

			if (first) {
				min = y;
				max = y;
				first = 0;
                                min_n = ni;
                                max_n = ni;
			} else {

			  if (y < min) {
					min = y;
					min_n = ni;
			          }

			  if (y > max) {
					max = y;
					max_n = ni;
                          }
			}

			ave += y;
                        
			ss += (y * y);
		}
	}

  if (k > 0) {
        sum = ave;
	ave = ave / (float) k;
	ss = ss / (float) k;
        rms = sqrt(ss);
	ss = ss - (ave * ave);
	ss = sqrt(ss);
      }


fprintf(ofp,"num %d min %6.*f max %6.*f ave %6.*f sd %6.*f min_n %d max_n %d sum %6.*f rms %6.*f\n ",k,dp,min,dp,max,dp,ave,dp,ss,min_n,max_n,dp,sum,dp,rms);


}

/* USAGE & HELP */
sho_use()
{
	show_version();
	fprintf(stderr,
		"Usage: stats [ -i in_file -o out_file] \n");
	fprintf(stderr, "-R  number reject this number\n");
	fprintf(stderr, "-G  number must be greater than to include\n");
	fprintf(stderr, "-L  number must be less than to include\n");
	fprintf(stderr, "-d  number of decimal places default 2\n");
	exit(-1);
}

show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}


chk_argc(i,argc,argv) 
char           *argv[];
{
  if (i < argc -1)
      return;
  printf("arg missing after %s\n",argv[i]) ;
  sho_use();
}


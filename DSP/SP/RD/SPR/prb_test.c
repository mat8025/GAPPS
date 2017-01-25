
#include <gasp-conf.h>

#include  <stdio.h>
#include  <math.h>
#include  <signal.h>
double   sqrt (), pow (), log10 ();
float fbuf[ 16000];
int   breaker (), brktrp;

main (argc, argv)
int   argc;
char *argv[];

{
int i,j, nsamples;
float sf,amp,fr;
float delta,df;
float pi,max;
double pk_pos,pk_amp,pk_bw;
float last_pk_pos = 0.0;
float last_sf_time = 0.0;
float last_pk_time = 0.0;
int mode;

sf = 16000.0;
fr = 1000.0;
amp = 100.0;
nsamples = 100;
 

   brktrp  = 0;
   signal (SIGFPE, breaker);

   for (i = 1; i < argc; i++) {
      switch (*argv[i]) {
	 case '-': 
	    switch (*++(argv[i])) {

	       case 'f': 
		  fr = atof (argv[++i]);
		  break;
	       case 'a': 
		  amp = atof (argv[++i]);
		  break;

	       case 'n': 
		  nsamples = atoi (argv[++i]);
		  break;
	       case 'I':
	       	   mode = -1;
	       	   break;
	          

	       case 's': 
		  sf = atof (argv[++i]);
		  break;


	       default: 
		  printf ("illegal options\n");
		  return (-1);
	    }
	    break;
      }
   }


	
   printf("nsamples %d\n",nsamples);	
/* gen sine wave */


   pi = 4.0 * atan (1.0);
   delta = 1.0/ sf;
   df = 1.0 / fr;
   
/*	SINE  */


      max = 2 * pi * fr * 1.0 / sf;

      j = 0;
      for (i = 0; i < nsamples; i++) {
	 /* sine function */

	    fbuf[j] =  (amp * sin (i * max));
	 j++;

      }
      j = 0;

      for (i = 0; i < nsamples; i++) {
/* determine peak time */
      	if (fbuf[i] < fbuf[i+1] && fbuf[i+1] > fbuf[i+2]) {
/*	printf("sample %d a1 %f a2 %f a3 %f a2_p %f\n",i+1,fbuf[i],fbuf[i+1],fbuf[i+2],(i+1) * delta); */
	prb_ip (fbuf[i], fbuf[i+1], fbuf[i+2], (i+1) *delta , delta, mode, &pk_pos, &pk_amp, &pk_bw);

/*	printf("sample %d pk_time %f pk_amp %f pk_bw %f\n",i+1,pk_pos,pk_amp,pk_bw); */
	
/*	printf("pk %d pk_time %f pk_est %f sf_time %f\n",j, j*df + df/ 4.0, pk_pos , (i+1) * delta); */
	printf("pk %d  %f %f %f \n",j, 1.0 / ((j*df+df/4.0) - last_pk_time), 1.0/ (pk_pos - last_pk_pos),
	1.0/ ((i+1) * delta - last_sf_time));
	last_pk_time = j*df + df/ 4.0;
	last_pk_pos = pk_pos;
	last_sf_time = (i+1) *delta;
	
	j++;
     }
 }
}


/*			
Parabolic interpolation of peak locations and amplitudes */

prb_ip (a1, a2, a3, a2_pos, delta, mode, pk_pos, pk_amp, pk_bw)
float    a1, a2, a3,a2_pos;
int   mode;
float    delta;
double  *pk_pos, *pk_amp, *pk_bw;
{
   float    aa, bb, cc, dd, ee, ff, gg;
   float inv_a1,inv_a2,inv_a3;
/* Function variables */
   if (mode == -1) {
   inv_a1 = 1.0/a1;
   inv_a2 = 1.0/a2;   
   inv_a3 = 1.0/a3;      
   } else
   {
   inv_a1 = a1;
   inv_a2 = a2;   
   inv_a3 = a3;      
   }

   aa = inv_a1 + inv_a3 - 2.0 * inv_a2;
   aa = aa / (2.0 * delta * delta);
   bb = (inv_a3 - inv_a1) / (2.0 * delta);
   cc = a2;
   ee = cc - ((bb * bb) / (4.0 * aa));
   dd = cc - ee / 2.0;
   gg = (bb * bb) - (float) mode * (4.0 * aa * dd);

/* Interpolate pk_pos, pk_bw and Gain */

   *pk_pos = a2_pos - (bb / (2.0 * aa));
   *pk_bw = (float) (-mode) * sqrt (gg) / aa;
   *pk_amp = ee;

}


/*			cpe
crude peak estimator
*/

cpe (a1, a2, a3, a2_pos, delta, mode, pk_pos, pk_amp, pk_bw)
float    a1, a2, a3,a2_pos;
int   mode;
float    delta;
double  *pk_pos, *pk_amp, *pk_bw;
{
   float    aa, bb, cc, dd, ee, ff, gg;
   *pk_pos = a2_pos - (bb / (2.0 * aa));
   *pk_bw = (float) (-mode) * sqrt (gg) / aa;
   *pk_amp = ee;

}



/* return negative value if floating point exception trapped */
breaker () {
   brktrp = -1;
   signal (SIGFPE, breaker);
}


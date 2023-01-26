static char     rcsid[] = "$Id: gr_pt.c,v 1.1 1996/12/13 05:26:54 mark Exp $";
/*
Gold and Rabiner Parallel Processing 
Time Domain Pitch Detection
Algorithm
*/

#include <stdio.h>
#include <fcntl.h>
#include "df.h"
#include "sp.h"
#include "trap.h"

int debug = 0;

float In_buf[MAXWIN];

#define MINARG 5
#define MAXWIN 1024
#define MAXSHIFT 1024
#define DEFWIN 25.
#define DEFSHF 10.
#define DEFS 16000.
#define DEFSTHRS 150
#define DEFVTHRS 4
#define NTRACKS 7
#define SPARE "Spare"

double   lt[2][512], mt[6][512];

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

   static  channel o_chn;   

   int last_sample_read =0;
   int new_sample = 0;
   int j,n,eof;

   int nsamples , npts , win_shift;
   
   int   winpts,  i, loop,nloops;
   int   nbytes;
   int sflg,cflg,vflg;
   double   atof (), log10 ();
   float    params[NTRACKS];

   float    start, stop, length,h_len;
   float maxamp;
   float   R0, R1, Rdiff, xmin, xmax, zc;
   int    x, x1, abs (), xdiff;
   double   r0, rms, sqrt ();

   int   coincs[4][6], tk[4], uvb[3], totpts;   
   int ms20;
   double   fsms;
   double   ppwin, ptstart, atof ();
   double   ppe[6][6], stpnt[6], amps[6];
   double   prang[4], cww[4];
   double   pav, pres, pavlo, pavup;

   int vthres = 4;
   int sthres = 100;
   int flip;
   int frms;

/* DEFAULT SETTINGS */

   int i_flag_set = 0;
   int o_flag_set = 0;
   float    winms = 20.0;
   float    shfms = 10.0;
   float    fs = 16000.0;

/* parse command line variables */

   for (i = 1; i < argc; i++) {

	     if (debug == HELP)     
     			 break;

      switch (*argv[i]) {
	 case '-': 
	    switch (*(argv[i] + 1)) {

	       case 'l': 
		  winms = atof (argv[++i]);
		  break;
	       case 's': 
		  shfms = atof (argv[++i]);
		  break;

	       case 'i': 
  		  i_flag_set = 1;		  
		  strcpy(in_file,argv[++i]);
		  break;
			case 'v':
				show_version();
				exit(-1);
				break;
	       case 'o': 
  		  o_flag_set = 1;
		  strcpy(out_file,argv[++i]);
		  break;
	       case 't': 
	       	     vthres = atoi( argv[++i]) ;
		  break;
	       case 'J': 
	       	     job_nu = atoi( argv[++i]) ;
		     gs_get_date(start_date,1);
		  break;

	       case 'Y':
	          debug = atoi( argv[++i]);
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
   	dbprintf(0,"not header file\n");
   	exit(-1);
   }

dbprintf(1,"infile %s df %d chn %d\n",in_file,i_df.fp,i_chn[0].fp);  

   nc = 0;

   if ( (int) i_df.f[N] > 0) {
      dbprintf (1,"There are %d channels;\n", (int) i_df.f[N]);
   }
 
   length = i_df.f[STP] - i_df.f[STR];

   dbprintf(1,"str %f stp %f\n", i_df.f[STR],i_df.f[STP]);

   nsamples = (int) i_chn[0].f[N];

   h_len = nsamples / i_chn[0].f[SF];

   if ( h_len < length ) {
   	o_df.f[STP] = h_len;
	o_df.f[STR] = 0.0;   	
     }
  
   if (length <=0.0) {
        length = h_len;
   	o_df.f[STP] = length;
   }


   if ( ((int) i_chn[nc].f[SOD]) > 0)
   fposn = (int) i_chn[nc].f[SOD];

   /* else start reading where header ends */
   /* sampling frequency */

   fs = 1.0 * (int) i_chn[0].f[SF];
 
 gs_init_df(&o_df);

   o_df.f[STR] = i_df.f[STR];
   o_df.f[STP] = i_df.f[STP];   


 strcpy(o_df.name,"GR_PT");
 strcpy(o_df.type,"CHANNEL"); 
  strcpy(o_df.x_d,"Time"); 
 o_df.f[N] = 1.0 * NTRACKS;

/* copy across some data from input to output headers */

/* sampling frequency */

   o_chn.f[SF] = fs;
   
/* window size and shift params */

   winpts = (int) (winms * fs / 1000.0  + 0.5);

   o_chn.f[FL] = (float) winpts / fs;
   if (winpts < 1 || winpts > MAXWIN) {
      dbprintf (0,"%s: window size out of range\n", argv[0]);
      exit (-1);
   }

   win_shift = (int) (shfms * fs /1000.0  + 0.5);

   o_chn.f[FS] = (float) win_shift / fs;

   if (win_shift < 1 ) {
      dbprintf (0," window shift out of range vp\n");
      exit (-1);
   }

   totpts = nsamples;

   nloops = (totpts - winpts) / win_shift + 1;
   totpts = winpts + (nloops - 1) * win_shift;
   o_chn.f[N] = nloops;

   o_chn.f[STP] = o_chn.f[STR] + (float) totpts / fs;

/* write out headers */

/* write general header */

	   if (!o_flag_set) 
       		strcpy(out_file,"stdout");

   gs_o_df_head(out_file,&o_df);

/* write channel headers */

   o_chn.fp = o_df.fp;
   
   strcpy(o_chn.dtype,"float");
   strcpy(o_chn.name,"PITCH_1");
   for(i = 0; i < NTRACKS ; i++ ) {
   o_chn.f[CN] = i * 1.0;
   o_chn.f[LL] = 0.0;
   o_chn.f[UL] = 600.0;   
   strcpy(o_chn.dfile,"@");
   gs_w_chn_head(&o_chn);
   }

   posn = gs_pad_header(o_df.fp);


/* number of points in 20 ms for function sildet */

   ms20 = winpts;
   fsms = fs/1000.0;

dbprintf(1,"ms20 %d fsms %f\n",ms20,fsms);
   

/* voicing thresholds */

   vthres = (vthres == -10000) ? DEFVTHRS : vthres;

   tk[0] = vthres + 5;
   tk[1] = vthres + 6;
   tk[2] = vthres + 9;
   tk[3] = vthres + 11;

/* pitch marker threshold */

	   ppwin *= fsms;

/* silence threshold */

   sthres = (sthres == -10000) ? DEFSTHRS : sthres;

/* upper and lower bounds of period average, 
   presently set at 4 to 10 ms */

   pavlo = 4.0 * fsms;
   pavup = 10.0 * fsms;

/* period ranges for determining coincidence window widths */

   prang[0] = 25.5 * fsms;
   prang[1] = 12.7 * fsms;
   prang[2] = 6.3 * fsms;
   prang[3] = 3.1 * fsms;

/* coincidence window widths in number of samples;
   equivalent to hundreds of microsecs */

   cww[3] = fs / 10000.;
   
     for (i = 2; i >= 0; i--)
      cww[i] = 2.0 * cww[i + 1];

/* clear buffers and initialize counters */

   for (i = 0; i < 6; i++) {
      for (j = 0; j < 6; j++)
	 ppe[i][j] = 0.;
      stpnt[i] = 0.;
      amps[i] = 0.;
   }
   start = 1.;
   frms = 0;

/* main while loop for pitch detection */
   npts = winpts;   
	j = 0;
	n = npts;
	loop = 0;
	

	while (1) {
	  
          eof = gs_read_chn(&i_chn[0],&In_buf[j],n);

          last_sample_read += n;

dbprintf(1,"lsr %d\n",last_sample_read);

	  if ( eof <= 0)  {
	  dbprintf(1,"END_OF_FILE\n"); 
          break;
	  }


	  if ( nsamples > 0 && last_sample_read > nsamples) {
	  	dbprintf(1,"lsr %d ns %d\n",last_sample_read,nsamples); 
		break;
	  }

/* invert data? */

      if (flip)
	 for (i = 0; i < winpts; i++)
	    In_buf[i] = -1* In_buf[i];


      sflg = sildet (ms20, In_buf, sthres);

dbprintf(1,"sflg %d ms20 %d\n",sflg,ms20);

      if (sflg == 0) {

	 ++frms;

	 peaker (winpts, In_buf);

	 decay (&pav, pres, pavlo, pavup, &ppe[0][0], &stpnt[0], &amps[0]);

	 if (frms >= 3) {
	    cflg = coinc (ppe, prang, cww, &coincs[0][0]);
	    vflg = buzhis (coincs, tk);
	 }
      }

      parset (sflg, cflg, vflg, &frms, &ppe[0][0], ppwin,
	    &pres, fs, fsms, amps, stpnt, ptstart, &uvb[0],
	    loop, &params[0]);

/* store results as parallel tracks in output file */

      fwrite ( params, sizeof(float), NTRACKS, o_df.fp);

       	new_sample += win_shift;
	gs_chn_ip_buf(&i_chn[0],In_buf,new_sample,&last_sample_read,&j,&n,npts);
	
	loop++;
        dbprintf(1,"loop %d \n",loop);
   }

   dbprintf (1,"GR_PT FINISHED...%d\n",loop);

   if (i_flag_set)
   gs_close_df(&i_df);

      if (o_flag_set)
   gs_close_df(&o_df);

   if (job_nu) {
	job_done(job_nu,start_date,o_df.source);
   }

}


/* 			sildet

Silence detector:  
2 crossings of set threshold 
(sthres) within
20 ms means non-silence.
Gold B. (1964); Note on buzz-hiss detection. JASA, 36, 1659-1611. */

sildet (ms20, inbuf, sthres)
int   ms20, sthres;
float inbuf[];
{
   int   k, i;

   for (k = 0, i = 0; i < ms20; i++) {
dbprintf(1,"sildet %f\n",inbuf[i]);
      if ( fabs (inbuf[i]) >= sthres)
	 k++;

      if (k >= 2)
	 return (0);
   }

   return (-1);

}


/*			peaker

Peak and valley detector for parallel processor;
   includes parabolic interpolation for increasing sampling
   resolution of detected peaks and valleys

Storage:
	peak amp ......................... mt[0][i]
	peak to valley amp ............... mt[1][i]
	peak to previous peak amp ........ mt[2][i]
	valley amp ....................... mt[3][i]
	valley to peak amp ............... mt[4][i]
	valley to previous valley amp .... mt[5][i]
*/

peaker (wsize, inbuf)
float    inbuf[];
int   wsize;
{
   int   p1, p2, i, j;

   for (i = 0; i < 6; i++)
      for (j = 0; j < 512; j++)
	 mt[i][j] = 0;

   for (p1 = -1, p2 = -1, i = 1; i < wsize - 2; i++) {

      if (inbuf[i] > 0 
      	  && inbuf[i] >= inbuf[i - 1] 
      	  && inbuf[i] > inbuf[i + 1]) {/* peaks */

	 ++p1;

	 interp (inbuf[i - 1], inbuf[i], inbuf[i + 1], i, &mt[0][p1], &lt[0][p1]);

	 if (p2 >= 0)
	    mt[1][p1] = mt[0][p1] + mt[3][p2];
	 if (p1 > 0 && mt[0][p1] > mt[0][p1 - 1])
	    mt[2][p1] = mt[0][p1] - mt[0][p1 - 1];
      }

      if (inbuf[i] < 0 
         && inbuf[i] <= inbuf[i - 1] 
         && inbuf[i] < inbuf[i + 1]) {/* valleys */
	 
	 ++p2;
	 interp (inbuf[i - 1], inbuf[i], inbuf[i + 1], i, &mt[3][p2], &lt[1][p2]);
	 if (p1 >= 0)
	    mt[4][p2] = mt[3][p2] + mt[0][p1];

	 if (p2 > 0 && mt[3][p2] > mt[3][p2 - 1])
	    mt[5][p2] = mt[3][p2] - mt[3][p2 - 1];
      }
   }

/* end of data flags */
   lt[0][p1 + 1] = -1.;
   lt[1][p2 + 1] = -1.;
}


/*			interp

Parabolic interpolation of peak locations and amplitudes */

interp (sm1, s, sp1, lin, sout, lout)
float    sm1, s, sp1;
int   lin;
double  *sout, *lout;
{
   double   A, B, sm1d, sd, sp1d, fabs ();

   sm1d = sm1;
   sd = s;
   sp1d = sp1;

   B = (sp1d - sm1d) * 0.5;
   A = (sp1d + sm1d) * 0.5 - sd;
   *lout = -B / (2.0 * A) + lin;
   *sout = fabs (sd - B * B / (4.0 * A));
   return (0);
}


/*			decay

Period detection by exponential decay for parallel processor.
   Previous periods are recalled, smoothed by an iterative process
   (pav), and the duration for no detection calculated (blnk).
   A decaying exponential curve is calculated (yax) and the next
   amplitude to cross this curve is the newly found period. The
   process starts over again from the new pitch marker.

*/


decay (pav, pres, pavlo, pavup, ppe, stpnt, amps)
double  *pav, pres, pavlo, pavup;
double   ppe[6][6], stpnt[6], amps[6];
{
   int   mp, lp, dp, i;
   double   blnk, tblnk, rdtc, stsav, apsav;
   double  ppsav, pt1, exht, pt2, xax, yax;
   double   exp ();

   *pav = (*pav + pres) * 0.5;

   if (*pav < pavlo)
      *pav = pavlo;
   if (*pav > pavup)
      *pav = pavup;
   blnk = *pav * 0.4;
   rdtc = 0.695 / *pav;

   for (mp = 0; mp < 6; mp++) {

      stsav = apsav = ppsav = 0.;
      lp = (mp < 3) ? 0 : 1;
      dp = -1;

PT1:  dp++;
      pt1 = lt[lp][dp];
      if (pt1 <= 0.)
	 goto STORE;
      if (mt[mp][dp] <= 0.)
	 goto PT1;

PTB:  tblnk = blnk + pt1;
      exht = mt[mp][dp];

PT2:  dp++;
      pt2 = lt[lp][dp];
      if (pt2 <= 0.)
	 goto STORE;
      if (pt2 <= tblnk || mt[mp][dp] <= 0.)
	 goto PT2;

      xax = tblnk - pt2;
      yax = exht * exp (xax * rdtc);
      if (mt[mp][dp] <= yax)
	 goto PT2;
      stsav = pt1;
      apsav = exht;
      ppsav = pt2 - pt1;
      pt1 = pt2;
      goto PTB;

STORE: ppe[2][mp] = ppe[1][mp];
      ppe[1][mp] = ppe[0][mp];
      ppe[0][mp] = ppsav;
      stpnt[mp] = stsav;
      amps[mp] = apsav;
   }

}


/*			coinc
   Coincidence counter for parallel processor.
   The most recently detected period estimates (ppe[1][i])
   are the candidates. The program begins by making some
   totals of the 3 most recent periods as a bias towards
   minimum-frequency selection. Then a candidate is compared
   to the other pitch measures to determine the number of
   similar pitches.  Totals of comparisons are controlled by
   coincidence window widths.
*/


coinc (ppe, prang, cww, coincs)
double   ppe[6][6], prang[4], cww[4];
int   coincs[4][6];
{
   int   flg, i, j, click, col, row;
   double   cnst, win;

   flg = 0;

   for (i = 0; i < 6; i++)
      for (j = 3; j < 6; j++)
	 ppe[j][i] = ppe[j - 3][i] + ppe[j - 2][i];

   for (i = 0; i < 6; i++) {

      if (ppe[0][i] > 0.0) {
	 flg = 1;

	 for (j = 0; j < 4; j++)
	    if (ppe[0][i] <= prang[j])
	       cnst = cww[j];

	 for (win = 0, click = 0; click < 4; click++) {
	    coincs[click][i] = 0;
	    win += cnst;
	    for (col = 0; col < 6; col++)
	       for (row = 0; row < 6; row++)
		  if (fabs (ppe[row][col] - ppe[0][i]) <= win)
		     coincs[click][i] += 1;
	 }
      }
      else {
	 for (j = 0; j < 4; j++)
	    coincs[j][i] = -1;
      }
   }

   return (flg);
}


/*			buzhis
A function to determine if frame of speech data is voiced or unvoiced.
*/

buzhis (coincs, tk)
int   coincs[4][6], tk[4];
{
   int   ftot, wk, sk, i, tppe, btot, fppe;

   for (ftot = -10000, wk = 0; wk < 4; wk++) {
      for (sk = -1, i = 0; i < 6; i++) {
	 if (coincs[wk][i] > sk) {
	    sk = coincs[wk][i];
	    tppe = i;
	 }
	 else;
      }
      btot = sk - tk[wk];
      if (btot > ftot) {
	 ftot = btot;
	 fppe = tppe;
      }
      else;
   }

   if (ftot < 0)
      fppe = -1;
   return (fppe);

}


parset (sflg, cflg, vflg, frms, ppe, ppwin, pres, fs, fsms,
   amps, stpnt, start, uvb, loop, params)
int   sflg, cflg, vflg, *frms, uvb[3], loop;
double  *pres, ppe[6][6], ppwin, fs, fsms, amps[6], stpnt[6], start;
float    params[];
{
   int   vflgo, i, j;

   double   f0, pp, amp, beg, end, fabs ();

/* clear storage buffer when added here */

   vflgo = vflg;

   *pres = f0 = pp = amp = beg = end = 0.;

   if (sflg < 0)
      goto UV;
   if (*frms < 3)
      goto PO;
   if (cflg = 0 || vflg < 0)
      goto UV;

   if (vflg != 0 && ppe[0][0] > 0.)
      if (fabs (ppe[0][0] - ppe[0][vflg]) <= ppwin)
	 vflg = 0;
   *pres = ppe[0][vflg];
   f0 = fs / *pres;
   pp = *pres / fsms;
   amp = amps[vflg];
   beg = stpnt[vflg] + start;
   end = beg + *pres;
   goto PO;

UV: for (i = 0; i < 2; i++)
      uvb[i] = uvb[i + 1];

   uvb[2] = loop;

   if ((uvb[2] - uvb[1]) == 1 && (uvb[1] - uvb[0]) == 1) {
      for (i = 0; i < 6; i++)
	 for (j = 0; j < 6; j++)
	    ppe[i][j] = 0.;
      *frms = 0;
   }

PO: params[0] = f0;
   params[1] = pp;
   params[2] = amp;
   params[3] = beg;
   params[4] = end;
   params[5] = *pres;
   params[6] = vflgo;
}


sho_use()
{
      printf ("Usage: gr_pt -l msec -s msec  -t [1-7] -i infil -o outfil\n");
      exit (-1);
}


show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}

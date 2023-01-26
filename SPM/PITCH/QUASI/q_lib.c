#include <stdio.h>
#include <fcntl.h>
#include <math.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/dir.h>
#include <sys/stat.h>
#include "quasi.h"

#define MAXQPS 3000

float Results[1000];
float In_buf[2048];
float Window[2046];
float Real[2048];
float Imag[2048];
float the_pitch[3000];
float Pbuffer[MAXQPS];

int Debug = -1;

int FPE;
int q_fpe_trap();
char * quasi_rule();

q_si(vox,nvs,ptp,pcon)
short vox[];
int nvs;
PTP *ptp;
P_con pcon[];
{
int nps;
float frame_shift;	
float sf;
int smooth;
int nxps;
char ans[32];
int n_syll;

	dbprintf(0,"nvs %d\n",nvs);

	sf = ptp->sf;
	frame_shift = ptp->frame_shift;
	smooth = ptp->smooth;

	dbprintf(0,"ptp %f %f\n",ptp->sf,ptp->frame_shift);

	signal (SIGFPE, q_fpe_trap);

	nps = ((nvs * 1.0) / sf ) / frame_shift;
	dbprintf(0,"nps %d\n",nps);
	if (nps > MAXQPS) 
		return -1;

	nxps = q_xpitch(vox,Pbuffer,nps,ptp);

	n_syll = c_pcon(Pbuffer,nxps,pcon,frame_shift,NULL);

	strcpy(ans,quasi_rule(n_syll,pcon));	
	return n_syll;
}

q_xpitch(vox,buffer,nps,ptp)
short vox[];
float buffer[];
int nps;
PTP *ptp;
{


float cep_thres = 2.0;
float start_at_hz = 80.0;
float finish_at_hz =400.0;
float sf = 8000.0;
float pow_thres = 65;
float min_pow_thres = 50;
float fr_shift;

float inc_thres;
float new_pp;
float power;
float scale_factor;
float dt;

int start_at =0;
int finish_at =0;
int init = 1;
int fft_size = 512;
int win_length = 320;
int n_peaks = 10;

int old_wl;
int get_n_peaks;
int n_lag;

int kfs;
int j,vp;
int nxps =0;
int smooth;

	dbprintf(0,"nps %d\n",nps);

	sf = ptp->sf;
	fr_shift = ptp->frame_shift;
	smooth = ptp->smooth;

dbprintf(1,"sf %f fr_shift %f\n",sf,fr_shift);

	start_at =  sf/(2.0  * start_at_hz);
	finish_at = sf/(2.0  * finish_at_hz);

	inc_thres = (2.0 * cep_thres) / (float) ( abs(start_at- finish_at) );

	dt = 2.0/ sf;
	n_lag = fft_size/4;
		
	scale_factor = 1.0 / (1.0 * fft_size);

		gs_window("Hanning",win_length,Window);	
		old_wl = win_length;
			
		for (kfs = 0 ; kfs < nps ; kfs++) {

/* LOAD SIGNAL FOR PROCESSING */

		vp = (int) (kfs * fr_shift * sf +0.5);
		dbprintf(1,"vp index %d\n",vp);
		for (j = 0; j < win_length ; j++)
			In_buf[j] = (float) vox[vp++];		


/*  DO CEPSTRUM */

		q_cep(In_buf,Real,Imag,fft_size,scale_factor,win_length,Window,&power);

/* SMOOTH */

		if (smooth)
			sp_rave(Real,n_lag,smooth,init);

		init = 0;

		get_n_peaks= q_pickpeaks(Real,Results,cep_thres,inc_thres,n_peaks,start_at,finish_at);

/* SORT in amp order  */

		if (get_n_peaks > 1)
			q_pksort(Results,n_peaks);

dbprintf(1,"npk %d pk1 %f pk2 %f pk3 %f: amp1 %f amp2 %f amp3 %f\n",n_peaks,Results[0],Results[1],Results[2],Results[n_peaks],
		    Results[n_peaks+1],Results[n_peaks+2]);

		if (power > 0.0)
			Results[2] =   10 * log10( power/ (float) (fft_size/2) );
		else
			Results[2] = -120.0;

		power= Results[2];

dbprintf(1,"power %f pow_thres %f\n",power,pow_thres);
dbprintf(1,"amp %f thres %f\n",Results[n_peaks],cep_thres);

/* PITCH_TRACK */
/* PULL OUT PREDOMINANT PITCH */

		if (Results[0] > 0.0 ) {
			q_pitch_track(Results,the_pitch,power,pow_thres,min_pow_thres,n_peaks,dt);	
		}
		else {
			Results[1] = -1;
			Results[3] = 0.0;
		}

dbprintf(1,"loop %d power %f pk_amp %f\n",kfs,Results[2],Results[3]);

/* STORE RESULTS  */

		buffer[kfs] = Results[0];
		nxps++;
		new_pp = Results[0];

/* ADAPTIVE WINDOW LENGTH */
			if ( power > pow_thres) {
				q_adapt_wl(Window,new_pp,&win_length,sf,old_wl);
			}

		old_wl = win_length;
        }

	return nxps;        
}



gs_fft (rl, im, size, fwd)
float    rl[];
float    im[];
int   size;
int   fwd;
{
/* Working variables */
   int   i, ii, iii, j, jj, jjj, j1, j2;
   int   np, p2, lix, lmx;
   float    ang, xang, c, s, t1, t2;
   float    pi2 = 6.283185307, alog2 = 0.6931471806;
   float    fwd_dir;

   if (fwd == 1)
      fwd_dir = 1.0;
   else
      fwd_dir = -1.0;

/* Determine transform size */

   np = size;
   p2 = (int) (0.5 + (log ((double) np)) / alog2);
   xang = pi2 / (float) np;
   lmx = np;

/* Compute each stage of the transform */

   for (i = 0; i < p2; i++) {
      lix = lmx;
      lmx = lmx / 2;
      ang = 0.0;

/* Compute for each butterfly */

      for (ii = 0; ii < lmx; ii++) {
	 c = cos (ang);
	 s = fwd_dir * sin (ang);
	 ang = ang + xang;

/* Compute for each point */
	 for (iii = lix; iii <= np; iii = iii + lix) {
	    j1 = iii - lix + ii;
	    j2 = j1 + lmx;

/* Butterfly calculation */
	    t1 = rl[j1] - rl[j2];
	    t2 = im[j1] - im[j2];
	    rl[j1] = rl[j1] + rl[j2];
	    im[j1] = im[j1] + im[j2];
	    rl[j2] = c * t1 + s * t2;
	    im[j2] = c * t2 - s * t1;
	 }
      }
      xang = 2.0 * xang;
   }

/* Bit reversal  */

   j = 0;
   jj = np / 2;
   for (i = 0; i < (np - 1); i++) {
      if (i < j) {
	 t1 = rl[j];
	 t2 = im[j];
	 rl[j] = rl[i];
	 im[j] = im[i];
	 rl[i] = t1;
	 im[i] = t2;
      }
      jjj = jj;
      while (jjj < (j + 1)) {
	 j = j - jjj;
	 jjj = jjj / 2;
      }
      j = j + jjj;
   }
}


gs_window (wintype, n, win)
char *wintype;
int   n;
float    win[];
{
   int   i, shift;
   float    n1, bw;
   float Pi2 = 6.2831853071;
   if (n <= 0)
      return (-1);
   n1 = (float) n - 1.0;
      
	    for (i = 0; i < n; i++)
	       win[i] = 0.5 - 0.5 * cos (Pi2 * (float) i / n1);
}


/* running ave of vector */
sp_rave (x,npts,m,init)
float  x[];
{
static float *fbuf;
static int state = 0;
int i,k,j;
float sum;
static int sm = 0;
static int snpts = 0;

	if (init == 1) {
		if (state == 1)
			free( (char *) fbuf);
			fbuf = NULL;
			if (npts > 0) 
			fbuf = (float *) calloc(sizeof(float), m * npts);

			if (fbuf == NULL) {
			state = 0;
			return 0;
			}
			state =1;
		sm = m;
		snpts = npts;
		}

	 if (state == 1 && (m == sm) && (npts == snpts)) {

	/* shift */

		for (i = 1 ; i < m; i++) {
			j = (m -i -1) * npts ;
			for (k = 0; k < npts; k++) {
				fbuf[j+npts] = fbuf[j];
				j++;
			}
		}
		
		for (k = 0; k < npts; k++) {
		fbuf[k] = x[k];
		}
	
		for (k = 0; k < npts; k++) {
					sum = 0;
					for (i = 0 ; i < m; i++) {
					 sum += fbuf[k +(i*npts)];
				        }
		x[k] = sum/(float) m;
		}
        }
}


/* given x,y points fit line */

sp_lfit (x,y,n,sig,mwt,a,b,siga,sigb,chi2,Q)
float    x[];
float    y[],sig[];
float *a,*b,*siga,*sigb,*chi2,*Q;
{
int i;
float ss,sx,sy,st2,wt,sxoss,T,tmp;

	sx = sy = st2 = 0.0;
	
	if (mwt) {
		ss = 0;	
	 for ( i = 0 ; i < n ; i++ ) {
		wt = 1.0 / (sig[i] * sig[i]);
		ss=ss+wt;
		sx = sx +x[i] * wt;
		sy = sy +y[i] * wt;
        }
       }
       else {
       	 for ( i = 0 ; i < n ; i++ ) {
       	 	sx = sx + x[i];
      		sy = sy + y[i];
         }
      		ss = (float) n;
       }

		sxoss = sx/ss;
		
	if (mwt) {
		 for ( i = 0 ; i < n ; i++ ) {
		  T= (x[i] - sxoss) / sig[i];
		  st2 = st2 + T*T;
		  *b  = *b + T * y[i]/ sig[i];
	         }
        }
	else {
		 for ( i = 0 ; i < n ; i++ ) {
		  T= x[i] - sxoss;
		  st2 = st2 + T * T;
		  *b  = *b + T * y[i];
	         }
        }

	*b = *b / st2;
	*a = (sy - sx * *b ) / ss;

	*siga = sqrt ((1.0 + sx * sx/ (ss + st2)) / ss);
	*sigb = sqrt ( 1.0 / st2);

	*chi2 = 0.0 ; /* calculate chi squared */

	if ( ! mwt && (n > 2) ) {
			 for ( i = 0 ; i < n ; i++ ) {
			 tmp = (y[i] - *a - *b * x[i]);
			 *chi2 = *chi2 + tmp * tmp;
			}
			*Q = 1.0;
			tmp = sqrt( *chi2 / (float) (n-2));
			*siga = *siga * tmp;
			*sigb = *sigb * tmp;
        }
}


parabolic_ip (a1, a2, a3, k, delta, mode, pk_pos, pk_amp, pk_bw)
float    a1, a2, a3;
int   mode;
float    delta;
float  *pk_pos, *pk_amp, *pk_bw;
{
   float    aa, bb, cc, dd, ee, ff, gg;
   float frq;

/* Function variables */

   frq = (float) (k * delta);

   if (mode == -2) { /* no interpolation */
   *pk_pos = frq;
   *pk_amp = a2;
   *pk_bw = 2.0 * delta;
   }
   else { /* should fit two parabolas to get closest to minimum/maximum */
   
   aa = a1 + a3 - 2.0 * a2;
   aa = aa / (2.0 * delta * delta);
   
   bb = (a3 - a1) / (2.0 * delta);
   cc = a2;
   
   ee = cc - ((bb * bb) / (4.0 * aa));
   
   dd = cc - ee / 2.0;
   gg = (bb * bb) - (float) mode * (4.0 * aa * dd);

/* Interpolate pk_pos freq, pk_bw and Gain */
/* if amp is neg ? */

   *pk_pos = frq - (bb / (2.0 * aa));

   if(gg < 0) {
   dbprintf(1,"para gg %f a1 %f a2 %f a3 %f \n",gg,a1,a2,a3);	
   }
   else
   *pk_bw = (float) (-mode) * sqrt (gg) / aa;

   *pk_amp = ee;
   }
}


sp_stats (X,S,n)
float X[],S[];
{
/* input raw scores
 * output sum mean ss sd
 */
 
int i,k;
float ss,ave,sd,sum,var,max,min;
sd = var = 0.0;

if ( n<=0)
return 0;

sum = 0.0;
ss =0.0;
min = X[0];
max = X[0];

for (i = 0; i < n ; i++) {
sum += X[i];
ss += X[i]*X[i];
if (X[i] < min)
min = X[i];
if (X[i] > max)
max =X[i];
}

ave = sum / (float) n;

S[0] = sum;
S[1] = ave;
S[2] = ss;

var = sqrt( (ss/ (float) n) - (ave*ave));

S[3] =var;

if ( n > 1) {
sd = var * (sqrt(n)/sqrt(n-1));
S[4] =sd;
}
S[5] = min;
S[6] = max;

return 1;
}


q_fpe_trap () 
{
   FPE = 1;
   signal (SIGFPE, q_fpe_trap);
}


struct stat stbf;

fsize (name,report)			/* get size of file */
char *name;
{

   int   i;
   if ((i == stat (name, &stbf)) == -1) {
      if (report)
dbprintf (1,"Can't find %s\n", name);
      return (-1);
   }

   if (stbf.st_size == 0) {
      if (report)
dbprintf (1,"%s -- zero length file\n", name);
      return (-1);
   }

   if (access (name, 0)) {
      if (report)
dbprintf (1,"No Read Permissions for %s\n", name);
      return (-1);
   }
   return (stbf.st_size);
}


dbprintf (level, str, arg1, arg2, arg3, arg4, arg5,
   arg6, arg7, arg8, arg9, arg10)
char *str;
int   arg1, arg2, arg3, arg4, arg5;
int   arg6, arg7, arg8, arg9, arg10;
{
char	message[256];
   
if (level > Debug)
      return;
   
   sprintf (message, str, arg1, arg2, arg3, arg4, arg5,
	       arg6, arg7, arg8, arg9, arg10);

   printf("%s",message);
   fflush(1);   
   return;
}



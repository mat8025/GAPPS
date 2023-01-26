/**********************************************************************/
/*                         SPALIB.C                                   */
/*            SUBPROGRAMS IN ALPHABETICAL ORDER                       */
/*              IN THE C PROGRAMMING LANGUAGE                         */
/*                                                                    */
/**********************************************************************/

/* NOTE: The user may wish to include the following in other programs */

/* .................Begin include file.................*/
/* Latest date: 06/23/92 */

#include <math.h>

/* In the VMS compiler, M_PI is not defined in math.h */

#ifdef vms
#define M_PI    3.14159265358979323846
#endif
#ifndef KR
#define M_PI    3.14159265358979323846
#endif

#define FALSE	0
#define TRUE	1
#define BIG	1e10
#define SMALL	1e-10
#define ORDER5	1e-5
#define ORDER4	1e-4
#define ABS(x) ((x) >= 0 ? (x) : -(x))
#define MIN(a,b) ((a) <= (b) ? (a) : (b))
#define MAX(a,b) ((a) >= (b) ? (a) : (b))

/* Table of constant values */

static long neg_i1 = -1;
static long pos_i1 = 1;
static long pos_i2 = 2;
static long pos_i4 = 4;
static long pos_i5 = 5;
static float neg_f1 = -1.0;
static float pos_f2 = 2.0;
static double pos_d10 = 10.0;

typedef struct {
	float r, i;
} complex;

typedef struct {
	double r, i;
} doublecomplex;

/* .................End of include file.................*/

/* SPBFCT     11/14/85 */
/* GENERATES (I1)!/(I1-I2)!=I1*(I1-1)*...*(I1-I2+1). */
/* NOTE: 0!=1 AND SPBFCT(I,I)=SPBFCT(I,I-1)=I!. */

#ifndef KR
double spbfct(long *i1, long *i2)
#else
double spbfct(i1, i2)
long *i1, *i2;
#endif
{
    /* Local variables */
    long i;
    double ret_val;

    ret_val = 0.0;
    if (*i1 < 0 || *i2 < 0 || *i2 > *i1)
    {
	return(ret_val);
    }

    ret_val = 1.0;
    for (i = *i1 ; i >= (*i1 - *i2 + 1) ; --i)
    {
	ret_val *= (double) i;
    }

    return(ret_val);
} /* spbfct */

/* SPBILN     11/13/85 */
/* CONVERTS ANALOG H(S) TO DIGITAL H(Z) VIA BILINEAR TRANSFORM */
/*      ANALOG TRANSFER FUNCTION         DIGITAL TRANSFER FUNCTION */
/*          D(L)*S**L+.....+D(0)             B(0)+......+B(L)*Z**-L */
/*    H(S)=---------------------        H(Z)=---------------------- */
/*          C(L)*S**L+.....+C(0)               1+.......+A(L)*Z**-L */
/* H(S) IS ASSUMED TO BE PRE-SCALED AND PRE-WARPED */
/* LN SPECIFIES THE LENGTH OF THE COEFFICIENT ARRAYS */
/* FILTER ORDER L IS COMPUTED INTERNALLY */
/* WORK IS AN INTERNAL ARRAY (2D) SIZED TO MATCH COEF ARRAYS */
/* IERROR=0    NO ERRORS DETECTED IN TRANSFORMATION */
/*        1    ALL ZERO TRANSFER FUNCTION */
/*        2    INVALID TRANSFER FUNCTION; Y(K) COEF=0 */

#ifndef KR
void spbiln(float *d, float *c, long *ln, float *b, float *a, float *work, long *error)
#else
void spbiln(d, c, ln, b, a, work, error)
long *ln, *error;
float *d, *c, *b, *a, *work;
#endif
{
    /* Local variables */
    long i, j, l, zero_func, work_dim1;
    float scale, tmp;
    double atmp;

    zero_func = TRUE;
    for (i = *ln ; i >= 0 && zero_func ; --i)
    {
	if (c[i] != 0.0 || d[i] != 0.0)
	{
	    zero_func = FALSE;
	}
    }

    if ( zero_func )
    {
        *error = 1;
        return;
    }

    work_dim1 = *ln + 1;

    l = i + 1;
    for (j = 0 ; j <= l ; ++j)
    {
	work[j * work_dim1] = 1.0;
    }

    tmp = 1.0;
    for (i = 1 ; i <= l ; ++i)
    {
	tmp = tmp * (float) (l - i + 1) / (float) i;
	work[i] = tmp;
    }

    for (i = 1 ; i <= l ; ++i)
    {
	for (j = 1 ; j <= l ; ++j)
	{
	    work[i + j * work_dim1] = work[i + (j - 1) * work_dim1]
				      - work[i - 1 + j * work_dim1]
				      - work[i - 1 + (j - 1) * work_dim1];
	}
    }

    for (i = l ; i >= 0 ; --i)
    {
	b[i] = 0.0;
	atmp = 0.0;

	for (j = 0 ; j <= l ; ++j)
	{
	    b[i] += work[i + j * work_dim1] * d[j];
	    atmp += (double) work[i + j * work_dim1] * c[j];
	}

	scale = (double) atmp;

	if (i != 0)
	{
	    a[i - 1] = (double) atmp;
	}
    }

    if (scale == 0.0)
    {
	*error = 2;
	return;
    }

    b[0] /= scale;
    for (i = 1 ; i <= l ; ++i)
    {
	b[i] /= scale;
	a[i - 1] /= scale;
    }

    if (l < *ln)
    {
	for (i = l + 1 ; i <= *ln ; ++i)
	{
	    b[i] = 0.0;
	    a[i - 1] = 0.0;
	}
    }

    *error = 0;
    return;
} /* spbiln */

/* SPBSSL     11/13/85 */
/* GENERATES ANALOG FILTER COEFFICIENTS FOR LTH ORDER */
/*       NORMALIZED LOWPASS BESSEL FILTER */
/* COEFFICIENTS ARE RETURNED IN ARRAYS D AND C */
/* LN SPECIFIES ARRAY SIZE (LN>=L) */
/* WSCL CONTROLS FREQUENCY SCALING SUCH THAT RESPONSE AT 1 RAD/SEC */
/*       IS EQUAL TO THAT OF UNSCALED H(S) AT WSCL RAD/SEC */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID FILTER ORDER (L<=0 OR L>=LN) */
/*        2      INVALID SCALE PARAMETER (WSCL<=0) */

#ifndef KR
void spbssl(long *l, float *wscl, long *ln, float *d, float *c, long *error)
#else
void spbssl(l, wscl, ln, d, c, error)
long *l, *ln, *error;
float *d, *c, *wscl;
#endif
{
    /* Builtin functions */
    long pow_ii();
    double pow_ri();

    /* Local variables */
    double spbfct();

    long k, ll, tmp_int1, tmp_int2;

    if (*l <= 0 || *l > *ln)
    {
	*error = 1;
	return;
    }
    if (*wscl <= 0.0)
    {
	*error = 2;
	return;
    }

    for (ll = 0 ; ll <= *ln ; ++ll)
    {
	d[ll] = 0.0;
	c[ll] = 0.0;
    }

    for (k = 0 ; k <= *l ; ++k)
    {
	tmp_int1 = (*l * 2) - k;
	tmp_int2 = *l - k;

	c[k] = pow_ri(wscl, &k)
	       * spbfct(&tmp_int1,&tmp_int1) / (pow_ii(&pos_i2, &tmp_int2)
	       * spbfct(&k,&k) * spbfct(&tmp_int2,&tmp_int2));
    }

    d[0] = c[0];

    *error = 0;
    return;
} /* spbssl */

/* SPBWCF     11/13/85 */
/* GENERATES KTH SECTION COEFFICIENTS FOR LTH ORDER NORMALIZED */
/*       LOWPASS BUTTERWORTH FILTER */
/* SECOND ORDER SECTIONS: K<=(L+1)/2 */
/* ODD ORDER L:  FINAL SECTION WILL CONTAIN 1ST ORDER POLE */
/* LN DEFINES COEFFICIENT ARRAY SIZE */
/* ANALOG COEFFICIENTS ARE RETURNED IN D AND C */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID FILTER ORDER L */
/*        2      INVALID SECTION NUMBER K */

#ifndef KR
void spbwcf(long *l, long *k, long *ln, float *d, float *c, long *error)
#else
void spbwcf(l, k, ln, d, c, error)
long *l, *k, *ln, *error;
float *d, *c;
#endif
{
    /* Local variables */
    long i;
    float tmp;

    if (*l <= 0)
    {
	*error = 1;
	return;
    }

    if (*k <= 0 || *k > ((*l + 1) / 2))
    {
	*error = 2;
	return;
    }

    d[0] = 1.0;
    c[0] = 1.0;
    for (i = 1 ; i <= *ln ; ++i)
    {
	d[i] = 0.0;
	c[i] = 0.0;
    }

    tmp = (float) *k - (*l + 1.0) / 2.0;

    if (tmp == 0.0)
    {
	c[1] = 1.0;
    }
    else
    {
	c[1] = (float) (-2.0 * cos((double) ((*k * 2) + *l - 1)
				   * M_PI / (double) (*l * 2)));
	c[2] = 1.0;
    }

    *error = 0;
    return;
} /* spbwcf */

/* SPCBII     11/13/85 */
/* GENERATES KTH SECTION COEFFICIENTS FOR LTH ORDER NORMALIZED */
/*       LOWPASS CHEBYSHEV TYPE II ANALOG FILTER */
/* SECOND ORDER SECTIONS:  K<= (L+1)/2 */
/* ODD ORDER L:  FINAL SECTION WILL CONTAIN SINGLE POLE */
/* LN DEFINES COEFFICIENT ARRAY SIZE */
/* WS AND ATT REGULATE STOPBAND ATTENUATION */
/*       MAGNITUDE WILL BE 1/ATT AT WS RAD/SEC */
/* ANALOG COEFFICIENTS ARE RETURNED IN ARRAYS D AND C */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID FILTER ORDER L */
/*        2      INVALID SECTION NUMBER K */
/*        3      INVALID STOPBAND FREQUENCY WS */
/*        4      INVALID ATTENUATION PARAMETER */

#ifndef KR
void spcbii(long *l, long *k, long *ln, float *ws, float *att, float *d, float *c, long *error)
#else
void spcbii(l, k, ln, ws, att, d, c, error)
long *l, *k, *ln, *error;
float *ws, *att, *d, *c;
#endif
{
    /* Local variables */
    long ll;
    float beta, scld, scln, alpha, omega, sigma, gam, tmp_float;

    if (*l <= 0)
    {
	*error = 1;
	return;
    }
    if (*k > ((*l + 1) / 2) || *k < 1)
    {
	*error = 2;
	return;
    }
    if (*ws <= 1.0)
    {
	*error = 3;
	return;
    }
    if (*att <= 0.0)
    {
	*error = 4;
	return;
    }

    gam = pow((double) (*att + sqrt((double) (*att * *att - 1.0))),
	      (double) (1.0 / (double) *l));

    alpha = 0.5 * (1.0 / gam - gam)
	    * (float) sin((double) ((*k * 2) - 1)
			  * M_PI / (double) (*l * 2));

    beta = 0.5 * (gam + 1.0 / gam)
	    * (float) cos((double) ((*k * 2) - 1)
			  * M_PI / (double) (*l * 2));

    sigma = (*ws * alpha) / (alpha * alpha + beta * beta);

    omega = (-1.0 * *ws * beta) / (alpha * alpha + beta * beta);

    for (ll = 0 ; ll <= *ln ; ++ll)
    {
	d[ll] = 0.0;
	c[ll] = 0.0;
    }

    if ((*l / 2) != ((*l + 1) / 2) && *k == ((*l + 1) / 2))
    {
	d[0] = -1.0 * sigma;
	c[0] = d[0];
	c[1] = 1.0;

	*error = 0;
	return;
    }

    scln = sigma * sigma + omega * omega;

    tmp_float = *ws / (float) cos((double) ((*k * 2) - 1)
				  * M_PI / (double) (*l * 2));
    scld = tmp_float * tmp_float;

    d[0] = scln * scld;
    d[2] = scln;
    c[0] = d[0];
    c[1] = -2.0 * sigma * scld;
    c[2] = scld;

    *error = 0;
    return;
} /* spcbii */

/* SPCFLT     11/13/85 */
/* FILTERS N-POINT DATA SEQUENCE IN PLACE USING ARRAY X */
/* TRANSFER FUNCTION IS COMPOSED OF NS SECTIONS IN CASCADE WITH */
/*       MTH STAGE TRANSFER FUNCTION */
/*            B(0,M)+B(1,M)*Z**(-1)+......+B(LS,M)*Z**(-LS) */
/*     H(Z) = ------------------------------------------- */
/*               1+A(1,M)*Z**(-1)+.......+A(LS,M)*Z**(-LS) */
/* PX RETAINS PAST VALUES OF INPUT X */
/* PY RETAINS PAST VALUES OF OUTPUT Y */
/* IERROR=0    NO ERRORS DETECTED */
/*     1 - NS  OUTPUT AT STAGE [IERROR] EXCEEDS 1.E10 */

#ifndef KR
void spcflt(float *b, float *a, long *ls, long *ns, float *x, long *n, float *px, float *py, long *error)
#else
void spcflt(b, a, ls, ns, x, n, px, py, error)
long *ls, *ns, *n, *error;
float *px, *py, *b, *a, *x;
#endif
{
    /* Local variables */
    long k, m, ll, b_dim1, a_dim1, px_dim1, py_dim1;

    b_dim1 = *ls + 1;
    a_dim1 = *ls;
    px_dim1 = *ls + 1;
    py_dim1 = *ls;

    for (m = 0 ; m < *ns ; ++m)
    {
	for (k = 0 ; k < *n ; ++k)
	{
	    px[m * px_dim1] = x[k];
	    x[k] = b[m * b_dim1] * px[m * px_dim1];

	    for (ll = 1 ; ll <= *ls ; ++ll)
	    {
		x[k] = x[k] + b[ll + m * b_dim1] * px[ll + m * px_dim1]
		       - a[ll - 1 + m * a_dim1] * py[ll - 1 + m * py_dim1];
	    }

	    if (ABS(x[k]) > BIG)
	    {
		*error = m;
		return;
	    }

	    for (ll = *ls ; ll >= 2 ; --ll)
	    {
		px[ll + m * px_dim1] = px[ll - 1 + m * px_dim1];
		py[ll - 1 + m * py_dim1] = py[ll - 2 + m * py_dim1];
	    }

	    px[m * px_dim1 + 1] = px[m * px_dim1];
	    py[m * py_dim1] = x[k];
	}
    }

    *error = 0;
    return;
} /* spcflt */

/* SPCHBI     11/13/85 */
/* GENERATES KTH SECTION COEFFICIENTS FOR LTH ORDER NORMALIZED */
/*             LOWPASS CHEBYSHEV TYPE I ANALOG FILTER */
/* SECOND ORDER SECTIONS:  K<=(L+1)/2 */
/* ODD ORDER L: LAST SECTION WILL CONTAIN SINGLE POLE */
/* LN DEFINES COEFFICIENT ARRAY SIZE */
/* EP REGULATES THE PASSBAND RIPPLE */
/* TRANSFER FUNCTION SCALING IS INCLUDED IN FIRST SECTION (L EVEN) */
/* ANALOG COEFFICIENTS ARE RETURNED IN D AND C */
/* IERROR=0    NO ERRORS DETECTED */
/*        1    INVALID FILTER ORDER L */
/*        2    INVALID SECTION NUMBER K */
/*        3    INVALID RIPPLE PARAMETER EP */

#ifndef KR
void spchbi(long *l, long *k, long *ln, float *ep, float *d, float *c, long *error)
#else
void spchbi(l, k, ln, ep, d, c, error)
long *l, *k, *ln, *error;
float *ep, *d, *c;
#endif
{
    /* Local variables */
    long ll;
    float omega, sigma, gam;

    if (*l <= 0)
    {
	*error = 1;
	return;
    }
    if (*k <= 0 || *k > ((*l + 1) / 2))
    {
	*error = 2;
	return;
    }
    if (*ep <= 0.0)
    {
	*error = 3;
	return;
    }

    gam = pow((1.0 + sqrt((double) (1.0 + *ep * *ep))) / (double) *ep,
	      1.0 / (double) *l);

    sigma = 0.5 * (1.0 / gam - gam)
	    * (float) sin((double) ((*k * 2) - 1)
			  * M_PI / (double) (*l * 2));

    omega = 0.5 * (gam + 1.0 / gam)
	    * (float) cos((double) ((*k * 2) - 1)
			  * M_PI / (double) (*l * 2));

    for (ll = 0 ; ll <= *ln ; ++ll)
    {
	d[ll] = 0.0;
	c[ll] = 0.0;
    }

    if ((*l / 2) != ((*l + 1) / 2) && *k == ((*l + 1) / 2))
    {
	d[0] = -1.0 * sigma;
	c[0] = d[0];
	c[1] = 1.0;

	*error = 0;
	return;
    }

    c[0] = sigma * sigma + omega * omega;
    c[1] = -2.0 * sigma;
    c[2] = 1.0;
    d[0] = c[0];

    if ((*l / 2) == ((*l + 1) / 2) && *k == 1)
    {
	d[0] /= sqrt((double) (1.0 + *ep * *ep));
    }

    *error = 0;
    return;
} /* spchbi */

/* SPCHRP     11/27/85 */
/* COMPUTES THE CHIRP-Z TRANSFORM OF A COMPLEX SEQUENCE. */
/* X=COMPLEX INPUT ARRAY CONTAINING THE COMPLEX SEQUENCE. */
/* LX=LAST INDEX IN THE ARRAY X(0:LX).  LX+1 MUST BE A POWER OF 2. */
/* LX1=LAST INDEX OF THE COMPLEX INPUT SEQUENCE, X(0)...X(LX1). */
/*     LX1 MUST BE LESS THAN LX. */
/* F1=FREQUENCY OF FIRST DFT COMPONENT.  (SAMPLING FREQ.=1.0.) */
/* F2=FREQUENCY OF LAST DFT COMPONENT, GREATER THEN F1. */
/* WORK=COMPLEX WORK ARRAY, DIMENSIONED COMPLEX WORK(0:LX). */
/* AFTER EXECUTION DFT COMPONENTS, SPACED EVENLY FROM F1 THRU F2, */
/*   ARE STORED IN X(0)...X(LX2).  THE ORIGINAL TIME SERIES IS LOST. */
/* LX2=LAST FREQUENCY INDEX AS ABOVE, COMPUTED AS LX2=LX-LX1 DURING */
/*      EXECUTION OF THE ROUTINE. */
/* IERROR=0  NO ERRORS */
/*        1  LX IS NOT GREATER THAN LX1 */
/*        2  F2 IS NOT GREATER THAN F1 */
/*        3  LX+1 IS NOT A POWER OF 2 */

#ifndef KR
void spchrp(complex *x, long *lx, long *lx1, float *f1, float *f2, complex *work, long *lx2, long *error)
#else
void spchrp(x, lx, lx1, f1, f2, work, lx2, error)
long *lx, *lx1, *lx2, *error;
float *f1, *f2;
complex *x, *work;
#endif
{
    /* Builtin functions */
    void complex_exp(), pow_ci();

    /* Local variables */
    void spfftc();

    long k, lxc, tmp_int;
    float tp, tmp_float;
    complex w2, am1, tmp_complex1, tmp_complex2;

    tp = (float) (2.0 * M_PI);

    *lx2 = *lx - *lx1;
    if (*lx2 < 1)
    {
	*error = 1;
	return;
    }
    if (*f1 >= *f2)
    {
	*error = 2;
	return;
    }

    lxc = 1;
    lxc = (lxc * 2) + 1;
    while ((lxc - *lx) < 0)
    {
	lxc = (lxc * 2) + 1;
    }

    if ((lxc - *lx) == 0)
    {
	tmp_complex1.r = 0.0;
	tmp_complex1.i = -tp * *f1;

	complex_exp(&am1, &tmp_complex1);

	tmp_complex1.r = 0.0;
	tmp_complex1.i = -tp * (*f2 - *f1) / ((float) *lx2 * 2.0);

	complex_exp(&w2, &tmp_complex1);

	for (k = 0 ; k <= *lx ; ++k)
	{
	    if (k <= *lx1)
	    {
		pow_ci(&tmp_complex1, &w2, &k);

		tmp_complex2.r = am1.r * tmp_complex1.r
				 - am1.i * tmp_complex1.i;
		tmp_complex2.i = am1.r * tmp_complex1.i
				 + am1.i * tmp_complex1.r;

		pow_ci(&tmp_complex1, &tmp_complex2, &k);

		work[k].r = tmp_complex1.r * x[k].r
			    - tmp_complex1.i * x[k].i;
		work[k].i = tmp_complex1.r * x[k].i
			    + tmp_complex1.i * x[k].r;
	    }

	    if (k > *lx1)
	    {
		work[k].r = 0.0;
		work[k].i = 0.0;
	    }

	    if (k <= *lx2)
	    {
		tmp_int = -k * k;
		pow_ci(&x[k], &w2, &tmp_int);
	    }

	    if (k > *lx2)
	    {
		tmp_int = -((1 + *lx - k) * (1 + *lx - k));
		pow_ci(&x[k], &w2, &tmp_int);
	    }
	}

	tmp_int = 1 + *lx;
	spfftc(work, &tmp_int, &neg_i1);
	tmp_int = 1 + *lx;
	spfftc(x, &tmp_int, &neg_i1);

	for (k = 0 ; k <= *lx ; ++k)
	{
	    tmp_float = x[k].r * work[k].r - x[k].i * work[k].i;
	    x[k].i = x[k].r * work[k].i + x[k].i * work[k].r;
	    x[k].r = tmp_float;
	}

	tmp_int = 1 + *lx;
	spfftc(x, &tmp_int, &pos_i1);

	for (k = 0 ; k <= *lx2 ; ++k)
	{
	    tmp_int = k * k;
	    pow_ci(&tmp_complex1, &w2, &tmp_int);
	    tmp_float = (x[k].r * tmp_complex1.r
		        - x[k].i * tmp_complex1.i) / (float) (1 + *lx);
	    x[k].i = (x[k].r * tmp_complex1.i
		     + x[k].i * tmp_complex1.r) / (float) (1 + *lx);
	    x[k].r = tmp_float;
	}

	*error = 0;
    }
    else
    {
	*error = 3;
    }

    return;
} /* spchrp */

/* SPCOMP     02/20/87 */
/* COMPUTES A SINGLE COMPLEX DFT COMPONENT OF A REAL VECTOR X. */
/* X MUST BE SPECIFIED DIMENSION X(0:N-1) OR LARGER. */
/* INPUTS ARE X(0),X(1),...,X(N-1) = REAL DATA SEQUENCE, */
/*            N=NO. OF DATA SAMPLES. */
/*            F=FREQUENCY IN HZ-S; SAMPLING FREQUENCY=1.0. */
/* OUTPUT IS COMPLEX SPCOMP=COMPLEX DFT COMPONENT.  NOTE THAT */
/* SPCOMP MUST BE DECLARED COMPLEX IN CALLING PROGRAM. */

#ifndef KR
complex spcomp(float *x, long *n, float *f)
#else
complex spcomp(x, n, f)
long *n;
float *x, *f;
#endif
{
    /* Builtin functions */
    void complex_exp();

    /* Local variables */
    long k;
    complex ret_val, tmp_complex1, tmp_complex2;
    float rad;

    rad = (float) (2.0 * M_PI * *f);

    ret_val.r = x[0];
    ret_val.i = 0.0;

    for (k = 1 ; k < *n ; ++k)
    {
	tmp_complex1.r = 0.0;
	tmp_complex1.i = (float) -k * rad;

	complex_exp(&tmp_complex2, &tmp_complex1);

	ret_val.r += x[k] * tmp_complex2.r;
	ret_val.i += x[k] * tmp_complex2.i;
    }

    return(ret_val);
} /* spcomp */

/* SPCONV     10/15/90 */
/* FAST CONVOLUTION OF SEQUENCES X AND Y. */
/* X AND Y SHOULD BE DIFFERENT VECTORS, DIMENSIONED X(0:L) AND Y(0:L). */

/* L=LAST INDEX IN BOTH X AND Y.  MUST BE (POWER OF 2)+1 AND AT LEAST 5. */
/* NMIN=MINIMUM SHIFT OF INTEREST IN THE CONVOLUTION FUNCTION. */
/* FFT LENGTH ,N, USED INTERNALLY, IS N = L-1. */
/* LET K=INDEX OF LAST NONZERO SAMPLE IN Y(0)---Y(N-1).  THEN X(0) */
/*  THRU X(N-1) MUST INCLUDE PADDING OF AT LEAST K-NMIN-1 ZEROS. */
/* CONVOLUTION FUNCTION (OUTPUT) REPLACES X(NMIN) THRU X(N-1). */
/* IERROR=0  NO ERROR DETECTED */
/*        1  L-1 NOT A POWER OF 2 */
/*        2  NMIN OUT OF RANGE */
/*        3  INADEQUATE ZERO PADDING */

#ifndef KR
void spconv(float *x, float *y, long *l, long *nmin, long *error)
#else
void spconv(x, y, l, nmin, error)
long *l, *nmin, *error;
float *x, *y;
#endif
{
    /* Local variables */
    void spfftr(), spiftr();

    long j, k, m, n;
    complex cx;
    float test;

    n = *l - 1;
    if (*nmin < 0 || *nmin >= n)
    {
	*error = 2;
	return;
    }

    test = (float) n;
    test /= 2.0;

    while ((test - 2.0) > 0.0)
    {
	test /= 2.0;
    }

    if ((test - 2.0) == 0)
    {
	for (k = n - 1 ; k >= 0 && y[k] == 0.0 ; --k) ;

	for (j = n - 1 ; j >= 0 && x[j] == 0.0 ; --j) ;

	if ((n - j) <= (k - *nmin))
	{
	    *error = 3;
	    return;
	}

	spfftr(x, &n);
	spfftr(y, &n);

	for (m = 0 ; m <= (n / 2) ; ++m)
	{
	    cx.r = x[m * 2] * y[m * 2] - x[(m * 2) + 1] * y[(m * 2) + 1];
	    cx.i = x[m * 2] * y[(m * 2) + 1] + x[(m * 2) + 1] * y[m * 2];

	    x[m * 2] = cx.r / n;
	    x[(m * 2) + 1] = cx.i / n;
	}

	spiftr(x, &n);

	*error = 0;
    }
    else if ((test - 2.0) < 0.0)
    {
	*error = 1;
    }

    return;
} /* spconv */

/* SPCORR     09/18/86 */
/* FAST CORRELATION OF X(0:L) AND Y(0:L).  FINDS RXY(0) THRU RXY(NMAX). */
/* L=LAST INDEX IN BOTH X AND Y.  MUST BE (POWER OF 2)+1 AND AT LEAST 5. */
/* ITYPE=TYPE OF CORRELATION=0 IF X AND Y ARE THE SAME VECTOR (AUTO- */
/*         CORRELATION), OR NOT 0 IF X AND Y ARE DIFFERENT VECTORS. */
/* NMAX=MAXIMUM LAG OF INTEREST IN THE CORRELATION FUNCTION. */
/* FFT LENGTH ,N, USED INTERNALLY, IS L-1. */
/* LET K=INDEX OF FIRST NONZERO SAMPLE IN Y(0)---Y(N-1).  THEN X(0) */
/*  THRU X(N-1) MUST INCLUDE PADDING OF AT LEAST NMAX-K ZEROS. */
/* CORRELATION FUNCTION, RXY, REPLACES X(0) THRU X(NMAX). */
/* Y(0) THRU Y(L) IS REPLACED BY ITS FFT, COMPUTED USING SPFFTR. */
/* IERROR=0  NO ERROR DETECTED */
/*        1  L-1 NOT A POWER OF 2 */
/*        2  NMAX OUT OF RANGE */
/*        3  INADEQUATE ZERO PADDING */

#ifndef KR
void spcorr(float *x, float *y, long *l, long *type, long *nmax, long *error)
#else
void spcorr(x, y, l, type, nmax, error)
long *l, *type, *nmax, *error;
float *x, *y;
#endif
{
    /* Local variables */
    void spfftr(), spiftr();

    long j, k, m, n;
    complex cx;
    float test;

    n = *l - 1;
    if (*nmax < 0 || *nmax >= n)
    {
	*error = 2;
	return;
    }

    test = (float) n;
    test /= 2.0;

    while ((test - 2.0) > 0.0)
    {
	test /= 2.0;
    }

    if ((test - 2.0) == 0)
    {
	for (k = 0 ; k < n && y[k] == 0.0 ; ++k) ;

	for (j = n - 1 ; j >= 0 && x[j] == 0.0 ; --j) ;

	if ((n - 1 - j) < (*nmax - k))
	{
	    *error = 3;
	    return;
	}

	spfftr(x, &n);
	if (*type != 0)
	{
	    spfftr(y, &n);
	}

	for (m = 0 ; m <= (n / 2) ; ++m)
	{
	    cx.r = x[m * 2] * y[m * 2] - -x[(m * 2) + 1] * y[(m * 2) + 1];
	    cx.i = x[m * 2] * y[(m * 2) + 1] + -x[(m * 2) + 1] * y[m * 2];

	    x[m * 2] = cx.r / n;
	    x[(m * 2) + 1] = cx.i / n;
	}

	spiftr(x, &n);

	*error = 0;
    }
    else if ((test - 2.0) < 0.0)
    {
	*error = 1;
    }

    return;
} /* spcorr */

/* SPCROS     05/15/90 */
/* SIMILAR TO SPPOWR, BUT FOR THE AVG. CROSS-SPECTRUM OF 2 SEQUENCES. */
/* X1(0) THRU X1(LX) AND X2(0) THRU X2(LX) ARE THE INPUT DATA SEQUENCES. 
*/
/* COMPLEX Y(0),Y(1),---,Y(LY)=OUTPUT SPECTRUM.  LY=POWER OF 2. */
/* WORK=COMPLEX WORK ARRAY DIMENSIONED AT LEAST WORK(0:2*LY-1). */
/* LX=LAST INDEX IN INPUT DATA SEQUENCES AS ABOVE. */
/* LY=FREQUENCY INDEX CORRESP. TO HALF SAMPLING RATE=POWER OF 2. */
/* SEGMENT LENGTH IS 2*LY.  DATA LENGTH (LX+1) MUST BE AT LEAST THIS BIG. */
/* IWINDO=DATA WINDOW TYPE, 1(RECTANGULAR), 2(TAPERED RECTANGULAR), */
/*   3(TRIANGULAR), 4(HANNING), 5(HAMMING), OR 6(BLACKMAN).  SEE CH. 14. 
*/
/* OVRLAP=FRACTION THAT EACH DATA SEGMENT OF SIZE 2*LY OVERLAPS ITS */
/*  PREDECESSOR.  MUST BE GREATER THAN OR EQUAL 0 AND LESS THAN 1. */
/* NSGMTS=NO. OVERLAPPING SEGMENTS OF X AVERAGED TOGETHER.  OUTPUT. */
/* IERROR=0  NO ERROR DETECTED. */
/*        1  IWINDO OUT OF RANGE (1-6). */
/*        2  LX TOO SMALL, I.E., LESS THAN 2*LY-1. */
/*        3  LY NOT A POWER OF 2. */

#ifndef KR
void spcros(float *x1, float *x2, complex *y, complex *work, long *lx, long *ly, long *iwindo, float *ovrlap, long *nsgmts, long *error)
#else
void spcros(x1, x2, y, work, lx, ly, iwindo, ovrlap, nsgmts, error)
long *lx, *ly, *iwindo, *nsgmts, *error;
complex *y, *work;
float *ovrlap, *x1, *x2;
#endif
{
    /* Builtin functions */
    void r_cnjg();

    /* Local variables */
    void spfftc();
    double spwndo();

    long m, tmp_int, index, nsamp, isegmt, nshift;
    complex p, q, u, v, tmp_complex1;
    float base;
    double w, tsv;

    if (*iwindo < 1 || *iwindo > 6)
    {
        *error = 1;
	return;
    }
    if ((*lx + 1) < (*ly * 2))
    {
        *error = 2;
	return;
    }

    base = (float) (*ly);
    base /= 2.0;

    while ((base - 2.0) > 0.0)
    {
	base /= 2.0;
    }

    if ((base - 2.0) == 0)
    {
	for (m = 0 ; m <= *ly ; ++m)
	{
	    y[m].r = 0.0;
	    y[m].i = 0.0;
	}

	nshift = MIN(MAX((long) ((*ly * 2) * (1.0 - *ovrlap) + 0.5), 1),
		     *ly * 2);

	*nsgmts = 1 + (*lx + 1 - (*ly * 2)) / nshift;

	tsv = 0.0;

	for (isegmt = 0 ; isegmt < *nsgmts ; ++isegmt)
	{
	    for (nsamp = 0 ; nsamp < (*ly * 2) ; ++nsamp)
	    {
		tmp_int = *ly * 2;

		w = spwndo(iwindo, &tmp_int, &nsamp);

		if (isegmt == 0)
		{
		    tsv += w * w;
		}

		index = nshift * isegmt + nsamp;
		work[nsamp].r = (float) w * x1[index];
		work[nsamp].i = (float) w * x2[index];
	    }

	    tmp_int = *ly * 2;
	    spfftc(work, &tmp_int, &neg_i1);

	    y[0].r += work[0].r * work[0].i / (tsv *  (double) *nsgmts);

	    for (m = 1 ; m <= *ly ; ++m)
	    {
		p.r = work[m].r + work[(*ly * 2) - m].r;
		p.i = work[m].i + work[(*ly * 2) - m].i;
		q.r = work[m].r - work[(*ly * 2) - m].r;
		q.i = work[m].i - work[(*ly * 2) - m].i;
		u.r = p.r * 0.5;
		u.i = q.i * 0.5;
		v.r = p.i * 0.5;
		v.i = -q.r * 0.5;
		r_cnjg(&tmp_complex1, &u);
		y[m].r = y[m].r + (tmp_complex1.r * v.r - tmp_complex1.i * v.i)
			 / (tsv * *nsgmts);
		y[m].i = y[m].i + (tmp_complex1.r * v.i + tmp_complex1.i * v.r)
			 / (tsv * *nsgmts);
	    }
	}

	*error = 0;
    }
    else if ((base - 2.0) < 0.0)
    {
	*error = 3;
    }

    return;
} /* spcros */

/* SPDECI     11/20/85 */
/* LINEAR DECIMATION OF A SEQUENCE OF EQUALLY-SPACED SAMPLES. */
/* X(0:LX)=ORIGINAL DATA VECTOR WITH STEP SIZE T1, TO BE INCREASED */
/*         TO T2. */
/* LX=LAST INDEX OF ORIGINAL SEQUENCE, X(0) --- X(LX). (INPUT.) */
/* RATIO=T2/T1=STEP SIZE RATIO.  MUST BE GE 1.0 AND LE LX.  (INPUT.) */
/* LX2=LAST INDEX OF DECIMATED SEQUENCE=LX/RATIO.  (OUTPUT.) */
/* IERROR=0 IF NO ERROR DETECTED, 1 IF RATIO IS OUT OF RANGE. */
/* COMPUTATION IS IN PLACE.  NEW SEQUENCE REPLACES X(0) THROUGH X(LX2). */
/* THE REMAINING ELEMENTS IN X, X(LX2+1) THROUGH X(LX), ARE SET TO ZEROS. */

#ifndef KR
void spdeci(float *x, long *lx, float *ratio, long *lx2, long *error)
#else
void spdeci(x, lx, ratio, lx2, error)
long *lx, *lx2, *error;
float *x, *ratio;
#endif
{
    /* Local variables */
    long k, k1;

    if (*ratio < 1.0 || *ratio > (float) (*lx))
    {
	*error = 1;
	return;
    }

    *lx2 = *lx / *ratio;
    for (k = 1 ; k <= *lx ; ++k)
    {
	k1 = k * *ratio;

	if (k <= *lx2)
	{
	    x[k] = x[k1] + ((float) k * *ratio - (float) k1)
			   * (x[k1 + 1] - x[k1]);
	}
	else
	{
	    x[k] = 0.0;
	}
    }

    *error = 0;
    return;
} /* spdeci */

/* SPDFTC     02/20/87 */
/* COMPUTES THE DFT OF A COMPLEX VECTOR X HAVING N COMPLEX SAMPLES. */
/* X AND Y ARE COMPLEX X(0:N-1) AND Y(0:N-1) OR LARGER. */
/* INPUTS ARE X(0),X(1),...,X(N-1)=COMPLEX DATA VECTOR. */
/*            N=NUMBER OF DATA SAMPLES. */
/*            ISIGN=-1 FOR FORWARD OR +1 FOR INVERSE TRANSFORM. */
/* OUTPUTS ARE Y(0),Y(1),...,Y(N-1)=COMPLEX DFT COMPONENTS, WITH */
/*   COSINE COMPONENT=REAL PART AND SINE COMPONENT=IMAGINARY PART. */
/* Y AND X CANNOT BE THE SAME ARRAY. */

#ifndef KR
void spdftc(complex *x, complex *y, long *n, long *isign)
#else
void spdftc(x, y, n, isign)
long *n, *isign;
complex *x, *y;
#endif
{
    /* Builtin functions */
    void complex_exp();

    /* Local variables */
    long k, m;
    complex tmp_complex1, tmp_complex2, tpjn;

    tpjn.r = 0.0;
    tpjn.i = (float) (2.0 * (double) *isign * M_PI / (double) *n);

    for (m = 0 ; m < *n ; ++m)
    {
	y[m].r = x[0].r;
	y[m].i = x[0].i;

	for (k = 1 ; k < *n ; ++k)
	{
	    tmp_complex1.r = (float) m * (float) k * tpjn.r;
	    tmp_complex1.i = (float) m * (float) k * tpjn.i;

	    complex_exp(&tmp_complex2, &tmp_complex1);

	    y[m].r += x[k].r * tmp_complex2.r - x[k].i * tmp_complex2.i;
	    y[m].i += x[k].r * tmp_complex2.i + x[k].i * tmp_complex2.r;
	}
    }

    return;
} /* spdftc */

/* SPDFTR     10/26/90 */
/* COMPUTES THE DFT OF A REAL VECTOR X CONTAINING N DATA SAMPLES. */
/* X IS DIMENSIONED X(0:N-1) OR LARGER. */
/* Y IS COMPLEX Y(0:N/2) IF N EVEN, OR Y(0:(N-1)/2) IF N ODD. */
/* INPUTS ARE X(0),X(1),...,X(N-1) AND N=NUMBER OF DATA SAMPLES. */
/* OUTPUTS Y(0),Y(1),...,Y(N/2) IF N EVEN, OR Y(0),Y(1),..., */
/*   Y((N-1)/2) IF N ODD, ARE THE COMPLEX DFT COMPONENTS, WITH */
/*   COSINE COMPONENT=REAL PART AND SINE COMPONENT=IMAGINARY PART. */
/* Y AND X CANNOT BE THE SAME ARRAY. */

#ifndef KR
void spdftr(float *x, complex *y, long *n)
#else
void spdftr(x, y, n)
long *n;
complex *y;
float *x;
#endif
{
    /* Builtin functions */
    void complex_exp();

    /* Local variables */
    long k, m;
    complex tmp_complex1, tmp_complex2, tpjn;

    tpjn.r = 0.0;
    tpjn.i = (float) (-2.0 * M_PI / (double) *n);

    for (m = 0 ; m <= (*n / 2) ; ++m)
    {
	y[m].r = x[0];
	y[m].i = 0.0;

	for (k = 1 ; k < *n ; ++k)
	{
	    tmp_complex1.r = (float) m * (float) k * tpjn.r;
	    tmp_complex1.i = (float) m * (float) k * tpjn.i;

	    complex_exp(&tmp_complex2, &tmp_complex1);

	    y[m].r += x[k] * tmp_complex2.r;
	    y[m].i += x[k] * tmp_complex2.i;
	}
    }

    return;
} /* spdftr */

/* SPDURB     09/16/91 */
/* DURBIN'S ALGORITHM - SPECIAL CASE OF LEVINSON'S ALGORITHM */
/* AAVECT(0:L+1) = AUGMENTED A DATA VECTOR */
/* B(0:L) = SOLUTION VECTOR RETURNED */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID L   <0 */
/*        2      AAVECT(0) TOO SMALL -- <1.E-10 */
/*	  3      SINGULAR CONDITION: SCL DROPS >5 ORDERS OF MAGNITUDE */
/*				     OR RMS ERROR DECREASES BY <1% */

#ifndef KR
void spdurb(float *aavect, long *l, float *b, long *error)
#else
void spdurb(aavect, l, b, error)
long *l, *error;
float *aavect, *b;
#endif
{
    /* Local variables */
    long i, nn;
    float beta, s, s0, scl, tmp;
    double gamma, gammap;

    if (*l < 0)
    {
	*error = 1;
	return;
    }
    if (ABS(aavect[0]) < SMALL)
    {
	*error = 2;
	return;
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	b[i] = 0.0;
    }

    b[0] = -aavect[1] / aavect[0];
    s0 = -b[0] * aavect[1];
    *error = 0;

    if (*l != 0)
    {
	for (nn = 1 ; nn <= *l ; ++nn)
	{
	    gamma = 0.0;
	    gammap = 0.0;

	    for (i = 1 ; i <= nn ; ++i)
	    {
		gamma -= (double) aavect[i] * b[nn - i];
		gammap -= (double) aavect[i] * b[i - 1];
	    }

	    scl = aavect[0] - (float) gammap;
	    if (ABS(scl/aavect[0]) < ORDER5)
	    {
		*error = 3;
		break;
	    }

	    beta = -(aavect[nn + 1] - (float) gamma) / scl;

	    for (i = 0 ; i <= ((nn - 2) / 2) ; ++i)
	    {
		tmp = b[i];
		b[i] += beta * b[nn - 1 - i];
		if (nn > 1)
		{
		    b[nn - 1 - i] += beta * tmp;
		}
	    }

	    if (((nn - 2) / 2) != ((nn - 1) / 2))
	    {
		b[(nn - 1) / 2] += beta * b[(nn - 1) / 2];
	    }

	    b[nn] = beta;

	    s = -b[0] * aavect[1];
	    for (i = 1 ; i <= nn ; ++i)
	    {
		s -= b[i] * aavect[i+1];
	    }

	    if ((s0 < SMALL && s <= SMALL) ||
		(s0 > SMALL && (s - s0)/s0 < ORDER4))
	    {
		*error = 3;
		break;
	    }
	    s0 = s;
	}
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	b[i] = -b[i];
    }

    return;
} /* spdurb */

/* SPEXPN     11/13/85 */
/* FITS EXPONENTIAL CURVE TO DATA IN ARRAYS X(0:N-1) AND Y(0:N-1) */
/* N SPECIFIES NUMBER OF DATA POINTS */
/* EQUATION: Y=A(B**X)    A,B ARE RETURNED */
/* DATA IN ARRAY Y IS CHANGED TO LOG DATA INTERNALLY */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 */
/*        2      SPLFIT ERROR = 2 */
/*        3      Y DATA VALUE <=0.  CANNOT COMPUTE LOG */

#ifndef KR
void spexpn(float *x, float *y, long *n, float *a, float *b, long *error)
#else
void spexpn(x, y, n, a, b, error)
long *n, *error;
float *x, *y, *a, *b;
#endif
{
    /* Local variables */
    void splfit();

    long i;
    float alg, blg;

    if (*n <= 0)
    {
	*error = 1;
	return;
    }

    *a = 0.0;
    *b = 0.0;

    for (i = 0 ; i < *n ; ++i)
    {
	if (y[i] <= 0.0)
	{
	    *error = 3;
	    return;
	}

	y[i] = (float) log10((double) y[i]);
    }

    splfit(x, y, n, &blg, &alg, error);

    if (*error != 0)
    {
	return;
    }

    *a = (float) pow(pos_d10, (double) alg);
    *b = (float) pow(pos_d10, (double) blg);

    return;
} /* spexpn */

/* SPFBLT     10/26/90 */
/* CONVERTS NORMALIZED LP ANALOG H(S) TO DIGITAL H(Z) */
/*       ANALOG TRANSFER FUNCTION           DIGITAL TRANSFER FUNCTION */
/*        D(M)*S**M+.....+D(0)               B(0)+.....+B(L)*Z**-L */
/*   H(S)=--------------------          H(Z)=-------------------- */
/*        C(M)*S**M+.....+C(0)                 1+......+A(L)*Z**-L */
/* FILTER ORDER L IS COMPUTED INTERNALLY */
/* IBAND=1    LOWPASS            FLN=NORMALIZED CUTOFF IN HZ-SEC */
/*       2    HIGHPASS           FLN=NORMALIZED CUTOFF IN HZ-SEC */
/*       3    BANDPASS           FLN=LOW CUTOFF; FHN=HIGH CUTOFF */
/*       4    BANDSTOP           FLN=LOW CUTOFF; FHN=HIGH CUTOFF */
/* LN SPECIFIES COEFFICIENT ARRAY SIZE */
/* WORK(0:LN,0:LN) IS A WORK ARRAY USED INTERNALLY */
/* RETURN IERROR=0    NO ERRORS DETECTED */
/*               1    ALL ZERO TRANSFER FUNCTION */
/*               2    SPBILN: INVALID TRANSFER FUNCTION */
/*               3    FILTER ORDER EXCEEDS ARRAY SIZE */
/*               4    INVALID FILTER TYPE PARAMETER (IBAND) */
/*               5    INVALID CUTOFF FREQUENCY */

#ifndef KR
void spfblt(float *d, float *c, long *ln, long *iband, float *fln, float *fhn, float *b, float *a, float *work, long *error)
#else
void spfblt(d, c, ln, iband, fln, fhn, b, a, work, error)
long *ln, *iband, *error;
float *d, *c, *fln, *fhn, *b, *a, *work;
#endif
{
    /* Builtin functions */
    double pow_ri();

    /* Local variables */
    double spbfct();
    void spbiln();

    long work_dim1, tmp_int, i, k, l, m, zero_func, ll, mm, ls;
    float tmpc, tmpd, w, w1, w2, w02, tmp;

    if (*iband < 1 || *iband > 4)
    {
	*error = 4;
	return;
    }
    if ((*fln <= 0.0 || *fln > 0.5) ||
	(*iband >= 3 && ( *fln >= *fhn || *fhn > 0.5 )))
    {
	*error = 5;
	return;
    }

    zero_func = TRUE;
    for (i = *ln ; i >= 0 && zero_func ; --i)
    {
	if (c[i] != 0.0 || d[i] != 0.0)
	{
	    zero_func = FALSE;
	}
    }

    if ( zero_func ) 
    {
        *error = 1;
        return;
    }

    work_dim1 = *ln + 1;

    m = i + 1;
    w1 = (float) tan(M_PI * *fln);
    l = m;
    if (*iband > 2)
    {
        l = m * 2;
        w2 = (float) tan(M_PI * *fhn);
        w = w2 - w1;
        w02 = w1 * w2;
    }

    if (l > *ln)
    {
	*error = 3;
	return;
    }

    switch (*iband)
    {
	case 1:

/* SCALING S/W1 FOR LOWPASS,HIGHPASS */

	    for (mm = 0 ; mm <= m ; ++mm)
	    {
		d[mm] /= pow_ri(&w1, &mm);
		c[mm] /= pow_ri(&w1, &mm);
	    }

	    break;

	case 2:

/* SUBSTITUTION OF 1/S TO GENERATE HIGHPASS (HP,BS) */

	    for (mm = 0 ; mm <= (m / 2) ; ++mm)
	    {
		tmp = d[mm];
		d[mm] = d[m - mm];
		d[m - mm] = tmp;
		tmp = c[mm];
		c[mm] = c[m - mm];
		c[m - mm] = tmp;
	    }

/* SCALING S/W1 FOR LOWPASS,HIGHPASS */

	    for (mm = 0 ; mm <= m ; ++mm)
	    {
		d[mm] /= pow_ri(&w1, &mm);
		c[mm] /= pow_ri(&w1, &mm);
	    }

	    break;

	case 3:

/* SUBSTITUTION OF (S**2+W0**2)/(W*S)  BANDPASS,BANDSTOP */

	    for (ll = 0 ; ll <= l ; ++ll)
	    {
		work[ll] = 0.0;
		work[ll + work_dim1] = 0.0;
	    }

	    for (mm = 0 ; mm <= m ; ++mm)
	    {
		tmp_int = m - mm;
		tmpd = d[mm] * pow_ri(&w, &tmp_int);
		tmpc = c[mm] * pow_ri(&w, &tmp_int);

		for (k = 0 ; k <= mm ; ++k)
		{
		    ls = m + mm - (k * 2);
		    tmp_int = mm - k;
		    tmp = spbfct(&mm,&mm) / (spbfct(&k,&k)
					     * spbfct(&tmp_int,&tmp_int));
		    work[ls] += tmpd * pow_ri(&w02, &k) * tmp;
		    work[ls + work_dim1] += tmpc * pow_ri(&w02, &k) * tmp;
		}
	    }

	    for (ll = 0 ; ll <= l ; ++ll)
	    {
		d[ll] = work[ll];
		c[ll] = work[ll + work_dim1];
	    }

	    break;

	case 4:

/* SUBSTITUTION OF 1/S TO GENERATE HIGHPASS (HP,BS) */

	    for (mm = 0 ; mm <= (m / 2) ; ++mm)
	    {
		tmp = d[mm];
		d[mm] = d[m - mm];
		d[m - mm] = tmp;
		tmp = c[mm];
		c[mm] = c[m - mm];
		c[m - mm] = tmp;
	    }

/* SUBSTITUTION OF (S**2+W0**2)/(W*S)  BANDPASS,BANDSTOP */

	    for (ll = 0 ; ll <= l ; ++ll)
	    {
		work[ll] = 0.0;
		work[ll + work_dim1] = 0.0;
	    }

	    for (mm = 0 ; mm <= m ; ++mm)
	    {
		tmp_int = m - mm;
		tmpd = d[mm] * pow_ri(&w, &tmp_int);
		tmpc = c[mm] * pow_ri(&w, &tmp_int);

		for (k = 0 ; k <= mm ; ++k)
		{
		    ls = m + mm - (k * 2);
		    tmp_int = mm - k;
		    tmp = spbfct(&mm,&mm) / (spbfct(&k,&k)
					     * spbfct(&tmp_int,&tmp_int));
		    work[ls] += tmpd * pow_ri(&w02, &k) * tmp;
		    work[ls + work_dim1] += tmpc * pow_ri(&w02, &k) * tmp;
		}
	    }

	    for (ll = 0 ; ll <= l ; ++ll)
	    {
		d[ll] = work[ll];
		c[ll] = work[ll + work_dim1];
	    }

	    break;

    }

    spbiln(d, c, ln, b, a, work, error);

    return;
} /* spfblt */

/* SPFFTC     02/20/87 */
/* FAST FOURIER TRANSFORM OF N=2**K COMPLEX DATA POINTS USING TIME */
/* DECOMPOSITION WITH INPUT BIT REVERSAL.  N MUST BE A POWER OF 2. */
/* X MUST BE SPECIFIED COMPLEX X(0:N-1)OR LARGER. */
/* INPUT IS N COMPLEX SAMPLES, X(0),X(1),...,X(N-1). */
/* COMPUTATION IS IN PLACE, OUTPUT REPLACES INPUT. */
/* ISIGN = -1 FOR FORWARD TRANSFORM, +1 FOR INVERSE. */
/* X(0) BECOMES THE ZERO TRANSFORM COMPONENT, X(1) THE FIRST, */
/* AND SO FORTH.  X(N-1) BECOMES THE LAST COMPONENT. */

#ifndef KR
void spfftc(complex *x, long *n, long *isign)
#else
void spfftc(x, n, isign)
long *n, *isign;
complex *x;
#endif
{
    /* Builtin functions */
    void complex_exp();

    /* Local variables */
    long i, l, m, mr,tmp_int;
    complex t, tmp_complex, tmp;
    float pisign;

    pisign = (float) ((double) *isign * M_PI);

    mr = 0;

    for (m = 1 ; m < *n ; ++m)
    {
	l = *n;
	l /= 2;

	while (mr + l >= *n)
	{
	    l /= 2;
	}

	mr = mr % l + l;

	if (mr > m)
	{
	    t.r = x[m].r;
	    t.i = x[m].i;
	    x[m].r = x[mr].r;
	    x[m].i = x[mr].i;
	    x[mr].r = t.r;
	    x[mr].i = t.i;
	}
    }

    l = 1;

    while (l < *n)
    {
	for (m = 0 ; m < l ; ++m)
	{

	    tmp_int = l * 2;

	    for (i = m ; tmp_int < 0 ? i >= (*n - 1) : i < *n ;
		 i += tmp_int)
	    {
		tmp.r = 0.0;
		tmp.i = (float) m * pisign / (float) l;

		complex_exp(&tmp_complex, &tmp);

		t.r = x[i + l].r * tmp_complex.r - x[i + l].i * tmp_complex.i;
		t.i = x[i + l].r * tmp_complex.i + x[i + l].i * tmp_complex.r;

		x[i + l].r = x[i].r - t.r;
		x[i + l].i = x[i].i - t.i;

		x[i].r = x[i].r + t.r;
		x[i].i = x[i].i + t.i;
	    }
        }
        l *= 2;
    }

    return;
} /* spfftc */

/* SPFFTR     11/12/85 */
/* FFT ROUTINE FOR REAL TIME SERIES (X) WITH N=2**K SAMPLES. */
/* COMPUTATION IS IN PLACE, OUTPUT REPLACES INPUT. */
/* INPUT:  REAL VECTOR X(0:N+1) WITH REAL DATA SEQUENCE IN FIRST N */
/*         ELEMENTS; ANYTHING IN LAST 2.  NOTE: X MAY BE DECLARED */
/*         REAL IN MAIN PROGRAM PROVIDED THIS ROUTINE IS COMPILED  */
/*         SEPARATELY ... COMPLEX OUTPUT REPLACES REAL INPUT HERE. */
/* OUTPUT: COMPLEX VECTOR XX(O:N/2), SUCH THAT X(0)=REAL(XX(0)),X(1)= */
/*         IMAG(XX(0)), X(2)=REAL(XX(1)), ..., X(N+1)=IMAG(XX(N/2). */
/* IMPORTANT:  N MUST BE AT LEAST 4 AND MUST BE A POWER OF 2. */

#ifndef KR
void spfftr(complex *x, long *n)
#else
void spfftr(x, n)
long *n;
complex *x;
#endif
{
    /* Builtin functions */
    void r_cnjg();

    /* Local variables */
    void spfftc();

    long m, tmp_int;
    complex u, tmp, tmp_complex;
    float tpn, tmp_float;

    tpn = (float) (2.0 * M_PI / (double) *n);

    tmp_int = *n / 2;
    spfftc(x, &tmp_int, &neg_i1);

    x[*n / 2].r = x[0].r;
    x[*n / 2].i = x[0].i;

    for (m = 0 ; m <= (*n / 4) ; ++m)
    {
	u.r = (float) sin((double) m * tpn);
	u.i = (float) cos((double) m * tpn);

	r_cnjg(&tmp_complex, &x[*n / 2 - m]);

	tmp.r = (((1.0 + u.r) * x[m].r - u.i * x[m].i)
		+ (1.0 - u.r) * tmp_complex.r - -u.i * tmp_complex.i) / 2.0;

	tmp.i = (((1.0 + u.r) * x[m].i + u.i * x[m].r)
		+ (1.0 - u.r) * tmp_complex.i + -u.i * tmp_complex.r) / 2.0;

	tmp_float = ((1.0 - u.r) * x[m].r - -u.i * x[m].i
		    + (1.0 + u.r) * tmp_complex.r - u.i * tmp_complex.i) / 2.0;
	x[m].i = ((1.0 - u.r) * x[m].i + -u.i * x[m].r
		 + (1.0 + u.r) * tmp_complex.i + u.i * tmp_complex.r) / 2.0;
	x[m].r = tmp_float;

	r_cnjg(&x[*n / 2 - m], &tmp);
    }

    return;
} /* spfftr */

/* SPFILT     11/13/85 */
/* FILTERS N-POINT DATA SEQUENCE IN PLACE USING ARRAY X */
/* TRANSFER FUNCTION COEFFICIENTS ARE IN ARRAYS B AND A */
/*            B(0)+B(1)*Z**(-1)+.......+B(LB)*Z**(-LB) */
/*     H(Z) = ---------------------------------------- */
/*              1+A(1)*Z**(-1)+.......+A(LA)*Z**(-LA) */
/* PX SAVES PAST VALUES OF INPUT X */
/* PY SAVES PAST VALUES OF OUTPUT Y */
/* IERROR=0    NO ERRORS DETECTED */
/*        1    FILTER RESPONSE EXCEEDS 1.E10 */

#ifndef KR
void spfilt(float *b, float *a, long *lb, long *la, float *x, long *n, float *px, float *py, long *error)
#else
void spfilt(b, a, lb, la, x, n, px, py, error)
long *lb, *la, *n, *error;
float *b, *a, *x, *px, *py;
#endif
{
    /* Local variables */
    long k, l;

    for (k = 0 ; k < *n ; ++k)
    {
	px[0] = x[k];
	x[k] = 0.0;

	for (l = 0 ; l <= *lb ; ++l)
	{
	    x[k] += b[l] * px[l];
	}

	for (l = 0 ; l < *la ; ++l)
	{
	    x[k] -= a[l] * py[l];
	}

	if (ABS(x[k]) > BIG)
	{
	    *error = 1;
	    return;
	}

	for (l = *lb ; l >= 1 ; --l)
	{
	    px[l] = px[l - 1];
	}

	for (l = *la - 1 ; l >= 1 ; --l)
	{
	    py[l] = py[l - 1];
	}

	py[0] = x[k];
    }

    *error = 0;
    return;
} /* spfilt */

/* SPFIRD     5/18/86 */
/* FIR DIGITAL FILTER DESIGN USING WINDOWED FOURIER SERIES */
/* L=LENGTH OF FILTER = L+1 */
/* IBAND=1(LOWPASS); 2(HIGHPASS); 3(BANDPASS); 4(BANDSTOP) */
/* FLN=NORMALIZED LOW CUT-OFF FREQUENCY IN HZ-SEC */
/* FHN=NORMALIZED HIGH CUT-OFF (BP,BS) IN HZ-SEC */
/* IWNDO=1(RECTANGULAR); 2(TAPERED RECTANGULAR); 3(TRIANGULAR) */
/*       4(HANNING); 5(HAMMING); 6(BLACKMAN) */
/* DIGITAL FILTER COEFFICIENTS ARE RETURNED IN B(0:L) */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID LENGTH  (L<=0) */
/*        2      INVALID WINDOW TYPE */
/*        3      INVALID FILTER TYPE */
/*        4      INVALID CUT-OFF FREQUENCY */

#ifndef KR
void spfird(long *l, long *iband, float *fln, float *fhn, long *wndo, float *b, long *error)
#else
void spfird(l, iband, fln, fhn, wndo, b, error)
long *l, *iband, *wndo, *error;
float *fln, *fhn, *b;
#endif
{
    /* Local variables */
    double spwndo();

    long i, mid, lim, tmp_int;
    float s, wc1, wc2, dly;

    if (*l <= 0)
    {
	*error = 1;
	return;
    }
    if (*wndo < 1 || *wndo > 6)
    {
	*error = 2;
	return;
    }
    if (*iband < 1 || *iband > 4)
    {
	*error = 3;
	return;
    }
    if ((*fln <= 0.0 || *fln > 0.5) ||
	(*iband >= 3 && *fln >= *fhn) ||
	(*iband >= 3 && *fhn >= 0.5))
    {
	*error = 4;
	return;
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	b[i] = 0.0;
    }

    dly = (float) *l / 2.0;
    lim = *l / 2;
    mid = 0;
    if (dly == (float) lim)
    {
	--lim;
	mid = 1;
    }

    wc1 = (float) (2.0 * M_PI * *fln);
    if (*iband >= 3)
    {
	wc2 = (float) (2.0 * M_PI * *fhn);
    }

    switch (*iband)
    {
	case 1:

/* LOWPASS DESIGN */

	for (i = 0 ; i <= lim ; ++i)
	{
	    s = i - dly;
	    tmp_int = 1 + *l;
	    b[i] = (float) (sin((double) (wc1 * s)) / (M_PI * (double) s)
		   * spwndo(wndo, &tmp_int, &i));
	    b[*l - i] = b[i];
	}

	if (mid == 1)
	{
	    b[*l / 2] = (float) (wc1 / M_PI);
	}
	break;

    case 2:

/* HIGHPASS DESIGN */

	for (i = 0 ; i <= lim ; ++i)
	{
	    s = i - dly;
	    tmp_int = 1 + *l;
	    b[i] = (float) ((sin(M_PI * (double) s) - sin((double) (wc1 * s)))
			    / (M_PI * (double) s) * spwndo(wndo, &tmp_int, &i));
	    b[*l - i] = b[i];
	}

	if (mid == 1)
	{
	    b[*l / 2] = (float) (1.0 - wc1 / M_PI);
	}
	break;

    case 3:

/* BANDPASS DESIGN */

	for (i = 0 ; i <= lim ; ++i)
	{
	    s = i - dly;
	    tmp_int = 1+ *l;
	    b[i] = (float) ((sin((double) (wc2 * s)) - sin((double) (wc1 * s)))
			    / (M_PI * (double) s) * spwndo(wndo, &tmp_int, &i));
	    b[*l - i] = b[i];
	}

	if (mid == 1)
	{
	    b[*l / 2] = (float) ((wc2 - wc1) / M_PI);
	}
    	break;

    case 4:

/* BANDSTOP DESIGN */

	for (i = 0 ; i <= lim ; ++i)
	{
	    s = i - dly;
	    tmp_int = 1 + *l;
	    b[i] = (float) ((sin((double) (wc1 * s)) + sin(M_PI * (double) s)
			    - sin((double) (wc2 * s))) / (M_PI * (double) s)
			    * spwndo(wndo, &tmp_int, &i));
	    b[*l - i] = b[i];
	}

	if (mid == 1)
	{
	    b[*l / 2] = (float) ((wc1 + M_PI - wc2) / M_PI);
	}
	break;
    }

    *error = 0;
    return;
} /* spfird */

/* SPFIRL     10/15/90 */
/* FIR LOWPASS FILTER DESIGN USING WINDOWED FOURIER SERIES */
/* L=FILTER SIZE SUCH THAT F(Z) = B(0) + B(1)*Z**(-1) +...+ B(L)*Z**(-L) */
/* FCN=NORMALIZED CUT-OFF FREQUENCY IN HERTZ-SECONDS */
/* IWNDO=WINDOW USED TO TRUNCATE FOURIER SERIES */
/*         1-RECTANGULAR; 2-TAPERED RECTANGULAR; 3-TRIANGULAR */
/*         4-HANNING; 5-HAMMING; 6-BLACKMAN */
/* B(0:L)=DIGITAL FILTER COEFFICIENTS RETURNED */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID FILTER LENGTH (L<=0) */
/*        2      INVALID WINDOW TYPE IWNDO */
/*        3      INVALID CUT-OFF FCN; <=0 OR >=0.5 */

#ifndef KR
void spfirl(long *l, float *fcn, long *wndo, float *b, long *error)
#else
void spfirl(l, fcn, wndo, b, error)
long *l, *wndo, *error;
float *fcn, *b;
#endif
{
    /* Local variables */
    double spwndo();

    long i, lim, tmp_int;
    float wcn, dly;

    if (*l <= 0)
    {
	*error = 1;
	return;
    }
    if (*wndo < 1 || *wndo > 6)
    {
	*error = 2;
	return;
    }
    if (*fcn <= 0.0 || *fcn >= 0.5)
    {
	*error = 3;
	return;
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	b[i] = 0.0;
    }

    wcn = (float) (2.0 * M_PI * *fcn);
    dly = (float) *l / 2.0;
    lim = *l / 2;

    if (dly == (float) (*l / 2))
    {
	--lim;
	b[*l / 2] = (float) (wcn / M_PI);
    }

    for (i = 0 ; i <= lim ; ++i)
    {
	tmp_int = 1+ *l;
	b[i] = (float) (sin((double) (wcn *  ((float) i - dly)))
			/ (M_PI * ((float) i - dly))
			* spwndo(wndo, &tmp_int, &i));
	b[*l - i] = b[i];
    }

    *error = 0;
    return;
} /* spfirl */

/* SPFLTR     10/23/90 */
/* FILTERS N-POINT DATA SEQUENCE X AND RETURNS OUTPUT IN Y */
/* TRANSFER FUNCTION COEFFICIENTS ARE IN ARRAYS B AND A */
/*             B(0)+B(1)*Z**(-1)+........+B(LB)*Z**(-LB) */
/*      H(Z) = ----------------------------------------- */
/*                1+A(1)*Z**(-1)+.......+A(LA)*Z**(-LA) */
/* PX RETAINS PAST VALUES OF INPUT X */
/* PY RETAINS PAST VALUES OF OUTPUT Y */
/* IERROR=0     NO ERRORS DETECTED */
/*        1     OUTPUT EXCEEDS 1.E10 */
/* NOTE: OUTPUT ARRAY Y MUST BE INITIALIZED BY CALLING PROGRAM */

#ifndef KR
void spfltr(float *b, float *a, long *lb, long *la, float *x, long *n, float *y, float *px, float *py, long *error)
#else
void spfltr(b, a, lb, la, x, n, y, px, py, error)
long *lb, *la, *n, *error;
float *y, *px, *py, *b, *a, *x;
#endif
{
    /* Local variables */
    long k, l;
    double sum;

    for (k = 0 ; k < *n ; ++k)
    {
	px[0] = x[k];
	sum = 0.0;

	for (l = 0 ; l <= *lb ; ++l)
	{
	    sum += (double) b[l] * (double) px[l];
	}

	for (l = 0 ; l < *la ; ++l)
	{
	    sum -= (double) a[l] * (double) py[l];
	}

	if (ABS(sum) > BIG)
	{
	    *error = 1;
	    return;
	}

	for (l = *lb ; l >= 1 ; --l)
	{
	    px[l] = px[l - 1];
	}

	for (l = (*la - 1) ; l >= 1 ; --l)
	{
	    py[l] = py[l - 1];
	}

	y[k] = (float) sum;
	py[0] = (float) sum;
    }

    *error = 0;
    return;
} /* spfltr */

/* SPGAIN     11/13/85 */
/* THIS FUNCTION COMPUTES THE COMPLEX GAIN OF ANY CAUSAL LINEAR */
/* SYSTEM IN DIRECT FORM.  FOR A PARALLEL SYSTEM, JUST TREAT EACH */
/* SECTION AS DIRECT AND ADD THE RESULTS.  FOR A CASCADE SYSTEM, */
/* TREAT EACH SECTION AS DIRECT AND MULTIPLY THE RESULTS TOGETHER. */
/* YOU MUST SPECIFY:  DIMENSION B(0:LB),A(1:LA); COMPLEX GAIN. */
/* THE LINEAR SYSTEM IS ASSUMED TO HAVE THE TRANSFER FUNCTION */
/*  */
/*       B(0)+B(1)*Z**(-1)+B(2)*Z**(-2)+...+B(LB)*Z**(-LB) */
/*  H(Z)=------------------------------------------------- */
/*       1.0+A(1)*Z**(-1)+A(2)*Z**(-2)+...+A(LA)*Z**(-LA) */
/* FOR AN FIR SYSTEM, USE LA=1 AND A(1)=0.  DO NOT USE LA=0. */
/* FREQ=FREQUENCY IN HZ-S, I.E., SAMPLING FREQUENCY=1.0. */
/* NOTE: COMPUTATION IS LIMITED BY "SMALL" AND "BIG" BELOW. */

#ifndef KR
complex spgain(float *b, float *a, long *lb, long *la, float *freq)
#else
complex spgain(b, a, lb, la, freq)
long *lb, *la;
float *b, *a, *freq;
#endif
{
    /* Builtin functions */
    double complex_abs();
    void complex_exp(), complex_div();

    /* Local variables */
    long i;
    complex asum, bsum, ret_val, tmp_complex1, tmp_complex2, z1;
    float tmp_float;

    tmp_complex1.r = 0.0;
    tmp_complex1.i = (float) (-2.0 * M_PI * *freq);
    complex_exp(&z1, &tmp_complex1);

    bsum.r = 0.0;
    bsum.i = 0.0;

    if (*lb > 0)
    {
        for (i = *lb ; i >= 1 ; --i)
        {
	    tmp_float = (bsum.r + b[i]) * z1.r - bsum.i * z1.i;
	    bsum.i = (bsum.r + b[i]) * z1.i + bsum.i * z1.r;
	    bsum.r = tmp_float;
        }
    }

    asum.r = 0.0;
    asum.i = 0.0;
    for (i = *la - 1 ; i >= 0 ; --i)
    {
	tmp_float = (asum.r + a[i]) * z1.r - asum.i * z1.i;
	asum.i = (asum.r + a[i]) * z1.i + asum.i * z1.r;
	asum.r = tmp_float;
    }

    tmp_complex1.r = 1.0 + asum.r;
    tmp_complex1.i = asum.i;
    if (complex_abs(&tmp_complex1) < SMALL)
    {
	ret_val.r = BIG;
	ret_val.i = 0.0;
    }
    else
    {
	tmp_complex1.r = b[0] + bsum.r;
	tmp_complex1.i = bsum.i;
	tmp_complex2.r = 1.0 + asum.r;
	tmp_complex2.i = asum.i;

	complex_div(&ret_val, &tmp_complex1, &tmp_complex2);
    }

    return(ret_val);
} /* spgain */

/* SPHILB     11/13/85 */
/* GENERATES THE WEIGHTS OF AN FIR HILBERT TRANSFORMER. */
/* AFTER EXECUTION THE WEIGHTS ARE IN X(0) THROUGH X(L-1), WHERE */
/*   L=LX IF LX IS ODD OR L=LX+1 IF LX IS EVEN. */
/* WHEN USED AS A CAUSAL FILTER, THE TRANSFORMER HAS APPROXIMATELY */
/*   UNIT GAIN, A GROUP DELAY OF (L-1)/2 SAMPLES, PLUS */
/*   APPROXIMATELY 90 DEGREES PHASE SHIFT AT ALL FREQUENCIES. */

#ifndef KR
void sphilb(float *x, long *lx)
#else
void sphilb(x, lx)
long *lx;
float *x;
#endif
{
    /* Local variables */
    void spmask();

    long k, l2, tmp_int;
    float tsv;

    l2 = *lx / 2;
    x[l2] = 0.0;
    x[*lx]=0.0;

    for (k = 1 ; k <= l2 ; ++k)
    {
	x[l2 + k] = (float) ((double) (k - ((k / 2) * 2)) * 2.0
			    / (M_PI * (double) k));
	x[l2 - k] = -x[l2 + k];
    }

    tmp_int = l2 * 2;

    spmask(x, &tmp_int, &pos_i5, &tsv, &k);

    return;
} /* sphilb */

/* SPIDTR     11/12/85 */
/* SAME AS SPDFTR EXCEPT REVERSED; Y=SPECTRUM, X=OUTPUT TIME SERIES. */
/* SPECTRAL DATA IS ASSUMED TO BE IN COMPLEX Y(0) THRU Y(N/2). */
/* N=TIME SERIES LENGTH SHOULD BE EVEN.  TIME SERIES (SCALED BY N) */
/* IS COMPUTED IN X(0) THRU X(N-1).  COMPLEX Y(0:N/2) AND DIMENSION */
/* X(0:N-1) ARE ASSUMED, ALTHOUGH THE ARRAYS MAY BE LARGER. */

#ifndef KR
void spidtr(complex *y, float *x, long *n)
#else
void spidtr(y, x, n)
long *n;
complex *y;
float *x;
#endif
{
    /* Builtin functions */
    long pow_ii();
    void complex_exp();

    /* Local variables */
    long k, m;
    complex tmp_complex1, tmp_complex2, tpjn;

    tpjn.r = 0.0;
    tpjn.i = (float) (2.0 * M_PI / (double) *n);

    for (k = 0 ; k < *n ; ++k)
    {
	x[k] = y[0].r + (float) pow_ii(&neg_i1, &k) * y[*n / 2].r;

	for (m = 1 ; m < (*n / 2) ; ++m)
	{
	    tmp_complex1.r = (float) m * (float) k * tpjn.r;
	    tmp_complex1.i = (float) m * (float) k * tpjn.i;

	    complex_exp(&tmp_complex2, &tmp_complex1);

	    x[k] += 2.0 * (y[m].r * tmp_complex2.r - y[m].i * tmp_complex2.i);
	}
    }

    return;
} /* spidtr */

/* SPIFTR     02/20/87 */
/* INVERSE FFT OF THE COMPLEX SPECTRUM OF A REAL TIME SERIES. */
/* X AND N ARE THE SAME AS IN SPFFTR.  IMPORTANT: N MUST BE A POWER */
/* OF 2 AND X MUST BE DIMENSIONED X(0:N+1) (REAL ARRAY, NOT COMPLEX). */
/* THIS ROUTINE TRANSFORMS THE OUTPUT OF SPFFTR BACK INTO THE INPUT, */
/* SCALED BY N.  COMPUTATION IS IN PLACE, AS IN SPFFTR. */

#ifndef KR
void spiftr(complex *x, long *n)
#else
void spiftr(x, n)
long *n;
complex *x;
#endif
{
    /* Builtin functions */
    void r_cnjg();

    /* Local variables */
    void spfftc();

    long m, tmp_int;
    complex u, tmp_complex, tmp;
    float tpn, tmp_float;

    tpn = (float) (2.0 * M_PI / (double) *n);

    for (m = 0 ; m <= (*n / 4) ; ++m)
    {
	u.r = (float) sin((double) m * tpn);
	u.i = (float) -cos((double) m * tpn);

	r_cnjg(&tmp_complex, &x[*n / 2 - m]);


	tmp.r = ((1.0 + u.r) * x[m].r - u.i * x[m].i)
		+ ((1.0 - u.r) * tmp_complex.r - -u.i * tmp_complex.i);
	tmp.i = ((1.0 + u.r) * x[m].i + u.i * x[m].r)
		+ ((1.0 - u.r) * tmp_complex.i + -u.i * tmp_complex.r);

	r_cnjg(&tmp_complex, &x[*n / 2 - m]);

	tmp_float = ((1.0 - u.r) * x[m].r - -u.i * x[m].i)
		    + ((1.0 + u.r) * tmp_complex.r - u.i * tmp_complex.i);
	x[m].i = ((1.0 - u.r) * x[m].i + -u.i * x[m].r)
		+ ((1.0 + u.r) * tmp_complex.i + u.i * tmp_complex.r);

	x[m].r = tmp_float;

	r_cnjg(&x[*n / 2 - m], &tmp);
    }
    tmp_int = *n / 2;

    spfftc(x, &tmp_int, &pos_i1);

    return;
} /* spiftr */

/* SPIIRD     05/09/86 */
/* IIR LOWPASS, HIGHPASS, BANDPASS, AND BANDSTOP DESIGN OF CHEBYSHEV 1, */
/*   CHEBYSHEV 2, AND BUTTERWORTH DIGITAL FILTERS IN CASCADE FORM. */
/* IFILT=1(CHEB1-PASSBAND RIPPLE), 2(CHEB2-STOPBAND RIPPLE), OR */
/*       3(BUTTERWORTH-NO RIPPLE). */
/* IBAND=1(LOWPASS), 2(HIGHPASS), 3(BANDPASS), OR 4(BANDSTOP). */
/* NS   =NUMBER OF SECTIONS IN CASCADE. */
/* LS   =ORDER OF EACH SECTION: USUALLY 2(IBAND=1,2) OR 4(IBAND=3,4). */
/* F1-F4=FREQ. IN HZ-SEC. (SAMPLING FREQ.=1.0) AS IN PLOTS BELOW. */

/*     LOWPASS        HIGHPASS       BANDPASS        BANDSTOP */

/*         F  F         F  F           F F  F F        F F F F */
/*         1  2         1  2           1 2  3 4        1 2 3 4 */
/*   0 XXX-------   0 +------XXX   0 +----XX----   0 XX--------X */
/*     I X .  .       I .  . X       I . .XX. .      IX. . . .X */
/*     I  X.  .       I .  .X        I . .XX. .      IX. . . .X */
/*     I...X  .       I....X         I...X..X .      I.X.....X */
/*     I    X .       I . X          I . X  X .      I  X. .X */
/*     I     X.       I .X           I .X    X.      I  X. .X */
/*  DB I......X    DB I.X         DB I.X......X   DB I...XXX */
/*     I       X      IX             IX        X     I */

/*       F3 AND F4 ARE NOT USED WITH ANY LOW OR HIGHPASS. */
/*       F2 IS NOT USED WITH LOWPASS BUTTERWORTH. */
/*       F1 IS NOT USED WITH HIGHPASS BUTTERWORTH. */
/*       F1 AND F4 ARE NOT USED WITH BANDPASS BUTTERWORTH. */
/*       F2 AND F3 ARE NOT USED WITH BANDSTOP BUTTERWORTH. */

/* DB   =DB OF STOPBAND REJECTION.  APPLIES TO CHEB. FILTERS ONLY. */
/*       NOT USED WITH BUTTERWORTH.  MUST BE GREATER THAT 3 DB. */
/* B    =NUMERATOR COEFFICIENTS, ALWAYS DIMENSIONED B(0:LS,NS). */
/* A    =DENOMINATOR COEFFICIENTS, ALWAYS DIMENSIONED A(LS,NS). */
/* IERROR=0    NO ERRORS. */
/*        1-5  SEE SPFBLT ERROR LIST. */
/*        6    IFILT OR IBAND OUT OF RANGE. */
/*        7    F1-F4 NOT IN SEQUENCE OR NOT BETWEEN O.O AND 0.5, */
/*             OR DB NOT GREATER THAN 3. */
/*        11+  SEE SPCHBI, SPCBII, OR SPBWCF ERROR LIST. */

#ifndef KR
void spiird(long *ifilt, long *iband, long *ns, long *ls, float *f1, float *f2, float *f3, float *f4, float *db, float *b, float *a, long *error)
#else
void spiird(ifilt, iband, ns, ls, f1, f2, f3, f4, db, b, a, error)
long *ifilt, *iband, *ns, *ls, *error;
float *f1, *f2, *f3, *f4, *db, *b, *a;
#endif
{
    /* Local variables */
    void spchbi(), spcbii(), spbwcf(), spfblt();

    long k, b_dim1, a_dim1, tmp_int;
    float omega, fh, alamda, fl, epslon, work[25], c[5], d[5];
    double tmp_double1, tmp_double2, tmp_double3, tmp_double4;

    if (0 >= *ns ||
	(*ifilt < 1 || *ifilt > 3) ||
	(*iband < 1 || *iband > 4))
    {
	*error = 6;
	return;
    }

    if (*iband == 1 || *iband == 4)
    {
	fl = *f1;
    }
    else if (*iband == 2 || *iband == 3)
    {
	fl = *f2;
    }

    if (*iband <= 3)
    {
	fh = *f3;
    }
    else if (*iband == 4)
    {
	fh = *f4;
    }

    if ((*iband < 3 && ((*ifilt < 3 && (0.0 >= *f1 || *f1 >= *f2 || *f2 >= 0.5))
		       || (*ifilt == 3 && (0.0 >= fl || fl >= 0.5)))) ||
        (*ifilt < 3 && ((0.0 >= *f1 || *f1 >= *f2 || *f2 >= *f3) ||
		       (*f3 >= *f4 || *f4 >= 0.5))) ||
        (*ifilt == 3 && (0.0 >= fl || fl >= fh || fh >= 0.5)) ||
        (*ifilt < 3 && *db <= 3.0))
    {
	*error = 7;
	return;
    }

    b_dim1 = *ls + 1;
    a_dim1 = *ls;

    if (*ifilt < 3)
    {
	if (*iband <= 2)
	{
	    omega = (float) (tan(M_PI * *f2) / tan(M_PI * *f1));
	}
	else if (*iband == 3)
	{
	    tmp_double1 = tan(M_PI * *f1);
	    tmp_double2 = tan(M_PI * *f4);

	    tmp_double3 = (tmp_double1 * tmp_double1
			 - tan(M_PI * fh) * tan(M_PI * fl)) / ((tan(M_PI * fh) 
			 - tan(M_PI * fl)) * tmp_double1);

	    tmp_double4 = (tmp_double2 * tmp_double2
			 - tan(M_PI * fh) * tan(M_PI * fl)) / ((tan(M_PI * fh) 
			 - tan(M_PI * fl)) * tmp_double2);

	    omega = (float) MIN(ABS(tmp_double4),ABS(tmp_double3));
	}
	else if (*iband == 4)
	{
	    tmp_double1 = tan(M_PI * *f2);
	    tmp_double2 = tan(M_PI * *f3);

	    tmp_double3 = 1.0 / ((tmp_double1 * tmp_double1
			 - tan(M_PI * fh) * tan(M_PI * fl)) / ((tan(M_PI * fh)
			 - tan(M_PI * fl)) * tmp_double1));

	    tmp_double4 = 1.0 / ((tmp_double2 * tmp_double2
			 - tan(M_PI * fh) * tan(M_PI * fl)) / ((tan(M_PI * fh)
			 - tan(M_PI * fl)) * tmp_double2));

	    omega = (float) MIN(ABS(tmp_double4),ABS(tmp_double3));
	}

	alamda = pow(pos_d10, (double) (*db / 20.0));
	tmp_double1 = (*ns * 2)
		      * log((double) omega
			    + sqrt((double) (omega * omega - 1.0)));
	epslon = alamda / (0.5 * (exp(tmp_double1)
				  + exp( -tmp_double1)));
    }

    for (k = 1 ; k <= *ns ; ++k)
    {
	if (*ifilt == 1)
	{
	    tmp_int = *ns * 2;
	    spchbi(&tmp_int, &k, &pos_i4, &epslon, d, c, error);
	}
	else if (*ifilt == 2)
	{
	    tmp_int = *ns * 2;
	    spcbii(&tmp_int, &k, &pos_i4, &omega, &alamda, d, c, error);
	}
	else if (*ifilt == 3)
	{
	    tmp_int = *ns * 2;
	    spbwcf(&tmp_int, &k, &pos_i4, d, c, error);
	}

	if (*error != 0)
	{
	    *error = 10 * *ifilt + *error;
	    return;
	}

	spfblt(d, c, ls, iband, &fl, &fh, &b[(k - 1) * b_dim1],
	       &a[(k - 1) * a_dim1], work, error);

	if (*error != 0)
	{
	    return;
	}
    }

    return;
} /* spiird */

/* SPLEVS     06/20/91 */
/* LEVINSON'S ALGORITHM - SOLUTION OF AB=C MATRIX EQUATION */
/* AVECT(0:L)= 1ST ROW OF SYMMETRIC TOEPLITZ MATRIX */
/* C(0:L)= DATA VECTOR */
/* B(0:L)=SOLUTION VECTOR RETURNED */
/* WK(0:L)=WORK VECTOR USED INTERNALLY */
/* IERROR=0     NO ERRORS DETECTED */
/*        1     INVALID L<0 */
/*        2     AVECT(0)<1.E-10 */
/*	  3     SINGULAR CONDITION: V DROPS >5 ORDERS OF MAGNITUDE */
/*				     OR RMS ERROR DECREASES BY <1% */

#ifndef KR
void splevs(float *avect, float *c, long *l, float *b, float *wk, long *error)
#else
void splevs(avect, c, l, b, wk, error)
long *l, *error;
float *avect, *c, *b, *wk;
#endif
{
    /* Local variables */
    long i, k, m, n;
    float s, s0, temp;
    double u, v, w;

    if (*l < 0)
    {
	*error = 1;
	return;
    }

    if (ABS(avect[0]) < SMALL)
    {
	*error = 2;
	return;
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	wk[i] = 0.0;
	b[i] = 0.0;
    }

    b[0] = c[0] / avect[0];
    s0 = b[0] * c[0];
    if (*l == 0)
    {
	return;
    }

    v = 1.0;
    for (m = 0 ; m < *l ; ++m)
    {
	u = (double) (avect[m + 1] / avect[0]);
	w = (double) ((c[m + 1] - b[0] * avect[m + 1]) / avect[0]);

	if (m > 0)
	{
	    for (k = 1 ; k <= m ; ++k)
	    {
		u -= (double) (wk[m - k] * avect[k] / avect[0]);
		w -= (double) (b[k] * avect[m + 1 - k] / avect[0]);
	    }
	}

	wk[m] = (float) (u / v);

	if (m > 0)
	{
	    for (n = 0 ; n <= ((m - 1) / 2) ; ++n)
	    {
		temp = wk[n];
		wk[n] = temp - wk[m] * wk[m - n - 1];
		if ((m - n - 1) != n)
		{
		    wk[m - n - 1] -= wk[m] * temp;
		}
	    }
	}

	v -= (double) wk[m] * u;
	if (ABS(v) < ORDER5)
	{
	    *error = 3;
	    return;
	}

	b[m + 1] = (float) (w / v);
	s = b[m + 1] * c[m + 1];

	for (k = 0 ; k <= m ; ++k)
	{
	    b[k] -= wk[m - k] * b[m + 1];
	    s += b[k] * c[k];
	}

	if ((s0 < SMALL && s <= SMALL) ||
	    (s0 > SMALL && (s - s0)/s0 < ORDER4))
	{
	    *error = 3;
	    return;
	}
	s0 = s;
    }

    *error = 0;
    return;
} /* splevs */

/* SPLFIT     10/26/90 */
/* FITS STRAIGHT LINE TO DATA IN ARRAYS X(0:N-1) AND Y(0:N-1) */
/* N SPECIFIES NUMBER OF DATA POINTS */
/* EQUATION OF LINE:  Y=AX+B    A,B ARE RETURNED */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 */
/*        2      ARITHMETIC PROBLEM - DENOMINATOR APPROX 0. */

#ifndef KR
void splfit(float *x, float *y, long *n, float *a, float *b, long *error)
#else
void splfit(x, y, n, a, b, error)
long *n, *error;
float *x, *y, *a, *b;
#endif
{
    /* Local variables */
    double spmean();

    long i;
    double xsum, ysum, x2sum, xysum, den;

    if (*n <= 0)
    {
	*error = 1;
	return;
    }

    *a = 0.0;
    *b = 0.0;

    xysum = 0.0;
    xsum = 0.0;
    ysum = 0.0;
    x2sum = 0.0;
    for (i = 0 ; i < *n ; ++i)
    {
	xysum += (double) (x[i] * y[i]);
	xsum += (double) x[i];
	ysum += (double) y[i];
	x2sum += (double) (x[i] * x[i]);
    }

    den = (double) *n * x2sum - xsum * xsum;
    if (den < SMALL)
    {
	*error = 2;
	return;
    }

    *a = (float) (((double) *n * xysum - xsum * ysum) / den);
    *b = (float) (spmean(y, n) - (double) *a * spmean(x, n));

    *error = 0;
    return;
} /* splfit */

/* SPLFLT     11/13/85 */
/* FILTERS N-POINT DATA SEQUENCE IN PLACE USING ARRAY X */
/* LATTICE TRANSFER FUNCTION COEFFICIENTS IN REAL ARRAYS KAPPA AND NU */
/* PAST RETAINS OLD VALUES TO ENABLE BLOCK MODE FILTERING */
/* IERROR=0    NO ERRORS DETECTED */
/*        1    OUTPUT EXCEEDS 1.E10 */

#ifndef KR
void splflt(float *kappa, float *nu, long *l, float *x, long *n, float *past, long *error)
#else
void splflt(kappa, nu, l, x, n, past, error)
long *l, *n, *error;
float *kappa, *nu, *x, *past;
#endif
{
    /* Local variables */
    long k, ll;
    double sum;

    for (k = 0 ; k < *n ; ++k)
    {
	sum = x[k];

	for (ll = *l ; ll >= 1 ; --ll)
	{
	    sum -= (double) kappa[ll - 1] * (double) past[ll - 1];
	    past[ll] = past[ll - 1] + kappa[ll - 1] * (float) sum;
	}

	past[0] = (float) sum;
	x[k] = 0.0;

	for (ll = 0 ; ll <= *l ; ++ll)
	{
	    x[k] += nu[ll] * past[ll];
	}

	if (ABS(x[k]) > BIG)
	{
	    *error = 1;
	    return;
	}
    }

    *error = 0;
    return;
} /* splflt */

/* SPLINT     11/20/85 */
/* LINEAR INTERPOLATION BETWEEN EQUALLY SPACED SAMPLES. */
/* X(0:LX)=VECTOR CONTAINING THE ORIGINAL DATA VECTOR, X(0:LX1) WITH */
/*         STEP SIZE T1, TO BE INTERPOLATED. */
/* LX1=LAST INDEX OF INPUT SEQUENCE, X(0) --- X(LX1).  (INPUT.) */
/* RATIO=T2/T1=STEP SIZE RATIO.  MUST BE GT 0.0 AND LT 1.0.  (INPUT.) */
/* LX2=LAST INDEX IN INTERPOLATED SEQUENCE=LX1/RATIO.  (OUTPUT.) */
/* IERROR=0  NO ERROR DETECTED */
/*        1  RATIO OUT OF RANGE */
/*        2  LX TOO SMALL FOR INTERPOLATED RESULT */
/* COMPUTATION IS IN PLACE.  LX MUST BE AT LEAST LX2=LX1/RATIO. */
/* THE REMAINING ELEMENTS, X(LX2+1) --- X(LX), ARE SET TO ZERO. */

#ifndef KR
void splint(float *x, long *lx, long *lx1, float *ratio, long *lx2, long *error)
#else
void splint(x, lx, lx1, ratio, lx2, error)
long *lx, *lx1, *lx2, *error;
float *x, *ratio;
#endif
{
    long k, k1;

    if (*ratio <= 0.0 || *ratio >= 1.0)
    {
	*error = 1;
	return;
    }

    *lx2 = *lx1 / *ratio;
    if (*lx2 > *lx)
    {
	*error = 2;
	return;
    }

    for (k = *lx ; k >= 1 ; --k)
    {
	k1 = k * *ratio;

	if (k <= *lx2)
	{
	    x[k] = x[k1] + ((float) k * *ratio - (float) k1)
			   * (x[k1 + 1] - x[k1]);
	}
	else
	{
	    x[k] = 0.0;
	}
    }

    *error = 0;
    return;
} /* splint */

/* SPLMTS     5/10/86 */
/* FINDS THE GLOBAL MINIMUM AND MAXIMUM OF THE N-POINT DATA */
/* SEQUENCE IN ARRAY X(0:N-1). */
/* XMIN AND XMAX ARE THE MINIMUM AND MAXIMUM DATA VALUES. */
/* IMIN AND IMAX ARE THE ARRAY LOCATIONS CORRESPONDING TO */
/* THE FIRST OCCURRENCE OF THE RESPECTIVE EXTREME. */

#ifndef KR
void splmts(float *x, long *n, float *xmin, long *imin, float *xmax, long *imax)
#else
void splmts(x, n, xmin, imin, xmax, imax)
long *n, *imin, *imax;
float *x, *xmin, *xmax;
#endif
{
    /* Local variables */
    long i;

    *imin = 0;
    *imax = 0;

    if (*n > 1)
    {

	for (i = 1 ; i < *n ; ++i)
	{
	    if (x[i] > x[*imax])
	    {
		*imax = i;
	    }

	    if (x[i] < x[*imin])
	    {
		*imin = i;
	    }
	}
    }

    *xmin = x[*imin];
    *xmax = x[*imax];

    return;
} /* splmts */

/* SPLSMT     10/26/90 */
/* GENERATES MATRIX USED FOR ORTHOGONAL POLYNOMIALS */

#ifndef KR
void splsmt(long *n, long *l, float *p)
#else
void splsmt(n, l, p)
long *n, *l;
float *p;
#endif
{
    /* Builtin functions */
    double pow_ri();

    /* Local variables */
    double spbfct();

    long i, j, p_dim1, tmp_int1, tmp_int2;
    double tmp_double;

    p_dim1 = *l + 1;

    for (i = 0 ; i <= *l ; ++i)
    {
	p[i] = 1.0;

	for (j = i + 1 ; j <= *l ; ++j)
	{
	    p[i + j * p_dim1] = 0.0;
	}
    }

    for (i = 1 ; i <= *l ; ++i)
    {
	for (j = 1 ; j <= i ; ++j)
	{
	    tmp_int1 = i + j;
	    tmp_int2 = *n - 1;
	    tmp_double = spbfct(&j,&j);
	    p[i + j * p_dim1] = pow_ri(&neg_f1, &j) * spbfct(&i, &j) * 
			        spbfct(&tmp_int1, &j) / (spbfct(&tmp_int2, &j)
			        * (tmp_double * tmp_double));
	}
    }

    return;
} /* splsmt */

/* SPLTCF     11/13/85 */
/* CONVERTS TRANSFER FUNCTION COEF. FROM DIRECT TO LATTICE FORM. */
/* DIRECT FORM H(Z) IS DEFINED BY */
/*           B(0)+B(1)*Z**(-1)+...........+B(L)*Z**(-L) */
/*    H(Z) = ------------------------------------------ */
/*             1+A(1)*Z**(-1)+..........+A(L)*Z**(-L) */
/* LATTICE COEF. ARE RETURNED IN REAL ARRAYS KAPPA AND NU */
/* IERROR=0     CONVERSION WITH NO ERRORS DETECTED */
/*        1     UNSTABLE H(Z) */
/* WORK ARRAY IS USED INTERNALLY. */

#ifndef KR
void spltcf(float *b, float *a, long *l, float *kappa, float *nu, float *work, long *error)
#else
void spltcf(b, a, l, kappa, nu, work, error)
long *l, *error;
float *b, *a, *kappa, *nu, *work;
#endif
{
    /* Local variables */
    long j, ll, work_dim1;

    work_dim1 = *l + 1;

    work[0] = 1.0;
    work[work_dim1 * 2] = b[0];

    for (ll = 1 ; ll <= *l ; ++ll)
    {
	work[ll] = a[ll - 1];
	work[ll + work_dim1 * 2] = b[ll];
    }

    for (ll = *l ; ll >= 1 ; --ll)
    {
	for (j = 0 ; j <= ll ; ++j)
	{
	    work[j + work_dim1] = work[ll - j];
	}

	kappa[ll - 1] = work[ll];

	if (ABS(kappa[ll - 1]) >= 1.0)
	{
	    *error = 1;
	    return;
	}

	for (j = 0 ; j <= ll ; ++j)
	{
	    work[j] = (work[j] - kappa[ll - 1] * work[j + work_dim1])
		      / (1.0 - kappa[ll - 1] * kappa[ll - 1]);
	}

	nu[ll] = work[ll + work_dim1 * 2];

	for (j = 0 ; j <= ll ; ++j)
	{
	    work[j + work_dim1 * 2] -= nu[ll] * work[j + work_dim1];
	}
    }

    nu[0] = work[work_dim1 * 2];

    *error = 0;
    return;
} /* spltcf */

/* SPMASK     05/19/86 */
/* THIS ROUTINE APPLIES A DATA WINDOW TO THE DATA VECTOR X(0:LX). */
/* ITYPE=1(RECTANGULAR), 2(TAPERED RECTANGULAR), 3(TRIANGULAR), */
/*       4(HANNING), 5(HAMMING), OR 6(BLACKMAN). */
/*       (NOTE:  TAPERED RECTANGULAR HAS COSINE-TAPERED 10% ENDS.) */
/* TSV=SUM OF SQUARED WINDOW VALUES. */
/* IERROR=0 IF NO ERROR, 1 IF ITYPE OUT OF RANGE. */

#ifndef KR
void spmask(float *x, long *lx, long *type, float *tsv, long *error)
#else
void spmask(x, lx, type, tsv, error)
long *lx, *type, *error;
float *x, *tsv;
#endif
{
    /* Local variables */
    double spwndo();

    long k, tmp_int;
    double w;

    if (*type < 1 || *type > 6)
    {
	*error = 1;
	return;
    }

    *tsv = 0.0;
    for (k = 0 ; k <= *lx ; ++k)
    {
	tmp_int = 1 + *lx;
	w = spwndo(type, &tmp_int, &k);
	x[k] *= (float) w;
	*tsv += (float) (w * w);
    }

    *error = 0;
    return;
} /* spmask */

/* SPMEAN     05/16/90 */
/* COMPUTES MEAN VALUE OF N-POINT DATA VECTOR X(0:N-1) */

#ifndef KR
double spmean(float *x, long *n)
#else
double spmean(x, n)
long *n;
float *x;
#endif
{
    /* Local variables */
    long i;
    double ret_val;

    ret_val = 0.0;
    if (*n <= 0)
    {
	return(ret_val);
    }

    for (i = 0 ; i < *n ; ++i)
    {
	ret_val += (double) x[i];
    }

    ret_val /= (double) *n;
    return(ret_val);
} /* spmean */

/* SPNLMS     11/13/85 */
/* IMPLEMENTS NLMS ALGORITHM B(K+1)=B(K)+2*MU*E*X(K)/((L+1)*SIG) */
/* X(O:N-1)=DATA VECTOR      INPUT SENT     OUTPUT RETURNED */
/* D(0:N-1)=DESIRED SIGNAL VECTOR */
/* N SPECIFIES NUMBER OF DATA POINTS IN X AND D */
/* B(0:L)=ADAPTIVE COEFFICIENTS OF LTH ORDER FIR FILTER */
/* MU=CONVERGENCE PARAMETER - DECLARE REAL */
/* SIG=INPUT SIGNAL POWER ESTIMATE - UPDATED INTERNALLY */
/* AL=FORGETTING FACTOR   SIG(K)=AL*(X(K)**2)+(1-AL)*SIG(K-1) */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID ORDER   L<0 */
/*        2      INVALID CONVERGENCE PARAMETER   MU<=0 OR >=1 */
/*        3      INPUT POWER ESTIMATE  SIG<=0 */
/*        4      FORGETTING FACTOR   AL<0 OR =>1 */
/*        5      RESPONSE EXCEEDS 1.E10 */

#ifndef KR
void spnlms(float *x, long *n, float *d, float *b, long *l, float *mu, float *sig, float *al, float *px, long *error)
#else
void spnlms(x, n, d, b, l, mu, sig, al, px, error)
long *n, *l, *error;
float *x, *d, *b, *mu, *sig, *al, *px;
#endif
{
    /* Local variables */
    long k, ll;
    float e, tmp;

    if (*l < 0)
    {
	*error = 1;
	return;
    }
    if (*mu <= 0.0 || *mu >= 1.0)
    {
	*error = 2;
	return;
    }
    if (*sig <= 0.0)
    {
	*error = 3;
	return;
    }
    if (*al < 0.0 || *al >= 1.0)
    {
	*error = 4;
	return;
    }

    for (k = 0 ; k < *n ; ++k)
    {
	px[0] = x[k];
	x[k] = 0.0;

	for (ll = 0 ; ll <= *l ; ++ll)
	{
	    x[k] += b[ll] * px[ll];
	}

	if (ABS(x[k]) > BIG)
	{
	    *error = 5;
	    return;
	}

	e = d[k] - x[k];
	*sig = *al * (px[0] * px[0]) + (1.0 - *al) * *sig;
	tmp = *mu * 2 / ((1.0 + (float) *l) * *sig);

	for (ll = 0 ; ll <= *l ; ++ll)
	{
	    b[ll] += tmp * e * px[ll];
	}

	for (ll = *l ; ll >= 1 ; --ll)
	{
	    px[ll] = px[ll - 1];
	}
    }

    *error = 0;
    return;
} /* spnlms */

/* SPNORM     11/13/85 */
/* SETS UP NORMAL EQN FOR LEAST-SQUARES POLYNOMIAL FIT: AB=C */
/* X(0:N-1) & Y(0:N-1) ARE N-POINT INPUT DATA ARRAYS */
/* L=ORDER OF POLYNOMIAL */
/* A(0:L,0:L) = ARRAY RETURNED     C(0:L) = VECTOR RETURNED */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID N: N<=0 */
/*        2      INVALID L: L<=0 OR L>N */

#ifndef KR
void spnorm(float *x, float *y, long *n, long *l, float *a, float *c, long *error)
#else
void spnorm(x, y, n, l, a, c, error)
long *n, *l, *error;
float *x, *y, *a, *c;
#endif
{
    /* Builtin functions */
    double pow_ri();

    /* Local variables */
    long i, j, k, a_dim1, tmp_int;
    double s1, s2, s3;

    a_dim1 = *l + 1;

    if (*n <= 0)
    {
	*error = 1;
	return;
    }
    if (*l <= 0 || *l > *n)
    {
	*error = 2;
	return;
    }

    for (j = 1 ; j <= *l ; ++j)
    {
	s1 = 0.0;
	s2 = 0.0;
	s3 = 0.0;
	for (k = 0 ; k < *n ; ++k)
	{
	    s1 += pow_ri(&x[k], &j);
	    tmp_int = *l + j;
	    s2 += pow_ri(&x[k], &tmp_int);
	    s3 += (double) y[k] * pow_ri(&x[k], &j);
	}
	a[j * a_dim1] = (float) s1;
	a[j + *l * a_dim1] = (float) s2;
	c[j] = (float) s3;
    }

    a[0] = (float) *n;
    c[0] = 0.0;
    for (k = 0 ; k < *n ; ++k)
    {
	c[0] += y[k];
    }

    for (i = 1 ; i <= *l ; ++i)
    {
	for (j = 0 ; j < *l ; ++j)
	{
	    a[i + j * a_dim1] = a[i - 1 + (j + 1) * a_dim1];
	}
    }

    *error = 0;
    return;
} /* spnorm */

/* SPORTH     11/13/85 */
/* GENERATES COEFFICIENTS FOR LEAST SQUARES FIT VIA ORTHOGONAL */
/*      POLYNOMIALS - LTH ORDER */
/* DATA SAMPLES MUST OCCUR AT REGULAR INTERVALS */
/* Y(0:N-1)=DATA ARRAY OF N SAMPLE POINTS */
/* ORTHB(0:L)=COEFFICIENTS RETURNED */
/* P(0:L,0:L)=WORK ARRAY USED INTERNALLY */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 OR L<=0 */
/*        2      N<L  CANNOT COMPUTE LEAST SQUARES FIT */

#ifndef KR
void sporth(float *y, long *n, long *l, float *orthb, float *p, long *error)
#else
void sporth(y, n, l, orthb, p, error)
long *n, *l, *error;
float *y, *orthb, *p;
#endif
{
    /* Local variables */
    double spbfct();
    void splsmt();

    long i, j, nn, p_dim1;
    double sd, sn, sum;

    p_dim1 = *l + 1;

    if (*n <= 0 || *l <= 0)
    {
	*error = 1;
	return;
    }
    if (*n < *l)
    {
	*error = 2;
	return;
    }

    splsmt(n, l, p);

    for (i = 0 ; i <= *l ; ++i)
    {
	sn = 0.0;
	sd = 0.0;

	for (nn = 0 ; nn < *n ; ++nn)
	{
	    sum = 0.0;

	    for (j = 0 ; j <= i ; ++j)
	    {
		sum += (double) p[i + j * p_dim1] * spbfct(&nn, &j);
	    }

	    sn += (double) y[nn] * sum;
	    sd += sum * sum;
	}
	orthb[i] = (float) (sn / sd);
    }

    *error = 0;
    return;
} /* sporth */

/* SPPFLT     11/13/85 */
/* FILTERS N-POINT DATA SEQUENCE X AND RETURNS OUTPUT IN Y */
/* TRANSFER FUNCTION IS COMPOSED OF NS SECTIONS IN PARALLEL WITH */
/*            MTH SECTION DEFINED BY */
/*          B(0,M)+B(1,M)*Z**(-1)+........+B(LS,M)*Z**(-LS) */
/*   H(Z) = --------------------------------------------- */
/*             1+A(1,M)*Z**(-1)+.........+A(LS,M)*Z**(-LS) */
/* PX RETAINS PAST VALUES OF INPUT X */
/* PY RETAINS PAST VALUES OF OUTPUT Y */
/* IERROR=0     NO ERRORS DETECTED */
/*     1 - NS   OUTPUT AT STAGE [IERROR]  EXCEEDS 1.E10 */

#ifndef KR
void sppflt(float *b, float *a, long *ls, long *ns, float *x, long *n, float *y, float *px, float *py, long *error)
#else
void sppflt(b, a, ls, ns, x, n, y, px, py, error)
long *ls, *ns, *n, *error;
float *b, *a, *x, *y, *px, *py;
#endif
{
    /* Local variables */
    long k, m, ll, b_dim1, a_dim1, px_dim1, py_dim1;
    double sum;

    b_dim1 = *ls + 1;
    a_dim1 = *ls;
    px_dim1 = *ls + 1;
    py_dim1 = *ls;

    for (k = 0 ; k < *n ; ++k)
    {
	y[k] = 0.0;
    }

    for (m = 0 ; m < *ns ; ++m)
    {
	for (k = 0 ; k < *n ; ++k)
	{
	    px[m * px_dim1] = x[k];
	    sum = (double) b[m * b_dim1] * (double) px[m * px_dim1];

	    for (ll = 1 ; ll <= *ls ; ++ll)
	    {
		sum += (double) b[ll + m * b_dim1] * px[ll + m * px_dim1]
		       - (double) a[ll - 1 + m * a_dim1] * py[ll - 1 + m * py_dim1];
	    }

	    if (ABS(sum) > BIG)
	    {
		*error = m;
		return;
	    }

	    for (ll = *ls ; ll >= 2 ; --ll)
	    {
		px[ll + m * px_dim1] = px[ll - 1 + m * px_dim1];
		py[ll - 1 + m * py_dim1] = py[ll - 2 + m * py_dim1];
	    }
	    px[m * px_dim1 + 1] = px[m * px_dim1];
	    py[m * py_dim1] = (float) sum;
	    y[k] += (float) sum;
	}
    }

    *error = 0;
    return;
} /* sppflt */

/* SPPOLY     11/13/85 */
/* GENERATES POLYNOMIAL COEFFICIENTS FOR LEAST SQUARES FIT */
/*    B(0:L)=COEFFICIENTS RTND: B0+B1*X+....+BL*X**L */
/* DX=POINT SPACING IN X DIRECTION (SAMPLE INTERVAL) */
/* Y(0:N-1)=ARRAY OF N EQUALLY SPACED DATA SAMPLES */
/* WORK ARRAYS: */
/*       ORTHB(0:L) - ORTHOGONAL POLYNOMIAL COEFFICIENTS */
/*       P(0:L,0:L) - MATRIX USED IN SPORTH AND SPSTRL */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 OR L<=0 */
/*        2      N<L  CANNOT COMPUTE LEAST SQUARES FIT */
/*        3      DX <=0.  INVALID SAMPLE INTERVAL */

#ifndef KR
void sppoly(float *dx, float *y, long *n, long *l, float *b, float *orthb, float *p, long *error)
#else
void sppoly(dx, y, n, l, b, orthb, p, error)
long *n, *l, *error;
float *dx, *y, *b, *orthb, *p;
#endif
{
    /* Builtin functions */
    double pow_ri();

    /* Local variables */
    void sporth(), spstrl();

    long i, j, p_dim1;
    double sum;

    p_dim1 = *l + 1;

    if (*dx <= 0.0)
    {
	*error = 3;
	return;
    }

    sporth(y, n, l, orthb, p, error);

    if (*error != 0)
    {
	return;
    }

    for (j = 0 ; j <= *l ; ++j)
    {
	b[j] = 0.0;

	for (i = j ; i <= *l ; ++i)
	{
	    b[j] += orthb[i] * p[i + j * p_dim1];
	}
    }

    spstrl(l, p);

    for (j = 0 ; j <= *l ; ++j)
    {
	sum = 0.0;

	for (i = j ; i <= *l ; ++i)
	{
	    sum += (double) b[i] * (double) p[i + j * p_dim1];
	}

	b[j] = (float) sum / pow_ri(dx, &j);
    }

    return;
} /* sppoly */

/* SPPOWR     O2/20/87 */
/* COMPUTES RAW PERIODOGRAM, AVERAGED OVER SEGMENTS OF X(0:LX). */
/* X(0),X(1),---,X(LX)=INPUT DATA SEQUENCE. */
/* Y(0),Y(1),---,Y(LY)=OUTPUT PERIODOGRAM.  LY MUST BE A POWER OF 2. */
/* WORK=WORK ARRAY DIMENSIONED AT LEAST WORK(0:2*LY+1). */
/* LX=LAST INDEX IN DATA SEQUENCE AS ABOVE. */
/* LY=FREQUENCY INDEX CORRESPONDING TO HALF SAMPLING RATE.  POWER OF 2. 
*/
/* SEGMENT LENGTH IS 2*LY.  DATA LENGTH (LX+1) MUST BE AT LEAST THIS BIG. */
/* IWINDO=DATA WINDOW TYPE, 1(RECTANGULAR), 2(TAPERED RECTANGULAR), */
/*   3(TRIANGULAR), 4(HANNING), 5(HAMMING), OR 6(BLACKMAN). SEE CH. 14. 
*/
/* OVRLAP=FRACTION THAT EACH DATA SEGMENT OF SIZE 2*LY OVERLAPS ITS */
/*   PREDECESSOR.  MUST BE GREATER THAN OR EQUAL 0 AND LESS THAN 1. */
/* NSGMTS=NO. OVERLAPPING SEGMENTS OF X AVERAGED TOGETHER.  OUTPUT. */
/* IERROR=0  NO ERROR DETECTED. */
/*        1  IWINDO OUT OF RANGE (1-6). */
/*        2  LX TOO SMALL, I.E., LESS THAN 2*LY-1. */
/*        3  LY NOT A POWER OF 2. */

#ifndef KR
void sppowr(float *x, float *y, float *work, long *lx, long *ly, long *iwindo, float *ovrlap, long *nsgmts, long *error)
#else
void sppowr(x, y, work, lx, ly, iwindo, ovrlap, nsgmts, error)
long *lx, *ly, *iwindo, *nsgmts, *error;
float *x, *y, *work, *ovrlap;
#endif
{
    /* Local variables */
    void spmask(), spfftr();

    long m, nsamp, tmp_int, isegmt, nshift;
    float base, tsv;

    if ((*lx + 1) < (*ly * 2))
    {
        *error = 2;
	return;
    }

    base = (float) (*ly);
    base /= 2.0;

    while ((base - 2.0) > 0.0)
    {
	base /= 2.0;
    }

    if ((base - 2.0) == 0)
    {
	for (m = 0 ; m <= *ly ; ++m)
	{
	    y[m] = 0.0;
	}

	nshift = MIN(MAX((long) ((*ly * 2) * (1.0 - *ovrlap) + 0.5), 1),
		     *ly * 2);

	*nsgmts = 1 + (*lx + 1 - (*ly * 2)) / nshift;

	for (isegmt = 0 ; isegmt < *nsgmts ; ++isegmt)
	{
	    for (nsamp = 0 ; nsamp < (*ly * 2) ; ++nsamp)
	    {
		work[nsamp] = x[nshift * isegmt + nsamp];
	    }

	    tmp_int = (*ly * 2) - 1;
	    spmask(work, &tmp_int, iwindo, &tsv, error);

	    if (*error != 0)
	    {
		return;
	    }

	    tmp_int = *ly * 2;
	    spfftr(work, &tmp_int);

	    for (m = 0 ; m <= *ly ; ++m)
	    {
		y[m] += (work[m * 2] * work[m * 2] + work[(m * 2) + 1]
			* work[(m * 2) + 1]) / (tsv * *nsgmts);
	    }
	}
    }
    else if ((base - 2.0) < 0.0)
    {
	*error = 3;
    }

    return;
} /* sppowr */

/* SPPWRC     11/13/85 */
/* FITS POWER FUNCTION CURVE TO DATA IN ARRAYS X(0:N-1) AND Y(0:N-1) */
/* N SPECIFIES NUMBER OF DATA POINTS */
/* EQUATION:  Y=A(X**B)   A,B ARE RETURNED */
/* DATA IN X AND Y IS CONVERTED TO LOG INTERNALLY */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 */
/*        2      SPLFIT ERROR = 2 */
/*        3      X OR Y DATA <=0.  CANNOT COMPUTE LOG */

#ifndef KR
void sppwrc(float *x, float *y, long *n, float *a, float *b, long *error)
#else
void sppwrc(x, y, n, a, b, error)
long *n, *error;
float *x, *y, *a, *b;
#endif
{
    /* Local variables */
    void splfit();

    long i;
    float alg;

    *a = 0.0;
    *b = 0.0;

    if (*n <= 0)
    {
	*error = 1;
	return;
    }

    for (i = 0 ; i < *n ; ++i)
    {
	if (x[i] <= 0.0 || y[i] <= 0.0)
	{
	    *error = 3;
	    return;
	}

	x[i] = (float) log10((double) x[i]);
	y[i] = (float) log10((double) y[i]);
    }

    splfit(x, y, n, b, &alg, error);
    if (*error != 0)
    {
	return;
    }

    *a = (float) pow(pos_d10, (double) alg);

    return;
} /* sppwrc */

/* SPRAND     11/13/85 */
/* UNIFORM RANDOM NUMBER FROM 0.0 TO 1.0. */
/* INITIALIZE BY SETTING ISEED, THEN LEAVE ISEED ALONE. */

#ifndef KR
double sprand(long *seed)
#else
double sprand(seed)
long *seed;
#endif
{
    /* Local variables */
    double ret_val;

    *seed = 2045 * *seed + 1;
    *seed -= (*seed / 1048576) * 1048576;

    ret_val = (double) ((*seed + 1) /  1048577.0);
    return(ret_val);
} /* sprand */

/* SPRESP     11/13/85 */
/* TIME DOMAIN RESPONSE OF A CAUSAL LINEAR SYSTEM. */
/* USER MUST DIMENSION X(0:LX),Y(0:LY),B(0:LB),A(1:LA) */
/* X=USER-SUPPLIED INPUT SIGNAL WITH FIRST SAMPLE AT X(0). */
/* THIS SIGNAL IS ASSUMED TO CONTINUE WITH ITS FINAL VALUE, */
/*  I.E., X(LX+1)=X(LX), ETC.  THUS A UNIT IMPULSE IS (1.,0.) */
/*  WITH LX=1, A UNIT STEP COULD BE (1.,1.) WITH LX=1, ETC. */
/* Y(0) THRU Y(LY)=COMPUTED RESPONSE TO INPUT SIGNAL X. */
/* B,A=COEFFICIENTS OF CAUSAL LINEAR SYSTEM WITH */
/*  */
/*       B(0)+B(1)*Z**(-1)+B(2)*Z**(-2)+...+B(LB)*Z**(-LB) */
/*  H(Z)=------------------------------------------------- */
/*       1.0+A(1)*Z**(-1)+A(2)*Z**(-2)+...+A(LA)*Z**(-LA) */
/*  */
/* FOR AN FIR SYSTEM, USE LA=1 AND A(1)=0.  DO NOT USE LA=0. */
/* NOTE: ZERO INITIAL CONDITIONS ARE ASSUMED. */

#ifndef KR
void spresp(float *x, float *y, long *lx, long *ly, float *b, float *a, long *lb, long *la)
#else
void spresp(x, y, lx, ly, b, a, lb, la)
long *lx, *ly, *lb, *la;
float *x, *y, *b, *a;
#endif
{
    /* Local variables */
    long k, n;
    float sample;
    double sum;

    for (k = 0 ; k <= *ly ; ++k)
    {
	sum = 0.0;

	for (n = 0 ; n <= *lb ; ++n)
	{
	    sample = 0.0;

	    if ((k - n) >= 0)
	    {
		sample = x[MIN(*lx,(k - n))];
	    }

	    sum += b[n] * sample;
	}

	for (n = 1 ; n <= *la ; ++n)
	{
	    sample = 0.0;

	    if ((k - n) >= 0)
	    {
		sample = y[k - n];
	    }

	    sum -= a[n-1] * sample;
	}

	y[k] = (float) sum;
    }

    return;
} /* spresp */

/* SPRFTM     11/13/85 */
/* FINDS RISE/FALL TIME PARAMETERS FOR N-POINT DATA VECTOR X(0:N-1) */
/* IDIR=1: RISE TIME      IDIR=-1: FALL TIME */
/* LINEAR INTERPOLATION IS USED TO FIND T10 AND T90 */
/* TIMES RETURNED ASSUME NORMALIZED SAMPLE INTERVAL  T=1 */
/* T0: MINIMUM    T10: 10%       T90: 90%      T100: MAXIMUM */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 */
/*        2      INVALID IDIR PARAMETER  .NE.1,-1 */
/*        3      T0=T100   MINIMUM AND MAXIMUM ARE SAME */

#ifndef KR
void sprftm(long *idir, float *x, long *n, float *t0, float *t10, float *t90, float *t100, long *error)
#else
void sprftm(idir, x, n, t0, t10, t90, t100, error)
long *idir, *n, *error;
float *x, *t0, *t10, *t90, *t100;
#endif
{
    /* Local variables */
    long i, imn, k0, k100;
    float a10, a90, xmn, xmx;

    if (*n <= 0)
    {
	*error = 1;
	return;
    }
    if (*idir != 1 && *idir != -1)
    {
	*error = 2;
	return;
    }

    splmts(x,n,&xmn,&imn,&xmx,&k100);

    if (*idir == 1)
    {
	k0 = 0;
    }
    else if (*idir == -1)
    {
	k0 = *n - 1;
    }

    for (i = (k100 - *idir) ; -(*idir) < 0 ? i >= k0 : i <= k0 ;
	 i += -(*idir))
    {
	if (x[i] >= x[i + *idir] && x[i] < x[k100])
	{
	    k0 = i + *idir;
	    goto L2;
	}
    }

L2:
    if (x[k0] == x[k100])
    {
	*error = 3;
	return;
    }

    *t0 = (float) k0;
    *t100 = (float) k100;
    a90 = (x[k100] - x[k0]) * 0.9 + x[k0];
    for (i = k100 ; -(*idir) < 0 ? i >= k0 : i <= k0 ; i += -(*idir))
    {
	if (x[i] < a90)
	{
	    goto L6;
	}
    }

    i = k0;

L6:
    *t90 = (float) i + (float) *idir * (a90 - x[i]) / (x[i + *idir] - x[i]);
    a10 = (x[k100] - x[k0]) * 0.1 + x[k0];
    for (i = k100 ; -(*idir) < 0 ? i >= k0 : i <= k0 ; i += -(*idir))
    {
	if (x[i] < a10)
	{
	    goto L8;
	}
    }

    i = k0;

L8:
    *t10 = (float) i + (float) *idir * (a10 - x[i]) / (x[i + *idir] - x[i]);

    *error = 0;
    return;
} /* sprftm */

/* SPSOLV     10/10/90 */
/* USES GAUSSIAN ELIMINATION TO SOLVE AB=C MATRIX EQUATION */
/* CAUTION:  DO NOT USE WITH ILL-CONDITIONED SYSTEMS */
/* NO PIVOTING IS PERFORMED */
/* A(0:L,0:L) = SQUARE MATRIX INPUT    C(0:L) = VECTOR INPUT */
/* L=ORDER OF SYSTEM OF EQUATIONS */
/* B(0:L) = SOLUTION VECTOR RETURNED */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      INVALID ORDER  L<=0 */
/*        2      ILL-CONDITIONED    PIVOT <1.E-10 */

#ifndef KR
void spsolv(float *a, float *c, long *l, float *b, long *error)
#else
void spsolv(a, c, l, b, error)
long *l, *error;
float *a, *c, *b;
#endif
{
    /* Local variables */
    long i, j, ii, a_dim1;
    float scl, piv;

    a_dim1 = *l + 1;

    if (*l <= 0)
    {
	*error = 1;
	return;
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	b[i] = 0.0;
    }

    for (i = 0 ; i <= *l ; ++i)
    {
	piv = a[i + i * a_dim1];

	if (ABS(piv) < SMALL)
	{
	    *error = 2;
	    return;
	}

	c[i] /= piv;

	for (j = i ; j <= *l ; ++j)
	{
	    a[i + j * a_dim1] /= piv;
	}

	for (ii = i + 1 ; ii <= *l ; ++ii)
	{
	    scl = a[ii + i * a_dim1];
	    c[ii] -= c[i] * scl;

	    for (j = i ; j <= *l ; ++j)
	    {
		a[ii + j * a_dim1] -= a[i + j * a_dim1] * scl;
	    }
	}
    }

    for (i = *l ; i >= 0 ; --i)
    {
	b[i] = c[i];

	for (j = i + 1 ; j <= *l ; ++j)
	{
	    b[i] -= a[i + j * a_dim1] * b[j];
	}
    }

    *error = 0;
    return;
} /* spsolv */

/* SPSTRL     11/13/85 */
/* GENERATES MATRIX OF STIRLING #S OF THE FIRST KIND */

#ifndef KR
void spstrl(long *l, float *s)
#else
void spstrl(l, s)
long *l;
float *s;
#endif
{
    /* Local variables */
    long i, j, s_dim1;

    s_dim1 = *l + 1;

    for (i = 0 ; i <= *l ; ++i)
    {
	s[i] = 0.0;
	s[i + i * s_dim1] = 1.0;

	for (j = i + 1 ; j <= *l ; ++j)
	{
	    s[i + j * s_dim1] = 0.0;
	}
    }

    for (i = 2 ; i <= *l ; ++i)
    {
	s[i + s_dim1] = -((float) i - 1.0) * s[i - 1 + s_dim1];
    }

    for (i = 3 ; i <= *l ; ++i)
    {
	for (j = 2 ; j < i ; ++j)
	{
	    s[i + j * s_dim1] = s[i - 1 + (j - 1) * s_dim1]
				- ((float) i - 1.0)
				* s[i - 1 + j * s_dim1];
	}
    }

    return;
} /* spstrl */

/* SPUNWR     11/13/85 */
/* SIMPLE PHASE UNWRAPPING ROUTINE, USEFUL WHERE PHASE WAS COMPUTED */
/*   USING ATAN2 FUNCTION AND IN SIMILAR SITUATIONS WHERE THE PHASE */
/*   IS WRAPPED INTO THE RANGE FROM -PI TO PI RADIANS. */
/* X(0:LX)=SEQUENCE OF PHASE ANGLES IN RADIANS OR DEGREES, ALL */
/*         ASSUMED TO BE OUTPUTS OF ATAN2 IN THE RANGE (-PI,PI) RAD. */
/* IRD=1 TO INDICATE X IS IN RADIANS, OR 2 TO INDICATE DEGREES. */
/* THE ROUTINE INSERTS A CORRECTION OF 2*PI OR 360 DEGREES WHEREVER */
/*   THE PHASE JUMPS MORE THAN PI RADIANS. */

#ifndef KR
void spunwr(float *x, long *lx, long *ird)
#else
void spunwr(x, lx, ird)
long *lx, *ird;
float *x;
#endif
{
    /* Builtin functions */
    double r_sign();

    /* Local variables */
    long k;
    float angl, dx, tmp_float;
    double cor;

    angl = 180.0;
    if (*ird == 1)
    {
	angl = M_PI;
    }

    cor = 0.0;
    for (k = 1 ; k <= *lx ; ++k)
    {
	dx = x[k] - (x[k - 1] - (float) cor);
	if (ABS(dx) > angl)
	{
	    tmp_float = 2.0 * angl;
	    cor -= r_sign(&tmp_float, &dx);
	}

	x[k] += (float) cor;
    }

    return;
} /* spunwr */

/* SPVARI     05/16/90 */
/* COMPUTES VARIANCE OF N-POINT DATA VECTOR X(0:N-1) */

#ifndef KR
double spvari(float *x, long *n)
#else
double spvari(x, n)
long *n;
float *x;
#endif
{
    /* Local variables */
    double spmean();

    long i;
    double ret_val, tmp_double;

    ret_val = 0.0;
    if (*n <= 1)
    {
	return(ret_val);
    }

    for (i = 0 ; i < *n ; ++i)
    {
	ret_val += (double) (x[i] * x[i]);
    }

    tmp_double = spmean(x, n);

    ret_val = MAX(0.0,(ret_val - (double) *n *
				 (tmp_double * tmp_double))
				 / ((double) *n - 1.0));
    return(ret_val);
} /* spvari */

/* SPWLSH     02/24/86 */
/* GENERATES A WALSH-ORDERED WALSH COEFFICIENT.  THE INPUTS ARE */
/*      LOGN=LOG BASE 2 OF TRANSFORM ARRAY SIZE. */
/*      NSEQ=SEQUENCY INDEX (0 THRU 2**LOGN-1). */
/*      K=TIME INDEX (0 THRU 2**LOGN-1). */
/* SPWLSH IS THE WALSH COEFFICIENT, EITHER -1.0 OR 1.0. */
/* REF. -- AHMED AND RAO(SPRINGER-VERLAG,1975), PAGES 90-91. */

#ifndef KR
double spwlsh(long *logn, long *nseq, long *k)
#else
double spwlsh(logn, nseq, k)
long *logn, *nseq, *k;
#endif
{
    /* Builtin functions */
    long pow_ii();
    double r_mod();

    /* Local variables */
    long i, is1, is2, tmp_int;
    float tmp_float;
    double ret_val;

    tmp_int = *logn - 1;
    is1 = pow_ii(&pos_i2,&tmp_int);

    is2 = 2;

    ret_val = (double) ((long) (*nseq / is1) % 2)
	      * (double) ((long) (*k / pos_i1) % 2);

    for (i = 2 ; i <= *logn ; ++i)
    {
	ret_val += ((double) ((long) (*nseq / is1) % 2)
		   + (double) ((long) (*nseq / (is1 / 2)) % 2))
		   * (double) ((long) (*k / is2) % 2);
	is1 /= 2;
	is2 *= 2;
    }

    tmp_float = (float) ret_val;
    ret_val = 1.0 - 2.0 * r_mod(&tmp_float, &pos_f2);

    return(ret_val);
} /* spwlsh */

/* SPWNDO     11/13/85 */
/* THIS FUNCTION GENERATES A SINGLE SAMPLE OF A DATA WINDOW. */
/* ITYPE=1(RECTANGULAR), 2(TAPERED RECTANGULAR), 3(TRIANGULAR), */
/*       4(HANNING), 5(HAMMING), OR 6(BLACKMAN). */
/*       (NOTE:  TAPERED RECTANGULAR HAS COSINE-TAPERED 10% ENDS.) */
/* N=SIZE (TOTAL NO. SAMPLES) OF WINDOW. */
/* K=SAMPLE NUMBER WITHIN WINDOW, FROM 0 THROUGH N-1. */
/*   (IF K IS OUTSIDE THIS RANGE, WINDOW IS SET TO 0.) */

#ifndef KR
double spwndo(long *type, long *n, long *k)
#else
double spwndo(type, n, k)
long *type, *n, *k;
#endif
{
    /* Local variables */
    long l;
    double ret_val;

    if ((*type < 1 || *type > 6) || (*k < 0 || *k >= *n))
    {
	ret_val = 0.0;
	return(ret_val);
    }

    ret_val = 1.0;

    switch (*type)
    {

	case 1:

	    break;

	case 2:

	    l = (*n - 2) / 10;

	    if (*k <= l)
	    {
		ret_val = 0.5 * (1.0 - cos((double) *k * M_PI
					   / ((double) l + 1.0)));
	    }

	    if (*k > (*n - l - 2))
	    {
		ret_val = 0.5 * (1.0 - cos((double) (*n - *k - 1) * M_PI
					   / ((double) l + 1.0)));
	    }

	    break;

	case 3:

	    ret_val = 1.0 - ABS(1.0 - (double) (*k * 2) / ((double) *n - 1.0));

	    break;

	case 4:

	    ret_val = 0.5 * (1.0 - cos((double) (*k * 2) * M_PI
				       / ((double) *n - 1.0)));

	    break;

	case 5:

	    ret_val = 0.54 - 0.46 * cos((double) (*k * 2) * M_PI
					/ ((double) *n - 1.0));

	    break;

	case 6:

	    ret_val = 0.42 - 0.5 * cos((double) (*k * 2) * M_PI
				       / ((double) *n - 1.0))
		      + 0.08 * cos((double) (*k * 4) * M_PI
				   / ((double) *n - 1.0));

	    break;

    }

    return(ret_val);
} /* spwndo */

/* SPXEXP     11/13/85 */
/* FITS CURVE OF FORM Y=BX*(E**AX) TO X(0:N-1) AND Y(0:N-1) */
/* N SPECIFIES NUMBER OF POINTS    A,B ARE RETURNED */
/* DATA IN X AND Y IS MODIFIED INTERNALLY */
/* IERROR=0      NO ERRORS DETECTED */
/*        1      N<=0 */
/*        2      SPLFIT ERROR = 2 */
/*        3      NEGATIVE DATA - CANNOT COMPUTE LN */

#ifndef KR
void spxexp(float *x, float *y, long *n, float *a, float *b, long *error)
#else
void spxexp(x, y, n, a, b, error)
long *n, *error;
float *x, *y, *a, *b;
#endif
{
    /* Local variables */
    void splfit();

    long i;
    float bln;

    if (*n <= 0)
    {
	*error = 1;
	return;
    }

    *a = 0.0;
    *b = 0.0;

    for (i = 0 ; i < *n ; ++i)
    {
	if (x[i] <= 0.0 || y[i] <= 0.0)
	{
	    *error = 3;
	    return;
	}

	y[i] = (float) (log((double) y[i]) - log((double) x[i]));
    }

    splfit(x, y, n, a, &bln, error);

    if (*error != 0)
    {
	return;
    }

    *b = (float) exp((double) bln);

    return;
} /* spxexp */

/* SPZINT     10/26/90 */
/* INTERPOLATION BETWEEN EQUALLY-SPACED SAMPLES USING ZERO PADDING. */
/* X(0:LX)=DATA VECTOR CONTAINING ORIGINAL SEQUENCE, X(0) THRU X(LX1). */

/* LX1=LAST INDEX OF ORIGINAL DATA SEQUENCE.  (NOTE: X(LX1+1) THRU */
/*     X(LX) CAN BE ANYTHING INITIALLY.)  COMPUTATION IS IN PLACE. */
/* RATIO (R) MUST BE 1./(POWER OF 2.). */
/* ROUTINE WORKS BY TAKING FFT OF X(0:LX1) PADDED WITH N-(LX1+1) ZEROS, */
/*  WHERE N=SMALLEST POWER OF 2 GT LX1, THEN PADDING THE FFT WITH */
/*  ZEROS TO INCREASE LENGTH TO N/R, THEN TAKING THE SCALED INVERSE FFT. */
/* LX MUST BE BIG ENOUGH TO ACCOMODATE FINAL FFT, I.E., */
/*        LX GT ((SMALLEST POWER OF 2) GT LX1)/R. */
/* LX2=LAST INDEX OF OUTPUT SEQUENCE, COMPUTED AS LX1/R. */
/* IERROR=0  NO ERROR DETECTED */
/*        1  RATIO IS NOT THE RECIPROCAL OF A POWER OF 2 */
/*        2  LX IS TOO SMALL FOR X(0:LX) TO HOLD THE INTERPOLATED RESULT. */

#ifndef KR
void spzint(float *x, long *lx, long *lx1, float *ratio, long *lx2, long *error)
#else
void spzint(x, lx, lx1, ratio, lx2, error)
long *lx, *lx1, *lx2, *error;
float *x, *ratio;
#endif
{
    /* Local variables */
    void spfftr(), spiftr();

    long k, n, n2;
    float base;

    base = 1.0;
    base /= 2.0;

    while ((*ratio - base) < 0.0)
    {
	base /= 2.0;
    }

    if ((*ratio - base) == 0)
    {
	n = 1;
	n *= 2;

	while (n <= *lx1)
	{
	     n *= 2;
	}

	n2 = 0.5 + (float) n / *ratio;
	if (n2 >= *lx)
	{
	    *error = 2;
	    return;
	}

	*lx2 = 0.5 + (float) *lx1 / *ratio;
	for (k = 0 ; k <= *lx ; ++k)
	{
	    if (k > *lx1)
	    {
		x[k] = 0.0;
	    }
	    x[k] /= n;
	}

	spfftr(x, &n);
	x[n] /= 2.0;
	spiftr(x, &n2);

	*error = 0;
    }
    else
    {
	*error = 1;
    }

    return;
} /* spzint */

/**********************************************************************/
/*                  Complex arithmetic utilities                      */
/**********************************************************************/

#ifndef KR
double complex_abs(complex *z)
#else
double complex_abs(z)
complex *z;
#endif
{
    return( sqrt(z->r * z->r + z->i * z->i) );
}

#ifndef KR
void complex_div(complex *quotient, complex *numerator, complex *denominator)
#else
void complex_div(quotient, numerator, denominator)
complex *numerator, *denominator, *quotient;
#endif
{
    double ratio, divisor;
    double real, imaginary;

    if( (real = denominator->r) < 0.0)
	real = -real;

    if( (imaginary = denominator->i) < 0.0)
	imaginary = -imaginary;

    if( real <= imaginary )
    {
	if(imaginary == 0)
	{
	    ratio = (double) (1.0 / denominator->r);

	    quotient->r = (float) (numerator->r * ratio);
	    quotient->i = (float) (numerator->i * ratio);
	}
	else
	{
	    ratio = (double) (denominator->r / denominator->i);

	    divisor = (double) denominator->i * (1.0 + ratio * ratio);

	    quotient->r = (float) ((numerator->r * ratio
				   + numerator->i) / divisor);
	    quotient->i = (float) ((numerator->i * ratio
				   - numerator->r) / divisor);
	}
    }
    else
    {
	if(real == 0)
	{
	    ratio = (double) (1.0 / denominator->i);

	    quotient->r = (float) (numerator->i * ratio);
	    quotient->i = (float) (-numerator->r * ratio);
	}
	else
	{
	    ratio = (double) (denominator->i / denominator->r);

	    divisor = (double) denominator->r * (1.0 + ratio * ratio);

	    quotient->r = (float) ((numerator->r
				   + numerator->i * ratio) / divisor);
	    quotient->i = (float) ((numerator->i
				   - numerator->r * ratio) / divisor);
	}
    }
}

#ifndef KR
void complex_exp(complex *r, complex *z)
#else
void complex_exp(r, z)
complex *r, *z;
#endif
{
    double expx;

    expx = exp((double) z->r);

    r->r = (float) expx * cos((double) z->i);
    r->i = (float) expx * sin((double) z->i);
}

#ifndef KR
void pow_ci(complex *result, complex *a, long *b)
#else
void pow_ci(result, a, b)
complex *result, *a;
long *b;
#endif
{
    void pow_zi();
    doublecomplex p1, a1;

    a1.r = (double) a->r;
    a1.i = (double) a->i;

    pow_zi(&p1, &a1, b);

    result->r = (float) p1.r;
    result->i = (float) p1.i;
}

#ifndef KR
long pow_ii(long *ap, long *bp)
#else
long pow_ii(ap, bp)
long *ap, *bp;
#endif
{
    long pow, x, n;

    pow = 1;
    x = *ap;
    n = *bp;

    if(n > 0)
    {
	for( ; ; )
	{
	    if(n & 01)
		pow *= x;

	    if(n >>= 1)
		x *= x;
	    else
		break;
	}
    }

    return(pow);
}

#ifndef KR
double pow_ri(float *ap, long *bp)
#else
double pow_ri(ap, bp)
float *ap;
long *bp;
#endif
{
    double pow, x;
    long n;

    pow = 1;
    x = *ap;
    n = *bp;

    if(n != 0)
    {
	if(n < 0)
	{
	    if(x == 0)
	    {
		return(pow);
	    }
	    n = -n;
	    x = 1/x;
	}

	for( ; ; )
	{
	    if(n & 01)
		pow *= x;

	    if(n >>= 1)
		x *= x;
	    else
		break;
	}
    }

    return(pow);
}

#ifndef KR
void pow_zi(doublecomplex *p, doublecomplex *a, long *b) 	/* p = a**b  */
#else
void pow_zi(p, a, b) 	/* p = a**b  */
doublecomplex *p, *a;
long *b;
#endif
{
    void z_div();
    long n;
    double t;
    doublecomplex x;
    static doublecomplex one = {1.0, 0.0};

    n = *b;
    p->r = 1;
    p->i = 0;

    if(n == 0)
	return;

    if(n < 0)
    {
	n = -n;
	z_div(&x, &one, a);
    }
    else
    {
	x.r = a->r;
	x.i = a->i;
    }

    for( ; ; )
    {
	if(n & 01)
	{
	    t = p->r * x.r - p->i * x.i;
	    p->i = p->r * x.i + p->i * x.r;
	    p->r = t;
	}

	if(n >>= 1)
	{
	    t = x.r * x.r - x.i * x.i;
	    x.i = 2 * x.r * x.i;
	    x.r = t;
	}
	else
	{
	    break;
	}
    }
}

#ifndef KR
void r_cnjg(complex *r, complex *z)
#else
void r_cnjg(r, z)
complex *r, *z;
#endif
{
    r->r = z->r;
    r->i = -z->i;
}

#ifndef KR
double r_mod(float *x, float *y)
#else
double r_mod(x, y)
float *x, *y;
#endif
{
    double floor(), quotient;

    if( (quotient = (double) (*x / *y)) >= 0)
    {
	quotient = floor(quotient);
    }
    else
    {
	quotient = floor(-quotient);
    }

    return((double) *x - (double) *y * quotient );
}

#ifndef KR
double r_sign(float *a, float *b)
#else
double r_sign(a, b)
float *a, *b;
#endif
{
    double x;

    x = (double) (*a >= 0 ? *a : - *a);

    return((double) ( *b >= 0 ? x : -x) );
}

#ifndef KR
void z_div(doublecomplex *quotient, doublecomplex *numerator, doublecomplex *denominator)
#else
void z_div(quotient, numerator, denominator)
doublecomplex *numerator, *denominator, *quotient;
#endif
{
    double ratio, divisor;
    double real, imaginary;

    if( (real = denominator->r) < 0.0)
	real = -real;

    if( (imaginary = denominator->i) < 0.0)
	imaginary = -imaginary;

    if( real <= imaginary )
    {
	if(imaginary == 0)
	{
	    ratio = (double) (1.0 / denominator->r);

	    quotient->r = (float) (numerator->r * ratio);
	    quotient->i = (float) (numerator->i * ratio);
	}
	else
	{
	    ratio = (double) (denominator->r / denominator->i);

	    divisor = (double) denominator->i * (1.0 + ratio * ratio);

	    quotient->r = (float) ((numerator->r * ratio
				   + numerator->i) / divisor);
	    quotient->i = (float) ((numerator->i * ratio
				   - numerator->r) / divisor);
	}
    }
    else
    {
	if(real == 0)
	{
	    ratio = (double) (1.0 / denominator->i);

	    quotient->r = (float) (numerator->i * ratio);
	    quotient->i = (float) (-numerator->r * ratio);
	}
	else
	{
	    ratio = (double) (denominator->i / denominator->r);

	    divisor = (double) denominator->r * (1.0 + ratio * ratio);

	    quotient->r = (float) ((numerator->r
				   + numerator->i * ratio) / divisor);
	    quotient->i = (float) ((numerator->i
				   - numerator->r * ratio) / divisor);
	}
    }
}

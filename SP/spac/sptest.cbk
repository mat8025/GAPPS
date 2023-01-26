
/* SPTEST */
/* Latest date: 06/30/92 */
#include <math.h>
#define MIN(a,b) ((a) <= (b) ? (a) : (b))
#define MAX(a,b) ((a) >= (b) ? (a) : (b))

typedef struct {
	float r, i;
} complex;

long i0 = 0;
long pos_i1 = 1;
long pos_i2 = 2;
long pos_i3 = 3;
long pos_i4 = 4;
long pos_i5 = 5;
long pos_i6 = 6;
long pos_i7 = 7;
long pos_i8 = 8;
long pos_i9 = 9;
long pos_i10 = 10;
long pos_i15 = 15;
long pos_i23 = 23;
long pos_i30 = 30;
long pos_i31 = 31;
long pos_i64 = 64;
long pos_i99 = 99;
long neg_i1 = -1;
float f0 = 0.0;
float pos_fp05 = 0.05;
float pos_fp1 = 0.1;
float pos_fp2 = 0.2;
float pos_fp25 = 0.25;
float pos_fp3 = 0.3;
float pos_fp4 = 0.4;
float pos_fp6 = 0.6;
float pos_fp75 = 0.75;
float pos_f1p3 = 1.3;
float pos_f2 = 2.0;
float pos_f2p5 = 2.5;
float pos_f3 = 3.0;
float pos_f10 = 10.0;
float pos_f20 = 20.0;

/* Initialized data */

/* FIXED ARRAYS: */
float a[8]= { -0.9, 1.45, -0.576,.5184,-1.18,.81,0.,0. },
      b[10] = { 1.,2.,3.,4.,5.,1.,1.,0.,0.,0. },
      c[5] = { 1.,-6.,22.,-46.,40. },
      d[5] = { 1.,0.,5.,0.,4. },
      ka[4] = { -.38,.85,-.15,.52 },
      nu[5] = { -3.15,-1.33,2.74,8.5,5. },
      u[25] = { 9.,4.,-1.,-4.,0.,1.,8.,-2.,-5.,0.,2.,5.,7.,1.,0.,3.,6.,-3.,6.,0.,0.,0.,0.,0.,1. },
      v[5] = { 29.,59.,4.,13.,1. },
      xc[5] = { 2.,4.,5.,6.,8. },
      xf[10] = { 15.,14.,12.,9.,7.,6.,4.,3.,2.,1. },
      yc[5] = { 1.,2.,3.,5.,2. };

#ifndef KR
main(void)
#else
main()
#endif
{
/* VARIABLE ARRAYS: */
    float at[4], at2[5], bt[5], bt2[10], kat[4], nut[5], wk[18], wk2[15],
	  wk3[25], x[100], y[100];
    complex cwk[16], cx[16], cy[9];

    /* Local variables */
    void spdeci(), spchbi(), spcbii(), spout(), spdftc(), spbwcf(), spfftc(),
	 sphilb(), spbiln(), spfird(), spfblt(), spcflt(), spiird(), spltcf(), 
	 spmask(), spchrp(), spdurb(), spdftr(), spfilt(), spfftr(), spfirl(), 
	 spbssl(), spconv(), spcorr(), spcros(), spfltr(), spexpn(), spidtr(),
	 spiftr(), splevs(), splfit(), splflt(), splint(), splmts(), splsmt(),
	 spnlms(), spnorm(), sporth(), sppflt(), sppoly(), sppowr(), sppwrc(),
	 spresp(), sprftm(), spsolv(), spstrl(), spunwr(), spxexp(), spzint();
    complex spgain(), spcomp();
    long i1, i2, ie, i, j, k, lx2, ns, tmp_int1, tmp_int2;
    long seed;
    float c0, c1, q, s1, s2, sig, t0, t10, t90, t100, tsv, x1, x2;
    double complex_abs(), r_imag(), pow_ri(), pow_dd();
    double spbfct(), spmean(), spvari(), spwlsh(), spwndo(), sprand();

/************************************************************************/
/*                             SPTEST.FOR                               */
/*             SIGNAL PROCESSING ALGORITHMS SUBPROGRAM TESTS            */
/*                       Source code in C                               */
/************************************************************************/
/* This program tests the subroutines and functions in SIGNAL PROCESSING */
/*  ALGORITHMS, Appendix A1.  In each test the message "passed" or */
/*  "failed" is printed after the name of the routine by the spout */
/*  subroutine at the end of this program. */
/* Each test checks for correct performance for a specific input, not for */
/*  all inputs, so the test is a check rather than a guarantee that the */
/*  routine is working correctly. */
/* A performance factor, Q, is computed as a function of the subroutine */
/*  output and compared with its correct value in the "spout" */
/*  statement.  For example, the correct value of Q in the test of the */
/*  SPFFTR subroutine is 8389.506.  A check sum of the data arrays in this */
/*  program is also computed, to assure that they remain intact. */
/* If a test fails, check the listings of both the subroutine and this */
/*  program against those in Appendix B1 of SIGNAL PROCESSING ALGORITHMS. */
/*  If the listings agree, make sure your compiler meets the C */
/*  standard.  Next, try printing the float value of Q for this test. */
/*  There may be a roundoff error.  If all else fails to yield a reason */
/*  for the failure, call John M.A. Salas at a reasonable hour. */

/* FIXED DATA CHECK SUM: */
    s1 = xf[5] + xf[6] + xf[7] + xf[8] + xf[9];
    for (k = 0 ; k <= 4 ; ++k)
    {
	for (i = 0 ; i <= 4 ; ++i)
	{
	    s1 += u[i + k * 5];
	    if ((i + 1) / 2 == 1 && k >= 1)
	    {
		s1 += a[k + (i << 2) - 5];
	    }
	    if ((i + 1) / 2 == 1)
	    {
		s1 += b[k + i * 5 - 5];
	    }
	}
	s1 = s1 + c[k] + d[k] + nu[k] + xc[k] + yc[k] + v[k];
	if (k <= 3)
	{
	    s1 += ka[k];
	}
    }

/************************************************************************/

/* TEST OF SPBFCT. */

    q = 0.0;
    for (i = 5 ; i <= 7 ; ++i)
    {
	tmp_int1 = i - 2;
	q += (float) spbfct(&i, &tmp_int1);
    }

    tmp_int1 = (long) (2940.0 - q);
    spout("SPBFCT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPBILN. */

    spbiln(d, c, &pos_i4, bt, at, wk3, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q -= 100.0 * ((float) (k + 1) * bt[k] +
		      (float) (k + 7) * at[MAX(1,k) - 1]);
    }

    tmp_int1 = (long) (3354.546 - q);
    spout("SPBILN ", &tmp_int1);

/************************************************************************/

/* TEST OF SPBSSL. */

    spbssl(&pos_i4, &pos_f1p3, &pos_i4, x, y, &ie);

    q = (float) ie;
    for (i = 0 ; i <= 4 ; ++i)
    {
	q += 10.0 * x[i] + 9.0 * y[i];
    }

    tmp_int1 = (long) (4131.385 - q);
    spout("SPBSSL ", &tmp_int1);

/************************************************************************/

/* TEST OF SPBWCF. */

    spbwcf(&pos_i4, &pos_i2, &pos_i4, bt, at, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 100.0 * ((float) (k + 1) * bt[k] + (float) (k + 7) * at[k]);
    }

    tmp_int1 = (long) (3178.207 - q);
    spout("SPBWCF ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCBII. */

    spcbii(&pos_i4, &pos_i2, &pos_i4, &pos_f1p3, &pos_f10, bt, at2, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 10.0 * ((float) (k + 1) * bt[k] +
		     (float) (k + 7) * at2[k]);
    }

    tmp_int1 = (long) (5225.932 - q);
    spout("SPCBII ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCFLT. */

    for (k = 0 ; k < 18 ; ++k)
    {
	wk[k] = 0.0;
    }

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) (3 * (k + 1));
	wk[k] = (float) k;
    }

    spcflt(b, a, &pos_i3, &pos_i2, x, &pos_i10, wk, &wk[5], &ie);

    q = (float) ie;
    for (k = 0 ; k <= 9 ; ++k)
    {
	q -= (float) (k + 1) * x[k] / 2.0;
    }

    tmp_int1 = (long) (8502.668 - q);
    spout("SPCFLT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCHBI. */

    spchbi(&pos_i4, &pos_i2, &pos_i4, &pos_fp4, bt, at2, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 100.0 * ((float) (k + 1) * bt[k] +
		      (float) (k + 7) * at2[k]);
    }

    tmp_int1 = (long) (1786.760 - q);
    spout("SPCHBI ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCHRP. */

    for (k = 0 ; k <= 8 ; ++k)
    {
	cx[k].r = xf[k];
	cx[k].i = xf[k + 1];
    }

    for (k = 0 ; k < 16 ; ++k)
    {
	cwk[k].r = 0.0;
	cwk[k].i = 0.0;
    }

    spchrp(cx, &pos_i15, &pos_i8, &pos_fp1, &pos_fp3, cwk, &lx2, &ie);

    q = (float) (ie + lx2);
    for (k = 0 ; k <= lx2 ; ++k)
    {
	q += (float) (10.0 * (double) k * complex_abs(&cx[k]));
    }

    tmp_int1 = (long) (4609.930 - q);
    spout("SPCHRP ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCOMP. */

    cy[0] = spcomp(xf, &pos_i8, &pos_fp2);

    q = (float) (100.0 * complex_abs(cy));

    tmp_int1 = (long) (1680.271 - q);
    spout("SPCOMP ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCONV. */

    for (k = 0 ; k <= 7 ; ++k)
    {
	y[k] = (float) MAX((4 - k),0);
	x[k] = (float) MAX((5 - k),0);
    }

    spconv(x, y, &pos_i9, &i0, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 7 ; ++k)
    {
	q += 10.0 * (float) k * x[k];
    }

    tmp_int1 = (long) (3500.0 - q);
    spout("SPCONV ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCORR. */

    for (k = 0 ; k <= 7 ; ++k)
    {
	y[k] = (float) MAX((k - 3),0);
	x[k] = (float) MAX((6 - k),0);
    }

    spcorr(x, y, &pos_i9, &pos_i1, &pos_i6, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 7 ; ++k)
    {
	q += 10.0 * (float) k * x[k];
    }

    tmp_int1 = (long) (9180.001 - q);
    spout("SPCORR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPCROS. */

    for (k = 0 ; k <= 99 ; ++k)
    {
	x[k] = (float) ((k + 1) % 10);
	y[k] = (float) (-((k + 1) % 14));
    }

    for (k = 0 ; k < 16 ; ++k)
    {
	cwk[k].r = 0.0;
	cwk[k].i = 0.0;
    }

    spcros(x, y, cy, cwk, &pos_i99, &pos_i8, &pos_i1, &pos_fp75, &ns, &ie);

    q = (float) (ns + ie);
    for (k = 0 ; k <= 8 ; ++k)
    {
	q -= 10.0 * (cy[k].r + 3.0 * cy[k].i);
    }

    tmp_int1 = (long) (4604.694 - q);
    spout("SPCROS ", &tmp_int1);

/************************************************************************/

/* TEST OF SPDECI. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) ((k + 1) * (k + 1));
    }

    spdeci(x, &pos_i9, &pos_f1p3, &lx2, &ie);

    q = (float) (ie + lx2);
    for (k = 0; k <= lx2; ++k)
    {
	q += (float) k * x[k];
    }

    tmp_int1 = (long) (1012.7 - q);
    spout("SPDECI ", &tmp_int1);

/************************************************************************/

/* TEST OF SPDFTC. */

    for (k = 0 ; k <= 7 ; ++k)
    {
	cx[k].r = 3.0 * (float) k;
	cx[k].i = 5.0 * (float) k;
    }

    spdftc(cx, cy, &pos_i8, &neg_i1);

    q = 0.0;
    for (k = 0 ; k <= 7 ; ++k)
    {
	q += (float) (k + 1) * (float) (k + 1) * cy[k].r -
	     (float) (k + 3) * cy[k].i;
    }

    tmp_int1 = (long) (2302.498 - q);
    spout("SPDFTC ", &tmp_int1);

/************************************************************************/

/* TEST OF SPDFTR.  PERFORM A TRANSFORM AND TEST A CHECKSUM (Q). */

    spdftr(xf, cy, &pos_i8);

    q = 0.0;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 10.0 * ((float) (k + 1) * cy[k].r -
		     (float) ((k + 3) * (k + 3)) * cy[k].i);
    }

    tmp_int1 = (long) (7179.453 - q);
    spout("SPDFTR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPDURB. */

    spdurb(xf, &pos_i3, bt, &ie);

    q = (float) ie + 100.0 * (10.0 * bt[0] + 9.0 * bt[1] +
			      8.0 * bt[2] + 7.0 * bt[3]);

    tmp_int1 = (long) (1067.500 - q);
    spout("SPDURB ", &tmp_int1);

/************************************************************************/

/* TEST OF SPEXPN. */

    for (k = 0 ; k <= 4 ; ++k)
    {
	y[k] = yc[k];
    }

    spexpn(xc, y, &pos_i5, &c0, &c1, &ie);

    q = 1000.0 * c0 + 955.0 * c1;

    tmp_int1 = (long) (2181.754 - q);
    spout("SPEXPN ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFBLT. */

    for (i = 0 ; i <= 4 ; ++i)
    {
	x[i] = c[i];
	y[i] = d[i];
    }

    spfblt(y, x, &pos_i4, &pos_i2, &pos_fp1, &f0, bt, at, wk3, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 10.0 * ((float) (k + 1) * bt[k] +
		     (float) (k + 7) * at[MAX(1,k) - 1]);
    }

    tmp_int1 = (long) (2778.627 - q);
    spout("SPFBLT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFFTC. */

    for (k = 0 ; k <= 7 ; ++k)
    {
	tmp_int1 = -k;
	cx[k].r = (float) pow_ri(&pos_f2, &tmp_int1);
	cx[k].i = (float) pow_ri(&pos_f3, &tmp_int1);
    }

    spfftc(cx, &pos_i8, &neg_i1);

    q = 0.0;
    for (k = 0 ; k <= 7 ; ++k)
    {
	q += 10.0 * ((float) ((k + 1) * (k + 1)) * cx[k].r +
		     (float) (k + 3) * cx[k].i);
    }

    tmp_int1 = (long) (2000.563 - q);
    spout("SPFFTC ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFFTR. */

    for (k = 0 ; k <= 7 ; ++k)
    {
	tmp_int1 = -k;
	x[k] = pow_ri(&pos_f2, &tmp_int1);
    }

    spfftr(x, &pos_i8);

    q = 0.0;

    for (k = 0 ; k <= 9 ; ++k)
    {
	q += 100.0 * (float) ((k + 1) * (k + 1)) * x[k];
    }

    tmp_int1 = (long) (8389.506 - q);
    spout("SPFFTR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFILT. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) (3 * (k + 1));
	wk[k] = (float) k;
    }

    spfilt(b, a, &pos_i3, &pos_i4, x, &pos_i10, wk, &wk[5], &ie);

    q = (float) ie;
    for (k = 0 ; k <= 9 ; ++k)
    {
	q += (float) (k + 1) * x[k];
    }

    tmp_int1 = (long) (7141.861 - q);
    spout("SPFILT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFIRD. */

    spfird(&pos_i4, &pos_i3, &pos_fp3, &pos_fp4, &pos_i1, bt, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q -= 10000.0 * bt[k];
    }

    tmp_int1 = (long) (1468.984 - q);
    spout("SPFIRD ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFIRL. */

    spfirl(&pos_i4, &pos_fp4, &pos_i1, bt, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 10000.0 * bt[k];
    }

    tmp_int1 = (long) (8714.65 - q);
    spout("SPFIRL ", &tmp_int1);

/************************************************************************/

/* TEST OF SPFLTR. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	wk[k] = (float) k;
    }

    spfltr(b, a, &pos_i3, &pos_i4, xf, &pos_i10, y, wk, &wk[5], &ie);

    q = (float) ie;
    for (k = 0 ; k <= 9 ; ++k)
    {
	q += (float) (k + 1) * y[k] / 2.0;
    }

    tmp_int1 = (long) (1172.911 - q);
    spout("SPFLTR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPGAIN. */

    cy[0] = spgain(b, a, &pos_i2, &pos_i3, &pos_fp2);

    q = 1000.0 * (cy[0].r + cy[0].i);

    tmp_int1 = (long) (7923.157 - q);
    spout("SPGAIN ", &tmp_int1);

/************************************************************************/

/* TEST OF SPHILB. */

    sphilb(x, &pos_i31);

    q = 0.0;
    for (k = 0 ; k <= 31 ; ++k)
    {
	q += 1000.0 * (float) k * x[k];
    }

    tmp_int1 = (long) (5207.549 - q);
    spout("SPHILB ", &tmp_int1);

/************************************************************************/

/* TEST OF SPIDTR. */

    for (k = 0 ; k <= 4 ; ++k)
    {
	cy[k].r = 3.0 * (float) k;
	cy[k].i = 5.0 * (float) k;
    }

    spidtr(cy, x, &pos_i8);

    q = 0.0;
    for (k = 0 ; k <= 7 ; ++k)
    {
	q += (k + 1) * (k + 1) * 10. * x[k];
    }

    tmp_int1 = (long) (7349.793 - q);
    spout("SPIDTR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPIFTR. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	tmp_int1 = -k;
	x[k] = pow_ri(&pos_f2, &tmp_int1);
    }

    spiftr(x, &pos_i8);

    q = 0.;
    for (k = 0 ; k <= 7 ; ++k)
    {
	q += 10.0 * (float) ((k + 1) * (k + 1)) * x[k];
    }

    tmp_int1 = (long) (2369.153 - q);
    spout("SPIFTR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPIIRD. */

    for (k = 0 ; k < 5 ; ++k)
    {
	at2[k] = 0.0;
    }

    for (k = 0 ; k < 10 ; ++k)
    {
	bt2[k] = 0.0;
    }

    spiird(&pos_i2, &pos_i3, &pos_i2, &pos_i4, &pos_fp1, &pos_fp2,
	   &pos_fp3, &pos_fp4, &pos_f20, bt2, at2, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 4 ; ++k)
    {
	q += 1000.0 * (at2[MAX(k,1) - 1] + at2[MAX(k,1) + 3] +
		       bt2[k] + bt2[k + 5]);
    }

    tmp_int1 = (long) (1026.385 - q);
    spout("SPIIRD ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLEVS. */

    splevs(xf, &xf[1], &pos_i3, bt, wk, &ie);

    q = (float) ie + 100.0 * (10.0 * bt[0] + 9.0 * bt[1] +
			      8.0 * bt[2] + 7.0 * bt[3]);

    tmp_int1 = (long) (1067.500 - q);
    spout("SPLEVS ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLFIT. */

    splfit(xc, yc, &pos_i5, &c0, &c1, &ie);

    q = 1000.0 * c0 + 955.0 * c1;

    tmp_int1 = (long) (1350.5 - q);
    spout("SPLFIT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLFLT. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) (3 * (k + 1));
	wk[k] = (float) k;
    }

    splflt(ka, nu, &pos_i4, x, &pos_i10, wk, &ie);

    q = (float) ie;
    for (k = 0 ; k <= 9 ; ++k)
    {
	q += 100.0 * (float) (k + 1) * x[k] / 100.0;
    }

    tmp_int1 = (long) (9582.598 - q);
    spout("SPLFLT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLINT. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) ((k + 1) * (k + 1));
    }

    splint(x, &pos_i99, &pos_i9, &pos_fp25, &lx2, &ie);

    q = (float) (ie + lx2);
    for (k = 0 ; k <= lx2 ; ++k)
    {
	q += 0.1 * (float) k * x[k];
    }

    tmp_int1 = (long) (3695.25 - q);
    spout("SPLINT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLMTS. */

    splmts(xf, &pos_i10, &x1, &i1, &x2, &i2);

    q = 1000.0 * x1 + 100.0 * x2 + 100.0 * (float) (i1 + i2);

    tmp_int1 = (long) (3400. - q);
    spout("SPLMTS ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLSMT. */

    splsmt(&pos_i9, &pos_i4, wk3);

    for (i = 0 ; i <= 4 ; ++i)
    {
	q = 100.0 * (9.0 * wk3[i] - 8.0 * wk3[i + 5] + 7.0 * wk3[i + 10] -
		     6.0 * wk3[i + 15] + wk3[i + 20]);
    }

    tmp_int1 = (long) (4279.167 - q);
    spout("SPLSMT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPLTCF */

    spltcf(b, a, &pos_i4, kat, nut, wk2, &ie);

    q = ie + 10.0 * nut[4];
    for (k = 0 ; k <= 3 ; ++k)
    {
	q += 10.0 * ((float) (k + 1) * kat[k] + (float) (k + 10) * nut[k]);
    }

    tmp_int1 = (long) (1051.609 - q);
    spout("SPLTCF ", &tmp_int1);

/************************************************************************/

/* TEST OF SPMASK. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = xf[k];
    }

    spmask(x, &pos_i9, &pos_i6, &tsv, &ie);

    q = ie + tsv * 100.0;
    for (k = 0 ; k <= 9 ; ++k)
    {
	q += 10.0 * (float) k * x[k];
    }

    tmp_int1 = (long) (1278.456 - q);
    spout("SPMASK ", &tmp_int1);

/************************************************************************/

/* TEST OF SPMEAN. */

    q = (float) (10.0 * spmean(xf, &pos_i10));

    tmp_int1 = (long) (73.0 - q);
    spout("SPMEAN ", &tmp_int1);

/************************************************************************/

/* TEST OF SPNLMS. */

    for (i = 0 ; i <= 8 ; ++i)
    {
	x[i] = xf[i];
	y[i] = xf[i + 1];
	if (i <= 4)
	{
	    bt[i] = (float) i;
	}
	if (i <= 4)
	{
	    wk[i] = (float) (-i);
	}
    }

    sig = 100.0;

    spnlms(x, &pos_i9, y, bt, &pos_i4, &pos_fp1, &sig, &pos_fp05, wk, &ie);

    q = (float) ie + 100.0 * (10.0 * bt[0] + 9.0 * bt[1] + 8.0 * bt[2] +
			      7.0 * bt[3] + 6.0 * bt[4]) + x[5];

    tmp_int1 = (long) (2009.807 - q);
    spout("SPNLMS ", &tmp_int1);

/************************************************************************/

/* TEST OF SPNORM. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) ((k + 1) * (k + 1)) / 100.0;
	y[k] = (float) cos((double) k / 3.0);
    }

    spnorm(x, y, &pos_i10, &pos_i4, wk3, wk, &ie);

    q = (float) ie;
    for (i = 0 ; i <= 4 ; ++i)
    {
	for (j = 0; j <= 4; ++j)
	{
	    q -= 100.0 * (float) i * (float) j * (wk3[i + j * 5] + wk[i]);
	}
    }

    tmp_int1 = (long) (2971.514 - q);
    spout("SPNORM ", &tmp_int1);

/************************************************************************/

/* TEST OF SPORTH. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	y[k] = (float) (pow((double) (k + 1) , pos_f2p5) / 10.0);
    }

    sporth(y, &pos_i10, &pos_i4, bt, wk3, &ie);

    q = (float) ie + 1000.0 * (10.0 * bt[0] + 9.0 * bt[1] + 8.0 * bt[2] +
			       7.0 * bt[3] + 6.0 * bt[4]);

    tmp_int1 = (long) (7143.835 - q);
    spout("SPORTH ", &tmp_int1);

/************************************************************************/

/* TEST OF SPPFLT. */

    for (k = 10 ; k <= 27 ; ++k)
    {
	y[k] = (float) k;
    }

    sppflt(b, a, &pos_i4, &pos_i2, xf, &pos_i10, y, &y[10], &y[20], &ie);

    q = (float) ie;
    for (k = 0 ; k <= 9 ; ++k)
    {
	q += (float) (k + 1) * y[k];
    }

    tmp_int1 = (long) (4361.801 - q);
    spout("SPPFLT ", &tmp_int1);

/************************************************************************/

/* TEST OF SPPOLY. */

    sppoly(&pos_fp6, xf, &pos_i10, &pos_i4, bt, wk, wk3, &ie);

    q = (float) ie + 10.0 * (10.0 * bt[0] + 9.0 * bt[1] + 8.0 * bt[2] +
			     7.0 * bt[3] + 6.0 * bt[4]);

    tmp_int1 = (long) (1287.019 - q);
    spout("SPPOLY ", &tmp_int1);

/************************************************************************/

/* TEST OF SPPOWR. */

    for (k = 0 ; k <= 99 ; ++k)
    {
	x[k] = (float) ((k + 1) % 10);
    }

    sppowr(x, y, wk, &pos_i99, &pos_i8, &pos_i1, &pos_fp75, &ns, &ie);

    q = (float) (ns + ie);
    for (k = 0 ; k <= 8 ; ++k)
    {
	q += 10.0 * y[k];
    }

    tmp_int1 = (long) (3966.887 - q);
    spout("SPPOWR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPPWRC. */

    for (k = 0 ; k <= 4 ; ++k)
    {
	x[k] = xc[k];
	y[k] = yc[k];
    }

    sppwrc(x, y, &pos_i5, &c0, &c1, &ie);

    q = 1000.0 * c0 + 955.0 * c1;

    tmp_int1 = (long) (1441.503 - q);
    spout("SPPWRC ", &tmp_int1);

/************************************************************************/

/* TEST OF SPRAND. */

    seed = 12345;
    q = 0.0;
    for (k = 0; k <= 99; ++k)
    {
	q += (float) (100.0 * sprand(&seed));
    }

    tmp_int1 = (long) (4690.126 - q);
    spout("SPRAND ", &tmp_int1);

/************************************************************************/

/* TEST OF SPRESP. */

    spresp(xf, y, &pos_i3, &pos_i9, b, a, &pos_i2, &pos_i3);

    q = xf[1];
    for (k = 0 ; k <= 9 ; ++k)
    {
	q += (float) (k + 1) * y[k];
    }

    tmp_int1 = (long) (2826.438 - q);
    spout("SPRESP ", &tmp_int1);

/************************************************************************/

/* TEST OF SPRFTM. */

    for (k = 0 ; k <= 29 ; ++k)
    {
	x[k] = MIN(1.0,(k / 15.0)) * (float) MIN((k / 3),1);
    }

    sprftm(&pos_i1, x, &pos_i30, &t0, &t10, &t90, &t100, &ie);

    q = 100.0 * (5.0 * t0 + 4.0 * t10 + 3.0 * t90 + 2.0 * t100);

    tmp_int1 = (long) (9050.0 - q);
    spout("SPRFTM ", &tmp_int1);

/************************************************************************/

/* TEST OF SPSOLV. */

    for (i = 0 ; i <= 4 ; ++i)
    {
	wk[i] = v[i];
	for (j = 0 ; j <= 4 ; ++j)
	{
	    wk3[i + j * 5] = u[i + j * 5];
	}
    }

    spsolv(wk3, wk, &pos_i4, bt, &ie);

    q = (float) ie + 1000.0 * bt[0] + 100.0 * bt[1] + 10.0 * bt[2] + bt[3];

    tmp_int1 = (long) (1234.0 - q);
    spout("SPSOLV ", &tmp_int1);

/************************************************************************/
/* TEST OF SPSTRL. */

    spstrl(&pos_i4, wk3);

    for (i = 0 ; i <= 4 ; ++i)
    {
	q = 9.0 * wk3[i] - 8.0 * wk3[i + 5] + 7.0 * wk3[i + 10] -
	    6.0 * wk3[i + 15] + wk3[i + 20];
    }

    tmp_int1 = (long) (162.0 - q);
    spout("SPSTRL ", &tmp_int1);

/************************************************************************/

/* TEST OF SPUNWR. */

    for (k = 0 ; k <= 7 ; ++k)
    {
	x[k] = (float) ((k - 4) * (k - 4));
    }

    spunwr(x, &pos_i7, &pos_i1);

    q = 10.0 * (x[0] + 2.0 * x[2] + 3.0 * x[4] + 4.0 * x[6] + 5.0 * x[7]);

    tmp_int1 = (long) (2295.133 - q);
    spout("SPUNWR ", &tmp_int1);

/************************************************************************/

/* TEST OF SPVARI. */

    q = (float) (100.0 * spvari(xf, &pos_i10));

    tmp_int1 = (long) (2534.444 - q);
    spout("SPVARI ", &tmp_int1);

/************************************************************************/

/* TEST OF SPWLSH. */

    q = 0.0;
    for (k = 0 ; k <= 255 ; ++k)
    {
	tmp_int1 = k / 16;
	tmp_int2 = k % 16;
	q -= (float) (0.1 * (double) (k * k) *
		     spwlsh(&pos_i4, &tmp_int1, &tmp_int2));
    }
    tmp_int1 = (long) (1254.402 - q);
    spout("SPWLSH ", &tmp_int1);

/************************************************************************/

/* TEST OF SPWNDO. */

    q = 0.0;
    for (i = 1 ; i <= 6 ; ++i)
    {
	q += (float) (1000.0 * spwndo(&i, &pos_i64, &pos_i23));
    }

    tmp_int1 = (long) (5146.273 - q);
    spout("SPWNDO ", &tmp_int1);

/************************************************************************/

/* TEST OF SPXEXP. */

    for (k = 0 ; k <= 4 ; ++k)
    {
	x[k] = xc[k];
	y[k] = yc[k];
    }

    spxexp(x, y, &pos_i5, &c0, &c1, &ie);

    q = -10000.0 * c0 + 955.0 * c1;

    tmp_int1 = (long) (1491.007 - q);
    spout("SPXEXP ", &tmp_int1);

/************************************************************************/

/* TEST OF SPZINT. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = (float) ((k + 1) * (k + 1));
    }

    spzint(x, &pos_i99, &pos_i9, &pos_fp25, &lx2, &ie);

    q = (float) (ie + lx2);
    for (k = 0 ; k <= lx2 ; ++k)
    {
	q += 0.1 * (float ) k * x[k];
    }

    tmp_int1 = (long) (3775.586 - q);
    spout("SPZINT ", &tmp_int1);

/************************************************************************/

/* FIXED DATA CHECK SUM: */

    s2 = xf[5] + xf[6] + xf[7] + xf[8] + xf[9];

    for (k = 0 ; k <= 4 ; ++k)
    {
	for (i = 0 ; i <= 4 ; ++i)
	{
	    s2 += u[i + k * 5];
	    if ((i + 1) / 2 == 1 && k >= 1)
	    {
		s2 += a[k + (i << 2) - 5];
	    }
	    if ((i + 1) / 2 == 1)
	    {
		s2 += b[k + i * 5 - 5];
	    }
	}

	s2 = s2 + c[k] + d[k] + nu[k] + xc[k] + yc[k] + v[k];

	if (k <= 3)
	{
	    s2 += ka[k];
	}
    }

    tmp_int1 = (long) ((s2 - s1) * 100.0);
    spout("CHEKSUM", &tmp_int1);
}

#ifndef KR
void spout(char *name, long *i)
#else
void spout(name, i)
char *name;
long *i;
#endif
{
    if (*i == 0)
    {
	printf(" %s PASSED.\n", name);
    }
    else if (*i != 0)
    {
	printf(" %s FAILED. !!!\n", name);
    }
    return;
} /* spout */


/* SPXAMP.C is a file of files.  First is an INCLUDE file which should*/
/* be labled SPAINCL.H and #included in each example, and may also be */
/* included in other programs.                                        */

/* .................Begin include file.................*/
/* Latest date: 06/29/92 */

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

typedef struct {
	float r, i;
} complex;

typedef struct {
	double r, i;
} doublecomplex;

/* .................End of include file.................*/

/* SPA0301 */
#include "spaincl.h"

long pos_i8 = 8;

/* Initialized data */

float x[8] = { -6.0, -2.0, 0.0, 2.0, 4.0, 6.0, 3.0, -1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spdftr();
    long m;
    complex y[5];

/* DEMONSTRATION OF THE USE OF SUBROUTINE SPDFTR. */

    spdftr(x, y, &pos_i8);

    printf(" M       REAL     IMAGINARY\n");

    for (m = 0 ; m <= 4 ; ++m)
    {
	printf("%2ld  %10.4f  %10.4f\n", m, y[m].r, y[m].i);
    }
}


/* SPA0302 */
#include "spaincl.h"

long pos_i8 = 8;

/* Initialized data */

float x[10] = { -6.0, -2.0, 0.0, 2.0, 4.0,
			6.0, 3.0, -1.0, 0.0, 0.0};

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spfftr();
    long m;

/* DEMONSTRATION OF THE USE OF SUBROUTINE SPFFTR. */

    spfftr(x, &pos_i8);

    printf(" M       REAL     IMAGINARY\n");

    for (m = 0 ; m <= 9 ; m += 2)
    {
        printf("%2ld  %10.4f  %10.4f\n", m / 2, x[m], x[m+1]);
    }
}


/* SPA0303 */
#include "spaincl.h"

long pos_i8 = 8;

/* Initialized data */

float x1[8] = { -6.0, -2.0, 0.0, 2.0, 4.0, 6.0, 3.0, -1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spdftr(), spidtr();
    long k;
    complex y[5];
    float x2[8];

/* DEMONSTRATION OF THE USE OF SPIDTR. */

    spdftr(x1, y, &pos_i8);
    spidtr(y, x2, &pos_i8);

    printf(" K    X(K)\t K    X(K)\n");

    for (k = 0 ; k <= 3 ; k++)
    {
        printf("%2ld  %6.1f\t%2ld  %6.1f\n", k, x2[k], k + 4, x2[k + 4]);
    }
}

/* SPA0304 */
#include "spaincl.h"

long pos_i8 = 8;

/* Initialized data */

float x[10] = { -6.0, -2.0, 0.0, 2.0, 4.0, 6.0, 3.0, -1.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spfftr(), spiftr();
    long k;

/* DEMONSTRATION OF THE USE OF SUBROUTINE SPIFTR. */

    spfftr(x, &pos_i8);
    spiftr(x, &pos_i8);

    printf(" K    X(K)\t K    X(K)\n");

    for (k = 0 ; k <= 3 ; k++)
    {
        printf("%2ld  %6.1f\t%2ld  %6.1f\n",k, x[k], k + 4, x[k + 4]);
    }
}

/* SPA0305 */
#include "spaincl.h"

long neg_i1 = -1;
long pos_i1 = 1;
long pos_i4 = 4;

/* Initialized data */

complex x1[4] = { {2.0, 1.0 },{0.0, 2.0 },
			 {1.0, 1.0 },{-1.0, 0.0 } };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spdftc();
    long i;
    complex x2[4];

/* DEMONSTRATION OF THE USE OF SUBROUTINE SPDFTC. */

    spdftc(x1, x2, &pos_i4, &neg_i1);
    spdftc(x2, x1, &pos_i4, &pos_i1);

    printf(" I      X1(I)\t\t     X2(I)\n");

    for (i = 0 ; i <= 3 ; i++)
    {
        printf("%2ld  %4.1f   %4.1f  %12.7f   %12.7f\n",
		i, x1[i].r, x1[i].i, x2[i].r, x2[i].i );
    }
}


/* SPA0306 */
#include "spaincl.h"

long neg_i1 = -1;
long pos_i1 = 1;
long pos_i4 = 4;

/* Initialized data */

complex x1[4] = { {2.0, 1.0 },{0.0, 2.0 },
			 {1.0, 1.0 },{-1.0, 0.0 } };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spfftc();
    long i, m;
    complex x2[4];

/* DEMONSTRATION OF THE USE OF SUBROUTINE SPFFTC. */

    spfftc(x1, &pos_i4, &neg_i1);

    for (m = 0 ; m <= 3 ; ++m)
    {
	x2[m].r = x1[m].r;
	x2[m].i = x1[m].i;
    }

    spfftc(x1, &pos_i4, &pos_i1);

    printf(" I      X1(I)\t\t     X2(I)\n");

    for (i = 0 ; i <= 3 ; i++)
    {
        printf("%2ld  %4.1f   %4.1f  %12.7f   %12.7f\n",
                i, x1[i].r, x1[i].i, x2[i].r, x2[i].i);
    }

}


/* SPA0307 */
#include "spaincl.h"

long pos_i8 = 8;

/* Initialized data */

float x[8] = { -6.0, -2.0, 0.0, 2.0, 4.0, 6.0, 3.0, -1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */

    long m;
    complex spcomp(), y;
    float tmp_float;

/* DEMONSTRATION OF THE USE OF COMPLEX FUNCTION SPCOMP */

    printf(" M       REAL     IMAGINARY\n");

    for (m = 0 ; m <= 4 ; ++m)
    {
	tmp_float = m / 8.0;

	y = spcomp(x, &pos_i8, &tmp_float);

	printf("%2ld  %10.4f  %10.4f\n", m, y.r, y.i);
    }
}


/* SPA0401 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i16 = 16;
long pos_i31 = 31;
float f0 = 0.0;
float pos_fp03125 = 0.03125;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void sppowr();
    long k, error, nsgmts, number_points;
    float work[34], x[32], y[17];

/* GENERATES A PERIODOGRAM SIMILAR TO FIG. 4.1. */

    for (k = 0 ; k <= 31 ; ++k)
    {
	x[k] = (float) sin(2.0 * M_PI * (double) k / 8.0);
    }

    sppowr(x, y, work, &pos_i31, &pos_i16, &pos_i1, &f0, &nsgmts, &error);

    printf(" NSGMTS,IERROR= %ld %ld\n", nsgmts, error);
    printf(" Y=");

    for (k = 0 ; k <= 16 ; ++k)
    {
	if ( k == 8 )
	{
	    printf("\n   ");
	}
	printf("%7.3f", y[k]);
    }
    printf("\n");

    number_points = 17;
    pfile2(&f0,&pos_fp03125,y,&number_points,&pos_i1,"P0401A");
}


/* SPA0402 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i16 = 16;
long pos_i999 = 999;
float f0 = 0.0;
float pos_fp03125 = 0.03125;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void sppowr();
    long k, m, error, nsgmts, number_points;
    long seed;
    float work[34], x[1000], y[17];
    double ex2, sprand(), tpower;

/* POWER DENSITY SPECTRUM OF WHITE UNIFORM NOISE. */

    seed = 12357;
    ex2 = 0.0;

    for (k = 0 ; k <= 999 ; ++k)
    {
	x[k] = (float) (6.0 * (sprand(&seed) - 0.5));
	ex2 += (double) (x[k] * x[k] / 1000.0);
    }

    sppowr(x, y, work, &pos_i999, &pos_i16, &pos_i1, &f0, &nsgmts, &error);
    tpower = (double) ((y[0] + y[16]) / 32.0);

    for (m = 1 ; m <= 15 ; ++m)
    {
	tpower += ((double) y[m] * 2.0 / 32.0);
    }

    printf(" IERROR,NSGMTS= %ld  %ld\n", error, nsgmts);
    printf(" Y=");

    for (k = 0 ; k <= 16 ; ++k)
    {
        if ( k == 8 )
        {
            printf("\n   ");
        }
        printf("%7.3f", y[k]);
    }
    printf("\n");

    printf(" ACTUAL POWER, ESTIMATED POWER: %7.3f  %7.3f\n", ex2, tpower);

    number_points = 17;
    pfile2(&f0,&pos_fp03125,y,&number_points,&pos_i1,"P0402A");
}


/* SPA0403 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i16 = 16;
long pos_i999 = 999;
float f0 = 0.0;
float pos_fp03125 = 0.03125;
float pos_fp5 = 0.5;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void sppowr();
    long k, m, error, nsgmts, number_points, work[34];
    long seed;
    float x[1000], y[17];
    double signal, sprand(), tmp_double;

/* POWER DENSITY SPECTRUM OF SINE WAVE IN WHITE UNIFORM NOISE. */

    seed = 12357;

    for (k = 0 ; k <= 999 ; ++k)
    {
	signal = sin(3.0 * M_PI * (double) k / 16.0) +
		 0.5 * sin(7.0 * M_PI * (double) k / 16.0);

	tmp_double = sqrt(0.12) * (sprand(&seed) - 0.5);
	x[k] = (float) (signal + sqrt(0.12) * (sprand(&seed) - 0.5));
    }

    sppowr(x, y, work, &pos_i999, &pos_i16, &pos_i1,
	   &pos_fp5, &nsgmts, &error);

    for (m = 0 ; m <= 16 ; ++m)
    {
	y[m] = (float) (log10((double) y[m]) * 10.0);
    }

    number_points = 17;
    pfile2(&f0,&pos_fp03125,y,&number_points,&pos_i1,"P0403A");

}


/* SPA0404 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i16 = 16;
long pos_i31 = 31;
float f0 = 0.0;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spcros();
    long k, error, nsgmts;
    complex work[32], y[17];
    float x1[32], x2[32];

/* TEST OF SPCROS, WITH RESULT SAME AS FOR SPA0401. */

    for (k = 0 ; k <= 31 ; ++k)
    {
	x1[k] = (float) sin(2.0 * M_PI * (double) k / 8.0);
	x2[k] = (float) sin(2.0 * M_PI * (double) k / 8.0);
    }

    spcros(x1, x2, y, work, &pos_i31, &pos_i16,
	   &pos_i1, &f0, &nsgmts, &error);

    printf(" NSGMTS,IERROR= %ld %ld\n", nsgmts, error);
    printf(" Y=");

    for (k = 0 ; k <= 16 ; ++k)
    {
        if ( ! (k % 4) && k != 0 )
        {
            printf("\n   ");
        }
        printf("%7.3f%7.3f ", y[k].r, y[k].i);
    }
    printf("\n");

}


/* SPA0405 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i8 = 8;
long pos_i31 = 31;
float pos_fp5 = 0.5;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spcros();
    long k, error, nsgmts;
    complex work[16], y[9];
    float x1[32], x2[32];

/* TEST OF SPCROS:  ONE IMAGINARY COMPONENT. */

    for (k = 0 ; k <= 31 ; ++k)
    {
	x1[k] = (float) cos(2.0 * M_PI * (double) k / 8.0);
	x2[k] = (float) sin(2.0 * M_PI * (double) k / 8.0);
    }

    spcros(x1, x2, y, work, &pos_i31, &pos_i8,
	   &pos_i1, &pos_fp5, &nsgmts, &error);

    printf(" NSGMTS,IERROR= %ld %ld\n", nsgmts, error);
    printf(" Y=");

    for (k = 0 ; k <= 8 ; ++k)
    {
        if ( ! (k % 4) && k != 0 )
        {
            printf("\n   ");
        }
        printf("%7.3f%7.3f ", y[k].r, y[k].i);
    }
    printf("\n");

}


/* SPA0406 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i16 =16;
long pos_i999 = 999;
float f0 = 0.0;
float pos_fp03125 = 0.03125;
float pos_fp5 = 0.5;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spcros();
    long k, m, error, nsgmts, number_points;
    long seed;
    complex work[32], y[17];
    float yabs[17], x1[1000], x2[1000];
    double signal, sprand();

/* TEST OF SPCROS:  SAME SIGNAL PLUS INDEPENDENT NOISE. */

    seed = 123;

    for (k = 0 ; k <= 999 ; ++k)
    {
	signal = sin(3.0 * M_PI * k / 16.0)
		 + 0.5 * cos(7.0 * M_PI * k / 16.0);

	x1[k] = (float) (signal + sqrt(12.0) * (sprand(&seed) - 0.5));
	x2[k] = (float) (signal + sqrt(12.0) * (sprand(&seed) - 0.5));
    }

    spcros(x1, x2, y, work, &pos_i999, &pos_i16,
	   &pos_i1, &pos_fp5, &nsgmts, &error);

    for (m = 0 ; m <= 16 ; ++m)
    {
	yabs[m] = y[m].r;
    }

    number_points = 17;
    pfile2(&f0,&pos_fp03125,yabs,&number_points,&pos_i1,"P0406A");
}


/* SPA0501 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i2 = 2;
float pos_fp25 = 0.25;

/* Initialized data */

float a = 0.6, b = 2.0, c = 0.0,
      d[3] = { 0.3, 0.8, 0.2 },
      f[2] = { 0.0, -0.1 },
      e[2] = { 0.0, 0.9 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    complex spgain(), tmp_complex;

/* DEMONSTRATION OF THE USE OF "SPGAIN" AT A SINGLE FREQUENCY. */

    printf("      REAL      IMAG\n");

    tmp_complex = spgain(&b, &a, &i0, &pos_i1, &pos_fp25);
    printf("%10.4f  %10.4f\n", tmp_complex.r, tmp_complex.i);

    tmp_complex = spgain(d, &c, &pos_i2, &pos_i1, &pos_fp25);
    printf("%10.4f  %10.4f\n", tmp_complex.r, tmp_complex.i);

    tmp_complex = spgain(f, e, &pos_i1, &pos_i2, &pos_fp25);
    printf("%10.4f  %10.4f\n", tmp_complex.r, tmp_complex.i);
}


/* SPA0502 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i2 = 2;

/* Initialized data */

float e[2] = { 0.0, 0.9 },
      f[2] = { 0.0, -0.1 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    long i, number_points;
    complex spgain(), tmp_complex;
    float freq[301], amp[301];
    double complex_abs();

/* AMPLITUDE GAIN PLOT FOR H(Z)=-0.1*Z/(Z**2+0.9). */

    for (i = 0 ; i <= 300 ; ++i)
    {
	freq[i] = i * 0.5 / 300.0;
	tmp_complex = spgain(f, e, &pos_i1, &pos_i2, &freq[i]);
	amp[i] = (float) complex_abs(&tmp_complex);
    }

    number_points = 301;
    pfile1(freq,amp,&number_points,&pos_i1,"P0502A");
}


/* SPA0503 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i2 = 2;

/* Initialized data */

float e[2] = { 0.0, 0.9 };
float f[2] = { 0.0, -0.1 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    long i, format, number_points;
    complex h, spgain();
    float freq[301], phase[301];

/* PHASE SHIFT PLOT FOR H(Z)=-0.1*Z/(Z**2+0.9). */

    for (i = 0 ; i <= 300 ; ++i)
    {
	freq[i] = i * 0.5 / 300.0;
	h = spgain(f, e, &pos_i1, &pos_i2, &freq[i]);
	phase[i] = (float) atan2((double) h.i, (double) h.r);
    }

    number_points = 301;
    pfile1(freq,phase,&number_points,&pos_i1,"P0503A");
}


/* SPA0504 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i2 = 2;

/* Initialized data */

float a = -0.8, b = 0.2,
      c[2] = { -0.95, 0.9 },
      d[2] = { 0.05, -0.1 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    long i, number_points;
    complex spgain(), tmp_complex1, tmp_complex2, tmp_complex3;
    float freq[301], amp[301];
    double complex_abs();

/* AMPLITUDE GAIN PLOT FOR THE CASCADE COMBINATION, H1*H2. */

    for (i = 0 ; i <= 300 ; ++i)
    {
	freq[i] = i * 0.5 / 300.0;
	tmp_complex1 = spgain(&b, &a, &i0, &pos_i1, &freq[i]);
	tmp_complex2 = spgain(d, c, &pos_i1, &pos_i2, &freq[i]);
	tmp_complex3.r = tmp_complex1.r * tmp_complex2.r
			 - tmp_complex1.i * tmp_complex2.i;
	tmp_complex3.i = tmp_complex1.r * tmp_complex2.i
			 + tmp_complex1.i * tmp_complex2.r;
	amp[i] = complex_abs(&tmp_complex3);
    }

    number_points = 301;
    pfile1(freq,amp,&number_points,&pos_i1,"P0504A");
}


/* SPA0505 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i2 = 2;

/* Initialized data */

float a = -0.8, b = 0.2,
      c[2] = { -0.95, 0.9 },
      d[2] = { 0.05, -0.1 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1();
    long i, number_points;
    complex spgain(), tmp_complex1, tmp_complex2, tmp_complex3;
    float freq[301], amp[301];
    double complex_abs();

/* AMPLITUDE GAIN PLOT FOR THE PARALLEL COMBINATION, H1+H2. */

    for (i = 0 ; i <= 300 ; ++i)
    {
	freq[i] = i * 0.5 / 300.0;
	tmp_complex1 = spgain(&b, &a, &i0, &pos_i1, &freq[i]);
	tmp_complex2 = spgain(d, c, &pos_i1, &pos_i2, &freq[i]);
	tmp_complex3.r = tmp_complex1.r + tmp_complex2.r;
	tmp_complex3.i = tmp_complex1.i + tmp_complex2.i;
	amp[i] = complex_abs(&tmp_complex3);
    }

    number_points = 301;
    pfile1(freq,amp,&number_points,&pos_i1,"P0505A");
}


/* SPA0506 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i4 = 4;
long pos_i300 = 300;
float f0 = 0.0;
float pos_fp2 = 0.2;
float neg_fp8 = -0.8;

/* Initialized data */

float b[5] = { -0.2, 0.4, 0.8, -0.4, 0.2 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), spunwr();
    long i, number_points;
    complex h3, h4, spgain();
    float freq[301], phase3[301], phase4[301];

/* PHASE SHIFT PLOTS FOR NONCAUSAL SYSTEMS H3(Z) AND H4(Z). */

    for (i = 0 ; i <= 300 ; ++i)
    {
	freq[i] = i * 0.5 / 300.0;
	h3 = spgain(b, &f0, &pos_i4, &pos_i1, &freq[i]);
	h4 = spgain(&pos_fp2, &neg_fp8, &i0, &pos_i1, &freq[i]);
	phase3[i] = (float) (atan2(h3.i, h3.r)
			     + 4.0 * M_PI * (double) freq[i]);
	phase4[i] = (float) (atan2(h4.i, h4.r)
			     + 2.0 * M_PI * (double) freq[i]);
    }

    spunwr(phase3, &pos_i300, &pos_i1);

    number_points = 301;
    pfile1(freq,phase4,&number_points,&pos_i1,"P0506A");
    pfile1(freq,phase3,&number_points,&pos_i1,"P0506B");
}


/* SPA0507 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i2 = 2;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

float a[2] = { -0.95, 0.9 },
      b[2] = { 0.05, -0.1 },
      x[2] = { 1.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spresp();
    long format, number_points;
    float y[101];

/* PLOT IMPULSE RESPONSE OF H(Z)=(0.05*Z**2-0.1*Z)/(Z**2-0.95*Z+0.9). */

    spresp(x, y, &pos_i1, &pos_i100, b, a, &pos_i1, &pos_i2);

    number_points = 101;
    pfile2(&f0,&pos_f1,y,&number_points,&pos_i1,"P0507A");
}


/* SPA0508 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i2 = 2;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_fp2 = 0.2;
float neg_fp8 = -0.8;

/* Initialized data */

float c[2] = { -0.95, 0.9 };
float d[2] = { 0.05, -0.1 };
float x[2] = { 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spresp();
    long format, number_points;
    float y1[101], y2[101];

/* PLOT THE UNIT STEP RESPONSE OF H1(Z)*H2(Z) IN CASCADE. */

    spresp(x, y1, &pos_i1, &pos_i100, &pos_fp2, &neg_fp8, &i0, &pos_i1);
    spresp(y1, y2, &pos_i100, &pos_i100, d, c, &pos_i1, &pos_i2);

    number_points = 101;
    pfile2(&f0,&pos_f1,y2,&number_points,&pos_i1,"P0508A");
}


/* SPA0601 */
#include "spaincl.h"

/* Initialized data */

long la = 1, lb = 1, n = 10;
float a[1] = { -0.8 }, b[2] = { 1.0, 0.5 },
      px[2] = { 0.0, 0.0 }, py[1] = { 0.0 },
      x[10] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spfilt();
    long error, k;


/* DEMONSTRATE THE USE OF SPFILT */

    spfilt(b, a, &lb, &la, x, &n, px, py, &error);

    if (error != 0)
    {
	printf(" SPFILT ERROR = %ld\n", error);
    }

    printf("  SAMPLE    OUTPUT\n");
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf(" %5ld%12.4f\n", k, x[k]);
    }
}


/* SPA0602 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long la = 4, lb = 4, n = 25;
float a[4] = { -3.0544, 3.8291, -2.2925, 0.55075 },
      b[5] = { 0.001836, 0.007344, 0.011016,  0.007344, 0.001836 },
      px[5] = { 0.0, 0.0, 0.0, 0.0, 0.0 },
      py[4] = { 0.0, 0.0, 0.0, 0.0 },
      x[25] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfilt();
    float data[100];
    long error, k, nblk;


/* DEMONSTRATE THE USE OF SPFILT FOR BLOCK MODE FILTERING. */

    for (nblk = 0 ; nblk <= 3 ; ++nblk)
    {
	spfilt(b, a, &lb, &la, x, &n, px, py, &error);

	if (error != 0)
	{
	    printf(" SPFILT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (k = 0 ; k <= 24 ; ++k)
	{
	    data[nblk * 25 + k] = x[k];
	    x[k] = 0.0;
	}
    }

    pfile2(&f0, &pos_f1, data, &pos_i100, &pos_i1, "P0602A");

    printf(" SAMPLE    RESPONSE\n");
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf(" %6ld%12.4f\n", k, data[k]);
    }
}


/* SPA0603 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long la = 4, lb = 4, n = 100;
float a[4] = { -3.0544, 3.8291, -2.2925, 0.55075 },
      b[5] = { 0.001836, 0.007344, 0.011016, 0.007344, 0.001836 },
      px[5] = { 0.0, 0.0, 0.0, 0.0, 0.0 },
      py[4] = { 0.0, 0.0, 0.0, 0.0 },
      x[100] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		 1.0 },
      y[100] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfltr();
    long error;


/* DEMONSTRATE THE USE OF SPFLTR. */

    spfltr(b, a, &lb, &la, x, &n, y, px, py, &error);

    if (error != 0)
    {
	printf(" SPFLTR ERROR = %ld\n", error);
	exit(-1);
    }

    pfile2(&f0, &pos_f1, y, &pos_i100, &pos_i1, "P0603A");
}


/* SPA0604 */
#include "spaincl.h"

/* Table of constant values */

long pos_i1 = 1;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long ls = 2, n = 25, ns = 2;
float a[4] = { -1.4996, 0.8482, -1.5548, 0.6493 },
      b[6] = { 0.001836, 0.003672, 0.001836, 1.0, 2.0, 1.0 },
      px[6] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      py[4] = { 0.0, 0.0, 0.0, 0.0 },
      x[25] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
     void pfile2(), spcflt();
     long error, k, nblk;
     float data[100];

/* DEMONSTRATE THE USE OF SPCFLT. */

    for (nblk = 0 ; nblk <= 3 ; ++nblk)
    {
	spcflt(b, a, &ls, &ns, x, &n, px, py, &error);

	if (error != 0)
	{
	    printf(" SPCFLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (k = 0 ; k <= 24 ; ++k)
	{
	    data[nblk * 25 + k] = x[k];
	    x[k] = 0.0;
	}
    }

    pfile2(&f0, &pos_f1, data, &pos_i100, &pos_i1, "P0604A");

    printf("  SAMPLE    OUTPUT\n");

    for (k = 0; k <= 9; ++k)
    {
	printf(" %6ld%12.4f\n", k, data[k]);
    }
}


/* SPA0605 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long ls = 2, ns = 2, n = 25;
float a[4] = { -1.5658, 0.6549, -1.4934, 0.8392 },
      b[6] = { 0.08327,0.0239, 0.0, -0.08327, -0.0246, 0.0 },
      px[6] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      py[4] = { 0.0, 0.0, 0.0, 0.0 },
      x[25] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0 },
      y[25] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), sppflt();
    long error, k, nblk;
    float data[100];

/* DEMONSTRATE THE USE OF SPPFLT. */

    for (nblk = 0 ; nblk <= 3 ; ++nblk)
    {

	sppflt(b, a, &ls, &ns, x, &n, y, px, py, &error);

	if (error != 0)
	{
	    printf(" SPPFLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (k = 0 ; k <= 24 ; ++k)
	{
	    data[nblk * 25 + k] = y[k];
	    x[k] = 0.0;
	}
    }

    pfile2(&f0, &pos_f1, data, &pos_i100, &pos_i1, "P0605A");

    printf(" SAMPLE    RESPONSE\n");
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf("%6ld%12.4f\n", k, data[k]);
    }
}


/* SPA0606 */
#include "spaincl.h"

/* Initialized data */

long la = 1, lb = 4, n = 10;
float a[1] = { 0.0 },
      b[5] = { 1.0, 4.0, 6.0, 4.0, 1.0 }, 
      px[5] = { 0.0, 0.0, 0.0, 0.0, 0.0 }, 
      py[1] = { 0.0 },
      x[10] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spfilt();
    long error, k;

/* FIR FILTERING WITH SUBROUTINE SPFILT. */

    spfilt(b, a, &lb, &la, x, &n, px, py, &error);

    if (error != 0)
    {
	printf(" SPFILT ERROR = %ld\n", error);
    }

    printf(" SAMPLE    RESPONSE\n");
    for (k = 0; k <= 9; ++k)
    {
	printf("%6ld%12.4f\n", k, x[k]);
    }
}


/* SPA0607 */
#include "spaincl.h"

/* Initialized data */

long ls = 2, ns = 2, n = 10;
float a[4] = { 0.0, 0.0, 0.0, 0.0 },
      b[6] = { 1.0, 2.0, 1.0, 1.0, 2.0, 1.0 },
      px[6] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      py[4] = { 0.0, 0.0, 0.0, 0.0 },
      x[10] = { 1.0, 0.,0.,0.,0.,0.,0.,0.,0.,0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spcflt();
    long error, k;

/* FIR FILTERING WITH SUBROUTINE SPCFLT. */

    spcflt(b, a, &ls, &ns, x, &n, px, py, &error);

    if (error != 0)
    {
	printf(" SPCFLT ERROR = %ld\n", error);
    }

    printf(" SAMPLE    RESPONSE\n");
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf("%6ld%12.4f\n", k, x[k]);
    }
}


/* SPA0608 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i100 = 100;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 4, n = 25;
float a[4] = { -3.0544, 3.8291, -2.2925, 0.55075 },
      b[5] = { 0.001836, 0.007344, 0.011016, 0.007344, 0.001836 },
      past[5] = { 0.0, 0.0, 0.0, 0.0, 0.0 },
      x[25] = { 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
     void pfile2(), splflt(), spltcf();
     long error, k, nblk;
     float data[100], kappa[4], nu[5], work[15];

/* IIR FILTERING WITH SPLFLT - LATTICE STRUCTURE. */

    spltcf(b, a, &l, kappa, nu, work, &error);

    if (error != 0)
    {
	printf(" UNSTABLE TRANSFER FUNCTION H(Z)\n");
    }

    for (nblk = 0 ; nblk <= 3 ; ++nblk)
    {

	splflt(kappa, nu, &l, x, &n, past, &error);

	if (error != 0)
	{
	    printf(" SPLFLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (k = 0 ; k <= 24 ; ++k)
	{
	    data[nblk * 25 + k] = x[k];
	    x[k] = 0.;
	}
    }

    pfile2(&f0, &pos_f1, data, &pos_i100, &pos_i1, "P0608A");

    printf(" KAPPA COEF = ");
    for (k = 0 ; k <= 3 ; ++k)
    {
	printf("%10.4f", kappa[k]);
    }

    printf("\n NU COEF = ");
    for (k = 0 ; k <= 4 ; ++k)
    {
	printf("%10.4f", nu[k]);
    }

    printf("\n SAMPLE    RESPONSE\n");
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf("%6ld%12.4f\n", k, data[k]);
    }
}


/* SPA0701 */
#include "spaincl.h"

/* Initialized data */

long ln = 2;
float d[3] = { 0.1056, 0.0, 0.0 },
      c[3] = { 0.1056, 0.4595, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spbiln();
    long error, k;
    float a[2], b[3], work[9];

/* TRANSFORMATION VIA THE BILINIAR TRANSFORM. */

    spbiln(d, c, &ln, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPBILN ERROR = %ld\n", error);
    }

    printf(" B(Z) COEFFICIENTS:  ");
    for (k = 0 ; k <= 2 ; ++k)
    {
	printf("%10.4f", b[k]);
    }

    printf("\n A(Z) COEFFICIENTS:  ");
    for (k = 0 ; k <= 1 ; ++k)
    {
	printf("%10.4f", a[k]);
    }
    printf("\n");
}


/* SPA0702 */
#include "spaincl.h"

long pos_i1 = 1;
long c__2 = 2;
long c__3 = 3;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 1, ln = 2;
float c[3] = { 1.0 , 1.41421, 1.0 },
      d[3] = { 1.0 , 0.0 ,0.0 },
      fl = 1e3, fh = 0.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfblt();
    long error, i;
    complex spgain(), tmp_complex;
    float a[2], amp[501], b[3], fhn, fln, tmp_float, work[9];
    double complex_abs();

/* LOWPASS ANALOG TO LOWPASS DIGITAL SCALED IN FREQUENCY. */
    fln = fl * t;
    fhn = fh * t;

    spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPFBLT ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0; i <= 500; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0702A");

    printf(" B(Z) COEFFICIENTS:  ");
    for (i = 0 ; i <= 2 ; ++i)
    {
	printf("%10.4f", b[i]);
    }

    printf("\n A(Z) COEFFICIENTS:  ");
    for (i = 0 ; i <= 1 ; ++i)
    {
	printf("%10.4f", a[i]);
    }
    printf("\n");
}


/* SPA0703 */
#include "spaincl.h"

/* Table of constant values */

 long pos_i1 = 1;
 long pos_i501 = 501;
 float f0 = 0.0;
 float pos_fp01 = 0.01;

/* Initialized data */

long band = 2; ln = 2;
float c[3] = { 1.0, 1.41421, 1.0 },
      d[3] = { 1.0, 0.0, 0.0 },
      fl = 3500.0, fh = 0.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfblt();
    complex spgain(), tmp_complex;
    float a[2], amp[501], b[3], fhn, fln, tmp_float, work[9];
    long error, i;
    double complex_abs();

/* LOWPASS ANALOG TO HIGHPASS DIGITAL SCALED IN FREQUENCY. */
    fln = fl * t;
    fhn = fh * t;

    spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPFBLT ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0; i <= 500; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0703A");

    printf(" B(Z) COEFFICIENTS:  ");
    for (i = 0 ; i <= 2 ; ++i)
    {
        printf("%10.4f", b[i]);
    }

    printf("\n A(Z) COEFFICIENTS:  ");
    for (i = 0 ; i <= 1 ; ++i)
    {
        printf("%10.4f", a[i]);
    }
    printf("\n");
}


/* SPA0704 */
#include "spaincl.h"

long pos_i1 = 1;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long iband = 3, ln = 4;
float d[5] = { 1.0, 0.0 , 0.0, 0.0, 0.0 },
      c[5] = { 1.0, 1.41421, 1.0, 0.0, 0.0 },
      fl = 1500.0, fh = 3500.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), spfblt();
    long i, error, format, number_points;
    complex spgain(), tmp_complex;
    float work[25], a[4], b[5], fhn, fln, plt1[501],  plt2[501], tmp_float;
    double complex_abs();

/* LOWPASS ANALOG TO BANDPASS DIGITAL SCALED IN FREQUENCY */

    fln = fl * t;
    fhn = fh * t;

    spfblt(d, c, &ln, &iband, &fln, &fhn, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPFBLT ERROR = %ld\n", error);
	exit(1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	plt1[i] = i * 5.0 / 500.0;
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	plt2[i] = (float) complex_abs(&tmp_complex);
    }

    number_points = 501;
    pfile2(&f0,&pos_fp01,plt2,&number_points,&pos_i1,"P0704A");

    printf(" B(Z) COEFFICIENTS:");
    for (i = 0 ; i < 5 ; ++i)
    {
	printf("%10.4f", b[i]);
    }
    printf("\n");

    printf(" A(Z) COEFFICIENTS:");
    for (i = 0 ; i < 4 ; ++i)
    {
	printf("%10.4f", a[i]);
    }
    printf("\n");
}


/* SPA0705 */
#include "spaincl.h"

/* Table of constant values */

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 4, ln = 4;
float d[5] = { 1.0, 0.0, 0.0, 0.0, 0.0 },
      c[5] = { 1.0, 1.41421, 1.0, 0.0, 0.0 },
      fl = 1500.0, fh = 3500.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfblt();
    long error, i;
    complex spgain(), tmp_complex;
    float a[4], amp[501], b[5], fhn, fln, tmp_float, work[25];
    double complex_abs();

/* LOWPASS ANALOG TO BANDSTOP DIGITAL SCALED IN FREQUENCY. */
    fln = fl * t;
    fhn = fh * t;

    spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPFBLT ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0; i <= 500; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0705A");

    printf(" B(Z) COEFFICIENTS:  ");
    for (i = 0 ; i <= 4 ; ++i)
    {
        printf("%10.4f", b[i]);
    }

    printf("\n A(Z) COEFFICIENTS:  ");
    for (i = 0 ; i <= 3 ; ++i)
    {
        printf("%10.4f", a[i]);
    }
    printf("\n");

}


/* SPA0706 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 1, l = 6, ln = 2;
float fl = 1e3, fh = 0., t = 1e-4,
      amp[501] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spbwcf(), spfblt();
    complex spgain(), tmp_complex;
    long error, i, k;
    float a[2], b[3], c[3], d[3], fhn, fln, tmp_float, work[9];
    double complex_abs();

/* DESIGN 6TH ORDER LOWPASS BUTTERWORTH FILTER. */
    fln = fl * t;
    fhn = fh * t;

    for (k = 1 ; k <= 3 ; ++k)
    {
	spbwcf(&l, &k, &ln, d, c, &error);

	if (error != 0)
	{
	    printf(" SPBWCF ERROR = %ld\n", error);
	    exit(-1);
	}

	spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

	if (error != 0)
	{
	    printf(" SPFBLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (i = 0 ; i <= 500 ; ++i)
	{
	    tmp_float = i * 0.5 / 500.0;
	    tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	    amp[i] *= complex_abs(&tmp_complex);
	}

	printf("SECTION %2ld COEFFICIENTS = ",k);
	for (i = 0 ; i < 3 ; i++)
	{
	    printf("%8.4f",b[i]);
	}

	printf("     ");

	for (i = 0 ; i < 2 ; i++)
	{
	    printf("%8.4f",a[i]);
	}
	printf("\n");
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0706A");

}


/* SPA0707 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 3, l = 8, ln = 4;
float fl = 1500.0, fh = 3500.0, t = 1e-4,
      amp[501] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spbwcf(), spfblt();
    double complex_abs();
    complex spgain(), tmp_complex;
    long error, i, k, tmp_int;
    float a[4], b[5], c[5], d[5], fhn, fln, tmp_float, work[25];

/* DESIGN 8TH ORDER BANDPASS BUTTERWORTH FILTER. */
    fln = fl * t;
    fhn = fh * t;

    for (k = 1 ; k <= 2 ; ++k)
    {
	tmp_int = l / 2;
	spbwcf(&tmp_int, &k, &ln, d, c, &error);

	if (error != 0)
	{
	    printf(" SPBWCF ERROR = %ld\n", error);
	    exit(-1);
	}

	spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

	if (error != 0)
	{
	    printf(" SPFBLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (i = 0 ; i <= 500 ; ++i)
	{
	    tmp_float = i * .5 / 500.;
	    tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	    amp[i] *= complex_abs(&tmp_complex);
	}

	printf("SECTION %2ld COEFFICIENTS = ",k);
	for (i = 0 ; i < 5 ; i++)
	{
	    printf("%9.4f",b[i]);
	}

	printf("\n                          ");

	for (i = 0 ; i < 4 ; i++)
	{
	    printf("%9.4f",a[i]);
	}

	printf("\n");
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0707A");
}

/* SPA0708 */
#include "spaincl.h"

/* Table of constant values */

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 2, l = 5, ln = 2;
float fl = 2500.0, fh = 0.0, t = 1e-4,
      amp[501] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spbwcf(), spfblt();
    complex spgain(), tmp_complex;
    long error, i, k;
    float a[2], b[3], c[3], d[3], fhn, fln, tmp_float, work[9];
    double complex_abs();

/* DESIGN 5TH ORDER HIGHPASS BUTTERWORTH FILTER. */
    fln = fl * t;
    fhn = fh * t;

    for (k = 1 ; k <= 3 ; ++k)
    {
	spbwcf(&l, &k, &ln, d, c, &error);

	if (error != 0)
	{
	    printf(" SPBWCF ERROR = %ld\n", error);
	    exit(-1);
	}

	spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

	if (error != 0)
	{
	    printf(" SPFBLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (i = 0 ; i <= 500 ; ++i)
	{
	    tmp_float = i * 0.5 / 500.0;
	    tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	    amp[i] *= complex_abs(&tmp_complex);
	}

	printf("SECTION %2ld COEFFICIENTS = ",k);
	for (i = 0 ; i < 3 ; i++)
        {
	    printf("%8.4f",b[i]);
	}

	printf("     ");

	for (i = 0 ; i < 2 ; i++)
	{
	    printf("%8.4f",a[i]);
	}
	printf("\n");
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0708A");
}


/* SPA0709 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 1, l = 6, ln = 2;
float fl = 1e3, fh = 0.0, t = 1e-4, ep = 1.0,
      amp[501] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spchbi(), spfblt();
    complex spgain(), tmp_complex;
    long error, i, k;
    float a[2], b[3], c[3], d[3], fhn, fln, tmp_float, work[9];
    double complex_abs();

/* DESIGN 6TH ORDER LOWPASS CHEBYSHEV TYPE I FILTER. */
    fln = fl * t;
    fhn = fh * t;

    for (k = 1 ; k <= 3 ; ++k)
    {

	spchbi(&l, &k, &ln, &ep, d, c, &error);

	if (error != 0)
	{
	    printf(" SPCHBI ERROR = %ld\n", error);
	    exit(-1);
	}

	spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

	if (error != 0)
	{
	    printf(" SPFBLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (i = 0 ; i <= 500 ; ++i)
	{
	    tmp_float = i * 0.5 / 500.0;
	    tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	    amp[i] *= complex_abs(&tmp_complex);
	}

	printf("SECTION %2ld COEFFICIENTS = ",k);
	for (i = 0 ; i < 3 ; i++)
	{
	    printf("%8.4f",b[i]);
	}

	printf("     ");

	for (i = 0 ; i < 2 ; i++)
	{
	    printf("%8.4f",a[i]);
	}
	printf("\n");
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0709A");
}


/* SPA0710 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 1, l = 6, ln = 2;
float fl = 1e3, fh = 0.0, t = 1e-4, sb = 1.57, attn = 15.0,
      amp[501] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		   1.0, 1.0, 1.0, 1.0, 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{

    /* Local variables */
    void pfile2(), spcbii(), spfblt();
    complex spgain(), tmp_complex;
    long error, i, k;
    float a[2], b[3], c[3], d[3], fhn, fln, tmp_float, work[9];
    double complex_abs();

/* DESIGN 6TH ORDER LOWPASS CHEBYSHEV TYPE II FILTER. */
    fln = fl * t;
    fhn = fh * t;

    for (k = 1 ; k <= 3 ; ++k)
    {

	spcbii(&l, &k, &ln, &sb, &attn, d, c, &error);

	if (error != 0)
	{
	    printf(" SPCBII ERROR = %ld\n", error);
	    exit(-1);
	}

	spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

	if (error != 0)
	{
	    printf(" SPFBLT ERROR = %ld\n", error);
	    exit(-1);
	}

	for (i = 0 ; i <= 500 ; ++i)
	{
	    tmp_float = i * 0.5 / 500.0;
	    tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	    amp[i] *= complex_abs(&tmp_complex);
	}

	printf("SECTION %2ld COEFFICIENTS = ",k);
	for (i = 0 ; i < 3 ; i++)
	{
	    printf("%8.4f",b[i]);
	}

	printf("     ");

	for (i = 0 ; i < 2 ; i++)
	{
	    printf("%8.4f",a[i]);
	}
	printf("\n");
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0710A");
}


/* SPA0711 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 1, l = 6, ln = 6;
float fl = 1e3, fh = 0.0, t = 1e-4, pscl = 1.0;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfblt(), spbssl();
    complex spgain(), tmp_complex;
    long error, i;
    float a[6], amp[501], b[7], c[7], d[7], fhn, fln, tmp_float, work[49];
    double complex_abs();

/* DESIGN 6TH ORDER LOWPASS BESSEL FILTER. */
    fln = fl * t;
    fhn = fh * t;

    spbssl(&l, &pscl, &ln, d, c, &error);

    if (error != 0)
    {
	printf(" SPBSSL ERROR = %ld\n", error);
	exit(-1);
    }

    spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPFBLT ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0711A");

    printf(" B(Z) COEF = ");
    for (i = 0 ; i <= 6 ; ++i)
    {
	printf("%8.4f", b[i]);
    }

    printf("\n");

    printf(" A(Z) COEF = ");
    for (i = 0 ; i <= 5 ; ++i)
    {
	printf("%8.4f", a[i]);
    }

    printf("\n");
}


/* SPA0712 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 3, l = 8, ln = 8;
float fl = 1500.0, fh = 3500.0, t = 1e-4, pscl = 2.1;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfblt(), spbssl();
    complex spgain(), tmp_complex;
    long error, i, tmp_int;
    float a[8], amp[501], b[9], c[9], d[9], fhn, fln, tmp_float, work[81];
    double complex_abs();

/* DESIGN 8TH ORDER BANDPASS BESSEL FILTER. */
    fln = fl * t;
    fhn = fh * t;
    tmp_int = l / 2;

    spbssl(&tmp_int, &pscl, &ln, d, c, &error);

    if (error != 0)
    {
	printf(" SPBSSL ERROR = %ld\n");
	exit(-1);
    }

    spfblt(d, c, &ln, &band, &fln, &fhn, b, a, work, &error);

    if (error != 0)
    {
	printf(" SPFBLT ERROR = %ld\n");
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &ln, &ln, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0712A");

    printf(" B(Z) COEF = ");
    for (i = 0 ; i <= 8 ; ++i)
    {
	printf("%7.3f", b[i]);
    }

    printf("\n");

    printf(" A(Z) COEF = ");
    for (i = 0 ; i <= 7 ; ++i)
    {
	printf("%7.3f", a[i]);
    }

    printf("\n");
}


/* SPA0801 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, wndo = 1;
float a = 0.0, fc = 200.0, t = 0.001;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfirl();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fcn, tmp_float;
    double complex_abs();

/* DESIGN FIR LOWPASS FILTER USING RECTANGULAR WINDOW. */
    fcn = fc * t;

    spfirl(&l, &fcn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0801A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0802 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, wndo = 2;
float a = 0.0, fc = 200.0, t = 0.001;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfirl();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fcn, tmp_float;
    double complex_abs();

/* DESIGN FIR LOWPASS FILTER USING TAPERED RECTANGULAR WINDOW. */
    fcn = fc * t;

    spfirl(&l, &fcn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0802A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0803 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, wndo = 3;
float a = 0.0, fc = 200.0, t = 0.001;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfirl();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fcn, tmp_float;
    double complex_abs();

/* DESIGN FIR LOWPASS FILTER USING TRIANGULAR WINDOW. */
    fcn = fc * t;

    spfirl(&l, &fcn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0803A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0804 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, wndo = 4;
float a = 0.0, fc = 200.0, t = 0.001;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfirl();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fcn, tmp_float;
    double complex_abs();

/* DESIGN FIR LOWPASS FILTER USING HANNING WINDOW. */
    fcn = fc * t;

    spfirl(&l, &fcn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0804A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0805 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, wndo = 5;
float a = 0.0, fc = 200.0, t = 0.001;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfirl();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fcn, tmp_float;
    double complex_abs();

/* DESIGN FIR LOWPASS FILTER USING HAMMING WINDOW. */
    fcn = fc * t;

    spfirl(&l, &fcn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0805A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}

/* SPA0806 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, wndo = 6;
float a = 0.0, fc = 200.0, t = 0.001;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfirl();
    complex spgain(), tmp_complex;
    long error, i, n;
    float amp[501], b[21], fcn, tmp_float;
    double complex_abs();

/* DESIGN FIR LOWPASS FILTER USING BLACKMAN WINDOW. */
    fcn = fc * t;

    spfirl(&l, &fcn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0806A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0807 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp01 = 0.01;

/* Initialized data */

long band = 2, l = 20, wndo = 1;
float a[1] = {0.0}, fl = 2500.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfird();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fln, tmp_float;
    double complex_abs();

/* DESIGN FIR HIGHPASS FILTER USING RECTANGULAR WINDOW. */
    fln = fl * t;

    spfird(&l, &band, &fln, &f0, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp01, amp, &pos_i501, &pos_i1, "P0807A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0; n <= 6; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0808 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long band = 3, l = 20, wndo = 5;
float a = 0.0, fh = 3500.0, fl = 1500.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfird();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fhn, fln, tmp_float;
    double complex_abs();

/* DESIGN FIR BANDPASS FILTER USING HAMMING WINDOW. */
    fln = fl * t;
    fhn = fh * t;

    spfird(&l, &band, &fln, &fhn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0808A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0 ; n <= 6 ; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0809 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long band = 4, l = 20, wndo = 4;
float a = 0.0, fh = 3500.0, fl = 1500.0, t = 1e-4;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfird_();
    long error, i, n;
    complex spgain(), tmp_complex;
    float amp[501], b[21], fln, fhn, tmp_float;
    double complex_abs();

/* DESIGN FIR BANDSTOP FILTER USING HANNING WINDOW. */
    fln = fl * t;
    fhn = fh * t;

    spfird(&l, &band, &fln, &fhn, &wndo, b, &error);

    if (error != 0)
    {
	printf(" ERROR RETURNED = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	tmp_float = i * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	amp[i] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_f1, amp, &pos_i501, &pos_i1, "P0809A");

    printf(" N     B(N)        N     B(N)        N     B(N)\n");
    for (n = 0; n <= 6; ++n)
    {
	printf("%2ld%10.5f%8ld%10.5f%8ld%10.5f\n",
	       n, b[n], n+7, b[n+7], n+14, b[n+14]);
    }
}


/* SPA0901 */
#include "spaincl.h"

long i0 = 0;
long pos_i5 = 5;
long pos_i9 = 9;

/* Initialized data */

float x[10] = { 0.0, 1.0, 2.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spcorr();
    long error, k;

/* SIMPLE EXAMPLE OF AUTOCORRELATION. */

    spcorr(x, x, &pos_i9, &i0, &pos_i5, &error);

    printf("%2ld\n", error);

    for (k = 0; k <= 5; ++k)
    {
	printf("%3ld%6.1f\n", k, x[k]);
    }
}


/* SPA0902 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i4 = 4;
long pos_i9 = 9;

/* Initialized data */

float x[10] = { 0., 1., 2., -1., 0., 0., 0., 0., 0., 0. };
float y[10] = { 1., -1., 1., -1., 0.,  0., 0., 0., 0., 0. };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spcorr();
    long error, k;

/* SIMPLE EXAMPLE OF CROSS CORRELATION. */

    spcorr(x, y, &pos_i9, &pos_i1, &pos_i4, &error);

    printf("%2ld\n", error);

    for (k = 0; k <= 4; ++k)
    {
	printf("%3ld%6.1f\n", k, x[k]);

    }
}


/* SPA0903 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i300 = 300;
long pos_i2049 = 2049;
float f0 = 0.0;
float pos_f1 = 1.0;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spcorr();
    long error, k, number_points;
    long seed;
    float x[2050];
    double sprand();

/* AUTOCORRELATION OF 1500 SAMPLES OF A SINE WAVE IN NOISE. */

    seed = 100;

    for (k = 0 ; k <= 1499 ; ++k)
    {
	x[k] = (float) (sin(2.0 * M_PI * (double) k / 25.0)
	       + sqrt(60.0) * (sprand(&seed) - 0.5));
    }

    for (k = 1500 ; k <= 2047 ; ++k)
    {
	x[k] = 0.0;
    }

    number_points = 301;
    pfile2(&f0,&pos_f1,x,&number_points,&pos_i1,"P0903A");

    spcorr(x, x, &pos_i2049, &i0, &pos_i300, &error);

    pfile2(&f0,&pos_f1,x,&number_points,&pos_i1,"P0903B");
}


/* SPA0904 */
#include "spaincl.h"

long i0 = 0;
long pos_i9 = 9;

/* Initialized data */

float x[10] = { 0., 1., 2., -1., 0., 0., 0., 0., 0., 0. },
      y[10] = { 1., -1., 1., -1., 0., 0., 0., 0., 0., 0. };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spconv();
    long error, k;

/* SIMPLE EXAMPLE OF CONVOLUTION. */

    spconv(x, y, &pos_i9, &i0, &error);

    for (k = 0; k <= 7; ++k)
    {
	printf("%3ld%6.1f\n", k, x[k]);
    }
}


/* SPA0905 */
#include "spaincl.h"

long i0 = 0;
long pos_i1 = 1;
long pos_i2049 = 2049;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

float coeff[8] = { 8.0, 4.0, 7.0, 2.0, 6.0, 3.0, 1.0, 1.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spconv();
    long error, k, number_points;
    static float x[2050], y[2050];

/* MORE OR LESS REALISTIC EXAMPLE OF CONVOLUTION. */

    for (k = 0 ; k <= 2047 ; ++k)
    {
	x[k] = (float) (exp(-k / 50.0) *
	       sin(2.0 * M_PI * (double) k / 50.0));

	if (k > 400)
	{
	    x[k] = 0.0;
	}

	y[k] = 0.0;

	if (k <= 700 && k % 100 == 0)
	{
	    y[k] = coeff[k / 100];
	}
    }

    number_points = 1000;
    pfile2(&f0,&pos_f1,x,&number_points,&pos_i1,"P0905A");
    pfile2(&f0,&pos_f1,y,&number_points,&pos_i1,"P0905B");

    spconv(x, y, &pos_i2049, &i0, &error);

    if ( error != 0 )
    {
	exit(-1);
    }

    pfile2(&f0,&pos_f1,x,&number_points,&pos_i1,"P0905C");
}


/* SPA1001 */
#include "spaincl.h"

long pos_i9 = 9;
float pos_f1p5 = 1.5;
float pos_f2 = 2.0;

/* Initialized data */

float data[10] = { 0.0, 2.0, 4.0, 6.0, 8.0, 8.0, 6.0, 4.0, 2.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spdeci();
    long k, error, lx2;
    float x[10];

/* TWO SIMPLE EXAMPLES OF DECIMATION. */

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = data[k];
    }

    spdeci(x, &pos_i9, &pos_f2, &lx2, &error);

    printf("%2ld%2ld    ", error, lx2);
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf("%6.2f", x[k]);
    }
    printf("\n");

    for (k = 0 ; k <= 9 ; ++k)
    {
	x[k] = data[k];
    }

    spdeci(x, &pos_i9, &pos_f1p5, &lx2, &error);

    printf("%2ld%2ld    ", error, lx2);
    for (k = 0 ; k <= 9 ; ++k)
    {
	printf("%6.2f", x[k]);
    }
    printf("\n");
}


/* SPA1002 */
#include "spaincl.h"

long pos_i5 = 5;
long pos_i10 = 10;
float pos_fp5 = 0.5;
float pos_fp75 = 0.75;

/* Initialized data */

float data[11] = { 2.0, 4.0, 6.0, 6.0, 8.0, 6.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void splint();

    long k, error, lx2;
    float x[11];

/* TWO SIMPLE EXAMPLES OF LINEAR INTERPOLATION. */

    for (k = 0 ; k <= 10 ; ++k)
    {
	x[k] = data[k];
    }

    splint(x, &pos_i10, &pos_i5, &pos_fp5, &lx2, &error);

    printf("%2ld%3ld   ", error, lx2);
    for (k = 0 ; k <= 10 ; ++k)
    {
        printf("%5.1f", x[k]);
    }
    printf("\n");

    for (k = 0 ; k <= 10 ; ++k)
    {
	x[k] = data[k];
    }

    splint(x, &pos_i10, &pos_i5, &pos_fp75, &lx2, &error);

    printf("%2ld%3ld   ", error, lx2);
    for (k = 0 ; k <= 10 ; ++k)
    {
        printf("%5.1f", x[k]);
    }
    printf("\n");
}


/* SPA1003 */
#include "spaincl.h"

long pos_i6 = 6;
long pos_i17 = 17;
float pos_fp5 = 0.5;

/* Initialized data */

float x[18] = { 2.0, 4.0, 6.0, 6.0, 8.0, 6.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spzint();
    long k, error, lx2;

/* SIMPLE EXAMPLE OF INTERPOLATION USING SPZINT. */

    spzint(x, &pos_i17, &pos_i6, &pos_fp5, &lx2, &error);

    printf("%4ld%4ld\n", error, lx2);
    for (k = 0 ; k <= lx2 ; ++k)
    {
	if ( k == 10 )
	{
	    printf("\n");
	}
	printf("%7.3f", x[k]);
    }
    printf("\n");
}


/* SPA1004 */
#include "spaincl.h"

long pos_i15 = 15;
long pos_i257 = 257;
float pos_fp0625 = 0.0625;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spzint();
    long k, error, lx2;
    float x[258];

/* MORE INTERESTING EXAMPLE OF INTERPOLATION USING SPZINT. */
/* RESULTS ARE PLOTTED IN FIGURE 10.13. */

    for (k = 0 ; k <= 15 ; ++k)
    {
	x[k] = (float) sin(2.0 * M_PI * (double) k / 4.0 + 0.5);
    }

    spzint(x, &pos_i257, &pos_i15, &pos_fp0625, &lx2, &error);

    printf(" IERROR,LX2=%4ld%4ld\n", error, lx2);
}


/* SPA1005 */
#include "spaincl.h"

long pos_i6 = 6;
long pos_i33 = 33;
float pos_fp25 = 0.25;
float pos_f3 = 3.0;

/* Initialized data */

float x[34] = { 2.0, 4.0, 6.0, 6.0, 8.0, 6.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spdeci(), spzint();
    long k, error, lx2, lx3;

/* SIMPLE EXAMPLE OF INTERPOLATION WITH TIME-STEP RATIO=I/J=3/4. */

    spzint(x, &pos_i33, &pos_i6, &pos_fp25, &lx2, &error);

    printf("%4ld%4ld\n", error, lx2);
    for (k = 0 ; k <= lx2 ; ++k)
    {
        if ( ! (k % 10) && k != 0 )
        {
            printf("\n");
        }
        printf("%7.3f", x[k]);
    }
    printf("\n");


    spdeci(x, &lx2, &pos_f3, &lx3, &error);

    printf("%4ld%4ld\n", error, lx3);
    for (k = 0 ; k <= lx3 ; ++k)
    {
        printf("%7.3f", x[k]);
    }
    printf("\n");
}


/* SPA1006 */
#include "spaincl.h"

long pos_i15 = 15;
long pos_i16 = 16;
long pos_i240 = 240;
long pos_i513 = 513;
float pos_fp0625 = 0.0625;
float pos_fp8 = 0.8;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spdftr(), splint(), spzint();
    long k, m, lx2, lx3, error1, error2;
    float x[514], s1[18], s2[242];

/* SPECTRA OF ORIGINAL (S1) AND INTERPOLATED (S2) SINUSOIDS. */

    for (k = 0 ; k <= 15 ; ++k)
    {
	x[k] = sin(2.0 * M_PI * (double) k / 4.0 + 0.5);
    }

    spdftr(x, s1, &pos_i16);

    for (m = 0 ; m <= 8 ; ++m)
    {
	s1[m] = sqrt(s1[m * 2] * s1[m * 2]
		+ s1[(m << 1) + 1] * s1[(m << 1) + 1]) / 8.0;
    }
    spzint(x, &pos_i513, &pos_i15, &pos_fp0625, &lx2, &error1);
    splint(x, &pos_i513, &lx2, &pos_fp8, &lx3, &error2);

    printf("IERROR1,IERROR2,LX2,LX3:%5ld%5ld%5ld%5ld\n",
	   error1, error2, lx2, lx3);

    spdftr(x, s2, &pos_i240);

    for (m = 0 ; m <= 120 ; ++m)
    {
	s2[m] = sqrt(s2[m * 2] * s2[m * 2]
		+ s2[(m << 1) + 1] * s2[(m << 1) + 1]) / 120.;
    }

    printf("  M SPECTRUM 1 SPECTRUM 2\n");
    for (m = 0 ; m <= 8 ; ++m)
    {
	printf("%3ld  %11.7f  %11.7f\n", m, s1[m], s2[m]);
    }
}


/* SPA1101 */
#include "spaincl.h"

/* Initialized data */

long l = 3, n = 51;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spnorm();
    long error, i, j, k;
    float a[16], c[4], x[51], y[51];

/* DEMONSTRATE THE USE OF SPNORM. */

    for (k = 0 ; k < n ; ++k)
    {
	x[k] = k / 50.0;
	y[k] = (x[k] * x[k] * x[k]) * 10.0 - (x[k] * x[k]) * 3.0 -
	       x[k] * 5.0 - 1.0;
    }

    spnorm(x, y, &n, &l, a, c, &error);

    if (error != 0)
    {
	printf(" SPNORM ERROR = %ld\n", error);
    }

    printf("                   A-MATRIX                        C\n");
    for (i = 0 ; i <= 3 ; ++i)
    {
	for (j = 0 ; j <= 3 ; ++j)
	{
	    printf("%10.2f",a[j + i * 4]);
	}
	printf("     %10.2f\n",c[i]);
    }
}


/* SPA1102 */
#include "spaincl.h"

/* Initialized data */

long l = 3, n = 51;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void spnorm(), spsolv();
    float a[16], b[4], c[4], x[51], y[51];
    long error, i, k;

/* DEMONSTRATE THE USE OF SPSOLV. */

    for (k = 0 ; k < n ; ++k)
    {
	x[k] = k / 50.0;
	y[k] = (x[k] * x[k] * x[k]) * 10.0 - (x[k] * x[k]) * 3.0 -
	       x[k] * 5.0 - 1.0;
    }

    spnorm(x, y, &n, &l, a, c, &error);

    if (error != 0)
    {
	printf(" SPNORM ERROR = %ld\n", error);
    }

    spsolv(a, c, &l, b, &error);

    if (error != 0)
    {
	printf(" SPSOLV ERROR = %ld\n", error);
    }

    printf(" POLYNOMIAL COEFFICIENTS\n");
    for (i = 0 ; i <= 3 ; ++i)
    {
	printf(" B(%1ld) = %7.2f\n", i, b[i]);
    }
}


/* SPA1103 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp02 = 0.02;
float pos_fp002 = 0.002;

/* Initialized data */

long l = 5, n = 51;
long seed = 12357;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spnorm(), spsolv();
    long error, i, k;
    float a[36], b[6], c[6], poly[501], px, x[51], y[51];
    double sprand();

/* DEMONSTRATE LEAST-SQUARES DATA FITTING VIA SPNORM AND SPSOLV. */

    for (k = 0 ; k < n ; ++k)
    {
	x[k] = k / 50.0;
	y[k] = (x[k] * x[k] * x[k]) * 10.0 - (x[k] * x[k]) * 3.0 -
	       x[k] * 5.0 - 1.0 + (sprand(&seed) - 0.5) * 0.4;
    }

    spnorm(x, y, &n, &l, a, c, &error);

    if (error != 0)
    {
	printf(" SPNORM ERROR = %ld\n", error);
    }

    spsolv(a, c, &l, b, &error);

    if (error != 0)
    {
	printf(" SPSOLV ERROR = %ld\n", error);
    }

    for (k = 0; k <= 500; ++k)
    {
	px = k / 500.0;
	poly[k] = b[0] + b[1] * px + b[2] * (px * px) + b[3] *
		  (px * px * px) + b[4] * (px * px * px * px) +
		  b[5] * (px * px * px * px * px);
    }

    pfile2(&f0, &pos_fp02, y, &pos_i51, &pos_i1, "P1103A");
    pfile2(&f0, &pos_fp002, poly, &pos_i501, &pos_i1, "P1103B");

    printf(" POLYNOMIAL COEFFICIENTS\n");
    for (i = 0; i <= 5; ++i)
    {
	printf(" B(%1ld) = %7.2f\n", i, b[i]);
    }
}


/* SPA1104 */
#include "spaincl.h"

/* Initialized data */

long l = 3, n = 51;
float dx = 0.02;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void sppoly();
    long error, i, k;
    float b[4], orthb[4], px, work[16], y[51];

/* DEMONSTRATE DATA FITTING VIA ORTHOGONAL POLYNOMIALS. */

    for (k = 0; k < n; ++k)
    {
	px = k / 50.;
	y[k] = (px * px * px) * 10.0 - (px * px) * 3.0 - px * 5.0 - 1.0;
    }

    sppoly(&dx, y, &n, &l, b, orthb, work, &error);

    if (error != 0)
    {
	printf(" SPPOLY ERROR = %ld\n", error);
    }

    printf("           POLYNOMIAL COEFFICIENTS\n");
    for (i = 0; i <= 3; ++i)
    {
	printf(" ORTHB(%1ld) = %8.2f          B(%1ld) = %8.2f\n",
	       i, orthb[i], i, b[i]);
    }
}


/* SPA1105 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp02 = 0.02;
float pos_fp002 = 0.002;

/* Initialized data */

long l = 5, n = 51;
long seed = 12357;
float dx = 0.02;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), sppoly();
    long error, i, k;
    float b[6], orthb[6], px, py[501], work[36], y[51];
    double sprand();

/* DEMONSTRATE LEAST-SQUARES DATA FITTING VIA ORTHOGONAL POLYNOMIALS. */

    for (k = 0 ; k < n ; ++k)
    {
	px = k / 50.0;
	y[k] = (px * px * px) * 10.0 - (px * px) * 3.0 - px * 5.0
		- 1.0 + (sprand(&seed) - 0.5) * 0.4;
    }

    sppoly(&dx, y, &n, &l, b, orthb, work, &error);

    if (error != 0)
    {
	printf(" SPPOLY ERROR = %ld\n", error);
    }

    for (k = 0; k <= 500; ++k)
    {
	px = k / 500.0;
	py[k] = b[0] + b[1] * px + b[2] * (px * px) +
		b[3] * (px * px * px) + b[4] * (px * px * px * px) +
		b[5] * (px * px * px * px * px);
    }

    pfile2(&f0, &pos_fp02, y, &pos_i51, &pos_i1, "P1105A");
    pfile2(&f0, &pos_fp002, py, &pos_i501, &pos_i1, "P1105B");

    printf("           POLYNOMIAL COEFFICIENTS\n");
    for (i = 0; i <= 5; ++i)
    {
	printf(" ORTHB(%1ld) = %8.2f          B(%1ld) = %8.2f\n",
	       i, orthb[i], i, b[i]);
    }
}


/* SPA1106 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;
long pos_i501 = 501;
float f0 = 0.0;
float pos_fp02 = 0.02;
float pos_fp002 = 0.002;

/* Initialized data */

long l = 3, n = 51;
long seed = 12357;
float dx = 0.02;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), sppoly();
    long error, i, k;
    float b[4], orthb[4], px, py[501], work[16], y[51];
    double sprand();

/* DEMONSTRATE LEAST-SQUARES DATA FITTING VIA ORTHOGONAL POLYNOMIALS. */

    for (k = 0; k < n; ++k) {
	px = k / 50.;
	y[k] = (px * px * px) * 10.0 - (px * px) * 3.0 - px * 5.0
		- 1.0 + (sprand(&seed) - 0.5) * 0.4;
    }

    sppoly(&dx, y, &n, &l, b, orthb, work, &error);

    if (error != 0)
    {
	printf(" SPPOLY ERROR = %ld\n", error);
    }

    for (k = 0; k <= 500; ++k)
    {
	px = k / 500.0;
	py[k] = b[0] + b[1] * px + b[2] * (px * px) +
		b[3] * (px * px * px);
    }

    pfile2(&f0, &pos_fp02, y, &pos_i51, &pos_i1, "P1106A");
    pfile2(&f0, &pos_fp002, py, &pos_i501, &pos_i1, "P1106B");

    printf("           POLYNOMIAL COEFFICIENTS\n");
    for (i = 0; i <= 3; ++i)
    {
	printf(" ORTHB(%1ld) = %8.2f          B(%1ld) = %8.2f\n",
	       i, orthb[i], i, b[i]);

    }
}


/* SPA1107 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 1;
float a = 0.0,
      avect[2] = { 2.0, 1.618 },
      c[2] = { 0.0, -2.351 },
      py = 0.0,
      px[2] = { 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void splevs(), spfilt();
    long i, k, error, format;
    float b[2], x[51], y[51], wk[2];

/* DEMONSTRATE THE USE OF LEVINSON'S ALGORITHM */

    splevs(avect, c, &l, b, wk, &error);

    if (error != 0)
    {
	printf(" SPLEVS ERROR = %ld\n", error);
	exit(1);
    }

    for (k = 0 ; k <= 50 ; ++k)
    {
	x[k] = (float) (2.0 * sin(2.0 * M_PI * k / 10.0));
	y[k] = (float) (4.0 * cos(2.0 * M_PI * k / 10.0));
    }

    spfilt(b, &a, &l, &pos_i1, x, &pos_i51, px, &py, &error);

    pfile2(&f0,&pos_f1,y,&pos_i51,&pos_i1,"P1107A");
    pfile2(&f0,&pos_f1,x,&pos_i51,&pos_i1,"P1107B");


    printf(" FILTER COEFFICIENTS\n");
    for (i = 0 ; i <= 1 ; ++i)
    {
	printf(" B(%1ld) = %10.3f\n", i, b[i]);
    }
}


/* SPA1108 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;

/* Initialized data */

long l = 6;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), splevs(), spfilt();
    long i, ll, error;
    float b[7], c[7], avect[7], wk[7];

/* DEMONSTRATE THE USE OF LEVINSON'S ALGORITHM */

    for (ll = 0 ; ll <= l ; ++ll)
    {
	avect[ll] = (float) (2.0 * cos(2.0 * M_PI * (double) ll / 10.0));
	c[ll] = (float) (-4.0 * sin(2.0 * M_PI * (double) ll / 10.0));
    }

    splevs(avect, c, &l, b, wk, &error);

    if (error != 0)
    {
	printf(" SPLEVS ERROR = %ld\n", error);
    }

    printf(" FILTER COEFFICIENTS\n");

    for (i = 0 ; i <= l ; ++i)
    {
	printf(" B(%1ld) = %10.3f\n", i, b[i]);
    }
}


/* SPA1109 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;

/* Initialized data */

long l = 6;
float a = 0.0, py = 0.0,
      px[7] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), splevs(), spfilt();
    long i, k, ll, error, number_points;
    float b[7], c[7], t[51], x[51], y[51], avect[7], wk[7];

/* DEMONSTRATE THE USE OF LEVINSON'S ALGORITHM */

    for (ll = 0 ; ll <= l ; ++ll)
    {
	avect[ll] = (float) (2.0 * cos(2.0 * M_PI * (double) ll / 10.0));
	c[ll] = (float) (-4.0 * sin(2.0 * M_PI * (double) ll / 10.0));
    }

    avect[0] = 1.001 * avect[0];
    splevs(avect, c, &l, b, wk, &error);

    if (error != 0)
    {
	printf(" SPLEVS ERROR = %ld\n", error);
    }

    for (k = 0 ; k <= 50 ; ++k)
    {
	t[k] = (float) k;
	x[k] = (float) (2.0 * sin(2.0 * M_PI * (double) k / 10.0));
	y[k] = (float) (4.0 * cos(2.0 * M_PI * (double) k / 10.0));
    }

    spfilt(b, &a, &l, &pos_i1, x, &pos_i51, px, &py, &error);

    number_points = 51;
    pfile1(t,y,&number_points,&pos_i1,"P1109A");
    pfile1(t,x,&number_points,&pos_i1,"P1109B");

    printf(" FILTER COEFFICIENTS\n");

    for (i = 0 ; i <= l ; ++i)
    {
	printf(" B(%1ld) = %10.3f\n", i, b[i]);
    }
}


/* SPA1110 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 1;
float a = 0.0, px[2] = { 0.0 ,0.0 }, py = 0.0;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spdurb(), spfilt();
    long error, i, k, ll;
    float aavect[3], b[2], x[51], y[51];

/* DEMONSTRATE THE USE OF DURBIN'S ALGORITHM. */

    for (ll = 0; ll <= (l + 1); ++ll)
    {
	aavect[ll] = (float) (0.5 * cos(2.0 * M_PI * (double) ll / 10.0));
    }

    spdurb(aavect, &l, b, &error);

    if (error != 0)
    {
	printf(" SPDURB ERROR = %ld\n", error);
    }

    for (k = 0; k <= 50; ++k)
    {
	x[k] = (float) sin(2.0 * M_PI * (double) k / 10.0);
	y[k] = (float) cos(2.0 * M_PI * (double) (k - 1) / 10.0);
    }

    spfilt(b, &a, &l, &pos_i1, x, &pos_i51, px, &py, &error);

    if (error != 0)
    {
	printf(" SPFILT ERROR = %ld\n", error);
    }

    pfile2(&f0, &pos_f1, y, &pos_i51, &pos_i1, "P1110A");
    pfile2(&f0, &pos_f1, x, &pos_i51, &pos_i1, "P1110B");

    printf(" FILTER COEFFICIENTS\n");
    for (i = 0; i <= l; ++i)
    {
	printf(" B(%1ld) = %10.3f\n", i, b[i]);
    }
}


/* SPA1111 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i51 = 51;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 6;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spdurb(), spfilt();
    long error, i, ll;
    float aavect[8], b[7];

/* DEMONSTRATE THE USE OF DURBIN'S ALGORITHM. */

    for (ll = 0 ; ll <= (l + 1) ; ++ll)
    {
	aavect[ll] = (float) (0.5 * cos(2.0 * M_PI * ll / 10.));
    }

    spdurb(aavect, &l, b, &error);

    if (error != 0) {
	printf(" SPDURB ERROR = %ld\n", error);
    }

    printf(" FILTER COEFFICIENTS\n");
    for (i = 0; i <= l; ++i)
    {
	printf(" B(%1ld) = %10.3f\n", i, b[i]);
    }
}


/* SPA1201 */
#include "spaincl.h"

long pos_i1 = 1;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long l = 20, n = 501;
long seed = 12357;
float al = 0.0,
      b[21] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      mu = 0.1,
      px[21] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      sig = 2.0, x[501];

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spnlms();
    long error, k;
    float d[501];
    double sprand();

    x[0] = 0.0;
/* DEMONSTRATE THE USE OF LMS ALGORITHM FOR LINE ENHANCEMENT. */

    for (k = 0; k <= (n - 2); ++k)
    {
	d[k] = sqrt(2.0) * sin(M_PI * 2.0 * k / 20.0) + sqrt(12.0)
		* (sprand(&seed) - 0.5);
	x[k + 1] = d[k];
    }

    d[500] = sqrt(2.0) * sin(M_PI * 2.0 * 500.0 / 20.0) 
	    + sqrt(12.0) * (sprand(&seed) - 0.5);

    spnlms(x, &n, d, b, &l, &mu, &sig, &al, px, &error);

    if (error != 0)
    {
	printf(" SPNLMS ERROR = %ld\n", error);
	exit(-1);
    }

    pfile2(&f0, &pos_f1, x, &n, &pos_i1, "P1201A");
    pfile2(&f0, &pos_f1, d, &n, &pos_i1, "P1201B");
}


/* SPA1202 */
#include "spaincl.h"

long pos_i1 = 1;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_fp001 = 0.001;

/* Initialized data */

long l = 20, n = 501;
long seed = 12357;
float a = 0.0, al = 0.01,
      b[21] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      mu = 0.01,
      px[21] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      sig = 2.0, x[501];

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spnlms();
    long error, k;
    complex spgain(), tmp_complex;
    float d[501], tmp_float;
    double complex_abs(), sprand();

    x[0] = 0.0;
/* DEMONSTRATE THE USE OF NLMS ALGORITHM FOR LINE ENHANCEMENT. */

    for (k = 0 ; k <= (n -2) ; ++k)
    {
	d[k] = sqrt(2.0) * sin(M_PI * 2.0 * k / 20.0) + sqrt(12.0)
		* (sprand(&seed) - 0.5);
	x[k + 1] = d[k];
    }

    d[500] = sqrt(2.0) * sin(M_PI * 2.0 * 500.0 / 20.0)
	    + sqrt(12.0) * (sprand(&seed) - 0.5);

    spnlms(x, &n, d, b, &l, &mu, &sig, &al, px, &error);

    if (error != 0)
    {
	printf(" SPNLMS ERROR = %ld\n", error);
	exit(-1);
    }

    pfile2(&f0, &pos_f1, x, &n, &pos_i1, "P1202A");

    for (k = 0; k <= 500; ++k)
    {
	tmp_float = k * .5 / 500.;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	x[k] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp001, x, &n, &pos_i1, "P1202B", 6L);
}


/* SPA1203 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i251 = 251;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_f250 = 250.0;

/* Initialized data */

long l = 4, n = 501;
long seed = 12357;
float al = 0.0,
      b[5] = { 0.0, 0.0, 0.0, 0.0, 0.0 },
      mu = 0.1,
      px[5] = { 0.0, 0.0, 0.0, 0.0, 0.0 },
      sig = 0.005;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spnlms();
    long error, k;
    float d[501], f, si[501], x[501];
    double sprand();

/* ADAPTIVE INTERFERENCE CANCELLING */

    for (k = 0 ; k <= (n - 1) ; ++k)
    {
	f = M_PI * 2.0 * k / 20.0;
	si[k] = (k * 0.01 + 1.0) * sin(f + M_PI / 3.0);
	d[k] = sqrt(12.0) * (sprand(&seed) - 0.5) + si[k];
	x[k] = sin(f) * 0.1;
    }

    pfile2(&f0, &pos_f1, si, &pos_i251, &pos_i1, "P1203A");
    pfile2(&f0, &pos_f1, x, &pos_i251, &pos_i1, "P1203B");

    spnlms(x, &n, d, b, &l, &mu, &sig, &al, px, &error);

    if (error != 0)
    {
	printf(" SPNLMS ERROR = %ld\n", error);
	exit(-1);
    }

    pfile2(&f0, &pos_f1, x, &pos_i251, &pos_i1, "P1203C");
    pfile2(&pos_f250, &pos_f1, &si[250], &pos_i251, &pos_i1, "P1203D");
    pfile2(&pos_f250, &pos_f1, &x[250], &pos_i251, &pos_i1, "P1203E");
    pfile2(&f0, &pos_f1, d, &pos_i251, &pos_i1, "P1203F");
}


/* SPA1204 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i3 = 3;
long pos_i20 = 20;
long pos_i21 = 21;
long pos_i31 = 31;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_f15 = 0.15;
float pos_fp35 = 0.35;

/* Initialized data */

long l = 30, n = 1001;
long seed = 12357;
float al = 0.0,
      b[31] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      px[31] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      mu = 0.1, sa = 0.0, sig = 1.0,
      spx[21] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		  0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spfird(), spfltr(), spnlms();
    long error, k;
    float d[1001], sb[21], spy, tmp_float, x[1001];
    double sprand();

/* ADAPTIVE SYSTEM IDENTIFICATION */

    for (k = 0 ; k <= (n - 1) ; ++k)
    {
	x[k] = sqrt(12.) * (sprand(&seed) - .5);
    }

    spfird(&pos_i20, &pos_i3, &pos_f15, &pos_fp35, &pos_i1, sb, &error);

    if (error != 0)
    {
	printf(" SPFIRD ERROR");
	exit(-1);
    }

    spfltr(sb, &sa, &pos_i20, &pos_i1, x, &n, d, spx, &spy, &error);

    if (error != 0)
    {
	printf(" SPFLTR ERROR");
	exit(-1);
    }

    spnlms(x, &n, d, b, &l, &mu, &sig, &al, px, &error);

    if (error != 0)
    {
	printf(" SPNLMS ERROR");
	exit(-1);
    }

    for (k = 0 ; k <= (n - 1) ; ++k)
    {
	tmp_float = d[k] - x[k];
	d[k] = tmp_float * tmp_float;
    }

    pfile2(&f0, &pos_f1, d, &n, &pos_i1, "P1204A");
    pfile2(&f0, &pos_f1, b, &pos_i31, &pos_i1, "P1204B");
    pfile2(&f0, &pos_f1, sb, &pos_i21, &pos_i1, "P1204C");
}


/* SPA1205 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i41 = 41;
long pos_i51 = 51;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_fp001 = 0.001;
float pos_f0125 = 0.0125;

/* Initialized data */

long l = 50, n = 501;
float a = 0.0,
      al = 0.0,
      amp[41] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
		  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.0,
		  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      b[51] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      px[51] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
      mu = 0.2, sig = 0.2;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spnlms();
    long error, j, k;
    complex spgain(), tmp_complex;
    float d[501], x[501], tmp_float;
    double complex_abs();

/* ADAPTIVE DESIGN OF A FILTER */

    for (k = 0 ; k <= (n - 1) ; ++k)
    {
	d[k] = amp[0] * 0.1;
	x[k] = 0.1;
	for (j = 1 ; j <= 40 ; ++j)
	{
	    d[k] += amp[j] * 0.1 * sin(M_PI * 2.0 * 0.0125 * 
		    j * (k - l / 2));
	    x[k] += sin(M_PI * 2.0 * 0.0125 * j * k) * 0.1;
	}
    }

    spnlms(x, &n, d, b, &l, &mu, &sig, &al, px, &error);

    if (error != 0)
    {
	printf(" SPNLMS ERROR");
	exit(-1);
    }

    for (k = 0 ; k <= (n - 1) ; ++k)
    {
	tmp_float = k * 0.5 / 500.0;
	tmp_complex = spgain(b, &a, &l, &pos_i1, &tmp_float);
	x[k] = complex_abs(&tmp_complex);
    }

    pfile2(&f0, &pos_fp001, x, &n, &pos_i1, "P1205A");
    pfile2(&f0, &pos_f0125, amp, &pos_i41, &pos_i1, "P1205B");
    pfile2(&f0, &pos_f1, b, &pos_i51, &pos_i1, "P1205C");
}


/* SPA1301 */
#include "spaincl.h"

#define LENGTH 4
#define MAXSIZE 10000

/* The above constants may be changed to 5 and 100000 to include the 
   100000 sample test case, however for some compilers, this will require
   compiling with a huge memory model.  Also note that a large amount of
   memory will be needed to run the program with this case. (~ 450K )
*/

/* Initialized data */

long len[5] = { 10,100,1000,10000,100000 };
long seed = 12357;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    long k, l;
    float avg, var;
    static float x[MAXSIZE];
    double spmean(), sprand(), spvari();

/* COMPUTE MEAN AND VARIANCE OF VECTOR OF RANDOM NUMBERS */

    for (k = 0; k < MAXSIZE; ++k)
    {
	x[k] = sprand(&seed);
    }

    printf(" LENGTH          MEAN             VARIANCE\n");
    for (l = 0; l < LENGTH; ++l)
    {
	avg = spmean(x, &len[l]);
	var = spvari(x, &len[l]);
	printf("%7ld       %10.7f       %10.7f\n", len[l], avg, var);
    }
}


/* SPA1302 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i2 = 2;
long pos_i51 = 51;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_f50 = 50.0;

/* Initialized data */

long n = 51;
long seed = 12357;
float a = 0.05, b = 0.25;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), splfit();
    long error, k;
    float aest, best, plt[2], x[51], y[51];
    double sprand();

/* DEMONSTRATE USE OF STRAIGHT LINE FIT ROUTINE. */

    for (k = 0; k <= 50; ++k)
    {
	x[k] = (float) k;
	y[k] = a * x[k] + b + (sprand(&seed) - 0.5) * 0.25;
    }

    splfit(x, y, &n, &aest, &best, &error);

    if (error != 0)
    {
	printf(" SPLFIT ERROR = %ld\n", error);
	exit(-1);
    }

    pfile2(&f0, &pos_f1, y, &pos_i51, &pos_i1, "P1302A");

    plt[0] = best;
    plt[1] = aest * 50.0 + best;

    pfile2(&f0, &pos_f50, plt, &pos_i2, &pos_i1, "P1302B");

    printf(" EQUATION:  Y = %5.3fX + %5.3f\n", aest, best);
}


/* SPA1303 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_fp1 = 0.1;

/* Initialized data */

long n = 51;
long seed = 12357;
float a = 2.0, b = 0.95;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spexpn();
    long error, i;
    float aest, best, plt[501], x[51], y[51];
    double pow_ri(), sprand();

/* DEMONSTRATE USE OF EXPONENTIAL FIT ROUTINE. */

    for (i = 0; i <= 50; ++i)
    {
	x[i] = (float) i;
	y[i] = a * pow_ri(&b, &i) + (sprand(&seed) - 0.5) * 0.2;
    }

    pfile2(&f0, &pos_f1, y, &n, &pos_i1, "P1303A");

    spexpn(x, y, &n, &aest, &best, &error);

    if (error != 0)
    {
	printf(" SPEXPN ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	plt[i] = aest * pow((double) best, (double) (i / 10.0));
    }

    pfile2(&f0, &pos_fp1, plt, &pos_i501, &pos_i1, "P1303B");

    printf(" EQUATION:  Y = (%4.2f)(%5.3f**X)\n", aest, best);
}


/* SPA1304 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_fp1 = 0.1;

/* Initialized data */

long n = 51;
long seed = 12357;
float a = 0.5, b = 0.5;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), sppwrc();
    long error, i;
    float aest, best, plt[501], x[51], y[51];
    double sprand();

/* DEMONSTRATE USE OF POWER FUNCTION FIT ROUTINE. */

    for (i = 0; i <= 50; ++i)
    {
	x[i] = (float) (i + 1);
	y[i] = a * pow((double) x[i], (double) b)
	       + (sprand(&seed) - 0.5) * 0.25;
    }

    pfile2(&f0, &pos_f1, y, &n, &pos_i1, "P1304A");

    sppwrc(x, y, &n, &aest, &best, &error);

    if (error != 0)
    {
	printf(" SPPWRC ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0 ; i <= 500 ; ++i)
    {
	plt[i] = aest * pow((double) (i / 10. + 1.0), (double) best);
    }

    pfile2(&f0, &pos_fp1, plt, &pos_i501, &pos_i1, "P1304B");

    printf(" EQUATION:  Y = %4.2f*(X**%4.2f)\n", aest, best);
}


/* SPA1305 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i501 = 501;
float f0 = 0.0;
float pos_f1 = 1.0;
float pos_fp1 = 0.1;

/* Initialized data */

long n = 51;
long seed = 12357;
float a = -0.1, b = 0.5;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), spxexp();
    long error, i;
    float aest, best, plt[501], x[51], y[51];
    double sprand();

/* DEMONSTRATE USE OF SPXEXP ROUTINE. */

    for (i = 0 ; i <= 50 ; ++i)
    {
	x[i] = (float) (i + 1.0);
	y[i] = b * x[i] * exp(a * x[i]) + (sprand(&seed) - 0.5) * 0.2;
    }

    pfile2(&f0, &pos_f1, y, &n, &pos_i1, "P1305A");

    spxexp(x, y, &n, &aest, &best, &error);

    if (error != 0)
    {
	printf(" SPXEXP ERROR = %ld\n", error);
	exit(-1);
    }

    for (i = 0; i <= 500; ++i)
    {
	plt[i] = best * (i / 10. + 1.) * exp(aest * (i / 
		10. + 1.));
    }

    pfile2(&f0, &pos_fp1, plt, &pos_i501, &pos_i1, "P1305B");

    printf(" EQUATION:  Y = %4.2f*X*EXP(%4.2f*X)\n", best, aest);
}


/* SPA1306 */
#include "spaincl.h"

long pos_i1 = 1;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long n = 101;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), splmts();
    long i, imin, imax;
    float x[101], xmin, xmax;

/* DEMONSTRATE USE OF SPLMTS ROUTINE. */

    for (i = 0; i <= 49; ++i)
    {
	x[i] = sin(M_PI * 2.0 * 0.25 * (i - 50)) / (M_PI * (i - 50));
	x[100 - i] = x[i];
    }

    x[50] = 0.5;

    splmts(x, &n, &xmin, &imin, &xmax, &imax);

    pfile2(&f0, &pos_f1, x, &n, &pos_i1, "P1306A");

    printf(" MAXIMUM VALUE:  X(%3ld) = %5.3f\n", imax, xmax);
    printf(" MAXIMUM VALUE:  X(%3ld) = %5.3f\n", imin, xmin);
}


/* SPA1307 */
#include "spaincl.h"

long pos_i1 = 1;
long neg_i1 = -1;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long n = 51;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), sprftm();
    long error, i;
    float fall0, fall10, fall90, fall100,
	  rise0, rise10, rise90, rise100, x[51];

/* DEMONSTRATE USE OF SPRFTM ROUTINE. */

    for (i = 0 ; i <= 50 ; ++i)
    {
	x[i] = i * exp(i * -0.1);
    }

    sprftm(&pos_i1, x, &n, &rise0, &rise10, &rise90, &rise100, &error);

    if (error != 0)
    {
	printf(" SPRFTM ERROR = %ld\n", error);
    }

    sprftm(&neg_i1, x, &n, &fall0, &fall10, &fall90, &fall100, &error);

    if (error != 0)
    {
	printf(" SPRFTM ERROR = %ld\n", error);
    }

    pfile2(&f0, &pos_f1, x, &n, &pos_i1, "P1307A");

    printf("                MIN        10%%        90%%       MAX\n");
    printf(" RISE TIME    %6.2f     %6.2f     %6.2f    %6.2f\n",
	   rise0, rise10, rise90, rise100);
    printf(" FALL TIME    %6.2f     %6.2f     %6.2f    %6.2f\n",
	   fall0, fall10, fall90, fall100);
}


/* SPA1308 */
#include "spaincl.h"

long pos_i1 = 1;
long neg_i1 = -1;
float f0 = 0.0;
float pos_f1 = 1.0;

/* Initialized data */

long n = 51;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    long error, i;
    void pfile2(), sprftm();
    float fall0, fall10, fall90, fall100,
	  rise0, rise10, rise90, rise100, x[51];

/* DEMONSTRATE USE OF SPRFTM ROUTINE. */

    for (i = 0; i <= 24; ++i)
    {
	x[i] = sin(M_PI * 2.0 * 0.25 * (i - 25)) / (M_PI * (i - 25));
	x[50 - i] = x[i];
    }

    x[25] = 0.5;

    sprftm(&pos_i1, x, &n, &rise0, &rise10, &rise90, &rise100, &error);

    if (error != 0)
    {
	printf(" SPRFTM ERROR = %ld\n", error);
    }

    sprftm(&neg_i1, x, &n, &fall0, &fall10, &fall90, &fall100, &error);

    if (error != 0)
    {
	printf(" SPRFTM ERROR = %ld\n", error);
    }

    pfile2(&f0, &pos_f1, x, &n, &pos_i1, "P1308A");

    printf("                MIN        10%%        90%%       MAX\n");
    printf(" RISE TIME    %6.2f     %6.2f     %6.2f    %6.2f\n",
	   rise0, rise10, rise90, rise100);
    printf(" FALL TIME    %6.2f     %6.2f     %6.2f    %6.2f\n",
	   fall0, fall10, fall90, fall100);

}


/* SPA1401 */
#include "spaincl.h"

long pos_i6 = 6;
long pos_i255 = 255;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), spmask();
    long i, j, l, k, error, number_points;
    float w[1536], x[256], tsv[6];

/* PLOTS OF SIX DATA WINDOWS. */

    for (i = 6, l = 0 ; i > 0 ; --i, ++l)
    {
	for (k = 0, j = 0 ; k < 256 ; ++k, ++j)
	{
	    x[k] = (float) k;
	    w[j + ( l * 256 )] = 1.0;
	}

	spmask(&w[l * 256], &pos_i255, &i, &tsv[i - 1], &error);

	if (error != 0)
	{
	    exit(1);
	}
    }

    number_points = 256;

    pfile1(x,w,&number_points,&pos_i6,"P1401A");

    printf(" TYPE   TSV\n");
    for (i = 0 ; i < 6 ; ++i)
    {
	printf("%4ld%12.6f\n", i+1, tsv[i]);
    }
}


/* SPA1402 */
#include "spaincl.h"

long pos_i6 = 6;
long pos_i16 = 16;
long pos_i999 = 999;
float f0 = 0.0;
float pos_fp5 = 0.5;
float pos_fp03125 = 0.03125;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile2(), sppowr();
    long i, k, m, error, ns, number_points, windo;
    long seed;
    float x[1002], y[102], wk[34];
    double sprand();

/* POWER DENSITY SPECTRA USING 6 DIFFERENT DATA WINDOWS. */
/* GENERATE THE TIME SERIES. */

    seed = 321;
    x[1] = 0.0;
    x[0] = 0.0;

    for (k = 0 ; k <= 999 ; ++k)
    {
	x[k + 2] = (float) (sqrt(12.0)
		   * (sprand(&seed) - 0.5)
		   + (double) x[k + 1] - (double) x[k] * 0.8);
    }

/* COMPUTE AND PLOT THE 6 POWER SPECTRA. */

    for (windo = 6, i = 0 ; windo >= 1 ; --windo, i++)
    {
	sppowr(&x[2], &y[i * 17], wk, &pos_i999, &pos_i16,
	       &windo, &pos_fp5, &ns, &error);

	if (error != 0)
	{
	    exit(1);
	}

	for (m = 0 ; m <= 16 ; ++m)
	{
	    y[m + (i * 17)] = 10.0 * (float) log10((double) y[m + (i * 17)]);
	}
    }

    number_points = 17;
    pfile2(&f0,&pos_fp03125,y,&number_points,&pos_i6,"P1402A");
}


/* SPA1403 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i2 = 2;
long pos_i200 = 200;
long f0 = 0.0;

/* Initialized data */

float b[3] = { 1.0, -4.0, 4.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), spunwr();
    long m, number_points;
    complex g, spgain();
    float freq[201], phase[201];

/* PHASE RESPONSE OF FIR FILTER, H(Z)=1-4*Z**(-1)+4*Z**(-2). */

    for (m = 0 ; m <= 200 ; ++m)
    {
	freq[m] = (float) m * 0.5 / 200.0;
	g = spgain(b, &f0, &pos_i2, &pos_i1, &freq[m]);
	phase[m] = (float) (atan2(g.i, g.r) * 180.0 / M_PI);
    }

    number_points = 201;
    pfile1(freq,phase,&number_points,&pos_i1,"P1403A");

    spunwr(phase, &pos_i200, &pos_i2);

    pfile1(freq,phase,&number_points,&pos_i1,"P1403B");
}


/* SPA1404 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i64 = 64;
long pos_i151 = 151;
float f0 = 0.0;

/* Initialized data */

float px[65] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
	         0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
		 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), sphilb(), spfltr();
    long k, error, number_points;
    float b[65], xd[151], t[151], x[151], y[151];

/* HILBERT TRANSFORM OF A SINE WAVE WITH 30 SAMPLES/PERIOD. */
/* GENERATE THE SINE WAVE PLUS A VERSION DELAYED BY 32 SAMPLES. */

    for (k = 0; k <= 150; ++k)
    {
	t[k] = (float) k;
	x[k] = (float) sin(2.0 * M_PI * k / 30.0);
	xd[k] = (float) sin(2.0 * M_PI * ((double) k - 32.0) / 30.0);
    }

/* GENERATE THE HILBERT-TRANSFORMED VERSION USING L=65 WEIGHTS. */

    sphilb(b, &pos_i64);
    spfltr(b, &f0, &pos_i64, &pos_i1, x, &pos_i151, y, px, px, &error);

    if (error != 0)
    {
	exit(1);
    }

/* PLOT THE DELAYED AND TRANSFORMED WAVEFORMS. */

    number_points = 151;
    pfile1(t,xd,&number_points,&pos_i1,"P1404A");
    pfile1(t,y,&number_points,&pos_i1,"P1404B");
}


/* SPA1405 */
#include "spaincl.h"

long pos_i1 = 1;
long pos_i923 = 923;
long pos_i2047 = 2047;
float f0 = 0.0;
float pos_fp03 = 0.03;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    void pfile1(), spchrp();
    long k, m, error, lx2, number_points;
    static complex work[2048], x[2048];
    float ampl[1125], freq[1125];
    double complex_abs();

/* USES THE CHIRP Z-TRANSFORM TO FIND THE SPECTRUM OF */
/* EXP(-K/176)*SIN(2*PI*K/160) FROM 0.0 TO 0.03 HZ-S. */
/* GENERATE THE TIME SERIES. */

    for (k = 0 ; k <= 923 ; ++k)
    {
	x[k].r = (float) (exp((double) -k / 176.0)
		 * sin(2.0 * M_PI * (double) k / 160.0));
	x[k].i = 0.0;
    }

/* GENERATE THE DFT IN THE DESIRED FREQUENCY RANGE. */

    spchrp(x, &pos_i2047, &pos_i923, &f0, &pos_fp03, work, &lx2, &error);

    if (error != 0)
    {
	exit(1);
    }

    for (m = 0 ; m <= lx2 ; ++m)
    {
	freq[m] = m * 0.03 / lx2;
	ampl[m] = (float) complex_abs(&x[m]);
    }

    number_points = lx2+1;
    pfile1(freq,ampl,&number_points,&pos_i1,"P1405A");
}


/* SPA1406 */
#include "spaincl.h"

long pos_i3 = 3;

#ifndef KR
main(void)
#else
main()
#endif
{
    /* Local variables */
    long nseq, k;
    float coeff[8];
    double spwlsh();

/* WALSH COEFFICIENTS FOR SEQUENCE LENGTH N=8. */

    printf(" SEQ. INDEX  --WALSH COEFFICIENTS----------\n");
    for (nseq = 0; nseq <= 7; ++nseq)
    {
	printf("%6ld     ", nseq);
	for (k = 0; k <= 7; ++k)
	{
	    coeff[k] = spwlsh(&pos_i3, &nseq, &k);
	    printf("%4.0f", coeff[k]);
	}
	printf("\n");
    }
}

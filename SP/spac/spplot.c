
#include <stdio.h>

/**********************************************************************/
/*                             SPPLOT                                 */
/*       Plot File Routines for SIGNAL PROCESSING ALGORITHMS.         */
/**********************************************************************/

/* LATEST DATE:  07/06/92. */
/* CREATES THE XY PLOT FILE "NAME.DAT" FOR SUBSEQUENT PLOTTING. */
/* INPUTS:  X(0:N-1)    = ABSCISSA VALUES X(0) THRU X(N-1). */
/*          Y(0:N-1,NP) = ORDINATE VALUES Y(0) THRU Y(N-1) FOR NP CURVES. */
/*          N           = NUMBER OF (X,Y) POINTS ON EACH CURVE. */
/*          NP          = NUMBER OF SEPARATE CURVES, FROM 1 THRU 6. */
/*          NAME        = NAME OF FILE -- 6 CHARACTERS. */
/* THE KTH RECORD OF THE "NAME.DAT" FILE HAS FORMAT (NP+1)2E15.7, AND */
/* CONTENTS X(K),Y(K,1),Y(K,2),...,Y(K,NP).  THUS, WITH NP=1, THE FILE */
/* HAS JUST ONE (X,Y) PAIR PER RECORD. */

#ifndef KR
void pfile1(float *x, float *y, long *number_points, long *number_plots, char *name)
#else
void pfile1(x, y, number_points, number_plots, name)
char *name;
long *number_plots, *number_points;
float *x, *y;
#endif
{
    /* Local variables */
    FILE *fp;
    char filename[11];
    long i, j;

    sprintf(filename,"%s.DAT",name);

    fp = fopen(filename,"w+");

    fprintf(fp, "%6ld%6ld\n", *number_points, *number_plots);
    for ( i = 0 ; i < *number_points ; i++ )
    {
      fprintf(fp,"%15.7E",x[i]);
      for ( j = *number_plots-1 ; j >= 0 ; j-- )
      {
        fprintf(fp,"%15.7E",y[i + (j * *number_points)]);
      }
      fprintf(fp,"\n");
    }
    fclose(fp);

} /* pfile1 */

/* LATEST DATE: 06/30/92 */
/* CREATES THE XY PLOT FILE "NAME.DAT" FOR SUBSEQUENT PLOTTING. */
/* INPUTS:  X0          = STARTING ABSCISSA VALUE, X(0) */
/*          DX          = X INCREMENT, X(K)-X(K-1) */
/*          Y(0:N-1,NP) = ORDINATE VALUES Y(0) THRU Y(N-1) FOR NP CURVES. */
/*          N           = NUMBER OF (X,Y) POINTS ON EACH CURVE. */
/*          NP          = NUMBER OF SEPARATE CURVES, FROM 1 THRU 6. */
/*          NAME        = NAME OF FILE -- 6 CHARACTERS. */
/* THE KTH RECORD OF THE "NAME.DAT" FILE HAS FORMAT (NP+1)2E15.7, AND */
/* CONTENTS X(K),Y(K,1),Y(K,2),...,Y(K,NP).  THUS, WITH NP=1, THE FILE */
/* HAS JUST ONE (X,Y) PAIR PER RECORD. */

#ifndef KR
void pfile2(float *x0, float *dx, float *y, long *number_points, long *number_plots, char *name)
#else
void pfile2(x0, dx, y, number_points, number_plots, name)
char *name;
long *number_points, *number_plots;
float *x0, *dx, *y;
#endif
{
    /* Local variables */
    FILE *fp;
    char filename[11];
    long i, j;

    sprintf(filename,"%s.DAT",name);

    fp = fopen(filename,"w+");

    fprintf(fp, "%6ld%6ld \n", *number_points, *number_plots);
    for ( i = 0 ; i < *number_points ; i++ )
    {
      fprintf(fp,"%15.7E", (*x0 + (i * *dx)));
      for ( j = *number_plots-1 ; j >= 0 ; j-- )
      {
        fprintf(fp,"%15.7E", y[i + (j * *number_points)]);
      }
      fprintf(fp,"\n");
    }
    fclose(fp);

} /* pfile2 */


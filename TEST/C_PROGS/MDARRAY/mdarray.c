

#include <stdio.h>
#include <stdlib.h>

#define NROWS 3
#define NCOLS 10


void dsp2(int *I, int *Q, int sz) 
{
  int i;
  int q;
  int j,m;
      //printf("k %d\n",k);
  printf(" dsp2 in \n");
    for ( m = 0; m < NCOLS; m++) {

      i = I[m];
      q = Q[m];
      //printf("k %d\n",k);

	printf("m %d i %d q %d \n",m , i , q );

    }
  printf(" dsp2 out \n");

}

void dsp1(int I[NROWS][NCOLS],
          int Q[NROWS][NCOLS], int sz)
{
  int i;
  int q;
  int j,m;
  printf(" dsp1 im \n");

  for (j = 0; j < NROWS; j++) {
    for (m = 0; m < NCOLS; m++) {
        i = I[j][m]; 
	q = Q[j][m];

	printf("j %d m %d i %d q %d \n",j, m , i , q );

    }
  } 

  I[0][0] = 79;
  Q[0][0] = 47;

  dsp2(I[0], Q[0],NCOLS);
  dsp2(I[1], Q[1], NCOLS);

  printf(" dsp1 out \n");

}

void dsp3(int I[][NCOLS],
          int Q[][NCOLS], int sz)
{
  int i;
  int q;
  int j,m;
  printf(" dsp3 in \n");

  for (j = 0; j < NROWS; j++) {
    for (m = 0; m < NCOLS; m++) {
        i = I[j][m]; 
	q = Q[j][m];

	printf("j %d m %d i %d q %d \n",j, m , i , q );

    }
  } 

  I[0][0] = 79;
  Q[0][0] = 47;

  dsp2(I[0], Q[0],NCOLS);
  dsp2(I[1], Q[1], NCOLS);

  printf(" dsp3 out \n");

}





int main (int argc, char **argv)
{

  int I[NROWS][NCOLS];
  int Q[NROWS][NCOLS];

  int k = 10;
  int r = 0;
  int i = 0;
  int q = 0;
  int j,m;
  int sz = sizeof (I);

  printf( "sz %d\n",sz);

  for (j = 0; j < NROWS; j++) {
    for (m = 0; m < NCOLS; m++) {
      i = I[j][m] = k++;
      q = Q[j][m] = r++;

	printf("j %d m %d i %d q %d \n",j, m , i , q );

    }
  } 


  dsp1(I,Q, sz); 


  for (j = 0; j < NROWS; j++) {
    for (m = 0; m < NCOLS; m++) {
        i = I[j][m]; 
	q = Q[j][m];
	printf("j %d m %d i %d q %d \n",j, m , i , q );
    }
  } 


   dsp3(I,Q, sz); 

   int (*ip)[NCOLS];  // ptr to array of NCOLS ints

   //   ip= &I[0][0];

   ip= &I[0];

   dsp3(ip,Q, sz); 

   dsp3(&I[0],Q, sz); 

}

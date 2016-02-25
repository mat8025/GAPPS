

#include <iostream>
#include <ostream>
#include <fstream>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>


using namespace std;

#define NROWS 3
#define NCOLS 10


void dsp2(int *I, int *Q, int sz) 
{
  int i;
  int q;
cout << " dsp2 in " << endl ;
    for (int m = 0; m < NCOLS; m++) {

      i = I[m];
      q = Q[m];
 cout << " m " << m << " i " << i << " q " << q  << endl;

    }

cout << " dsp2 out " << endl ;
}

void dsp1(int I[NROWS][NCOLS],
          int Q[NROWS][NCOLS], int sz)
{
  int i;
  int q;

  for (int j = 0; j < NROWS; j++) {
    for (int m = 0; m < NCOLS; m++) {
        i = I[j][m]; 
	q = Q[j][m];

	cout << "j " << j << " m " << m << " i " << i << " q " << q  << endl;

    }
  } 

  I[0][0] = 79;
  Q[0][0] = 47;

  dsp2(I[0], Q[0],NCOLS);
  dsp2(I[1], Q[1], NCOLS);

  cout << " dsp1 out " << endl ;

}





int main (int argc, char **argv)
{

  int I[NROWS][NCOLS];
  int Q[NROWS][NCOLS];

  int k = 10;
  int r = 0;
  int i = 0;
  int q = 0;

  int sz = sizeof (I);

  cout << "sz " << sz << endl;

  for (int j = 0; j < NROWS; j++) {
    for (int m = 0; m < NCOLS; m++) {
      i = I[j][m] = k++;
      q = Q[j][m] = r++;

      cout << "j " << j << " m " << m << " i " << i << " q " << q  << endl;

      //printf("k %d\n",k);
    }
  } 


  dsp1(I,Q, sz); 


  for (int j = 0; j < NROWS; j++) {
    for (int m = 0; m < NCOLS; m++) {
        i = I[j][m]; 
	q = Q[j][m];

	cout << "j " << j << " m " << m << " i " << i << " q " << q  << endl;

    }
  } 



}

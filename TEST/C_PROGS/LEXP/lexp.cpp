

#include <iostream>
#include <ostream>
#include <fstream>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>


using namespace std;

int main (int argc, char **argv)
{

  int k = 10;
  int i = 0;

  for (int j = 0; j < 5; j++) {
    i = k++;
    cout << j << endl;
    printf("k %d\n",k);

  } 


  //<<"%V $j \n"

  int m = 5;

  for (int j = 0; j < (m=10); j++) {
    i = k++;
    //<<"%V$j $i "
    printf ("k %d  m %d\n",k,m);

  } 


}

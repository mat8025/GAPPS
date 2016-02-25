#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

using namespace std;

int cp[10];

int len;

int nit = 0;
int pn  = 0;

int rav[10];


int av[10];

char s[20] = "abcdefg";


void shiftRight (int vr[], int len)
{
  int lm = vr[0];
  for (int j = 0; j < (len -1) ; j++) {
    vr[j] = vr[j+1];
  }
  vr[len-1] = lm;
}

void shiftLeft (int vr[], int len)
{
  int rm = vr[len-1];
  for (int j = len-1; j > 0 ; j--) {
    vr[j] = vr[j-1];
  }
  vr[0] = rm;
}


void perm (int np, int sav[])
{
  int lav[10];
  int clen;
  int rsa;

  nit++;

  //  cout << endl <<  "nit " << nit << " av[] " << av[0] << " " << av[1] << " " << av[2] << endl;
  //  cout << endl <<  "perm " <<   " " <<  (len-np) << " " << sav[np] << " " << sav[np+1] << endl << endl;


  if (np == 0) {
    pn++;
    cout << pn << " :-> [" ;
    for (int j =0; j < len; j++)
    cout << av[j] << "  "  ;
    cout << "] < " ;
    for (int j =0; j < len; j++)
    cout << s[av[j]] << "  "  ;

    cout << " > " << endl ;
    return;
  }

  //  sav[0] = (np + 1) % len;
  
  clen = np;
  int wp = len - np ;

  for (int k = 0; k < clen ; k++) {

    sav[0] = rav[wp];

    //    cout << "nit " << nit << " k " << k << " clen " << clen << " wp  " << wp << " rsa " << rsa << endl ;

    perm(np-1, &sav[1]);

    shiftRight(&rav[wp],clen); 

  }

}


int main(int argc, char *argv[])
{

  strcpy(s,argv[1]);

  len = strlen(argv[1]);

  if (len <= 0) 
    return -1;

  cout << len << " arg2 "  << argv[1] << endl;

  cout << s << endl;

  int cp[10];
  int np;

  for (int i = 0; i < 10 ; i++) {
    //    av[i] = -1;
    rav[i] = i;
  }

  // shiftLeft(rav,len);
  // shiftLeft(rav,len);

  cout << s << " len " << len << endl;
  cout << endl;

  int si = 0;

  perm(len, av);

  cout << " Perms All done -- number of iterations " << nit << " permutations " << pn << endl ;

}

#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

using namespace std;

#define MAXPERM 20




class Perm {
  int cnit;
  int nit;
  int pn;
  int npr;
  char s[MAXPERM];

 public:

  int rav[MAXPERM];  
  int av[MAXPERM];
  int nl;

  uint *iv;
  uint *ivp;




  void inc() { nit++; };
  void pcnt() { pn++; };
  int  getCnt() const {  return pn; }; 
  int  getNit() const {  return nit; }; 
  int  getNpr() const {  return npr; }; 
  char getLetter(int k) const { return s[k]; };
  const char * getWord() const { return s; };

  void shiftLeft( int wp, int clen);

   Perm(int n, char *wrd);
   ~Perm() { delete [] iv; };
};


Perm::Perm (int n, char *wrd) : nl(0), pn (0), nit(0), iv(NULL), ivp( NULL) 
{

  for (int j =0 ; j < MAXPERM ; j++) 
    s[j] = 0;


  if (n <=0)
    npr = 0;
  else {

  npr = 1;
  nl = n; // max ??

  while (n > 1) {
    npr *= n--;
  }

  for (int i =0 ; i < nl ; i++) {
    rav[i] = i; // setup the indexing
    av[i] = 0;
    s[i] = wrd[i];
  }

  cnit = npr * (nl) ;
  cout << "constructing " << cnit << " " << s << endl;
  iv = new uint [cnit+1] ;
  ivp = iv;

  }
}


void Perm::shiftLeft( int wp, int clen)
{
    int *vr = &rav[wp];
    int lm = vr[0];

    for (int j = 0; j < (clen -1) ; j++) {
        vr[j] = vr[j+1];
    }

    vr[clen-1] = lm;
} 


void permR (int np, int sav[], Perm *p)
{
  int clen;

  p->inc();

  //  cout << endl <<  "nit " << p->nit << " av[] " << p->av[0] << " " << p->av[1] << " " << p->av[2] << endl;
  //  cout << endl <<  "perm " <<   " " <<  (len-np) << " " << sav[np] << " " << sav[np+1] << endl << endl;


  if (np == 0) {

    p->pcnt();

    cout << p->getCnt() << " :-> [ " ;

    for (int j =0; j < p->nl; j++) {
      cout << p->av[j] << "  "  ;
      *p->ivp++ = p->av[j];
    }
             cout <<  "]  < "  ;

        for (int j =0; j < p->nl; j++)
	  cout << p->getLetter(p->av[j]) << "  "  ;

	cout << "> " << endl ;

    return;
  }

  
  clen = np;

  int wp = p->nl - np ;

  for (int k = 0; k < clen ; k++) {

    sav[0] = p->rav[wp];

    //cout << "nit " << p->nit << " k " << k << " clen " << clen << " wp  " << wp  << endl ;

    permR(np-1, &sav[1], p);

    p->shiftLeft(wp,clen); 

  }

}


void doPerm( Perm *p)
{
  int n; 

  n = p->nl;

  //  cout << " npr " << p->getNpr() << endl;
  //  cout <<  "nl " << p->nl << " av[] " << p->av[0] << " " << p->av[1] << " " << p->av[2] << endl;
  //  cout <<  "nl " << p->nl << " rav[] " << p->rav[0] << " " << p->rav[1] << " " << p->rav[2] << endl;

  permR(n, p->av, p);


}


int main(int argc, char *argv[])
{

  int len;

  try {

  if (argv[1] == NULL)
            throw -1;

  len = strlen(argv[1]);

  if (len <= 0) 
      throw -1;

  if (len >= MAXPERM) 
     throw -2;

  
  Perm p(len, argv[1]);

  cout << len << " arg1 "  << argv[1] << endl;

  cout << p.getWord() << endl;

  cout << p.getWord() << " len " << len << endl;
  
  cout << endl;

  doPerm(&p);

  cout << " Perms All done -- number of iterations " << p.getNit() << " permutations " << p.getCnt() << endl ;

  }

  catch (int ball)
    {
      if (ball == -1)
        cout << " usage ./strperm word " << endl;        

      if (ball == -2)
        cout << " word is too long max is  " << MAXPERM << endl;        

    }

}

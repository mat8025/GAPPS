#ifndef _RECORD_H
#define _RECORD_H 1


#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "siv.h"
#include "svar.h"
#include "aop.h"

class Record: public Siv {

 public:

  void prstatus () { cout << "Record is an array of Svars " << "\n"; };
  void getSize () { cout << " size " << size << "\n"; };
  
    Svar **recvec;
    Aop aop;
    int size;
	////////// Member Functions /////////
        int getBounds(int wb) { return aop.getBounds(wb);};
	int getND() { return aop.getND();};
	int set (int num);
        Svar ** getRecord() { return recvec;};
        Svar * getRecord(int i) { return recvec[i];};
        int realloc (int num, int size);
  //     manipulate record structure
        int  sortCols(int rol, int an, int dir , int si = 0);
	int  sortRows(int rol, int an, int dir, int si = 0);
	void swapRows (int a,int b);
	void swapCols (int a,int b);
	void deleteRows (int a,int b);
	void insertRows (int a,int nr,int b);	
	void deleteVecOfRows (int rows[], int n);	
	void deleteCols (int a,int b);			
  //
  // cons - destr
  
   Record () { printf("cons a Record \n"); recvec = NULL; setType (RECORD);};
   ~Record();

};



// add in class Aop, Range




#endif

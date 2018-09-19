#ifndef _SIV_H
#define _SIV_H 1

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
using namespace std;



/*  bit-code si variable control  bit word */
#define VOK           0x1   // bit 0
#define SI_STATIC	0x2 
#define PROC_ARG_REF	0x4	 
#define SI_ARRAY	0x8	
#define DYNAMIC_ARRAY   0x10
#define PROC_ARG_VALUE	0x20	
#define SI_GENERIC      0x40
#define SUBSC_ARRAY     0x80
#define SUBSC_ARRAY_LH  0x100
#define SUBSC_SVAR      0x200 // not needed?
#define SUBSC_SVAR_LH   0x400 // not needed?
#define RP_TRANSFER     0x800
#define SUBSC_ARRAY_LSET 0x1000 
#define SUBSC_LOCK     0x2000
#define ARRAY_ELE      0x4000 	
#define SUBI           0x8000 	
#define SVPTR          0x10000 	 //pts to si variable for vector ops 
#define SI_PRIVATE     0x20000 	 // private/public 
#define SI_CLASS                0x40000  // is object/class
#define SI_MEMBER            0x80000 	 //<bit 20> is class_member
#define SI_ACCESS              0x100000  // can access
#define SI_GLOBAL              0x200000 	
#define SI_PTRADDR            0x400000 	
#define PROC_VAR               0x800000
#define SUBSC_RANGE         0x1000000
#define REF_LH                     0x2000000 
#define LH_SUBSC_RANGE   0x4000000 
#define SI_CONST                 0x8000000
#define RDPHOLD                 0x10000000
#define SVREF                 0x20000000  // reference to si variable
#define SI_FREE	              0x40000000


#define LH_SUBSC  SUBSC_ARRAY_LH




/*  bit-code siv variable attribute word */
#define PTR_VAR		         0x1	   //<bit 0>
#define TAG_ARG	 	         0x2	   //<bit 1> siv argument additional attributes
#define ARGTMPVAR               0x4	   //<bit 2>
#define EXPVAR                       0x8	   //<bit 3> siv used in expression eval
#define SI_ENUM                      0x10	   //<bit 4> siv used as ENUM
#define AOP_SET                      0x20	   //<bit 5> AOP array object set
#define LS_ARG                        0x40       //        arg is literal string
#define LIST_ARG                     0x80       //        arg is a list
#define PTR_ARG                      0x100       //        arg is a ptr -- check re ARGPTR
#define ARRAY_NAME_ARG      0x200       //
#define DOB_LIST                     0x400       //
#define DOB_SVAR                   0x800       //
#define DOB_PAN                     0x1000      //
#define DOB_RECORD              0x2000       //
#define DOB_EVENT                 0x4000       //
#define REC_FLD                      0x8000      //        
#define STACKV_ARG_REF         0x10000  // stack arg ref variable
#define SI_STACKV                   0x20000  // stack variable
#define SI_STVINUSE	          0x40000
#define SI_STVSTR 	          0x80000
#define SI_STVNUM 	          0x100000
#define SI_STVPAN 	          0x200000
#define VALUE_ARG 	          0x400000
//=======================================
#define NM_INFO           0x1 
#define ID_INFO	       0x2 
#define SLOT_INFO        0x4
#define TYPE_INFO        0x8
#define SZ_INFO            0x10
#define ND_INFO            0x20	 
#define OFFS_INFO        0x40
#define RCOL_INFO        0x80
#define CW_INFO        0x100
#define AW_INFO        0x200	 



#include "aop.h"

class Siv {

 private:
        uint32_t  cw;  //  indicates what the siv var is used for
        uint32_t  aw;  // used as an argument attributes
  	//////////////////  CW //////////////////////////////////


public:
  virtual void prstatus () = 0;
  virtual int getBounds (int wb) = 0;
  virtual int getND () = 0;  

  int type;
  int dtype;
  int size;
        uint32_t testCW(uint32_t wd) { return ((cw & wd)); };
        void setCW(uint32_t wd, uint32_t on)
	{
             cw = (on) ? (cw | wd) : (cw & ~wd);
        };
        uint32_t testAW(uint32_t wd) { return ((aw & wd)); };	
        void setAW(uint32_t wd, uint32_t on)
	{
             aw = (on) ? (aw | wd) : (aw & ~wd);
        };
        char name[MAXVARNAME+1];
  
  void setType(int wt) { type = wt;};
  int getType() { return type;};  
  void setDtype(int wt) { dtype = wt;};
  int getDtype() { return dtype;};  
  int getSize () { cout << " size " << size << "\n"; return size; };

  int  Sizeof ()
    {
      if (dtype == SHORT) return sizeof(short);
      if (dtype == INT) return sizeof(int);
      if (dtype == LONG) return sizeof(long);
      if (dtype == DOUBLE) return sizeof(double);
      if (dtype == FLOAT) return sizeof(float);      

      return sizeof(long);      
    }

  
  Siv() { name[0] = 0; };
  ~Siv () {};

};


#endif

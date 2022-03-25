/*//////////////////////////////////<**|**>///////////////////////////////////
//                             vec.h 
//		          
//    @comment  Vec class - inherits from Siv 
//    @release   CARBON  
//    @vers 1.5 B 6.3.87 C-Li-Fr 
//    @date 02/23/2022 08:45:43    
//    @cdate Sun Nov 22 21:54:12 2020    
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2022 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

  
                                           

#ifndef _VEC_H
#define _VEC_H  1

#include <iostream>
#include <type_traits>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <math.h>
#include <ctype.h>
#include <time.h>
#include <signal.h>
#include <string.h>
#include <stdarg.h>
#include <stddef.h>
#include <string.h>
#include <regex.h>
#include <sys/types.h>
#include <sys/errno.h>
#include <sys/stat.h>


#define dbp printf

#define TRUE 1
#define FALSE 0                              

#include "range.h"

const char * dtype (int i);

enum datatype {

  NOT_KNOWN_DTYPE = -3,
  UNKNOWN_TYPE	  = -2,  // max siv.h type is char - use -1 as UNSET
  UNSET  = -1,
  NOTANUM  =  0,        
  CHAR   ,
  CHAR_R   ,  
  CHAR_P   ,    
  SHORT  ,
  SHORT_R  ,
  SHORT_P  ,    
  INT    ,
  INT_R,
  INT_P,
  FLOAT  ,
  FLOAT_R,
  FLOAT_P,
  DOUBLE ,
  DOUBLE_R,
  DOUBLE_P,
  UCHAR  ,
  HEX    ,
  UINT    ,
  USHORT  ,
  LONG    ,
  LONG_R    ,
  LONG_P    ,    
  ULONG   ,
  CMPLX   ,
  DCMPLX  ,
  PCMPLX  ,
  LDCMPLX ,
  LDOUBLE ,
  BOOLEAN ,
  RECORD  ,
  LIST    ,
  VARIABLE,
  FRVALUE ,
  TRUED   ,
  FALSED ,
  THIS     ,  
  HASH     , 
  S64     , 
  U64     ,
  OCTAL  ,
  SCINUM,
  ASCII  ,          /* fixed char - record - size can be declared */
  REAL,
  VOID,
  DLONG,
  GSTRING,   //  vector of chars
  GENERIC ,   // holds anything - converted to anything on assignment */
  GEVENT   , 
  GCONTOUR , 
  SCLASS  ,
  PANSTR  ,
  SIV,
  SIV_R,
  SIV_P,
  STRV     ,  //  svar (size 1)  used to hold variable length vector of chars
  STRV_R,
  STRV_P,      
  SVAR   ,         // array of varchars 
  SVAR_R,
  SVAR_P,  
  PAN    ,          // arbitary precision number - default base 256 
  PAN_R,
  PAN_P,
  OBJ,
  OBJ_R,  
  OBJ_P,    
  VEC,  // always passed as ref
  MAT, // always passed as ref
  PTR     ,   // points to an asl variable - index into array */
  PTR_I,
  PTR_F,
  PTR_D,
  PTR_L,  
  PTR_S,
  PTR_C,
  //  
  MAXTYPE,  // valid type less than MAXTYPE >= 0
};
// 
//
#define CONV_CASE(CT) case CT: return #CT

enum dftype {

  SST =1,
  CSV,
  TSV,
  REC,

};


enum oprtype {
	NON_OP       =  -3,
        MINUS        =  0,
	PLUS,
	LT,
	GT,
	LTE,
	GTE,
	EQV,
	NOT_EQV, 
	EQU,
	MUL,
	DIV ,
	MOD,
	AND,
	NAND,     
	OR  ,
	XOR,          
	EXP,
	NOT ,
	BOR  ,
	BAND ,
	BSR ,      
	BSL ,      
	BXOR,     
	B1COMP ,
	PLUSEQ ,
	MINUSEQ,
	MULEQ,   
	DIVEQ,    
	POST_INC ,
	POST_DECR,
	POWEQ,      
	STRCMP,
	STRCAT,    
	STRCUT,   
	STRDIV,   
	MATMUL,
	LISTINIT,
	UMINUS,
	MATROWCAT,
	MATCOLCAT, 
	PRE_INC  ,
	PRE_DECR,
	PTR_ADDR,
	ADDRESS, 
	IMINUS,    
	IDIV  ,
	UPLUS,
	//
};



using namespace std;





int whatType(char* t);

class Siv;
//class Vec;




class Array {
private:
    int nd;
public:
  void setND(int n) { nd = n;};
  int getND() { return nd;};
  Array() {nd = 0;}
};


template <typename T>
//class Vec : public Siv {
class Vec : public Array {


 public:

  int cols; // number of elements
  T * memp;
  int size;
  int type;
  
  // Aop *aop;  // currently uses parent aop
  // move to vec ??
  Range vrng;

    Vec();
    Vec(int cols);


  //    Vec(int dtype, int ne, double strval, double incrval); // generate series
    Vec(int ne, double strval, double incrval); // generate series  

    Vec(const Vec&);
  //Vec (int dtype) :{...};  anon array fill ?? 

  ~Vec();
  
    void reset( int n);

  void vinit() {
    size = 0;
    memp = NULL;
    type = UNSET;
    setND(1);
  }
  void setType(int wtype) {type = wtype;};
  
  int getType( ) { return type;};
  
  
    Vec& operator = ( double val );

    Vec& operator = ( int val );

    Vec& operator = ( float val[] );

  // Vec& operator = ( const Vec& ) ;

  //    Vec& operator = ( const Mat& ) ;

    Vec& operator = (Vec* v);

  //Vec& operator = ({int a1,...});
  
    void operator += ( const Vec& ) ;

    Vec operator+( Vec& b) ;
  

  //////////////////////////////////////////////////////////////////////////////////

                Vec& operator=(const Vec<int>&);
                Vec& operator=(const Vec<double>&);
                Vec& operator=(const Vec<float>&);
                Vec& operator=(const Vec<short>&);  


  
  
  
  //Vec operator+(const Vec& v);
  

       Vec operator-( Vec& b) {
	   Vec r;
	   vec_sub (this, &b, &r);
	   return r;
	}

     Vec operator*( Vec& b) {
	   Vec r;
	   vec_mul (this, &b, &r);
	   return r; //when deleted? - after operation?
     }

  Vec operator <<= ( Vec& b) {
	   Vec r;
	   vec_cat (this, &b, &r);
	   return r;
     }

    Vec operator+= (int i);
    Vec operator+= (double d);
    Vec operator-= (double d);  
    Vec operator*= (double d);
    Vec operator/= (double d);  

  Vec operator* (double d);
  Vec operator+ (double d);
  Vec operator- (double d);
  Vec operator/ (double d);
  // ?? return a Pan

	// The reference return type is to allow us to assign to it.
       T& operator[](int i);
  
       T operator[] (int i) const;
  

  void * Memp() { void *mp = (void *) memp; return mp;};
  
  double getVal(int i)
  {
      double val;
      
      T *tp = (T *) memp;
        val = (double) tp[i];

       dbp("getval [%d] %f\n",i,val);
	     
       return val ;
  }

  
  // Vec&   operator() (long rng =0);
  // Vec&   operator() (int beg, int end, int stride);  

  /*  
  long getRange() { return vrng.getRange();};
  void setRange(long rng) { vrng.setRange(rng);};
 
  void decodeRange()
  {
   if (getRange() == RALL) {
      vrng.setRange(0, cols-1,1);
    }
    else
      vrng.decodeRange();
  };
  */
//==============================

  double rms();
  Vec stats();
  void Cos();
  void Sin();
  void Tan();
  void Smooth(int wsz);

//==============================


     	 template <class W>
       	 friend std::ostream& operator<< (std::ostream&, const Vec<W>&);
  /*  
template <class W>
  friend Vec operator+(const Vec<W> &v1, const Vec<W> &v2);
  
 // function to output the  object
  template <class W>
        friend ostream& operator << ( ostream&, Vec<W>& ) ;
        friend istream& operator >> ( istream&, Vec<W>& ) ;
  */
};
template <class T>
Vec<T>::Vec()
{
    int wtype= whatType((char *) typeid(T).name());
    //  setType(wtype);
  cols = 1;
  vinit();
#if CDB_FUNC
  DBF("cons id %d c %d\n", getID(),  cols);  //
#endif
  
  // to be setup after  assign /use
  // setRange(-1);
  //setVType(VEC_V);
  reset(cols);
}
//[EF]===========================================//
template <class T>
Vec<T>::Vec(int c)
{
    int ttype= whatType((char *) typeid(T).name());
    vinit();

  type=ttype;
  reset(c);
  cols = size;
#if CDB_FUNC
    DBF("cons id %d wtype %d  ttype %d c %d\n", getID(), wtype, ttype,  c);//
#endif
}
//[EF]===========================================//

template <class T>
Vec<T>::Vec(int ne, double strval, double incrval)
{

    int wtype= whatType((char *) typeid(T).name());
#if CDB_FUNC
  DBP("cons id %d wtype %d  cols %d\n", getID(), wtype,   ne);//
#endif
  vinit() ;
  // setType(wtype);
  cols = ne;
  reset(ne);
  // setCW(SI_ARRAY,ON);
  
  // setup Aop in base Siv class
  // setND(1);
  // ReallocMem (wtype, size);
  // initBounds(1);
  // setBounds(0,cols);
  // setRange(-1);
  
  //setVType(VEC_V);
   t_vset( (T)0, memp,size, strval,incrval);

  
}
//[EF]===========================================//



template <class T>
Vec<T>::~Vec()
{

  // dbt("destructing id %d type %s %p\n", getID(),dtype(getType()),Memp());  
  delete memp;
  //FreeMem(0);
 // setMemp(NULL);
  
  
}
//[EF]===========================================//

 template <class T>
	T& Vec<T>::operator[] (int index) {
			return memp[index];
	}

 template <class T>
	T Vec<T>::operator[] (int index) const {
			return memp[index];
	}


/////////////////////////////////////////////////////////////////////////////////////////

	template <class T>
	std::ostream& operator<< (std::ostream& os, const Vec<T>& v) {
		for (int i = 0; i < v.size; i++) {
			os << v.memp[i];
			if (i < v.size - 1) os << ", ";
		}
		return os;
	}




/// data == Memp

template < class T, class W> int

tcopy(Vec<T> *v, const Vec<W> *x)
{

  			if (v->size != x->size) {
				// if our target array isn't the same size
				// as the target's, then we delete ours and
				// get one that is the correct size.
				delete [] v->memp;
				v->size = x->size;
				v->memp = new T[v->size];
			}
			for (int i = 0; i < v->size; i++)
			  v->memp[i] = (T) x->memp[i];


			return v->size;
}

template <class T>
	Vec<T>& Vec<T>::operator=(const Vec<float>& right) {
          if ((void *) this != (void *) &right) {
             tcopy(this,  &right);
      }

   return *this;
}

template <class T>
	Vec<T>& Vec<T>::operator=(const Vec<int>& right) {
         if ((void *) this != (void *) &right) {
          tcopy(this,  &right);
         }
		return *this;
}

template <class T>
	Vec<T>& Vec<T>::operator=(const Vec<short>& right) {
         if ((void *) this != (void *) &right) {
          tcopy(this,  &right);
         }
		return *this;
}




// mscan
template < class X > int
mscan (char *mem, int offset, X *var)
{
  mem += offset;
 *var = (X) *(X *) mem; 
 return 1;
}
//[ET]===================================//


///         veccopy

template < class X > int
veccopy (X *tovec, X *frvec, int n)
{
  if (n <=0)
    return 0;
  // no check of array bounds 
  for (int i= 0; i < n ; i++)
    tovec[i] = frvec[i];
  return 1;
}
//[ET]===================================//
template < class X > int
vecswapele (X *vec,  int j, int k)
{
  X tmp;
  if (j <0)
    return 0;
  if (k <0)
    return 0;

  tmp = vec[j];
  vec[j] = vec[k];
  vec[k] = tmp;
  
  // no check of array bounds 
  return 1;
}
//[ET]===================================//
template < typename X > void
t_vout(X tval, ostream &strm, void *memp, int size)
{
  X *tp = (X *) memp;
      for (int i= 0; i < size; i++)
	strm << "  " << tp[i]  ;
      strm << endl;
}
//[ET]===================================//

template < typename X > void
t_vset(X tval,  void *memp, int size,double strval, double incrval)
{
  X *tp = (X *) memp;
  double val = strval;
  for (int i= 0; i < size; i++) {
    tp[i] = (X) val;
    val += incrval;
  }
}
//[ET]===================================//

template < class X > void
assignD(X tval, void *memp, int size,double val)
{
  X *tp = (X *) memp;
      for (int i= 0; i < size; i++)
	tp[i] = (X) val;
}

//[ET]===================================//
template < class X > void
rangeSetD(X tval, void *memp, int size,int beg, int end, int stride,double val)
{
  X *tp = (X *) memp;

  //  need a circular buffer form 
  if (beg >=0 && end >= beg && stride < size) {
    int j = beg;
    while (j <= end) {
        	tp[j] = (X) val;
		j += stride;
    }
  }
}

//[ET]===================================//
template < class X > void
rangeSetI(X tval, void *memp, int size,int beg, int end, int stride,int val)
{
  X *tp = (X *) memp;

  //  need a circular buffer form 
  if (beg >=0 && end >= beg && stride < size) {
    int j = beg;
    while (j <= end) {
        	tp[j] = (X) val;
		j += stride;
    }
  }
}
//[ET]===================================//
template < class X  > void
rangeSetColsToVal(X tval, void *memp, int tosize, Range *tor,double val)
{
  X *tp = (X *) memp;
  
  //  need a circular buffer form 
  if (tor->start >=0 && tor->end >= tor->start && tor->stride < tosize) {
    int j = tor->start;
    //dbp("tor  b %d e %d s %d\n",tor->start,tor->end ,tor->stride);
    while (j <= tor->end) {
      tp[j] = (X) val;
      j += tor->stride;
      }
    }
}


//[ET]===================================//

template < class X  > bool
rangeEqnColsToVal(X tval, void *memp, int tosize, Range *tor,double val)
{
  X *tp = (X *) memp;
  bool ret = TRUE;
  //  need a circular buffer form 
  if (tor->start >=0 && tor->end >= tor->start && tor->stride < tosize) {
    int j = tor->start;
    dbp("EQN?  b %d e %d s %d\n",tor->start,tor->end ,tor->stride);
    while (j <= tor->end) {
      if (tp[j] != (X) val) {
        ret = FALSE;
         break;
        }
        j += tor->stride;
      }
    }
  return ret;
}
//[ET]===================================//

template < class X, class Y > void
rangeSetVec(X tval, void *memp, int tosize,Range *tor,Y yval, void *frmemp, Range *frr)
{
  X *tp = (X *) memp;
  Y *frp = (Y *) frmemp;
  Y val;
  //  need a circular buffer form 
  if (tor->start >=0 && tor->end >= tor->start && tor->stride < tosize) {
    int j = tor->start;
    int k = frr->cindex;
    //dbp("rangeSetVec frr  b %d e %d s %d ci %d\n",frr->start,frr->end ,frr->stride,frr->cindex);
    // DBT("tor  b %d e %d s %d\n",tor->start,tor->end ,tor->stride);
    while (j <= tor->end) {
      //dbp ("tor j %d frr k %d\n",j,k);
      val = frp[k];
      tp[j] = (X) val;
      j += tor->stride;
      k += frr->stride;
      if (k >=  frr->ne) {
	break;
      }
    }
  }
}
//[ET]===================================//
template < class X > double
Trms(X tval, void *memp, int vsize,Range *tor)
{
  X *tp = (X *) memp;
  //  need a circular buffer form 
  double total = 0.0;
  double rms = 0.0;

  if (tor->validate() > 0) {
  
  if (tor->start >=0 && tor->end >= 0 && tor->stride < vsize) {
    int j = tor->start;

    // DBT("tor  b %d e %d s %d\n",tor->start,tor->end ,tor->stride);

    int k = 0;
    int passed= 0;
    while (1) {
      //   dbp ("tor j %d     k %d\n",j,k);
      total += (tp[j] *tp[j]);

      passed =circular_address (j,tor->stride , vsize, tor->end);
      k++;
      if (passed || k > vsize)
	break;
    }

    
    double mean = total/(k*1.0);
    rms = sqrt(mean);
  }
  }
  return rms;
}
//[ET]===================================//
template < class X > 
void Tstats(X tval, void *memp, int vsize,Range *tor,Vec<double> *st)
{
  //  need a circular buffer form 
  X *tp = (X *) memp;

  double total = 0.0;
  double ss, ave, sd, sum, var, max, min, rms;
   int maxi, mini;
  sd = var = 0.0;
  max = min = 0.0;
  sum = 0.0;
  ss = 0.0;
  
  double *S= (double *) st->Memp();

  if (tor->validate() > 0) {
  
  if (tor->start >=0 && tor->end >= 0 && tor->stride < vsize) {
    int j = tor->start;

    int i = 0;
    int passed= 0;
    while (1) {
      //   dbp ("tor j %d     k %d\n",j,k);
      total += (tp[j] *tp[j]);

      passed =circular_address (j,tor->stride , vsize, tor->end);
              min = tp[i];
	      max = tp[i];
	      mini = i;
	      maxi = i;
	  sum += tp[i];
	  ss += tp[i] * tp[i];
       if (tp[i] < min)
	    {
	      min = tp[i];
	      mini = i;
	      // dbp("setting min %f  mini %d \n",min,mini);
	    }
	  if (tp[i] > max)
	    {
	      max = tp[i];
	      maxi = i;
	    }
      i++;
      if (passed || i > vsize)
	break;
    }
    if (i > 0) {
      ave = sum / (double) i;

      S[0] = sum;
      S[1] = ave;
      S[2] = ss;

      var = ss / (float) i - (ave * ave);
      rms = sqrt (ss / (float) i);
      S[3] = var;
       sd = sqrt (((ss - (i * ave * ave)) / (float) (i - 1)));
       S[4] = min;
      S[5] = min;
      S[6] = max;
      S[7] = mini;
      S[8] = maxi;
      S[10] = rms;
      S[11] = i;
    }


  }
  }

}
//[ET]===================================//


template <class T>
void Vec<T>::reset( int newSize)
{


  dbp("reset  size %d newsize %d\n",size,newSize);
  // reset  type and size for this vec
  // probably can't do this

if (newSize > size) {
			T* newData = new T[newSize];
			for (int i = 0; i < size; ++i)
				newData[i] = memp[i];
			delete [] memp;
			memp = newData;
			size = newSize;
		}

  
  /*  
  setType(wtype);
  cols = n;
  setCW(SI_ARRAY,ON);
  size = cols;
  // setup Aop in base Siv class
  setND(1);
  ReallocMem (wtype, size);
  dbt("reset id %d %s size %d mp %p\n",getID(),dtype(getType()),size,getMemp());
  initBounds(1);
  setBounds(0,cols);
  setRange(-1);
  setVType(VEC_V);
  */
}
//[EF]===========================================//



//Vec  setVec  ( const Mat& );

/*
int vec_add (Vec *a, Vec *b, Vec *r);
int vec_sub (Vec *a, Vec *b, Vec *r);
int vec_mul (Vec *a, Vec *b, Vec *r);
int vec_cat (Vec *a, Vec *b, Vec *r);
*/



#endif

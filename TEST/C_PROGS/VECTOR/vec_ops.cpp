/*//////////////////////////////////<**|**>///////////////////////////////////
//                          vec_ops.cpp 
//		          
//    @comment  Vec class operators and member functions 
//    @release   CARBON       
//    @vers 1.6 C Carbon 6.3.95 C-Li-Am 
//    @date 03/16/2022 19:09:07    
//    @cdate Sun Nov 22 21:49:50 2020     
//    @author: Mark Terry                                  
//    @Copyright   RootMeanSquare - 1990,2022 --> 
//  
// ^.  .^ 
//  ( ^ ) 
//    - 
///////////////////////////////////<v_&_v>//////////////////////////////////*/ 

  


//#include "vec_ops.h"

#include "vect.h"


void
Range::Reset ()
{
  //  DBF (" B4 reset start %d end %d stride %d \n", start, end, stride);
  start = end = cindex = 0;
  stride = 1;
  ne = 1;
  cw = 0;
  rc = inv = gotstart = gotend = gotstride = 0;
};
//[EF]===========================================//

const char * dtype (int i)
{
  switch (i)
    {
    case NOT_KNOWN_DTYPE:
    CONV_CASE(UNKNOWN_TYPE);
    CONV_CASE(GENERIC);
    CONV_CASE(ASCII);
    CONV_CASE(CHAR);
    CONV_CASE(SHORT);
    CONV_CASE(USHORT);
    CONV_CASE(INT);
    CONV_CASE(UINT);
    CONV_CASE(LONG);
    CONV_CASE(DLONG);    
    CONV_CASE(ULONG);
    CONV_CASE(FLOAT);
    CONV_CASE(DOUBLE);
    CONV_CASE(CMPLX);
    CONV_CASE(DCMPLX);
    CONV_CASE(PCMPLX);
    CONV_CASE(SVAR);
    CONV_CASE(STRV);
    CONV_CASE(UCHAR);
    CONV_CASE(HEX);
    CONV_CASE(GSTRING);
    CONV_CASE(PAN);
    CONV_CASE(REAL);
    CONV_CASE(VARIABLE);
    CONV_CASE(UNSET);
    CONV_CASE(PTR);
    CONV_CASE(SCLASS);
    CONV_CASE(RECORD);
    CONV_CASE(LIST);
    CONV_CASE(HASH);
    CONV_CASE(GEVENT);
    CONV_CASE(GCONTOUR);
    CONV_CASE(SIV);
    CONV_CASE(VOID);
    CONV_CASE(VEC);
    CONV_CASE(MAT);
    CONV_CASE(PTR_I);
    CONV_CASE(PTR_F);
    CONV_CASE(PTR_D);
    CONV_CASE(PTR_S);
    CONV_CASE(PTR_C);                            
    }

  return ("NOT_KNOWN_DTYPE");
}
//========================================

int whatType(char* t)
{
  int wtype = INT;
      printf("type %s\n",t);
  if (strcmp(t,"i") == 0) {
    printf(" int type\n");
    wtype = INT;
  }
  else if (strcmp(t,"f") == 0) {
    printf(" float type\n");
    wtype = FLOAT;
  }
      if (strcmp(t,"d") == 0) {
    printf(" double type\n");
    wtype = DOUBLE;
  }
    
      return wtype;
}
//============================//






/*

template <class T>
Vec<T>Vec(int wtype,int ne, double strval, double incrval)
{
#if CDB_FUNC
  DBP("cons id %d wtype %d  cols %d\n", getID(), wtype,   ne);//
#endif
  
  setType(wtype);
  cols = ne;
  setCW(SI_ARRAY,ON);
  size = cols;
  // setup Aop in base Siv class
  setND(1);
  ReallocMem (wtype, size);
  initBounds(1);
  setBounds(0,cols);
  setRange(-1);
  
  setVType(VEC_V);

  switch (getType())
    {
    case INT:  
    case UINT:
      t_vset( (int)0, Memp(),size, strval,incrval);
      break;
    case DOUBLE:
      t_vset( (double)0, Memp(),size, strval,incrval);
      break;
    case FLOAT:
      t_vset( (float)0, Memp(),size, strval,incrval);
      break;
    case CHAR:
    case UCHAR:      
      t_vset( (char)0, Memp(),size, strval,incrval);
      break;                  
    default:
      DBE("%s not coded!\n", Dtype());
    }
  
}
//[EF]===========================================//
*/

/*
int vec_add (Vec *a, Vec *b, Vec *r)
{
  ///
  ///
  ///
  int ret = 0;


#if CDB_FUNC
  DBF("a  cols %d b cols %d\n",a->cols,b->cols);//
#endif
  
  // if ( a->cols == b->cols  && a->getType() == b->getType() )
    {
      
       r->setType(a->getType());
       r->ReallocMem(b->size);
       r->cols = b->cols;
       r->size = a->size;
#if CDB_FUNC       
       DBF("making r r cols %d  size %d \n",r->cols, r->size);
#endif

       // need template addvec <class T, class R>
       if (a->getType() == DOUBLE  && b->getType() == INT) {
	 double *rip = (double *) r->Memp();
	 double *aip = (double *) a->Memp();
	 int *bip = (int *) b->Memp();	 	 

	 for (int j = 0; j < r->size; j++) {
	   rip[j] = aip[j] + (double) bip[j];
	   // dbt("r %f  = %f + %f \n",rip[j],aip[j],bip[j]);
	 }
	 ret =1;

	 
       }
       else if (r->getType() == INT) {
	 int *rip = (int *) r->Memp();
	 int *aip = (int *) a->Memp();
	 int *bip = (int *) b->Memp();	 	 

	 for (int j = 0; j < r->size; j++)
	   rip[j] = aip[j] + bip[j];
	 ret =1;
       }
       else if (r->getType() == DOUBLE) {
	 double *rip = (double *) r->Memp();
	 double *aip = (double *) a->Memp();
	 double *bip = (double *) b->Memp();	 	 

	 for (int j = 0; j < r->size; j++) {
	   rip[j] = aip[j] + bip[j];
	   //  dbt("r %f  = %f + %f \n",rip[j],aip[j],bip[j]);
	 }
	 ret =1;
       }
       else if (r->getType() == FLOAT) {
	 float *rip = (float *) r->Memp();
	 float *aip = (float *) a->Memp();
	 float *bip = (float *) b->Memp();	 	 

	 for (int j = 0; j < r->size; j++) {
	   rip[j] = aip[j] + bip[j];
	   //  dbt("r %f  = %f + %f \n",rip[j],aip[j],bip[j]);
	 }
	 ret =1;
       }       
  }
  
  return ret;

}
//[EF]===========================================//
int vec_sub (Vec *a, Vec *b, Vec *r)
{
  ///
  ///
  ///
  int ret = 0;
#if CDB_FUNC
  DBP("a  cols %d b cols %d\n",a->cols,b->cols);//
#endif
  
  if ( a->cols == b->cols
      && a->getType() == b->getType()
      ) {
      
       r->setType(a->getType());
       r->ReallocMem(a->size);
       r->cols = b->cols;
       r->size = a->size;

#if CDB_FUNC
       dbp("r cols %d  size %d \n",r->cols, r->size);//
#endif
       

       // need template
       if (r->getType() == INT) {
	 int *rip = (int *) r->Memp();
	 int *aip = (int *) a->Memp();
	 int *bip = (int *) b->Memp();	 	 

	 for (int j = 0; j < r->size; j++)
	   rip[j] = aip[j] - bip[j];
	 ret =1;
       }
  }
  
  return ret;

}
//[EF]===========================================//



int vec_mul (Vec *a, Vec *b, Vec *r)
{
  ///
  ///
  ///
  int ret = 0;
  //dbp("a  cols %d b cols %d\n",a->cols,b->cols);
  if ( a->cols == b->cols
      && a->getType() == b->getType()
      ) {
      
       r->setType(a->getType());
       r->ReallocMem(a->size);
       r->cols = b->cols;
       r->size = a->size;
       //    dbt("r cols %d  size %d \n",r->cols, r->size);
       // need template
       if (r->getType() == INT) {
	 int *rip = (int *) r->Memp();
	 int *aip = (int *) a->Memp();
	 int *bip = (int *) b->Memp();	 	 

	 for (int j = 0; j < r->size; j++)
	   rip[j] = aip[j] * bip[j];
	 ret =1;
       }
  }
  
  return ret;
}

//[EF]===========================================//

int vec_cat (Vec *a, Vec *b, Vec *r)
{
  ///
  ///
  ///
  int ret = 0;
  DBF("a  cols %d b cols %d\n",a->cols,b->cols);
  if ( a->getType() == b->getType() ) {
      
       r->setType(a->getType());
       r->ReallocMem(a->size+b->size);
       r->cols = a->cols + b->cols;
       r->size = a->size +b->size;
#if CDB_FUNC
       DBF("r cols %d  size %d \n",r->cols, r->size);//
#endif
       
       // need template
         void *rmp =  r->Memp();
	 int nb = a->size * a->Sizeof();
	 memcpy(rmp,a->Memp(), nb);
	 rmp += nb;
	 nb = b->size * b->Sizeof();
	 memcpy(rmp,b->Memp(), nb);

	 ret =1;
       
  }
  
  return ret;
}
*/
//[EF]===========================================//
/*
template <class T>
Vec& Vec<T>::operator() (long rngval)
{
  //
  if (rngval == 0) {
    vrng.start= 0;
    vrng.end= -1;
    vrng.stride= 1;
    vrng.range = -1;
  }
  else
    vrng.setRange(rngval);
#if CDB_FUNC
  dbp ("vec func set range = %ld\n",vrng.getRange());//
#endif
  

  
  return *this;
}

//[EF]===========================================//
template <class T>
Vec<T>&   Vec<T>::operator() (int start, int end, int stride)
{

  vrng.start= start;
  vrng.end= end;
  vrng.stride= stride;
      vrng.range = -2;
#if CDB_FUNC
      dbp("set vrng %d %d %d \n", vrng.start,  vrng.end,  vrng.stride);
#endif  
  return *this;
}
//[EF]===========================================//
*/
template <class T>
Vec<T>& Vec<T>::operator = ( int val )
{
  //
  // use template
  // 
  // not array and is a number
  

  //  is array - range >= 0
  //  vector set the element V[range] - check bounnds
  //  range < -1 - extract range start stop step - and set
  //  matrix extract ele0,ele1 -  or range0, range1 and set
#if CDB_FUNC  
  DBP ("Vec range = %ld  set val %d\n",range, val);
  // dbp("Vec info %s\n",infoV());
#endif
  //long rng = getRange();
  long rng = 1;   
 if ( rng >= 0) {

           T *tp = (T *) Memp();

        tp[rng] = (T) val;
 }
 /*
 else if ( rng < 0) {

   // decode the range

   // decodeRange();

#if CDB_FUNC
   dbp ("Vec size %d set  range (%d,%d,%d) to= %ld\n",size,vrng.start,vrng.end,vrng.stride, val);//
#endif
   
   if (vrng.end >= size) {
     vrng.end = size;
   }

   if (vrng.end < 0) {
     vrng.end = size+vrng.end;
   }

   rangeSetI ((T) 0, Memp(), size,vrng.start,vrng.end,vrng.stride,val);

 }
 */
 /*
 else {
   // scalar set
   if (getType() == UNSET) {
     setType(INT);
     ReallocMem(1);

   }
 
           T *tp = (T *) Memp();
        *tp = (T) val;

  } 
 */
//  setRange(RALL);   // set back to default
   


   return ( *this ) ;
}
//[EF]===========================================//
template <class T>
Vec<T>& Vec<T>::operator = ( double val )
{
  // use template

  // not array and is a number
  

  //  is array - range >= 0
  //  vector set the element V[range] - check bounnds
  //  range < -1 - extract range start stop step - and set
  //  matrix extract ele0,ele1 -  or range0, range1 and set
  
  // dbp ("Vec range = %ld  set val %f\n",range, val);
  // dbp("Vec info %s\n",infoV());

  // long rng = getRange();
   long rng = 1;   
 if ( rng >= 0) {


        T *tp = (T *) Memp();

        tp[rng] = (T) val;

 }
 /*
 else if ( rng < 0) {

   // decode the range

   // decodeRange();

#if CDB_FUNC
   dbp ("Vec size %d set  range (%d,%d,%d) to= %ld\n",size,vrng.start,vrng.end,vrng.stride, val);//
#endif
   
   if (vrng.end >= size) {
     vrng.end = size;
   }

   if (vrng.end < 0) {
     vrng.end = size+vrng.end;
   }

   rangeSetI ((T) 0, Memp(), size,vrng.start,vrng.end,vrng.stride,val);
 }



   
  setRange(RALL);   // set back to default
 */
   return ( *this ) ;
}
//[EF]===========================================//

/*
template <class T>
Vec<T>& Vec<T>::operator = (const Vec<T>& v)
{

  ///
  /// this will  set/copy vector arrays scalars
  ///

  if (this != &v)
    {
      try
      {
#if CDB_FUNC	
	DBF("this = const v this range %d v_range %d  RALL %d\n",getRange(),v.getRange(),RALL) ;

	DBF("const gettype %d\n",getType());
	
	DBF("this range %d    v.range  %d\n",getRange(), v.getRange() );
#endif	
	if (getRange() == RALL  && v.getRange() == RALL) {

          // copy over entire vector --
	  // data types same? convert
	  // sizes same --

	  if (getType() == UNSET  ||  size != v.size ) {
	    setType(v.getType());
	    ReallocMem(v.getSize());
	    // copy entire vec


	  }

	  // unless this is fixed size  resize
	  if (size == v.size && getType() == v.getType()) {
	    //dbt("copy entire vec  - same types \n");

           memcpy(Memp(),v.Memp(), v.size * v.Sizeof());
	    

	  }
	  // convert ?
	  
	}
	else if ((getRange() < -1)  && (v.getRange() < -1)) {
            // setting a sub-range from a sub-range
	    dbt("const setting a sub-range from a sub-range\n");
	    vrng.decodeRange();
	    v.vrng.decodeRange();
	    Range *fr_rng = &v.vrng;
            // decode the ranges
	      fr_rng->ne = v.cols;
	      fr_rng->cindex = fr_rng->start;
	    if (size == v.size && getType() == v.getType()) {
	      // use range obj
	      if (getType() == INT)
	        rangeSetVec((int) 0, Memp(), size,&vrng,(int) 0, v.Memp(), fr_rng);
	      else if (getType() == DOUBLE)
		rangeSetVec((double) 0,Memp(), size,&vrng,(double) 0, v.Memp(), fr_rng);
	      else if (getType() == CHAR || getType() == UCHAR)
		rangeSetVec((char) 0,Memp(), size,&vrng,(char) 0, v.Memp(), fr_rng);	      
		

	    }
	    // reset v.range ? to -1

	}

	    vrng.setRange(-1);	
      }


      catch (int ball)
      {


      }
      
       setRange(-1);	

    }

  return (*this);
}
//[EF]===========================================//
*/
/*
template <class T>
Vec<T> & Vec<T>::operator = (Vec* v)
{

  ///
  /// this will  set/copy vector arrays scalars
  ///

  if (this != v)
    {
      try
      {
		dbt(" this range %d v_range %d  RALL %d\n",getRange(),v->getRange(),RALL) ;
#if CDB_FUNC
	dbp(" this range %d v_range %d  RALL %d\n",getRange(),v->getRange(),RALL) ;
	dbp("gettype %d\n",getType());
#endif	
	if (getRange() == RALL  && v->getRange() == RALL) {

          // copy over entire vector --
	  // data types same? convert
	  // sizes same --

	  if (getType() == UNSET) {
	    setType(v->getType());
	    ReallocMem(v->getSize());
	    // copy entire vec
	    dbt("realloc to %d\n",v->getSize());

	  }
	  // else if (size == v->size && getType() == v->getType()) {
	   if (getType() == v->getType() && size >= v->size) {
	   // copy entire vec
	     dbt("copy entire ? after size %d %d ?\n",size,v->size);
             memcpy(Memp(),v->Memp(), v->size * v->Sizeof());
	  }
	  // convert ?
	  
	}
	else if ((getRange() < -1)  && (v->getRange() < -1)) {
            // setting a sub-range from a sub-range
	    vrng.decodeRange();
	    v->vrng.decodeRange();
	    Range *fr_rng = &v->vrng;
            // decode the ranges
	      fr_rng->ne = v->cols;
	      fr_rng->cindex = fr_rng->start;
	    if (size == v->size && getType() == v->getType()) {
	      // use range obj
	      if (getType() == INT)
	        rangeSetVec((int) 0, Memp(), size,&vrng,(int) 0, v->Memp(), fr_rng);
	      else if (getType() == DOUBLE)
		rangeSetVec((double) 0,Memp(), size,&vrng,(double) 0, v->Memp(), fr_rng);
	      else if (getType() == FLOAT)
		rangeSetVec((float) 0,Memp(), size,&vrng,(float) 0, v->Memp(), fr_rng);	      
	      else if (getType() == CHAR || getType() == UCHAR)
		rangeSetVec((char) 0,Memp(), size,&vrng,(char) 0, v->Memp(), fr_rng);	      
		

	    }
	    // reset v->range ? to -1

	}

	    vrng.setRange(-1);	
      }


      catch (int ball)
      {


      }
      
       setRange(-1);	

    }

  return (*this);
}
*/
//[EF]===========================================//
/*
template <class T>
Vec<T> setVec ( const Mat& m)
{
  //
  // select subset of Mat to put into vector
  //
  Vec tmp;
  
            m.decodeRowRange();
	    m.decodeColRange();
            tmp.setType(m.getType());
	     void *row_mp = m.Memp();
	     void *vec_mp = tmp.Memp();
	     int sz = m.Sizeof();
	     tmp.cols = 0;
	     for (int r = m.rng_rows.start ; r <= m.rng_rows.end ; r += m.rng_rows.stride)
	      {

		tmp.cols += m.cols;
		//dbp ("setVec r %d tmp.cols %d\n",r,tmp.cols);
		tmp.ReallocMem((r+1) * m.cols);
		row_mp += (r * m.cols * sz);	
                vec_mp = tmp.Memp() + (r * m.cols * sz);
                memcpy(vec_mp,row_mp,( m.cols * sz));

	      }

	     return tmp ;   // when will this get deleted?

}
//[EF]===========================================//
template <class T>
Vec & Vec<T>::operator = (const Mat & m)

{
  
#if CDB_FUNC
  DBF("V %s\n",this->infoV());
  dbp("V  cols %d\n",cols);//	
  dbp("M %s\n",m.infoV());//
  dbp("M rows %d cols %d\n",m.rows,m.cols);//
#endif	 
            m.decodeRowRange();
	    m.decodeColRange();
	    // tmp.setType(m.getType());
	     void *row_mp = m.Memp();
	     void *vec_mp = Memp();
	     int sz = m.Sizeof();
	     int vsz = cols;
	     int need_cols=0;
	     int jr =0;

	     //dbp("mrows  b %d e %d s %d\n",m.rng_rows.start,m.rng_rows.end ,m.rng_rows.stride);
	     //dbp("mcols  b %d e %d s %d\n",m.rng_cols.start,m.rng_cols.end ,m.rng_cols.stride);
	     
	     for (int r = m.rng_rows.start ; r <= m.rng_rows.end ; r += m.rng_rows.stride)
	      {
		need_cols = (jr+1) * m.cols;
                if (need_cols > cols) {
		ReallocMem(need_cols);
                cols = need_cols;
                 dbp ("V <=M  r %d cols %d  sz %d\n",r,cols,getSize());
		}
		
		row_mp = m.Memp(r * m.cols);	
                vec_mp = Memp(jr * m.cols);
                memcpy(vec_mp,row_mp,( m.cols * sz));
                jr++;
	      }
	     //	dbp ("setVec  cols %d  sz %d\n",cols,getSize());

  /// will this work 
	     //  Vec tmp;
	     //tmp = setVec(m);
	     //dbp("tmp cols %d  sz %d\n",tmp.cols,tmp.getSize());
  ///*this = tmp;

#if CDB_FUNC
	     dbp("Vec this = Mat cols %d   sz %d  %d \n",this->cols, this->getSize(), (char) (char *) Memp());//
#endif
	     
    return (*this);
}
//[EF]===========================================//
*/
/*
ostream& operator << ( ostream &strm, Vec<T> &x )
{
  // dbt(" ostream Vec\n");
  if (x.isNumberType()) {
      if (x.getType() == INT) {
	t_vout( (int) 0,strm, x.Memp(), x.size);
      }
      else if (x.getType() == CHAR || x.getType() == UCHAR) {
	t_vout( (char) 0,strm, x.Memp(), x.size);
      }      
      else if (x.getType() == SHORT) {
	t_vout( (short) 0,strm, x.Memp(), x.size);
      }      
      else if (x.getType() == DOUBLE) {
	t_vout( (double) 0,strm, x.Memp(), x.size);      
      }
      else if (x.getType() == FLOAT) {
	t_vout( (float) 0,strm, x.Memp(), x.size);      
      }
      else if (x.getType() == LONG) {
	t_vout( (long) 0,strm, x.Memp(), x.size);      
      }            
    }
}
*/
//[EF]===========================================//
template <class T>
double Vec<T>::rms()
{
  ///
  ///  compute rms
  ///
  //vrng.sivp = this;
  // whole vector
  // decodeRange();
  
  long rng = getRange();
  double rmsval =0.0;
  int dir = vrng.validate();
  if (dir != 0) {
    rmsval = Trms((T) 0, Memp(), size, &vrng);
  }

  
  // specified range
  return rmsval;
}
//[EF]===========================================//

template <class T>
Vec<T> Vec<T>::stats()
{
  Vec<double> st (12);
  //   vrng.sivp = this;
  // whole vector
  // decodeRange();
  
  //long rng = getRange();

  int dir = vrng.validate();
  if (dir != 0) {

    Tstats((T) 0, Memp(), size, &vrng,&st);
  }
  
  
  
  return st;
}
//[EF]===========================================//

template < class X, class Y > void
vec_sop( X* v, Y b, int op, int sz)
{
#if CDB_FUNC  
  DBF("sop op %d %s sz %d\n",op,optype(op),sz);//
#endif 
  X a;
  for (int i= 0; i < sz ;i++) {
    a= *v;
   switch (op)
    {
    case MUL:
      a *= b;
      break;
    case DIV:
      a /= b;
      break;
    case PLUS:
      a += b;
      break;
    case MINUS:
      a -= b;
      break;
    case IMINUS:
      a = b - a;
      break;
    case IDIV:
      a = b / a;
      break;
    case MOD:
      a = (int) a % (int) b;
      break;
    case EXP:
      {
	double pr;
	pr = pow ((double) a, (double) b);
	a = (X) pr;
      }
      break;
   }
   *v=a;
   v++;
  }


}
//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator+=(double d)
{
  dbt("*=  vec %s d %f\n",dtype(getType()),d);

    T *tp = (T*) Memp();
    vec_sop(tp,d,PLUS, size);
 
  return *this;
}
//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator-=(double d)
{
  //dbt("*=  vec %s d %f\n",dtype(getType()),d);
     T *tp = (T *)Memp();
    vec_sop(tp,d,MINUS, size);

  return *this;
}
//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator+=(int val)
{
#if CDB_FUNC  
  DBF("+= val %d\n",val);//
#endif
  
     T *tp = (T *)Memp();
    vec_sop(tp,val,PLUS, size);
  
  return *this;
}
//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator*=(double d)
{
#if CDB_FUNC
 DBP("*=  vec %s d %f\n",dtype(getType()),d);
#endif  
     T *tp = (T *)Memp();
    vec_sop(tp,d,MUL, size);

  return *this;
}
//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator/=(double d)
{ 
   dbp("*=  vec %s d %f\n",dtype(type),d);
  if (d != 0.000) {

     T *tp = (T *)Memp();
    vec_sop(tp,d,DIV, size);
  }
  else {
   dbp("div by zero !! %f\n",d);
  }
  return *this;
}
//[EF]===========================================//
/*
Vec operator+(const Vec &v1, const Vec &v2) {

  Vec v;   // Construct a temporary vector to hold the sum
  dbt(" tmp vec + vec\n");
  v.pinfo();
  if(v1.size != v2.size){
    cerr << "FATAL vector::operator+(const vector &, const vector&) size mismatch: ";
    cerr << v1.size << " " << " != " << v2.size << "\n";
    //  exit(1);
  }
  else {
    
    
    vec_add(&v1,&v2,&v);
  }
  return v;
  
}
*/
//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator*(double d) {

  Vec<T> tmp(cols);


  T *tp = (T*) tmp.Memp();
  T *fp = (T *) Memp();

  // type is not double then we have
  // demote/promote tmp Vec to suit ?
  
  for (int i=0; i< cols; i++)
    *tp++ = d * *fp++;
  
    
      return tmp;
}

//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator+(double d) {

    Vec<T> tmp(cols);
    
  T *tp = (T *) tmp.Memp();
  T  *fp = (T *) Memp();
  
  for (int i=0; i< cols; i++)
    *tp++ = d + *fp++;
  

  
      return tmp;

}

//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator+( Vec& v) {

  Vec<T> tmp(cols);
  tmp.pinfo();
  //  printf(" op + Vec %s %s\n",dtype(getType()),dtype(v.getType()));

  // need a template ? T and ?? v type
  
  /*
  if (getType() == DOUBLE) {

  double *tp = (double *) tmp.Memp();
  double *fp = (double *) v.Memp();
  double *hp = (double *) Memp();
  
  for (int i=0; i< cols; i++)
    *tp++ = *hp++ + *fp++;
  }
  else if (getType() == INT) {

  int *tp = (int *) tmp.Memp();
  int *fp = (int *) v.Memp();
  int *hp = (int *) Memp();
  
  for (int i=0; i< cols; i++)
    *tp++ = *hp++ + *fp++;
  }
  */

  
      return tmp;

}

//[EF]===========================================//

template <class T>
Vec<T> Vec<T>::operator-(double d) {

   Vec<double> tmp(cols);
  double *tp = (double *) tmp.Memp();
  T *fp = (T *) Memp();
  
  for (int i=0; i< cols; i++) {
    *tp++ = *fp - d ;
     *fp++;
  }
      return tmp;
}

//[EF]===========================================//
template <class T>
Vec<T> Vec<T>::operator/(double d) {

  Vec<double> tmp(cols);
  double *tp = (double *) tmp.Memp();
  T *fp = (T *) Memp();
  if (d != 0.0) {
  for (int i=0; i< cols; i++) {
    *tp++ = *fp/d ;
     *fp++;
  }
  }
   return tmp;

}

//[EF]===========================================//
template <class T>
void Vec<T>::Cos()
{

    T *fp = (T *) Memp();
      for (int i=0; i< cols; i++) {
	*fp = cos((double) *fp);
	 fp++;
      }

}
//[EF]===========================================//

template <class T>
void Vec<T>::Sin()
{
  
  T *fp = (T *) Memp();
      for (int i=0; i< cols; i++) {
	*fp = sin((double) *fp);
	 fp++;
      }

}
//[EF]===========================================//

template <class T>
void Vec<T>::Tan()
{

     T *fp = (T *) Memp();
      for (int i=0; i< cols; i++) {
	*fp = tan((double) *fp);
	 fp++;
      }


}
//[EF]===========================================//

template <class T>
void Vec<T>::Smooth(int m)
{

    // mode 1 =   x[n] = (x[n] +x[n+1] + x[n+2] + x[n+m]) / m
     double sum = 0.0;

     T *x = (T *) Memp();


      for (int i=0; i< cols-m; i++) {

         sum = 0.0;
	      for (int j=0; j< m; j++) {
 	       sum +=  x[j] ;
              }
	      x[i] = sum / (m*1.0);
	      
      }

}
//[EF]===========================================//





#if 0
Vec Vec::operator+( Vec& b) {

  Vec r(DOUBLE,b.cols);
	   printf("one operand +? %s\n",r.info());
	   r.pinfo();
	   vec_add (this, &b, &r);
	   return r;

}
#endif

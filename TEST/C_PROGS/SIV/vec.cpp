/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                       vec                      
///   CopyRight   - RootMeanSquare                                 
//    Mark Terry  - 1998 -->                                           
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "defs.h"
#include "vector.h"
#include "debug.h"

int  Floatsz = sizeof(float);
int  Doublesz = sizeof(double);
int  Charsz = sizeof(char);
int  Intsz = sizeof(int);
int  Shortsz = sizeof(short);
int  Longsz = sizeof(long);

template < class X > void vecstore (X * av, Vector *vec, int n)
{
  if (vec->reallocMem (n) == SUCCESS){ 
    X *vp = (X *) vec->memp;
    for (int i = 0; i < n; i++) {
      *vp++ = av[i];
    }
  }
}
//====================================

void Vector::Store (int *vec, int n)

{
  //  check current dtype and size
  //  realloc if needed
  //  cast/convert or warn
  if (dtype == INT) {
    vecstore (vec, this, n);
  }

}
//[EF]===================================================//
void Vector::Store (float *vec, int n)

{
  //  check current dtype and size
  //  realloc if needed
  //  cast/convert or warn
   if (dtype == FLOAT) {
    vecstore (vec, this, n);
    }

}
//[EF]===================================================//
void Vector::Store (double *vec, int n)

{
  //  check current dtype and size
  //  realloc if needed
  //  cast/convert or warn
  if (dtype == DOUBLE) {
    vecstore (vec, this, n);
  }
}
//[EF]===================================================//
void Vector::Store (short *vec, int n)

{
  if (dtype == SHORT ) {
    vecstore (vec, this, n);
  }
}
//[EF]===================================================//
void Vector::Store (long *vec, int n)

{
  if (dtype == LONG ) {
    vecstore (vec, this, n);
  }
}
//[EF]===================================================//
void Vector::Store (char *vec, int n)

{
  if (dtype == CHAR ) {
    vecstore (vec, this, n);
  }
}
//[EF]===================================================//



int Vector::reallocMem(int n)
{
  ///
  ///  for num (int,float) types
  ///

  
  int rtval = SUCCESS;
  int fixup = 0;
  int did_realloc = 0;
  char cname[64];
	
  //	sprintf(cname,"%s",getName());

	// we realloc to change size ( or if type has changed)

    void *vp;
    char *cp;
    int cs =0;  
    uint32_t newmemsize = 0;

    int k,m;



    //DBPF("%s needs %d pieces of mem\n",getName(),n);
    //    ASSERT_SIV(this);
    //DBT(" need %d mbytes memsize %d\n",n ,memsize);
    try {


    if (type == SCLASS || type == LIST) {
      // NOOP
      throw OKTOEXIT;
    }
      
      if (n < 0) {
        DBP("WARNING ReallocMem - noop! size %d\n",n);
        throw ERR2EXIT;
      }   

      if ((memsize > 0)   && ((n+1) * Sizeof()) <= (int) memsize) {
        
        size = n;
  DBPF("%s %d already has enuf mem !need %d items type %s has memsize %d \n",
	     getName(),id, n,Dtype(),memsize);
	
        if (memp != 0) {
	  
	    throw OKTOEXIT;
        }
        else {
          DBP("WARNING id %d bad memp %p memsize? %d \n", id, Memp(), memsize);
	  memsize = 0;
          fixup = 1;
         }
     }
    else {
      DBPF("%s needs more memory %d pieces of mem type %d memsize %d \n",
	   getName(),n,type,memsize);
    }


      /*
    if (isStrType()) {

      DBPF("WARNING SCLASS/SVAR ReallocMem - noop! name %s\n",name);

      if (getValue() == NULL) {
	NewSvar(2);
      }
      
      if (getValue() == NULL) 
	throw ERR2EXIT;

       throw OKTOEXIT;
    }
      */
      

  // Lets FIX RellocMem to leave scalars,size 1 alone for reuse
  // only realloc if size changes > 1  - size 1 has enuf memory always allocated to hold all number types
  // except PAN

    if (type == UNSET) {

      if (n > 1) {
  DBP("WARNING type unset in ReallocMem - noop! name %s size %d n %d memsize %d\n",
      name,size,n, memsize);
      }

      // else we cover at least double size
      // this variable may be via createv and type not yet assigned
      //      dbp("WARNING Forcing type to Float \n" );
      //      type = FLOAT;

      if (memp == 0) {
	// big enuf for a long anyway
	//vp = scalloc_id(64, 1,__FUNCTION__);

	        vp = scalloc_id(64, 1,cname);         
                memp = vp;
                memsize = 64;
      }

      throw OKTOEXIT; // live dangerously --- FIXME

    }


    // if ((testCW(SI_ARRAY) || (n >= 1)) && getpBounds() == NULL) {
    // have to discriminate between scalar and array of size 1
    
      if ( testCW(SI_ARRAY) || (n > 1)) {
        // for vector why not have this done in constructor
	// - should always have space

	if (aop.bounds == NULL) {
	 aop.bounds = (int *) calloc(DEFNBOUNDS, sizeof(int));
        }
	
	if (aop.bounds == NULL) {
	  DBP("bad bounds \n");
	   throw ERR2EXIT;
	}

	aop.setND(1);
	aop.setBounds(0 , n);
	size = n;
	setCW(SI_ARRAY,ON);
    }

    cs = 0;

    if (memp != 0)
	cs = memsize;

    /* this should take care of multi-dimension arrays where n is low-dimension number */
    // don't prevent reallocMem - warn if this is a fixed array size


       if ((!testCW(DYNAMIC_ARRAY) && n > 1 && size > 0)) {
	dbwarning("reallocMem not dynamic array type %s \n", name);
       }



    vp = (void *) memp;

    // we already have Doublesz area of memory allocated on init

    m = n + 1;		// safety one more but not used


    if (memp == 0 && testCW(DYNAMIC_ARRAY)) {
      m  += 10;
      DBPF("initting dynamic array memory to at least 10 pieces \n");
    }


    if (n > 1 || memp == 0 || testCW(DYNAMIC_ARRAY))	
    {


      DBPF("%s REQUIRED %d m %d memp %p   size %d type %s memsize %d\n",
		name, n, m, memp,  size, Dtype(), memsize);

	switch (type) {
	  case GENERIC:
	    newmemsize = (m * Doublesz);
	    break;

	  case DOUBLE:
	    newmemsize = (m * Doublesz);
	    break;

	  case FLOAT:
	    newmemsize = (m * Floatsz);
	    break;

	  case CMPLX:
	    newmemsize = (2 * m * Floatsz);
	    break;

	  case DCMPLX:
	    newmemsize = (2 * m * Doublesz);
	    break;

	  case INT:
	  case UINT:
	    newmemsize = (m * Intsz);
	    break;

	  case SHORT:
	  case USHORT:
	    newmemsize = (m * Shortsz);
	    break;

	  case LONG:
	  case ULONG:
	    newmemsize = (m * Longsz);
	    break;

	  case CHAR:
	  case UCHAR:
	    newmemsize = (n * Charsz);
	    break;

	  case PAN:
	    DBPF("alloc for pan -- not really neeeded\n");
	    newmemsize = (1 * Doublesz);
	    break;

	    
	  default:

	    newmemsize = (m * Doublesz);

  DBP( "ReallocMem %s IDtype %d NOTKNOWN \n",getName(),getID(), type);

            if (type == INT) {
	      //   DBP( "ReallocMem type %d is INT %d\n", type,INT);

            }

	    break;
	}


	DBPF("newmemsize %d  current cs %d \n",newmemsize,cs);


	if (newmemsize > memsize || memp == 0) {

 	    newmemsize += Doublesz; // safety so any type - size 1 can fit without reallocing for
                                  // size 1 (scalar)
	    if (memp == 0) {

	      //vp = scalloc_id(newmemsize, 1,__FUNCTION__);
	      vp = scalloc_id(newmemsize, 1,cname);

		DBPF("did calloc of newmemsize %d  \n",newmemsize);
                

	    }
	    else {

	      DBPF("reallocMem newmemsize %d  memp %d \n",newmemsize,memp);
	      vp = srealloc_id((void *) memp, newmemsize,"siv_realloc");

              DBPF("did realloc of newmemsize %d  \n",newmemsize);
              did_realloc = 1;
            }

	    if (vp != NULL)
		memsize = newmemsize;

	}
    }

    if (vp == NULL) {
      dbp("bad vp for %s n %d\n",getName(),n);
	throw ERR2EXIT;
    }

    memp = vp;

    size = n;
    
    aop.setBounds(0,n);


        DBPF( "ok size now %d %s memp %d size %d offset %d\n", n, name, memp, size, offset);
	//DBT( "ok size now %d %s memp %d size %d offset %d\n", n, name, memp, size, offset);

     

      // we may have changed type prior to allocating so 
      // clear via difference in byte size newmemsize old memsize

    if (did_realloc && ((newmemsize - cs) > 0)) {
     
	    cp = (char *) memp;

	    cp += cs;

	    k = (newmemsize - cs) ;

            DBPF("realloced more %d so clearing new mem ok newmemsize %d cs %d  k  %d to zero\n",did_realloc,newmemsize,cs, k);

	    while (k-- > 0) *cp++ = 0;

	}
	

    //DBPF("%s memp %p  size %d offset %d\n",name, memp, size, offset);


        memsize = newmemsize;
	setCW(SI_FREE,OFF);
    }

    

       catch (int e) {

        if (e == ERR2EXIT) {
	   whatError(MALLOC_ERROR,__FUNCTION__);
           rtval = REALLOC_ERROR;
        }
        else if (e == OKTOEXIT)  {
           rtval = SUCCESS ;
	   setCW(SI_FREE,OFF);	   
        }
       }

    if (fixup) {
   DBP("WARNING %s fixed memp memsize? %d %p\n", getName(),memsize, Memp());
    }     


     DBPF("%s \n",info());
     DBPF("rtval %d  memp %p\n",rtval, Memp());
    
    return (rtval);
}
//[EF]===================================================//
void Vector::Print() {
  
    if (dtype == INT) {
    int *ip = (int *) memp;
         for (int i = 0; i < size; i++)
          {
	    printf("%x,",*ip++);
	  }
    }
    else  if (dtype == FLOAT) {
    float *tp = (float *) memp;
         for (int i = 0; i < size; i++)
          {
	    printf("%f,",*tp++);
	  }
    }
    else  if (dtype == DOUBLE) {
    double *tp = (double *) memp;
         for (int i = 0; i < size; i++)
          {
	    printf("%f,",*tp++);
	  }
    }    
          printf("\n");
}

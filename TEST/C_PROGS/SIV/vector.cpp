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
    //    ASSERT_SIV(this);

    try {
      
      if (n <= 0) {
        DBP("WARNING ReallocMem - noop! size %d\n",n);
        throw ERR2EXIT;
      }   

      if ((memsize > 0) && ((n+1) * Sizeof()) <= (int) memsize) {
        
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
      // DBPF
      DBPS ("%s needs more memory %d pieces of mem dtype %d memsize %d \n",
	   getName(),n,dtype,memsize);
    }
    

    cs = 0;

    if (memp != 0)
	cs = memsize;

    /* this should take care of multi-dimension arrays where n is low-dimension number */
    // don't prevent reallocMem - warn if this is a fixed array size


       if ((!testCW(DYNAMIC_ARRAY) && n > 1 && size > 0)) {
	 dbwarning("reallocMem not dynamic array type %s \n", getName());
       }



    vp = (void *) memp;

    // we already have Doublesz area of memory allocated on init

    m = n + 1;		// safety one more but not used


    if (memp == 0 && testCW(DYNAMIC_ARRAY)) {
      m  += 10;
      DBPS("initting dynamic array memory to at least 10 pieces \n");
    }


    if (n > 1 || memp == 0 || testCW(DYNAMIC_ARRAY))	
    {


      DBPS("%s REQUIRED %d m %d    size %d dtype %d memsize %d\n",
	   getName(), n, m, size, dtype, memsize);

        newmemsize = computeMemSize( m, dtype);

	DBPS("newmemsize %d  current %d \n",newmemsize,cs);


	if (newmemsize > memsize || memp == 0) {

 	    newmemsize += Doublesz;
	    // safety so any type - size 1 can fit without reallocing for
                                  // size 1 (scalar)
	    if (memp == 0) {
	        vp = scalloc_id(newmemsize, 1,cname);

		DBPF("did calloc of newmemsize %d  \n",newmemsize);
                

	    }
	    else {

	      DBPS("reallocMem newmemsize %d  memp %p \n",newmemsize,memp);
	      vp = srealloc_id((void *) memp, newmemsize,"siv_realloc");

              DBPS("did realloc of newmemsize %d newvp %p\n",newmemsize,vp);
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


    DBPS( "ok %s  memp %p size %d \n",  getName(), memp, size);
	
      // we may have changed type prior to allocating so 
      // clear via difference in byte size newmemsize old memsize

    if (did_realloc && ((newmemsize - cs) > 0)) {
     
	    cp = (char *) memp;

	    cp += cs;

	    k = (newmemsize - cs) ;

            DBPS("realloced more %d so clearing new mem ok newmemsize %d cs %d  k  %d to zero\n",did_realloc,newmemsize,cs, k);

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

     DBPS("rtval %d \n",rtval);
    
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
//[EF]===================================================//

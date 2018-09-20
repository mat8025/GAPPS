/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                       array                      
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
#include "matrix.h"
#include "debug.h"



int Matrix::reallocMem(int r,int c)
{
  ///
  ///  for num (int,float) types
  ///
  ///
  ///  for num (int,float) types
  ///
  int rtval = SUCCESS;
  int fixup = 0;
  int did_realloc = 0;
  char cname[64];


  int n = r * c;
  DBPS("matrix realloc r %d c %d n %d  dtype %d\n",r,c,n, getDtype());
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
        DBPF("%s  already has enuf mem !need %d items dtype %d has memsize %d \n",
	     getName(), n, getDtype(),memsize);
	
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
      DBPS("%s needs more memory %d pieces of mem dtype %d memsize %d \n",
	   getName(),n,getDtype(),memsize);
    }
    

    cs = 0;

    if (memp != 0)
	cs = memsize;

    /* this should take care of multi-dimension arrays where n is low-dimension number */
    // don't prevent reallocMem - warn if this is a fixed array size


       if ((!testCW(DYNAMIC_ARRAY) && n > 1 && size > 0)) {
	 dbwarning("reallocMem not dynamic array dtype %d \n", name, getDtype());
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


      DBPF("%s REQUIRED n %d m %d memp %p   size %d dtype %d memsize %d\n",
		name, n, m, memp,  size, dtype, memsize);

        newmemsize = computeMemSize( m, dtype);

	DBPF("newmemsize %d  current cs %d \n",newmemsize,cs);


	if (newmemsize > memsize || memp == 0) {

 	    newmemsize += Doublesz;
	    // safety so any type - size 1 can fit without reallocing for
                                  // size 1 (scalar)
	    if (memp == 0) {
	        vp = scalloc_id(newmemsize, 1,cname);

		DBPS("did calloc of newmemsize %d  \n",newmemsize);
                

	    }
	    else {

    DBPS("reallocMem newmemsize %d  memp %p  dtype %d\n",newmemsize,memp, getDtype());
	      vp = srealloc_id((void *) memp, newmemsize,"siv_realloc");

              DBPS("did realloc of newmemsize %d  \n",newmemsize);
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
    
    aop.setBounds(0,r);
    aop.setBounds(1,c);


    DBPS( "ok size now %d %s memp %d size %d \n", n, getName(), memp, size);
	
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

    DBPS("rtval %d sivtype %d  dtype %d memp %p\n",rtval,type,getDtype(), memp);
    
    return (rtval);
}
//[EF]===================================================//

void Matrix::storeRow( int *vec, int rowi, int n)
{
      int rows = aop.getBounds(0);
      int cols = aop.getBounds(1);
      if (rowi < rows && rowi >= 0
	  && n <= cols && n > 0) {
      int *ip = (int *) memp;
      ip += (rowi * cols);
      	  for (int c = 0; c < n; c++)
	    *ip++ = vec[c];
      }

}
//[EF]===================================================//

void Matrix::Print() {

    int rows = aop.getBounds(0);
    int cols = aop.getBounds(1);
    
    if (dtype == INT) {
    int *ip = (int *) memp;

    
         for (int i = 0; i < rows; i++)
          {
	  for (int c = 0; c < cols; c++)
          { 
	    printf("%d,",*ip++);
	  }
	  printf("\n");
	  }
    }
}
//[EF]===================================================//


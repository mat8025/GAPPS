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
#include "array.h"
#include "debug.h"


int
Array::reallocMem ()
{
  ///
  ///  aop - has to contain required size,dimensions --
  ///  for num (int,float) types
  ///

  int rtval = SUCCESS;
  int fixup = 0;
  int did_realloc = 0;
  char cname[64];

  //    sprintf(cname,"%s",getName());
  // we realloc to change size ( or if type has changed)

  void *vp;
  char *cp;
  int cs = 0;
  uint32_t newmemsize = 0;

  int k, m;
  //    ASSERT_SIV(this);
  int n = aop.getSize ();

  try
  {

    if (n <= 0)
      {
	DBP ("WARNING ReallocMem - noop! size %d\n", n);
	throw ERR2EXIT;
      }

    if ((memsize > 0) && ((n + 1) * Sizeof ()) <= (int) memsize)
      {

	size = n;
	DBPF
	  ("%s %d already has enuf mem !need %d items type %s has memsize %d \n",
	   getName (), id, n, Dtype (), memsize);

	if (memp != 0)
	  {
	    throw OKTOEXIT;
	  }
	else
	  {
	    DBP ("WARNING id %d bad memp %p memsize? %d \n", id, Memp (),
		 memsize);
	    memsize = 0;
	    fixup = 1;
	  }
      }
    else
      {
	// DBPF
	DBPS ("%s needs more memory %d pieces of mem dtype %d memsize %d \n",
	      getName (), n, dtype, memsize);
      }


    cs = 0;

    if (memp != 0)
      cs = memsize;

    /* this should take care of multi-dimension arrays where n is low-dimension number */
    // don't prevent reallocMem - warn if this is a fixed array size


    if ((!testCW (DYNAMIC_ARRAY) && n > 1 && size > 0))
      {
	dbwarning ("reallocMem not dynamic array type %s \n", getName ());
      }

    vp = (void *) memp;

    // we already have Doublesz area of memory allocated on init

    m = n + 1;			// safety one more but not used


    if (memp == 0 && testCW (DYNAMIC_ARRAY))
      {
	m += 10;
	DBPS ("initting dynamic array memory to at least 10 pieces \n");
      }


    if (n > 1 || memp == 0 || testCW (DYNAMIC_ARRAY))
      {


	DBPS ("%s REQUIRED %d m %d    size %d dtype %d memsize %d\n",
	      getName (), n, m, size, dtype, memsize);

	newmemsize = computeMemSize (m, dtype);

	DBPS ("newmemsize %d  current %d \n", newmemsize, cs);


	if (newmemsize > memsize || memp == 0)
	  {

	    newmemsize += Doublesz;
	    // safety so any type - size 1 can fit without reallocing for
	    // size 1 (scalar)
	    if (memp == 0)
	      {
		vp = scalloc_id (newmemsize, 1, cname);

		DBPF ("did calloc of newmemsize %d  \n", newmemsize);


	      }
	    else
	      {

		DBPS ("reallocMem newmemsize %d  memp %p \n", newmemsize,
		      memp);
		vp = srealloc_id ((void *) memp, newmemsize, "siv_realloc");

		DBPS ("did realloc of newmemsize %d newvp %p\n", newmemsize,
		      vp);
		did_realloc = 1;
	      }

	    if (vp != NULL)
	      memsize = newmemsize;

	  }
      }

    if (vp == NULL)
      {
	dbp ("bad vp for %s n %d\n", getName (), n);
	throw ERR2EXIT;
      }

    memp = vp;

    size = n;

    DBPS ("ok %s  memp %p size %d \n", getName (), memp, size);

    // we may have changed type prior to allocating so 
    // clear via difference in byte size newmemsize old memsize

    if (did_realloc && ((newmemsize - cs) > 0))
      {

	cp = (char *) memp;

	cp += cs;

	k = (newmemsize - cs);

	DBPS
	  ("realloced more %d so clearing new mem ok newmemsize %d cs %d  k  %d to zero\n",
	   did_realloc, newmemsize, cs, k);

	while (k-- > 0)
	  *cp++ = 0;

      }


    //DBPF("%s memp %p  size %d offset %d\n",name, memp, size, offset);


    memsize = newmemsize;
    setCW (SI_FREE, OFF);
  }

  catch (int e)
  {

    if (e == ERR2EXIT)
      {
	whatError (MALLOC_ERROR, __FUNCTION__);
	rtval = REALLOC_ERROR;
      }
    else if (e == OKTOEXIT)
      {
	rtval = SUCCESS;
	setCW (SI_FREE, OFF);
      }
  }

  if (fixup)
    {
      DBP ("WARNING %s fixed memp memsize? %d %p\n", getName (), memsize,
	   Memp ());
    }

  DBPS ("rtval %d \n", rtval);

  return (rtval);
}

//[EF]===================================================//
void
Array::storeRow (int *vec, int sb[])
{

  int index = aop.setInnerRow (sb);
  if (index != -1)
    {
      int *ip = (int *) memp;
      ip += index;
      int n = aop.bounds[aop.getND () - 1];
      for (int k = 0; k < n; k++)
	*ip++ = vec[k];
    }
}

//[EF]===================================================//

void
Array::printInnerMatrix (int index)
{

  int rows = aop.getBounds (aop.nb - 2);
  int cols = aop.getBounds (aop.nb - 1);

  if (dtype == INT)
    {
      printf ("\n");
      for (int i = 0; i < (aop.nb - 2); i++)
	{
	  printf ("[%d]", aop.ibounds[i]);
	}
      printf ("\n\n");


      int *ip = (int *) memp;
      ip += index;
      for (int i = 0; i < rows; i++)
	{

	  for (int c = 0; c < cols; c++)
	    {
	      printf ("%d,", *ip++);
	    }
	  printf ("\n");
	}
    }

}

//[EF]===================================================//

void
Array::printDimn (int wb, int index)
{
  int step = 1;			// what is step for this dimension?

  if (wb < (aop.nd - 2))
    {

      for (int i = wb + 1; i < aop.nd; i++)
	{
	  step *= aop.bounds[i];
	}

      for (int i = 0; i < aop.bounds[wb]; i++)
	{
	  aop.ibounds[wb] = i;
	  printDimn (wb + 1, index);
	  index += step;

	}
    }
  else
    {

      printInnerMatrix (index);
    }

}

//[EF]===================================================//
void
Array::Print ()
{
  printf ("Printing %s\n", getName ());
  printDimn (0, 0);

}

//[EF]===================================================//

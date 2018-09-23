/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                       record                      
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
#include "record.h"
#include "debug.h"


Record::~Record()
{
    DBPS("destructing Record!\n");
    Svar *sp;
  
    if (getRecord() != NULL ) {
          for (int i = 0; i < size ; i++) {
	    sp = getRecord(i);  
              if (sp != NULL) {
                   sp->vfree(); // CHECK
                   delete sp; 
              }              
          }
     }


}
//[EF]===================================================//
int
Record::realloc (int num)
{

  ///
  /// record  realloc - array of Svar pointers 
  ///
  int ret = SUCCESS;

  try
  {
    Svar **newrec = NULL;
    Svar *sp;
    if (aop.nd ==0) {
      aop.initBounds(1);

    }
    if (num <= 0)
      num = 1;

    if (num == aop.size)
      {
	;
      }
    else if (num > aop.size)
      {

	DBPS ("num %d   csize %d\n", num, size);

	newrec =
	  (Svar **) srealloc_id (recvec, (num * sizeof (Svar *)),
				 __FUNCTION__);

	if (newrec == NULL)
	  throw REALLOC_ERROR;

	recvec = newrec;

	char rname[32];
	for (int i = size; i < num; i++)
	  {
	    sprintf (rname, "rec%d", i);
	    sp = new Svar (rname, 1);
	    recvec[i] = sp;
	  }

	aop.size = num;
      }
    else
      {

	// delete svar then realloc num < size - presumably always works
	// since reducing

	
	for (int i = aop.size - 1; i >= num; i--)
	  {
	    sp = getRecord (i);
	    delete sp;
	    recvec[i] = NULL;
	  }

	newrec =
	  (Svar **) srealloc_id (recvec, (num * sizeof (Svar *)),
				 __FUNCTION__);
	if (newrec == NULL)
	  throw REALLOC_ERROR;
	recvec = newrec;

      }
  }

  catch (int ball)
  {

    if (ball != SUCCESS)
      {
	whatError (ball, __FUNCTION__);
	ret = ball;
      }

  }

  size = aop.size;
  return ret;

}

//[EF]===================================================//
int Record::storeRow (int row, Strv *str)
{
  ///
  ///
  ///

  //   check row exists -- add/insert
  //   split str via WS or comma
  int ret = SUCCESS;
  if (row >= 0 && row < aop.size) { // overwrite-
    DBPS("%s\n",str->v.cptr(0));
    Svar *sp;
    sp = getRecord(row);
    if (sp != NULL)
     sp->findWsTokens( str->v.cptr(0));
    else
      ret = ARRAY_STORE_ERROR;
  }
  // add to end -- 

  // extend to row index - with empty rows also added

  // insert ?
  return ret;
}
//[EF]===================================================//
void Record::printRow (int row)
{
  ///
  ///
  ///

  //   check row exists -- add/insert
  //   split str via WS or comma
  if (row >= 0 && row < aop.size) { // overwrite-
    Svar *sp;
    sp = getRecord(row);
    if (sp != NULL) {
      for (int i=0; i< sp->getNarg(); i++)
      printf("%s ",sp->cptr(i));
      printf("\n");
    }

  }

}
//[EF]===================================================//
void Record::printRows (int srow, int frow)
{

  if (frow == -1)
    frow = aop.size -1;
  for (int i = srow; i< frow; i++)
    printRow(i);

}

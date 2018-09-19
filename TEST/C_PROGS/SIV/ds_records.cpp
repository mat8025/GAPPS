/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    ds_records                      
///   CopyRight   - RootMeanSquare                                 
//    Mark Terry  - 1998 -->                                           
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include <stdio.h>
#include <stdlib.h>
#include <iostream>


//#include "ds_records.h"
#include "defs.h"
//#include "var.h"
#include "record.h"
#include "debug.h"

Record::~Record()
{
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

asl_return_code
Record::set(int num)
{
  
  ///
  /// record NULL then alloc array of Svar pointers and new Svar into
  ///
  asl_return_code ret = SUCCESS;
  if (num <= 0) {
     num = 1;
     DBW("forcing zero/neg to  num %d\n",num);
  }
  try {
   recvec = (Svar **) scalloc_id( num, sizeof (Svar *),__FUNCTION__);
  
    if (recvec == NULL) {
       DBE("calloc recvec\n");
       return 0;
    }

    Svar *sp;
    char rname[32];
      for (int i = 0; i < num ; i++) {
           sprintf(rname,"rec%d",i);
           sp = new Svar(rname,1);
           recvec[i] = sp;
	   //	   DBPF("rec %d\n",i);
      }
  }
  
  catch (asl_error_codes ball) {

      if (ball != SUCCESS) {
	whatError(ball,__FUNCTION__);
	ret = ball;
      }

  }

  return ret;
}
//[EF]===================================================//
asl_return_code
Record::realloc(int num, int size)
{
  
  ///
  /// record  realloc - array of Svar pointers and new Svar into
  ///
  asl_return_code ret = SUCCESS;

  try {


    
  Svar **newrec = NULL;
  Svar *sp;
  if (num <=0) num = 1;
  
      if (num == size) {
        ;
      }
      else if ( num > size) {

	DBPF("num %d   csize %d\n",num,size);

      newrec = (Svar **) srealloc_id( recvec, (num * sizeof (Svar *)),__FUNCTION__);

	if (newrec == NULL)
	  throw REALLOC_ERROR;

      recvec = newrec;
      
      char rname[32];
      for (int i = size; i < num ; i++) {
           sprintf(rname,"rec%d",i);
           sp = new Svar(rname,1);
           recvec[i] = sp;
      }

      
      }
      else {
          
          // delete svar then realloc num < size - presumably always works
          // since reducing
      for (int i = size-1; i >= num ; i--) {
	   sp = getRecord(i);
           delete sp;
           recvec[i] = NULL;
      }
      
      newrec = (Svar **) srealloc_id( recvec, ( num * sizeof (Svar *)),__FUNCTION__);
      if (newrec == NULL)
           throw REALLOC_ERROR;
       recvec = newrec;

      }


  }

    catch (asl_error_codes ball) {

      if (ball != SUCCESS) {
	whatError(ball,__FUNCTION__);
	ret = ball;
      }

  }

  return ret;

}
//[EF]===================================================//
void
Aop::setRcol (int lh, int k)
{

  DBPF ("info %s lh? %d rcol %d\n", info (), lh, k);

  if (k == -1)
    {
      DBW (" -1 set lh %d rcol %d\n", lh, k);
    }

  //  if (testCW(ARRAY_ELE) || testCW (SUBSC_RANGE| SUBSC_ARRAY)) { // TBC  do we want this test?
  if (lh)
    lh_rcol = k;
  else
    rcol = k;
}

//[EF]===================================================//

int
Aop::getRcol (int lh)
{
  int val = -1;


  if (lh)
    val = lh_rcol;
  else
    val = rcol;

  return val;
};

//[EF]===================================================//

int
Record::sortRows (int col, int an, int dir, int si)
{
  ///
  /// sort the record rows using selected col
  /// via alpha value  or converted to number
  ///  dir 1 least-> largest or reverse  dir -1
  ///
  /// TBD an,dir
  Svar *tmp;

  int swop = 0;
  int sorted = 0;
  int nfields;
  try
  {

    if (col < 0)
      throw ARRAY_BOUNDS_ERROR;

    int nrows = aop.getBounds (0);
    //DBP("%d %d %d %d\n",col,an,dir,si);
    if (nrows <= 1)
      {
	sorted = 1;
	throw SUCCESS;
      }
    // bubble sort
    Svar *spa, *spb;
    char *cpa, *cpb;
    int alen, blen, s_len, kc, swop_item, nswaps;
    int ksorts = 0;
    float a, b;
    int number_sort = 0;
    // DBT("nrows %d\n",nrows);
    while (1)
      {
	nswaps = 0;
	swop = 0;
	
	for (int i = si; i < nrows - 1; i++)
	  {
	    //  get the alpha ptrs
	    spa = getRecord (i);
	    if (spa == NULL)
	      throw ARRAY_ERROR;
	    nfields = spa->getNarg ();
	    if (col >= nfields)
	      throw ARRAY_BOUNDS_ERROR;
	    cpa = spa->cptr (col);
	    spb = getRecord (i + 1);
	    if (spb == NULL)
	      throw ARRAY_ERROR;
	    nfields = spb->getNarg ();
	    if (col >= nfields)
	      throw ARRAY_BOUNDS_ERROR;
	    cpb = spb->cptr (col);
	    // now the compare
	    alen = strlen (cpa);
	    blen = strlen (cpb);
	    s_len = (alen < blen) ? alen : blen;
	    kc = 0;
	    swop_item = 0;
	    number_sort = 0;
	    if (isdigit (*cpa) && isdigit (*cpb))
	      {
		number_sort = 1;
	      }
	    if (an == 1)
	      {
		// force alpha
		number_sort = 0;
	      }


	    while (kc++ < s_len)
	      {
		if (!number_sort)
		  {
		    if (*cpb == *cpa);
		    else if ((dir == 1 && *cpb < *cpa)
			     || (dir == -1 && *cpb > *cpa))
		      {
			swop_item = 1;
			break;
		      }
		    else
		      break;
		  }
		else
		  {
		    a = atof (cpa);	// should use number to str -- for E fmt
		    b = atof (cpb);
		    //  DBP("%s %f %s %f\n",cpa,a,cpb,b);
		    if (a == b);
		    else if ((dir == 1 && a < b) || (dir == -1 && a > b))
		      {
			swop_item = 1;
			break;
		      }
		    else
		      break;
		  }


		cpa++;
		cpb++;
	      }
	    //    DBT("swop %d s_len %d  a %s b %s\n",swop_item,s_len,cpa,cpb);
	    if (swop_item)
	      {			// have to swap row 
		nswaps++;
		swop = 1;
		// the swop
		tmp = recvec[i];
		recvec[i] = recvec[i + 1];
		recvec[i + 1] = tmp;
		//      tmp = spb;

		// spb = spa;
		// spa = tmp;
		spa = getRecord (i);
		spb = getRecord (i + 1);
	      }
	    //   DBT("after swop %d s_len %d  a %s b %s\n",swop_item,s_len,spa->cptr(col),spb->cptr(col));

	  }

	if (!swop)
	  {
	    sorted = 1;
	    break;
	  }
	ksorts++;
	//      DBT("ksorts %d nswaps %d\n",ksorts,nswaps);
	if (ksorts > (4 * nrows))
	  break;
      }
  }
  catch (asl_error_codes ball)
  {
    sorted = 0;
  }

  return sorted;
}

//[EF]===================================================////

int
Record::sortCols (int rol, int an, int dir, int si)
{
  ///
  /// sort the record cols using selected row
  /// via alpha value  or converted to number
  ///  dir 1 least-> largest or reverse  dir -1
  ///




}

//[EF]===================================================////
void
Record::swapRows (int rowa, int rowb)
{
  // record type
  //DBP("swapRows \n");

  Svar *tmp;
  try
  {

    if (rowa < 0)
      throw ARRAY_BOUNDS_ERROR;
    int nrows = aop.getBounds (0);
    if (nrows <= 1)
      {
	throw SUCCESS;
      }
    if ((rowa >= 0 && rowa < nrows) && (rowb >= 0 && rowb < nrows))
      {
	//      DBP("swopping rows %d %d\n",rowa,rowb);
	// the swop
	tmp = recvec[rowb];
	recvec[rowb] = recvec[rowa];
	recvec[rowa] = tmp;
      }
  }

  catch (asl_error_codes ball)
  {

  }


}

//[EF]===================================================////

void
Record::deleteRows (int rowa, int rowb)
{
  ///
  /// delete rows in
  /// record type
  /// consecutive delete
  ///

  try
  {

    if (rowa < 0)
      throw ARRAY_BOUNDS_ERROR;

    DBPF ("parent siv %s \n", info());
    
    int nrows = aop.getBounds (0);

    DBPF ("rowa %d rowb %d nrows %d\n", rowa, rowb, nrows);
    
    if (nrows < 1)
      {
	throw SUCCESS;
      }

    DBPF ("rowa %d rowb %d nrows %d\n", rowa, rowb, nrows);

    if (rowb == -1)
      rowb = nrows - 1;

    if (rowb >= nrows)
      rowb = nrows - 1;

    DBPF ("rowa %d rowb %d nrows %d\n", rowa, rowb, nrows);

    if ((rowa >= 0 && rowa < nrows)
	&& (rowb >= rowa) && (rowb >= 0 && rowb < nrows))
      {

	for (int i = rowa; i <= rowb; i++)
	  {
	    delete recvec[i];
	    recvec[i] = NULL;
	  }

	//DBT ("delete OK \n");

	// now shuffle the rest of record into rows rowa ...
	// and reset the number of records
	int j = rowa;
	for (int i = rowb + 1; i < nrows; i++)
	  {
	    recvec[j] = recvec[i];
	    recvec[i] = NULL;
	    j++;
	  }

	aop.setBounds (0, nrows - (rowb - rowa + 1));
	// realloc record to new size??
        DBPF ("new sz %d\n", aop.getBounds (0));
	aop.setSize (aop.getBounds (0));
        DBPF ("after delete %s\n", info());
      }
  }

  catch (asl_error_codes ball)
  {

  }

}

//[EF]===================================================//

void
Record::insertRows (int rowa, int nr, int rowb)
{
  ///
  /// insert rows in
  /// record type
  ///  this is just rearrangement of a consecutive section of records
  //   to a new location
  ///  no ovelap of the existing section to new location allowed
  ///


  Svar **tvec = NULL;
  try
  {
    int nrows = aop.getBounds (0);

    if (nrows < 1 || rowa == rowb)
      {
	throw SUCCESS;
      }

    if ((rowa < 0) || (rowb < 0) || (rowa >= nrows) || (nr >= nrows))
      throw ARRAY_BOUNDS_ERROR;

    DBT ("insert nr %d rows  from rowa %d  @ rowb %d  rrows %d\n", nr, rowa, rowb, nrows);

    tvec = (Svar **) srealloc_id (tvec, (nrows * sizeof (Svar *)),__FUNCTION__);
    if (tvec == NULL)
      throw REALLOC_ERROR;
    // now shuffle the rest of record into rows rowa ...
    // and reset the number of records

    // copy of existing record svar ptr array
    for (int i = 0; i < nrows; i++)
      {
	tvec[i] = recvec[i];
      }
    
    DBPF("copied %d svar* \n",nrows);
    // now place the 2b inserted section into new position
    int j = rowb;
    int k = rowa;

    if (rowa > rowb)
      {
	
	for (int i = 0; i < nr; i++)
	  {
	    DBPF("insert %d @ %d  %s \n",k,j,tvec[k]->cptr(0));
	    recvec[j] = tvec[k];

	    j++;
	    k++;

	  }

	k = rowb;
	int nrs = (rowa - rowb);
	for (int i = 0; i < nrs; i++)
	  {
	    recvec[j] = tvec[k];
	    DBPF("move %d to %d %s \n",k,j,tvec[k]->cptr(0));
	    j++;
	    k++;
	  }
      }
    else
      {
	// rowa < rowb
	j = rowa;
        rowb -= 1; // section should go infront of insert row
	int nrs = (rowb - (rowa +nr -1));
	k = rowb -nrs+1;
	for (int i = 0; i < nrs; i++)
	  {
	    recvec[j] = tvec[k];
	    j++;
	    k++;
	  }
	k = rowa;
	
	for (int i = 0; i < nr; i++)
	  {
	    recvec[j] = tvec[k];
	    j++;
	    k++;
	  }
      }
    free (tvec);
  }


  catch (asl_error_codes ball)
  {

  }


}

//[EF]===================================================//

void
Record::deleteVecOfRows (int rows[], int n)
{
  ///
  /// delete rows in
  /// record type
  /// using indices in argument array
  /// shuffle up to produce consecutive enteries
  /// and resize

  try
  {


    if (n <= 0)
      throw ARRAY_BOUNDS_ERROR;
    int nrows = aop.getBounds (0);
    if (nrows < 1)
      {
	throw SUCCESS;
      }

    DBPF ("n %d nrows[0] %d\n", n, rows[0]);


    int j;
    int k = 0;
    for (int i = 0; i < n; i++)
      {
	j = rows[i];
	if (j >= 0 && j < nrows)
	  {
	    if (recvec[j] != NULL)
	      {
		delete recvec[j];
		recvec[j] = NULL;
		k++;
	      }
	  }
      }
    DBPF ("done %d delete OK \n", k);

    // now shuffle the rest of record into rows rowa ...
    // and reset the number of records
    j = 0;
    k = 0;
    int m;
    while (j < nrows)
      {
	if (recvec[j] == NULL)
	  {
	    m = j + 1;
	    while (m < nrows)
	      {
		if (recvec[m] != NULL)
		  {
		    recvec[j] = recvec[m];
		    recvec[m] = NULL;
		    k++;
		    break;
		  }
		m++;
	      }
	  }
	else
	  {
	    k++;
	  }
	j++;
      }

    aop.setBounds (0, k);
    // realloc record to new size??
    aop.setSize (aop.getBounds (0));
    DBPF("%s \n",info());
  }


  catch (asl_error_codes ball)
  {

  }


}

//[EF]===================================================//


void
Record::deleteCols (int rowa, int rowb)
{
  ///
  /// delete rows in
  /// record type

  Svar *tmp;
  try
  {
    throw NOT_CODED_ERROR;

  }

  catch (asl_error_codes ball)
  {

  }

}

//[EF]===================================================//

Svar Rectmp; // Global

void
Record::swapCols (int a, int b)
{

  //  Svar tmp;

  try
  {

    if (a < 0)
      throw ARRAY_BOUNDS_ERROR;
    int nrows = aop.getBounds (0);
    if (nrows <= 0)
      {
	throw ARRAY_BOUNDS_ERROR;
      }

    int ncols = getRecord (0)->getNarg ();
    if (ncols <= 1)
      {
	throw ARRAY_BOUNDS_ERROR;
      }

    if ((a >= 0 && a < ncols) && (b >= 0 && b < ncols))
      {
	// the swop

	for (int i = 0; i < nrows; i++)
	  {
	    //DBT("[%d] a %d b %d %s\n",i,a,b,recvec[i]->cptr(a));
	    Rectmp.cpy (recvec[i]->cptr (a), 0);
	    recvec[i]->cpy (recvec[i]->cptr (b), a);
	    recvec[i]->cpy (Rectmp.cptr (0), b);
	  }
      }
  }

  catch (asl_error_codes ball)
  {

  }

}

//[EF]===================================================////

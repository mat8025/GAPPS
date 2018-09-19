/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    ds_sivrange                     
///   CopyRight   - RootMeanSquare                        
//    Mark Terry  - 1998 -->                                          
/////////////////////////////////////////<v_|_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

//#include "ds_sivrange.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "defs.h"
#include "debug.h"
#include "siv.h"
#include "range.h"
#include "aop.h"

void
adjustNegOffset (int &offset, int size)
{
  if (offset < 0)
    {
      //  DBP("neg offset %d size %d \n",offset, size);
      if (size > 0)
	{
	  if (abs (offset) <= size)
	    offset = size + offset;
	  else
	    {
	      offset = offset % size;
	      //DBPERROR ("array_index for  %s mod offset %d\n", name,offset);
	    }

	  if (offset < 0)
	    offset += size;
	}
      else
	offset = 0;
    }
}
//[EF]===================================================//
void circular_address ( int &cele, int stride, int vsize)
{
  //DBP("cele %d stride %d vsize %d\n",cele, stride, vsize);
	  cele += stride;
          if (cele < 0)
	    cele = vsize + cele;
          else if (cele >= vsize) {
	    cele = (cele % vsize);
          }
}
//[EF]===================================================//




int
Aop::checkValidBounds ()
{
  int rv = 0;
  try
  {

    if (nd <= 0)
      {
	DBPERROR ("  %s\n", info());
	throw NOTOK;
      }
    else
      rv = 1;

    for (int i = 0; i < nd; i++)
      {

	DBPF( "%s bounds[%d] %d\n",getName(), i, getBounds(i));

	if (getBounds(i) <= 0)
	  {
	    DBPERROR ("invalid dimension %d", i);
	    throw NOTOK;
	  }

      }
  }

  catch (int ball)
  {
    rv = 0;
  }

  return rv;
}
//[EF]===================================================//

int
Aop::computeOffSet(int nds[])
{
  //assume nd has the required dimn spec
  int os = 0;
  int the_nd = getND();
  int r= getBounds(the_nd-1);
  os = nds[the_nd-1];
  //DBP("os %d the_nd %d\n",os,the_nd);
int kd;
  for (int i = 1; i < the_nd; i++) {
    kd = the_nd-1-i;
    os += r * nds[kd];
    r *= getBounds(kd);
    //DBP("[%d] kd %d  os %d r %d\n",i, kd, getBounds(kd),os,r);  
  }

  return os;
}
//[EF]===================================================//

void Range::EvalRange (Aop *aop, int wd, int val, int val_status)
{

  int gotval = val_status;
  int atend = aop->crange->testCW (RNGATEND);

  //Siv *rsivp = findRefOrPtr (this);
  int *rbounds = aop->getBounds();

    DBPF
	  ("%s nd %d wd %d bounds %d in rc %d val %d atend %d  gotval %d \n",
	   getName (), nd, wd, getBounds(wd), aop->crange->rc, val, atend, gotval);

  if (!testCW (SUBI))
    {
      //      SetUpSubi ();
    }


  if (aop->crange->testCW (RNGALL))
    {
      aop->crange->start = 0;
      aop->crange->end = rbounds[wd] - 1;
      aop->crange->stride = 1;
      aop->crange->rc = 3;
      aop->crange->gotstart = 1;
    }

  else
    {
      // this incrementally works out range as each pass adds in start:stop:stride
      // with optionally empty fields

      if (aop->crange->rc && atend)
	{
	  if (!aop->crange->gotstart)
	    {
	      aop->crange->gotstart = 1;
	      aop->crange->start = 0;
	    }
	  aop->crange->rc = 3;
	}

      if (aop->crange->rc == 1 && !gotval)
	{
	  if (!aop->crange->gotstart)
	    {
	      aop->crange->gotstart = 1;
	      aop->crange->start = 0;
	    }
	}

      if (aop->crange->rc == 2 && !gotval)
	{
	  if (!aop->crange->gotend)
	    {
	      aop->crange->gotend = 1;
	      aop->crange->end = rbounds[wd] - 1;
	    }
	}


      if (aop->crange->rc && gotval)
	{
	  int def = 0;

	  if (!aop->crange->gotstart)
	    {

	      aop->crange->gotstart = 1;

	      if (!def)
		{

		  DBPF("setting start %d\n", val);

		  aop->crange->start = val;
		  if (aop->crange->start < 0)
		    {
		      aop->crange->start = rbounds[wd] + aop->crange->start;
		      if (aop->crange->start < 0)
			{
			  dberror ("range start < 0\n", val);
			  aop->crange->start = 0;
			}
		    }
		}
	      else
		aop->crange->start = 0;

	    }
	  else if (!aop->crange->gotend)
	    {

	      aop->crange->gotend = 1;

	      if (!def)
		{
		  aop->crange->end = val;
		  // check end against sivp bounds

		  if (aop->crange->end < 0)
		    {
		      aop->crange->end = rbounds[wd] + aop->crange->end;
		    }

		  if (aop->crange->end >= rbounds[wd])
		    {

		      if (testCW (DYNAMIC_ARRAY))
			{
			  if (!aop->RangeExtend (wd, aop->crange->end + 1))
			    {
			      DBPERROR
				("range outside of variable %s array bounds end %d %d\n",
				 getName (), aop->crange->end, rbounds[wd]);

			      aop->crange->end = rbounds[wd] - 1;
			    }
			}
		      else
			{
			  DBPERROR
			    ("range outside of variable array bounds end %d %d\n",
			     aop->crange->end, rbounds[wd]);
			  aop->crange->end = rbounds[wd] - 1;
			}
		    }

		  DBPF("setting end %d %d\n", val, aop->crange->end);

		}
	      else
		aop->crange->end = rbounds[wd] - 1;

	    }
	  else if (!aop->crange->gotstride)
	    {

	      if (!def)
		{

		  DBPF("setting stride %d\n", val);

		  aop->crange->stride = val;
		}
	      else
		aop->crange->stride = 1;

	      aop->crange->gotstride = 1;
	      aop->crange->rc = 3;
	    }

	  gotval = 0;

	}
    }

  // if range has been set - work out new bounds


  if (gotval || aop->crange->rc == 3)
    {

      // fill in dp
      DBPF("fill in dp \n");

      if (aop->crange->gotstart)
	{

	  if (!aop->crange->gotstride) {
	    DBPF("default stride 1 \n");
	    aop->crange->stride = 1;
	  }

	  if (!aop->crange->gotend) {
	    aop->crange->end = rbounds[wd] - 1;
	    DBPF("default end %d \n",  rbounds[wd] - 1 );
	  }

	  if (aop->crange->end < 0)
	    {
	      aop->crange->end = rbounds[wd] + aop->crange->end;
	    }


	  if (aop->crange->end >= aop->crange->start && aop->crange->stride >= 1)
	    {

	      if (aop->crange->start < 0 && aop->crange->end < 0)
		{
		  aop->crange->start = rbounds[wd] + aop->crange->start;
		  aop->crange->end = rbounds[wd] + aop->crange->end;
		}


	      if (aop->crange->end > (rbounds[wd] - 1)) {
		DBPF("limit end %d \n",  rbounds[wd] - 1 );
		aop->crange->end = rbounds[wd] - 1;
              }

    DBPF(" range %d : %d : %d\n", aop->crange->start, aop->crange->end,
			  aop->crange->stride);


	      // CHECK STRIDE

	      //   if (aop->crange->start > 0)            aop->crange->stride *= -1;
	      aop->crange->getStride ();

	      if (aop->crange->stride != 0)
		{
                  int r;
		  if (aop->crange->start == aop->crange->end) {
		    DBPF("start == end %d \n", aop->crange->end);
		     r= aop->crange->start;
		     aop->subi[wd][r] = 1;
		  }
		  else {
		    DBPF("start %d  end %d  stride %d\n", aop->crange->start,aop->crange->end,aop->crange->stride);
		    DBPF(" %d nd %d subi_nd %d\n",rbounds[wd],nd,aop->subi_nd);

		    if (aop->subi_nd == 0 ||
			aop->subi == NULL
			|| aop->subi_nd < (wd+1) ) {
		      DBW("%s  nd %d subi not setup subi_nd %d !\n",getName(),getND(),aop->subi_nd);
		       aop->SetUpSubi();
		    }
					     
		    for (int r = aop->crange->start; r <= aop->crange->end;
		       r += aop->crange->stride)
		    {
		      if (r < rbounds[wd])
			{
			  aop->subi[wd][r] = 1;
	     DBPF("%s subi-wd %d  r %d subi %d\n",name,wd,r, aop->subi[wd][r]);
			}
		      else
			{
			  DBPERROR
			    ("Siv:: ERROR ele %d outside bounds %d -so EXPAND?\n",
			     r, rbounds[wd]);
			}
		    }
		  }
		}
	    }

	  // reset
          // TBC
	  if (aop->nd > 1) {
	    aop->crange->gotstart = aop->crange->gotend = aop->crange->gotstride = 0;
// why reset - need to keep if nd == 1
	  }
//        aop->crange->stride = 1;
//        aop->crange->end = aop->crange->rc = 0;
	  aop->crange->rc = 0;
	}
    }

DBPF
	("<--- range st %d ; end  %d ; stride %d\n", aop->crange->start,
	 aop->crange->end, aop->crange->stride);
}

//[EF]===================================================//

int Aop::VrangeToSubSet ()
{
  
  //if (testCW (SUBSC_RANGE) && (nd == 1 || type == LIST))
    {
      range.Compute ();
      // allocsubset

      subsize = range.ne;
      subnd = 1;
      int *bp;

      bp = (int *) srealloc_id (subset, ((getSubSize() + 1) * sizeof (int)),__FUNCTION__);

      // fill

      if (bp == NULL)
	{
	  DBPERROR ("alloc VrangeToSubSet \n");
	}
      else
	{
	  subset = bp;
	  int j = range.start;

	  //DBPF("st %d ne %d  stride %d \n",range.start,range.ne, range.stride;  

	  for (int i = 0; i < range.ne; i++)
	    {
	      subset[i] = j;
	      j += range.stride;
	    }
	  return 1;
	}

      // setCW (SUBSC_ARRAY, ON);

    }

  return 0;
}
//[EF]===================================================//

void
Range::Reset() {
    DBPF(" B4 reset start %d end %d stride %d \n", start, end, stride);
    start = end = 0;
    stride = 1;
    ne = 1;
    cw = 0;
    rc = inv = gotstart = gotend = gotstride = 0;
}


//[EF]===================================================//

int
Range::Compute ()
{
  
  DBPF("start %d end %d stride %d \n", start, end, stride);

  float nef;
  int rsize;
  int te;
  ne = 1;

  // get the array index of start and end
    {

      rsize = getSize ();

      if (end < 0)
	{
	  adjustNegOffset (end, rsize);
	}

      if (start < 0)
	{
	  adjustNegOffset (start, rsize);
	}
  
  if (start >= end) {
  // start > end -- stride +ve  - circle to get to desired end element
    if (stride > 0)  {
      
      if (start == end) {
	DBT(" start %d end %d gotstart %d\n",start,end,gotstart);
	if (!gotstart) {
		end--;
	   if (end < 0)
		  adjustNegOffset (end, rsize);
	te =   (rsize-start) + (end+1);
        }
	else {
	   te = 1;
	}
	
	DBT("te %d\n",te);
      }
      else {
         te =   (rsize-start) + (end+1);
      }
    }
    else if (stride < 0)
      {
		
       if (start == end && !gotstart) {
  	  end++;
       if (end == rsize)
	  end = 0;
          te = rsize;
      }
       else
        te = (start -end) + 1.0;

  // start > end -- stride -ve  -- just decrement til at/past desired end element
      }
    else {
      //  DBP("no stride\n");
      te = 1;
    }
  }
  else {

  // start <= end -- stride +ve -- just add till at or past end
    if (stride > 0)  
       te = (end - start) + 1.0;
    else
       te = (start+1) + (rsize - end);
  // start < end -- stride -ve -- circle to get to desired end element
  }
  
  if (stride != 0) {
    ne =   te /abs( stride);

  if ((ne* abs(stride)) < te) ne++; 
  }
  //  nef = fabs ((abs (end - start) + 1.0) / (float) stride);
  //  ne = abs ((int) nef);
  
  }

  if (ne > rsize)
    ne = rsize;

//DBP("range ne %d\n",ne);

  return ne;
}
//[EF]===================================================//

int
Range::getStart (int sz)
{
  int the_start = 0;
  //  int v_size;

  DBPF("str %d end %d stride %d \n", start, end, stride);

      the_start = start;

      if (start < 0)
	{
	  the_start = sz + start;
	}

  if (the_start < 0)
    the_start = 0;

  return the_start;
}
//[EF]===================================================//

int
Range::getStride ()
{
  if (end < start && end > 0 && stride > 0)
    {
      // stride *= -1;
    }

   DBPF("str %d end %d stride %d \n", start, end, stride);

  return stride;
}
//[EF]===================================================//

int
Range::getEnd ()
{
  int the_end = 0;

DBPF("str %d end %d stride %d \n", start, end, stride);

  the_end = end;


      if (end < 0)
	{
	  the_end = size + end;
	}
   

  if (the_end < 0)
    the_end = 0;

  return the_end;
}

//[EF]===================================================//


int Aop::RangeExtend(int wd, int newbd)
{
  int rtval= 1;
  int num,oldb;


  {
    // we allow increasing size of bounds but not number of dimensions

  try {
    /*
    if (wd == 0 && type == SVAR)
        throw ISOK;

    if (type == LIST) {
      throw (ReallocBounds(1));
    }
    */
    
    if (wd >= nd) {

       dbp("WARNING RangeExtend Can't increase number of dimensions %d  wd %d dynamically %s \n", nd, wd, name);
       throw 0;
       /*
      if (type == RECORD && (! (wd > nd))) {
         DBT("RECORD type -- referencing svar field - no dimension increase needed!\n");
          throw 1;
	}
      else{
       dbp("WARNING RangeExtend Can't increase number of dimensions %d  wd %d dynamically %s \n", nd, wd, name);
      }
       throw 0;
       */
    }
    
    
    if (bounds == NULL) {
      DBP("WARNING need to init bounds %s nd %d !\n",name,nd);
       throw 0;
    }

    oldb = getBounds(wd);
    setBounds(wd,newbd);

    // compute new size
    num = 1;
    for (int i = 0; i < nd; i++)
      num = num * getBounds(i);
    

//DBPF("extending to %d from %d\n",num,size);

    //  SIV has to extend memory //
    // ptr back to siv needed here ?
    /*
    if (ReallocMem(type, num + 1)) {
	size = num;

    } else {
	DBPERROR("RangeExtend Can't extend to %d from %d\n", num, size);
	throw 0;
    }
    */

    
    // ReallocSubi

    /*
    if (!testCW(SUBI)) {
	SetUpSubi();
    }
    else
    */
      {

       subi[wd] = (char *) srealloc_id((void *) subi[wd], (getBounds(wd) + PAD_SUBI) ,"siv_range_ext: subi");

       // CHECK THIS


	if (subi[wd] == NULL) {
	  DBPERROR("RangeExtend Can't realloc subi dimn  %d  to %d bytes\n", wd, getBounds(wd));
	}

	for (int j = oldb; j < getBounds(wd); j++) {
	    subi[wd][j] = 0;
        }
    }
  }

  catch (int ball) {
    rtval = ball;
  }

  }

//Exit:;

    return rtval;
}
//[EF]===================================================//

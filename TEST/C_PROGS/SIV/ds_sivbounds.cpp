/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                    sivbounds                 
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
#include "debug.h"
#include "siv.h"
#include "aop.h"

Aop::~Aop()
{
  //  DBP("destructing aop!\n");


     if (bounds != NULL) {
              sfree(bounds);           
     }


     if (subdimn != NULL) {
              sfree(subdimn);           
     }

      if (subset != NULL) {
              sfree(subset); 
      }
}
//[EF]===================================================//
void Aop::makeAop()
{
  /*
      DBPF("setting aop for array %s\n",info());
      range.sivp = this;
      crange = &range;
      aop->lhrange.sivp = this;
      setAW(AOP_SET,ON);
  */
}
//[EF]===================================================//

int Aop::InitBounds()
{
  int ret = 0;

    DBPF("<%s>\n",info());
  
          
              makeAop();
          
	    // DBP("makeaop\n");
	    
           if (bounds == NULL) {
	     //char ocname[124];
	     //sprintf(ocname,"bnds %s",name);
                 
	     bounds = (int *) scalloc_id(DEFNBOUNDS+1, sizeof(int),__FUNCTION__);

            if (bounds == NULL) {
                DBPERROR(" can't calloc siv bounds \n");
                return 0;
            }
            else
	      nb = DEFNBOUNDS;

	      setND(1);
            }
	   ret = 1;

	    return ret;
}
//[EF]===================================================//

int Aop::setBounds(int dimn, int n)
{
  /// bounds needs another private member to indicate how many bounds are
  /// in fact allocated -- typically DEFNBOUNDS are present
  /// but more can be allocated
  /// when setting bounds -- nd is not guaranteed to indicated the bounds allocated

  int ret = -1;
  int ok = 1;
  
  DBPF("%s\n",info());
    

              makeAop();
	      DBPF("%s\n",info());




	
            if (bounds == NULL) {
	      if (!InitBounds()) {
		  ok = 0;
		  //		     setAW(AOP_SET,OFF); 
              }

            }

DBPF("ok %d dimn %d nd %d nb %d n %d\n",ok,dimn,nd,nb,n);

              if (ok && (dimn < nd)) {
                //setAW(AOP_SET,ON); // make sure on!
		bounds[dimn] = n;
DBPF("%s dimn %d  aop %d \n",getName(),dimn, bounds[dimn]);
              ret = n;
            }

   return ret;
}
//[EF]===================================================//
int Aop::incrBounds(int dimn, int n)
{
  // bounds needs another private member to indicate how many bounds are
  // in fact allocated -- typically DEFNBOUNDS are present
  // but more can be allocated
  // when setting bounds -- nd is not guaranteed to indicated the bounds allocated

  int ret = 0;
  int ok = 1;


            if (bounds == NULL) {
	      if (!InitBounds()) {
		  ok = 0;
              }
            }

	    if (ok && (dimn < nd) && (dimn < nb)) {
	      bounds[dimn] += n;
	      DBP("dimn %d  [%d] \n",dimn, bounds[dimn]);
              ret = 1;
            }


   return ret;
}
//[EF]===================================================//
int Aop::decrBounds(int dimn, int n )
{
  /// bounds needs another private member to indicate how many bounds are
  /// in fact allocated -- typically DEFNBOUNDS are present
  /// but more can be allocated
  /// when setting bounds -- nd is not guaranteed to indicated the bounds allocated

  int ret = 0;
  int ok = 1;


            if (bounds == NULL) {
	      if (!InitBounds()) {
		  ok = 0;
              }
            }

	    if (ok && (dimn < nd) && (dimn < nb)) {
	      bounds[dimn] -= n;
              if (bounds[dimn] < 0) bounds[dimn] = 0;
	      DBPF("dimn %d  aop %d \n",dimn, bounds[dimn]);
              ret = 1;
            }


   return ret;
}
//[EF]===================================================//


int Aop::initBounds(int nib)
{


    makeAop();

  
    if (bounds == NULL && nib > 0) {
      // char ocname[124];
      // sprintf(ocname,"bnds %s",name);
                 
      bounds = (int *) scalloc_id(nib+1, sizeof(int),__FUNCTION__);

           if (bounds == NULL) {
             DBPERROR(" can't calloc siv bounds \n");
             //setAW(AOP_SET,OFF);
	     return 0;
           }

	   setND(nib);
           nb = nib;
	    return 1;
    }

 return 0;
}
//[EF]===================================================//


int Aop::ReallocBounds(int newd)

{
    int rtval = 0;



  // reset Bounds -- don't set ND ?? 

    int *bp = NULL;

    rtval = 1;



      DBPF( "%s <%d>  %s nd %d newd %d size %d\n",name, getID(), Dtype(), nd, newd, size);


   if (newd <= DEFNBOUNDS && nd <= DEFNBOUNDS && bounds != NULL) {

      //  nd = newd;

      DBPF("NOP --- sufficent bounds already allocated? %s nd %d newd %d %d\n",name,nd,newd,getBounds());


    }
    else {

    bp = bounds;

    int nib = newd ;

    if (nib < DEFNBOUNDS) {
	nib = DEFNBOUNDS;	// always have DEFNBOUNDS
    }


    if ( (newd != nd) || bounds == NULL) {

//        DBP("<%d> nb %d\n",getID(),nb);

      bp = (int *) srealloc_id(bounds, ((nib + 2) * sizeof(int)),__FUNCTION__);

	if (bp == NULL) {
	    DBPERROR("realloc in arraysub\n");
	    nd = 0;
	    rtval = 0;
	}
        else {

	bounds = bp;
        nb = nib;

#if 0
	if (newd > nd)

	    for (int i = nd; i < newd; i++) {
	      setBounds(i,0);
            }
#endif

	if (size > 0 && nd == 1)
	  setBounds(0,size);

	}
    }
    else {

//         DBP("NOP -- bounds already allocated \n");
     }
    }

    

    DBPF("nd %d newd %d sz %d\n",  nd, newd, size);
    

    return rtval;
}
//[EF]===================================================//
int Aop::getBounds(int wb )
{
  int hm = 0;
        if (bounds != NULL && wb >= 0)
           hm = bounds[wb];
  return hm;
}
//[EF]===================================================//


int Aop::CheckBounds()
{
  int _dbl = 1;
  int ok = 1;
  
  try {

    /*
   if (testCW(PROC_ARG_REF) ) {
     DBLF("PROC_ARG_REF %s\n",info());
     setCW(SVPTR,ON); // 
     throw 0;
  }
    */
    


    DBLF("%s \n",info());

    if (nd < 0) {
        setND(1);

     if (size > 1)
        setBounds(0,size);
    }

    if (nd == 0 && size > 0) {
      //           DBP("ND 0! -- so setting bounds %d %d\n",id, getBounds());
        setND(1);
        setBounds(0,size);

    }
    else if ((nd == 1) && (getBounds(0) != size)) {

      //  DBP("setting bounds %d %d\n",id, getBounds());

	setBounds(0,size);

	//DBP("did set bounds %d %d\n",id, getBounds());
    }

    if (nd > 2048) {  // TBC MAX??
      DBP("nd > than max %d \n",nd);
      setND(1);
    }

    DBLF("%s \n",info());
  }

  catch (int err) {
    DBPF("not an array %s\n",getName());
    ok = 0;
  }

  DBLF("<--- %d\n",ok);

  return ok;
}
//[EF]===================================================//

int Aop::CopyBounds(Siv * from)
{
    int *tbp, *fbp;
    int newnd;
    int ok = 1;

    DBPF("to %s  nd %d sz %d from %s nd %d size %d bounds[0] %d\n",
	      name, nd, size, from->name, from->getND(), from->getSize(), from->getBounds(0));

    try {

     if (from->getSize() == 0 || from->getND() == 0) {
        throw 0;
     }

 

    size = from->getSize();

    if (from->getND() <= 0 && from->getSize() > 1) {
	dbwarning( "neg nd %d resetting to 1\n", from->getND());
	throw ARRAY_BOUNDS_ERROR;
    }

    //FIX nd getting trashed

    if (from->getND() > 10000 || from->getND() <= 0) {
	DBPERROR( "to %s from %s nd %d \n", name, from->name, from->getND());
       	throw ARRAY_BOUNDS_ERROR;
    }

    newnd = from->getND();

    //  dbprintf(DBSIV," newnd %d from->getND() %d nd %d\n",newnd,from->getND(),nd);

    if (newnd <= 0)
	newnd = 1;

    if (from->getND() == 0) {
	DBPERROR( "nd %d resetting to 1\n", from->getND());
    }

    if (nd < newnd) {

	if (!setArrayNDB(newnd)) {
	    DBPERROR(" CopyBounds can't reallocbounds \n")
	    throw NOTOK;
	}
	
    }

    setND(from->getND());

    for (int i = 0; i < from->getND(); i++) {
        setBounds(i, from->getBounds(i));
	//        DBP("[%d] bd %d\n",i,from->getBounds(i));
    }

    CheckBounds();

#if 0
    tbp = (int *) getpBounds();
    fbp = (int *) from->getpBounds();


    if (fbp == NULL) {
	DBPERROR(" nd %d from bounds NULL \n", from->getND());
	throw -2;
    }

    for (int i = 0; i < from->getND(); i++) {
      DBPF("[%d] bd %d\n",i,*fbp);

	*tbp++ = *fbp++;
    }
#endif

    }

    catch (int e) {

      ok = 0;

      if (e == 0) {
         ok = 1;
//         DBP("no bounds to copy \n");
      }
      else {
      DBP("error %d\n",e);
      }
    }

    DBPF(" %s now has nd %d sz %d bounds[0] %d\n",name, nd, size, getBounds(0));


 return ok;
}
//[EF]===================================================//


int
Aop::checkVectorBounds (int n, int wtype)
{
  /// this will extend create the array if n > then current size and is DYNAMIC 

  int retval = 0;
  int maxav;
  int unset_offset;

  // or generic ?
  /*

  if (type != wtype)
    {
      DBPERROR ("%s %d slot type %d  %d\n", name, slot, type, wtype);
      //serror (ARRAY_ERROR, " wrong array type");
      whatError(ARRAY_ERROR);
    }
  else {
  // single dimn array 
  maxav = size - offset;

  DBPF("maxav %d offset %d needed %d name %s\n", maxav, offset, n, name);

  if (n > maxav)
    {
      if (testCW (DYNAMIC_ARRAY) && ReallocMem (type, ((n - maxav) + size)))
	{
	  DBPF("realloc array %s %d\n", name, n);
	  maxav = n;
	}
      else
	{
	  DBPERROR
	    ("array %s outside bounds need %d have %d size %d offset %d\n",
	     name, n, maxav, getBounds(0), offset);
	}
    }

  //  dbp("maxav %d size %d\n",maxav,size);
  retval = maxav;

  }
*/
  


  return retval;
}
//[EF]===================================================//

int
Aop::setArrayNDB (int newnd)
{
  // DBP(" %d\n",newnd);
  //  set the ND and construct bounds
  //  size and type may be unknown

  
  int ret = 0;
  ret = ReallocBounds (nd);
  if (ret)
    {
      nd = newnd;
    }
  else
    nd = 0;
  return ret;
}

//[EF]===================================================//
int Aop::getInnerStep( )
{
  int step = 0;



      if (getND() > 1) {
	step = 1;
	for (int i = 1; i < getND(); i++) {
           step *= bounds[i];
	}
      }



  return step;
}
//[EF]===================================================//
int
Aop::SetUpSubi ()
{
  int _dbl =1;
  int rtok = 1;

  
  try
  {

    freeSubi ();

    DBPF  ("%s %d sz %d %d\n", name, nd, size, getBounds (0));

    CheckBounds ();

    if (nd > MAXDMN || nd <= 0)
      {
	DBW(" nd %d - assuming 1 should be used size %d\n", nd, size);
	//	nd =1;

		setND(1);
		setBounds(0,size);

	 CheckBounds ();
	
	
      }

    subi = (char **) scalloc_id (nd + 2, sizeof (char *),__FUNCTION__);

    if (subi == NULL)
      {
	DBPERROR (" - array subscriptcalloc \n");
	throw - 2;
      }


    for (int i = 0; i < nd; i++)
      {

	subi[i] =
	  (char *) scalloc_id ((getBounds (i) + PAD_SUBI), sizeof (char),__FUNCTION__);

	//DBT ( "%s subi %d address %d %d\n", getName(), i, subi[i], getBounds(i));

	if (subi[i] == NULL)
	  {
	    DBPERROR (" - array subscriptcalloc %d \n", i);
	    for (int j = 0; j < i; j++)
	      {			//clean up
		sfree (subi[j]);
		subi[j] = 0;
	      }
	    sfree (subi);
	    subi = 0;
	    throw - 3;
	  }
      }

    subi_nd = nd;

    //setCW (SUBI, ON);
  }

  catch (int e)
  {

    rtok = 0;
  }

  /*
  if (!testCW (SUBI))
    {
      DBP ("error failed to set SUBI\n");
    }
  */
  
  return rtok;
}
//[EF]===================================================//
void
Aop::freeSubi ()
{

  
  //  DBT(" %s\n",info());

  if (subi != NULL && (subi_nd) > 0)
    {

      //DBP("%s nd %d ndi %d subi  %d\n", getName(),nd, aop->subi_nd, aop->subi);

      for (int i = 0; i < subi_nd; i++)
	{

	  DBPF( "FREE? subi[%d]  %p\n", i, subi[i]);
	  if (subi[i] != NULL)
	    {
	      sfree (subi[i]);
	      subi[i] = 0;	// they should have been allocated
	    }
	}

      sfree (subi);
      subi = 0;
      subi_nd = 0;
      //setCW (SUBI, OFF);
    }

}

//[EF]===================================================//

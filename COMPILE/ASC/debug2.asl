/* 
 *  @script debug.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.15 P Phosphorus [asl 6.3.69 C-Li-Tm] 
 *  @date 01/04/2022 11:44:51          
 *  @cdate 1/1/2014 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2022 → 
 * 
 */
//-----------------<v_&_v>--------------------------//


int hold_dbl = _dblevel;
int dblevel = _dblevel;
Str _Use = "??";

int _DB = -1 ;// dbg FH set to nop --set to 2 for error output;

void DummyP ()
{
// $_proc  called if $pname() does not resolve to known Proc

  printf (" _proc called if invalid proc name\n");

}

//==========================

void debugON ()
{

  if (dblevel < 1)
    {

      _dblevel = 1

    }




  setmaxcodeerrors (-1);	//  unlimited

  setmaxicerrors (-1);


  _DB = ofw ("${_script}.err");



  printf ("_dblevel %d\n", _dblevel);



}

//==========================

void debugOFF ()
{
#if ASL
  setdebug (-1, _ ~ pline, _ ~ step, _ ~ trace, _ ~ showresults, 1);

  filterFuncDebug (REJECTALL_, "proc");

  filterFileDebug (REJECTALL_, "yyy");
#endif
  _dblevel = 0;

  _DB = -1;

}

//==========================

void ignoreErrors ()
{

  setmaxcodeerrors (-1);	// just keep going;
  setmaxicerrors (-1);
}

//==========================

void setNICerrors (int n)
{

  setmaxicerrors (n);
}

//==========================

void showUse ()
{

  <<"%V $_Use\n"
}






#if ASL
_dblevel = hold_dbl;
sdb (hold_dbl, _keep, _ ~ trace);
#endif

//////////
//<<" %V $_include  $_dblevel DONE debug.asl\n"
///
///  while (1) {
///     resetDebug();
///  ...
///  }
// include or insert this for debugging scripts
// use resetDebug() at start of loops - to prevent very large
// idb or xdb files
// comments not in exe!!

//==============\_(^-^)_/==================//

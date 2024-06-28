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

//<<"Including  debug \n"

_dblevel = getDebugLevel()

  hold_dbl = _dblevel;
int dblevel = _dblevel;

int _DBH = -1; // dbg FH set -1 for nop --set to 2 for error output;

//<<"%V   $_dblevel\n"
Str _My_script = getScript()
Str _Usage = " ... "

// if there are errors keep  idb,xdb file in .GASP/WORK/Debug
// will be overwritten by scripts  unless unique/local options used

DB_prompt = "go_on? : [y,n,!q]"

int DB_action = 1;
int DB_ask = 0;
int DB_allow = 0;
int DB_step = 0;

//[EP]==========================

  void DummyP()
  {
// $_proc  called if $pname() does not resolve to known Proc

  <<" $_proc called if invalid proc name\n";

  }
//[EP]==========================

  void debugON()
  {

   <<" Debugging $_My_script %V   $_dblevel - just a simple debug?\n"

    if (_dblevel < 1) {
      _dblevel = 0;
    }


  setmaxcodeerrors(-1); //  unlimited

  setmaxicerrors(-1);

   _DBH =2;

 //<<[_DBH]"Script is $_script\n";

  }

//[EP]==========================
void errorFile()
{
   _DBH=ofw("${_script}.err");
  <<[_DBH]"Script is $_script\n";
}

//[EP]==========================

void debugOFF()
  {



  filterFuncDebug(REJECT_ALL_,"proc");
  filterFileDebug(REJECT_ALL_,"yyy");

  _dblevel = 0;

  _DBH= -1;

  }
//==========================

  void ignoreErrors()
  {

  setmaxcodeerrors(-1); // just keep going;
  setmaxicerrors(-1);
  }
//==========================

  void setNICerrors( int n)
  {

     setmaxICerrors(n);
  } //==========================

  void showUsage(Str usage)
  {
    _Usage = usage;
    <<"asl $_My_script    \n\t$_Usage\n";
  }


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

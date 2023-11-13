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
 // filterFuncDebug(REJECTALL_,"proc");

 // filterFileDebug(REJECTALL_,"yyy");

int hold_dbl = _dblevel;
int dblevel = _dblevel;

  int _DBH = -1; // dbg FH set -1 for nop --set to 2 for error output;


Str _My_script = getScript()
Str _Usage = " ... "

//<<"%V$hold_dbl \n"

//sdb(1,@~pline,@~step,@~trace)

//sdb(dblevel,@~pline,@~step,@~trace)
//filterFuncDebug(REJECTALL_,"proc");
//filterFileDebug(REJECTALL_,"yyy");


//<<"%V $hold_dbl\n"
//dblevel = -1;

// working variables

//_IV = vgen(INT_,10,0,1)
//_DV = vgen(DOUBLE_,10,0,1)
//Str _S = "abcde";
//Svar _SV;
//Pan _P ;
//_P= 4.0*atan(1.0);
//!p _P
//dbid = IDof("_DBH");
//<<"%V dbid _DBH\n"
//sdb(1,@keep);
// if there are errors keep  idb,xdb file in .GASP/WORK/Debug
// will be overwritten by scripts  unless unique/local options used
void askit(int ask)
{
Str ans;
	  if (ask) {
       ans = query("ok? : [y,n,q]")
       if (ans @= "q") {
            exit(-1)
        }

       }
}
//[EP]==========================

  void DummyP()
  {
// $_proc  called if $pname() does not resolve to known Proc

  <<" $_proc called if invalid proc name\n";

  }
//==========================

  void debugON()
  {

   <<" debugging $_My_script \n\n"

    if (dblevel < 1) {
      _dblevel = 1;
    }

 


//<<"%V $_DBH ALLOWALL debug from files and funcs\n"
//<<"use filterFuncDebug() filterFileDebug() to control\n"
//sdb(dblevel,_keep,_~pline,_trace)
//filterFuncDebug(ALLOWALL_,"xxx");
//filterFileDebug(ALLOWALL_,"yyy");

  setmaxcodeerrors(-1); //  unlimited

  setmaxicerrors(-1);

//  _DBH =2;


   _DBH=ofw("${_script}.err");
  <<[_DBH]"Script is $_script\n";

  }
//==========================

  void debugOFF()
  {

  setdebug(-1,_~pline,_~step,_~trace,_~showresults,1);

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
  }
//==========================

  void showUse(Str useage)
  {
    _Useage = useage;
    <<"asl $_My_script $_Useage\n";
  }

  _dblevel = hold_dbl;

  sdb(hold_dbl,_keep,_~trace);


  if (_dblevel > 1) {
  
  //sdb(_dblevel,_keep,_trace)
  
   printf("_dblevel %d\n",_dblevel);

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

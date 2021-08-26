/* 
 *  @script debug.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.14 Si Silicon [asl 6.3.16 C-Li-S] 
 *  @date Sat Feb  6 06:54:04 2021 
 *  @cdate  1/1/2014  
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//-----------------//                                                      


//<<"Including  debug \n"

//sdb(-1,@~pline,@~step,@~trace)

//sdb(_dblevel,@~pline,@~step,@~trace)
//filterFuncDebug(REJECTALL_,"proc");
//filterFileDebug(REJECTALL_,"yyy");


// working variables
int _DB = -1; // dbg FH set to nop --set to 2 for error output

_IV = vgen(INT_,10,0,1)

_DV = vgen(DOUBLE_,10,0,1)

Str _S = "abcde";
Svar _SV;

Pan _P ;

_P= 4.0*atan(1.0);

//!p _P


dbid = IDof("_DB");
//<<"%V dbid _DB\n"



//sdb(1,@keep);
// if there are errors keep  idb,xdb file in .GASP/WORK/Debug
// will be overwritten by scripts  unless unique/local options used



proc DummyP()
{
// $_proc  called if $pname() does not resolve to known Proc
<<" $_proc called if invalid proc name\n" 
}
//==========================


proc debugON()
{

if (_dblevel < 1) {
     _dblevel = 1;
 }

//<<"%V $_DB ALLOWALL debug from files and funcs\n"
//<<"use filterFuncDebug() filterFileDebug() to control\n"
//sdb(_dblevel,@keep,@~pline,@trace)
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");
setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);
_DB =1;
}
//==========================

proc debugOFF()
{

setdebug(-1,@~pline,@~step,@~trace,@~showresults,1)
filterFuncDebug(REJECTALL_,"proc");
filterFileDebug(REJECTALL_,"yyy");
_dblevel = 0;
_DB=-1
}
//==========================

proc ignoreErrors()
{
setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);
}
//==========================
proc allowErrors(int n)
{
setmaxcodeerrors(n); // just keep going
setmaxicerrors(n);
}
//==========================
proc turnDEBUG(int on)
{

   if (on) {
     debugON()
   }
   else {

     debugOFF()
   }
   

}
//==========================
proc setNICerrors( int n)
{
 setmaxICerrors(n)
}
//==========================



proc showUse()
{
  <<"$Use_\n"
}


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
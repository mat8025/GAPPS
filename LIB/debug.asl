//%*********************************************** 
//*  @script debug.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.11 Na Sodium                                                 
//*  @date Thu Dec 27 07:41:32 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


<<"Including  debug \n"

int _DB = -1; // dbg FH set to nop --set to 2 for error output

dbid = IDof("_DB");
//<<"%V dbid _DB\n"

setdebug(1,@keep);
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

setdebug(1,@keep,@~pline,@~step,@~trace)
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


}
//==========================

proc debugOFF()
{

setdebug(-1,@~pline,@~step,@~trace,@~showresults,1)
filterFuncDebug(REJECTALL_,"proc");
filterFileDebug(REJECTALL_,"yyy");
}

proc scriptDBON()
{
  _DB = 2;
}

proc scriptDBOFF()
{
<<"setting _DB to $_DB\n"
  _DB = -1;
}

proc setNICerrors( int n)
{
 setmaxICerrors(n)
}
//==========================

<<" %V $_include  DONE debug.asl\n"

///
///  while (1) {
///     resetDebug();
///  ...
///  }


// include or insert this for debugging scripts
// use resetDebug() at start of loops - to prevent very large
// idb or xdb files
// comments not in exe!!
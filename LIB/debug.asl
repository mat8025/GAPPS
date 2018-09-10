///
/// debug.asl
///


setdebug(0,@keep);
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

setdebug(0,@~pline,@~step,@~trace,@~showresults,1)
filterFuncDebug(REJECTALL_,"proc");
filterFileDebug(REJECTALL_,"yyy");
}

//==========================

<<" %V $_include \n"

///
///  while (1) {
///     resetDebug();
///  ...
///  }


// include or insert this for debugging scripts
// use resetDebug() at start of loops - to prevent very large
// idb or xdb files

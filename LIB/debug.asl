///
/// debug.asl
///




proc DummyP()
{
// $_proc  called if $pname() does not resolve to known Proc
<<" $_proc called if invalid proc name\n" 
}
//==========================


proc debugON()
{

setdebug(1,@keep,@~pline,@~step,@~trace)
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_op");


}
//==========================

proc debugOFF()
{

setdebug(0,@~pline,@~step,@~trace,@~showresults,1)
filterFuncDebug(REJECTALL_,"proc");
filterFileDebug(REJECTALL_,"ic_op");
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

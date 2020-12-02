//%*********************************************** 
//*  @script debug.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.12 Mg Magnesium [asl 6.2.91 C-He-Pa]                          
//*  @date Mon Nov 30 08:52:56 2020 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


//<<"Including  debug \n"

sdb(-1,@~pline,@~step,@~trace)

//sdb(_dblevel,@~pline,@~step,@~trace)
filterFileDebug(ALLOWALL_,"yyy");
filterFuncDebug(REJECTALL_,"xxx");

int _DB = -1; // dbg FH set to nop --set to 2 for error output

dbid = IDof("_DB");
//<<"%V dbid _DB\n"



//sdb(1,@keep);
// if there are errors keep  idb,xdb file in .GASP/WORK/Debug
// will be overwritten by scripts  unless unique/local options used



void DummyP()
{
// $_proc  called if $pname() does not resolve to known Proc
<<" $_proc called if invalid proc name\n" 
}
//==========================


void debugON()
{

if (_dblevel < 1) {
     _dblevel = 1;
 }

//<<"%V $_DB ALLOWALL debug from files and funcs\n"
//<<"use filterFuncDebug() filterFileDebug() to control\n"
//sdb(2,@keep,@~pline,@~step,@~trace)
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");
setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);
_DB =1;

}
//==========================

void debugOFF()
{

setdebug(-1,@~pline,@~step,@~trace,@~showresults,1)
filterFuncDebug(REJECTALL_,"proc");
filterFileDebug(REJECTALL_,"yyy");
_dblevel = 0;
_DB=-1
}

void turnDEBUG(int on)
{

   if (on) {
     debugON()
   }
   else {

     debugOFF()
   }
   

}

void setNICerrors( int n)
{
 setmaxICerrors(n)
}
//==========================



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
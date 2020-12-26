//%*********************************************** 
//*  @script proc_str_ret.asl 
//* 
//*  @comment test proc return of Str 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.98 C-He-Cf]                               
//*  @date Tue Dec 22 21:48:53 2020 
//*  @cdate Tue Dec 22 21:48:53 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///   test proc str return
///

Str say()
  {
   <<"$_proc hey there I exist\n"
   isay="hey hey"
   <<"$isay $(typeof(isay))\n"
   return isay;
  }

//setDebug(1,"trace","keep","~stderr")

chkIn()

ws = say()


<<"$ws $(typeof(ws))\n"

chkStr(ws,"hey hey");

chkOut();
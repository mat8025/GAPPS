//%*********************************************** 
//*  @script chknum.asl 
//* 
//*  @comment test if string is a number format 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 13:48:52 2020 
//*  @cdate Thu Apr  2 13:48:52 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  test str is a number str
///


#include "debug"

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOW_,"proc_","args_","scope_","class_");

debugON()
setdebug(1,@pline,@~trace)

nstr="";

while (1) {

nstr= iread("type a number str:")

 type = isanumber (nstr)

if (nstr @= "quit")
  break;
<<"%V $nstr $type\n"



}
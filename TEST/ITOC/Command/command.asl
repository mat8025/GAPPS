//%*********************************************** 
//*  @script command.asl 
//* 
//*  @comment test shell command & 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Mon Dec 28 13:33:21 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
#

#include "debug.asl";



if (_dblevel >0) {
   debugON()
}


 ignoreErrors();


chkIn()

//  issue shell command

//E=!!"./pan_type"
//<<"$E\n"

ret= !!" date > keep-the-date "

<<"%V $ret \n"


!!" date "

Str  ws 
vs = "a str"

<<"%I $ws \n"
<<"%I $vs \n"


vs = "command"

chkStr(vs,"command")

svar wd

wd= !!"asl -cwl AAA_COMMAND.asl"

<<"%V$wd \n"

//ans=query("OK?");

wd = !!" date "


<<"%V$wd \n"

//ans=query("OK?")

wd = !!" pwd "


<<"%V$wd \n"
//ans=query("OK?")

wd = !!" ls "


<<"result of ls is :\n%(1,, ,\n)$wd \n"
<<"$wd[0] $wd[1] \n"



  ws = wd[0]

<<"%I$ws \n"

<<"%V$ws \n"

 if (ws @= "AAA_COMMAND") {

<<" ls correct $ws @= command\n")

 }




vs = "AAA_COMMAND"


 if (ws @= vs) {

<<" ls correct $ws @= $vs\n")

 }


chkStr(ws,"AAA_COMMAND")

chkStr(wd[0],"AAA_COMMAND")


chkStr(ws,vs)

chkStr(ws,vs)


chdir("../")

!!"pwd"

!!"ls"


foo="Command"

chdir(foo)

!!"pwd"

//!!"asl ./pan_type"

//<<"%V$CE\n"


CE=!!"date"
<<"%V$CE\n"



chkOut()

//exit(1)



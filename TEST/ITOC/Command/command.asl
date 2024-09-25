/* 
 *  @script command.asl                                                       
 * 
 *  @comment  shell command &                                                 
 *  @release Carbon                                                           
 *  @vers 1.4 Be Beryllium [asl 6.54 : C Xe]                                  
 *  @date 09/25/2024 05:03:55                                                 
 *  @cdate 1/1/2005                                                           
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2024 -->                                     
 * 
 */ 


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


!!" date "
!!"pwd"
!!"whoami"

ret= !!" date > keep-the-date "

<<"%V $ret \n"

ask()

ans=ask(" $ret OK?")
<<"%V $ans\n"


Str  ws 
vs = "a str"

   ws.pinfo()
   vs.pinfo()
   


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

 if (ws == "AAA_COMMAND.asl") {

<<" ls correct $ws == command\n")

 }




vs = "AAA_COMMAND.asl"


 if (ws == vs) {

<<" ls correct $ws @= $vs\n")

 }


chkStr(ws,"AAA_COMMAND.asl")

chkStr(wd[0],"AAA_COMMAND.asl")


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



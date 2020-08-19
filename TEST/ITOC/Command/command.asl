#
setdebug(1)

//  issue shell command
chkIn()

//E=!!"./pan_type"
//<<"$E\n"
!!" date "

str  ws 
vs = "a str"

<<"%I $ws \n"
<<"%I $vs \n"


vs = "command"
chkStr(vs,"command")



CRET= !!"asl -cwl AAA_COMMAND.asl"

<<"%V$CRET \n"

svar wd
wd = !!" date "


<<"%V$wd \n"


wd = !!" pwd "


<<"%V$wd \n"


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


chdir("Base")

!!"pwd"

!!"ls"

chdir("../")

!!"pwd"

foo="Base"

chdir(foo)

!!"pwd"




//!!"asl ./pan_type"

//<<"%V$CE\n"


CE=!!"date"
<<"%V$CE\n"

updir()

chkOut()

;

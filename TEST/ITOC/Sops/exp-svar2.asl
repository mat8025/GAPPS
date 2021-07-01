<|Use_=
Demo  of svar;
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}



chkIn()


ws= scat("un"," dia")


<<"$ws\n"

chkStr(ws,"un dia")


ws2= scat(scat("un"," dia")," pronto")

<<"func in args <|$ws2|>\n"

chkOut()
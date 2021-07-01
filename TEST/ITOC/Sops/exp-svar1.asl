
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

svar Sv = "una larga noche"

Sv->info(1)

<<"%V $Sv\n"

tv = Sv

<<"$tv\n"

<<"%V $tv\n"

tv->info(1)

chkStr(Sv[0],  "una larga noche")

Sv[1] = "tenter cela, c'est tempérer le destin"

<<"%V $Sv\n"

Sv->info(1)


Sv[2] = "intentar esto es templar el destino"


Sv[3] = "Dies zu versuchen ist, das Schicksal zu tempeln"


<<" %(1,,,\n) $Sv\n"

Sv->info(1)

chkOut()
///
///
///

include "debug.asl"
debugON()
setdebug(1,@keep,@pline)
FilterFileDebug(REJECT_,"storetype_e","ds_storevar")



checkIn();


svar Wans;

//   Wans[0] = "stuff to do";
Wans = "stuff to do";

<<"sz $(Caz(Wans)) $Wans\n"

W=testargs(1,Wans)

<<"%(1,,,\n)$W\n"


Wans[3] = "more stuff to do";

<<"sz $(Caz(Wans)) $Wans\n"

S=testargs(1,Wans)

<<"%(1,,,\n)$S\n"



Wans->resize(12)
Wans->info(1)
sz= Caz(Wans)

<<"sz $(Caz(Wans)) $Wans\n"
checkNum(sz,12)

Wans[9] = "keeps going"
    
<<"sz $(Caz(Wans)) $Wans\n"
Wans->info(1)


M=testargs(1,Wans)


<<"%(1,,,\n)$M\n"



Wans->resize(5)

<<"sz $(Caz(Wans)) $Wans\n"
sz= Caz(Wans)
checkNum(sz,5)

Wans->info(1)

R=testargs(1,Wans)

<<"%(1,,,\n)$R\n"

<<"%V $(Typeof(Wans)) $Wans\n"

Wans->info(1)
delete(Wans);
//Wans->info(1)


checkOut();



exit()





//%*********************************************** 
//*  @script resize.asl 
//* 
//*  @comment test resize ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri Apr 17 14:18:41 2020 
//*  @cdate Fri Apr 17 14:18:41 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
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



   Wans = "stuff to do";

<<"sz $(Caz(Wans)) $Wans\n"

W=testargs(Wans)

<<"%(1,,,\n)$W\n"

//ans = iread();
Wans[3] = "more stuff to do";

<<"sz $(Caz(Wans)) $Wans\n"

S=testargs(Wans)

<<"%(1,,,\n)$S\n"

//ans = iread();

   Wans->resize(10)

<<"sz $(Caz(Wans)) $Wans\n"

    Wans[9] = "keeps going"
    
<<"sz $(Caz(Wans)) $Wans\n"

delete(W)
W=testargs(Wans)


<<"%(1,,,\n)$W\n"

//ans = iread();

   Wans->resize(5)

<<"sz $(Caz(Wans)) $Wans\n"


R=testargs(Wans)

<<"%(1,,,\n)$R\n"

<<"%V $(Typeof(Wans)) $Wans\n"

<<"resize svar to sz 1 \n"

 Wans->resize(1)

<<"sz $(Caz(Wans)) $Wans\n"
<<"check args \n"


R1=testargs(Wans)

<<"%(1,,,\n)$R1\n"


//ans = iread();


delete(Wans);


Wans="again";

L=testargs(Wans)

<<"%(1,,,\n)$L\n"

<<"%V $(Typeof(Wans)) $Wans\n"



checkStage("svar");


int V[20];


 V[10] = 47;

checkNum(V[0],0)
checkNum(V[10],47)
checkNum(V[19],0)
<<"$V\n"


//V->resize(30)

//V->info(1)

resize(V,30);


 V[20] = 80;
checkNum(V[20],80)
checkNum(V[29],0)
<<"$V\n"


//  should give error --- not dynamic

V[30] = 79;

checkNum(V[30],79)



<<"$V\n"
TR=testargs(1,V)


 resize(V,40);

V[35] = 80;

checkNum(V[35],80)

<<"%(1,,,\n)$TR\n"

 resize(V,6,6);

 V[0][3] = 79;
checkNum(V[0][3],79)


<<"$V\n";

TR=testargs(1,V)

<<"%(1,,,\n)$TR\n"




 Delete(V);



float V = 4*atan(1.0)
<<"%V $(Caz(V)) $V\n"


TR2=testargs(1,V)

<<"%(1,,,\n)$TR2\n"

checkOut();








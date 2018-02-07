///
///
///


checkIn();


svar Wans;

//   Wans[0] = "stuff to do";
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



exit()


checkOut();


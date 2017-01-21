setDebug(1)

checkIn()

record R[10];



 R[0] = Split("each to his own")
 R[1] = Split("and the devil take the hindmost")
 R[2] = Split("but everybody counts don't they matey")
 R[3] = Split("this is the 4th record")

<<"$R[0]\n"

<<"$R[0][0] \n"

<<"$R[0][3] \n"

svar S

  S= R[0];

 sz= Caz(R[0]);

<<"R0sz $sz\n"

<<"$S\n";

 sz= Caz(S);

<<"Ssz $sz\n"

W= Split("each to his own")

 sz= Caz(W);

<<"Wsz $sz\n"

///
///
///



<<"$S[1]\n";

<<"%(2,\s->,\,,<-\n)$S\n"

<<"$R[1]\n"

 sz= Caz(R[1]);

<<"R1sz $sz\n"

  S= R[1];



<<"$S\n";

sz= Caz(S);
<<"Ssz $sz\n"

<<"S1: $S[1]\n";


<<"%(2,\s->,\,,<-\n)$S\n"



//<<"%(2,\s->,\,,<-\n)$R[1]\n"

Rn = 4;
svar s;

for (ir = 0; ir < Rn; ir++) {

     s= R[ir];

    sz= Caz(s);
    <<"$ir $sz s: $s\n\n"
    if (ir == 0) {
     checkStr(s[0],"each");
    }
    if (ir == 1) {
     checkStr(s[0],"and");
    }
    
<<"%(2,\s->,\,,<-\n)$s\n"
<<"%(2,\s->,| |,<-\n)$s\n"

}

svar t;
     t= R[2];
    
    <<" t: $t\n"
  //  S= Split(t)
<<"%(2,\s->,\,,<-\n)$t\n"


<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"
<<"$R[3]\n"


ir = 3

<<"$R[ir]\n"


     s= R[ir];
    
    <<"$ir s: $s\n"
    S= Split(s)
    
<<"%(2,\s->,\,,<-\n)$S\n"

checkOut();
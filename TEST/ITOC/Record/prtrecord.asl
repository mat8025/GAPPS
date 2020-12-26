//%*********************************************** 
//*  @script prtrecord.asl 
//* 
//*  @comment test record print 
//*  @release CARBON 
//*  @vers 1.76 Os Osmium                                                 
//*  @date Sat Jan 12 12:17:53 2019 
//*  @cdate 9/12/2015 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


#include "debug.asl"

debugON();


//setDebug(1,@pline,@trace,"~step")

chkIn(_dblevel)

record R[10];



 R[0] = Split("each to his own")
<<"$R[0]\n"
R->info(1) 
 R[1] = Split("and the devil take the hindmost")
<<"$R[1]\n"
R->info(1)
 R[2] = Split("you are as strong as your will")
<<"$R[2]\n"
R->info(1)

R[3] = Split("this is the 4th record")
<<"$R[3]\n"
R->info(1)

sz =Caz(R)
ncols = Caz(R[0])
ncols1 = Caz(R[1])
ncols2 = Caz(R[2])

<<"%V $sz $ncols $ncols1 $ncols2\n"


<<"$R[0]\n"
R->info(1) 








svar S;

  S= R[1];

  ssz= Caz(S);

  rsz= Caz(R);
  colsz= Caz(R,0);

<<"%V $rsz $colsz $ssz\n"

<<"$S[0]\n"

<<"$S[2]\n"

<<"$S\n"


<<"$R[1][2] \n"

wrd="$R[1][3]"
<<"$wrd R[1][3] $R[1][3] \n"


wrd="$R[2][3]"
<<"wrd <|$wrd|>\n"
chkStr(wrd,"strong");



<<"all?R $R \n"



<<"all?R[::] $R[::] \n"


<<"R[1:3] $R[1:3:] \n"

<<"R[2] $R[2] \n"

<<"R[1] $R[1]\n"


  NR = R;

<<"R[1] $R[1]\n"


 wrd = R[1][2]

chkStr(wrd,"devil")


 wrd = R[3][4]

chkStr(wrd,"record")


sz = Caz(NR);
<<" $(typeof(NR)) $sz elements\n"

<<"2 $NR[2] \n"
<<"3 $NR[3] \n"

 wrd = NR[1][2]

chkStr(wrd,"devil")


 wrd = NR[3][4]

chkStr(wrd,"record")



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

<<"S[1] $S[1]\n";

<<"%(2,\s->,\,,<-\n)$S\n"

<<"R[1] $R[1]\n"

  sz= Caz(R[1]);

<<"R1sz $sz\n"

  S = R[1];

<<"$S\n";

sz= Caz(S);
<<"Ssz $sz\n"

//exit()

<<"S1: $S[1]\n";


<<"%(2,\s->,\,,<-\n)$S\n"



//<<"%(2,\s->,\,,<-\n)$R[1]\n"

//chkOut();
//exit();

Rn = 4;
svar s;

for (ir = 0; ir < Rn; ir++) {

     s= R[ir];

    sz= Caz(s);
    <<"$ir $sz s: |$s[0]|\n\n"
    if (ir == 0) {
     chkStr(s[0],"each",4);
    }
    if (ir == 1) {
     chkStr(s[0],"and",3);
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
    //S= Split(s)
    
//<<"%(2,\s->,\,,<-\n)$S\n"

chkOut();
exit();
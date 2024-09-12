//%*********************************************** 
//*  @script args.asl 
//* 
//*  @comment test args processing 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.73 C-He-Ta]                               
//*  @date Tue Sep 22 06:42:12 2020 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///
#include "debug";


   if (_dblevel >0) {

     debugON();

     }
//openDll("plot")

   db_ask = 0

   myScript = getScript();

   myScript.pinfo();

   <<"%V $myScript \n";

nas = "47"
chkStr(nas,"47");

ans = ask("%V $nas ",db_ask);



   int na;

   Svar sa;

   na = _clargc;

   <<"%V $_clargc \n";

   sa = _clarg;

   <<"sa $sa[0] $sa[1] \n";

   char c = '?';

   <<"%v $c\n";

   float f = atan(1.0) *4;

   f.pinfo();

   F=vgen(INT_,5,20,1);

   <<"%V $F \n";

   pinfo(F);

   D = vgen(FLOAT_,20,10,1);

   pinfo(D);

   D.redimn(2,5,2);

   pinfo(D);
//svar help="Ayudame ahora"

   Svar help;

   help[0] = "Ayudame ahora";

   help[1] = "que esta pasando?";

   pinfo(help);
//Pan P = exp(1.0); // TBF

   Pan R;

   R = exp(1.0);

   P = &R;

   k = 0;

   A = testargs(k++,help,47,f,"hey",1.2,1,',',"*",c,F,D,R,P,_Whue,"red",&F[2]);

   sz= Caz(A)

   <<"%(1,-->, , \n)$A\n";

ans= ask("%V $sz  $A[11]",db_ask)

   <<"%V$k \n";

   chkN(k,1);

   int b = ',';

   <<"%V %c $b $(',') $c\n";

   for (i = 0; i < sz; i++) {

     <<"<$i>  $A[i] \n";

     }

   aval = A[11];

ans= ask("%V $aval  $A[11]",db_ask)
   <<"%V $ans\n"
//   chkStr(aval,"47");

   <<"$help\n";

   c_index = 0;

   ret=testargs(c_index++);

   <<"%V$c_index \n";

   chkN(c_index,1);

   c_index = 0;
//   openDLL ("plot")
   setRGB(++c_index);

   <<"%V$c_index \n";

   chkN(c_index,1);

   chkOut();

//==============\_(^-^)_/==================//


/*
    want getargvalue as string



*/
//%*********************************************** 
//*  @script swab.asl 
//* 
//*  @comment test swap function 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sun Mar 10 08:42:29 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl";


debugON();
  setdebug(1,@keep,@pline,@trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);

chkIn()

uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE };


<<" $C[0]  $C[1]\n"
<<" $(typeof(C)) \n"
<<" $C \n"

<<"%x $C \n"

C->Info(1)




chkN(C[0],0xCA)
chkN(C[11],0xDE)



// just copy
<<" just assign/copy to new vector \n"
D = C
<<"D $D\n"
// convert

   retype(D,INT_)

<<" $(typeof(D)) \n"
<<"D[]  $D \n"
<<"D[]  %x $D \n"
D->info(1)

swab(D)

<<"D[]  %x $D \n"

E=D
<<" $(typeof(E)) \n"
<<"E[]  %x $E \n"
   retype(E,CHAR_)
<<" $(typeof(E)) \n"
<<"E[]  %x $E \n"
E->Info(1)

uchar U[] ;
U = E;
U->Info(1)
<<"U[]  %x $U \n"

uchar c0;
uchar c1 = 0xFE;
c0 = 0xCA;
//c1 = 0xBE;
<<"%x $c0 $c1\n"

bscan(U,0,&c0,&c1)

<<"%x $c0 $c1\n"
c0->info(1)
c1->info(1)

chkN(c0,0xBE)
chkN(c1,0xBA)

chkOut()

exit()

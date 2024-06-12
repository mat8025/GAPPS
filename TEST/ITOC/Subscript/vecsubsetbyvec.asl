//%*********************************************** 
//*  @script vecsubsetbyvec.asl 
//* 
//*  @comment test vector subset ops
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

<|Use_=
Demo  of vector subset by vec
e.g. int H = {2,4,7};
B=vgen(INT_,20,0,1);
B[H] = 34;
eles 2,4,7 of vec B set to 34
///////////////////////
|>



#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e","ds_storesiv");
filterFuncDebug(REJECT_,"vrealloc","init");


chkIn()

int a = 61;
int b = 62;
int c = 63;
int d = 64;


int CDL[] = {2,4,7,a,b,(c*3)}



<<"$CDL \n"

chkN(CDL[0],2)
chkN(CDL[2],7)

chkN(CDL[4],62)
chkN(CDL[5],(c*3))

chkOut()


B=vgen(INT_,20,0,1)

<<"%V$B\n"

chkN (B[0],0)q
chkN (B[4],4)

int H[3] = {2,4,7}

<<"%V$H \n"

 B[H] = 34;

<<"%V$B\n"
chkN (B[2],34)
chkN (B[3],3)
chkN (B[7],34)
B->info(1)

<<"%V$B\n"

<<"%V$B[7]\n"
<<"%V$B[19]\n"

int J[4] = {2,4,7,11}

C= B[J]

<<"%V$C\n"
chkN (C[0],34)
B->info(1)

<<"%V$B\n"
<<"%V$B[0]\n"
<<"%V$B[7]\n"
<<"%V$B[11]\n"
<<"%V$B[19]\n"
<<"%V$B\n"
chkOut()

 B[2,4,7] = 36;




chkN (B[7],36)


<<"%V$B[2,4,7,8]\n"


chkOut()
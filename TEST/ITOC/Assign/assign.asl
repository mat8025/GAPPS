//%*********************************************** 
//*  @script assign.asl 
//* 
//*  @comment test assign values to variables arrays 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                            
//*  @date Tue Dec 22 09:34:43 2020 020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


chkIn(_dblevel)


prog = GetScript()

<<"Running $prog\n"

av = 80;
<<"%V $av\n"


char A[20];

 for (i= 1; i < 20; i++) {
 
  A[i] = i;

<<"$i $A[i]\n"
chkN(A[i],i)

 }

<<"$A\n"




k = 0



  sz = Caz(A)
  chkN(sz,20)
  bd = Cab(A)
  gt = typeof(A)

chkStr(gt,"CHAR");

<<"%V$sz $bd $gt \n"
  A[0] = k
  B = A
  C = A

  B = B + 10

  sz = Caz(B)
  bd = Cab(B)

  gt = typeof(B)

<<"%V$sz $bd $gt \n"

  C *= 2

  sz = Caz(C)
  bd = Cab(C)
  gt = typeof(C)

<<"%V$sz $bd $gt \n"

<<"$C \n"
// if (k++ > 2)     break
//
//}

chkN(C[1],2)

Str s ="OK"

chkStr(s,"OK")

chkOut()


//////////////////////////////  TBD ///////////////////////////////
/*

1. add more types 
2. MD arrays


*/

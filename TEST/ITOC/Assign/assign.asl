/* 
 *  @script assign.asl 
 * 
 *  @comment test assign values to variables arrays 
 *  @release CARBON 
 *  @vers 1.3 6.3.76 C-Li-Os 
 *  @date 01/25/2022 09:57:09          
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                       


chkIn()


prog = GetScript()

<<"Running $prog\n"

av = 80;
<<"%V $av\n"
db_ask = 0
Svar ans = "help me"

<<"%V $ans $db_ask \n"

float AF[20];

AF[0] = 80
AF[8] = 30
  i = 7

<<"%V $i\n"

  AF[i] = i;

<<"%V $AF[i] \n"
  j = 8
  
  xf = AF[j];

<<"%V $xf\n"

 <<"$i  AF[$i ] $AF[i] $AF[j] $xf\n"


chkN(AF[i],i)
chkN(xf,30)


ans=ask(" Pass? ",db_ask)
<<"%V $ans \n"

if (ans == "no") {
   exit()
}




 for (i= 1; i < 20; i++) {
 
  AF[i] = i;
  xf = AF[i]
 <<"  AF[$i ] $AF[i] $xf\n"
chkN(AF[i],i)
chkN(xf,i)

 }

<<"$AF\n"

  sz = Caz(AF)
  chkN(sz,20)
  bd = Cab(AF)
  gt = typeof(AF)

chkStr(gt,"FLOAT");

ans=ask(" Pass? ",db_ask)


char A[20];

 for (i= 1; i < 20; i++) {
 
  A[i] = i;
  x = A[i]
 <<"  A[$i ] $A[i] $x\n"
chkN(A[i],i)
chkN(x,i)

 }

<<"$A\n"

ans=ask(" Pass? ",db_ask)

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

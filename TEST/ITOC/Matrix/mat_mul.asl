/* 
 *  @script mat_mul.asl 
 * 
 *  @comment test matrix multiply 
 *  @release CARBON 
 *  @vers 1.2 He 6.3.82 C-Li-Pb 
 *  @date 02/10/2022 08:26:00          
 *  @cdate 11/03/2021 08:16:29 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//----------------<v_&_v>-------------------------//                                                                
   

   
#include "debug" 
   if (_dblevel >0) {
     debugON();
     }
   
   chkIn();
   
   ask =0



//int A[][] = { 3,1,2, 2,1,3 }
  
  
  int A[] = { 3,1,2, 2,1,3 };
  
  A.redimn(2,3);
  
  <<"A:\n "
  <<"%(3,, ,\n)$A\n\n";
  askit(ask)
  
  int B[] ={ 1,2, 3, 1, 2, 3}
  
  B.redimn(3,2);
  
  <<"B:\n"
  <<"%(2,, ,\n)$B\n\n";
  
    fileDB(ALLOW_,"opera_main,opera_mat")
  C = A * B;
  
  
  <<"%(2,, ,\n)$C\n";


<<"C[0][0] =  $C[0][0]\n"

    askit(ask)
  
  ok=chkN(C[0][0],10);
  
  <<"%V$ok\n";
  
  ok=chkN(C[1][1],14);
  
  <<"%V$ok\n";
  
  D = B * A;
  
  
  <<"%(3,, ,\n)$D\n\n";
  
  <<" $(Cab(D)) $(Caz(D))\n";
  
  <<"%V$D[0][1] \n";
  
  
  ok=chkN(D[0][1],3);
  
  <<"%V$ok\n";
  
  <<"%V$D[0][0] \n";
  
  ok=chkN(D[0][0],7);
  
  <<"%V$ok\n";
  
  <<"%V$D[1][1] \n";
  
  i = D[1][1];
  
  <<"$i $D[1][1]\n";
  
  ok=chkN(D[1][1],4);
  
  <<"%V$ok\n";
  
  <<"%V$D[2][2] \n";
  
  i = D[2][2];
  
  <<"$i $D[2][2]\n";
  
  ok=chkN(D[2][2],13);
  
  <<"%V$ok\n";
  
float Identity[16] = { \
  1, 0, 0, 0,\
  0, 1, 0, 0,\
  0, 0, 1, 0,\
  0, 0, 0, 1\
};

 Identity.redimn(4,4);
<<"$Identity\n"

Identity.pinfo();

float I2[16] = { \
  0, 0, 0, 1,\
  0, 0, 1, 0,\
  0, 1, 0, 0,\
  1, 0, 0, 0\
};

 I2.redimn(4,4);
<<"$I2\n"

I2.pinfo();

double M[2][3] = { 1,2.5,3 ,\
			     4,5.1,6};
/*
double M[2][3] = { \
				{1,2.5,3},\
                                {4,5.1,6},\
                           };
*/

<<"$M\n"

M.pinfo();

double R[4][4] = {  1,2.5,3,4, \
                              5,6.1,7,8,\
		              9,10,11,12,\
			      13,14,15,16\
                           };

 R.pinfo()

 <<"$R\n"
 
 askit(ask)

 J = Identity;

 T= J * J;

<<"$T\n"

T.pinfo();

  Z= R * R

 
 
Z.pinfo();

 askit(ask)

  Z= I2 * J


Z.pinfo();


  Z= J * I2


Z.pinfo();

Z= R * I2;


Z.pinfo();

Z= R * J;


Z.pinfo();

 d= Mdet(R)

<<"%V $d\n";

a= 1.0;
b=2.0
c=3.0
d=4.0

double P[4] = {a,b,c,d,};

P.redimn(2,2);
P.pinfo()

<<"$P \n"

 e = a*d - b*c;

<<"%V $e \n";


 d= Mdet(P)

<<"%V $d\n";


  chkOut();

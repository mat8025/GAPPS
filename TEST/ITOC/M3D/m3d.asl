/* 
 *  @script m3d.asl 
 * 
 *  @comment test multi dim 3 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.30 C-Li-Zn] 
 *  @date 03/11/2021 10:51:53 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                      
<|Use_=
Demo  of MD3
///////////////////////
|>


#include "debug";



if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");
//filterFuncDebug(REJECT_,"vrealloc","Svar","init");

ignoreErrors()

chkIn(_dblevel);



N = 10
P = 10
L = 10

int G[] = {1,2,3};
<<"%V$G\n"


V = vgen(INT_,N,0,1)

V[0:3] = 68;


val = V[2]

<<"$val \n"


chkN(val,68)


V[{5,6,7}] = 77;


<<"$V\n"
chkN(V[5],77)
chkN(V[6],77)
chkN(V[7],77)




int M2[L][P]

M2->info(1)
M2[0][2] = 67;
M2->info(1)

//M2[1:4][3] = 68;


M2[1,4,5][1,3] = 68;


val = M2[4][1]

<<"$val \n"


chkN(val,68)

<<"%V$M2\n"


M2[{3,4,5}][{5,6}] = 55;

<<"%V$M2\n"

M2[6:9:1][{5,6}] = 77;


<<"%V$M2\n"

M2[6:9:1][1:3:1] = 44;


<<"%V$M2\n"





int M[N][P][L];

M<-pinfo()

M[0][0][2] = 67;

M<-pinfo()




<<"$V\n"

V<-pinfo()

b = Cab(V)
<<"Vbounds $b \n"


b = Cab(M)
//b = Cab(M)
<<"0 bounds $b \n"

M<-pinfo()

val = 7

    M[0][1][2] = 47;

M->info(1)

b = Cab(M)
<<"1 bounds $b \n"
    val2= M[0][1][2] ;
<<"%V $val2 $M[0][1][2] \n"

chkN(47,val2);



b = Cab(M)
<<"2 bounds $b \n"


   M[0][1][3] = 79;
   val2= M[0][1][2] ;     
<<"%V $val2 $M[0][1][2] \n"

    val3= M[0][1][3] ;
<<"%V $val3 $M[0][1][3] \n"
    val2= M[0][1][2] ;
<<"%V $val2 $M[0][1][2] \n"
   M[0][1][4]  = 80;
    val2= M[0][1][4] ;
<<"%V $val2 $M[0][1][4] \n"
    val2= M[0][1][2] ;
<<"%V $val2 $M[0][1][2] \n"

    M[0][2][1] = 66;

<<"%V $M[0][2][1]  \n"
<<"%V $M[0][3][1]  \n"
<<"%V $M[0][3][2]  \n"

    mval = M[0][2][1] ;
<<"%V $M[0][2][1]  $mval\n"
    i= 0;
    M[0][i][1] = val++;
    i = 1;
    M[0][i][1] = val++;

  for (i = 0; i < 10; i++) {
    M[0][i][1] = val++;
    val2= M[0][i][1] ;
    <<"%V $i $M[0][i][1] $val2  $val\n"
  }


<<"%V $M[0][0][1]  \n"
//  chkN(M[0][0][1],7)

<<"%V $M[0][1][1]  \n"
//  chkN(M[0][1][1],8)

<<"%V $M[0][2][1]  \n"
<<"%V $M[0][3][1]  \n"
<<"%V $M[0][3][2]  \n"
M[0][0][0] = 65;
M->info(1)



<<"%V $M[0][1][2]  \n"
    val2= M[0][1][4] ;
<<"%V $val2 $M[0][1][4] \n"

//<<"$M \n"




 val = 7

for (i = 0; i < P; i++) {

    M[0][i][1] = val
<<"M 0,$i,1 $M[0][i][1] \n"
   val++
 }


 val = 7
 for (i = 0; i < P; i++) {
<<"M 0,$i,1 $M[0][i][1] $val\n"
    chkN(M[0][i][1],val)
    val++
 }


//chkOut()  ; // xic bug after


b = Cab(M)
<<"$b \n"
<<"V is $V \n"

  val = 0
  kcnt =0
  for (i = 0; i < 2; i++) {

    for (j = 0; j < 2; j++) {

    for (k = 0; k < 10; k++) {

            M[i][j][k] = val;
       if ((kcnt % 100) == 0) {
          <<"$i,$j,$k == $M[i][j][k] \n"
       }
          chkN(M[i][j][k],val);
	  val++;
          kcnt++
    }

    }

  }
//======================================//

M[0][1][4] = 80

M[0:3:1][{1,2}][{1}] = 81

<<"$M[0][1][1]\n"

//<<"$M[0][1][::]\n"

mval = M[0][1][1]

<<"$mval\n"

chkN(mval,81)


mval = M[1][2][1]

<<"$mval\n"

chkN(mval,81)

M[5:8:1][4:8:1][1] = 39 // NOK

mval = M[5][5][1]

<<"$mval\n"

chkN(mval,39)




//M[5:8:1][4:8:1][{1}] = 39

//M[5:8:1][4:8:1][1:3:1] = 39  // OK



<<"$M\n"





M[0][1][0:3:1] = 81


M[1][1][0:3:1] = 82

mval = M[0][1][1]

<<"$mval\n"

chkN(mval,81)


mval = M[1][1][2]

<<"$mval\n"

chkN(mval,82)

mval = M[0][1][4]

<<"$mval\n"

chkN(mval,80)


//chkOut()

M[0:1][1][0:3:] = 8

<<"0:1,1 :: $M[0:1][1][::] \n"


M[0][0:1:][0:3:] = 8

<<"0,0:1 :: $M[0][0:1][::] \n"

M[0][1][0:3:] = 7

<<"0,1 :: $M[0][1][::] \n"



<<"0,3 --------------------\n"

M[0][1][::] = V
  V += 3

<<"0,1 :: $M[0][1][::] \n"


M[0][2][::] = V

<<"V == $V\n"

<<"0,2--------------------\n"
<<"M 0,1 ::\n $M[0][2][::] \n"

  V += 3

M[0][3][::] = V

<<"V == $V\n"

<<"0,3--------------------\n"
<<"M 0,1 ::\n $M[0][3][::] \n"

  V += 3

M[0][9][::] = V

<<"V == $V\n"

<<"0,9--------------------\n"
<<"M 0,9 ::\n $M[0][9][::] \n"

  V += 3


/*
// will throw an error

M[0][10][::] = V

<<"V == $V\n"

<<"0,10--------------------\n"
<<"M 0,10 ::\n $M[0][10][::] \n"

  V += 3





m = P-1

<<"V == $V\n"

M[0][m][::] = V

<<"M 0,$m :: $M[0][m][::] \n"

  V += 3


m = P-1

<<"$m $(P-1) \n"

M[0][m][::] = V
  V += 3

<<"0,3 :: $M[0][m][::] \n"



for (j = 0; j < 2; j++) {

 for (i = 0; i < P; i++) {
  M[j][i][::] = V
  V += 3
 }

}

chkStage()


<<"0,0 :: $M[0][0][::] \n"

for (j = 0; j < 2; j++) {

 for (i = 0; i < P; i++) {

   <<"$j,$i :: $M[j][i][::] \n"

 }

}

chkOut()
exit()
// gotta fix the indexing and subset for 3 + index


int A[3][N]


b = Cab(A)
<<"$b \n"

for (i = 0; i < 3; i++) {
 A[i][::] = V
 V += 3
}

 for (i = 0; i < 3; i++) {
  <<"$A[i][::]\n"
 }


*/




chkOut()


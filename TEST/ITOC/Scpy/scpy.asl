/* 
 *  @script scpy.asl 
 * 
 *  @comment test scpy SF  
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.16 C-Li-S]                                
 *  @date Sat Feb  6 07:03:12 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


/*
scpy(&M[0],&T[0],{n})
returns len of string copied, (from second to first parameter) 
used for char arrays 
but can also copy the string contained by an sivar
the maximum number of characters to be copied can also be set.
e.g.
scpy(&M[0],&w1) or  scpy(&w1,&M[0]) 
.br
scpy(&M[1],&T[2],4)
*/

/////

#include "debug"

debugON()
//filterFileDebug(REJECT_,"ic_wic.cpp","get_args.cpp","~ds_storestr.cpp");
//filterFileDebug(REJECT_,"array_parse.cpp","args_process_e.cpp","get_args.cpp");

//filterFuncDebug(REJECT_,"var_main");


chkIn(_dblevel)
/*
!p _DV
!p _IV
!p _P
*/

int ki = 3;

char M[32];
char A[32];
char T[32];

char R[32];

M->info(1)
sz=Caz(M)
<<"%v$sz\n"
<<"%I $M\n"

scpy(M,"hola que tal");
<<"%I $M\n"
<<"%s <|$M|>\n"
A= -67

chkStr(M,"hola que tal");

  _S ="io sto bene"

<<"S= $_S\n"
//!i _S


chkStr(_S,"io sto bene");

//scpy(&S,"hola que tal");// crash

  scpy(_S,"hola que tal");// 

<<"S= $_S\n"


_S->info(1)


chkStr(_S,"hola que tal");

<<"%I $_S\n"



<<"%d $M\n"


scpy(T,M,10)

<<"%d $T\n"

<<"%s $T\n"
chkN(T[1],M[1])

<<"$A\n"

scpy(&A[5],M,10)

M->info(1)
<<"M %d $M\n"
<<"A %d $A\n"
chkN(A[5],M[0])
<<"A %s $A\n" // bug?


scpy(&A[ki],M,10)

<<"$A\n"

chkN(A[ki],M[0])


scpy(&R[2],&M[3],10)

<<"R %d $R[::]\n"

<<"R %s $R\n"
chkR(R[2],M[3])


scpy(R,&M[ki],10)

<<"R %d $R[::]\n"

<<"R %s $R\n"
chkR(R[0],M[ki])

ki++
scpy(&R,&M[ki],10)

<<"R %d $R[::]\n"

<<"R %s $R\n"
chkR(R[0],M[ki])



char num[5];


scpy(num,&M[2],3)

chkN(num[0],M[2])
<<"%d $num \n"


M[20] = 88;

M[20] = 'X';


M[21] = 'Y';
M[22] = 'Z';

<<" %d $M\n"

scpy(&num[1],&M[20],3)

chkR(num[1],M[20])

<<"%d $num \n"

<<"%d $num[1]  $M[20] \n"
chkOut()
//%*********************************************** 
//*  @script scpy.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Wed Dec 26 19:20:13 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///



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

chkIn(_dblevel)
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


chkStr(M,"hola que tal");



Str S;

  S="io sto bene"

<<"S= $S\n"

//scpy(&S,"hola que tal");// crash

  scpy(S,"hola que tal");// 

<<"S= $S\n"


S->info(1)
chkStr(S,"hola que tal");

<<"%I $S\n"



<<"%d $M\n"



scpy(T,M,10)

<<"%d $T\n"

<<"%s $T\n"


scpy(&A[5],M,10)

//<<"A %d $A[::]\n"
<<"A %d $A\n"

<<"A %s $A\n" // bug?

scpy(R,&M[3],10)

<<"R %d $R[::]\n"

<<"R %s $R\n"

char num[5];


scpy(&num,&M[2],3)


<<"%d $num \n"


scpy(&num,&M[20],3)


<<"%d $num \n"
chkOut()
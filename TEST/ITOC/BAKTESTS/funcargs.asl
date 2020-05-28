//%*********************************************** 
//*  @script funcargs.asl 
//* 
//*  @comment test func args 
//*  @release CARBON 
//*  @vers 1.13 Al Aluminium                                              
//*  @date Tue Jan 29 11:50:29 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug.asl"
debugON()

filterFileDebug(REJECT_,"exp_e","proc_e");

proc foo(x,y,z)
{
<<"%V $x $y $z\n"
int m =x;
int n =y;
int p =z;

for (i=0; i< 3; i++) {
SV2=testargs(-1,m,n,p,1,2,3)
<<"%V$SV2 \n"

<<"%V $m $n $p\n"
m++;
n++;

<<"%V $m $n $p\n"
}

}


//======================//

CheckIn()

 int A[5];

 A= igen(5,0,1)

 B = A * 2

 a = 1;

 checkFnum(a,1)


 int b = 79;
 int c = 47;
 
<<"%V $a $b $c \n"

SV=testargs(1,a,b,c)

<<"%V$SV[0] $SV[1] $SV[2]\n"

SV=testargs(1,&a,&b,&c)
<<"%V$SV\n"


SV=testargs(1,c,a,b)
<<"%V$SV\n"



<<"%V $a $b $c \n"

foo(a,b,c)
/{




 testargs(1,@head,"big",@tail,"tiny",1,2,3,A)
 SV=testargs(-1,@head,"big",@tail,"tiny",1,2,3,A)

//iread();
<<"whats in SV\n"
<<"%V$SV[0] $SV[1] $SV[2]\n"
<<"%(12,,\,,\n)$SV[0:10]\n"

<<"%(1,,,\n)$SV\n"

<<"%V$SV[3] $SV[8] $SV[18]\n"

/}

SV=testargs(1,c,a,b)
<<"%V$SV\n"


 CheckOut()

;

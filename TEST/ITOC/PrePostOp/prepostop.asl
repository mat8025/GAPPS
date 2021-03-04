//%*********************************************** 
//*  @script prepost_opr.asl 
//* 
//*  @comment  test a++ ++a ops 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.47 C-He-Ag]                                
//*  @date Wed May 13 11:09:50 2020 
//*  @cdate Wed May 13 11:09:50 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug"


if (_dblevel >0) {
   debugON()
}

chkIn(_dblevel)

proc Foo(int a,int b)
{
<<"%V$a $b\n"
 c= a + b
 
<<"sum %V$c \n"
 return c;
}

//======================================//

int VA[3] = {1,2,3};
VA->info(1)

int k = 0;
k->info(1)
A= vgen(INT_,10,0,1)
A->info(1)
<<"$A\n"

A[0] = 47;
A[1] = 79;
A[2] = 80;
A[3] = 14;

<<"$A\n"



b = A[k]

<<"0th ele is $b\n"

chkN(b,47)


b= A[k++]

<<"0th ele is still $b\n"

chkN(b,47)


<<"%V$k\n"

b = A[k]

<<"1st ele is $b \n"

chkN(b,79)


b= A[k++]

<<"1st ele is $b \n"

chkN(b,79)

<<"%V$k\n"

b= A[k++]

<<"2nd ele $b \n"

chkN(b,80)

<<"%V$k\n"

k++;

b= A[k++]

<<"4th ele $b \n"

chkN(b,4)

<<"%V$k\n"


b= A[k--]

<<"%V$b \n"

chkN(b,5)

<<"%V$k\n"


b= A[--k]

<<"%V$b \n"

chkN(b,14)

<<"%V$k\n"

chkN(k,3)

b= A[++k--]

<<"%V$b \n"

<<"%V$k\n"

chkN(k,3)
chkN(b,4)


int e = ++k ;

<<"%V$e $k \n"


int w = --k ;

<<"%V$w $k \n"

chkN(e,4)
chkN(w,3)

int Gc;


 k = 0

<<"%v $k \n"
k++
<<"%v $k \n"
chkN(k,1)
k--
<<"%v $k \n"
chkN(k,0)
++k++
<<"%v $k \n"
chkN(k,2)
--k--
<<"%v $k \n"
chkN(k,0)

double x0 = -10.0

<<"%v $x0 \n"

chkR(x0,-10)

x0++

chkR(x0,-9)

k = 2
m = 2

n = k++ + m--

<<"%V $n $k $m \n"

chkN(n,4)

k = 2
m = 2

n = --k + ++m

chkN(n,4)


<<"%V $n $k $m \n"


<<"b4foo %V $k $m \n"

 r=Foo(k++,m++)
<<"%V $k $m \n"

chkN(k,2)
chkN(m,4)

chkN(r,4)


<<"b4foo %V $k $m \n"

 r = Foo(++k,++m)

<<"%V $k $m $r\n"

chkN(k,3)
chkN(m,5)

chkN(r,8)


AV = vgen(INT_,10,0,1)

AV->info(1)

<<"%V$AV\n"

chkN(AV[1],1)

 AV++;
 
<<"%V$AV\n"

chkN(AV[1],2);

//setdebug(1,"trace")

BV = ++AV ; // this should increment all elements in the vector

<<"after ++ $AV\n"
BV->info(1)
<<"%V $BV\n"

chkN(BV[1],3)


BV = AV++ ; // this should increment all elements in the vector

<<"after  $AV ++\n"

chkN(AV[1],4)

chkN(BV[1],3)

<<"%V $BV\n"


chkOut()


exit()


//%*********************************************** 
//*  @script median.asl 
//* 
//*  @comment test Median of an array 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Wed Dec 23 22:37:40 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
/// median
///

/*
Median(A)
returns median value of array-- the array size is obtained from the array variable
If A is a matrix - a column vector of the medians for each row is returned.

*/
#include "debug.asl";

sdb(_dblevel,@~trace)

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

I= vgen(INT_,10,0,1)

<<"$I\n"


med = median(I)

<<"%V$med\n"
chkN(med,4.5)

s= Sum(I)
s->info(1)
<<"Sum is $s\n"

I += 1  // add one to each element in vector

<<"$I\n"

s= Sum(I)

<<"Sum is $s\n"

//ird()

J= vgen(INT_,9,1,1)

<<"$J\n"


med = median(J)

<<"%V$med\n"

chkN(med,5)

int K[] = {3, 5, 7, 12, 13, 14, 21, 23, 23, 23, 23, 29, 40, 56} 

<<" $K \n"

med = median(K)

<<"%V$med\n"

chkN(med,22)


s = Sum(K);

<<"sum K is $s  $(typeof(s))\n"
bd=Cab(s)
sz = Caz(s)

<<"$bd $sz $(infoof(s)) \n"

//ans = iread();
<<"%V$s\n"
chkN(s[0],292)

//ird!

I= vgen(INT_,100,0,1)

I->redimn(20,5)

<<"$I\n"

Q=median(I)

<<"median is :\n"

<<"%6.2f$Q\n"


S=Sum(I,0)

<<"$(Cab(S)) \n "

<<"SumCols is :\n"
<<"$S\n"


S=Sum(I,1)

<<"$(Cab(S)) \n "

<<"SumRows is :\n"
<<"$S\n"




T= transpose(I)

<<"$(Cab(T)) \n\n "

<<"$T \n"



V=median(T)

<<"$V\n"

<<"$(Cab(V))\n"


chkOut()
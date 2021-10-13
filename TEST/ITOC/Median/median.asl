/* 
 *  @script median.asl 
 * 
 *  @comment test Median of an array 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.49 C-Li-In] 
 *  @date 08/23/2021 06:33:06 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                             
///
/// median
///

<|Use_=
Demo  of Median func ;
Median(A)
returns median value of array-- the array size is obtained from the array variable
If A is a matrix - a column vector of the medians for each row is returned.
///////////////////////
|>


                                                                        
#include "debug"

if (_dblevel >0) {
  debugON()
    <<"$Use_\n"   
}



chkIn(_dblevel)

I= vgen(INT_,10,0,1)

<<"$I\n"


med = median(I)

<<"%V$med\n"
chkN(med,4.5)

s= Sum(I)
s->pinfo()
<<"Sum is $s\n"


I += 1;  // add one to each element in vector

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
s<-pinfo()
chkN(s,292)

//ird!

I= vgen(INT_,100,0,1)

I<-redimn(20,5)

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
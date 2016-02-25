checkIn()

I= vgen(INT_,10,0,1)

<<"$I\n"


med = median(I)

<<"%V$med\n"
checkNum(med,4.5)

s= Sum(I)

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

checkNum(med,5)

int K[] = {3, 5, 7, 12, 13, 14, 21, 23, 23, 23, 23, 29, 40, 56} 

<<" $K \n"

med = median(K)

<<"%V$med\n"

checkNum(med,22)


s = Sum(K)

<<"sum K is $s\n"

checkNum(s,292)

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


checkOut()
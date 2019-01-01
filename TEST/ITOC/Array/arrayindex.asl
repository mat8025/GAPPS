///
///

checkIn()


M= vgen(INT_,20,0,1)

<<"$M\n"

k = M[7];



j = M[3+4];

n = 3;
o = 5;


m = M[n+4];


p = M[n+o];

checkNum(M[n+o],8)

<<"%V$k $j $m $p\n"

M->redimn(5,4)

<<"$M\n"

<<"$M[1][3]\n"

a= 0
checkNum(M[a+1][n],7)
<<"$M[a+1][n]\n"
a =2
<<"$M[a+1][n]\n"
checkNum(M[a+1][n],15)
checkOut()
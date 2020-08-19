///
///

chkIn(_dblevel)


M= vgen(INT_,20,0,1)

<<"$M\n"

k = M[7];



j = M[3+4];

n = 3;
o = 5;


m = M[n+4];


p = M[n+o];

chkN(M[n+o],8)

<<"%V$k $j $m $p\n"

M->redimn(5,4)

<<"$M\n"

<<"$M[1][3]\n"

chkN(M[1][3],7)
a= 0

b = M[1][3]

<<"%V$b \n"

chkN(b,7)

b=M[a][n]

chkN(b,3)

<<"%V$b  $a $n $M[a][n]\n"
a=1
b=M[a+1][n]

<<"%V$b  $(a+1) $n $M[a+1][n]\n"

chkN(M[a+1][n],11)

<<"$M[a+1][n]\n"



a =2
<<"$M[a+1][n]\n"

chkN(M[a+1][n],15)


chkOut()

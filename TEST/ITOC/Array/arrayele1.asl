CheckIn()

k= 4
n = 6


// works for int not other types?

//double K[10][3]
//char K[10][3]
//short K[10][3]
//float K[10][3]


int K[10][3]

<<" $(Cab(K)) \n"

 K[0][0] = 77

//<<"%I %3r\n $K \n"
<<" $K \n"



CheckNum(K[0][0],77)


k= 4
j = 1
 K[k][0] = 27

<<" $K \n"


CheckNum(K[k][0],27)

n = 6

 K[n][0] = k

<<"%I $K \n"

CheckNum(K[n][0],k)

 K[n][0] = k * 2

<<"%(6,, ,\n)$K \n"

CheckNum(K[n][0],(k*2))

 K[n+1][j] = k * 4

<<"$K \n"

CheckNum(K[n+1][j],(k*4))


<<" ${K[n+1][j]} \n"



float F[10][3]

<<" $(Cab(F)) \n"

 F[0][0] = 77

<<"%(3,, ,\n) $F \n"

CheckNum(F[0][0],77)


k= 5
j = 1

 F[k][0] = 27

<<"%(3,, ,\n) $F \n"


CheckNum(F[k][0],27)

n = 6

 F[n][0] = k

<<"%(3,, ,\n)$F \n"

CheckNum(F[n][0],k)

 F[n][0] = k * 2

<<"%(3,, ,\n)$F \n"

CheckNum(F[n][0],(k*2))

 F[n+1][j] = k * 4

<<"%(3,, ,\n)$F \n"

CheckNum(F[n+1][j],(k*4))


<<" ${F[n+1][j]} \n"


short S[10][3]

<<" $(Cab(S)) \n"

 S[0][0] = 77

<<"%I $S \n"

CheckNum(S[0][0],77)




 S[k][0] = 27

<<"%I $S \n"


CheckNum(S[k][0],27)

n = 6

 S[n][0] = k

<<"%($n,, ,\n)%I $S \n"

CheckNum(S[n][0],k)

 S[n][0] = k * 2

<<"$S \n"

CheckNum(S[n][0],(k*2))

 S[n+1][j] = k * 4

<<"$S \n"

CheckNum(S[n+1][j],(k*4))


<<" ${S[n+1][j]} \n"


I = Igen(30,0,1)

 <<" $I[2] \n"


 a = 2
 b = 3

<<"  c is element of I \n"

int ci = I[(a+b)]

<<"%V $(a+b) $ci \n "

<<"%i \n$ci \n "



CheckNum(ci, (a+b))


int c = I[(a*b)]

<<"$(a*b) $c \n"

CheckNum(c, (a*b))

 c = I[(a*b+b)]

<<"$(a*b+b) $c \n"

CheckNum(c, (a*b+b))

CheckOut()


stop!
//
checkIn()
//setdebug(1)
int I[10]

I[2] = 47
I[3] = 79
I[4] = 80
<<" $I \n"


int K[10+1]

K[2] = 79

<<" $K \n"


uchar UV[10]

UV[2] = 47
UV[3] = 79
UV[4] = 80
UV[5] = 'A'

<<" $UV \n"
<<" $UV[2] \n"


CheckNum(UV[2],47)


char CV[10]

CV[2] = 47
CV[3] = 79
CV[4] = 80
CV[5] = 'A'

<<" $CV \n"
<<" $CV[2] \n"

CheckNum(CV[2],47)

uchar us =3

<<"$(typeof(us)) $us \n"
<<"$us = 3 \n"
CheckNum(us,3)

UVG = vgen(CHAR_,10,0,1)

<<"UVG  $UVG \n"

CheckNum(UVG[2],2)

CheckOut()

;

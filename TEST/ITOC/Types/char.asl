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

CheckNum(UV[5],'A')


//char CV[10];
char CV[20];

CV[0] = 14
CV[1] = 15

CV[2] = 47
CV[3] = 79
CV[4] = 80


// FIX this  xic version destroys array!!

CV[5] = 'A'

<<"CV[] = $CV \n"
<<" $CV[1] \n"
<<" $CV[2] \n"

CheckNum(CV[0],14)
CheckNum(CV[1],15)
CheckNum(CV[2],47)

cv0 = CV[0];
cv1 = CV[1];

<<"%V $cv0 $cv1 \n"


CheckNum(cv0,14)
CheckNum(cv1,15)



uchar us =3

<<"$(typeof(us)) $us \n"
<<"$us = 3 \n"
CheckNum(us,3)

UVG = vgen(CHAR_,10,0,1)

<<"UVG  $UVG \n"

CheckNum(UVG[2],2)

CheckOut()

;

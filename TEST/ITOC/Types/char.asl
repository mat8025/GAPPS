///
///  char.asl
/// 
checkIn()

setdebug(1,"~pline")

char CV[20];

CV[0] = 14
CV[1] = 15

CV[2] = 47
CV[3] = 79
CV[4] = 80


CV[5] = 'A';

<<"CV[] = $CV \n"
<<" $CV[1] \n"
<<" $CV[2] \n"

checkNum(CV[0],14)
checkNum(CV[1],15)
checkNum(CV[2],47)

cv0 = CV[0];
cv1 = CV[1];

<<"%V $cv0 $cv1 \n"


checkNum(cv0,14)
checkNum(cv1,15);

char CMD[3][5];

CMD[0][0] = 81
CMD[0][1] = 82
CMD[0][2] = 78
CMD[0][3] = 79
CMD[0][4] = 80


CMD[1][0] = 97
CMD[1][1] = 98
CMD[1][2] = 99
CMD[1][3] = 100
CMD[1][4] = 101

sz = Caz(CMD);
bd = Cab(CMD);

<<"%V$sz $bd\n";
cv0 = CMD[0][0];

checkNum(cv0,81);

checkNum(CMD[0][1],82);


<<"CMD[] :\n";
<<"$CMD \n"
CMD[2][4] = 13
CMD[2][3] = 28
CMD[2][2] = 12
CMD[2][1] = 6
CMD[2][0] = 17


<<"$CMD \n"

B = CMD[2][1:4:];
// B should be a vector!
B->Redimn()

<<"%V$B \n"
<<"$(typeof(B)) $(Cab(B)) $(Cnd(B))\n"

cv0 = B[0];
<<"%V$cv0\n";

cv1 = B[1];
<<"%V$cv1\n";

cv2 = B[2];
<<"%V$cv2\n";


checkNum(B[1],12);

D = CMD[2][1:3:];

<<"%V$D \n"
<<"$(typeof(D)) $(Cab(D)) \n"

checkNum(D[0],6);

<<"\\\\\\ \n";

E = CMD[0:2][1:3:];

<<" $E \n"
<<"$(typeof(E)) $(Cab(E)) \n"


str s = "hey";

<<"$s \n"

 //scpy(s,"$CMD[0][::]");

nc=scpy(s,CMD[0][::]);

<<"$nc :: $s \n"

<<"$(typeof(s)) $(Cab(s)) \n"


nc=scpy(s,CMD[0:1][::]);

<<"$nc :: $s \n"

<<"$(typeof(s)) $(Cab(s)) \n"


//////////////////////////////



uchar UV[10]

UV[2] = 47
UV[3] = 79
UV[4] = 80
UV[5] = 'A'

<<" $UV \n"
<<" $UV[2] \n"


CheckNum(UV[2],47)

CheckNum(UV[5],'A')





uchar us =3

<<"$(typeof(us)) $us \n"
<<"$us = 3 \n"
CheckNum(us,3)

UVG = vgen(CHAR_,10,0,1)

<<"UVG  $UVG \n"

CheckNum(UVG[2],2)

CheckOut()

;

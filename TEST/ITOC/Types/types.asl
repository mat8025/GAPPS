//%*********************************************** 
//*  @script types.asl 
//* 
//*  @comment test asl types 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri Apr 17 11:14:54 2020 
//*  @cdate Fri Apr 17 11:14:54 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%




//%*********************************************** 
//*  @script double.asl 
//* 
//*  @comment test double type 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 16:45:21 2020 
//*  @cdate Thu Apr  2 16:45:21 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


checkIn(_dblevel)

double DV[10]

DV[2] = 47

<<" $DV \n"

CheckFNum(DV[2],47,6)

double d =3

<<"$(typeof(d)) $d \n"

CheckFNum(d,3)

DVG = vgen(DOUBLE_,10,0,1)

<<" $DVG \n"

                                                                                                                                CheckFNum(DVG[2],2,6)


checkStage("double")

//%*********************************************** 
//*  @script float.asl 
//* 
//*  @comment test float type 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 16:46:01 2020 
//*  @cdate Thu Apr  2 16:46:01 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


float FV[10]

FV[2] = 47

<<" $FV \n"

CheckFNum(FV[2],47,6)

float f =3

<<"$(typeof(f)) $f \n"

CheckFNum(f,3)

FVG = vgen(FLOAT_,10,0,1)

<<" $FVG \n"

CheckFNum(FVG[2],2,6)


checkStage("float")



//%*********************************************** 
//*  @script char.asl 
//* 
//*  @comment test  char type 
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%




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

s= CMD[0][::];

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




CheckStage("char")


uint UI[10]

UI[2] = 47

<<" $UI \n"

ulong ul =3

<<"$(typeof(ul)) $ul \n"

CheckNum(ul,3)


ulong UL[10]

UL[2] = 79

CheckNum(UL[2],79)

<<" $UL \n"



UV = vgen(LONG_,10,0,1)

<<" $UV \n"

CheckNum(UV[2],2)

CheckStage("long")

/////////////////////////////////////////

setap(30)

pan a = 1.234567801012340001234567; 
pan b = -0.98765400000001; 
pan c = 1.234567801012340001234567;

<<"$a $(typeof(a)) \n"

<<"$b $(typeof(b)) \n"

<<"$c $(typeof(c)) \n"

CheckFNum(a,c,6)
CheckFNum(b,-0.987654000001,4)

CheckFNum(a,1.234567801012340001234567,6)

CheckFNum(a,1.234567801012340001234567,2)

CheckFNum(b,-0.987654000001,2)



pan P[50]


P[20] = 787.0
P[30] = 429.0


p20 = P[20]
CheckFNum(p20,787.0,5)
CheckFNum(P[20],787.0,5)
CheckFNum(P[30],429.0,5)

CheckStage("Pan")

/////////////////////////////////

ushort US[10];

US[2] = 47

<<" $US \n"

CheckNum(US[2],47)

ushort usi =3

<<"$(typeof(usi)) $usi \n"

CheckNum(usi,3)

UVG = vgen(SHORT_,10,0,1)

<<" $UVG \n"

CheckNum(UVG[2],2)

CheckStage("short")

//%*********************************************** 
//*  @script real.asl 
//* 
//*  @comment test real aka double (promote float to double) type 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 16:46:48 2020 
//*  @cdate Thu Apr  2 16:46:48 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



float rf = 7.2

<<"$(typeof(rf)) $rf \n"

real r = 3.14259

<<"$(typeof(r)) $r \n"

r->info(1)



rf = r;

<<"$(typeof(rf)) $rf \n"


double rd = r;

<<"$(typeof(rd)) $rd \n"

checkFnum(rd,3.14259)


checkFnum(r,3.14259)



real RV[10]

RV[2] = 47

<<" $RV \n"

CheckFNum(RV[2],47,6)



CheckFNum(d,3)

RVG = vgen(REAL_,10,0,1)

<<" $RVG \n"

CheckFNum(RVG[2],2,6)

CheckStage("real")



str sa= "-1"

i=  atoi(sa);
checkNum(i,-1)
<<"$sa int $i $(typeof(i))\n"

f=  atof(sa);
checkNum(f,-1)
<<"$sa float $f $(typeof(f))\n"
long L = 47
<<"long $L $(typeof(L))\n"
l=  atol("12");
checkNum(l,12)
<<"long $l $(typeof(l))\n"

l=  atol(sa);
checkNum(l,-1)
<<"$sa long $l $(typeof(l))\n"



l =  2^32 
<<"$l $(typeof(l))\n"
u=  atou(sa);

<<"$u $(typeof(u))\n"

ul = l -1; 


<<"$s ulong $ul $u $(typeof(u))\n"

checkNum(u,ul)
checkStage("atou,l,f")

sa ="-1.0"

p=  atop(sa);

<<"$sa $p $(typeof(p))\n"
checkFNum(p,-1.0,5)

p=  atop(2.345);

<<"$sa $p $(typeof(p))\n"
checkFnum(p,2.345,5)


checkStage("atoi")





CheckOut()


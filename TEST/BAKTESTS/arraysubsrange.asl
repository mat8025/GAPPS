
CheckIn()

setdebug(1)

// test array indexing

 N = 20

 YV = Igen(N,20,1)

 ok=CheckNum(YV[0],20)

 if (!ok) {
   <<"FAIL \n"
 }

 <<"%V$YV \n"

 S = YV[0:-3:]

 <<"%V$S \n"

 e = S[-1]

<<"$S\n"
<<"$e $S[-1]\n"
 e= S[0]
<<"$e $S[0]\n"

 e = S[-2]
<<"$e $S[-2]\n"

 e= YV[-3]
 ok =CheckNum(e,YV[17])

 if (!ok) {
   <<"FAIL 1\n"
 }


 AV = YV[-16:-6:2] 

<<"%V$YV[-16:-10:2] \n"
<<"%V$YV[-16:-6:2] \n"

<<" $AV \n"

 e = YV[-1]

<<"%V$e $YV[19]\n"

 ok=CheckNum(e,YV[19])
 if (!ok) {
   <<"FAIL 2\n"
 }

 e = YV[-2]

<<"$e $YV[18] $YV[-2]\n"

 ok=CheckNum(e,YV[18])

 if (!ok) {
   <<"FAIL 3 \n"
 }

 e = YV[-3]

<<"$e $YV[17] $YV[-3]\n"

 ok=CheckNum(e,YV[17])

 if (!ok) {
   <<"FAIL 4\n"
 }

 e = YV[-20]

<<" %V$e  is $YV[0] $YV[-20]\n"

 ok=CheckNum(e,YV[0])
 if (!ok) {
   <<"FAIL 5\n"

 }

 e = YV[-21]

<<" %V$e \n"

 e = YV[-22]

<<" %V$e \n"

 <<"%V$S \n"

 ok=CheckNum(S[0],20)
 if (!ok) {
   <<"FAIL 6\n"
 }

 ok=CheckNum(S[10],30)
 if (!ok) {
   <<"FAIL 7\n"

 }
 ok=CheckNum(S[17],37)
 if (!ok) {
   <<"FAIL 8\n"

 }
 ok=CheckNum(S[-1],37)
 if (!ok) {
   <<"FAIL 9\n"

 }

<<" %V$YV \n"


<<" %V$YV[2:-10:2] \n"

// testargs(YV[2:-10:2])
//iread()
<<" \n"


<<"%V$YV[-16:-10:2] \n"

// testargs(YV[-16:-10:2])
//iread()

<<" \n"


// testargs(YV[-16:-10:2],YV[1:-1:3])

//iread()
 CheckOut()

STOP!
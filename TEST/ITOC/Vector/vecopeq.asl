
// vector vector opeq  
setdebug(1,"pline","trace","~stderr")
FilterDebug(0)
proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }

}



#define  ASK ask();
//#define  ASK ;

proc foo()
{

<<"in $_proc Y: $Y\n"
<<"in $_proc T: $T\n"

  Y *= T
<<"out $_proc $Y\n"

}
//========================

checkIn()


 Y = vgen(FLOAT_,10,0,1);


<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

checkNum(Y[2],4)


ASK
  T = vgen(FLOAT_,10,0,1);

<<"$T\n"

//checkNum(T[2],2)
//ASK

  Y *= T

<<"Y: $Y\n"

checkNum(Y[2],8)


 Y = vgen(FLOAT_,10,0,1);


<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

checkNum(Y[2],4)


  Y =  Y * T
  


<<"Y: $Y\n"


checkNum(Y[2],8)



<<"$Y\n"

 foo()

checkNum(Y[2],16)

<<"$Y\n"

 foo()

checkNum(Y[2],32)
<<"$Y\n"

 Y *= T


checkNum(Y[2],64)

<<"$Y\n"

ASK

foo()

checkNum(Y[2],128)


 Y = vgen(FLOAT_,10,0,1);

<<"Y: $Y\n"
<<"T $T\n"

  Y += T;

<<"Y: $Y\n"

checkNum(Y[2],4)

checkNum(Y[9],18)

  Y -= T;

<<"Y: $Y\n"

checkNum(Y[2],2)

checkNum(Y[9],9)

checkOut();


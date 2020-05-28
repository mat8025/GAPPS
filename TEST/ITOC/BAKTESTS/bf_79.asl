
// vector vector opeq  
setdebug(1,"pline")
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
checkNum(T[2],2)
ASK

//Y *= T

Y =  Y * T

checkNum(Y[2],8)


checkOut()
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



checkOut();


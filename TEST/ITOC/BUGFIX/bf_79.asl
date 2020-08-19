
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

chkIn()


 Y = vgen(FLOAT_,10,0,1);


<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

chkN(Y[2],4)


ASK
  T = vgen(FLOAT_,10,0,1);


<<"$T\n"
chkN(T[2],2)
ASK

//Y *= T

Y =  Y * T

chkN(Y[2],8)


chkOut()
<<"$Y\n"

 foo()

chkN(Y[2],16)

<<"$Y\n"

 foo()

chkN(Y[2],32)
<<"$Y\n"

 Y *= T
chkN(Y[2],64)

<<"$Y\n"

ASK

foo()

chkN(Y[2],128)



chkOut();


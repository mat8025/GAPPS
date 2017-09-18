///
///
///
setdebug(1,"trace")

Class Scalc
{

 public:
  float a;
  float b;


 CMF mul (x,y)
  {
   <<"in $_proc $x $y\n";
    z = x*y;
    return z;
  }

 CMF set (x,y)
 {
  a= x;
  b =y;
 }
 
 CMF print ()
 {
  <<"%V $a $b\n"
 }
 
/{/*
// so no overloading via prototyping --- just replaces
 CMF set (x)
 {
  a= x;
 }

 CMF set ()
 {
  a= 80;
 }

/}*/




};





Scalc acalc;

c=2;
d =4.0;

    ans = acalc->mul(c,d);

<<"$ans \n"


    ans = acalc->mul(3.2,d);

<<"$ans \n"

<<" $(infoof(acalc))\n"

    acalc->set(47,79)

    acalc->print();

FV = fgen(10,0,1);

<<"$FV \n"

    ok=examine(FV);

<<"%V $ok\n"

svar S;

  S = "how can we move forward";

    ok=examine(S);

<<"%V $ok\n"


    ok=examine(acalc);

<<"%V $ok\n"


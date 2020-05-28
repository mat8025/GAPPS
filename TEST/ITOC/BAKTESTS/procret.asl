#! /usr/local/GASP/bin/asl

float dFT60 = 2.0
//int xbin

//N = $2
//<<" $N \n"

N = 3

int ok = 0
int bad = 0
int ntest = 0


proc PR2ESB( prx)
{

 int xbin = prx/dFT60

    <<" PR2ESB %V $prx $xbin  \n"

 return xbin 
}

proc RtoSpo2( r)

{
      sz= Caz(r)

   <<" %V $sz $r \n"

      rspo2 = -8.5 * r * r + -14.6 * r + 108.25

      sz= Caz(rspo2)

      <<" %V $sz $rspo2 \n"

    retval = rspo2
    return retval
}

proc foo( fx)
{

 x = PR2ESB(fx)

<<" $_cproc $x \n"

}

y = 3.0

  x = PR2ESB(y)
<<" $y $x \n"
  x = RtoSpo2(y)
<<" $y $x \n"




y++

  x = PR2ESB(y)

<<" $y $x \n"
  x = RtoSpo2(y)

y = y + 1

   y = 1


 j = 0
 while (y < N) {

  x = PR2ESB(y)


  <<" while  $y $x \n"
  x = RtoSpo2(y)
  <<" while  $y $x \n"
   y++
   j++
  <<" after pinc $y \n"
  foo(y)
 <<"last st in while $j\n")

 }
 <<"first st after while \n")
<<" is $y == $N ? \n"



 if (y == N)
    ok++
 else
    bad++

 ntest++

<<" %V $ok $bad $ntest \n"
STOP!

 int val = (N-1)/2

<<" $x == $val ? \n"

  if (x == val)
    ok++
 else
    bad++

 ntest++

<<" %V $ok $bad $ntest \n"

  if (x == (N-1)/2) {
    ok++
 }
 else {
<<" $x != $val ? \n"
    bad++
 }

 ntest++

<<" %V $ok $bad $ntest \n"

 pcc= (100.0 * ok)/ntest

<<"%-24s:$1: %V $ok  $bad  %6.1f $pcc\% \n"


STOP!

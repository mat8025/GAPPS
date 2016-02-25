#! /usr/local/GASP/bin/asl

float dFT60 = 2.0
//int xbin

N = $2
<<" $N \n"

int ok = 0
int bad = 0
int ntest = 0

Graphic = 0


  if (!Graphic)
    <<" not  ~0 == $Graphic graphic true \n"
  else
    <<" 1  == %v $Graphic graphic  \n"



proc PR2ESB( prx)
{

 int xbin = prx/dFT60

    <<" PR2ESB $prx $xbin  \n"

<<" testing  Graphic $Graphic \n"

  if (!Graphic)
  return xbin 

<<" doing Graphic $Graphic $xbin\n"

  return (2*xbin)
}



y = 3.0

  x = PR2ESB(y)

<<" $y PR2ESB returns $x \n"

y++

  x = PR2ESB(y)

<<" $y PR2ESB returns $x \n"

STOP!

y = y + 1

 while (y < N) {

  x = PR2ESB(y)


  <<" while  $y $x \n"

   y++

  <<" after pinc $y \n"

 }


 if (y == N)
    ok++
 else
    bad++

 ntest++


 pcc= (100.0 * ok)/ntest

// int val = Trunc ((N-1)/2)

 int val = (N-1)/2

<<" $x == $val ? \n"

  if (x == val)
    ok++
 else
    bad++

 ntest++


//  if (x == (Trunc((N-1)/2))) {
  if (x == (N-1)/2) {
    ok++
 }
 else {
<<" $x != $val ? \n"
    bad++
 }

 ntest++

<<"%-24s:$1: :success $ok failures $bad  %6.1f $pcc\% \n"


STOP!

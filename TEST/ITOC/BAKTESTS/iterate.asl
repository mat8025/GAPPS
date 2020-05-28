#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

x0 = 0.1
last_x = x0

float Y[500+]


aw = CreateGwindow("resize",0.1,0.1,0.9,0.9,0)
SetGwindow(aw,"scales",0,-3,500,3)
SetGwindow(aw,"pixmapon","drawoff")
 col = 1


// gans=decision_w("_NEVER_GIVE_UP_", "Churchill says NEVER!"," AGREE ", " DISAGREE ")
// <<"answer back was $gans \n"

 for (c = 0.1 ; c <= 5.0 ; c += 0.05) {

  for (z = 0.05 ; z < 1.0 ; z += 0.005) {

    x0 = z

 for (i = 0 ; i < 500 ; i++) {

   x = c * (x0 -x0*x0)
//   x = c * atan(x0)
//   x =  exp(x0)

//   <<" $i $x $c $x0\n"
  Y[i] = x
  if (x == last_x) {
     break
  }
  x0 = x
  last_x = x
 }

<<" $c $z  \r"
 fflush(1)
 DrawY(aw,Y)

 gsync()
 
// sleep(0.5)
 SetGwindow(aw,"showpixmap","hue",col++)
  if (col > 16) {
      col = 1
  }
 SetGwindow(aw,"clearpixmap")
 }

 }

 STOP!
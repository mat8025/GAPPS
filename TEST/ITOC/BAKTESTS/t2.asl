///
///
///

include "debug.asl"
debugON()
setdebug(1,@trace)
 xv = vgen(FLOAT_,5,-10,5)

<<"%6.2f$xv\n"
<<"fit to square x*x \n"
  yv = xv * xv

<<"xv %6.2f$xv\n"
<<"yv %6.2f$yv\n"


  cv = polyncof(xv,yv,5)

<<"%6.3f$cv\n"
exit()

//    z[k] = cof[0] + x[k] * ( cof[1] + x[k] * ( cof[2] + x[k] * (cof[3] + x[k] * cof[4])))


c0 = 20
c1 = 1
c2 = 2
c3 = 3
c4 = 4

x = 7

   z = c0 + x * ( c1 + x * ( c2 + x * (c3 + x * c4))) ;

<<" $z = $c0 + $x * ( $c1 + $x * ( $c2 + $x * ($c3 + $x * $c4))) \n"
   



cv[0] = 20
cv[1] = 1
cv[2] = 2
cv[3] = 3
cv[4] = 4

//xv=vgen(FLOAT_,10,1,1)
//float xv[] = {-10.00,  -5.00,   0.00,   5.00,  10.00}

 


exit()


<<"$xv\n"

k = 4
<<"$xv[k] \n"
   z = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<" $z = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"


zv=vgen(FLOAT_,10,0,0)

<<"$zv\n"
     zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<" $zv[k] = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"

<<"%6.4f zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) \n"

 for (k = 0; k  < 5 ; k++) {

     zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<"%6.2f $zv[k] = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"
}


 yv = xv * xv * xv   + 1.8 * xv * xv

<<"xv %6.2f$xv\n"
<<"yv %6.2f$yv\n"

  cv = polyncof(xv,yv,5)

<<"cv $cv\n"

exit()

 for (k = 0; k  < 5 ; k++) {

     zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<"%6.2f $zv[k] = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"
}

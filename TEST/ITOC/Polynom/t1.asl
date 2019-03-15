///
///
///


//    z[k] = cof[0] + x[k] * ( cof[1] + x[k] * ( cof[2] + x[k] * (cof[3] + x[k] * cof[4])))


c0 = 20
c1 = 1
c2 = 2
c3 = 3
c4 = 4

x = 7

   z = c0 + x * ( c1 + x * ( c2 + x * (c3 + x * c4))) ;

<<" $z = $c0 + $x * ( $c1 + $x * ( $c2 + $x * ($c3 + $x * $c4))) \n"
   

int cv[10];

cv[0] = 20
cv[1] = 1
cv[2] = 2
cv[3] = 3
cv[4] = 4

xv=vgen(INT_,10,1,1)

<<"$xv\n"

k = 6
<<"$xv[k] \n"
   z = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<" $z = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"


zv=vgen(INT_,10,0,0)

<<"$zv\n"
     zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<" $zv[k] = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"

<<"zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) \n"

 for (k = 0; k  < 5 ; k++) {

     zv[k] = cv[0] + xv[k] * ( cv[1] + xv[k] * ( cv[2] + xv[k] * (cv[3] + xv[k] * cv[4]))) ;

<<" $zv[k] = $cv[0] + $xv[k] * ( $cv[1] + $xv[k] * ( $cv[2] + $xv[k] * ($cv[3] + $xv[k] * $cv[4]))) \n"

 }
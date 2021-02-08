/* 
 *  @script polynom.asl 
 * 
 *  @comment test polynom  
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.16 C-Li-S]                                
 *  @date Sat Feb  6 07:00:16 2021 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
////
///
///

// stats are in the math lib -- for now


chkIn(_dblevel)

float z[5]

 x = vgen(FLOAT_,5,-10,5)

<<"%6.2f$x\n"
<<"fit to square x*x \n"
 y = x * x

<<"%6.2f$x\n"

<<"%6.2f$y\n"

  cof = polyncof(x,y,5)

<<"%6.3f$cof \n"

<<"$cof[2] \n"

 chkR(cof[2],1.0)


 y = x * x * x

<<"X %6.2f$x\n"
<<"Y %6.2f$y\n"

 cof = polyncof(x,y,5)

<<"Cube %6.3f$cof \n"

chkR(cof[3],1.0)


 y = x * x * x   + 1.8 * x * x

<<"%6.2f$y\n"

  cof = polyncof(x,y,5)

<<"%6.3f$cof \n"

chkR(cof[3],1.0)

chkR(cof[2],1.8)


   for (k = 0; k  < 5 ; k++) {

      z[k] = cof[0] + x[k] * ( cof[1] + x[k] * ( cof[2] + x[k] * (cof[3] + x[k] * cof[4])))
<<"%V $k $x[k] $z[k]\n"
   }

<<"Z %6.4f$z[0:4] \n"
zr = Fround(z[0],2)
<<"%V6.4f$zr\n"
chkR(zr,-820.0)


chkOut()

chkR(Fround(z[0],2),-820.0)

   for (k = 0; k  < 5 ; k++) {

      z[k] = cof[4]
      for (j = 3 ; j >= 0; j--) {
         z[k] = z[k] * x[k] + cof[j]
      }
   }

<<"%6.2f$z[0:4] \n"


   v= polyGen(x, cof, 5)

<<"%V6.2f$v \n"


<<"fit to cube x*x*x \n"
 y = x * x * x

<<"%6.2f$x\n"

<<"%6.2f$y\n"

  cof = polyncof(x,y,5)

<<"$cof \n"

y = (x * x * x) /0.5 + 2 *x*x + 3*x + 4


<<"%V6.2f$x\n"

<<"%V6.2f$y\n"

  cof = polyncof(x,y,5)

<<"%V6.2f$cof \n"


   for (k = 0; k  < 5 ; k++) {
       z[k] = cof[4]
     for (j = 3; j >= 0; j--) {
       z[k] = z[k] * x[k] + cof[j];
     }

   }

<<"%6.2f$z \n"

<<"%V6.2f$x \n"

   v= polyGen(x, cof, 5)

<<"%V6.2f$v \n"

chkOut()


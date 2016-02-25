//
//  vector  subset opeq
//

setdebug(1,"pline")
 //float X[] = vgen(FLOAT_,10,0,1);  // fails

 Y = vgen(FLOAT_,10,0,1);

<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

      Y[1:5] = Y[1:5] * 3;

<<"$Y\n"

     Y[1:5] *= 3;

<<"opeq vers $Y\n"


exit()
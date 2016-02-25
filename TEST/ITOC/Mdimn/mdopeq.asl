
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

/{




 X = vgen(FLOAT_,10,47,1);


<<"X $X\n"

 float W[2] = {2,3};

<<"W= $W\n"




  Y += 2;

<<"$Y\n"


  Y /= 2;

<<"$Y\n"

  Y *= X;

<<"$Y\n"

  Y += X;

<<"$Y\n"


  Redimn(Y,5,2)

<<"$Y\n"


  Y *= 2;


<<"$Y\n"

  Y[0][::] = Y[0][::] * W;

<<"$Y\n"

  Y[0][::] *= W;

<<"$Y\n"
/}
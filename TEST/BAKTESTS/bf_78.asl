//
//  vector  subset opeq
//

setdebug(1,"pline","~step")

//float X[] = vgen(FLOAT_,10,0,1);  // fails

checkIn()

 Y = vgen(FLOAT_,10,0,1);

<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

checkNum(Y[2],4)

<<"$Y[2] == 4\n"

Y[2:8:2] *= 3;

<<"opeq vers $Y[::]\n"
<<"$Y\n"

<<"$Y[2] == 12\n"

checkNum(Y[2],12)


// BUG XIC -  array shifted left to index 1
//     Y[1:5] = Y[1:5] * 3;

Z= Y;

     Y[1:5]  *= 3;

     <<"$Y\n"

checkNum(Y[2],36)





<<"$Y[2] == 36\n"
<<"Z %6.1f$Z\n"


 Z[1:5] = Z[1:5] * 3;

<<"Z %6.1f$Z\n"

checkNum(Z[2],36)


checkOut()

exit()

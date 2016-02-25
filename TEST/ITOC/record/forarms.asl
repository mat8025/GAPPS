// armstrong number -ASL version
  n= 0  
    for (a=0; a<=9; a++) {
     for (b=0; b<=9; b++) {
       for (c=0; c<=9; c++) {
         d=  a*100 + b * 10 + c
         int z = a^3 + b^3 + c^3
         if (z == d) <<"$(++n) $d $z\n"
       }
     }
 }
STOP!
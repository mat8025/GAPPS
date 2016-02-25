// armstrong number -ASL version
  n= 0  
  for (e=0; e<=9; e++) {
    for (a=0; a<=9; a++) {
     for (b=0; b<=9; b++) {
       for (c=0; c<=9; c++) {
         d= e*1000 + a*100 + b * 10 + c
         int z = e^3 + a^3 + b^3 + c^3
         if (z == d) <<"$(++n) $d $z\n"
       }
     }
  }
 }
STOP!
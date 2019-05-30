// armstrong number -ASL version

//An Armstrong number is a number such that the sum !
// of its digits raised to the third power is equal to the number ! itself.
//For example, 371 is an Armstrong number, since  27 + 343 +1 = 371


int z;

<<"2 digit \n"
  n= 0  

    
     for (b=1; b<=9; b++) {
       for (c=0; c<=9; c++) {
          d =    b * 10 + c ;
          z =    b^2 + c^2 ;
//<<"$b $c  $d $z\n"
         if (z == d) {
	  ++n;
	 <<"$n  $z\n";
	 }
       }
     }

<<" there are $n anums for 2 digit nums \n"




<<"3 digit \n"
  n= 0  

    for (a=1; a<=9; a++) {
     for (b=0; b<=9; b++) {
       for (c=0; c<=9; c++) {
         d=  a*100 + b * 10 + c ;
          z =  a^3 + b^3 + c^3 ;
         if (z == d) {
	  ++n;
	 <<"$n  $z\n";
	 }
       }
     }
  }

<<" there are $n anums for 3 digit nums \n"

<<" 4 digit \n"
  n= 0  
  for (e=1; e<=9; e++) {
    for (a=0; a<=9; a++) {
     for (b=0; b<=9; b++) {
       for (c=0; c<=9; c++) {
         d= e*1000 + a*100 + b * 10 + c ;
          z = e^4 + a^4 + b^4 + c^4 ;
         if (z == d) {
	  ++n;
	 <<"$n  $z\n";
	 }
       }
     }
  }
 }

<<" there are $n anums for 4 digit nums \n"

<<" 5 digit \n"
  n= 0
  for (f=1; f<=9; f++) {
  for (e=0; e<=9; e++) {
    for (a=0; a<=9; a++) {
     for (b=0; b<=9; b++) {
       for (c=0; c<=9; c++) {
         d= f*10000 + e*1000 + a*100 + b * 10 + c ;
          z = f^5 + e^5 + a^5 + b^5 + c^5 ;
         if (z == d) {
	  ++n;
	 <<"$n  $z     \t                                       \t\n";
	 }
	 else {
	 y = z -d ;
	 <<"$z\t$d\t$y\r"

         }
       }
     }
  }
 }
}
//==========

<<" 6 digit \n"
  n= 0
  for (g=1; g<=9; g++) {
  for (f=0; f<=9; f++) {
  for (e=0; e<=9; e++) {
    for (a=0; a<=9; a++) {
     for (b=0; b<=9; b++) {
       for (c=0; c<=9; c++) {
         d= g*100000 + f*10000 + e*1000 + a*100 + b * 10 + c ;
          z = g^6 + f^6 + e^6 + a^6 + b^6 + c^6 ;
         if (z == d) {
	  ++n;
	 <<"$n  $z                                                         \n";
	 }
	 else {
	 y = z - d;
         <<"$z\t$d\t$y\r"
         }
       }
     }
  }
 }
}
}

STOP!
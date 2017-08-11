int tl = 0;
int ml = 0;

setdebug(1,"trace");

A=ofr("pincdec.asl")

<<"%V$A\n";

int n= 0;
while (1) {



   S= readline(A);

   a=tl++;

   if (tl > 30) {
     break;
   }
   ml--;
   <<"$a $tl $ml $n\t:: $S\n"
   n += 1;
   if (n > 25) {
     break;
   }
 }


<<"%V$tl \n";



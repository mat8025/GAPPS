

proc poo(d1,d2) 
{

<<" this is our first st \n"
int ok = 0
<<"%I $d1 $d2 \n"
<<"%V $d1 $d2 \n"

   if (d1 == d2) {
       ok = 1
   }

<<" returning? $ok\n"
}


<<" lost \n"


char a = 'A'

<<"%V $a \n"





 poo(65,a)


 poo((30+35),a)

stop!
;
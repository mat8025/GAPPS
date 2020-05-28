

wc = scnt('M')

<<"%V $wc $(typeof(wc))\n"

mc = scnt("t")

<<"%V $mc $(typeof(mc))\n"





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


<<"in\n"
 poo('A',a)
<<"out\n"

<<"in\n"
 poo(scnt('AT'),a)
<<"out\n"

<<"in\n"
 poo(a,scnt('MT'))
<<"out\n"
stop!

<<"%V $a \n"
 poo(a,65)

 poo(scnt("A"),a)



 poo(a,scnt("A"))




 stop!


;
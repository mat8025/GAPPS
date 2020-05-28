
CheckIn()

//setdebug(0)

wc = scnt('M')

<<"%V $wc $(typeof(wc))\n"

mc = scnt("t")

<<"%V $mc $(typeof(mc))\n"

int GA = 0

proc poo(d1,d2) 
{

<<" this is our first st \n"
int ok = 0
<<"%I $d1 $d2 \n"
<<"%V $d1 $d2 \n"

   if (d1 == d2) {
       ok = 1
   }
   GA++

<<" returning? $ok %V $GA\n"
}


<<" lost \n"


char a = 'A'


<<"in\n"
 poo('A',a)
<<"out\n"

  CheckNum(GA,1)
<<"in\n"
 poo(scnt('AT'),a)
<<"out\n"
  CheckNum(GA,2)
<<"in\n"
 poo(a,scnt('MT'))
<<"out\n"
  CheckNum(GA,3)

<<"%V $a \n"
 poo(a,65)

 poo(scnt("A"),a)



 poo(a,scnt("A"))


  CheckNum(GA,6)

  CheckOut()

 stop!


;
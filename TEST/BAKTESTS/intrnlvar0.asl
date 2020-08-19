


proc poo(a,b)

{

 c = a * b

 <<" in $_proc $_pargc args  : $a * $b = $c\n"
 <<"%,j $_pstack \n"
 sz = Caz(_pstack)
 if (sz < 10) 
 foo(a,c)

}


proc foo(a,b)

{
 c = a * b

 <<" in $_proc $_pargc args  : $a * $b = $c\n"
 <<"%,j $_pstack \n"
 poo(a,c)
}


<<" $_clarg \n"
<<" $_lstate \n"

poo(2,3)
 <<"%,j $_pstack \n"

<<" $_lstate \n"

STOP!
///
///  Atof
///

setDebug(1,@~trace,@~pline,@~soe);


checkIn()

p = _PI

  i = 47;
    <<"%I $i    \n"



  f= 1.2;
  sz = Caz(&f);
  <<"%V $f  $sz  \n"
    <<"%I $f    \n"

  f = atof("3.141593")

  sz = Caz(&f);
  <<"%V $f  $sz  \n"

 checkNum(sz,0)



A= Split("$_PI 1634 8208 9473")

<<"%V $A \n"

F=Atof(A)
 sz = Caz(F);
 bd = Cab(F);
 <<"%V $F  $sz $bd\n"
checkNum(sz,4)

G = Atof(A[1])
 sz = Caz(&G);
 bd = Cab(&G);
<<"%V $G $sz $bd \n"
checkNum(sz,0)

I = Atoi(A[2])
 sz = Caz(&I);
 bd = Cab(&I);
<<"%V $I $sz $bd \n"

checkNum(sz,0)

checkOut()



checkIn(_dblevel)

N=10


proc Foo(float rl[])
{
 int j1;
   j1 =2;
   float rxp;
<<"%V$rxp  $(typeof(rxp)) %i$rxp \n"

     rxp = rl[j1];
  <<" %V$j1 $rxp  $(cab(rxp))\n"
     rxp2 = rl[j1+1];
  <<" %V$j1 $rxp2  $(cab(rxp2))\n"
     j1 = 1;
   for (i = j1; i < N ; i++) {
     rxp = rl[j1];
  <<" %V$j1 $rxp  $(cab(rxp))\n"
     j1++;
   }

}
//----------------------------

proc fooey(float rl[])
{

<<"%I$rl   $(Caz(rl))\n"

     rxp = rl[1]
<<"$rxp\n"

<<"%I$rl   $(Caz(rl))\n"
    j1 = 1
     rxp = rl[j1]
<<"$rxp\n"
<<"$rl\n"
<<"%I$rl   $(Caz(rl))\n"
//  for (i = 0; i < 2; i++) {
    j2 = 2
     rl[j2] = rl[j1]
<<"%I$rl   $(Caz(rl))\n"
<<"$rl\n"
    j3 = 3
     rl[j1] = rl[j1] + rl[j2]
//<<"%I$rl \n"
vsz = Caz(rl)
<<"%V$vsz\n"
<<"$rl\n"

<<"%I$rl   $(Caz(rl))\n"
<<"$rl\n"
//  }
}




   Re = fgen(10,10,1)
<<"%i $Re\n"
<<"$Re\n"
   j =2;
   rxm = Re[j];
<<" %V$j $rxm  %i$rxm\n"

   rxm = Re[j+1];
<<" %V$j $rxm  %i$rxm\n"


   Foo(Re)

    fooey(Re)

sz = Caz(Re)

<<"%V$sz\n"

checkOut()



 
#! /usr/local/GASP/bin/asl



int ok = 0


proc poo(a)
{
c = 0
   ok = 0

  if (a > 0) {
       ok = 1
       c = 1
       return c
  }

ok = -1

     return c

}

int z[] = {0,1,2,3,4,5,6,8}

<<" $z \n"


proc poo2(a)
{
c = 0
   ok = 0

  for (i = 0 ; i < 7; i++) {
       if (a > z[i]) {
       c = 1
       ok = 1
<<"%V $i $a > $z[i] \n"
<<" FOR exit i $i SHOULD RETURN $c\n"
       return c
       }
  }


ok = -1
<<" main exit $i \n"
     return c

}





  poo(1)

k = -1
 while (1) {

   poo(k)
<<" %V $k $ok \n"

   poo2(k)
<<" %V $k $ok \n"

   k++
  if (k > 3)
    break
  }


STOP!

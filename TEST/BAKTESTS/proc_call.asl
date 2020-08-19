//%*********************************************** 
//*  @script proc_call.asl 
//* 
//*  @comment test out name mangling for proc/cmf  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Tue Mar 31 14:52:28 2020 
//*  @cdate Tue Mar 31 14:52:28 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///
///

#include "debug"

checkIn(_dblevel)


int n1 = 3;

<<"%V$n1\n"

      cn (n1,3)

n1++

<<"%V$n1\n"

      cn (n1,4)

++n1

<<"%V$n1\n"
      cn (n1,5)





proc moo(int a)
{
<<" $_proc $a \n"

  a->info(1)
     return a;
}
<<"moo(float) ?\n"

proc moo(float x)
{
<<" $_proc $x \n"

  x->info(1)
       return x;
}
<<"moo(short,char) ?\n"
proc moo(short s, char c)
{
<<" $_proc $s $c\n"

  s->info(1)
  c->info(1)

   d= s + c;

   return d;

}

<<"moo(pan , pan) ?\n"
proc moo (pan m, pan n)
{

   pan    d;

    d = m + n;
<<" $_proc %V $m $n $d \n"

   return d;


}
//===============


<<"moo(m , gen) ?\n"
proc moo (generic m, generic n)
{

   double d;

    d = m + n;
<<" $_proc %V $m $n $d \n"

   return d;


}
//===============
int j = 52;

<<"call moo int\n"
  k= moo(j)

cn (k,52);

float y = 2.1


<<"call moo float\n"
   z= moo(y)


cn (z,2.1);

short s1 = 67;
char c1 = 33;


<<"call moo short,char\n"
    s2 = moo(s1,c1)

cn (s2,100);

pan p  = 3.4

pan q = 1.2

 d4 = moo(p,q)

d4->info(1)
<<"%V$d4\n"


ans = "mark"
<<"Que pasa $ans ?\n"

gen g = 3.4
gen h = 8


    d3 = moo(h,g)

cn (d3,11.4);

 g = 77
 h = 23.0

    d3 = moo(h,g)

//<<"%V$d3\n"
d3->info(1)
cn (d3,100);


 a  = sin(0.5)

<<"%v$a \n"

checkOut()
  while (1) {
<<"Que pasa $ans ?\n"


   ans= i_read("??");

   if (ans == "quit") {
       break;
   }
   
}
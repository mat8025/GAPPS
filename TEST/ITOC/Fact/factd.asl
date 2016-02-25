#! /usr/local/GASP/bin/asl

// test proc recursion
// FIX - compile as declare then assign
//int N = $2

double M

int N

 N = $2

<<" $(typeof(N)) %v $N  \n"

M = N

<<" $(typeof(M)) %v $M  \n"

// FIX

//uint M = N
//uint M 


float k = 3

<<" START $(typeof(k)) $k $N $M \n"

//STOP!
 a = 2

 rn = 0

<<" %V $rn \n"

proc poo(a)
{
  b = a * 2
<<" $_cproc $b \n"
  return b
}



proc fact( pf)
{
//uint mpf
//uint t
double mpf
double t

      mpf = 1.0
      t = 1.0

     if (pf <= 1) {
<<" $_cproc end condition $pf \n"
      return 1
     }

     mpf = pf -1
//<<" arg in $_cproc %V $pf $(typeof(pf)) $mpf\n"
     t = fact(mpf) * pf
//     <<"exit $_cproc %V $(typeof(t)) $t $pf * $mpf \n"
     return t
}


 p =  fact(M)

<<" Fact returns $p \n"

<<" %V $N $p  %e $p\n"

 p =  fact(M+1)

<<" Fact returns $p \n"

<<" %V $N $p  %e $p\n"


STOP!




///////////////////////////////

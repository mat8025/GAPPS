#! /usr/local/GASP/bin/asl


// test proc recursion

N = $2

int k = 3

<<" START $k $N \n"

 a = 2

 rn = 0

<<" %V $rn \n"

proc poo(a)
{
  b = a * 2
<<" $_cproc $b \n"
  return b
}



proc fact(pf)
{
int mpf
int t

     if (pf <= 1) {
<<" $_cproc end condition $pf \n"
      return 1
     }

     mpf = pf -1
<<" arg in $_cproc %V $pf $mpf\n"
     t = poo(mpf) * pf
     <<"exit $_cproc %V $t $pf * $mpf \n"
     return t
}


 p =  fact(N)

<<" Fact returns $p \n"

<<" %V $N $p \n"

STOP!




///////////////////////////////

// test proc recursion

N = _clarg[1]

int k = 3

<<"START %V$k $N \n"

 a = 2

 rn = 0

<<" %V $rn \n"


proc fact(pf)
{
int mpf
int t

     if (pf <= 1) {
<<" $_cproc end condition $pf \n"
      return 1
     }

     rn++

     mpf = pf -1

<<" arg in $_cproc %V $rn $pf $mpf\n"

//     t = pf * mpf
//    t = poo(mpf)
//<<" poo returns  $t  \n"
//     t = pf * poo(mpf)
//    t = poo(mpf) * pf

     <<" %V  $pf * $mpf \n"

     t = pf * fact(mpf)

     <<"exit $_cproc %V $t $pf * $mpf \n"

     return t
}


 p =  fact(N)

<<" Fact returns $p \n"

<<" %V $N $p \n"

STOP!




///////////////////////////////

#! /usr/local/GASP/bin/asl


// test proc recursion

N = $2

int k = 3

<<" START $k $N \n"

 a = 2

 rn = 0

<<" %V $rn \n"

proc fact(pf)
{
int mpf

     if (pf <= 1) {
<<" try calling stop ! $pf\n"

<<" TRY STOP $pf \n"

<<" try calling stop ! \n"
//        STOP!

<<" AFTER STOP ~! \n"
      return 1
<<" AFTER return ! \n"
     }

<<" INCR RN \n"
     rn++

//     if (rn > N)         STOP!

     mpf = pf -1

<<" arg in $_cproc %V $rn $pf $mpf\n"

      t = pf * fact(mpf)
     //t= pf * mpf
     return t
}


 p =  fact(N)

<<" Fact returns $p \n"

<<" %V $N $p \n"

STOP!




///////////////////////////////

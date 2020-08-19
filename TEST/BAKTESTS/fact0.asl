#! /usr/local/GASP/bin/asl

// test proc recursion
// FIX - compile as declare then assign
//int N = $2
//double M

SetPCW("writepic","writeexe")

proc fact( pf)
{

//generic mpf

<<" arg in $_cproc %V $pf $(typeof(pf))\n"

double mpf

//      t = 1.0

     if (pf <= 1) {

<<" $_cproc end condition $pf \n"

      return 1
<<" should not see this \n"

     }

     mpf = pf -1

<<"  $_cproc %V  $mpf\n"
ttyin()

//     t = fact(mpf) * pf
     t = mpf * pf

     <<"exit $_cproc %V $(typeof(t)) $t $pf * $mpf \n"

     return t
}


int N

 N = GetArgI()

<<" $(typeof(N)) $N  \n"



// FIX

uint M 

M = N

<<" $(typeof(M)) $N $M \n"
ttyin()

int k = 3

<<" START $k $N $M \n"

 a = 2

 rn = 0

<<" %V $rn \n"

double fr
fr = 0.0


  fr= fact(3)

<<" $fr \n"

  fr= fact(4)

<<" $fr \n"

STOP!





 M = 1

 while (M <= N) {

 fr =  fact(M)

 <<" Fact returns $fr \n"

<<" $M $fr %e $fr\n"

 M++
 }

STOP!




///////////////////////////////

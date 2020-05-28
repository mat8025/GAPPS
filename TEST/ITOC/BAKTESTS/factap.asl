// test proc recursion
// FIX - compile as declare then assign
//int N = $2
//double M

proc fact(pf)
{

//generic mpf

<<" arg in $_cproc %V $pf $(typeof(pf))\n"

// FIX pan mpf

pan mpf;

      t = 1.0

     if (pf <= 1) {

<<" $_cproc end condition $pf \n"

      return 1

     }
   else {
     mpf = pf -1

<<"  $_cproc %V  $mpf\n"
//ttyin("about to recurse !! \n")

    t = fact(mpf) * pf

     <<"exit $_cproc %V $(typeof(t)) $t $pf * $mpf \n"
  }
     return t
}
//======================================



pan N

 N = atoi( _clarg[1])

pan M

<<"%V$N  $(typeof(N)) \n"

a = typeof(N)

<<" $N $a \n"

<<" $(typeof(N)) $N  \n"


M = N

<<" $(typeof(M)) $N $M \n"

int k = 3

<<" START $k $N $M \n"

 a = 2

 rn = 0

<<" %V$rn \n"

pan fr
 
 fr = 0.0

<<" $(typeof(N)) $N  \n"

//iread()
//fr =  fact(N)
//<<"\n  $N $fr \n"
<<"--------------------------\n"
//exit()

  pan F = N
  int i = N-1
  while (1) {

   F= F * i
   i -= 1
//<<"%p$F  \n"

<<"%p$F \n"





   if (i == 1)
     break

  }




exit_si()

  M = 1
 
  while (M <= N) {

  fr =  fact(M)

//<<" \n Fact returns $fr \n"

  <<"  $M $fr \n"

  M = M + 1

 }


STOP!




///////////////////////////////

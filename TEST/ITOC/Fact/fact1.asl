
// test proc recursion
// FIX - compile as declare then assign
//int N = $2
//double M

chkIn()

proc fact( pf)
{

//generic mpf

<<" arg in $_cproc %V $pf $(typeof(pf))\n"

// FIX pan mpf
double mpf

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


int N

 N = GetArgI()

<<" $(typeof(N)) $N  \n"



// FIX

uint M 

M = N

<<" $(typeof(M)) $N $M \n"
//ttyin()

int k = 3

<<" START $k $N $M \n"

 a = 2

 rn = 0

<<" %V $rn \n"

double fr
fr = 0.0

  fr= fact(1)

<<" 1! = $fr \n"
  chkR(fr,1,6)

  fr= fact(2)

<<"2! = $fr \n"
  chkR(fr,2,)

  fr= fact(3)

<<"3! = $fr \n"

  chkR(fr,6,6)
  fr= fact(4)

<<"4! = $fr \n"

  chkR(fr,24.0,6)


 fr =  fact(N)

 <<" Fact $N ! returns $fr \n"

<<" $N ! $fr %e $fr\n"

    chkOut()

STOP!




///////////////////////////////

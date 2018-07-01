///
/// test proc recursion
/// FIX - compile as declare then assign
//int N = $2
//double M

#define DBP <<

CheckIn()

proc fact( pf)
{

//generic mpf

DBP" arg in $_proc %V $pf $(typeof(pf))\n"

// FIX pan mpf
ulong mpf;
ulong  t;

     t = 1;

     if (pf <= 1) {

DBP" $_proc end condition $pf \n"
     }
   else {
     mpf = pf -1

DBP"  $_proc %V$mpf\n"
//ttyin("about to recurse !! \n")

    t = fact(mpf) * pf

<<"exit $_proc %V $(typeof(t)) $t $pf * $mpf \n"
  }
     return t;
}
//=====================================


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

ulong fr;

fr = 0;

  fr= fact(1);

<<" 1! = $fr \n"
  CheckFNum(fr,1,6)

  fr= fact(2);

<<"2! = $fr \n"
  CheckFNum(fr,2,)

  fr= fact(3);

<<"3! = $fr \n"

  CheckFNum(fr,6,6)
  fr= fact(4);

<<"4! = $fr \n"

  CheckFNum(fr,24.0,6)


   fr =  fact(N);

 <<" Fact $N ! returns $fr \n"

<<" $N ! $fr %e $fr\n"

    CheckOut()

exit();




///////////////////////////////

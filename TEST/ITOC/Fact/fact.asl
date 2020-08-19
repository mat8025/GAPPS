//%*********************************************** 
//*  @script fact.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.55 C-He-Cs]                              
//*  @date Wed Jun  3 08:17:35 2020 
//*  @cdate Wed Jan  9 07:14:37 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
/// test proc recursion
/// FIX - compile as declare then assign
//int N = $2
//double M




#define DBP <<

chkIn(_dblevel)

// want to use ulong


proc Foo(long pf)
{

long mpf;
long  t;

    t = 1;

<<"  $_proc %V$pf\n" 

    if (pf <= 1) {

     DBP" $_proc end condition $pf $t\n"

      return t;
     }
    else {

    mpf = pf -1

    t = Foo(mpf) * pf

<<"exit $_proc %V $(typeof(t)) $mpf $pf ! =  $t \n"
    }


return t;

}



//======================================//
proc Foo(pan pf)
{
  static int PF = 1;
 <<"$_proc $pf  $PF\n"
  PF++;
  pan t=1;
  a= pf
  pf--
  if (pf < 1) {
 <<"$_proc $pf < 1  \n"
   return t
  }
  else {
  t=  Foo(pf) *a ;
<<"%V $a $pf $t\n"
  }
  return t
}

//======================================//


proc Fact(int pf)
{

 pan t = 1;
 for (i= 1 ; i <= pf ; i++) {

    t *= i;

<<"$i  $t\n"

 }

   return t;
}



//=====================================



long n = 1;
long N = 10;
k= atoi(_clarg[1])
if (k != 0) {
   N= k
}

// recursion -- statement XIC is rentered
// compute initial conditions 1,2 - first for xic to work
// then statement is closed -so no more WIC/XIC
m= Foo(n)
<<"%V $m $n\n"
n++;

m= Foo(n)
<<"%V $m $n\n"




m= Foo(N)

<<"%V $m $n\n"

pr = Fact(N)

<<"%V $pr $m\n"
//
m->info(1)
pr->info(1)

if (pr == m) {
<<"N! $pr == $m Pass\n"
}

long L = pr

if (L == m) {
<<"N! $L == $m Pass\n"
}

chkN(m,L)

chkOut()
exit()





long fr;

fr1 =0;fr2 =0;fr3 =0;
fr4=0;

 //
long L = 1

fr1=Fact(L)

<<"%V $L $fr1 \n"



L=2
fr2= Fact(L)
//fr3= Fact(3)

exit()

L=4
fr4 =Fact(L)


exit()
long N

 N = GetArgI()

<<" $(typeof(N)) $N  \n"

 fr=Fact(N)

<<" $N ! == $fr  \n"

<<"1! 1 == $fr\n"

 fr=Fact(2)

<<"2! 2 == $fr\n"



 fr=Fact(3)

<<"3! 6 == $fr\n"




 fr=Fact(4)

<<"4! 24 == $fr\n"


 fr=Fact(5)

<<"5! 120== $fr\n"

 fr=Fact(4)

<<"4! 24 == $fr\n"

 fr=Fact(N)

<<"$N! $fr\n"






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



fr = 0;

n=1
  fr= Fact(n);

<<" 1! = $fr \n"
  chkR(fr,1,6)

n++
  fr= Fact(n);

<<"2! = $fr \n"
  chkR(fr,2)


n++
  fr= Fact(n);

<<"3! = $fr \n"

  chkR(fr,6,6)

n++

  fr4= Fact(n);
<<"4! = $fr4 \n"
//chkStr(fr4,"24")
  chkR(fr4,24.0,6)

  fr= Fact(5);
<<"5! = $fr \n"

  chkR(fr,120.0,6)

<<" N! == ? \n";

<<" N! == ? \n";

   fr =  Fact(N);

 <<" Fact $N ! returns $fr \n"

<<" $N ! $fr %e $fr\n"


<<"1! $fr1\n"
<<"2! $fr2\n"
<<"3! $fr3\n"
<<"4! $fr4\n"

chkOut()






///////////////////////////////

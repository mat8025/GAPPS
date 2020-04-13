//%*********************************************** 
//*  @script fact.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Wed Jan  9 07:14:37 2019 
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


setdebug(1,@keep);


filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


#define DBP <<

checkIn()

// want to use ulong

proc Fact(long pf)
{

DBP" arg in $_proc %V $pf $(typeof(pf))\n"

// FIX pan mpf
// ulong mpf;
long mpf;
//ulong  t;
long  t;
    mpf = 0;
    t = 1;


DBP"  $_proc %V$mpf\n"
//ttyin("about to recurse !! \n")
     if (pf <= 1) {

DBP" $_proc end condition $pf $t\n"
      return t;
     }
    else {

    mpf = pf -1

    t = Fact(mpf) * pf

<<"exit $_proc %V $(typeof(t)) $mpf $pf ! =  $t \n"
    }

//<<" ret $t\n"
t->info(1)
return t;
}
//=====================================

long fr;

fr1 =0;fr2 =0;fr3 =0;
fr4=0;

 //
long L = 1
fr1=Fact(L)

L=2
fr2= Fact(L)
//fr3= Fact(3)
L=4
fr4 =Fact(L)
  
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
  checkFNum(fr,1,6)

n++
  fr= Fact(n);

<<"2! = $fr \n"
  checkFNum(fr,2)


n++
  fr= Fact(n);

<<"3! = $fr \n"

  checkFNum(fr,6,6)

n++

  fr4= Fact(n);
<<"4! = $fr4 \n"
//checkStr(fr4,"24")
  checkFNum(fr4,24.0,6)

  fr= Fact(5);
<<"5! = $fr \n"

  checkFNum(fr,120.0,6)

<<" N! == ? \n";

<<" N! == ? \n";

   fr =  Fact(N);

 <<" Fact $N ! returns $fr \n"

<<" $N ! $fr %e $fr\n"


<<"1! $fr1\n"
<<"2! $fr2\n"
<<"3! $fr3\n"
<<"4! $fr4\n"

checkOut()






///////////////////////////////

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

CheckIn()

proc fact( pf)
{

//generic mpf

DBP" arg in $_proc %V $pf $(typeof(pf))\n"

// FIX pan mpf
 ulong mpf;
 ulong  t;
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

    t = fact(mpf) * pf

<<"exit $_proc %V $(typeof(t)) $mpf $pf ! =  $t \n"
    }

//<<" ret $t\n"
t->info(1)
return t;
}
//=====================================

ulong fr;

fr1 =0;fr2 =0;fr3 =0;
fr4=0;

 //
fr1=fact(1)
fr2= fact(2)
//fr3= fact(3)

fr4 =fact(4)
  
int N

 N = GetArgI()

<<" $(typeof(N)) $N  \n"

 fr=fact(N)

<<" $N ! == $fr  \n"

<<"1! 1 == $fr\n"

 fr=fact(2)

<<"2! 2 == $fr\n"



 fr=fact(3)

<<"3! 6 == $fr\n"




 fr=fact(4)

<<"4! 24 == $fr\n"


 fr=fact(5)

<<"5! 120== $fr\n"

 fr=fact(4)

<<"4! 24 == $fr\n"

 fr=fact(N)

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
  fr= fact(n);

<<" 1! = $fr \n"
  CheckFNum(fr,1,6)

n++
  fr= fact(n);

<<"2! = $fr \n"
  CheckFNum(fr,2)


n++
  fr= fact(n);

<<"3! = $fr \n"

  CheckFNum(fr,6,6)

n++

  fr4= fact(n);
<<"4! = $fr4 \n"
//CheckStr(fr4,"24")
  CheckFNum(fr4,24.0,6)

  fr= fact(5);
<<"5! = $fr \n"

  CheckFNum(fr,120.0,6)

<<" N! == ? \n";

<<" N! == ? \n";

   fr =  fact(N);

 <<" Fact $N ! returns $fr \n"

<<" $N ! $fr %e $fr\n"


<<"1! $fr1\n"
<<"2! $fr2\n"
<<"3! $fr3\n"
<<"4! $fr4\n"

    CheckOut()



exit();




///////////////////////////////

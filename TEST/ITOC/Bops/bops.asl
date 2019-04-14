//%*********************************************** 
//*  @script bops.asl 
//* 
//*  @comment test basic ops  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Thu Mar  7 23:24:30 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"

debugON()
setdebug(1,@pline,@trace,@keep)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


checkIn(0)

//prog= GetScript()

float fn=2.71828;
<<"%V$fn\n"
CheckFNum(fn,2.71828)

int d= 7;
<<"%V$d\n"
int e = -6


CheckNum(d,7)
CheckNum(e,-6)

int b = 79;

CheckNum(b,79)

b = d * e;

<<"%V$b\n"

CheckNum(b,-42);


b++;


<<"%V$b\n"

CheckNum(b,-41);


na = argc()

if (na >= 1) {
 for (i = 0; i < argc() ; i++) {
<<"arg [${i}] $_clarg[i] \n"
 }
}
<<"args listed\n"








//    CheckOut()
//    exit()

//a = 2 + 2
int a = 2 + 2
<<"%V$a\n"

CheckNum(a,4)

b = 7 * 6

<<"%V$b\n"

CheckNum(b,42)


c= a * b

CheckNum(c,(4*42))

<<"$c $a $b \n"


z = Sin(0.9)

<<" %v $z \n"


x = Cos(0.9)

<<" %v $z $x \n"

//   test some basics -- before using testsuite  



int k=4;


<<"%V $k \n"

CheckNum(k,4)

int k1 = 47

<<"%V $k1 \n"

CheckNum(k1,47)


float y = 3.2

<<"%V $y \n"

 CheckFNum(y,3.2,6)

a = 2 + 2

<<"%v $a \n"
//     CheckNum(a,4)

sal = 40 * 75 * 4

<<"%v $sal \n"

 CheckNum(sal,12000)


int n = 1

<<"%V $n \n"

        CheckNum(n,1)


n++

       CheckNum(n,2)


++n

      CheckNum(n,3)

<<"%V $n \n"

   z = n++ + 1
<<"%V $z \n"

      CheckNum(n,4)

      CheckNum(z,4)

<<"%v $n \n"

   z = ++n + 1
<<"%V $z \n"

      CheckNum(z,6)

<<"%V $n \n"

++n++

<<"%V $n \n"

    CheckNum(n,7)




N = 24

k = 2
ok =0
  if (k <= N) {
<<" $k  <= $N \n"
   ok = 1
<<" <= op  working!\n"
  }
  else {
<<" <= op not working! %V$k\n"
  }

CheckNum(1,ok)

ok = 0
k = 25

  if (k >= N) {
<<" $k  >= $N \n"
   ok = 1
<<" >= op  working!\n"
  }
  else {
<<" >= op not working! %V$k\n"
  }


CheckNum(1,ok)

  ok = 0

  if (k != N) {
<<" $k  != $N \n"
   ok = 1
<<" != op  working!\n"
  }
  else {
<<" != op not working! %V$k\n"
  }

CheckNum(1,ok)


float fa = 1;
float fb = 2.3;
float fc = 4.8;

CheckFnum(fb,2.3)
<<"%V$fa $fb $fc\n"
  fb++ 
CheckFnum(fb,3.3)

<<"%V$fa $fb $fc\n"  

int h = -4;

<<"%V$h\n"

CheckNum(h,-4);

float q=-7;<<"$q\n"

CheckFNum(q,-7);

  int sum = 0;
  double mi = 1;
  N = 1000;
  
  for (k = 0; k < N; k++) {

    sum += k;
    mi *= k;
<<"%V $k $sum $mi \n"
  }

<<"%V $sum  $k  $(k*N/2) $mi\n"

<<"B4 CheckOut()\n"
CheckOut()

ans = iread(">>>:")
<<"after CheckOut()\n"
//float ok = 47.2
//<<"$ok \n"



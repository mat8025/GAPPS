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


#include "debug"


if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)


int n1 = 1;

<<"%V $n1 \n"

        chkN(n1,1)


   n1++;

<<"%V $n1 \n"

      chkN(n1,2)




   ++n1;

<<"%V $n1 \n"

  chkN(n1,3)



   n1 += 2

chkN(n1,5)


   n1 -= 2

chkN(n1,3)


  n1 *= 2

chkN(n1,6)


  n1 /= 2

chkN(n1,3)







float fn=2.71828;
<<"%V$fn\n"
 chkR(fn,2.71828)

int d= 7;

int e = -6;

int u = 47
int w = -79;

<<"%V$d $e\n"

<<"%V$u $w\n"




chkN(d,7)
chkN(e,-6)

int b = 79;

<<"%V $b\n"

chkN(b,79)
<<"%V$d $e\n"
b = d * e;

<<"%V$b\n"

chkN(b,-42);


b++;


<<"%V$b\n"

chkN(b,-41);

//co()
//exit()

na = argc()
<<"%V $na\n"
i = 0
<<"arg [${i}] $_clarg[i] \n"
i++;
<<"arg [${i}] $_clarg[i] \n"
i++;
<<"arg [${i}] $_clarg[i] \n"



if (na >= 1) {

 for (i = 0 ; i < na ; i++) {
<<"arg [${i}] $_clarg[i] \n"

  if (i == 10) {
<<"i == 5 %V $i\n"
   break;
  }
 // <<"%V $i\n"
 }

}
<<"args listed\n"


int a = 2 + 2
<<"%V$a\n"

chkN(a,4)

b = 7 * 6

<<"%V$b\n"

chkN(b,42)


c= a * b

chkN(c,(4*42))

<<"$c $a $b \n"


z = Sin(0.9)

<<" %v $z \n"


x = Cos(0.9)

<<" %v $z $x \n"

//   test some basics -- before using testsuite  



int k=4;


<<"%V $k \n"

chkN(k,4)

int k1 = 47

<<"%V $k1 \n"

chkN(k1,47)


float y = 3.2

<<"%V $y \n"

 chkR(y,3.2,6)

a = 2 + 2

<<"%v $a \n"
//     chkN(a,4)

sal = 40 * 75 * 4

<<"%v $sal \n"

 chkN(sal,12000)



int n = 1;

<<"%V $n \n"

      //  chkN(n,1)


   n++

<<"%V $n \n"

    //   chkN(n,2)


   ++n

<<"%V $n \n"

      chkN(n,3)

<<"%V $n \n"

   z = n++ + 1
<<"%V $z \n"

      chkN(n,4)

      chkN(z,4)

<<"%v $n \n"

   z = ++n + 1
<<"%V $z \n"

      chkN(z,6)

<<"%V $n \n"

++n++

<<"%V $n \n"

    chkN(n,7)




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

chkN(1,ok)

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


chkN(1,ok)

  ok = 0

  if (k != N) {
<<" $k  != $N \n"
   ok = 1
<<" != op  working!\n"
  }
  else {
<<" != op not working! %V$k\n"
  }

chkN(1,ok)


float fa = 1;
float fb = 2.3;
float fc = 4.8;

chkR(fb,2.3)
<<"%V$fa $fb $fc\n"
  fb++ 
chkR(fb,3.3)

<<"%V$fa $fb $fc\n"  

int h = -4;

<<"%V$h\n"

chkN(h,-4);

float q=-7;<<"$q\n"

chkR(q,-7);

  int sum = 0;
  double mi = 1;
  N = 100;
  
  for (k = 0; k < N; k++) {

    sum += k;
    mi *= k;
<<"%V $k $sum $mi \n"
  }

<<"%V $sum  $k  $(k*N/2) $mi\n"

fv = vgen(FLOAT_,10,0,1)
fv->info()

<<"$fv \n"

 fv[0] = -32;
 fv[2] = 77;
 fv[3] = 80;

<<"$fv \n"

chkN(fv[3],80)

chkOut()



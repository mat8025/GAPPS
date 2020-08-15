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


include "debug"

debugON()

checkIn(_dblevel)

//prog= GetScript()

int n1 = 1;

<<"%V $n1 \n"

        checkNum(n1,1)


   n1++

<<"%V $n1 \n"

      checkNum(n1,2)




   ++n1

<<"%V $n1 \n"

  checkNum(n1,3)



   n1 += 2

checkNum(n1,5)


   n1 -= 2

checkNum(n1,3)


  n1 *= 2

checkNum(n1,6)


  n1 /= 2

checkNum(n1,3)







float fn=2.71828;
<<"%V$fn\n"
CheckFNum(fn,2.71828)

int d= 7;

int e = -6;

int u = 47
int w = -79;

<<"%V$d $e\n"

<<"%V$u $w\n"




checkNum(d,7)
checkNum(e,-6)

int b = 79;

<<"%V $b\n"

checkNum(b,79)
<<"%V$d $e\n"
b = d * e;

<<"%V$b\n"

checkNum(b,-42);


b++;


<<"%V$b\n"

checkNum(b,-41);

co()
exit()

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


//checkOut()





//    CheckOut()
//    exit()

//a = 2 + 2
int a = 2 + 2
<<"%V$a\n"

checkNum(a,4)

b = 7 * 6

<<"%V$b\n"

checkNum(b,42)


c= a * b

checkNum(c,(4*42))

<<"$c $a $b \n"


z = Sin(0.9)

<<" %v $z \n"


x = Cos(0.9)

<<" %v $z $x \n"

//   test some basics -- before using testsuite  



int k=4;


<<"%V $k \n"

checkNum(k,4)

int k1 = 47

<<"%V $k1 \n"

checkNum(k1,47)


float y = 3.2

<<"%V $y \n"

 CheckFNum(y,3.2,6)

a = 2 + 2

<<"%v $a \n"
//     checkNum(a,4)

sal = 40 * 75 * 4

<<"%v $sal \n"

 checkNum(sal,12000)


int n = 1;

<<"%V $n \n"

      //  checkNum(n,1)


   n++

<<"%V $n \n"

    //   checkNum(n,2)


   ++n

<<"%V $n \n"

      checkNum(n,3)

<<"%V $n \n"

   z = n++ + 1
<<"%V $z \n"

      checkNum(n,4)

      checkNum(z,4)

<<"%v $n \n"

   z = ++n + 1
<<"%V $z \n"

      checkNum(z,6)

<<"%V $n \n"

++n++

<<"%V $n \n"

    checkNum(n,7)




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

checkNum(1,ok)

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


checkNum(1,ok)

  ok = 0

  if (k != N) {
<<" $k  != $N \n"
   ok = 1
<<" != op  working!\n"
  }
  else {
<<" != op not working! %V$k\n"
  }

checkNum(1,ok)


float fa = 1;
float fb = 2.3;
float fc = 4.8;

checkFnum(fb,2.3)
<<"%V$fa $fb $fc\n"
  fb++ 
checkFnum(fb,3.3)

<<"%V$fa $fb $fc\n"  

int h = -4;

<<"%V$h\n"

checkNum(h,-4);

float q=-7;<<"$q\n"

checkFNum(q,-7);

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

checkNum(fv[3],80)

checkOut()



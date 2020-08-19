//%*********************************************** 
//*  @script pan.asl 
//* 
//*  @comment test_pan numbers 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.47 C-He-Ag]                             
//*  @date Fri May 15 23:25:45 2020 
//*  @cdate 1/1/1999 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



setap(50);    // set precision to 100? decimal places

// FIX pan N  = GetArgN()


chkIn(_dblevel);


x = 2.1234567
pan N = x;
pan M = 4.00;

pan c= 300000000.0;
pan a = 1.0/c;

<<"%e $a\n"

//ans = iread()


pan_prec = 1;

chkR(N,x,pan_prec);

<<" $N $x\n"


chkR(M,4.0,3);


 Q= N +M ;

<<"%V%p$Q\n"

 //chkN(Q,6.0);

 Q= N * M ;

<<"%V%p$Q\n"

<<"$Q  $N $M \n"
//chkR(Q,8.0);

chkR(Q,(x*4.0),pan_prec);

<<"$Q  $(x*4.0) \n"

double q = Q
double n = N

r = q/n

<<"%v$r \n"
pan qp = 8.4938268
pan np = 2.123456700
R= qp/np
<<"%V$R\n"
<<"$(typeof(R))\n"
qp = Q
np = N

<<"%V$qp\n"
<<"%V$np\n"

R= qp/np
<<"%V$R\n"
 q = Q
 n = N

r = q/n
<<"%V$r\n"

 q = qp
 n = np
 n += .01
r = q/n
<<"%V$r\n"

r = qp/np
<<"%V$r\n"



 R = Q/N

<<"%V%p$Q\n"
<<"%V$Q\n"
<<"%V$N\n"
<<"%V$R\n"
<<"%V$R\n"
<<"%V$M\n"

//chkR(R,M,pan_prec);
 r= fround(R,1);

<<"%V$r\n"
chkR(r,M,2);

//query()
<<"%V$M\n"
 M = M + 1;  // TBF XIC bug
<<"%V$M\n"

<<"M++\n"

 M++;
<<"%V$M\n"


<<"%V%p$M\n"

 k = 3;
<<"$k\n" 
 chkR(k,3)
 k= k +1;
<<"$k\n" 
 chkR(k,4)
 k++;
<<"$k\n" 
 chkR(k,5)


<<"%V $pan_prec \n"
<<"%V $M \n"


 chkR(M,6.0,pan_prec);

 M--;

<<"%V $M \n"

 chkR(M,5.0,pan_prec);


  M = M + 4.9

<<"%V $M \n"

 chkR(M,9.9,pan_prec);

pan P = 2.1

  M = M + P

<<"%V $M \n"

chkR(M,12.0,pan_prec);

 chkOut()

exit()

<<"%V$N $M\n"

<<"$(typeof(M))\n"

P = N * M

<<"$P $(typeof(P))\n"


//N = 12345678987654321
//M = 98765432123456789


P = N * M

<<"$P $(typeof(P))\n"

N = P / M

<<"$N $(typeof(N))\n"

icompile(0)

pan ans

uint n
uint m
uint p

 if (anotherArg()) {
  N  = getArgN()
 }



<<"%V$N \n"



 if (anotherArg()) {
  M = GetArgN()
 }

<<"%V$M\n"


P = N * M

<<" $P = $N * $M \n"
<<"$(typeof(N)) $(typeof(M)) $(typeof(P))\n"

n = N
m = M
p = n * m
<<" $p = $n * $m \n"
<<"$(typeof(n)) $(typeof(m)) $(typeof(p))\n"

nc = 35
  p = 1
  for (i = 1; i < nc ; i++) {
     p = p * 2
<<"$i $p \n"
  }

//ans=iread("-)")

nc = 200
  P = 1
  for (i = 1; i < nc ; i++) {
     P = P * 2
//    P *= 2

<<"$i $P \n"
//ans=iread("-)")
  }




P = 2 
M = 1
N = 0
 
for (i=0;i<15;i++)  {
    <<"$i $N\n"
    <<" $M \n"
    <<"$P  \n";  
    N= M ; 
//    M= M +P; 
   M *= P
   P= M
}



Q = N / M

<<" $Q =  $N/ $M   \n"

R = P / M

<<" $R =  $P/ $M   \n"

float y 

   y = Fround(R,2)

<<"%V$y \n"

int k

  k = Fround(R,2)

<<"%V$k \n"

   y = Fround(R)

<<"%V$y \n"


  k = Fround(R)

<<"%V$k \n"


  r = Sqrt(R)

  ans = r * r

<<"%V$R  sqrt is \n$r \n"
<<"$ans \n"
<<"$(typeof(ans))\n"

  ans = (r * r) / .8765;
<<"$ans \n"
  ans *= .8765;
<<"$ans \n"

 i = 0
 P = 4

 NI = 3

 while (i < NI) {


  P = P * 2

<<"$i $P = %V$P * 2\n"

<<" $(panilength(P)) \n"

  i++

 }

 P = 4;
 i = 0;

 while (i < NI) {

<<"%V$P \n"  
  P *=  2;
<<"$i *= 2 %V$P\n"

//<<" $(panilength(P)) \n"

  i++;

 }

 P = 4
 i = 0

 

 while (i < NI) {

<<"P = 2 * %V$P \n"
  P = 2 * P
<<"$i  $P\n"

//<<" $(panilength(P)) \n"

  i++

 }


exit()

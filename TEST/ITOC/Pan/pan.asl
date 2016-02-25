// FIX - compile as declare then assign
//int N = $2
//double M


//setdebug(1,"pline","steponerror")

//setdebug(1,"pline","runtoerror")

setap(100)    // set precision to 50 decimal places

// FIX pan N  = GetArgN()
checkIn()
pan N = 2.0;
pan M = 4.0;


checkNum(N,2.0);
checkNum(M,4.0);


 Q= N +M ;

<<"%V%p$Q\n"

 checkNum(Q,6.0);

 Q= N * M ;

checkNum(Q,8.0);

 Q = M/N;

checkNum(Q,2.0);


 M++;
 checkNum(M,5.0);

 M--;
 checkNum(M,4.0);



checkOut()

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

  ans = (r * r) / .8765
<<"$ans \n"
  ans *= .8765
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

 P = 4
 i = 0

 while (i < NI) {

<<"%V$P \n"  
  P *=  2
<<"$i *= 2 %V$P\n"

//<<" $(panilength(P)) \n"

  i++

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

STOP!

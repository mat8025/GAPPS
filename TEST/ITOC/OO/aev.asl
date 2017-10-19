
int A[10]


i = 3
A[i] = 3
k= A[i]

<<"$i $k\n"

k++

int B[20][20]

i = 2
k = 7
 B[i][k] = 47

j = B[i][k]

<<"$j $B[i][k] \n"


 B[i+k][k] = 79

j = B[i+k][k]

<<"$j $B[i+k][k] \n"

 B[i+k][k*2] = 80

 j = B[i+k][k*2]

 B[i+k][k*2] = 80

 aev1 = B[i+k][k*2]

 B[k-i][i*3] = 82

<<"%V$i $k \n"

 aev2 = B[k-i][i*3]

 <<"%V$aev2 == $B[k-i][i*3] \n"

 <<"%V$aev1 == $B[i+k][k*2] \n"

/////////////////////////////////
int C[20]

   C->set(0,1)
<<"$C \n"


 B[C[1]][C[8]] = 28

 yv = B[C[1]][C[8]]

 yv1 = B[1][8]

<<"%V$B[C[1]][C[8]] \n"


<<"%V$yv $yv1 \n"

 i = 3
 k = 4
 j = 1

 B[C[i]][C[k]] = 30

 yv = B[C[i]][C[k]]

<<"%V$i $k\n"
<<"%V$C[i] $C[k]\n"

<<"%V$yv $B[C[i]][C[k]] \n"

 B[C[i+j]][C[k-j]] = 40

 yv = B[C[i+j]][C[k-j]]

<<"%V$i $k $j\n"
<<"%V$C[i+j] $C[k-j]\n"

<<"%V$yv $B[C[i+j]][C[k-j]] \n"
  k = 1
  for (i = 10 ; i <19 ; i++) {
   for (k = 1; k <=20 ; k++) {
    B[C[i+j]][C[k-j]] =  (20 *(i+j)) + (k-j)
   }
  }


<<"$B\n"

  k = 1
  for (i = 10 ; i <19 ; i++) {
   for (k = 1; k <=20 ; k++) {
    B[C[i+j]][C[k-j]] =  -1
   }
  }

  k = 1
  m  = 2
  for (i = 10 ; i <19 ; i++) {
   for (k = 0; k < 10 ; k++) {
    B[C[i+j]][C[k*m]] =  (20 *(i+j)) + (k*m)
   }
  }


<<"$B\n"


  exit()


/// now lets fix the array member chain parse

int act_ocnt = 0;

class Act {

 public:

 int type;
 int mins; 
 int t;

 CMF Set(s)
 {
     obid = _cobj->obid()
//     <<"Act Set  $_cobj  $obid $(offsetof(&_cobj)) $(IDof(&_cobj))\n" 
     <<"Act Set  $_cobj \n" 
      type = s
     <<"type  $s $type\n"
     return type
 }

 CMF Get()
 {
   return type
 }

 CMF Act() 
 {
   <<"Act cons of $_cobj $act_ocnt\n"
   act_ocnt++
   type = 1
   mins = 10;
   t = 0;
 }

}

Act a

  a->type = 5;

  <<"$a->type \n"


<<"/////////////////// Nested Class /////////////\n"

int dil_ocnt = 0

class Dil {

 public:
 int w_day;

// Act A[3] ;
// FIXME each cons of A tacks on anotherstatement ??
//

 Act A[3]
 Act B;

 CMF Dil() 
 {
   w_day = 1
   //<<"cons of Dil $_cobj $w_day $dil_ocnt\n"
   dil_ocnt++ 
 }

}

xov = 20

<<" after class def \n"

Dil G[3]

 G[0]->A[0]->t = 78

   yt0 = G[0]->A[0]->t

<<"%V $yt0 \n"

i = 2
k = 1

 G[i+k]->A[k*2]->t = 47

   yt1 = G[i+k]->A[k*2]->t

<<"%V$yt1 \n"


int A[10]


i = 3
A[i] = 3
k= A[i]

<<"$i $k\n"

k++

/// now lets fix the array member chain parse

int act_ocnt = 0; // this should be tied to Class Act

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
//   <<"Act cons of $_cobj $act_ocnt\n"
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

 Act A[7]
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

Dil G[7]

 G[1]->A[2]->t = 79

 yt0 = G[1]->A[2]->t

<<"%V $yt0 \n"

 G[2]->A[3]->t = 47

 yt1 = G[2]->A[3]->t

<<"%V $yt1 \n"


i = 2
k = 3

 G[i]->A[k]->t = 74

 yt2 = G[i]->A[k]->t

<<"%V $yt2 \n"

 G[i*k]->A[k]->t = 80

   yt3 = G[i*k]->A[k]->t

<<"%V$yt3 \n"

 G[i*k]->A[k+2]->t = 28

   yt4 = G[i*k]->A[k+2]->t

<<"%V$yt4 \n"

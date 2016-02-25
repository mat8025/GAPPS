//   exercise member class
setdebug(0)
#define WALK 1
#define HIKE 2
#define RUN 3
#define BIKE 4
#define SWIM 5
#define TRDMILL 6
#define WTLIFT  7

char C[256]


class Activity {

 public:

 int type;
 uint duration;  //  mins
 float distance;  // Km 
 float speed;
 int intensity;

 CMF Get()
 {
 <<"Activity get %V is $type \n"
  return type
 }

 CMF Set(wt)
 {
  type = wt
 <<"Setting Activity %V to $wt $type \n"
 }

 CMF Print()
 {
 <<"Activity  \n"
  <<"%V is $type \n"
 }

 CMF Tell()
 {
 <<"Activity TELL \n"
  <<"%V $type \n"
 }

 CMF Activity() 
 {
   <<"cons of Act $_cobj\n" 
   type = RUN
 }

}


<<" Making our nested Class Dil \n"

wdil = 0

class Dil {

public:

 int n_actv;
 str w_day;

 int I[10];

 Activity A[3] ;
 
 CMF Print(wa) 
 {
   <<" %V $w_day \n"
   <<" %V $n_actv \n"
   <<" dotell\n"

   A[wa]->Tell()

   <<" doget\n"
   
   mwt = A[wa]->Get()

   <<"%V $mwt \n"


 }

 CMF Set(wa,wt) 
 {

 <<" Dil set $wt\n"

//   A->Set(wt)
     A[wa]->type = wt
     x = wa]A->type
 <<"%V $x \n"

 }

 CMF showI()
  {

    ma = memaddr(&I[0])

 <<"%V %u $ma \n"

    mad = memaddr(&C[0])
    mas = memaddr(&I[0])

 <<"%V %u $mad $mas \n"
    // memcpy(mad, mas, 40)
    

    for (j =0; j < 10; j++) {
      y = I[j]
      <<"$j $y\n"
    }

  }

 CMF Dil() 
 {
   n_actv = 12
   w_day = date()
  // <<"cons of Day $_cobj $w_day $wdil\n"
 <<"cons of Day $_cobj $w_day \n"
//   wdil++
 }

}

<<" nested class\n"
Dil E
<<" after nested class\n"


  E->A[1]->type = 80

  yt = E->A[1]->type 

<<"%V $yt \n"


stop!

<<" nested class\n"
xov = 20
  Dil D[2]
<<"FIRST $(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"
<<"$(xov--) \n"


  D[0]->A[1]->type = WTLIFT
  wt = D[0]->A[1]->type
<<"%V $wt \n"




  D[2]->A[1]->type = HIKE
  wt = D[2]->A[1]->type
<<"%V $wt \n"











//////////// TBD /////////////////
// base cons ---
// when does sub-class cons get called
// array with class - not being filled correct
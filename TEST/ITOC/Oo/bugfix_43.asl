//   check array of objects within a class
//   each object should call constructor
//   should be able to reach member variables
//   D->A[i]->x

#define WALK 1
#define HIKE 2
#define RUN 3
#define BIKE 4
#define SWIM 5
#define TRDMILL 6
#define WTLIFT  7

char C[256]

AC =0

class Activity {

 public:
 int id;
 int type;
 uint duration;  //  secs
 float distance;  // Km 
 float speed;
 int intensity;

 CMF Get()
 {
 <<"Activity get %V $_cobj $id is $type \n"

  return type

 }

 CMF Set(wt)
 {
  <<"Setting Activity of id $id $_cobj %V to $wt $type \n"
  type = wt
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
   id = AC++
   <<"cons of Act $_cobj $(Offsetof(_cobj)) $id\n" 
   type = RUN
 }

}


Activity a

<<" Activity functions: \n"

   st = a->Get()

<<"%V $st \n"

   a->Set(HIKE)

   st = a->Get()

<<"%V $st \n"

   a->Tell()

   a->type = BIKE

   st = a->Get()

<<"%V $st \n"
<<"%V $a->type \n"

//<<"$(nsc(20,'/|\'))\n"


Activity X[5]


 X[1]->Set(1)
 X[2]->Set(1)


 st = X[1]->Get()

 <<"%V $st \n"

 X[2]->Set(4)

 st = X[2]->Get()

 <<"%V $st \n"



 <<" Making our nested Class Dil \n"


class Dil {

public:

 int n_actv;
 int I[10];
 Activity A[5] ;

 str w_day;
 
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
   <<"cons of $_cobj Day $w_day\n"
 }


}


<<" nested class\n"

  Dil D



  <<" done cons of D \n"

  <<" nested class reference \n"
//  D->A[0]->Set(HIKE)

stop!


  //D->A[1]->Set(HIKE)


  <<" onwards! \n"


stop!


<<" set day 0 act 1 to HIKE \n"

  D->A[1]->Get()


<<" got act 1 of  day 1  \n"




stop!



//  check array assignment within object
CheckIn(0)

setdebug(1)

class Dil {

public:

 int n_actv;
 int I[30];
 int id;

 CMF Print(wa) 
 {
   k = I[wa]
   <<"$wa $k \n"
 }


 CMF Set( wi, val)
 {
      I[wi] = val
 }

 CMF showI()
  {

    //mas = memaddr(&I[0])

 <<"%V$_cobj \n"

// <<"memcpy to %u $mad from $mas #bytes $nbytes\n"
//   memcpy(mad, mas, nbytes)

// <<"%V $I \n" 
  }

 CMF Dil() 
 {
 <<"Starting cons \n"

     I[0:9] = 0

//<<"%V$I \n"
     id = OC++

     <<"cons for $_cobj  $id \n"

     I[0] = SC++
     k = I[0]

<<"%V$k \n"

     I[1] = 28

 <<"%V$I \n" 

     k = I[0]

<<"%V$k \n"
 <<"Done cons \n"
 }

}
//------------------------------------------------

nbytes = 10 * 4

<<"%V$nbytes \n"

uint OC = 1  // object counter

<<"%V$OC\n"

uint SC = 50

char C[1024]

C[0] = 1


Dil D

<<" done dec of D\n"

//CheckNum(D->I[0],50)
//<<" $C[0:10]\n"

Dil E

//CheckNum(E->I[0],51)
 <<" $C[0:10]\n"

<<" after cons\n"
  D->Set(5,32)
<<" after set\n"

  D->Print(5)
   k = D->I[5]
<<" trying D->I[5] = 32 $k\n"
 
   D->I[5] = 33
   k = D->I[5]

<<" after set D->I[5] = 33 $k\n"

  D->I[9] = 78
  E->I[9] = 93
  E->I[8] = 79
  vi = E->I[8]
<<"%V$vi = 79? \n"

<<" %V$E->I[9] \n"


 CheckNum(E->I[9],93)



  D->Set(8,47)

<<" show D \n"

  D->showI()

  D->I[2] =79

  E->showI()

  D->showI()

  D->I[4] =80

  D->showI()

  E->I[2] = 16

  E->showI()

  CheckNum(D->I[8],47)

CheckOut()

stop()


;




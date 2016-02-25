


class Dil {

public:

 int n_actv;
 int I[10];
 int id;
 CMF Print(wa) 
 {

   k = I[a]
   <<"$wa $k \n"
 }


 CMF showI()
  {
    mas = memaddr(&I[0])
 <<"%V $_cobj %u $mas\n"

 <<"memcpy to %u $mad from $mas #bytes $nbytes\n"

   memcpy(mad, mas, nbytes)

 <<"%V $I \n" 
 <<"%(8,, ,\n) $C[0:39]\n"

  }

 CMF Dil() 
 {
     I[0:9] = 0
     mas = memaddr(&I[0])

     id = OC++
     <<"cons for $_cobj  $id %u $mas \n"

     I[0] = SC++
     k = I[0]
<<"%v $k \n"
     I[1] = 28
 <<"%V $I \n" 
     k = I[0]
<<"%v $k \n"
//     memcpy(mad, mas, 32)
 }


}


nbytes = 10 * 4

uint OC = 1  // object counter

uint SC = 50

char C[1024]

C[0] = 1

    mad = memaddr(&C[0])

<<"C addr %u $mad \n"

Dil D

 //<<" $C[0:10]\n"

Dil E

 <<" $C[0:10]\n"

<<" after cons\n"
  D->I[5] = 32
  D->I[9] = 78
  E->I[9] = 93

  C[0] = 1

<<" show D \n"

  D->showI()

  D->I[2] =79

  E->showI()

  D->showI()

  D->I[4] =80

  D->showI()

  E->I[2] = 16

  E->showI()




stop()


;




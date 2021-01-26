//%*********************************************** 
//*  @script class_array.asl 
//* 
//*  @comment check array assignment within object 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                             
//*  @date Fri May 22 16:46:03 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
#include "debug"
debugON()



chkIn (_dblevel); 


uint OC = 1;  // object counter

class Dil {

public:

 int n_actv;
 int IV[30];
 int id;

 cmf Print(int wa) 
 {
   k = IV[wa]
   <<"$wa $k \n"
 }


 cmf Set(int wi, int val)
 {
    <<"%V $wi $val\n"
   <<"$IV[::] \n"
      IV[wi] = val;
   <<"$IV[::] \n" 
 }

 cmf showIV()
  {
//mas = memaddr(&I[0])

 <<"%V$_cobj \n"

// <<"memcpy to %u $mad from $mas #bytes $nbytes\n"
//   memcpy(mad, mas, nbytes)
 <<"%V $IV[::] \n" 
  }

 cmf Dil() 
 {
 <<"Starting cons \n"
     id = OC;

     OC++;


     IV[0:9] = 1;

//<<"%V$I \n"
     <<"cons for $_cobj  $id \n"

     IV[23] = SC++ ;

     k = IV[0];

<<"%V$k \n"

     IV[1] = 28;

 <<"%V$I \n" 

     k = IV[0];

<<"%V$k \n"
 <<"Done cons \n"
 }

}
//------------------------------------------------

nbytes = 10 * 4

<<"%V$nbytes \n"



<<"%V$OC\n"

uint SC = 50;

char C[1024];

C[0] = 1;
 <<" $C[0:10]\n"

Dil E;

   E->showIV();




Dil D;

<<" after cons\n"
  D->showIV();



  D->Set(5,32)
  
<<" after set\n"
  D->showIV();

<<" done dec of D\n"



  D->Print(5);

  D->showIV()

  k = D->IV[5];
   
<<" trying %V $k $D->IV[5]  \n"

  E->showIV();
  D->showIV()



   D->IV[5] = 33;

   D->IV[6] = 1634;
   
   k = D->IV[5]

<<" after set D->IV[5] = 33 $k\n"

  D->IV[9] = 78;

<<"%V $D->IV[9]  78? \n"
  D->showIV()
  
  E->IV[9] = 93;

<<"%V $E->IV[9]  93? \n"

  E->IV[8] = 79

<<"%V $E->IV[8]  79? \n"

  vi = E->IV[8];


<<"%V $vi = 79? \n"
<<"%V $E->IV[9] \n"


 chkN (E->IV[9],93);


  D->Set(8,47)

<<" show D \n"




  D->IV[2] =79;


  D->showIV()

chkN (D->IV[2],79);



  E->showIV()

  D->showIV()

  D->IV[4] =80;

  D->showIV()

  E->IV[2] = 16

  E->showIV()

  D->Set(8,47)

  D->showIV()

  chkN (D->IV[8],47)

  val = D->IV[8]

<<"%V $val\n"


chkOut ()






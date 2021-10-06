//%*********************************************** 
//*  @script arrayele.asl 
//* 
//*  @comment test array vec and ele use 
//*  @release CARBON 
//*  @vers 1.40 Zr Zirconium [asl 6.2.95 C-He-Am] 
//*  @date Sat Dec 19 10:28:02 2020
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn (_dblevel);



float array_asg (float rl[])
{

<<"In $_proc   $rl\n";
  rl->info(1)


  int kp = 3;
  int kp2 = 5;

  kp->info(1)

    rl[1] = 28;
    
    val = rl[1];

    val->info(1)
    
<<"$val \n"

<<"$rl[1] \n"


    rl[kp] = 67;

     val = rl[kp];

    val->info(1)
    
<<"$val \n"

<<"$rl[kp] \n"

    rl[kp2] = 14

<<"$rl[kp2] \n";


<<"%V $rl\n"

   chkR (rl[3],67)

   t3 = rl[8]

   return t3;
}
//======================================//



Real1 = vgen (FLOAT_, 10, 0, 1);

Real1->info(1);

<<"%V$Real1\n";



val = array_asg (Real1);

chkR(Real1[1],28)
chkR(Real1[3],67)

<<"%V $val\n"

<<"%V$Real1\n"

chkOut ();



Real2 = vgen (FLOAT_, 10, 1, 1);

<<"%V$Real2\n";

val = array_asg (Real2);

<<"%V $val\n"

<<"%V$Real2\n"

chkOut ();



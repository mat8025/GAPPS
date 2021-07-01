

float vec_sum (float rl[])
{

<<"In $_proc   $rl\n";
  rl->info(1)
   t4 = rl[2] + rl[1] + rl[4];
   <<"%V $t4\n"
   t3 = 61;
<<"%V $t3\n"
t3->info(1);
  // return (10 *t3);
   return (t3);

}
//======================================//


Rvec = vgen(FLOAT_,10,0,0.5)

<<"%V$Rvec \n"


 rs= vec_sum(Rvec);

<<"%V $rs \n"

exit()
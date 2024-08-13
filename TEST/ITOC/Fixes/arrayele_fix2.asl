

chkIn (_dblevel);

call_sf = 1;
call_vmf = 1;
<<"%V $call_sf $call_vmf \n"

void goo(double val)
{
<<"$_proc nothing much to see $val\n"
//  val->info(1)
 if (call_sf) {
   x=sin(val)
   <<"$x is sin of $val\n"
   }
 if (call_vmf) {  
   x->info(1)
   }
}

//======================================//

double pscalar (double sd)
{
 <<"$_proc  scale arg  $sd\n";

  // sd->info(1)
 //  vid = sd->vid()
 //  <<"%V$vid\n"
   sd += 1;
   iv = sd
   iv += 1;
   goo(iv)

<<"%V $iv \n"
   return sd;
}

//======================================//

float p_vec (float rl[])

{

  <<"$_proc  array arg $rl\n";
  rl.pinfo()
  
  float t1;
  float t2;


  int j = 4

  //<<"%V$rl \n";

  t1 = rl[0];
  rl.pinfo() // TBC

  t2 = rl[1];
  t3 = rl[2];
  t4 = rl[j];


<<"%V $t1 $t2 $t3\n"
<<"%V $t4\n"

<<"$rl \n"

  rl.pinfo() // TBC
  int j1 = 4;
  int j2 = 6;
  
  t7 = rl[j1] - rl[j2];

<<"%V $t7\n"
 chkR (t7, -2);


<<"%V $rl[j1]\n"



  kp = 3;

<<"%V $rl[j1]    $rl[j2] \n"

  rl[kp] = rl[j1] - rl[j2];

<<"%V $kp $rl[kp] \n"

   return t3;
}
//======================================//


fv = vgen(FLOAT_,10,0,1)


<<"$fv \n"

 double d= 1.234

  xm = sin(d)

<<"$xm is sin of $d\n"



 pscalar(d)



 double e= 3.234

 pscalar(e)




 fv->info()

 <<"%V $fv[1] \n"


 p_vec(fv)

<<"after pvec\n"


fv[0] = -32;
 fv[2] = 77;
 fv[3] = 80;

<<"$fv \n"

 f=p_vec(fv)

 <<"$f\n"

  chkOut ();

/////////

<<"first line \n"

Proc goo(double val)
{
<<"$_proc nothing much to see $val\n"
  val->info(1)
}

//======================================//

Proc pscalar ( double sd)
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

Proc p_vec (double rl[] )

{

  <<"$_proc  array arg $rl\n";

  float t1;
  float t2;


  int j = 4
  t1= rl[0];
  t2= rl[1];
  t3 = rl[2];
  t4 = rl[j];


<<"%V $t1 $t2 $t3\n"
<<"%V $t4\n"

<<"$rl \n"

    //rl->info(1) // TBC

   return t3;
}
//======================================//


fv = vgen(FLOAT_,10,0,1)


<<"$fv \n"

 double d= 1.234

 pscalar(d)



 double e= 3.234

 pscalar(e)




 fv->info()

 p_vec(fv)

<<"after pvec\n"


fv[0] = -32;
 fv[2] = 77;
 fv[3] = 80;

<<"$fv \n"

 f=p_vec(fv)

 <<"$f\n"

  
///
///
///

setdebug(1,@keep,@trace,@filter,0);

LD_libs = 0;


//=======================//
proc zoo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return k;
}
//=======================//


include "iproc_libs.asl"

<<"%V $LD_libs\n"

cbname = "zoo"

<<"indirect call of $cbname\n"
  frs=$cbname(4);  
  <<"%V $(typeof(frs))  $frs\n"





   fri = zoo(80);

<<"%V $(typeof(fri))  $fri\n"

  frs="xx";

<<"%V $(typeof(frs))  $frs\n"

  frs= zoo(2);

<<"%V $(typeof(frs))  $frs\n"



N = 6;
kp= 0;

  while (1) {

       cbname = iread("what to call?:")
<<"indirect call of $cbname\n"
       $cbname(kp);
<<"done indirect call of $cbname\n"
kp++;
  if (kp > N) {
   <<" exito? loop $kp > $N - segamos adelante!\n"
    break;
  }
  }


exit()

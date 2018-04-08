///
///
///

setdebug(1,@keep,@trace,@filter,0);
just_once = 0;
LD_libs = 0;
//=======================//
proc goo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 3) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
<<"OUT $_proc $k $znt $m\n"  
  //return k;
  //return;
}
//=======================//
just_once++ ;
<<"after  define goo() $just_once but not after Call\n"

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
checkIN()

include "iproc_libs.asl"

<<"%V $LD_libs\n"

   goo(80);

<<" after direct call of goo \n"


// = iread("?")

cbname = "goo"

<<"indirect call of $cbname\n"
  $cbname(5);  
  <<"after indirect call of $cbname\n"

  frs="xx";



cbname = "zoo"

<<"indirect call of $cbname\n"
  frs=$cbname(4);  
  <<"%V $(typeof(frs))  $frs\n"
<<"@exit %V $just_once should be 1\n"

checkNum(just_once,1)
checkStr(frs,"5")

checkOut()

exit()

   fri = zoo(80);

<<"%V $(typeof(fri))  $fri\n"



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

///
///
///

 ci (_dblevel)
 
just_once = 0;
LD_libs = 0;
//=======================//
proc goo(int m)
{
static int znt = 0;
znt++;
<<"IN goo $_proc $znt $m\n"


if (znt > 3) {
  <<" repeat call $znt \n"
  //exit();
}
  k = m+ znt;
<<"OUT $_proc $k $znt $m\n"  
  //return k;
  //return;
  return "$_proc"
}
//=======================//
just_once++ ;
<<"after  define goo() $just_once but not after Call\n"

//=======================//
proc zoo(int m)
{
static int znt = 0;
znt++;
<<"IN zoo $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return "zoo"
}
//=======================//

proc hoo(int m)
{
static int znt = 0;
znt++;
<<"IN hoo $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return "hoo"
}
//=======================//

proc boo()
{
static int znt = 0;
znt++;
<<"IN  $_proc $znt\n"

  return "boo"
}
//=======================//

proc coo()
{
static int znt = 0;
znt++;
<<"IN  $_proc $znt\n"

  return "$_proc"
}
//=======================//

proc moo()
{
static int znt = 0;
znt++;
<<"IN moo $_proc $znt\n"

  return "$_proc"
}
//=======================//


proc roo()
{
static int znt = 0;
znt++;
<<"IN $_proc $znt\n"

  return "$_proc"
}
//=======================//



//include "iproc_libs.asl"



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

cn (just_once,1)
cs (frs,"5")





   fri = zoo(80);

<<"%V $(typeof(fri))  $fri\n"



<<"%V $(typeof(frs))  $frs\n"

  frs= zoo(2);

<<"%V $(typeof(frs))  $frs\n"



N = 6;
kp= 0;

svar pnames = {"boo","coo","moo","roo" }

for (i=0; i< 4; i++) {
       cbname = pnames[i]
<<"trying indirect call of $cbname\n"
       wp= $cbname();
<<"$kp done indirect call of $wp \n"

}








svar pnames2 = {"goo","hoo","zoo","goo" }

for (i=0; i< 4; i++) {
       cbname = pnames2[i]
<<"trying indirect call of $cbname\n"
       wp= $cbname(kp);
<<"$kp done indirect call of $wp \n"
      kp++;

}


exit()

  while (1) {

       cbname = iread("what to call?:")
<<"trying indirect call of $cbname\n"
       wp= $cbname(kp);
<<"$kp done indirect call of $wp \n"
  kp++;
  if (kp > N) {
   <<" exito? loop $kp > $N - segamos adelante!\n"
    break;
  }
  
  }


exit()

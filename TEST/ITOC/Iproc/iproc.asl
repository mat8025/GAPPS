/* 
 *  @script iproc.asl                                                   
 * 
 *  @comment test indirect call pr proc ()                              
 *  @release Beryllium                                                  
 *  @vers 1.3 Li Lithium [asl 6.4.51 C-Be-Sb]                           
 *  @date 07/26/2022 20:33:43                                           
 *  @cdate 1/1/2011                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

///
///
///

#include "debug"


if (_dblevel >0) {
   debugON()
}


 chkIn (_dblevel)
 
just_once = 0;
LD_libs = 0;
//=======================//
int goo_call = 0;
Str goo(int m)
{
static int znt = 0;
znt++;
<<"IN goo $_proc $znt $m\n"

 goo_call++;
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

int zoo_call = 0;
Str zoo(int m)
{
static int znt = 0;
znt++;
<<"IN zoo $_proc $znt $m\n"

  zoo_call++;

if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return "zoo"
}
//=======================//
int hoo_call = 0;
Str hoo(int m)
{
static int znt = 0;
znt++;
<<"IN hoo $_proc $znt $m\n"

hoo_call++;
if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return "hoo"
}
//=======================//

int moo_call = 0;
Str moo(int m)
{
static int znt = 0;
znt++;
<<"IN moo $_proc $znt\n"
moo_call++;
  return "$_proc"
}
//=======================//

int roo_call = 0;
Str roo(int m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt\n"
roo_call++;
  return "$_proc"
}
//=======================//



//include "iproc_libs.asl"



   goo(80);

<<" after direct call of goo $goo_call\n"


// = iread("?")

cbname = "goo"

<<"indirect call of $cbname\n"
  $cbname(5);  
  <<"after indirect call of $cbname  %v $goo_call\n"

  frs="xx";

chkN(goo_call,2)






cbname = "zoo"

<<"indirect call of $cbname\n"
  frs=$cbname(4);  
  <<"%V $(typeof(frs))  $frs\n"
<<"@exit %V $just_once should be 1\n"

chkN(zoo_call,1)

chkN (just_once,1)






   fri = zoo(80);

<<"%V $(typeof(fri))  $fri\n"



<<"%V $(typeof(frs))  $frs\n"

  frs= zoo(2);

<<"%V $(typeof(frs))  $frs\n"



N = 6;
kp= 0;

Svar pnames = {"goo","zoo","moo","roo" }

<<"%V $pnames \n"

<<"%V $pnames[1] \n"




for (i=0; i< 4; i++) {
       cbname = pnames[i]
<<"trying indirect call of $cbname\n"
       wp= $cbname(i);
<<"$kp done indirect call of $wp %V $goo_call $zoo_call $moo_call\n"

}







kp= 0;
svar pnames2 = {"goo","hoo","zoo","moo" }

for (i=0; i< 4; i++) {
       cbname = pnames2[i]
<<"trying indirect call of $cbname\n"
       wp= $cbname(kp);
<<"$kp done indirect call of $wp %V $goo_call $zoo_call $moo_call\n"
      kp++;

}


y = sin(0.7)


 fname="_sin" ; // use _name to have asl lookup name as SFunction
                        // no leading _   then asl  will look up Proc
			

z=$fname(0.7)

<<"%V $y $z\n"

chkR(z,y)

chkOut();

exit();




  while (1) {

       cbname = iread("what to call?:")
<<"trying indirect call of $cbname\n"
       wp= $cbname(kp);
<<"$kp done indirect call of $wp \n"
  kp++;
  if (kp > N) {
   <<" exit ? loop $kp > $N - segamos adelante!\n"
    break;
  }
  
  }


exit()

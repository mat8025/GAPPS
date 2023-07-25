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
//----------------<v_&_v>-------------------------//;                  

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

<<"IN zoo $_proc  $m\n"
<<"$znt \n"
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

float rf = 3.45;


  frs="xx";


<<"%V $frs  $rf\n" ;   

 chkN(rf,3.45)

 rf = sin(0.7) ; // fix broke direct func call ?
 
 chkN(rf,sin(0.7))
<<"%V $frs  $rf\n" ;   // 

tof = typeof(rf)

<<" %V $tof\n"

<<"$(typeof(rf)) \n" ;   // fix broke indirect func call

<<"%V $(typeof(frs))  $frs\n" ;   // fix broke indirect func call








   zoo(80);

<<" after direct call of zoo $zoo_call\n"


// = iread("?")

cbname = "goo"

<<"indirect call of $cbname\n"




frs = $cbname(5);  

<<"after indirect call of $cbname  %V $goo_call $frs\n"



chkN(goo_call,1)








  cbname = "zoo"

<<"indirect call of $cbname\n"
  frs =  $cbname(4);
  
<<"%V $(typeof(frs))  $frs\n" ;   // fix broke indirect func call




<<"@exit %V $just_once should be 1\n"

chkN(zoo_call,2)

chkN (just_once,1)






   fri = zoo(80);

//<<"%V $(typeof(fri))  $fri\n"



//<<"%V $(typeof(frs))  $frs\n"

  frs= zoo(2);

//<<"%V $(typeof(frs))  $frs\n"

Str wp = "xyz"

N = 6;
kp= 0;

kp= 7;

for (i=0; i< 3; i++) {

<<"$i before DIRECT call of zoo $zoo_call\n"
      wp= zoo(kp);
      kp++;

<<"$kp after DIRECT call of $wp  zoo $zoo_call\n"

}


Svar pnames = {"moo","zoo","roo","goo", "" }

<<"%V $pnames \n"

<<"%V $pnames[1] \n"

<<"trying asl callproc zoo 7\n"

    wp =  runproc("zoo",7)
<<"done asl callproc zoo  $wp  $zoo_call\n"

    wp =  runproc("moo",kp)
<<"done asl callproc moo  $wp  $moo_call\n"

ans=query("called moo?");


for (i=0; i< 3; i++) {

   wp =  runproc("roo",kp)
<<"done asl callproc roo  $wp  $roo_call\n"
   ans=query("called roo?");
}

<<" test that WIC is now on again \n"

for (i=0; i< 4; i++) {
   kp++;
<<" %V $i $kp\n"
}

 wp =  runproc("hoo",kp)

 wp =  runproc("goo",kp)
chkOut()

exit(-1)



for (i=0; i< 4; i++) {
       cbname = pnames[i]
<<"trying indirect call of $cbname  $i\n"
       wp= $cbname(i);
<<"$kp done indirect call of $wp %V $goo_call $zoo_call $moo_call\n"

}







svar pnames2 = {"moo","hoo","zoo","goo" }

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

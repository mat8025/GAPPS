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
/*
#include "debug"

if (_dblevel >0) {
   debugON()
}

*/
chkIn (_dblevel);


<<"%V $_dblevel\n"

//*/


float f= 3.142;

f->info(1)


<<"$f \n"

int p = 1234567;

p->info(1)



Str sv ="buen dia"

asv = sv;



sv->info(1);
asv->info(1);

Real1 = vgen (FLOAT_, 10, 0, 1);

Real1->info(1);

<<"%V$Real1\n";



//exit()


float array_asg (float rl[])
{

<<"In $_proc   $rl\n";
  rl->info(1)
  int kp = 3;
  int kp2 = 5;

kp->info(1)


//ans=query()

    rl[1] = 77;

    rl[kp] = 67
    rl[kp2] = 14

<<"%V $rl\n"

   chkR (rl[3],67)

   t3 = rl[8]

   return t3;
   

}
//======================================//

int SA =0;

float array_sub (float rl[])
{

<<"In $_proc   $rl\n";
  rl->info(1)

 //SA = SA + 1;
 SA++;
  
  float t1;
  float t2;
   
//  <<"%V$rl \n";

  t1 = rl[2];
  t1->info(1)

//ans=query();
  rl->info(1)
//  <<"%6.2f%V$t1\n";

//<<"%6.2f$rl \n"

  t1 = rl[4];

//  <<"%6.2f%V$t1\n";


  <<"$(Caz(t1))\n";
  rl->info(1)
//  chkR (t1, 4.0);

//query()

  int k = 5;
  t2 = rl[k];
  <<"%V$t2\n";
  <<"$(Caz(t2))\n";

  

  j1 = 4;
  j2 = 6;

  t3 = rl[j1] - rl[j2];

  <<"%V %6.2f $t3  \n";
  <<"$(Caz(t3))\n";

  chkR (t3, -2);

//<<"$rl[j1]\n";

  t4 = rl[j1 + 1];

  <<"%V $t4  \n";

  <<"$(Caz(t4))\n";

 // chkR (t4, 5);

  <<"%V $k $j1 $j2 \n";
//<<"%6.2f$rl \n";

  kp = 3;

<<"%V $rl[j1]    $rl[j2] \n"
//query()

<<"rl $rl \n"

    rj1 = rl[j1];
    
    rj1->info(1);

<<"%V $SA\n"

//ans=query();

<<"%V $rj1\n"    


    rj2 = rl[j2];

   rj2->info(1);
   
<<"%V $rj2\n"    

  wrl = rj1 -rj2

 <<"%V $wrl\n"

wrl->info(1);
  chkR (wrl, -2);

  rl[kp] = rl[j1] - rl[j2];

<<"%V $kp  $j1 $j2 \n";
<<"%V $rl[kp] $rl[j1]  $rl[j2] \n"
  
<<"rl $rl \n"

//<<"%6.2f$rl \n";
//  <<"%V $rl[kp] \n";

  wrl = rl[kp];
<<"%V $wrl\n"
  chkR (wrl, -2);

  rl[0] = 47;

  <<"%V $rl \n";

  <<"%V $wrl \n";
  <<"%V $kp $rl[kp] \n";

   jj = rl[kp];

   <<"%V $jj $kp $rl[kp] \n";

  <<"%V $rl \n";

  chkR (jj, -2);


  
//  query()
/{/*  
  ff= rl[kp];
  //<<"$rl \n"
  <<"%V $ff $jj $rl[kp] \n"
  
  chkR (rl[kp], -2.0);

  rl->info(1)



  <<"just rl[k] :: $rl[kp] \n";

 // <<"%6.2f$rl \n";

  t2 = rl[kp];

  <<"%V$t2\n";
  <<"$(Caz(t2))\n";

  chkR (t2, -2);
  
//<<"$rl[0:3]\n"     ;

  rf1= rl[j1];
   rl->info(1)
  rf2= rl[j2];  
  
<<"%V $j1 $j2 $rf1 $rf2\n" 
  rl->info(1)
  TA=testargs(rl[j1],rl[j2],rf1,rf2)

<<"%(1,,,\n)$TA\n";

  rl[j1] = rl[j1] - rl[j2];

  rf1= rl[j1];
  rf2= rl[j2];  
  
<<"%V $j1 $j2 $rf1 $rf2\n" 



//<<"%V $rl[j1] = $rl[j1] - $rl[j2] \n";

  rl->info(1)
  TA=testargs(rl[j1],rl[j2],rf1,rf2)

<<"%(1,,,\n)$TA\n";
  
  chkR (rl[j1], -2);

  ff= rl[j1];
<<" $ff   \n"
<<" $rl[j1]  -2 \n"


//<<"$rl\n"   // FIX does not parse rl here why?

  chkR (rl[4], -2);

  <<"rl vec $rl[0:-1]\n";

  chkR (rl[5], 5);

  t6 = rl[5];

  chkR (t6, 5);

  <<"%V$t6\n";
  <<"$(Caz(t6))\n";

//<<"$rl\n";
/}*/
  return t3;
}

//////////////////////////////////////////////////////////////////////////////////////




chkR (Real1[2],2)



Real2 = vgen (FLOAT_, 10, 1, 1);

<<"%V$Real2\n";

val = array_asg (Real1);
<<"%V $val\n"
//ans= query()
<<"%V$Real1\n"



val = array_asg (Real2);
//ans= query()

<<"%V $val\n"

<<"%V$Real2\n"




val = array_sub (Real2);
//ans= query()






float mt1;

mt1 = Real1[4];
chkR (mt1, 4);
<<"%V $mt1 \n";

Real1[0] = 74.47;

<<"%V$Real1\n";

val = array_sub (Real1);

chkStage()




val = array_sub (Real2);



////////////////////

//double Real[10];

Real = vgen (DOUBLE_,10, 0, 1);

<<"Real %6.2f $Real \n";

Real->info(1);



val = array_sub (Real);




val = Real[3];

<<"%V$val \n";
chkR (val, -2);
k = 4;

val = Real[k];

<<"%V$val \n";

chkR (val, 4);


sz = Csz (Real);

<<" done Caz %V$sz\n";

double t1 = 4;

sz = Csz (&t1);

<<" done Caz %V$sz\n";


<<"%V$t1  $(typeof(t1))\n";



<<"$(Caz(t1))\n";


<<" done Caz !\n";

t1 = Real[4] ;

<<"%V $t1  $(typeof(t1))\n";



<<"$(Caz(t1))\n";


<<" done Caz !\n";

chkR (t1, 4);

double t2;

k = 5;
t2 = Real[k];

<<"%V$t2\n";
<<"$(Caz(t2))\n";

chkR (t2, 5);

j1 = 4;
j2 = 6;

t3 = Real[j1] - Real[j2];

<<"%V $t3  \n";

<<"$(Caz(t3))\n";

chkR (t3, -2);

<<"$Real[j1]\n";

t4 = Real[j1 + 1];

<<"%V $t4  \n";

<<"$(Caz(t4))\n";

chkR (t4, 5);

<<"$Real \n";

Real[k] = Real[j1] - Real[j2];

chkR (Real[k], -2);

<<"ele[${k}] $Real[k] \n";

<<"$Real \n";

t2 = Real[k];

<<"%V$t2\n";
<<"$(Caz(t2))\n";

chkR (t2, -2);

<<"$Real[0:3]\n";

Real[j1] = Real[j1] - Real[j2];

<<"$Real\n";

<<"just Real[j1] $Real[j1]\n";

chkR (Real[j1], -2);

chkR (Real[4], -2);



////// Now inside proc -- with proc stack variables  //////////////////////////////

Real2 = fgen (10, 0, 1);
<<"%V$Real\n";

val = array_sub (Real2);

<<"$val \n";

N=10


proc Foo(float rl[])
{
 int j1;
   j1 =2;
   float rxp;
<<"%V$rxp  $(typeof(rxp)) %i$rxp \n"

     rxp = rl[j1];
  <<" %V$j1 $rxp  $(cab(rxp))\n"
     rxp2 = rl[j1+1];
  <<" %V$j1 $rxp2  $(cab(rxp2))\n"
     j1 = 1;
   for (i = j1; i < N ; i++) {
     rxp = rl[j1];
  <<" %V$j1 $rxp  $(cab(rxp))\n"
     j1++;
   }

}
//----------------------------

proc fooey(float rl[])
{

<<"%I$rl   $(Caz(rl))\n"

     rxp = rl[1]
<<"$rxp\n"
 chkR (rxp,11)
<<"%I$rl   $(Caz(rl))\n"
    j1 = 1
     rxp = rl[j1]
<<"$rxp\n"
<<"$rl\n"
<<"%I$rl   $(Caz(rl))\n"

    j2 = 2
     rl[j2] = rl[j1]
<<"%I$rl   $(Caz(rl))\n"
<<"$rl\n"
    j3 = 3
     rl[j1] = rl[j1] + rl[j2]
//<<"%I$rl \n"
vsz = Caz(rl)
<<"%V$vsz\n"
<<"$rl\n"

<<"%I$rl   $(Caz(rl))\n"
<<"$rl\n"

}

  Re = fgen(10,10,1)
<<"%i $Re\n"
<<"$Re\n"
   j =2;
   rxm = Re[j];
<<" %V$j $rxm  %i$rxm\n"

   rxm = Re[j+1];
<<" %V$j $rxm  %i$rxm\n"


    Foo(Re)

    fooey(Re)

sz = Caz(Re)

<<"%V$sz\n"
chkN (sz,10)

chkOut ();



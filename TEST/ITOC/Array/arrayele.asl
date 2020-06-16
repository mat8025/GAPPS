//%*********************************************** 
//*  @script arrayele.asl 
//* 
//*  @comment test array vec and ele use 
//*  @release CARBON 
//*  @vers 1.38 Sr Strontium [asl 6.2.58 C-He-Ce]                          
//*  @date Sun Jun 14 12:41:42 2020 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

ci (_dblevel);

<<"%V $_dblevel\n"
//cd query()

float f= 3.142;

<<"$f \n"

proc array_asg (float rl[])
{

<<"In $_proc   $rl\n";
  rl->info(1)
  int kp = 3;
  int kp2 = 5;
  rl[1] = 77;

    rl[kp] = 67
    rl[kp2] = 14

<<"%V $rl\n"

   cr (rl[3],67)

   t3 = rl[8]

   return t3;
   

}
//======================================//


proc array_sub (float rl[])
{

<<"In $_proc   $rl\n";
  rl->info(1)
 
  float t1;
  float t2;
   
//  <<"%V$rl \n";

  t1 = rl[0];
  rl->info(1)
//  <<"%6.2f%V$t1\n";

//<<"%6.2f$rl \n"

  t1 = rl[4];

//  <<"%6.2f%V$t1\n";


  <<"$(Caz(t1))\n";
  rl->info(1)
//  cr (t1, 4.0);

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

  cr (t3, -2);

//<<"$rl[j1]\n";

  t4 = rl[j1 + 1];

  <<"%V $t4  \n";

  <<"$(Caz(t4))\n";

 // cr (t4, 5);

  <<"%V $k $j1 $j2 \n";
//<<"%6.2f$rl \n";

  kp = 3;

<<"%V $rl[j1]    $rl[j2] \n"
//query()

<<"rl $rl \n"

    rj1 = rl[j1];
<<"%V$rj1\n"    


    rj2 = rl[j2];
<<"%V$rj2\n"    

  wrl = rj1 -rj2
<<"%V $wrl\n"
  cr (wrl, -2);

    rl[kp] = rl[j1] - rl[j2];

<<"%V $kp  $j1 $j2 \n";
<<"%V $rl[kp] $rl[j1]  $rl[j2] \n"
  
<<"rl $rl \n"

//<<"%6.2f$rl \n";
//  <<"%V $rl[kp] \n";

  wrl = rl[kp];
<<"%V $wrl\n"
  cr (wrl, -2);

  rl[0] = 47;

  <<"%V $rl \n";

  <<"%V $wrl \n";
  <<"%V $kp $rl[kp] \n";

   jj = rl[kp];

   <<"%V $jj $kp $rl[kp] \n";

  <<"%V $rl \n";

  cr (jj, -2);

//  query()
/{/*  
  ff= rl[kp];
  //<<"$rl \n"
  <<"%V $ff $jj $rl[kp] \n"
  
  cr (rl[kp], -2.0);

  rl->info(1)



  <<"just rl[k] :: $rl[kp] \n";

 // <<"%6.2f$rl \n";

  t2 = rl[kp];

  <<"%V$t2\n";
  <<"$(Caz(t2))\n";

  checkFNum (t2, -2);
  
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
  
  checkFNum (rl[j1], -2);

  ff= rl[j1];
<<" $ff   \n"
<<" $rl[j1]  -2 \n"


//<<"$rl\n"   // FIX does not parse rl here why?

  checkFNum (rl[4], -2);

  <<"rl vec $rl[0:-1]\n";

  cr (rl[5], 5);

  t6 = rl[5];

  checkFNum (t6, 5);

  <<"%V$t6\n";
  <<"$(Caz(t6))\n";

//<<"$rl\n";
/}*/
  return t3;
}

//////////////////////////////////////////////////////////////////////////////////////

Real1 = vgen (FLOAT_, 10, 0, 1);

<<"%V$Real1\n";


cr (Real1[2],2)



Real2 = vgen (FLOAT_, 10, 1, 1);

<<"%V$Real2\n";

val = array_asg (Real1);
<<"%V $val\n"

<<"%V$Real1\n"



val = array_asg (Real2);
<<"%V $val\n"

<<"%V$Real2\n"




val = array_sub (Real2);

float mt1;

mt1 = Real1[4];
cr (mt1, 4);
<<"%V $mt1 \n";

Real1[0] = 74.47;

<<"%V$Real1\n";

val = array_sub (Real1);

checkStage()




val = array_sub (Real2);



////////////////////

//double Real[10];

Real = vgen (DOUBLE_,10, 0, 1);

<<"Real %6.2f $Real \n";

val = array_sub (Real);




val = Real[3];

<<"%V$val \n";
cr (val, -2);
k = 4;

val = Real[k];

<<"%V$val \n";

cr (val, 4);


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

cr (t1, 4);

double t2;

k = 5;
t2 = Real[k];

<<"%V$t2\n";
<<"$(Caz(t2))\n";

cr (t2, 5);

j1 = 4;
j2 = 6;

t3 = Real[j1] - Real[j2];

<<"%V $t3  \n";

<<"$(Caz(t3))\n";

cr (t3, -2);

<<"$Real[j1]\n";

t4 = Real[j1 + 1];

<<"%V $t4  \n";

<<"$(Caz(t4))\n";

cr (t4, 5);

<<"$Real \n";

Real[k] = Real[j1] - Real[j2];

cr (Real[k], -2);

<<"ele[${k}] $Real[k] \n";

<<"$Real \n";

t2 = Real[k];

<<"%V$t2\n";
<<"$(Caz(t2))\n";

cr (t2, -2);

<<"$Real[0:3]\n";

Real[j1] = Real[j1] - Real[j2];

<<"$Real\n";

<<"just Real[j1] $Real[j1]\n";

cr (Real[j1], -2);

cr (Real[4], -2);



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
 cr (rxp,11)
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
cn (sz,10)

co ();



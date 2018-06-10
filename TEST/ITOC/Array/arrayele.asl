



setdebug (1, @pline, @~step, @trace, @soe) ;

checkIn ();



proc array_sub (float rl[])
{

  float t1;
  float t2;

  <<"In $_proc\n";
  <<"$rl \n";


//<<"%6.2f$rl \n"

  t1 = rl[4];

  <<"%6.2f%V$t1\n";


  <<"$(Caz(t1))\n";

  checkFnum (t1, 4.0);


//ans=iread()
  int k = 5;
  t2 = rl[k];
  <<"%V$t2\n";
  <<"$(Caz(t2))\n";

  checknum (t2, 5);

  j1 = 4;
  j2 = 6;

  t3 = rl[j1] - rl[j2];

  <<"%V %6.2f $t3  \n";
  <<"$(Caz(t3))\n";

  checkFnum (t3, -2);

//<<"$rl[j1]\n";

  t4 = rl[j1 + 1];

  <<"%V $t4  \n";

  <<"$(Caz(t4))\n";

  checkFnum (t4, 5);

  <<"%V $k $j1 $j2 \n";
//<<"%6.2f$rl \n";

  kp = 3;

<<"%V $rl[j1]    $rl[j2] \n"

  rl[kp] = rl[j1] - rl[j2];


  <<"%V$rl[kp]\n";

  <<"%V $kp  $j1 $j2 \n";


//<<"%6.2f$rl \n";
  <<"%V $rl[kp] \n";

  wrl = rl[kp];

  rl[0] = 47;

  <<"%V $Real1 \n";
  <<"%V $wrl \n";
  <<"%V $kp $rl[kp] \n";
  jj = rl[kp];
    checkFnum (jj, -2);
   <<"%V $jj $kp $rl[kp] \n";
  checkFnum (rl[kp], -2);

  <<"just rl[k] :: $rl[kp] \n";

  <<"%6.2f$rl \n";

  t2 = rl[kp];

  <<"%V$t2\n";
  <<"$(Caz(t2))\n";

  checkFNum (t2, -2);
  
//<<"$rl[0:3]\n"     ;

  rl[j1] = rl[j1] - rl[j2];


  checkFNum (rl[j1], -2);

//<<"$rl\n"   // FIX does not parse rl here why?

  checkFNum (rl[4], -2);

  <<"rl vec $rl[0:-1]\n";

  checkFnum (rl[5], 5);

  t6 = rl[5];

  checkFNum (t6, 5);

  <<"%V$t6\n";
  <<"$(Caz(t6))\n";

//<<"$rl\n";

  return t3;
}

//////////////////////////////////////////////////////////////////////////////////////


Real1 = vgen (FLOAT_, 10, 0, 1);
<<"%V$Real1\n";

float mt1;

mt1 = Real1[4];
checkFnum (mt1, 4);
<<"%V $mt1 \n";

Real1[0] = 74.47;

val = array_sub (Real1);






////////////////////

double Real[10];

Real = dgen (10, 0, 1);

<<"Real $Real \n";

val = Real[3];

<<"%V$val \n";
checkFNum (val, 3);
k = 4;

val = Real[k];

<<"%V$val \n";

checkFnum (val, 4);



sz = Csz (Real);

<<" done Caz %V$sz\n";



double t1 = 4;




sz = Csz (&t1);

<<" done Caz %V$sz\n";


<<"%V$t1  $(typeof(t1))\n";



<<"$(Caz(t1))\n";


<<" done Caz !\n";

t1 = Real[4] ;

<< "%V$t1  $(typeof(t1))\n";



<<"$(Caz(t1))\n";


<<" done Caz !\n";

checkFnum (t1, 4);

double t2;

k = 5;
t2 = Real[k];

<< "%V$t2\n";
<<"$(Caz(t2))\n";

checkFnum (t2, 5);

j1 = 4;
j2 = 6;

t3 = Real[j1] - Real[j2];

<<"%V $t3  \n";

<<"$(Caz(t3))\n";

checkFnum (t3, -2);

<<"$Real[j1]\n";

t4 = Real[j1 + 1];

<<"%V $t4  \n";

<<"$(Caz(t4))\n";

checkFnum (t4, 5);

<<"$Real \n";

Real[k] = Real[j1] - Real[j2];

checkFnum (Real[k], -2);

<<"ele[${k}] $Real[k] \n";

<<"$Real \n";

t2 = Real[k];

<<"%V$t2\n";
<<"$(Caz(t2))\n";

checkFnum (t2, -2);

<<"$Real[0:3]\n";

Real[j1] = Real[j1] - Real[j2];

<<"$Real\n";

<<"just Real[j1] $Real[j1]\n";

checkFnum (Real[j1], -2);

checkFnum (Real[4], -2);



////// Now inside proc -- with proc stack variables  //////////////////////////////

Real = fgen (10, 0, 1);
<<"%V$Real\n";


val = array_sub (Real);


<<"$val \n";


CheckOut ();

exit ();

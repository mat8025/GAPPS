
// test threads

 SetDebug(0)

mypr = -1;
int N1 = 1000;
int N2 = 2000;
int N3 = 3000;

 
 x = 2
 y = 4

<<"Globals to use %I $x $y \n"

<<" prior to goo def \n"
proc goo()
{
<<" hey I am in $_cproc goo \n"
   gz = x + y
<<" $_proc %v $gz \n"
}

<<" prior to foo1 def \n"

   int Foo1 = 0;


proc foo1()
{
//<<" hey I am in foo1 \n"

int z1 = 0;
int x1 = 1;
int y1 = 1;   

<<" %V foo1 $x1 $y1 \n"

   z1 = x1 + y1

   foo1tid = GthreadGetId()

 // which thread am I
    mypr =gthreadgetpriority(foo1tid);

//  <<" foo1 thread $foo1tid pr $mypr $_proc computed $z = $x + $y \n"

   x1++;
   y1++;

   int j =0;

   for (j = 0 ; j < N1; j++) {

     z1 = x1 + y1;

     //<<"foo1 $j \n"
   if ( (j % 100) == 0) {
    <<" foo1 thread $foo1tid $_proc computed $z1 = $x1 + $y1 \n"
   }
     x1++;

     y1++;

//     Foo1++;
          Foo1 = Foo1 + 1;
    if (Nta > 2) {     
     sleep(0.1)
    }
      //yieldprocess()   
   }
   
<<"foo1 loop end\n"

     <<" DONE foo1 $_proc exiting %V $z1 $foo1tid \n"

      GthreadExit()

     }
//========================================================

int Foo2 = 0;


proc foo2()
{
//<<" hey I am in foo2 \n"
//<<" %V $x $y \n"
int z2 = 0;
int x2 = 1;
int y2 = 1;

<<" %V foo2 $x2 $y2 $z2 \n"

   foo2tid = GthreadGetId()

 // which thread am I
    mypr =gthreadgetpriority(foo2tid);

<<"$foo2tid  pr $mypr \n"

   int j =0

   for (j = 0 ; j < N2; j++) {
   z2 = x2 + y2
     //<<" foo2 thread $foo2tid $_proc computed $z = $x + $y \n"
   y2++
   x2++
   sleep(0.001);

   Foo2++;
// yieldprocess()   
   }

    <<" DONE foo2 $_proc exiting %V $x2 %v $z2 $foo2tid \n"

   //GthreadExit(foo2tid)
     GthreadExit()

<<" should not see this foo2 \n"
     }
//===========================================

int Foo3 =0;

proc foo3( t_arg1, t_arg2, t_arg3)
{
<<" hey I am in foo3 \n"
<<" %V new thread $_proc  my arg is $t_arg1 $t_arg2 $t_arg3\n" 

<<" %V foo3 $x3 $y3 $z3 \n"
   foo3tid = GthreadGetId()

int z3 = 0;
int x3 = 1;
int y3 = 1;

    
 // which thread am I

  int j =0;

   for (j = 0 ; j < N3; j++) {
    z3 = x3 + y3;
//   <<" foo3  thread $foo3tid my arg is < $t_arg1 > < $t_arg2 > < $t_arg3 > $_proc computed $z = $x + $y \n"
      y3++;       x3++;
    Foo3++;
// sleep(0.001)
//sleep(0.01)
     // yieldprocess()   
   }

  total = z3;
  
  <<" DONE $_proc exiting %V $x3 $z3 $foo3tid \n"


   GthreadExit(foo3tid)

<<" should not see this foo3 \n"
}

//===============================================

int Foo4 =0;

proc foo4()
{
int z2 = 0;
int x2 = 1;
int y2 = 1;

   footid = GthreadGetId()

 // which thread am I

   //mypr =gthreadgetpriority(footid);

<<"$footid  pr $mypr \n"

   int j =0

   for (j = 0 ; j < N3; j++) {
   z2 = x2 + y2
   y2++
   x2++
   Foo4++;
   }

    <<" DONE $_proc exiting %V $x2 %v $z2 $footid \n"

     GthreadExit()
     }
//===========================================


int Foo5 =0;

proc foo5()
{
int z2 = 0;
int x2 = 1;
int y2 = 1;

   footid = GthreadGetId()

 // which thread am I

   //mypr =gthreadgetpriority(footid);

<<"$footid  pr $mypr \n"

   int j =0

   for (j = 0 ; j < N3; j++) {
   z2 = x2 + y2
   y2++
   x2++
   Foo5++;
   }

    <<" DONE $_proc exiting %V $x2 %v $z2 $footid \n"

     GthreadExit()
     }
//===========================================

int Foo6 =0;

proc foo6()
{
int z2 = 0;
int x2 = 1;
int y2 = 1;

   footid = GthreadGetId()

 // which thread am I

   //mypr =gthreadgetpriority(footid);

<<"$footid  pr $mypr \n"

   int j =0

   for (j = 0 ; j < N2; j++) {
   z2 = x2 + y2
   y2++
   x2++
   Foo6++;
   sleep(0.01)
   }

    <<" DONE $_proc exiting %V $x2 %v $z2 $footid \n"

     GthreadExit()
     }
//===========================================






int mi = 0

mi++
<<" ONLY ONCE $mi\n"

 // create some threads

//SetDebug(0,"step")

tid = GthreadGetId()

<<" main thread ? $tid \n"

  N1 = atoi(_clarg[1])
  N2 = atoi(_clarg[2])
  N3 = atoi(_clarg[3])

  <<"%V$N1 $N2 $N3\n"
  //iread()
  
  
 k = 0
 i = 1

id5 = -1


     Nta = gthreadHowMany()

  <<" should be in main thread $tid howmany threads $nt \n"

//    gthreadwait()

   tid2 = gthreadcreate("foo2")

  <<" should be in main thread after creating thread $tid2  \n"
  //gthreadsetpriority(id,20,"OTHER")
   //mypr = gthreadgetpriority(tid2)


  <<"%V  created thread $tid2 with priority $mypr\n"

   wtid = GthreadGetId()
   tid1 = gthreadcreate("foo1")
  //  gthreadsetpriority(id,0,"OTHER")
   //mypr = gthreadgetpriority(tid1)

  <<"%V created thread $tid1 $mypr\n"
  <<" should be main thread after creating thread $tid1 prior $mypr mthread $wtid \n"

   i++


   tid3 = gthreadcreate("foo3", "mt", "nnngu", 77)

  //gthreadsetpriority(id3,10,"RR")

   //mypr = gthreadgetpriority(tid3)

  <<" created thread $id3 priority $mypr \n"
  <<" should be main thread after creating thread  $tid3 \n"

   wtid = GthreadGetId()

  // gthreadsetpriority(id,10,"OTHER")

   tid4 = gthreadcreate("foo4")
   tid5 = gthreadcreate("foo5")

   Nta = gthreadHowMany() 
  
  <<" should be back in main thread %V $wtid  $Nta \n"
  <<" waiting for $(Nta-1) threads to finish\n"

   tid6 = gthreadcreate("foo6")
  m = 0;
  
  while (1) {
  
       Nta = gthreadHowMany()
	 //sleep(0.1)
	 // yieldprocess();
	 
       m++;

 
   if ((m == 5001)) {
//<<"  Main thread loop %V $wtid $m  $nt $Foo1 $Foo2 $Foo3 $Foo4\n"
<<"$Foo1 $Foo2 $Foo3\n"
    }


/{
//xic(0)
 if ((m % 2000) == 0) {
<<"  Main thread loop %V $wtid $m  $nt $Foo1 $Foo2 $Foo3\n"
//  <<"%V$m $Foo1 $Foo2 $Foo3\n\n"
  }
//xic(1)
/}

     if ((m % 100) == 0) {
tmp1 = Foo1
tmp2 = Foo2
tmp3 = Foo3
tmp4 = Foo4
tmp5 = Foo5
tmp6 = Foo6
//<<"%V$m $tmp $tmp2 $tmp3\r"
//<<"  Main thread loop %V $wtid $m  $nt $Foo1 $Foo2 $Foo3 $Foo4 $Foo5 $Foo6\r"

<<"  Main thread loop %V $wtid $m  $Nta $tmp1 $tmp2 $tmp3 $tmp4 $tmp5 $tmp6\r"
}


     if (Nta <= 2) {
        break;
	}
}


  <<" waiting for $Nta to finish! \n"
   gthreadwait()

   wtid = GthreadGetId()

  <<"  in main thread   $wtid after all other threads have finished\n"
  goo()

    <<"  Main thread end %V $wtid $m  $nt $Foo1 $Foo2 $Foo3 $Foo4 $Foo5 $Foo6\n"



    exitsi()




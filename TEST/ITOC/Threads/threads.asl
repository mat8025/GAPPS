#/* -*- c -*- */
# test threads

// SetDebug(0)

checkIn()

int N_boxes = 40

int AB[N_boxes]
int BB[N_boxes]
int CB[N_boxes]

ok = 0

float sum_AB = 0
float sum_CB = -1


 x = 2
 y = 4

<<"Globals to use %I $x $y \n"

<<" prior to goo def \n"

proc goo()
{
<<" hey I am in $_cproc goo \n"
   gz = x + y
<<" $_cproc %v $gz \n"
for (j = 0; j < N_boxes ; j++) {
 <<"$AB[j] $BB[j] $CB[j]\n"
}
     if (sum_AB == sum_CB) {
        ok =1
     }
<<"%V$ok \n"
checkNum(ok,1)
}

<<" prior to foo1 def \n"

proc foo1()
{
<<" hey I am in foo1 \n"
<<"foo1 %V$x $y \n"

   z = x + y

   foo1tid = GthreadGetId()

 // which thread am I

  <<" foo1 thread $foo1tid $_cproc computed $z = $x + $y \n"

   x++
   y++

   int j =0

   for (j = 0 ; j < N_boxes; j++) {

   z = x + y
    <<"foo1 $j \n"
  <<" foo1 thread $foo1tid $_cproc computed $z = $x + $y \n"

   x++

   y++

   AB[j] = z 

   nanosleep(0,50000)
   }

<<" DONE foo1 $_cproc exiting %v $foo1tid \n"
    sum_AB = Sum(AB)

   GthreadExit()

}

proc foo2()
{
<<" hey I am in foo2 \n"

<<" %V$x $y \n"


   foo2tid = GthreadGetId()

 // which thread am I

   int jf2 =0
   int nt

    while (1) {

     z = x + y

     if (AB[jf2] > 0) {
         BB[jf2] = AB[jf2]
  <<" foo2 thread $foo2tid moved box $jf2 $BB[jf2]\n"
         jf2++
     }

     if (jf2 >= N_boxes)
        break
	  nanosleep(0,200)
   }

<<" DONE foo2 $_cproc exiting %v $x %v $foo2tid \n"

   //GthreadExit(foo2tid)
     GthreadExit()

<<" should not see this foo2 \n"
}


proc foo3( t_arg1, t_arg2, t_arg3)
{
<<" hey I am in foo3 \n"
<<" new thread %V$_cproc  my arg is $t_arg1 $t_arg2 $t_arg3\n" 

   foo3tid = GthreadGetId()

 // which thread am I

   int jf3 =0
   int nt = 0
    <<" foo3 thread $foo3tid of $nt  my arg is < $t_arg1 > < $t_arg2 > < $t_arg3 > $_cproc computed $z = $x + $y \n"
   int ktimes = 0

    while (1) {
    
     if (BB[jf3] > 0) {

         CB[jf3] = BB[jf3]

         <<" foo3 thread $foo3tid moved box $jf3 $CB[jf3]\n"
         jf3++
     }
     else {
     <<"$ktimes trying to move box $jf3 $AB[jf3] $BB[jf3] $CB[jf3]\n"
     }

     if (jf3 >= N_boxes) {
        break
     }

     nanosleep(0,500000)
     ktimes++

     if (ktimes > 100)
         break
   }

  //  for (j = 0; j < N_boxes ; j++)
  //       BB[j] = -1


    sum_CB = Sum(CB)
<<" DONE $_cproc exiting %v $x %v $foo3tid $sum_CB\n"
   GthreadExit(foo3tid)

<<" should not see this foo3 \n"
}




int mi = 0

mi++
<<" ONLY ONCE $mi\n"




 // create some threads

//SetDebug(0,"step")

   tid = GthreadGetId()

<<"in  main thread thead id is $tid \n"

 k = 0
 i = 1

id5 = -1

     nt = gthreadHowMany()

     <<"Currently $nt threads active \n"
  //  i_read()
tname = "foo2"

  id = gthreadCreate(tname)

  <<" should be main thread after creating thread $i $wtid \n"
     nt = gthreadHowMany()
<<" $nt threads active \n"
  //   gthreadsetpriority(id,10,"RR")

   mypr = gthreadgetpriority(id)
   i++


  <<"created thread %V$id $mypr\n"


   wtid = GthreadGetId()
 
  for (jm = 0; jm < N_boxes; jm++) {
    AB[jm] = 0 ; 
    BB[jm] = 0 ;
    CB[jm] = 0; 
  }


   id = gthreadcreate("foo1")
   gthreadsetpriority(id,20,"RR")

   mypr = gthreadgetpriority(id)

  <<"created thread %V$id $mypr\n"
  <<"should be main thread after creating thread $i $wtid \n"

   i++


   id3 = gthreadcreate("foo3", "mt", "nnngu", 77)

  //   gthreadsetpriority(id3,90,"RR")

   mypr = gthreadgetpriority(id3)

  <<" created thread $id3 priority $mypr \n"
  <<" should be main thread after creating thread $i $id3 \n"

   wtid = GthreadGetId()

   nt = gthreadHowMany()
  <<" should be back in main thread %V $wtid $m $nt \n"
  <<" waiting for $(nt-1) threads to finish\n"
  //  i_read(": hit key to continue \n")
  for (m = 0 ; m < 25; m++) {
     nt = gthreadHowMany()
     nanosleep(0,300)
  <<" main thread loop %V$wtid $m $nt \n"
     if (nt <= 2) 
        break
  }


   gthreadwait()

   wtid = GthreadGetId()

<<"  in main thread   $wtid after all other threads have finished\n"
     nt = gthreadHowMany()
<<" $nt threads active \n"

  <<" now call goo() \n"
  goo()

  checkOut()

 stop!



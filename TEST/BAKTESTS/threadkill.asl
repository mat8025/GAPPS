
//  test threadkill


 x = 2
 y = 4

<<"Globals to use %I $x $y \n"

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

   for (j = 0 ; j < 15; j++) {

   z = x + y
    <<"foo1 $j \n"
  <<" foo1 thread $foo1tid $_cproc computed $z = $x + $y \n"

   x++

   y++

     sleep(1)
   }

<<" DONE foo1 $_cproc exiting %v $foo1tid \n"

      GthreadExit()

}




   tid = GthreadGetId()

<<"in  main thread? $tid \n"

   foo1_id = gthreadcreate("foo1")

   mypr = gthreadgetpriority(foo1_id)

   nt = gthreadHowMany()
  <<" should be back in main thread %V$tid $foo1_id $nt \n"


    sleep(3)


  <<"OK kill (send signal ) to foo1 \n"



      gthreadKill(foo1_id,-9)

   nt = gthreadHowMany()
  <<" should be one less thread $nt \n"

   nt = gthreadHowMany()
  <<" should be one less thread $nt \n"

   while (1) {

   nt = gthreadHowMany()
  <<" should be one less thread $nt \n"
   if (nt == 1)
        break
   }


stop!
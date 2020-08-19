//
//  test mutex wrappers

setdebug(0)

m_id = createMutex()


<<"%V $m_id\n"

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

<<"in foo1 -- trying to get mutex $m_id\n"

  ret=mutexLock(m_id)

  <<"obtained mutex  foo1 thread $foo1tid $_cproc computed $z = $x + $y \n"

   x++
   y++

   int j =0



   for (j = 0 ; j < 15; j++) {

   z = x + y
    <<"foo1 $j \n"
  <<" foo1 thread $foo1tid $_cproc computed $z = $x + $y \n"

   x++

   y++

     nanosleep(100000)
   }

<<" DONE foo1 $_cproc exiting %V$foo1tid and releasing mutex $m_id\n"
      ret=mutexUnLock(m_id)

      GthreadExit()

}
//==========================================


      ret=mutexLock(m_id)

      <<" got mutex $ret\n"

      prior = mutexGetPriority(m_id)

      <<"  mutex %V$prior\n"

      prior = mutexSetPriority(m_id,10)

      <<"  mutex %V$prior\n"

     prior = mutexGetPriority(m_id)

      <<"  mutex %V$prior\n"


   tid = GthreadGetId()

<<"in  main thread? $tid \n"
//   I think this needs a kernel mod to work ??
//   need to find out
//   gthreadSetPriority(tid,0,"RR")

   ret=mutexUnLock(m_id)
   sleep(1)
<<" Creating thread \n"
 
   foo1_id = gthreadcreate("foo1")
   
   mypr = gthreadgetpriority(foo1_id)

   ret=mutexLock(m_id)
   nt = gthreadHowMany()

<<" should be back in main thread -AFTER foo1 is DONE %V$tid $foo1_id $nt \n"



   nt = gthreadHowMany()
  <<" should be back in main thread %V$nt \n"
          nanosleep(3,1)

<<"main is now releasing mutex $m_id \n"
      ret=mutexUnLock(m_id)


      prior = mutexGetPriority(m_id)

      <<"  mutex %V$prior\n"
         nanosleep(1,1)

<<"in main trying to get   Mutex $m_id \n"

      ret=mutexLock(m_id)
  <<"bak in main after waiting on Mutex %V$m_id \n"


   nt = gthreadHowMany()
  <<" should be back in main thread %V$nt \n"




stop!

//
//  test mutex wrappers

#define PGREEN '\033[1;32m'
#define PRED '\033[1;31m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'


#define OMG 47

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
    //ret=mutexLock(m_id)
{
   while(1) {
      ret=mutexTryLock(m_id)
  <<""$ret \n"
      if (ret ==1) {
         break;
      }
      sleep(0.1)
  }
}
  <<"obtained mutex? $ret foo1 thread $foo1tid $_cproc computed $z = $x + $y \n"

   x++
   y++

   int j =0

   for (j = 0 ; j < 15; j++) {

   z = x + y
    <<"foo1 $j \n"
  <<" $(PGREEN) foo1 thread $foo1tid $_cproc computed $z = $x + $y $(POFF) \n"

   x++

   y++

    // nanosleep(100000)
     sleep(0.5)
   }

    ret=mutexUnLock(m_id)

<<" DONE  $_proc $ret exiting %V$foo1tid and releasing mutex $m_id $(POFF) \n"

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

<<"in  main thread $tid \n"
//   I think this needs a kernel mod to work ??
//   need to find out
//   gthreadSetPriority(tid,0,"RR")

//   ret=mutexUnLock(m_id)

 <<"Creating thread 1\n"

   foo1_id = gthreadcreate("foo1")


   ret=mutexUnLock(m_id);

<<"Main unlocks \n"

   sleep(1)
   
 //  mypr = gthreadgetpriority(foo1_id)
// ret=mutexUnLock(m_id);
 int ntrys = 0;


 sr= " \033[1;31m";
 sro = "\033[0m";


  while(1) {
      ret=mutexTryLock(m_id)
  
      if (ret ==1) {
         break;
      }
      ntrys++;

//"\t\t \033[1;31m$ntrys main thread trying to get mutex $ret waiting on foo1 - now sleeping\033[0m \n"

<<"\t\t \033[1;3${ntrys}m$ntrys main thread trying to get mutex $ret waiting on foo1 - now sleeping\033[0m \n"

//<<"\t\t $sr $ntrys main thread trying to get mutex $ret waiting on foo1 - now sleeping $sro \n"

<<"\t\t\t $(PRED) sd is $(RED_)  $(GREEN_1) $ntrys main thread trying to get mutex $ret waiting on foo1 - now sleeping $(POFF) HeyBlackPen\n"

//<<"t\t $ntrys main thread trying to get mutex $ret waiting on foo1 - now sleeping \n"


      sleep(0.5)
  }


   nt = gthreadHowMany()

<<" should be back in main thread - AFTER foo1 is DONE %V$tid $foo1_id $nt $ret\n"

   nt = gthreadHowMany()

  <<" should be back in main thread %V$nt \n"

      nanosleep(3,1)

//<<"main is now releasing mutex $m_id \n"

      prior = mutexGetPriority(m_id)

      <<"  mutex %V$prior\n"

         nanosleep(1,1)

<<" $(PBLACK) in main trying to get   Mutex $m_id \n"


  <<"bak in main after waiting on Mutex %V$m_id \n"

   nt = gthreadHowMany()

  <<" should be back in main thread %V$nt \n"

    ret=mutexUnLock(m_id)

<<"main $ret is now releasing mutex $m_id \n"


    ret=mutexLock(m_id)

<<"main $ret is now reacquiring mutex $m_id \n"


    ret=mutexUnLock(m_id)

<<"main $ret is now re-releasing mutex $m_id \n"



stop!

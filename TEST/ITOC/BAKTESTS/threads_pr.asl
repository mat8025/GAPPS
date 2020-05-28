#/* -*- c -*- */
# test threads

 SetDebug(0)



T= utime()
int ti = 10

int jt1 =0

proc foo1()
{

<<" %V foo1 $x $y \n"

   z = x + y

   foo1tid = GthreadGetId()

   gthreadsetpriority(foo1tid,high_pr,sched_type)

 // which thread am I
   int mypr = gthreadgetpriority(foo1tid)
  <<" foo1 thread $foo1tid %v $mypr\n"


   x++
   y++

   sleep(1)

   while (1) {

   z = x + y
    if ((jt1 % 1000) == 0) {
//  <<" foo1 $jt1 thread $foo1tid $_cproc computed $z = $x + $y \n"
     yieldthread()
     sleep(0.1)
   }
   x++

   y++

//     sleep(0.5)
    jt1++
    nt = utime()
    if ((nt - T) > ti)
         break
     yieldthread()
   }

  mypr = gthreadgetpriority(foo1tid)
<<" DONE foo1 $_cproc exiting %v $foo1tid $mypr  nl $jt1\n"
<<" EXIT THREAD %v $foo1tid \n"
      GthreadExit()



}

int jt2= 0

proc foo2()
{
<<" %V $x $y \n"


   foo2tid = GthreadGetId()

   gthreadsetpriority(foo2tid,mid_pr,sched_type)
 // which thread am I
   int mypr = gthreadgetpriority(foo2tid)
  <<" foo2 thread $foo2tid %v $mypr\n"

   sleep(1)

   while (1) {
   z = x + y
   if ((jt2 % 1000) == 0) {
//  <<" foo2 thread $foo2tid $_cproc computed $z = $x + $y \n"
   yieldthread()
   }

   y++
   x++
//     sleep(0.1)
    jt2++
    nt = utime()
    if ((nt - T) > ti)
         break
     yieldthread()
   }

  mypr = gthreadgetpriority(foo2tid)
<<" DONE foo2 $_cproc exiting %v $x %v $foo2tid $mypr  nl $jt2\n"

<<" EXIT THREAD %v $foo2tid \n"
     GthreadExit()

<<" should not see this foo2 \n"
}

int jt3 = 0

proc foo3( t_arg1, t_arg2, t_arg3)
{
<<" %V new thread $_cproc  my arg is $t_arg1 $t_arg2 $t_arg3\n" 

   foo3tid = GthreadGetId()

 // which thread am I

   gthreadsetpriority(foo3tid,mid_pr,sched_type)
   int mypr = gthreadgetpriority(foo3tid)
  <<" foo3 thread $foo3tid %v $mypr\n"

   sleep(1)

   while (1) {
    z = x + y
   if ((jt3 % 1000) == 0) {
//   <<" foo3  thread $foo3tid my arg is < $t_arg1 > < $t_arg2 > < $t_arg3 > $_cproc computed $z = $x + $y \n"
   yieldthread()
   }
    y++
    x++

    jt3++
    nt = utime()
    if ((nt - T) > ti)
         break
//     sleep(0.5)
     yieldthread()
   }


  mypr = gthreadgetpriority(foo3tid)

<<" DONE $_cproc exiting %v $x %v $foo3tid $mypr nl $jt3\n"

<<" EXIT THREAD %v $foo3tid \n"
   GthreadExit()

<<" should not see this foo3 \n"
}


proc mt()
{
   mtid = GthreadGetId()

   gthreadsetpriority(mttid,high_pr+1,sched_type)
   mypr = gthreadgetpriority(mtid)
  <<" in mt thread priority $mypr \n"

   id = gthreadcreate("foo$i")
     nt = gthreadHowMany()
  <<" should be in mt thread after creating thread $i $id $nt \n"

   i++

   id = gthreadcreate("foo$i")
     nt = gthreadHowMany()
  <<" should be main thread after creating thread $i $id $nt \n"
   i++

     nt = gthreadHowMany()
<<" $nt threads active \n"

   id3 = gthreadcreate("foo3", "mt", "nnngu", 77)

//   gthreadsetpriority(id3,mid_pr,sched_type)

   mypr = gthreadgetpriority(id3)

  <<" created thread %v $id3 priority $mypr \n"

   wtid = GthreadGetId()

  <<" created thread $id3 priority $mypr \n"
  <<" should be main thread after creating thread $i $id3 \n"

   nt = gthreadHowMany()

  <<" int mt  %V $wtid $m $nt \n"

  <<" waiting for $nt threads to finish\n"

  for (m = 0 ; m < 25; m++) {
     nt = gthreadHowMany()
     sleep(0.1)
  <<" mth loop %V $wtid $m $nt \n"
     if (nt <= 2) 
        break

     yieldthread()
  }

<<" EXIT THREAD mt $mtid \n"

   GthreadExit()

}


int mi = 0

mi++


 x= 2
 y = 4

 // create some threads

//SetDebug(0,"step")




 k = 0
 i = 1

id5 = -1
sched_type = "RR"
//sched_type = "FIFO"
low_pr = 2
mid_pr = 3
high_pr = 4


   tid = GthreadGetId()

<<" main thread ? $tid \n"
// set main thread at high

//     gthreadsetpriority(tid,high_pr,sched_type)

     id = gthreadcreate("mt")

     nt = gthreadHowMany()
  <<" should be back in main  after waiting for $nt threads  to finish $wtid \n"

   wtid = GthreadGetId()

  <<" should be back in main thread  after waiting for $nt threads  to finish $wtid \n"
     sleep(1)
     nt = gthreadHowMany()

   while (nt > 1) {

     nt = gthreadHowMany()

   }
<<" %v $nt \n"

<<" using %v $sched_type \n"

 STOP!



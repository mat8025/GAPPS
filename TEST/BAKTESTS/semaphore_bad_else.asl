
// test createsem  sem_post sem_wait

// trains running towards a section of single track pos 50 to 100
setdebug(1)
int t_A = 0
int t_B = 0
int p_A 
int p_B
int Crash = 0

proc train_A()
{

int pa = 200
int sr

   a_tid = GthreadGetId()
  <<"  thread $a_tid $_cproc\n"

  while (1) {

   p_A = pa

<<"train_A @ %V$p_A $pa\n"

   if (pa == 101) {
      // can I proceed
      <<"train_A at critical section do I have to wait? %V$pa \n"
         //sv = getSemVal(s_id_1)

//         sr = sem_wait(s_id_1)
         // did I wait
         <<"%V$sr \n"
   }



   if ((pa <= 100) && (pa >= 50)) {

    t_A = 1
/{

    if (t_B == 1) {
<<"Crash imminent\n"
    Crash =1
    }
    
    if (abs(p_A - p_B) <= 1) {
      Crash =1
    }


/}


   }
   else {
     t_A = 0
   }


   if (pa == 50) {
       <<" finished using track post \n"
  //     sp = sem_post(s_id_1)
   }




   sleep(0.1)

   pa--


   if (pa == 0) {
<<"break $pa \n"
       break
   }

  }

   t_A = -1

<<"exit thread %V$pa \n"

  // GthreadExit() 
}

/{

proc train_B()
{

int p = 0

int sr = -1


  while (1) {

//<<"train_B %V$p $p_B\n"

   if (p == 49) {

      // can I proceed
<<"train_B - can I proceed ?  - else wait \n"
        // sv = getSemVal(s_id_1)

         sr = sem_wait(s_id_1)
         // did I wait
         <<"%V$sr finished wait\n"
   }


// critical section

   if (p <= 100 && p >= 50) {
    t_B = 1


    if (t_A == 1) {
<<"Look out Crash imminent\n"
    


    }    


    if (abs(p_A - p_B) <= 1) {
      Crash =1
    }

   }
   else
     t_B = 0



   sleep(0.3)

   if (p == 50) {
       // finished using track
       sp = sem_post(s_id_1)
   }


   p++

   p_B = p
<<"train_B @ $p_B\n"



   if (p == 200) {
       break
   }

  }


   t_B = -1
<<"exit thread %V$p \n"
   GthreadExit() 


}
/}

   tid = GthreadGetId()

<<" main thread ? $tid \n"

     nt = gthreadHowMany()

<<" how many threads ? $tid \n"


// create some semaphores for use by the trains

/{
   s_id_1=createSem()

  // s_id_2=createSem()

<<"%V$s_id_1  \n"

    sv = getSemVal(s_id_1)

<<"%V$sv\n"

/}


/{
   train_A_id = gthreadcreate("train_A")

  <<" should be main thread after creating thread %V$train_A_id \n"

   mypr = gthreadgetpriority(train_A_id)
 
  <<"created thread %V$mypr\n"


   train_B_id = gthreadcreate("train_B")

  <<" should be main thread after creating thread %V$train_B_id \n"

   mypr = gthreadgetpriority(train_B_id)
 
  <<"created thread %V$mypr\n"
/}




     nt = gthreadHowMany()

<<" how many threads ? $tid \n"


    train_A()



stop!

int k = 0


   while (1) {






     k++
     sleep(0.5)

   if (Crash) {

<<" Disaster  trains collide positions %V$p_A $p_B !\n")
     break 
   }

   if ((t_A == -1) && (t_B == -1)) {
<<"%V$t_A $t_B at arrival stations\n"
      break
   }

  }





stop!


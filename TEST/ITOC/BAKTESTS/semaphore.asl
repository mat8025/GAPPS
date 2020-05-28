
// test createsem  sem_post sem_wait

// trains running towards a section of single track pos 50 to 100
setdebug(1)

int t_A = 0
int t_B = 0

int p_A 
int p_B
int Crash = 0

int t_A_running = 0
int t_B_running = 0

proc train_A()
{

int pa = 200
int sr
int dir = -1
float sleep_time = 0.5
int safe_arrival = 0;

   a_tid = GthreadGetId()
  <<"  thread $a_tid $_cproc\n"
  sv = 0

  int k_times = 0

  while (k_times < 5000) {

   p_A = pa

//<<"train_A @ %V$pa $dir\n"
// FIX ME

   if ((pa == 101) && (dir == -1)) {


      // can I proceed
 <<"train_A at critical section do I have to wait? %V$pa $k\n"
         //sv = getSemVal(s_id_1)
         if (sv == 0) {
<<"train_A looks like I have to wait!! %V$sv @ $k\n"

         }
         //sr = sem_wait(s_id_1)
         // did I wait ?
    <<"train_A done waiting%V$sr @ $k\n"
   }


   if ((pa == 49) &&  (dir == 1)) {

      // can I proceed

      <<"train_A at critical section do I have to wait? %V$pa $k\n"

//         sv = getSemVal(s_id_1)

//         sr = sem_wait(s_id_1)

         // did I wait ?
         <<"train_A done waiting%V$sr @ $k\n"
   }



   if ((pa <= 100) && (pa >= 50)) {

    t_A = 1

<<"train_A in critical section $pa $t_A\n"

    if (t_B == 1) {

<<"Crash imminent\n"

    Crash =1

    how_close = abs(p_A - p_B)
    
    if (abs(p_A - p_B) <= 1) {
      Crash =1
       <<"train_A%V$how_close \n"
    }

    }


   }
   else {
     t_A = 0
   }




   if ((pa == 101) && (dir == 1) ) {

  //     sp = sem_post(s_id_1)
  //       sv = getSemVal(s_id_1)

<<"train_A finished using track %V$pa $p_A so set sem open $sv and post wake_up\n"

   
   }

  if ((pa == 48) && (dir == -1) ) {



   //    sp = sem_post(s_id_1)
   //    sv = getSemVal(s_id_1)

<<"train_A finished using track %V$pa $p_A so set sem open $sv and post wake_up\n"

   }



   sleep(sleep_time)

   pa += dir

   t_A_running = 1


//i_read()
    if ((pa == 200) || (pa == 0)) {



<<"break $pa \n"
  //     break
     dir = dir * -1
     sleep_time *= 0.99

     if (sleep_time < 0.05) {
     sleep_time = 1.3
     }

   safe_arrival++
<<"train_A safe @ station %V$sleep_time $safe_arrival\n"

   }

   k_times++
<<"train_A $k_times \n"
  }

   t_A = -1
   t_A_running = 0
<<"exit thread %V$pa \n"

   GthreadExit() 
}



proc train_B()
{

int p = 0

int sr = -1
int dir = 1
float sleep_time = 0.12
int safe_arrival = 0

  int k_times = 0

  while (1) {

  <<"train_B %V$p $k_times\n"

   if ((p == 49) && (dir == 1)) {

      // can I proceed
<<"train_B - can I proceed ?  - else wait $k\n"

       //  sv = getSemVal(s_id_1)
         if (sv == 0) {
<<"train_B looks like I have to wait!! %V$sv @ $k\n"
         }

       //  sr = sem_wait(s_id_1)
         // did I wait
         <<"train B done waiting %V$sr @ $k\n"
   }

   if ((p == 101) && (dir == -1)) {

      // can I proceed
<<"train_B - can I proceed ?  - else wait $k\n"
       //  sv = getSemVal(s_id_1)
<<"train_B - %V$sv  \n"
       //  sr = sem_wait(s_id_1)
         // did I wait
         <<"train B done waiting %V$sr @ $k\n"
   }



// critical section

   if ((p <= 100) && (p >= 50)) {



    t_B = 1



//<<"train_B in critical section $p $t_B\n"

    if (t_A == 1) {
<<"Look out Crash imminent\n"

    how_close = abs(p_A - p_B)

    if (abs(p_A - p_B) <= 1) {

<<"crash @ %V$p_A $p_B $how_close\n"

      Crash =1
    }

    }



   }
   else {
     t_B = 0
   }


   sleep(sleep_time)

   if ((p == 101) && (dir == 1) ) {
       // finished using track
     //  sp = sem_post(s_id_1)
     //  sv = getSemVal(s_id_1)
     <<"train_B finished using track %V$p $p_B so set sem open $sv and post wake_up\n"
   }

   if ((p == 49) && (dir == -1) ) {
       // finished using track

     //  sp = sem_post(s_id_1)
     //   sv = getSemVal(s_id_1)
     <<"train_B finished using track %V$p $p_B so set sem open $sv and post wake_up\n"
   }


   p += dir

   p_B = p
//<<"train_B @ $p_B\n"
   t_B_running = 1


   if ((p == 200) || (p == 0)) {
       dir = dir * -1
       t_B = -1
   safe_arrival++
<<"train_B safe @ station %V$sleep_time $safe_arrival\n"

   }

    k_times++
  }


   t_B = -1
<<"exit thread %V$p \n"

   GthreadExit() 


}



int k = 0

mypr = 0

   tid = GthreadGetId()

<<" main thread ? $tid \n"

     nt = gthreadHowMany()

<<" how many threads? $nt \n"


// create some semaphores for use by the trains


 //    train_B()    

//   s_id_1=createSem()
   s_id_1= 1

//   s_id_2=createSem()
   s_id_2= 2

<<"%V$s_id_1  \n"

//    sv = getSemVal(s_id_1)
    sv = 1
<<"%V$sv\n"

  train_A_id = gthreadcreate("train_A")

  //train_A_id = 1
  //train_A()    

  <<" should be main thread after creating thread %V$train_A_id \n"

  mypr = gthreadgetpriority(train_A_id)
 
  <<"created thread %V$mypr\n"


  train_B_id = gthreadcreate("train_B")

  <<" should be main thread after creating thread %V$train_B_id \n"

  mytbpr = gthreadgetpriority(train_B_id)
 
  <<"created thread %V$mytbpr\n"


   //  train_B()    


     nt = gthreadHowMany()

<<" how many threads? %V$nt \n"

//hold_main = i_read(":-)")


     nt = gthreadHowMany()

<<" how many threads? %V$nt \n"

//hold_main = i_read(":-)")




   while (1) {

     k++
<<"in main thread $k \n"


   //train_A()    

   sleep(2.0)

   //train_B()    

   if (Crash) {


<<" Disaster  trains collided positions %V$p_A $p_B !\n"

//     break 
   }
   else {

<<"OK so_far %V$p_A $p_B  $t_A $t_B \n"

   }


   if ((t_A == -1) && (t_B == -1)) {
<<"%V$t_A $t_B at arrival stations\n"
//      break
   }

   if ((t_A == -1) ) {
<<"%V$t_A arrived safely at station  $t_B \n"
    
   }

   if ((t_B == -1) ) {
<<"%V$t_B arrived safely at station  $t_A \n"
    
   }


  }





stop!





//<<" Disaster  trains collided positions %V$p_A $p_B !\n")
<<"OK so_far %V$p_A $p_B  $t_A $t_B \n")
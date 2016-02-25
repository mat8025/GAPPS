// test threads

// trains running towards a section of single track @ pos 25 to 50

// in this version we will use semaphores to indicate if trains are on critical section
// and wait until safe to proceed
// 

//setdebug(1)

int t_A = 0
int t_B = 0

int p_A 
int p_B
int Crash = 0

int t_A_running = 0
int t_B_running = 0

int dir_A = -1
int dir_B = 1
int t_AW = 0
int t_BW = 0

proc train_A()
{
int ins = 0
int pa = 100
int sr

float sleep_time = 0.25
int safe_arrival = 0;
int just_started = 0

   a_tid = GthreadGetId()
  <<"  thread $a_tid $_cproc\n"
  sv = 0

  int k_times = 0

  while (1) {

   p_A = pa

//<<"train_A @ %V$pa $dir_A\n"


   if ((pa == 51) && (dir_A == -1)) {


      // can I proceed

 //<<"train_A at critical section do I have to wait? %V$pa $t_B $k\n"

         sv = getSemVal(s_id_1)
         if (sv == 0) {
           <<"train_A looks like I have to wait!! %V$sv @ $k\n"
         }
         else {
 //          <<"no wait $sv\n"
         }


         t_AW = 1
         sr = sem_wait(s_id_1)
         // did I wait ?
         t_AW = 0

   }


   if ((pa == 24) &&  (dir_A == 1)) {

      // can I proceed

     // <<"train_A at critical section do I have to wait? %V$pa $k\n"
         sv = getSemVal(s_id_1)
         if (sv == 0) {
           <<"train_A looks like I have to WAIT!! %V$sv @ $k\n"
         }
         else {
   //        <<"no wait $sv\n"
         }

          
           t_AW = 1
           sr = sem_wait(s_id_1)
           t_AW = 0
         // did I wait ?

   }

   if ((pa <= 50) && (pa >= 25)) {

    t_A = 1

    if (t_B == 1 && (dir_A != dir_B)) {

<<"train_A in critical section $pa $t_A\n"

    how_close = abs(p_A - p_B)

<<"Crash imminent %V$p_A $p_B  $how_close  $dir_A $dir_B\n"

    if (how_close <= 1) {
      Crash =1
       <<"train_A %V$Crash $how_close \n"
    }

    }


   }
   else {
     t_A = 0
   }

   if ((pa == 51) && (dir_A == 1) ) {

  sp = sem_post(s_id_1)
  sv = getSemVal(s_id_1)

     // <<"train_A finished using track %V$pa $p_A so set sem open $sv and post wake_up\n"

         t_A = 0   
   }

   if ((pa == 24) && (dir_A == -1) ) {

   sp = sem_post(s_id_1)
   sv = getSemVal(s_id_1)

    // <<"train_A finished using track %V$pa $p_A so set sem open $sv and post wake_up\n"
          t_A = 0
   }

   
   pa += dir_A

   if ((pa <= 50) && (pa >= 25)) {
       t_A = 1
   }

   t_A_running = 1


//i_read()
    if ((pa == 100) || (pa == 0)) {
     


<<"break $pa \n"
  //     break

     dir_A = dir_A * -1  // reverse direction
 just_started = 1
//    sleep_time *= 0.99

//<<"train_A safe @ station %V$sleep_time $safe_arrival\n"
//<<"[A]"

     nanosleep(2,10)



   safe_arrival++

  if (just_started) {
    if (dir_A == -1) {
    <<"train_A starts off @ station Liverpool\n"
    }
    else {
     <<"train_A starts off @ station London\n"
    }
    just_started = 0
   }

  }

   nanosleep(0,90000000)

   


   k_times++
//<<"train_A $k_times \n"
  }

   t_A = -1
   t_A_running = 0

<<"exit thread %V$pa \n"

   GthreadExit() 
}



proc train_B()
{
int ins = 0
int pb = 0

int sr = -1

float sleep_time = 0.25
int safe_arrival = 0
just_started = 0
  int k_times = 0

  while (1) {

  //<<"train_B %V$p $k_times\n"

   if ((pb == 24) && (dir_B == 1)) {

      // can I proceed
//<<"train_B - can I proceed ?  - else wait $k\n"

         sv = getSemVal(s_id_1)
         if (sv == 0) {
            <<"train_B looks like I have to WAIT!! %V$sv @ $k\n"
         }
         else {
//           <<"no wait $sv\n"
         }
         t_BW = 1
         sr = sem_wait(s_id_1)
         t_BW = 0
   }

   if ((pb == 51) && (dir_B == -1)) {

      // can I proceed
//<<"train_B - can I proceed ?  - else wait $k\n"
         sv = getSemVal(s_id_1)
         if (sv == 0) {
            <<"train_B looks like I have to WAIT!! %V$sv @ $k\n"
         }
         else {
  //         <<"no wait $sv\n"
         }

         t_BW = 1
         sr = sem_wait(s_id_1)
         t_BW = 0
   }



// critical section

   if ((pb <= 50) && (pb >= 25)) {

    t_B = 1


//<<"train_B in critical section $pb $t_B\n"

    if (t_A == 1 && (dir_A != dir_B)) {
<<"Look out Crash imminent\n"

    how_close = abs(p_A - p_B)

    if (abs(p_A - p_B) <= 1) {

      Crash =1
<<"%V$Crash @ $p_A $p_B $how_close\n"


    }

    }

   }
   else {
     t_B = 0
   }



     nanosleep(60000000)

   


   if ((pb == 51) && (dir_B == 1) ) {
       // finished using track
       sp = sem_post(s_id_1)
       sv = getSemVal(s_id_1)
    // <<"train_B finished using track %V$pb $p_B so set sem open $sv and post wake_up\n"
        t_B = 0
   }

   if ((pb == 24) && (dir_B == -1) ) {
       // finished using track
       sp = sem_post(s_id_1)
       sv = getSemVal(s_id_1)
    // <<"train_B finished using track %V$pb $p_B so set sem open $sv and post wake_up\n"
        t_B = 0
   }


   pb += dir_B
   p_B = pb

   if ((pb <= 50) && (pb >= 25)) {
       t_B = 1
   }



//<<"train_B @ $p_B\n"
   t_B_running = 1


   if ((pb == 100) || (pb == 0)) {
       dir_B = dir_B * -1
       just_started = 1
       t_B = -1
   safe_arrival++
//<<"train_B safe @ station %V$sleep_time $safe_arrival\n"
    nanosleep(2,10)
   }

 if (just_started) {
  if (dir_B == -1) {  
    <<"train_B starts off from station Liverpool\n"
  }
  else {
    <<"train_B starts off from station London\n"
  }
   just_started = 0
 }


  //  sleep(sleep_time)

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

   s_id_1=createSem()

   s_id_2=createSem()
   

<<"%V$s_id_1  \n"

   sv = getSemVal(s_id_1)
   
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

//<<"in main thread $k \n"


   //train_A()    
   //<<"sleeping in main \n"

   nanosleep(9000000)



   if (Crash) {

<<" Disaster  trains collided positions %V$p_A $p_B !\n"

    stop!

//     break 
   }
   else {
<<"London"


<<"$(nsc(19,\"_\")) $(nsc(25,\"X\")) $(nsc(40,\"_\"))"

<<"Liverpool\n"


<<"$(nsc(p_A,\" \"))"

 if (t_AW) { 
    <<"a\n"
 }
  else {
  if ((p_A > 1) && (p_A < 97)) {
  <<"A\n"
  }
  else {
<<"[A]\n"
  }
 }


<<"$(nsc(p_B,\" \"))"

 if (t_BW) {
     <<"b\n"
 } 
 else { 
  if ((p_B > 1) && (p_B < 97)) {
  <<"B\n"
  }
  else {
<<"[B]\n"
  }

 }
//<<"OK so_far %V$p_A $p_B  $t_A $t_B \n"

   }



   if ((t_A == -1) ) {
//<<"%V$t_A arrived safely at station  $t_B \n"

   //nanosleep(2,0) 
   }

   if ((t_B == -1) ) {
//<<"%V$t_B arrived safely at station  $t_A \n"
   //nanosleep(2,0) 
   }


  }





stop!





//<<" Disaster  trains collided positions %V$p_A $p_B !\n")
<<"OK so_far %V$p_A $p_B  $t_A $t_B \n")

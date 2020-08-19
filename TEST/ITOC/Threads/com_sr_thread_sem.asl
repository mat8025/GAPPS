//     com -- sender ---> receiver
//     use semaphores for read-write protection 
//

chkIn()

enum com { 
  READY,
  READY_WAIT,
  PROCESSING,
  DONE,
  DONE_WAIT,
}


 int sender = READY
 int sender_cnt =0;
 int sender_val = 0;

 int receiver = READY
 int receiver_cnt =0;
 int receiver_val =0;

<<"%V$sender $receiver \n"
<<"$(typeof(com)) \n"
<<"$com[0] $com[1] $com[2] $com[5]\n"
<<"$com[0:-1]\n"

//<<"$com->getName(0) \n"

 s_state = com->enumNameFromValue(0)
 r_state = com->enumNameFromValue(1)

<<"$s_state $r_state \n"

//<<" $(com->enumNameFromValue(0)) \n"
//<<" $(com->enumNameFromValue(1)) \n"





proc checkSender()
{

   s_tid = GthreadGetId()
  <<" checkSender thread $s_tid $_cproc\n"

 sender = READY

 while (1) {


  switch (sender) 
    {
    case READY:
       sem_wait(s_wid)
       sender = PROCESSING;
        break;
    case PROCESSING:
       sender_val += 1000;  
       sender_cnt++;
       sender = DONE
        break;
    case DONE:
        sender = READY;  
        sem_post(s_rid)
         break;
    }

   if (sender_cnt == NCNT) {
      <<"sender waiting for exit condition \n"
     sleep(1.0)

    if (sender_cnt == receiver_cnt) {
      <<"sender DONE exits \n"
      break
    }
  }

  }

   sleep(3)

   GthreadExit() 

}


proc checkReceiver()
{

   r_tid = GthreadGetId()
  <<" checkReceiver thread $r_tid $_cproc\n"

 receiver = READY
 int kr = 0 

 while (1) {
  get_lock = 0
//<<"%V$kr   $receiver \n"


  switch (receiver) 
  {
    case READY:
      sem_wait(s_rid)   
      receiver = PROCESSING;
     break;
   case PROCESSING:
        receiver_cnt++;
        receiver_val = sender_val;
        receiver = DONE
   break;
   case DONE:
         receiver = READY; // and then tiny sleep so we don't get mutext first?
         sem_post(s_wid)
   break;

  }


   if (receiver_cnt == NCNT) {
<<"%V$kr \n"
         break
   }

 }

   GthreadExit() 

}

NCNT = 20000


// create some semaphores for use by the reader/writers


   s_wid=createSem()

   s_rid=createSem()

   sem_wait(s_rid)   // reader has to wait initially

<<"%V$s_rid $s_wid  \n"

    sv = getSemVal(s_wid)

   tid = GthreadGetId()

<<" main thread ? $tid \n"

     nt = gthreadHowMany()

<<" how many threads ? $tid \n"

   sender_id = gthreadcreate("checkSender")

  <<" should be main thread after creating thread %V$sender_id \n"

   mypr = gthreadgetpriority(sender_id)
 
  <<"created thread %V$mypr\n"


   receiver_id = gthreadcreate("checkReceiver")

  <<" should be main thread after creating thread %V$receiver_id \n"

   mypr = gthreadgetpriority(receiver_id)
 
  <<"created thread %V$mypr\n"




int k = 0
<<"%V $k \n"

    while (1) {


 s_state = com->enumNameFromValue(sender)
 r_state = com->enumNameFromValue(receiver)

<<"$k SENDER $sender $s_state\t\t$sender_cnt $sender_val RECEIVER $r_state\t\t$receiver_cnt $receiver_val\n"

//step = iread(":-)")

    if (receiver_cnt >= NCNT) {
        break
    }

     sleep(1.0)

     k++
    }


// kill threads


     nt = gthreadHowMany()

  <<" should be main thread how many threads? $nt \n"

 chkN(sender_cnt,NCNT)
 chkN(receiver_cnt,NCNT)

 chkN(sender_val, (NCNT * 1000))
 chkN(receiver_val, (NCNT * 1000))

chkOut()


stop!
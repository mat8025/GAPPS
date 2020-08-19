
//     com -- sender ---> receiver

checkIn()

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


//<<"$com[0:-1]\n"   // FIXIT XIC

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

 while (1) {

  switch (sender) 
  {
    case READY:
         if (receiver == READY)
             sender = PROCESSING;
         else if (receiver == READY_WAIT)
             sender = PROCESSING;
         else
            sender = READY_WAIT;
     break;
   case READY_WAIT:
       sleep(0.01)
         if (receiver == READY)
             sender = PROCESSING;
         else if (receiver == READY_WAIT)
             sender = PROCESSING;
      break;
   case PROCESSING:
        sender_cnt++;
        sender_val += 1000;
        sender = DONE
   break;
   case DONE:
        if (receiver == DONE)
            sender = READY;
         else if (receiver == DONE_WAIT)
            sender = READY;
        else
            sender = DONE_WAIT;
   case DONE_WAIT:
       sleep(0.01)
         if (receiver == DONE)
            sender = READY;
         else if (receiver == DONE_WAIT)
            sender = READY;
   break;

  }
   if (sender_cnt == NCNT)
       break

  }

   GthreadExit() 

}


proc checkReceiver()
{

   r_tid = GthreadGetId()
  <<" checkReceiver thread $r_tid $_cproc\n"

 while (1) {

  switch (receiver) 
  {
    case READY:
         if (sender == DONE)
             receiver = PROCESSING;
         else
            receiver = READY_WAIT;
     break;
   case READY_WAIT:
         sleep(0.02)
         if (sender == DONE)
             receiver = PROCESSING;
         else if (sender == DONE_WAIT)
             receiver = PROCESSING;
      break;
   case PROCESSING:
        receiver_cnt++;
        receiver_val = sender_val;
        receiver = DONE
   break;
   case DONE:
        if (sender == READY)
            receiver = READY;
        else if (sender == READY_WAIT)
            receiver = READY;
        else
            receiver = DONE_WAIT;
   case DONE_WAIT:
         sleep(0.02)
         if (sender == READY)
            receiver = READY;
        else if (sender == READY_WAIT)
            receiver = READY;

   break;

  }

 }

   GthreadExit() 

}

NCNT = atoi(_clarg[1])
<<"%V$NCNT \n"


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

    if (receiver_cnt >= NCNT)
        break

     sleep(0.1)

     k++
    }


// kill threads


     nt = gthreadHowMany()

  <<" should be main thread how many threads? $nt \n"

 checkNum(sender_cnt,NCNT)
 checkNum(receiver_cnt,NCNT)

 checkNum(sender_val, (NCNT * 1000))
 checkNum(receiver_val, (NCNT * 1000))

checkOut()


stop!
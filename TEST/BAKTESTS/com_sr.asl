
//     com -- sender ---> receiver


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

  switch (sender) 
  {
    case READY:
         if (receiver == READY)
             sender = PROCESSING;
         else
            sender = READY_WAIT;
     break;
   case READY_WAIT:
         if (receiver == READY)
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
        else
            sender = DONE_WAIT;
   case DONE_WAIT:
         if (receiver == DONE)
            sender = READY;
   break;

  }

}


proc checkReceiver()
{

  switch (receiver) 
  {
    case READY:
         if (sender == DONE)
             receiver = PROCESSING;
         else
            receiver = READY_WAIT;
     break;
   case READY_WAIT:
         if (sender == DONE)
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
        else
            receiver = DONE_WAIT;
   case DONE_WAIT:
         if (sender == READY)
            receiver = READY;
   break;

  }

}


int k = 0

    while (1) {

       checkSender()


       checkReceiver()

 s_state = com->enumNameFromValue(sender)
 r_state = com->enumNameFromValue(receiver)

<<"$k $sender $s_state  $sender_cnt $sender_val $r_state $receiver_cnt $receiver_val\n"

//step = iread(":-)")

    if (k++ > 100)
        break

    }






stop!
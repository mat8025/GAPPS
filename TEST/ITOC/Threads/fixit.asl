


enum com { 
  READY,
  READY_WAIT,
  PROCESSING,
  DONE,
  DONE_WAIT,
}


int k = 0

<<"%V$k \n"


k = 4

<<"%V$k \n"


s_state = com->enumNameFromValue(0)
 r_state = com->enumNameFromValue(1)

<<"$s_state $r_state \n"



stop!
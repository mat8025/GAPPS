

 svar mo = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"}

<<"%V$mo \n"



<<"$mo[1] \n"

<<"$mo[0] \n"

<<"$mo[2:4] \n"
int wd 
  ld = julday("01/01/2009")
  for (k = 0; k < 12 ; k++) {
  wm = k + 1

  wd = julday("$wm/01/2009")
  dd = wd - ld
<<"$k $mo[k] $wd $dd\n"
  ld = wd

  }
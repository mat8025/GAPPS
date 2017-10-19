
CheckIn()

// trailing + make it a dynamic expandable array
int J[20+] 

  J[0:30]->SetV(10,2)

<<"$J \n"
int sum
<<"%V$sum \n"

  sum = J[1] + J[2] 

<<"  %V$sum = $J[1] + $J[2]   \n"


CheckNum(sum,26)

  sum = J[2] + J[1] 

<<"  %V$sum = $J[2] + $J[1]   \n"

CheckNum(sum,26)

  sum = J[1] + J[2] + J[3] 

<<"  %V$sum = $J[1] + $J[2] + $J[3]  \n"

CheckNum(sum,42)

  sum = J[3] + J[2] + J[1] 

<<"  %V$sum = $J[3] + $J[2] + $J[1]  \n"

CheckNum(sum,42)

  sum = J[1] + J[2] + J[3] + J[4]

<<"  %V$sum = $J[1] + $J[2] + $J[3] + $J[4] \n"

CheckNum(sum,60)

  sum = J[2] + J[1] + J[4] + J[3]

<<"  %V$sum = $J[2] + $J[1] + $J[4] + $J[3] \n"

CheckNum(sum,60)

int k = 11


  sum = J[2] + J[1] + k + J[4] + J[3]

<<"  %V$sum = $J[2] + $J[1] + $k + $J[4] + $J[3] \n"

CheckNum(sum,71)

  sum = k + J[2] + J[1]  + J[4] + J[3]

CheckNum(sum,71)

  sum = J[2] + J[1]  + J[4] + J[3] + k


CheckNum(sum,71)

//CheckNum(sum,72)


CheckOut()
stop!
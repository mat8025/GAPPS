
 dt = 1.0

 alpha = 1.0/240

 tau = dt * (1-alpha)/alpha



<<"$V$dt $alpha $tau \n"

  for (i = 1; i< 500; i++) {

    alpha = 1.0/(i * 1.0)
    tau = dt * (1-alpha)/alpha

<<"%V$i $alpha  $tau \n"


  }


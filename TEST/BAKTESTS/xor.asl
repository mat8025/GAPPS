

j = 1
m = 2
k = 3


  z = j XOR m

<<"XOR %V$z $j $m\n"

  z = j AND m

<<"AND %V$z $j $m\n"


  z = j BXOR m

<<"BXOR %V$z $j $m\n"

  z = j BAND m

<<"BAND %V$z $j $m\n"

// but make ^ pow

  z = k ^ m

<<"^ %V$z $k $m\n"


stop!
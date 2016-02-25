setdebug(1)

N= 10

// XIC error FIXIT
float TA[N*2] 

<<"%(2,, ,\n)$TA\n"


TA[0:-1:2] = vgen(FLOAT,N,0,1) 

<<"%(2,, ,\n)$TA\n"

stop!
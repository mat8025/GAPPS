
N = 1200


float TA[N*2] 

TA[0:-1:2] = vgen(FLOAT,N,0,1) 

TA[481:-1:2] = 1000


<<"%(2,, ,\n)$TA\n"


stop!
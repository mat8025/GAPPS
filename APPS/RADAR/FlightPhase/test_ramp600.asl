
N = 600


float TA[N*2] 

TA[0:-1:2] = vgen(FLOAT,N,0,1) 

TA[481:1081:2] = vgen(FLOAT,300,0,10) 
TA[1081:-1:2] = 3000

<<"%(2,, ,\n)$TA\n"


stop!
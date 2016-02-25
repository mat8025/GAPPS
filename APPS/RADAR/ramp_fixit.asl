
N= 10

float TA[N*2] 
// XIC error FIXIT

TA[0:-1:2] = vgen(FLOAT,N,0,1) 

<<"%(2,, ,\n)$TA\n"


stop!
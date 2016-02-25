
Checkin()

N= 10


float TA[N*2] 

<<"%(2,, ,\n)$TA\n"

checkNum(TA[1],0)


TA[0:-1:2] = vgen(FLOAT_,N,0,1) 

<<"%(2,, ,\n)$TA\n"


checkNum(TA[2],1)

int I[10]

I[2] = 2

checkNum(I[2],2)


CheckOut()



fpm = 1200

N = 600

CT = 300
CRS = fpm/60

float TA[N*2] 

TA[0:-1:2] = vgen(FLOAT,N,0,1) 

TA[481:1081:2] = vgen(FLOAT,CT,0,CRS) 
TA[1081:-1:2] = CT * CRS

<<"%(2,, ,\n)$TA\n"


stop!
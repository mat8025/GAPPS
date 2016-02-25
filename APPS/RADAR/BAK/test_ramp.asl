
N = 900


float TA[N*2] 

TA[0:-1:2] = vgen(FLOAT,N,0,1) 

TA[481:1079:2] = vgen(FLOAT,300,0,10) 
start_cruise_alt =  TA[1079]

TA[1081:1281:2] = 3000

end_cruise_alt =  TA[1281]

TA[1281:1479:2] = vgen(FLOAT,100,3000,-10) 

end_descent_alt = TA[1479]
//TA[1481:-1:2] = TA[1481]
TA[1481:-1:2] = 2000

<<"%(2,, ,\n)$TA\n"
<<"%V$start_cruise_alt $end_cruise_alt $end_descent_alt\n"

stop!
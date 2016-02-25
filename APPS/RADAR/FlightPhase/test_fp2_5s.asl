
// sampling regular at 5 sec intervals

// total time 20 mins
flight_time_mins = 25
total_time = flight_time_mins * 60
ftime = total_time

int ds = 5

N = ftime / ds

spm = 60 / ds

float A[N] 

T = vgen(FLOAT,N,0,ds) 


// climb at 600' min for 5 mins

crate = 600 // feet per min
da = 600/60  * ds

cts = 2 * spm
ns = 5 * spm
cte = cts + ns

<<"%V$cte $cte \n"


A[cts:cte:1] = vgen(FLOAT,ns+1,0,da) 

start_cruise_alt =  A[cte]

ns = 3 * spm

cruise_st = cte 
cruise_end = cte +  ns

// level cruise for 3 mins

A[cruise_st:cruise_end:1] = start_cruise_alt

end_cruise_alt =  A[cruise_end]

ns = 0.5 * spm

// descend @ 600 fpm for  1 min

descent_end = cruise_end + ns




A[cruise_end:descent_end:1] = vgen(FLOAT,ns+1,end_cruise_alt,-da) 

end_descent_alt = A[descent_end]


// level for 7 mins

ns = 7 * spm


A[descent_end:-1:] = end_descent_alt


TA = vZipper(T,A)


<<"%(2,, ,\n)$TA\n"

<<"%V$start_cruise_alt $end_cruise_alt $end_descent_alt\n"

stop!
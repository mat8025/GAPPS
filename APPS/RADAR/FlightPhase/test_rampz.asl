
N = 1000



float A[N] 

T = vgen(FLOAT,N,0,1) 
// climb at 600' min for 5 mins
A[240:540:1] = vgen(FLOAT,301,0,10) 
start_cruise_alt =  A[840]
// level cruise for 2 mins
A[540:660:1] = 3000

end_cruise_alt =  A[660]
// descend @ 600 fpm for 120 secs
A[660:780:1] = vgen(FLOAT,121,3000,-10) 

end_descent_alt = A[780]

// level for 60
A[780:-1:] = end_descent_alt

TA = vZipper(T,A)


<<"%(2,, ,\n)$TA\n"

<<"%V$start_cruise_alt $end_cruise_alt $end_descent_alt\n"

stop!

// sampling regular at 5 sec intervals
// option 5 8 5 8
// input rate


 enum eflight { LEVEL, CLIMB, DESCENT};



// read flight_mode time in pairs

   na = Caz(_clarg)

<<[2]"%V$na \n"

   k = 1
   tot_time = 0
   n_fp = 0

int FM[]
int FT[]
int FR[]

int fmode
int c_rate = 0
initial_alt = 0
ctime = 0


//  read alt if set

    c_type = _clarg[k]
    k++

    wc = pickc(c_type,0)

    if ( wc == 'a') {
      initial_alt = atoi(_clarg[k]) 
<<[2]"setting %V$initial_alt \n"
      k++
    } 
    else
       k = 1  //reset args


    while (k < na) {

    c_type = _clarg[k]
    k++

    wc = pickc(c_type,0)

    if ( wc == 'c') {
//<<"found climb \n"
          FM[n_fp] = CLIMB
    c_time = atoi(_clarg[k]) 
          k++
    c_rate = atoi(_clarg[k]) 
    k++
    }
    else if ( wc == 'l') {
//<<"found level \n"
          FM[n_fp] = LEVEL
    c_time = atoi(_clarg[k]) 
          k++
    c_rate = 0
    }
    else  { 
//<<"found descend \n"
          FM[n_fp] = DESCENT
    c_time = atoi(_clarg[k])
          k++
    c_rate = atoi(_clarg[k]) 
    k++
    }




         FT[n_fp] = c_time
         FR[n_fp] = c_rate
         tot_time += c_time


<<[2]"%V$c_type $c_time $wc\n"
    n_fp++


   }


<<[2]"\n%V$n_fp $tot_time \n"

// total time 20 mins

flight_time_mins = tot_time/60.0

ftime = tot_time

int ds = 5

N = ftime / ds

spm = 60 / ds

N = N +1 

float A[N] 

T = vgen(FLOAT,N,0,ds) 


// climb at 600' min for 5 mins
crate = 600 // feet per min


   fp_s = 0
   fp_e = 0

int cr = 0   // current climb rate
int ca = initial_alt  // current alt


   for (i = 0; i < n_fp ; i++) {



      ns = FT[i] / ds
      fp_e += ns

      <<[2]"%V$i $FM[i] $FT[i] $FR[i] $ns\n"

      da = FR[i]
      da = da/60.0  * ds

      if (FM[i] == CLIMB) {
          cr = da
      }
      else if (FM[i] == DESCENT) {
          cr = -da
      }
      else {
          cr = 0
      }

      A[fp_s:fp_e:1] = vgen(FLOAT,ns+1,ca,cr) 

      fp_s = fp_e
      ca = A[fp_s]
      if (ca < 0.0) {
          ca = 0.0
      }
   }


TA = vZipper(T,A)


<<"%(2,, ,\n)$TA\n"



stop!






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
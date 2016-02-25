
// sampling irregulary at 
// 6 9 6 9  ... secs
// input rate

//int f_i = 6
//int s_i = 9


int f_i = 2
int s_i = 2

int ir[2] = { f_i, s_i }

  enum eflight { LEVEL, CLIMB, DESCENT };



// read flight_mode time in pairs

   na = Caz(_clarg)

//<<[2]"%V$na \n"

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
//<<[2]"setting %V$initial_alt \n"
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


//<<[2]"%V$c_type $c_time $wc\n"
    n_fp++


   }


//<<[2]"\n%V$n_fp $tot_time \n"

// total time 20 mins

flight_time_mins = tot_time/60.0

ftime = tot_time

int ds = ( f_i + s_i )




N = (ftime / ds) * 2

spm = (60 / ds) * 2

N = N 

float A[N] 


 T = vvgen(FLOAT,N,ir,0) 

//<<[2]"%(5,, ,\n)$T \n"



// climb at 600' min for 5 mins

crate = 600 // feet per min


   fp_s = 0
   fp_e = 0

int cr = 0   // current climb rate
int ca = initial_alt  // current alt

ct = f_i + s_i

float air[2] = { f_i, s_i }

   for (i = 0; i < n_fp ; i++) {

      ns = (FT[i] / ct ) * 2

      fp_e += ns

  //    <<[2]"%V$i $FM[i] $FT[i] $FR[i] $ns\n"

      da = FR[i]

      da2 = da/60.0  * s_i

      da = da/60.0  * f_i



      if (FM[i] == CLIMB) {
          cr = da
          cr2 = da2
      }
      else if (FM[i] == DESCENT) {
          cr = -da
          cr2 = -da2
      }
      else {
          cr = 0
          cr2 = 0
      }

//      A[fp_s:fp_e:1] = vgen(FLOAT,ns+1,ca,cr) 

      air[0] = cr
      air[1] = cr2

      A[fp_s:fp_e:1] = vvgen(FLOAT,ns+2, air, ca) 

      fp_s = fp_e
      ca = A[fp_s]
      if (ca < 0.0) {
          ca = 0.0
      }
   }


  TA = vZipper(T,A)


  <<"%(2,, ,\n)$TA[0:-3]\n"


stop!

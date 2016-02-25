

float Alt[]
float Tim[]
float DB[]
float LPDB[]
float FP[]

 k = 0

// so read in Tim and Alt

A = 0  // read on stdio


  R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)

  sz = Caz(R) ;  dmn = Cab(R) ; nrows = dmn[0]; ncols = dmn[1]

<<"%V$sz   $nrows $ ncols \n"

  Tim = R[::][0]
  Alt = R[::][1]



// produce flight-phase 
   lp_delta_baro = 0.0
   delta_baro = 0.0
   B1  = 0.0
   Beta = 0.0
   last_baro = 0.0
   last_tim = 0.0
   flight_phase = 0.0
   int fast_change = 0
   int kfc = 0


  for (i =0 ; i < nrows ; i++) {

      alt = Alt[i]
      tim = Tim[i]      

      delta_baro = alt - last_baro
      last_baro =  alt

// clamp delta_baro 
      if (delta_baro > 10)
          delta_baro = 10

      Beta = 0.01


      lp_delta_baro = lp_delta_baro + Beta * (delta_baro - lp_delta_baro)

      flight_phase = 10 * lp_delta_baro

    if (i < 100) {
      <<[2]"%V$i $alt $tim $delta_baro $lp_delta_baro $B1 $Beta $flight_phase \n"
     }

      DB[i] = delta_baro
      LPDB[i] = lp_delta_baro
      FP[i] = flight_phase
   }


<<[2]"%V$kfc \n"


//<<"%V$k $tim $alt \n"

<<"#col_headings Tim Alt DB LPDB FP \n"


   for (i =0 ; i < nrows ; i++) {

       <<"$Tim[i] $Alt[i] $DB[i] $LPDB[i] $FP[i] \n"

   }


stop!


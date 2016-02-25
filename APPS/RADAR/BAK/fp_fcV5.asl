
openDll("math")


// FlightPhase computation  ----  
// N.B.  has to work with irregular sampled baro-altitudes
//  typically it is 5 sec then 8 sec -- and then 0 sec between inputs


float Alt[]
float Tim[]
float DB[]
float LPDB[]
float FP[]


 enum flightmode { LEVEL, CLIMB, DESCENT} ;


int FPfilter[24]

int CRfilter[3]  // descent/climb mode


//<<"%V$FPfilter \n"

FPfilter->shiftL(7)

//<<"%V$FPfilter \n"

FPfilter->shiftL(120)

//<<"%V$FPfilter \n"

sum = Sum(FPfilter)

ave = sum/ 24.0

mean = Mean(FPfilter)
vave = Ave(FPfilter)

//<<"%V$sum $ave $vave $mean\n"
FPfilter = 0

 k = 0

// so read in Tim and Alt

A = 0  // read on stdio


  R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)

  sz = Caz(R) ;  dmn = Cab(R) ; nrows = dmn[0]; ncols = dmn[1]

//<<"%V$sz   $nrows $ ncols \n"

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
   cr_val = 0.0
   int fast_change = 0
   int kfc = 0

TCR = 200
MCR = 100

spm = 60/5    // 5 sec update

int slew_mins = 2

int full_descent_mode = 0
int slew_to_level_mode = 0

int slew_cnt = slew_mins * spm

int non_descent_mode = 1
int flight_mode = LEVEL
int hold_descent_mode = 0

float hold_descent_flight_phase = 0.0

float slew_descent_flight_phase = 0.0

slew_flight_phase = 0.0

  for (i =0 ; i < nrows ; i++) {

      alt = Alt[i]
      tim = Tim[i]      

      delta_baro = alt - last_baro
      last_baro =  alt

      dsecs = tim - last_tim
      last_tim = tim

      if (dsecs == 0.0)  {
          delta_baro = 0
<<[2]"missed %V$i $tim $last_tim $dsecs \n"
      }

      else  {

          delta_baro = delta_baro * 60.0/dsecs

//<<[2]"OK %V$i $tim $last_tim $dsecs $delta_baro\n"

    // limit delta_baro
    // is TCR 500 a sufficient climb?


        if (delta_baro > TCR) {
            delta_baro = TCR
        }

        if (delta_baro < -TCR) {
            delta_baro = -TCR
        }

        if ((delta_baro < MCR) && (delta_baro > 0)) {
             delta_baro = 0
        }

        if ((delta_baro < 0) && (delta_baro > -MCR)) {
             delta_baro = 0
        }


// 240 is about right

       Beta = dsecs/ (240)


// low pass -- change in  filter output proportional to difference beteen current and last input
 
      lp_delta_baro = lp_delta_baro + Beta * (delta_baro - lp_delta_baro)
  


      CRfilter->shiftL(delta_baro)

      FPfilter->shiftL(delta_baro)

      flight_phase = Ave(FPfilter)

      ave_cr_val = Ave(CRfilter)  // short-term ave to determine flight path


      cr_val = ave_cr_val  * 0.005  // for 200'

//<<[2]"$CRfilter %V$ave_cr_val $cr_val\n"





//<<"%V$FPfilter \n"

     flight_phase = flight_phase  * 0.005  // for 200'

//<<"%V$flight_phase \n"

     // flight_phase = lp_delta_baro  * 0.002  // for 500'

    //   flight_phase = lp_delta_baro  * 0.001  // for 1000'





     if (flight_phase > 1.0) {
            flight_phase = 1.0
     }

     if (flight_phase < -1.0) {
            flight_phase = -1.0
     }


//  check if we have started a climb or descent

      if (cr_val >= 0.1) {


          if (flight_mode == DESCENT) {

//              hold_descent_flight_phase = flight_phase

<<[2]"setting hold mode from CLIMB transition %V$flight_phase\n"

                hold_descent_mode = 60 // for our five min countdown
          }

          flight_mode = CLIMB


      }
      else if (cr_val < -0.75) {

            if (flight_mode == DESCENT) {
            
<<[2]"updating %V$hold_descent_flight_phase to $flight_phase\n"
             hold_descent_flight_phase = flight_phase   // when we transistion - hold the last descent flight phase  
            }

            flight_mode = DESCENT

      }
      else {

          if (flight_mode == DESCENT) {
  
<<[2]"setting hold_mode from LEVEL transition %V$flight_phase\n"
            hold_descent_mode = 60 // for our five min countdown
          }

         flight_mode = LEVEL

      }





     
      if ((flight_mode == DESCENT)  && (hold_descent_mode > 0)) {

                FPfilter = (hold_descent_flight_phase * 200)

<<[2]"new  DESCENT during hold %V$hold_descent_flight_phase  $flight_phase \n"             
                flight_phase = hold_descent_flight_phase 

                // now cancel hold since we have entered a new descent
                hold_descent_mode = 0
      }

       


      if ((flight_mode != DESCENT)  && (hold_descent_mode > 0)) {

// we have levelled off or are climbing -- but we were previously in steady descent
// so use hold_descent_flight_phase for five mins

          hold_descent_mode--



        flight_phase = hold_descent_flight_phase   // hold it at the last descent_flight_phase -- until five (hold time) mins is up

//<<[2]"%V$hold_descent_mode $flight_phase\n"

        if (hold_descent_mode == 0) {      // now transition to slew_to_level_mode
            slew_to_level_mode = slew_cnt  // and slew to flight-phase zero in 2 mins
            slew_descent_flight_phase = hold_descent_flight_phase
            slew_flight_phase = slew_descent_flight_phase
        }






      }


      if (slew_to_level_mode > 0) {

        if (flight_mode == DESCENT) {
     
            if (slew_flight_phase < flight_phase) {
                  flight_phase = slew_flight_phase
                  // reset FPfilter
                  FPfilter = (slew_flight_phase * 200)
                  slew_to_level_mode = 0
            }
        }
        else {

        slew_flight_phase = slew_descent_flight_phase * (1 - (slew_cnt - slew_to_level_mode)/(slew_cnt * 1.0)) 

        flight_phase = slew_flight_phase

//<<[2]"%V$slew_to_level_mode $flight_phase\n"


        slew_to_level_mode--

        if (slew_to_level_mode == 0) {
             // regardless of whether we were climbing now flush long-term average buffer 
             // so flight-phase we be zero
             FPfilter = 0
        }

        }



      }


     // check and limit flight phase
     if (flight_phase > 1.0) {
            flight_phase = 1.0
     }

     if (flight_phase < -1.0) {
            flight_phase = -1.0
      }

//      <<[2]"$tim $alt $delta_baro $lp_delta_baro $flight_phase \n"

      FP[i] = flight_phase

      DB[i] = delta_baro

      LPDB[i] = lp_delta_baro  // not using this at the moment
 

/{
    if (i < 1000) {
      <<[2]"%V$i $alt $tim $delta_baro $lp_delta_baro $B1 $Beta $flight_phase \n"
      <<[2]"$Tim[i] $Alt[i] $DB[i] $LPDB[i] $FP[i] \n"
     }
/}


    }


   }



<<[2]"%V$kfc \n"


//<<"%V$k $tim $alt \n"

<<"#col_headings Tim Alt DB LPDB FP \n"


   for (i =0 ; i < nrows ; i++) {

       <<"$Tim[i] $Alt[i] $DB[i] $LPDB[i] $FP[i] \n"

   }


stop!


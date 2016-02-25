
openDll("math")


// FlightPhase computation  ----  
// N.B.  has to work with irregular sampled baro-altitudes
//  typically it is 5 sec then 8 sec -- and then 0 sec between inputs
//  this version to deal with irregular input samples


enum flightmode { LEVEL, CLIMB, DESCENT} ;


proc checkFlightMode ( crv)
{

int fmode = LEVEL;

         if (crv >= Climb_mode_threshold) { // we have a climb
             fmode = CLIMB;
         }
         else if (cr_val < Descent_mode_threshold ) {  // definite descent
             fmode = DESCENT;
         }
         else {
             fmode = LEVEL;

         }
<<[2]" new flight mode $fmode \n"
      return fmode 
}

proc limitVal( val, min, max)
{
   if (val < min) {
        val = min
   }
   else if (val > max) {
        val = max
   }
    return val
}



float Alt[]
float Tim[]
float DB[]

float FP[]




//   5 sec interval thus for our 2 min slew time
//int FPfilter[24]


int FPfilter[120]   // we can't assume fixed intervals so we will interpolate to sec interval

int CRtrend[3]  // descent/climb mode


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
CRtrend = 0

 k = 0

// so read in Tim and Alt

A = 0  // read on stdio


  R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)

  sz = Caz(R) ;  dmn = Cab(R) ; nrows = dmn[0]; ncols = dmn[1]

//<<"%V$sz   $nrows $ ncols \n"

  Tim = R[::][0]
  Alt = R[::][1]



// produce flight-phase 

   delta_baro = 0.0

   last_baro = 0.0
   last_tim = 0.0
   flight_phase = 0.0
   cr_val = 0.0
   int fast_change = 0
   int kfc = 0


Max_flight_phase = 1.0
Min_flight_phase = -1.0


TCR = 100.0
MCR = 100  // dead-band

// TBD -- make climb hold mode -- so symmetrical with descent

TCR_scale = 1.0/ TCR

float Climb_mode_threshold = 0.25
float Descent_mode_threshold = -0.75

float slew_mins = 2.0
float hold_descent_mins = 5.0
float hold_climb_mins = 5.0

int full_descent_mode = 0

int non_descent_mode = 1;
int flight_mode = LEVEL;
int hold_mode = 0;
int hold_descent_mode = 0; // initial
int hold_climb_mode = 0;

int hold_descent_secs  = hold_descent_mins * 60;
int hold_climb_secs  = hold_climb_mins * 60;

float hold_flight_phase = 0.0;

int max_flight_phase_reached = 0;
int min_flight_phase_reached = 0;
float dsecs = 0.0

// we don't know at what intervals the flight-phase calculation occur -- i.e. variable deltas
// so measure the time between cycles and then effectively interpolate so it 'runs' every second
// also if we do have samples below 5 Hz - don't go to hold_mode unless we see a climb/descend for 30 secs?

last_baro = Alt[i];

  for (i =0 ; i < nrows ; i++) {

      alt = Alt[i] ;
      tim = Tim[i]  ;    

      delta_baro = alt - last_baro;
      last_baro =  alt;

      dsecs = tim - last_tim;
      last_tim = tim ;

      if (dsecs <= 0.0)  {
          delta_baro = 0;
<<[2]"missed %V$i $tim $last_tim $dsecs \n";
      }

      else  {

          delta_baro = delta_baro * 60.0/dsecs;

//<<[2]"OK %V$i $tim $last_tim $dsecs $delta_baro\n"

    // limit delta_baro
    // is TCR 500 a sufficient climb?


        // dead-band +/- 100
        if ((delta_baro < MCR) && (delta_baro > -MCR)) {
             delta_baro = 0;
        }
        else {
          delta_baro = limitVal(delta_baro,-TCR,TCR)
        }

      CRtrend->shiftL(delta_baro) ;


      if (!hold_mode) { 
        FPfilter->shiftL(delta_baro,dsecs)   // shift in delta_baro dsecs times i.e. duplicate so we weight correctly depending on dsecs
      }

      flight_phase = Ave(FPfilter);

      ave_cr_val = Ave(CRtrend) ; // short-term ave to determine flight path using three consecutive samples

      cr_val = ave_cr_val  * TCR_scale ;  // scale for 200'


//<<[2]"$CRtrend %V$ave_cr_val $cr_val\n"


//<<"%V$FPfilter \n"

     flight_phase = flight_phase  * TCR_scale ;  // 

<<[2]"$i $tim %V$flight_mode $hold_mode $hold_descent_mode $hold_climb_mode  $delta_baro $cr_val $flight_phase\n" ;


//<<"%V$flight_phase \n"

     flight_phase = limitVal(flight_phase,Min_flight_phase, Max_flight_phase)



    // what is our flight_mode ?

      new_flight_mode = checkFlightMode(cr_val);



           switch (new_flight_mode) {

                  case CLIMB:

                   if (flight_mode == DESCENT) { // previous mode was a descent - so we want to use that previous flight-phase

                   <<[2]"setting descent hold mode from CLIMB transition %V$flight_phase\n"
                     if (min_flight_phase_reached ) {
                      flight_phase = Min_flight_phase;
                     }
                     hold_descent_mode =  hold_descent_secs ; // for our hold countdown
                     min_flight_phase_reached = 0;

                   }
                  else if (flight_mode == CLIMB) { 
                   if (flight_phase >= Max_flight_phase) {
                      max_flight_phase_reached = 1;
                   }
                   if (max_flight_phase_reached ) {
                    flight_phase = Max_flight_phase;
                   }

                    hold_flight_phase = flight_phase;   // when we transistion level - hold the last climb flight phase  
                    hold_mode = 0;
                   }


                  flight_mode = CLIMB;

                   <<[2]"setting flight_mode to CLIMB transition %V$i $delta_baro $flight_phase $cr_val\n"
                  break;
               case DESCENT:
      
                  if (flight_mode == DESCENT) {

                   <<[2]"updating %V$hold_flight_phase to $flight_phase $min_flight_phase_reached \n"

                  if (min_flight_phase_reached) {
                      flight_phase = Min_flight_phase ; // should be sticky as long as in descent mode
                   <<[2]"setting %V$flight_phase to min \n"
                  }
 

                   hold_flight_phase = flight_phase;   // when we transistion - hold the last descent flight phase  
                   hold_climb_mode = 0;
                   hold_mode = 0;

                   if (flight_phase <= Min_flight_phase) {
                         min_flight_phase_reached = 1;
                   <<[2]" %V$min_flight_phase_reached\n"
                   }

                  }

                  flight_mode = DESCENT;
                 break;
               case LEVEL:
                   // we are level or less than 100 climb/descent rate
         
                    if (flight_mode == DESCENT) {

                     if (min_flight_phase_reached ) {
                        flight_phase = Min_flight_phase;
                     }

                     <<[2]"setting descent hold_mode from LEVEL transition %V$flight_phase  $min_flight_phase_reached \n"
 
                      if (flight_phase > 0.0) {
                      // reset FPfilter to current flight_phase
                       FPfilter = (flight_phase * TCR);   //
                      }

                     if (flight_phase < 0.0) {
                      hold_descent_mode = hold_descent_secs; // for our hold countdown
                      hold_mode = 1;
                      hold_flight_phase = flight_phase;

                      FPfilter = (hold_flight_phase * TCR);   // vector set
                      min_flight_phase_reached = 0;
                      }

                       hold_climb_mode = 0;

                      }

                      if (flight_mode == CLIMB) {

                          if (flight_phase > 0.0) {
                           hold_climb_mode = hold_climb_secs; // for our hold countdown
                           }

                         hold_flight_phase = flight_phase;
       
                        if (max_flight_phase_reached == 1) {
                          hold_flight_phase = Max_flight_phase;
                          flight_phase = Max_flight_phase;
                          max_flight_phase_reached =0;
                         }

                        <<[2]"setting hold_climb_mode from LEVEL transition %V$flight_phase $cr_val\n"

                       }

                        flight_mode = LEVEL;
                      break;
                 }






               if ((flight_mode == DESCENT)  && (hold_descent_mode > 0)) {

                   FPfilter = (hold_flight_phase * TCR);   // vector set

                  <<[2]"new  DESCENT during hold %V$hold_flight_phase  $flight_phase \n"             

                   flight_phase = hold_flight_phase ;
                    // now cancel descent hold since we have entered a new descent
                    hold_mode = 0 ;
                    hold_descent_mode = 0;
                 }


     
              if ((flight_mode != DESCENT)  && (hold_descent_mode > 0)) {

              // we have levelled off or climbing -- but we were previously in steady descent
              // so use hold_flight_phase for hold_descent mins

                hold_mode = 1;
                hold_descent_mode -= dsecs;
                flight_phase = hold_flight_phase;   // hold it at the last descent_flight_phase -- until hold mins is up

                //<<[2]"%V$hold_descent_mode $flight_phase\n"

                 if (hold_descent_mode <= 0) {      // now transition to slew_to_level_mode
                  FPfilter = (hold_flight_phase * TCR);   // vector set
                  hold_mode = 0;
                 }

               }



             if ((flight_mode == LEVEL)  && (hold_climb_mode > 0)) {

                // we have levelled off -- but we were previously in steady climb
                // so use hold_climb_flight_phase for hold_climb_mins

                 hold_mode = 1;
                 hold_climb_mode -= dsecs
                 flight_phase = hold_flight_phase;   // hold it at the last hold_flight_phase -- until hold mins are up


                if (hold_climb_mode <= 0) {      // now transition to slew_to_level_mode

                 FPfilter = (hold_flight_phase * TCR)   // vector set
                 hold_flight_phase = 0.0;
                 hold_mode = 0;
                }

               }


     // double check and limit flight phase

     flight_phase = limitVal(flight_phase,Min_flight_phase, Max_flight_phase)

//      <<[2]"$tim $alt $delta_baro  $flight_phase \n"

      FP[i] = flight_phase;

      DB[i] = delta_baro;
 

//    if (i < 1000) {
//      <<[2]"%V$i $alt $tim $delta_baro   $flight_phase \n"
//      <<[2]"$Tim[i] $Alt[i] $DB[i]  $FP[i] \n"
//     }

    }

   }



<<[2]"%V$kfc \n";


//<<"%V$k $tim $alt \n"

<<"#col_headings Tim Alt DB  FP \n"


   for (i =0 ; i < nrows ; i++) {

       <<"$Tim[i] $Alt[i] $DB[i] $FP[i] \n";
   }


stop!

////////////////  TBD ///////
/{

  can we do we just hold_flight_phase ?  --- yes

  factor to slew descent or climb faster separately ?

  CRtrend filter --- 3 steps to qualify flight mode 

  climb descent CR thresholds ?  tuned ? adaptive ?

  do a C program to validate --- easy export to sim 2100


/}
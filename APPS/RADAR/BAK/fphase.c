
#include <stdio.h>
#include <fcntl.h>
 




enum flightmode { LEVEL, CLIMB, DESCENT} ;
#define FPFSIZE 120
#define CRSIZE 3

static float ave (int *vec , int n)
{
   float ave = 0.0;
   int i;
   if (n > 0) {
   for ( i =0; i < n ; i++)
     ave += vec[i];
     ave /= (float) n;

   }
   return  ave ;
}


static void
shiftL(int *vec, int n, int val, int n_shift)
{

  int i,j;
   for (j = 0; j < n_shift; j++) {
    for (i = 0; i < n-1; i++) {
       vec[i] = vec[i+1];
    }
       vec[n-1] = val;
    }

}

static void
vecFill(int *vec, int n, float val)
{
int i;
    for (i = 0; i < n; i++)
       *vec++ = val;

}

FILE *logfile;


// time in secs   alt in feet computes flight_phase

void
calcFlightPhase(int tim, float alt,  float *the_flight_phase)


{
 static uint  fpcnt = 0;
 static int FPfilter[FPFSIZE];     // we can't assume fixed intervals so we will interpolate to sec interval
 static int CRtrend[CRSIZE];  // descent/climb mode

 static float  last_baro = 0.0;
 static int  last_tim = 0;
 static int  e_tim = 0;


 static int max_flight_phase_reached = 0;
 static int min_flight_phase_reached = 0;
 static int flight_mode = LEVEL;
 static int hold_mode = 0 ;
 static int hold_descent_mode = 0 ;// initial
 static int hold_climb_mode = 0 ;
 static float hold_flight_phase = 0.0 ;

 float  flight_phase;
 int dsecs;
 float  delta_baro = 0.0;
 float  delta_alt_fpm = 0.0;
 float  cr_val = 0.0;
 float  ave_cr_val;
 float Max_flight_phase = 1.0;
 float Min_flight_phase = -1.0;
 float TCR = 200.0; // any climb rate that exceeds this is limited to this threshold climb rate
 float TCR_scale = 1.0/ TCR; // used to scale filter values to give flight-phase in range -1.0/1.0
 float MCR = 100;  // minimum climb rate dead-band
 float Climb_mode_threshold = 0.25 ;
 float Descent_mode_threshold = -0.75 ;
 float slew_mins = 2.0 ;
 float hold_descent_mins = 5.0  ;  //  our current hold times are 5 mins could be variable
 float hold_climb_mins = 5.0 ;     //

 int hold_descent_secs  = hold_descent_mins * 60 ;  // making it effectively run every sec -- even input samples are irregular
 int hold_climb_secs  = hold_climb_mins * 60 ;

// we don't know at what intervals the flight-phase calculation occur -- variable deltas
// so measure the time between cycles and then effectively interpolate so it 'runs' every second
// also if we do have samples below 5 Hz - don't go to hold_mode unless we see a climb/descend for 30 secs?

//  alt = flight_pta->baro_alt;
//  tim = flight_pta->secs;    // can we make this seconds from midnight - then don't need this hrs,mins,secs stuff


      if (fpcnt == 0) {
       logfile = fopen("wx1_debug.txt","w");
       last_baro =  alt;
       last_tim = tim;

      }
      fpcnt++;


      delta_baro = alt - last_baro;
      last_baro =  alt;

      dsecs = tim - last_tim ;
      e_tim += dsecs;

      last_tim = tim  ;

      if (dsecs == 0)  {
          delta_baro = 0 ;
      }

      else  {

          delta_baro = delta_baro * 60.0/ (float) dsecs;


        delta_alt_fpm = delta_baro;

    // limit delta_baro
    // is TCR 100 fpm a sufficient climb?  -- range likely to be 500 -- 3000 fpm

        if (delta_baro > TCR) {
            delta_baro = TCR ;
        }

        if (delta_baro < -TCR) {
            delta_baro = -TCR ;
        }

        if ((delta_baro < MCR) && (delta_baro > -MCR)) {
             delta_baro = 0 ;
        }


      //  CRtrend->shiftL(delta_baro,1) ;  // shiftL provided above
	shiftL(CRtrend, CRSIZE,(int) delta_baro,1);

      if (!hold_mode) {
	  shiftL(FPfilter,FPFSIZE,(int) delta_baro,dsecs);
      }

      flight_phase = ave(FPfilter,FPFSIZE);  // int vector average

      ave_cr_val = ave(CRtrend, CRSIZE);  // short-term ave to determine flight path using three consecutive samples

      cr_val = ave_cr_val  * TCR_scale;  // 

      flight_phase = flight_phase  * TCR_scale ;  // 

     if (flight_phase > Max_flight_phase) {
            flight_phase = Max_flight_phase ;
     }

     if (flight_phase < Min_flight_phase) {
            flight_phase = Min_flight_phase ;
     }

    // what is our flight_mode ?

      if (cr_val >= Climb_mode_threshold) { // we have a climb

          if (flight_mode == DESCENT) { // previous mode was a descent - so we want to use that previous flight-phase

//"setting hold mode from CLIMB transition flight_phase\n"
           if (min_flight_phase_reached ) {
                   flight_phase = Min_flight_phase;
           }
           hold_descent_mode =  hold_descent_secs; // for our hold countdown
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
             hold_mode = 0 ;
        }

          flight_mode = CLIMB;
//"setting flight_mode to CLIMB transition %V$i $delta_baro $flight_phase $cr_val\n"
      }
      else if (cr_val < Descent_mode_threshold ) {  // definite descent

            if (flight_mode == DESCENT) {

//"updating %V$hold_descent_flight_phase to $flight_phase\n"

            if (min_flight_phase_reached) {
                flight_phase = Min_flight_phase ; // should be sticky as long as in descent mode
             }

             hold_flight_phase = flight_phase;   // when we transistion - hold the last descent flight phase
             hold_climb_mode = 0 ;
             hold_mode = 0 ;

             if (flight_phase <= Min_flight_phase) {
                 min_flight_phase_reached = 1;
             }

             }

            flight_mode = DESCENT;
      }
      else {  // LEVEL

          // we are level or less than 100 climb/descent rate
         
          if (flight_mode == DESCENT) {

// fprintf("setting hold_mode from LEVEL transition %V$flight_phase\n"
           if (min_flight_phase_reached ) {
                   flight_phase = Min_flight_phase;
           }

           if (flight_phase > 0.0) {
              // reset FPfilter to current flight_phase
               vecFill(FPfilter, FPFSIZE, (flight_phase * TCR));

           }

           if (flight_phase < 0.0) {
               hold_descent_mode = hold_descent_secs ;// for our hold countdown
               hold_mode = 1 ;
               hold_flight_phase = flight_phase;
               vecFill(FPfilter, FPFSIZE, (flight_phase * TCR));
               min_flight_phase_reached = 0;
            }
            hold_climb_mode = 0 ;
          }

          if (flight_mode == CLIMB) {

            if (flight_phase > 0.0) {
              hold_climb_mode = hold_climb_secs; // for our hold countdown
            }

            hold_flight_phase = flight_phase ;

           if (max_flight_phase_reached == 1) {
             hold_flight_phase = Max_flight_phase;
             flight_phase = Max_flight_phase;
             max_flight_phase_reached =0 ;
            }

//fprintf(logfile,"setting hold_climb_mode from LEVEL transition %V$flight_phase $cr_val\n" );
          }
         flight_mode = LEVEL ;
      }

         if ((flight_mode == DESCENT)  && (hold_descent_mode > 0)) {

              //  FPfilter = (hold_descent_flight_phase * TCR) ;  // vector set
                  vecFill(FPfilter, FPFSIZE, (hold_flight_phase * TCR));
//<<[2]"new  DESCENT during hold %V$hold_descent_flight_phase  $flight_phase \n"

                flight_phase = hold_flight_phase ;
                // now cancel descent hold since we have entered a new descent
                hold_mode = 0 ;
                hold_descent_mode = 0 ;

      }

      if ((flight_mode != DESCENT)  && (hold_descent_mode > 0)) {

// we have levelled off or climbing -- but we were previously in steady descent
// so use hold_descent_flight_phase for hold_descent mins

         hold_mode = 1;
         hold_descent_mode -= dsecs ;

         flight_phase = hold_flight_phase ;  // hold it at the last descent_flight_phase -- until hold mins is up

//<<[2]"%V$hold_descent_mode $flight_phase\n"

        if (hold_descent_mode <= 0) {      // now transition to slew_to_level_mode

            vecFill(FPfilter, FPFSIZE, (hold_flight_phase * TCR));
            hold_mode = 0;
        }

      }



      if ((flight_mode == LEVEL)  && (hold_climb_mode > 0)) {

// we have levelled off -- but we were previously in steady climb
// so use hold_climb_flight_phase for hold_climb_mins

         hold_mode = 1 ;
         hold_climb_mode -= dsecs ;
                        // set to last hold_flight_phase --

         flight_phase = hold_flight_phase ;  // hold it at the last hold_flight_phase -- until hold mins is up


        if (hold_climb_mode <= 0) {      // now transition to slew_to_level_mode

            vecFill(FPfilter, FPFSIZE, (hold_flight_phase * TCR));
            hold_flight_phase = 0.0;
            hold_mode = 0;
        }

      }

 fprintf(logfile,"tim %d dsecs %d d_alt_fpm %6.1f %d hold_mode %d flight_mode %d cr_val %6.2f hold_fp %6.2f flt_phs %6.2f\n",
           e_tim, dsecs, delta_alt_fpm, hold_mode,flight_mode, cr_val, hold_flight_phase, flight_phase);

     // finally  double check and limit flight phase
     if (flight_phase > Max_flight_phase) {
            flight_phase = Max_flight_phase ;
     }

     if (flight_phase < Min_flight_phase) {
            flight_phase = Min_flight_phase ;
     }

      *the_flight_phase == flight_phase;

     }

}




int main ()
{


  // read in a txt file with rows of  time alt







  // output test   rows of time alt fphase ...


}


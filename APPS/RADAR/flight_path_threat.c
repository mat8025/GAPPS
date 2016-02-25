// flight_path_threat_assessment
#include <stdlib.h>
#include <math.h>
#include "flight_path_threat.h"
#include "defines.h"
#include "units.h"
#include "radar.h"


// TMP for force flight_phase via GUI
#include "gui_var_init.h"

void initFlightPathThreat(FLIGHT_PATH_THREAT_TYPE *fpta)
{
 static int init_fpta = 1; //  init the flight_path_threat variables
 if (init_fpta) {
 fpta->descent_gain = 2.0;
 fpta->climb_gain = 2.0;
 fpta->thres_gain_min = DISPLAY_THRES_ADJ_MIN;
 fpta->thres_gain_max = DISPLAY_THRES_ADJ_MAX;
 fpta->flight_phase = 0.0;
 fpta->display_thres_adj = 0.0;
 init_fpta = 0;
  fpta->hrs = 0;
  fpta->mins = 0;
  fpta->secs = 0;
 }
}

#if 0
void setFlightPathThreat(FLIGHT_PATH_THREAT_TYPE *fpta, int hrs, int mins, int secs, int air_gnd_disc)
{
 // time diff in secs
 int dsecs = 0;
 int dmins = 0;
 // assume hrs for now  doesnot not wrap around 12 or 24
 if (hrs != fpta->hrs) {
      dmins = ((60 - fpta->mins + mins) + ((hrs-fpta->hrs -1) * 60));
 }
      dsecs = dmins * 60;

 if (mins == fpta->mins)
      dsecs += (secs - fpta->secs);
 else {
      dsecs += ((60 - fpta->secs + secs) + ((mins-fpta->mins -1) * 60));
  }

   fpta->hrs = hrs;
   fpta->mins = mins;
   fpta->secs =  secs;
    fpta->dsecs =  dsecs;

    // and air_gnd
   fpta->air_gnd_disc =  air_gnd_disc;

}
#endif

void checkFPTAgain(FLIGHT_PATH_THREAT_TYPE *fpta)
{
 fpta->display_thres_adj = (fpta->display_thres_adj > fpta->thres_gain_max) ?
                fpta->thres_gain_max : fpta->display_thres_adj;

 fpta->display_thres_adj = (fpta->display_thres_adj < fpta->thres_gain_min) ?
                fpta->thres_gain_min : fpta->display_thres_adj;
}

void flight_path_threat_assess(FLIGHT_PATH_THREAT_TYPE  *fpta)
{
 // clouds in the way
 float thres_adjust = 0.0;

   if (fpta->flight_phase <= 0.0) {
        fpta->display_thres_adj = fpta->descent_gain * fpta->flight_phase;
   }
   else {
        fpta->display_thres_adj = fpta->climb_gain  *  fpta->flight_phase;

   }

   // check max/min
    checkFPTAgain(fpta);

}

float ave (float *vec , int n)
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

int timeDiff(int ohrs, int omins, int osecs, int nhrs, int nmins, int nsecs)
{
 int dsecs = 0;
 int dmins = 0;
 // assume hrs for now  doesnot not wrap around 12 or 24
 if (ohrs != nhrs) {
      dmins = ((60 - omins + nmins) + ((ohrs-nhrs -1) * 60));
 }
      dsecs = dmins * 60;

 if (omins == nmins)
      dsecs += (nsecs - osecs);
 else {
      dsecs += ((60 - osecs + nsecs) + ((nmins-omins -1) * 60));
  }

  return dsecs;


}

// TMP GUI
extern float Panel_flight_phase;


void
calcFlightPhase(FLIGHT_PATH_THREAT_TYPE *flight_pta )
{
//  low-pass/smooth baro_alt  and calculate flight_phase
//  -1 descent 0 cruise   1 climb
//   500' descent  or greater per min for 40 secs ? --- flight_phase should be <= -1
//   500' climb  ...  flight_phase should be 1.0



   static int dbaro_sweep = 0;

   static int n_50fmin_change = 0; // MAT debug lp_delta_baro
   static float dbaro_pmin[10];
   static int dbaro_k = 0;
   static int use_dbaro_pmin = 0;
   float dbaro_ave;
   //
   float raw_flight_phase;
   float raw_flight_phase_ave;
   float baro_alt;
   float delta_baro_per_min = 0;
   static  float last_baro =0.0;
   static  float lp_delta_baro = 0.0;
   static int fast_change_cntr = 0;
   float Beta;
   float B1;
   float daf;
   float loc_flight_phase;
   static int last_hrs = 0;
   static int last_mins = 0;
   static int last_secs = 0;
   int dsecs;
   if (logfile == NULL) {

   
    logfile = fopen("wx1_debug.txt","w");
    fprintf(logfile,"db_sweep time dsecs scan_cnt baro_alt delta_baro_min dbaro_ave raw_ave_fp lp_delta_baro raw_fp n50fm fltphase \n");


   }
   baro_alt = flight_pta->baro_alt;

   if (dbaro_sweep == 0) {
      last_baro =  baro_alt;
      lp_delta_baro = 0;
      fast_change_cntr = 0;

    }


    dsecs= timeDiff(last_hrs, last_mins, last_secs, flight_pta->hrs, flight_pta->mins, flight_pta->secs);

              last_hrs  = flight_pta->hrs;
              last_mins = flight_pta->mins;
              last_secs = flight_pta->secs;
            if (dsecs != 0)
            delta_baro_per_min =  ( (baro_alt - last_baro) / (float) dsecs)  * 60 ;

            last_baro = baro_alt;

            // using averaging filter
            dbaro_pmin[dbaro_k++] = delta_baro_per_min; // we are in feet per min
            if (dbaro_k >= 10) {
                dbaro_k = 0;
                use_dbaro_pmin =1;
            }


            if (use_dbaro_pmin)
             dbaro_ave = ave(dbaro_pmin,10);
            else
             dbaro_ave = 0.0;

            if ((lp_delta_baro * delta_baro_per_min) < 0)
               fast_change_cntr += 1;
            else
               fast_change_cntr -= 1;


              B1 = (dsecs * 4.16667e-3f);

             // now a divide by 16
              B1 *= 0.0625;

           fast_change_cntr = min(max(fast_change_cntr,4),0);

           if (fast_change_cntr > 4)
                 Beta = B1 * 4.0 ;
           else
                 Beta = B1;


            if(flight_pta->air_gnd_disc == GND)
               Beta *= 8;
            else if(fast_change_cntr > 4)
               Beta *= 4;

           // fp_calc->beta = Beta; // Test
           // fp_calc->lp_delta_baro = lp_delta_baro;

            lp_delta_baro = lp_delta_baro + Beta * (delta_baro_per_min - lp_delta_baro);

            daf = fabs(dbaro_ave);
            if ( daf > 50) {
                   n_50fmin_change++;

            }

            // so a lowpass of lp_delta_baro of >= 500'  descent a min?  gives flight_phase -1

            raw_flight_phase = (float)(lp_delta_baro ) * 2e-3;
            raw_flight_phase_ave = dbaro_ave * 2e-3;
            // limit to -1 full descent to 1 max climb
            loc_flight_phase = min(max(raw_flight_phase_ave,-1.0),1.0);

            //fp_calc->raw_flight_phase = raw_flight_phase;

            flight_pta->flight_phase = loc_flight_phase;

 // MAT test  -- can we hook up an input on the GUI for this?
 //           flight_pta->flight_phase = -0.9;




            if (logfile != NULL) {

fprintf(logfile,"%d %s %d %d %6.1f %6.2f %6.2f %6.2f %6.2f %6.2f %d %6.2f\n",
  dbaro_sweep++, flight_pta->time_string,dsecs,flight_pta->scan_cnt, baro_alt,
          delta_baro_per_min, dbaro_ave, raw_flight_phase_ave,  lp_delta_baro, raw_flight_phase, n_50fmin_change, loc_flight_phase);



          fflush(logfile);
           }

           // DEBUG force via gui

           if (Use_PanelFlightPhase) {
             flight_pta->flight_phase = Panel_flight_phase;
           }

           // GUI var
           theFlightPhase = flight_pta->flight_phase;

}


//////////////////////////////////////////////////////////////////////////////////
/// utilities for calcFlightPhase




void
shiftL(float *vec, int n, float val, int n_shift)
{

  int i,j;
   for (j = 0; j < n_shift; j++) {
    for (i = 0; i < n-1; i++) {
       vec[i] = vec[i+1];
    }
       vec[n-1] = val;
    }

}

void
vecFill(float *vec, int n, float val)
{
int i;
    for (i = 0; i < n; i++)
       *vec++ = val;

}

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:
**
** Syntax:    void calcFlightPhaseVT    (FLIGHT_PATH_THREAT_TYPE *flight_pta)
**
** Description:   FlightPhase computation  ----
** N.B.  has to work with irregular sampled baro-altitudes
**  typically it is 5 sec then 8 sec -- since it is called at the end of the sweep
**  consider calling after n epochs so the sampling rate is about 2 Hz
**  version to deal with irregular input samples
**
**
**
** Returns:
**
** Algorithm:
**
** Special Notes:
** $Id$
**.EH-------------------------------------------------------------------------
*/
enum flightmode { LEVEL, CLIMB, DESCENT} ;
#define FPFSIZE 120
#define CRSIZE 3

void
calcFlightPhaseVT(FLIGHT_PATH_THREAT_TYPE *flight_pta )
{

 static uint  fpcnt = 0;
 static float alt = 0.0;
 static int tim = 0;
 static int FPfilter[FPFSIZE];     // we can't assume fixed intervals so we will interpolate to sec interval
 static int CRtrend[CRSIZE];  // descent/climb mode

 static float  last_baro = 0.0;
 static int  last_tim = 0;
 static int  e_tim = 0;
 static float  flight_phase = 0.0;

 static int full_descent_mode = 0 ;
 static int slew_to_level_mode = 0 ;
 static int max_flight_phase_reached = 0;
 static int min_flight_phase_reached = 0;
 static int flight_mode = LEVEL;
 static int hold_mode = 0 ;
 static int hold_descent_mode = 0 ;// initial
 static int hold_climb_mode = 0 ;
 static int slewing_from_climb = 0;
 static int slewing_from_descent = 0;
 static float hold_descent_flight_phase = 0.0 ;
 static float hold_climb_flight_phase = 0.0 ;
 static float hold_flight_phase = 0.0 ;

 static float slew_descent_flight_phase = 0.0;  // CHECK need this ?
 static float slew_climb_flight_phase = 0.0 ;
 static float slew_flight_phase = 0.0;
 // check can't we get secs from midnight ??
 static int last_hrs = 0;
 static int last_mins = 0;
 static int last_secs = 0;

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

 int slew_cnt = slew_mins * 60 ; // making it effectively run every sec -- even input samples are irregular

int non_descent_mode = 1;


int hold_descent_secs  = hold_descent_mins * 60 ;
int hold_climb_secs  = hold_climb_mins * 60 ;





// we don't know at what intervals the flight-phase calculation occur -- variable deltas
// so measure the time between cycles and then effectively interpolate so it 'runs' every second
// also if we do have samples below 5 Hz - don't go to hold_mode unless we see a climb/descend for 30 secs?

      alt = flight_pta->baro_alt;
      tim = flight_pta->secs;    // can we make this seconds from midnight - then don't need this hrs,mins,secs stuff


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
#if 0
      dsecs= timeDiff(last_hrs, last_mins, last_secs, flight_pta->hrs, flight_pta->mins, flight_pta->secs);

              last_hrs  = flight_pta->hrs;
              last_mins = flight_pta->mins;
              last_secs = flight_pta->secs;
#endif

      last_tim = tim  ;

      if (dsecs == 0)  {
          delta_baro = 0 ;

      }

      else  {

          delta_baro = delta_baro * 60.0/ (float) dsecs;



    // limit delta_baro
    // is TCR 500 a sufficient climb?
         delta_alt_fpm = delta_baro;

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
           shiftL(CRtrend, CRSIZE, delta_baro,1);

      if (!hold_mode) {
        //FPfilter->shiftL(delta_baro,dsecs);   // shift in delta_baro dsecs times i.e. duplicate so we weight correctly depending on dsecs
           shiftL(FPfilter,FPFSIZE, delta_baro,dsecs);
      }

      flight_phase = ave(FPfilter,FPFSIZE);  // vector Ave provided above

      ave_cr_val = ave(CRtrend, CRSIZE);  // short-term ave to determine flight path using three consecutive samples

      cr_val = ave_cr_val  * TCR_scale;  // scale for 200'


     flight_phase = flight_phase  * TCR_scale ;  // for 200'

     if (flight_phase > Max_flight_phase) {
            flight_phase = Max_flight_phase ;
     }

     if (flight_phase < Min_flight_phase) {
            flight_phase = Min_flight_phase ;
     }

    // what is our flight_mode ?

      if (cr_val >= Climb_mode_threshold) { // we have a climb

          if (flight_mode == DESCENT) { // previous mode was a descent - so we want to use that previous flight-phase

//"setting hold mode from CLIMB transition %V$flight_phase\n"

           hold_descent_mode =  hold_descent_secs; // for our hold countdown
          }
          else if (flight_mode == CLIMB) {
               if (flight_phase >= Max_flight_phase) {
                 max_flight_phase_reached = 1;
             }
             if (max_flight_phase_reached ) {
                 flight_phase = Max_flight_phase;
             }
             hold_climb_flight_phase = flight_phase;   // when we transistion level - hold the last climb flight phase
             hold_flight_phase = flight_phase ;
             hold_mode = 0 ;

        }

          flight_mode = CLIMB;
//"setting flight_mode to CLIMB transition %V$i $delta_baro $flight_phase $cr_val\n"
      }
      else if (cr_val < Descent_mode_threshold ) {  // definite descent

            if (flight_mode == DESCENT) {

//"updating %V$hold_descent_flight_phase to $flight_phase\n"

             hold_descent_flight_phase = flight_phase;   // when we transistion - hold the last descent flight phase
 
             hold_climb_mode = 0 ;
             hold_mode = 0 ;
             }

            flight_mode = DESCENT;
      }
      else {  // LEVEL

          // we are level or less than 100 climb/descent rate
         
          if (flight_mode == DESCENT) {

// fprintf("setting hold_mode from LEVEL transition %V$flight_phase\n"

           if (flight_phase > 0.0) {
              // reset FPfilter to current flight_phase
               vecFill(FPfilter, FPFSIZE, (flight_phase * TCR));
               //FPfilter = (flight_phase * TCR);   // vector set
           }

           if (flight_phase < 0.0) {
               hold_descent_mode = hold_descent_secs ;// for our hold countdown
               hold_mode = 1 ;
            }
            hold_climb_mode = 0 ;
          }

          if (flight_mode == CLIMB) {

            if (flight_phase > 0.0) {
              hold_climb_mode = hold_climb_secs; // for our hold countdown
            }

            hold_flight_phase = flight_phase ;
            hold_climb_flight_phase = flight_phase ;

           if (max_flight_phase_reached == 1) {
             hold_flight_phase = Max_flight_phase;
             hold_climb_flight_phase = Max_flight_phase;
             flight_phase = Max_flight_phase;
             max_flight_phase_reached =0 ;
            }

//fprintf(logfile,"setting hold_climb_mode from LEVEL transition %V$flight_phase $cr_val\n" );
          }
         flight_mode = LEVEL ;
      }

         if ((flight_mode == DESCENT)  && (hold_descent_mode > 0)) {

              //  FPfilter = (hold_descent_flight_phase * TCR) ;  // vector set
                  vecFill(FPfilter, FPFSIZE, (hold_descent_flight_phase * TCR));
//<<[2]"new  DESCENT during hold %V$hold_descent_flight_phase  $flight_phase \n"

                flight_phase = hold_descent_flight_phase ;
                hold_flight_phase = hold_descent_flight_phase ;
                // now cancel descent hold since we have entered a new descent
                hold_mode = 0 ;
                hold_descent_mode = 0 ;

      }



      if ((flight_mode != DESCENT)  && (hold_descent_mode > 0)) {

// we have levelled off or climbing -- but we were previously in steady descent
// so use hold_descent_flight_phase for hold_descent mins

         hold_mode = 1;
         hold_descent_mode -= dsecs ;

         flight_phase = hold_descent_flight_phase ;  // hold it at the last descent_flight_phase -- until hold mins is up

//<<[2]"%V$hold_descent_mode $flight_phase\n"

        if (hold_descent_mode <= 0) {      // now transition to slew_to_level_mode

            slew_descent_flight_phase = hold_descent_flight_phase;

            //FPfilter = (hold_descent_flight_phase * TCR);   // vector fill
             vecFill(FPfilter, FPFSIZE, (hold_descent_flight_phase * TCR));
            hold_mode = 0;
        }

      }



      if ((flight_mode == LEVEL)  && (hold_climb_mode > 0)) {

// we have levelled off -- but we were previously in steady climb
// so use hold_climb_flight_phase for hold_climb_mins

         hold_mode = 1 ;
         hold_climb_mode -= dsecs ;
                        // set to last hold_flight_phase --

//         flight_phase = hold_climb_flight_phase   // hold it at the last climb_flight_phase -- until hold mins is up
           flight_phase = hold_flight_phase ;  // hold it at the last hold_flight_phase -- until hold mins is up


        if (hold_climb_mode <= 0) {      // now transition to slew_to_level_mode
            slew_to_level_mode = slew_cnt;  // and slew to flight-phase zero in slew_time mins

            //FPfilter = (hold_flight_phase * TCR);   // vector set
            vecFill(FPfilter, FPFSIZE, (hold_flight_phase * TCR));
            hold_flight_phase = 0.0;
            hold_climb_flight_phase = 0.0;
            hold_mode = 0;
        }

      }


 fprintf(logfile,"tim %d dsecs %d d_alt_fpm %6.1f %d hold_mode %d flight_mode %d cr_val %6.2f hold_fp %6.2f flt_phs %6.2f\n",
 e_tim, dsecs, delta_alt_fpm, hold_mode,flight_mode, cr_val, hold_flight_phase, flight_phase);

     // double check and limit flight phase
     if (flight_phase > Max_flight_phase) {
            flight_phase = Max_flight_phase ;
     }

     if (flight_phase < Min_flight_phase) {
            flight_phase = Min_flight_phase ;
     }

     flight_pta->flight_phase = flight_phase;

//      <<[2]"$tim $alt $delta_baro  $flight_phase \n"
       // GUI var
           theFlightPhase = flight_pta->flight_phase;
 }


}





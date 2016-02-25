/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** Header File: flight_phase.h
**
** Description:   This file contains routines to calculate flightphase and for
**                flight_path_threat_assessment
**
** flight_phase.c 422 2010-04-06 13:18:52Z amterry -- first version
**
** $Id: flight_phase.c 532 2010-04-22 23:15:40Z amterry $
**----------------------------------------------------------------------------
*/

#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <fcntl.h>

#include "flight_path_threat.h"
#include "flight_phase.h"
//#include "debug.h"
#include "defines.h"
#include "units.h"
#include "radar.h"


// TMP for force flight_phase via GUI
#include "gui_var_init.h"

// some utilities for flight-phase calc


float ave (int *vec , int n)
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


// running average of baro alt during sweep -- what is rate of baro alt updates
float raveAlt (float balt )
{
  static int nc = 0;
  static float vec[N_RAVE];
  static int i = 0;
  static int full = 0;
  static float ta = 0;
  float rave = 0.0;
  float last_alt;
  

  last_alt = vec[i];
  vec[i] = balt;
  nc++;
  i++;
  if (i >= N_RAVE)
    i = 0;

  if (nc > N_RAVE) {
    full = 1;
    nc = N_RAVE; // full
  }

   ta += balt;
   if (full) {
     ta -= last_alt;
     rave = ta * RAVE_MULT;
   }
   else
   rave = ta / (float) nc;

  return  rave ;
}


void
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

void
vecFill(int *vec, int n, int val)
{
int i;
    for (i = 0; i < n; i++)
       *vec++ = val;

}

__inline
float minof(float  aval, float bval)
{
  float wval = (aval < bval) ? aval : bval;
  return (wval);
}

__inline
float maxof(float  aval, float bval)
{
  float wval = (aval > bval) ? aval : bval;
  return (wval);
}


enum flightmode {

  LEVEL,
  NEUTRAL,
  DESCENT,
  ASCENT,
  CLIMB,
  DESCENT_HOLD,
  ASCENT_HOLD,
  HOLD_COMPLETE,
};


///////////////////////////////////////////////////

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:
**
** Syntax:    void calcFlightPhase    (FLIGHT_PATH_THREAT_TYPE *flight_pta)
**
** Description:   FlightPhase computation  ----
** N.B.  has to work with irregular sampled baro-altitudes
**  typically it is 5 sec then 8 sec -- since it is called at the end of the sweep
**  consider calling after n epochs so the sampling rate is about 0.5 Hz
**  this version has to deal with irregular input samples
**
**
**
** Returns:
**
** Algorithm:
**
** Special Notes:
** $Id: flight_phase.c 532 2010-04-22 23:15:40Z amterry $
**.EH-------------------------------------------------------------------------
*/


///////////////////////////////////////////////////////////////////////////////////////////


extern int Jfps;


 void initFlightPhase( FLIGHT_PHASE_TYPE *flightP)
{
     int i;
     flightP->flight_mode = LEVEL;
     flightP->previous_flight_mode = LEVEL;
     flightP->hold_mode = OFF;
     flightP->hold_mode_secs = 0;
     flightP->hold_descent_mins = DESCENT_HOLD_MINS;
     flightP->hold_climb_mins = CLIMB_HOLD_MINS;
     flightP->hold_descent_secs = flightP->hold_descent_mins * 60;  // making it effectively run every sec 
                                                                    // -- even input samples are irregular
     flightP->hold_climb_secs = flightP->hold_climb_mins * 60;
     flightP->slew_mins = SLEW_MINS;
     flightP->max_flight_phase_reached = 0;
     flightP->min_flight_phase_reached = 0;
     flightP->climb_phase_max = -1.0;
     flightP->descent_phase_min = 1.0;
     flightP->hold_flight_phase = 0.0;
     flightP->flight_phase = 0.0;
      flightP->last_flight_phase = 0.0;
      flightP->max_flight_phase = MAX_FLIGHT_PHASE;
      flightP->min_flight_phase = MIN_FLIGHT_PHASE;
      flightP->climb_mode_thres = 200;
      flightP->descent_mode_thres = -200;
      flightP->TCR  = 150; // threshold  climb rate    --make 100
      flightP->TCR_scale = 1.0 / flightP->TCR;	// used to scale filter values to give flight-phase in range -1.0/1.0
      flightP->MCR = 100; // minimum climb rate   - make 99
      flightP->min_descent_phase_level = -0.2;  // above this no descent hold
      flightP->min_climb_phase_level = 0.2;  // below this no climb hold
      flightP->slew_rate = 1.0/120.0;
      flightP->f_rate = 1.0;
      flightP->delta_baro = 0.0;
      flightP->last_delta_baro = 0.0;
      flightP->fp_update = 0;
      flightP->fp_calc_init = 1;
      flightP->fp_cnt = 0;
      for (i = 0; i < CRSIZE; i++)
	flightP->CRtrend[i] = 0;

        Jfps = 0;

}


// time in secs   alt in feet computes flight_phase
//int FPfilter[FPFSIZE];	// we can't assume fixed intervals so we will interpolate to sec interval



int checkFlightMode (FLIGHT_PHASE_TYPE *flightP)
{
// using an average of last  3 delta-baros to judge climb rate
// could use 2 for better timing resolution particularly if we are getting called at
// a slow rate

int fmode = LEVEL;

         flightP->f_rate = 1.0;  // normal change rates apply

         if (flightP->delta_baro > 0 && flightP->last_delta_baro > 0  && (flightP->ave_cr_val > flightP->TCR)) { // we have a climb
             fmode = CLIMB;
         }
         else if (flightP->delta_baro < 0 && flightP->last_delta_baro < 0  && (flightP->ave_cr_val < -flightP->TCR)) {  // definite descent
             fmode = DESCENT;

   // decided  against this option -- it will take from top of climb to full descent 4 mins we
   // only have one rate in this system
  // if (flightP->ave_cr_val < -4000) flightP->f_rate = 2.0; // or whatever to have it go the remainder of range to -1.0
                                                            // in < 2 mins
         }
         else {
             fmode = LEVEL;

         }

     if (fmode != flightP->flight_mode) {
      // fprintf(fpdbfile,"transition == ave_cr %6.4f  last_db %6.2f dbaro %6.2f -- fmode now %d\n",
      //   flightP->ave_cr_val, flightP->last_delta_baro, flightP->delta_baro, fmode);
     }

         flightP->last_delta_baro  = flightP->delta_baro;

	 return fmode;
}





void limitFlightPhase(  FLIGHT_PHASE_TYPE *flightP)
{
     if (flightP->flight_phase > flightP->max_flight_phase)
                flightP->flight_phase = flightP->max_flight_phase;

     if (flightP->flight_phase < flightP->min_flight_phase)
                flightP->flight_phase = flightP->min_flight_phase;


}

float limitVal(float  val, float min, float  max)
{
   if (val < min) {
     val = min;
   }
   else if (val > max) {
     val = max;
   }
   return val;
}




void limitDeltaBaro( FLIGHT_PHASE_TYPE *flightP )
{
            // dead-band +/- 100
        if ((flightP->delta_baro < flightP->MCR) && (flightP->delta_baro > -flightP->MCR)) {
             flightP->delta_baro = 0;
        }
        else {
          flightP->delta_baro = limitVal(flightP->delta_baro,-flightP->TCR, flightP->TCR);
        }

}

void updateFlightPhase(FLIGHT_PHASE_TYPE *FlightP, int dsecs)
{
float delta_fp;

     if (FlightP->flight_mode == LEVEL)  {
         // slew towards zero
          slewFlightPhase(FlightP ,dsecs);
          }
     else {
     //
     delta_fp = (dsecs * FlightP->delta_baro * FlightP->TCR_scale * FlightP->slew_rate * FlightP->f_rate); // change when not holding  - by dsecs at scaled rate

     FlightP->flight_phase += delta_fp ;// change when not holding  - by dsecs at scaled rate
     FlightP->fp_update = 1;

     //     fprintf(fpdbfile,"fpcnt %d updating flight_phase %6.4f  by delta_fp %6.4f \n", FlightP->fp_cnt, FlightP->flight_phase, delta_fp);

     }
}

void aveCrFlightPhase( FLIGHT_PHASE_TYPE *flightP,  int dsecs)
{

      shiftL (flightP->CRtrend, CRSIZE, (int) flightP->crfpm, 1);
      // short-term ave to determine flight path using three consecutive samples
      flightP->ave_cr_val = ave (flightP->CRtrend, CRSIZE);   // > 100 climb < 100 descent else level
                                                              // more 4000' fpm descent then it is emergency descent


      //      fprintf(fpdbfile,"ave_cr_val %f \n", ave_cr_val, );


}

void slewFlightPhase(FLIGHT_PHASE_TYPE *flightP,int dsecs)
{
        if (flightP->flight_phase > 0.0) {

	   flightP->flight_phase -=  minof(flightP->flight_phase,(flightP->slew_rate * dsecs));

	   //fprintf(fpdbfile,"slewing down last_fp %6.4f flight_phase %6.4f @  slew_rate %6.4f \n",flightP->last_fp, flightP->flight_phase, flightP->slew_rate);

         }
         else if (flightP->flight_phase < 0.0) {

	   flightP->flight_phase += (flightP->slew_rate * dsecs);
 
	   //fprintf(fpdbfile,"slewing up last_fp %6.4f flight_phase %6.4f @   slew_rate %6.4f \n", flightP->last_fp, flightP->flight_phase, flightP->slew_rate);
       
      }
}



void  checkHold(FLIGHT_PHASE_TYPE *flightP,int dsecs)
{
float in_flight_phase = flightP->flight_phase;
float fp_change;
static int too_fast = 0;

// fprintf(fpdbfile,"checkhold in flight_phase %6.2f \n", flightP->flight_phase);
// in hold flight-phase is left unchanged
// after hold is over -- then flight-phase is commanded by flight climb/descent rate
// always decrement hold_duration

               if ( flightP->hold_mode_secs > 0) 
                       flightP->hold_mode_secs -= dsecs;
               if ( flightP->hold_mode_secs < 0) 
                       flightP->hold_mode_secs = 0;


               switch (flightP->flight_mode) {

                   case DESCENT:

                     if ( flightP->hold_mode == DESCENT_HOLD) {  // level ---> descent
                   // if we were in descent hold - cancel
		   //    printf("new  DESCENT during hold set fphase to hold_flight_phase %6.4f  \n",flightP->hold_flight_phase);


		       if ( flightP->flight_phase > -1.0) {
                        flightP->hold_mode = OFF ;    // now cancel descent hold since we have entered a new descent allow flight_phase to decrease
                        flightP->hold_mode_secs = 0;  // reset hold timer
                       }


                     }
                     else if ( flightP->hold_mode == ASCENT_HOLD ) {  // level ---> descent

                        flightP->hold_mode = OFF ; // now cancel climb hold since we have entered a new descent

                     }

                    break;

                  case CLIMB:

                     // climbing -- if we were descent hold -- continue holding
                     // and hold_flight_phase for hold_descent mins --- missed approach

                     if (flightP->hold_mode_secs > 0) {   // descent ---> climb
			; // keep any descent hold
		     }
		     else if (flightP->hold_mode_secs <= 0) {      // now transition to slew_to_level_mode
		       flightP->hold_mode = OFF; // but if we timed out cancel hold
                     }


                   break;

                  case LEVEL:

                      // check ongoing hold conditions
                      // we have levelled off but we were previously in steady descent

                        if (flightP->hold_mode_secs <= 0) {      // now transition to slew_to_level_mode
                            flightP->hold_mode = OFF;
                        }


                      if (flightP->hold_mode_secs > 0) {  // climb hold ---> level
                        // level and holding
                       // we have levelled off -- 
                       // so use hold_ flight_phase for hold__mins
                      }

#if 0
// this is where we could adjust f_rate for a faster descent from a top of the climb hold condition 1.0 ---> -1.0
                    if (!flightP->hold_mode && flightP->flight_phase != 1.0 && flightP->flight_phase != -1.0) {
                         // then we are not descending or ascending so f_rate so goes to normal
                           flightP->f_rate = 1.0;

                    }
#endif



                    break;
               }



                if (in_flight_phase > 0)  {
                fp_change = in_flight_phase - flightP->flight_phase;
                }
                else {
                 fp_change = flightP->flight_phase - in_flight_phase;
                 }
                if (fp_change > flightP->slew_rate) {
                 too_fast++;  // sanity check -- should never occur
		 //fprintf(fpdbfile,"#after hold now flight_phase %6.2f  change %f\n", flightP->flight_phase, fp_change);
                }
             //



}


void logFlightPhase (FLIGHT_PHASE_TYPE *FlightP, int state)
{


       switch (state) {

        case 1:
      fprintf(logfile,"%d,%d,%d,%d,%d,%6.0f,%6.0f,%6.2f,%6.2f,%6.2f,%6.2f,%6.2f,%6.2f,%6.2f\n",
	FlightP->fp_cnt, FlightP->tim, FlightP->flight_mode, 
        FlightP->hold_mode, FlightP->hold_mode_secs, 
	FlightP->alt,FlightP->gps_alt,FlightP->delta_baro, 
        FlightP->ave_cr_val, FlightP->flight_phase,FlightP->r_fphase, FlightP->crfpm,
        FlightP->r_calc_fp, FlightP->r_phi_offset ) ;

  //     fprintf(fpdbfile,"fp_update %d  delta_fp %6.2f last_fp %6.2f new_flight_mode %d\n", FlightP->fp_update, delta_fp, FlightP->last_fp, new_flight_mode);
        break;
        case 2:
  //fprintf(fpdbfile,"updating hold_flight_phase %6.4f to flight_phase %6.4 f min_flight_phase_reached?%d \n", FlightP->hold_flight_phase, FlightP->flight_phase,FlightP->min_flight_phase_reached) ;

        break;

        case 3:

	  //    fprintf (fpdbfile,
	  //   "tim %d   hold_mode %d flight_mode %d ave_cr_val %6.2f fp_phs %6.2f max %6.2f min %6.2f\n",
	  //     FlightP->tim,   FlightP->hold_mode, FlightP->flight_mode, FlightP->ave_cr_val,
	  //     FlightP->flight_phase,FlightP->climb_phase_max,FlightP->descent_phase_min);

       // fprintf(fpdbfile,"%d %f %f %f\n",FlightP->tim,FlightP->alt,FlightP->delta_baro,FlightP->flight_phase);
        break;


        }

}

int   checkTimeAlt(FLIGHT_PHASE_TYPE *FlightP)
  {
  int dsecs;
  // what if the delta time is outside of our 'window'
  // negative time ?
  FlightP->delta_baro = FlightP->alt - FlightP->last_baro;
  FlightP->last_baro = FlightP->alt;


  dsecs = FlightP->tim - FlightP->last_tim;
  // if dsecs is neg or zero calcFlightPhase skips calc
  // if decs > 60 secs --  must be a glitch in input we set to dsecs zero
  // situation should be rectified at next input
  // ideally calcFlightPhase called at 0.5 Hz
  // if baro_alt or time updates are bizarre or fail
  // flight-phase probably should be probably be nudged towards  0.0


   if (dsecs > 60 || dsecs <= 0) {
       dsecs = 0;
   }
   else {
      FlightP->crfpm = FlightP->delta_baro / dsecs * 60;
      FlightP->delta_baro = FlightP->crfpm;
      
   }

  FlightP->last_tim = FlightP->tim;
  return dsecs;

  }


//extern "C++"
//void plotFlightPhase(FLIGHT_PHASE_TYPE *FlightP);

void
calcFlightPhase (FLIGHT_PHASE_TYPE *FlightP)
{
  int dsecs;

// we don't know at what intervals the flight-phase calculation occur -- variable deltas
// so measure the time between cycles and  compute the cimb/descent rate

  if (FlightP->fp_calc_init == 1)
    {

      FlightP->last_baro = FlightP->alt;
      FlightP->last_tim =  FlightP->tim;

      FlightP->fp_calc_init = 0;
    }

  FlightP->fp_cnt++;

  // call new radio flight phase code

  radio_fp(FlightP);

  dsecs= checkTimeAlt(FlightP);

  //fprintf(fpdbfile,"fphase in %6.4f \n",FlightP->flight_phase);
  //fprintf(fpdbfile,"tim %d last_tim %d dsecs %d\n",tim, last_tim, dsecs);

  if (dsecs > 0)
    {

      // limit delta_baro
      // is TCR 100 fpm a sufficient climb?  -- range likely to be 500 -- 3000 fpm

      limitDeltaBaro( FlightP );

      if (!FlightP->hold_mode)  {

          updateFlightPhase(FlightP, dsecs);

	}

      aveCrFlightPhase(FlightP,  dsecs);

      limitFlightPhase(FlightP);

      logFlightPhase(FlightP,1);

      // what to guard against here is that in turbulence -we can get momentary climb/descents
      // and we don't want those to change our flight_modes 

           switch (checkFlightMode(FlightP)) {   // what is our  new flight_mode ?


                  case CLIMB:


		    switch(FlightP->flight_mode) {  // look at previous mode

                      case DESCENT: // descent ---> climb
                                    // previous mode was a descent - so we want to use that previous flight-phase
                                    // if we are in descent flight phase territory i.e. < 0
                      // if (FlightP->min_flight_phase_reached ) {
                      //  FlightP->flight_phase = FlightP->min_flight_phase;
                      // }

                       if (FlightP->flight_phase < FlightP->min_descent_phase_level) { // has to be significantly into to neg territory
                        FlightP->hold_mode_secs = FlightP->hold_descent_secs; // for our hold countdown
                        FlightP->hold_mode = DESCENT_HOLD;
			//fprintf(fpdbfile,"descent-->climb flight_phase %6.2f  --> %f\n", FlightP->flight_phase, FlightP->descent_phase_min);
                        FlightP->flight_phase =   FlightP->descent_phase_min;   // last descent phase

                      //  FlightP->descent_flight_phase = 1.0;  // reset
                       // FlightP->hold_flight_phase = FlightP->flight_phase;

                        FlightP->min_flight_phase_reached = 0;
                       }


                     break;
                     case CLIMB:  // climb ---> climb

                       if (FlightP->flight_phase >= FlightP->max_flight_phase) {
                         FlightP->max_flight_phase_reached = 1;
                       }

                       if (FlightP->max_flight_phase_reached ) {
                     //   FlightP->flight_phase = FlightP->max_flight_phase;
                       }

                       if ( FlightP->hold_mode == ASCENT_HOLD && FlightP->flight_phase < 1.0) {
                        FlightP->hold_mode = OFF ; // now cancel ascent hold since we have entered a new climb and are not yet at maximum FP
                        FlightP->hold_mode_secs = 0;  // reset hold timer
                       }



                      break;

                     case LEVEL:  // level ---> climb

                      if ( FlightP->hold_mode == DESCENT_HOLD) {

                      }

                      if ( FlightP->hold_mode == ASCENT_HOLD && FlightP->flight_phase < 1.0) {
                        FlightP->hold_mode = OFF ; // now cancel ascent hold since we have entered a new climb and are not yet at maximum FP
                        FlightP->hold_mode_secs = 0;  // reset hold timer
                      }


                      break;

                    }

                     FlightP->flight_mode = CLIMB;


                     break;


               case DESCENT:

                        switch(FlightP->flight_mode) {

                          case DESCENT: // descent ---> descent
                            logFlightPhase(FlightP,2);


                             if (FlightP->min_flight_phase_reached) {
                           //  FlightP->flight_phase = FlightP->min_flight_phase ; // should be sticky as long as in descent mode
                            }



			     if ( FlightP->hold_mode == ASCENT_HOLD ) { // two descents cancel climb hold
                                FlightP->hold_mode_secs = 0;
                                FlightP->hold_mode = OFF;
			      }

                           //FlightP->descent_phase_min = 1.0;  // reset

                           if (FlightP->flight_phase <= FlightP->min_flight_phase) {
                            FlightP->min_flight_phase_reached = 1;
                           }

                         break;
                         case CLIMB:  // climb ---> descent
                                      // do not enter climb hold
                           break;

                          case LEVEL: // level ---> descent
                                     // cancel any descent hold -- allow flight-phase to decrease
                              if (FlightP->hold_mode == DESCENT_HOLD  && FlightP->flight_phase > -1.0) {
                                FlightP->hold_mode_secs = 0;
                                FlightP->hold_mode = OFF;
                              }

                          break;

                  }

                  FlightP->flight_mode = DESCENT;
	//	  fprintf(fpdbfile," flight_mode to descent %d\n", FlightP->flight_mode);

                 break;

               case LEVEL:

                   // we are level or less than 100 climb/descent rate

                      switch (FlightP->flight_mode) {

                        case DESCENT:   // descent ---> level

                            if (FlightP->min_flight_phase_reached ) {
                           //  FlightP->flight_phase = FlightP->min_flight_phase;
                             }

                            if (FlightP->flight_phase < FlightP->min_descent_phase_level) {

                                FlightP->hold_mode_secs = FlightP->hold_descent_secs; // for our hold countdown
                                FlightP->hold_mode = DESCENT_HOLD;

                                FlightP->flight_phase =  FlightP->descent_phase_min;

                                FlightP->min_flight_phase_reached = 0;
			    }

                             

                         break;

                         case CLIMB:   // climb --> level
                           //  and only if not if a descent hold -- descent hold timer +ve fphase < -0.25

                          if (FlightP->flight_phase > FlightP->min_climb_phase_level) {   // only to hold mode if we are a positive flight phase

                            FlightP->hold_mode_secs = FlightP->hold_climb_secs; // for our hold countdown
                            FlightP->hold_mode = ASCENT_HOLD;

                            FlightP->flight_phase = FlightP->climb_phase_max;
                            FlightP->climb_phase_max = -1.0 ; // reset
                            }


                            //FlightP->hold_flight_phase = FlightP->flight_phase;

                            if (FlightP->max_flight_phase_reached == 1) {
                           //  FlightP->hold_flight_phase = FlightP->max_flight_phase;
                            // FlightP->flight_phase = FlightP->max_flight_phase;
                             FlightP->max_flight_phase_reached =0;
                            }

                          break;

                          case LEVEL:  // level ---> level nothing to do except check hold (done later)

                          break;
                      }

                        FlightP->flight_mode = LEVEL;
                      break;
	     }

    //   fprintf(fpdbfile,"flight_mode now %d\n", FlightP->flight_mode);

        checkHold(FlightP, dsecs);

   //     limitFlightPhase(FlightP);

        FlightP->last_fp = FlightP->flight_phase;

        // keep recording max min -- so when we go to hold the greatest descent/climb phase is used as the hold value
        // and not any transistion value
        if ( FlightP->flight_phase < FlightP->descent_phase_min)
             FlightP->descent_phase_min = FlightP->flight_phase;

         if ( FlightP->flight_phase > FlightP->climb_phase_max)
             FlightP->climb_phase_max = FlightP->flight_phase;


        logFlightPhase(FlightP,3);
        //plotFlightPhase(FlightP);

  //    fprintf(ofp,"%d %f %f %f\n",FlightP->tim,FlightP->alt,FlightP->delta_baro,FlightP->flight_phase);


    }

}


#define RFP_THRES  150.0     // might work at 100 -- have to try real flight examples
//#define RFP_THRES  250.0  // original
#define DESCENT_FP_HOLD_THRES  -0.2 
#define ASCENT_FP_HOLD_THRES    0.2 
#define HOLD_TIME_SECS  300

void 
radio_fp(FLIGHT_PHASE_TYPE *FlightP)
{
    static float elapsed_time;
    static float fp_previous_elapsed_time = 0.0;
    float fp_sweep_time;           
    static float delta_baro_samples[4] = {0.0, 0.0, 0.0, 0.0};                      
    static unsigned int delta_baro_index = 0; 
    float delta_baro;                      
    float phi_offset_max;
                 
    static float start_hold_time;
    static unsigned int fp_mode;  /* flight phase mode */
    
    static unsigned int flight_phase_baro;                      
    static unsigned int last_baro;                      
    static int phi_offset;           
    static float flight_phase;           
    static unsigned int initialize_fpo = TRUE;
    int i;

    flight_phase_baro = FlightP->alt;
    elapsed_time = FlightP->tim;
                  /* initialize variables first end-of-sweep */
                  if (initialize_fpo == TRUE)
                  {
                     last_baro = flight_phase_baro;
                     fp_mode = NEUTRAL;
                     flight_phase = 0.0;
                     start_hold_time = 0.0;
                     initialize_fpo = FALSE;
                     fp_previous_elapsed_time = FlightP->tim; 
                  }
                  else
                  {                       
                     /* Calculate the flight phase offset sweep time */
                     fp_sweep_time = elapsed_time - fp_previous_elapsed_time;
                     // input as rate fpm  since fp_sweep_time varies!                      	

                     if(fp_sweep_time == 0)
                        delta_baro_samples[delta_baro_index] = 0.0;
                     else {
		       //  delta_baro_samples[delta_baro_index] = (float) flight_phase_baro - (float)last_baro;
		       delta_baro_samples[delta_baro_index] = ((float) flight_phase_baro - (float)last_baro) * 60.0/fp_sweep_time ;
                     }

                     delta_baro_index++;
                     if (delta_baro_index >= 4)
                     	  delta_baro_index = 0;
                     	                     	
                     /* calculate delta baro sum */
                     delta_baro = 0.0;
                     for (i = 0; i < 4; i++)
                        delta_baro += delta_baro_samples[i];
                                         
                     /* calculate delta baro average in fpm */
                     //delta_baro = delta_baro * (60.0 * 0.25)/fp_sweep_time;
                     delta_baro = delta_baro / 4.0;  // already in feet_per_min
                                            
                     /* Keep track of previous elapsed time */	                        
                     fp_previous_elapsed_time = elapsed_time;
                                          
                     /* Keep track of last baro */	                        
                     last_baro = flight_phase_baro;
 
                     /* delta baro < -250 fpm -> descent mode */
                     if (delta_baro < -RFP_THRES)
                     {
                        fp_mode = DESCENT;
                        
                        /* flight phase = flight phase - sweep time / 120 secs  */
                        flight_phase -= fp_sweep_time * 8.333333e-3;
                        
                        /* limit flight phase to -1.0 */
                        if (flight_phase < -1.0)
                        {
                           flight_phase = -1.0;
                        }
                     }
                     else if (delta_baro > RFP_THRES)
                     {
                     	  /* if still in descent hold, wait for time-out */
                        if (fp_mode == DESCENT_HOLD)
                        {
                           if ((elapsed_time - start_hold_time) >= HOLD_TIME_SECS)
                           { 
                              fp_mode = ASCENT;
                           }
                        }
                        else if ((fp_mode == DESCENT) && (flight_phase < DESCENT_FP_HOLD_THRES))
                        {
                           fp_mode = DESCENT_HOLD;
                           start_hold_time = elapsed_time - fp_sweep_time;
                        }
                        else
                        {
                           fp_mode = ASCENT;
                        }
                                                
                    	  /* if ascent mode slew flight phase to full ascent */
                        if (fp_mode == ASCENT)
                        {
                           /* flight phase = flight phase + sweep time / 120 secs  */
                           flight_phase += fp_sweep_time * 8.333333e-3;
                             
                           /* limit flight phase to 1.0 */
                           if (flight_phase > 1.0)
                           {
                              flight_phase = 1.0;
                           }
                        }
                     }
                     else
                     {
                     	  /* if descent ceases and flight phase is negative go to hold mode */
                        if (fp_mode == DESCENT)
                        {
                           if (flight_phase < DESCENT_FP_HOLD_THRES)
                           {
                              fp_mode = DESCENT_HOLD;
                              start_hold_time = elapsed_time - fp_sweep_time;
                           }
                           else
                           {
                              fp_mode = HOLD_COMPLETE;
                           }
                        }
                     	  /* if ascent ceases go to hold mode */
                        else if (fp_mode == ASCENT)
                        {
                           if (flight_phase > ASCENT_FP_HOLD_THRES)
                           {
                              fp_mode = ASCENT_HOLD;
                              start_hold_time = elapsed_time - fp_sweep_time;
                           }
                           else
                           {
                              fp_mode = HOLD_COMPLETE;
                           }
                        }
                        else if ((fp_mode == DESCENT_HOLD) || (fp_mode == ASCENT_HOLD))
                        {
                           /* hold for 5 minutes */
                           if ((elapsed_time - start_hold_time) >= HOLD_TIME_SECS)
                           { 
                              fp_mode = HOLD_COMPLETE;
                           }
                        }
                        else if (fp_mode != HOLD_COMPLETE)
                        {
                           flight_phase = 0.0;
                           fp_mode = NEUTRAL;
                        }
                        
                        if (fp_mode == HOLD_COMPLETE)
                        {
                        	  /* after 5 minutes hold time slew flight phase back to 0 */
                           if (flight_phase > 0.0)
                           {
                              /* flight phase = flight phase - sweep time / 120 secs  */
                              flight_phase -= fp_sweep_time * 8.333333e-3;
                              
                              /* limit flight phase to 0.0 */
                              if (flight_phase < 0.0)
                              {
                                 flight_phase = 0.0;
                                 fp_mode = NEUTRAL;
                              }
                           }
                           else if (flight_phase < 0.0)
                           {
                              /* flight phase = flight phase - sweep time / 120 secs  */
                              flight_phase += fp_sweep_time * 8.333333e-3;
                              
                              /* limit flight phase to 0.0 */
                              if (flight_phase > 0.0)
                              {
                                 flight_phase = 0.0;
                                 fp_mode = NEUTRAL;
                              }
                           }
                           else
                           {
                              fp_mode = NEUTRAL;
                           }
                        }
                     }
                      
                     /* phi_offset=min(flight_phase*0.5,0) */
                     phi_offset_max = flight_phase * 0.5;
                     if (phi_offset_max > 0.0)
                        phi_offset_max = 0.0;

                     FlightP->r_calc_fp = flight_phase;  
                     FlightP->r_phi_offset = phi_offset_max;
  
                     /* convert to 1/64 deg per LSB */  
                     phi_offset = (int)(phi_offset_max * 64.0 - 0.5);

                  }

}



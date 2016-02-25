
#include <stdio.h>
#include <fcntl.h>
#include <string.h>



enum flightmode
  { LEVEL, CLIMB, DESCENT, };


#define FPFSIZE 120
#define CRSIZE 3

static float
ave (int *vec, int n)
{
  float ave = 0.0;
  int i;
  if (n > 0)
    {
      for (i = 0; i < n; i++) {
	ave += vec[i];

      }
        ave /= (float) n;
    }
  return ave;
}


static void
shiftL (int *vec, int n, int val, int n_shift)
{

  int i, j;
  for (j = 0; j < n_shift; j++)
    {
      for (i = 0; i < (n - 1); i++)
	{
	  vec[i] = vec[i + 1];
	}
      vec[n - 1] = val;
    }

}

static void
vecFill (int *vec, int n, float val)
{
  int i;
  for (i = 0; i < n; i++)
    *vec++ = val;

}


int checkFlightMode (float crv, float climb_thres, float descent_thres)
{

int fmode = LEVEL;

         if (crv >= climb_thres) { // we have a climb
             fmode = CLIMB;
         }
         else if (crv < descent_thres) {  // definite descent
             fmode = DESCENT;
         }
         else {
             fmode = LEVEL;

         }

	 //	 printf("crv %6.4f climb_thres %6.4f float descent_thres %6.4f -- fmode now %d\n", crv, climb_thres, descent_thres, fmode);

	 return fmode; 
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


inline
float minof(float  aval, float bval)
{
  float wval = (aval < bval) ? aval : bval;
  return (wval); 
}

inline
float maxof(float  aval, float bval)
{
  float wval = (aval > bval) ? aval : bval;
  return (wval); 
}


void  checkHold(int flight_mode, float *flight_phase, float *hold_flight_phase, int dsecs, int *hold_mode, int *hold_descent_mode, int *hold_climb_mode)
{

               switch (flight_mode) {

                   case DESCENT:

                     if ( *hold_descent_mode > 0) {

//                      FPfilter = (hold_flight_phase * TCR);   // vector set

		       printf("new  DESCENT during hold set fphase to hold_flight_phase %6.4f  \n",*hold_flight_phase);              

                      *flight_phase = *hold_flight_phase ;
                    
                      *hold_mode = 0 ; // now cancel descent hold since we have entered a new descent
                      *hold_descent_mode = 0;
                     }

                    break;

                  case CLIMB:

                     // climbing -- but we were previously in steady descent
                     // so use hold_flight_phase for hold_descent mins --- missed approach

                     if (*hold_descent_mode > 0) {

                     *hold_mode = 1;
                     *hold_descent_mode -= dsecs;
                     *flight_phase = *hold_flight_phase;   // hold it at the last descent_flight_phase -- until hold mins is up

                //<<[2]"%V$hold_descent_mode $flight_phase\n"

                      if (*hold_descent_mode <= 0) {      // now transition to slew_to_level_mode
                       *hold_mode = 0;
                     }
                     }

                   break;

                  case LEVEL:
                         // we have levelled off but we were previously in steady descent
                         // so use hold_flight_phase for hold_descent mins

                     if (*hold_descent_mode > 0) {  // level and holding
                       *hold_mode = 1;
                       *hold_descent_mode -= dsecs;
                       *flight_phase = *hold_flight_phase;   // hold it at the last descent_flight_phase -- until hold mins is up

                       printf("in hold_descent_mode %d  set flight_phase %6.4f\n",*hold_descent_mode, *flight_phase);

                       if (*hold_descent_mode <= 0) {      // now transition to slew_to_level_mode

                         *hold_mode = 0;
                      }

                     }

                      if (*hold_climb_mode > 0) { // level and holding

                       // we have levelled off -- but we were previously in steady climb
                       // so use hold_climb_flight_phase for hold_climb_mins

                        *hold_mode = 1;
                        *hold_climb_mode -= dsecs;
                        *flight_phase = *hold_flight_phase;   // hold it at the last hold_flight_phase -- until hold mins are up

                        if (*hold_climb_mode <= 0) {      // now transition to slew_to_level_mode
                         *hold_flight_phase = 0.0;
                         *hold_mode = 0;
                      }

                    }

                    break;
               }
}






FILE *logfile;
FILE *ofp;

// time in secs   alt in feet computes flight_phase

int FPfilter[FPFSIZE];	// we can't assume fixed intervals so we will interpolate to sec interval
int CRtrend[CRSIZE];	// descent/climb mode







void
calcFlightPhase (int tim, float alt, float *the_flight_phase)
{
  static uint fpcnt = 0;
  //  static int FPfilter[FPFSIZE];	// we can't assume fixed intervals so we will interpolate to sec interval
  // static int CRtrend[CRSIZE];	// descent/climb mode

  static float last_baro = 0.0;
  static int last_tim = 0;
  static int e_tim = 0;


  static int max_flight_phase_reached = 0;
  static int min_flight_phase_reached = 0;
  static int flight_mode = LEVEL;
  static int hold_mode = 0;
  static int hold_descent_mode = 0;	// initial
  static int hold_climb_mode = 0;
  static float hold_flight_phase = 0.0;

  static float flight_phase;
  static float last_fp = 0.0;
  int dsecs;
  float delta_baro = 0.0;
  float delta_alt_fpm = 0.0;
  float delta_fp;
  float cr_val = 0.0;
  float ave_cr_val;
  float Max_flight_phase = 1.0;
  float Min_flight_phase = -1.0;
  float TCR = 200.0;		// any climb rate that exceeds this is limited to this threshold climb rate
  float TCR_scale = 1.0 / TCR;	// used to scale filter values to give flight-phase in range -1.0/1.0
  float MCR = 100;		// minimum climb rate dead-band
  float Climb_mode_threshold = 0.25;
  float Descent_mode_threshold = -0.75;
  float slew_mins = 2.0;
  float hold_descent_mins = 5.0;	//  our current hold times are 5 mins could be variable
  float hold_climb_mins = 5.0;	//
  float rate_f = 1.0/ 120.0;  // for two mins
  int hold_descent_secs = hold_descent_mins * 60;	// making it effectively run every sec -- even input samples are irregular
  int hold_climb_secs = hold_climb_mins * 60;
  int new_flight_mode;
  int fp_update;
  int i;

// we don't know at what intervals the flight-phase calculation occur -- variable deltas
// so measure the time between cycles and then effectively interpolate so it 'runs' every second
// also if we do have samples below 5 Hz - don't go to hold_mode unless we see a climb/descend for 30 secs?

//  alt = flight_pta->baro_alt;
//  tim = flight_pta->secs;    // can we make this seconds from midnight - then don't need this hrs,mins,secs stuff


  if (fpcnt == 0)
    {
      logfile = fopen ("wx1_debug.txt", "w");
      last_baro = alt;
      last_tim = tim;
      ofp = fopen ("test_case_out.txt", "w");
      //      for (i = 0; i < FPFSIZE; i++) 	FPfilter[i] = 0;
      for (i = 0; i < CRSIZE; i++)
	CRtrend[i] = 0;

    }

  fpcnt++;


  delta_baro = alt - last_baro;
  last_baro = alt;

  dsecs = tim - last_tim;

  printf("fphase in %6.4f \n",flight_phase);

  printf("tim %d last_tim %d dsecs %d\n",tim, last_tim, dsecs);

  e_tim += dsecs;

  last_tim = tim;

  if (dsecs <= 0)
    {
      delta_baro = 0;
    }

  else
    {

      delta_baro = delta_baro * 60.0 / (float) dsecs;

      delta_alt_fpm = delta_baro;

      // limit delta_baro
      // is TCR 100 fpm a sufficient climb?  -- range likely to be 500 -- 3000 fpm

        // dead-band +/- 100
        if ((delta_baro < MCR) && (delta_baro > -MCR)) {
             delta_baro = 0;
        }
        else {
          delta_baro = limitVal(delta_baro,-TCR,TCR);
        }


      if ((delta_baro < MCR) && (delta_baro > -MCR))
	{
	  delta_baro = 0;
	}

      shiftL (CRtrend, CRSIZE, (int) delta_baro, 1);

      if (!hold_mode)
	{
	  //  shiftL (FPfilter, FPFSIZE, (int) delta_baro, dsecs);
	  delta_fp = (dsecs * delta_baro * TCR_scale * rate_f); // change when not holding  - by dsecs at scaled rate       

	  flight_phase += delta_fp ;// change when not holding  - by dsecs at scaled rate
	  fp_update = 1;

	  printf("fpcnt %d updating flight_phase %6.4f  by delta_fp %6.4f \n", fpcnt, flight_phase, delta_fp); 
	}

       if ((flight_mode == LEVEL) && (!hold_mode)) {
         // slew towards zero

         if (flight_phase > 0.0) {
            

	   flight_phase -=  minof(flight_phase,(rate_f * dsecs));
  
   	   printf("fpcnt %d slewing down last_fp %6.4f flight_phase %6.4f @   rate_f %6.4f \n",fpcnt, last_fp, flight_phase, rate_f); 

         }
         else if (flight_phase < 0.0) {

	   flight_phase += (rate_f * dsecs);

	   printf("fpcnt %d slewing up last_fp %6.4f flight_phase %6.4f @   rate_f %6.4f \n",fpcnt, last_fp, flight_phase, rate_f); 
         }



      }



     last_fp = flight_phase;        

 //  flight_phase = ave (FPfilter, FPFSIZE);	// int vector average

      ave_cr_val = ave (CRtrend, CRSIZE);	// short-term ave to determine flight path using three consecutive samples

      cr_val = ave_cr_val * TCR_scale;	// 

      //      printf("ave_cr_val %f cr_val %f \n", ave_cr_val, cr_val);

      //      flight_phase = flight_phase * TCR_scale;	// 

      flight_phase = limitVal(flight_phase, Min_flight_phase, Max_flight_phase);


  printf("fpcnt %d tim %d flight_mode %d hold_mode %d hold_descent_mode %d hold_climb_mode %d hold_flight_phase %6.2f delta_baro %6.2f cr_val %6.2f flight_phase %6.2f\n",
	 fpcnt, tim, flight_mode, hold_mode, hold_descent_mode, hold_climb_mode, hold_flight_phase, delta_baro, cr_val, flight_phase) ;



      new_flight_mode = checkFlightMode(cr_val, Climb_mode_threshold , Descent_mode_threshold);

      printf("fp_update %d  delta_fp %6.2f last_fp %6.2f new_flight_mode %d\n", fp_update, delta_fp, last_fp, new_flight_mode);

      // what is our flight_mode ?


           switch (new_flight_mode) {

                  case CLIMB:

                   if (flight_mode == DESCENT) { // previous mode was a descent - so we want to use that previous flight-phase
                                                 // if we were in descent flight phase territory
		     //                   <<[2]"setting descent hold mode from CLIMB transition %V$flight_phase\n"
                     if (min_flight_phase_reached ) {
                      flight_phase = Min_flight_phase;
                     }
              
                    if (flight_phase < 0.0) {
                      hold_descent_mode = hold_descent_secs; // for our hold countdown
                      hold_mode = 1;
                      hold_flight_phase = flight_phase;

//                      FPfilter = (hold_flight_phase * TCR);   // vector set
                      min_flight_phase_reached = 0;
                      }
                   }
                  else if (flight_mode == CLIMB) { 

                   if (flight_phase >= Max_flight_phase) {
                      max_flight_phase_reached = 1;
                   }
                   if (max_flight_phase_reached ) {
                    flight_phase = Max_flight_phase;
                   }

                    hold_flight_phase = flight_phase;   // when we transistion level - hold the last climb flight phase  
                    if (! (hold_descent_mode > 0)) {
                       hold_mode = 0;
                    }
                   }
                  else if (flight_mode == LEVEL) { 
                    if (! (hold_descent_mode > 0)) {
                       hold_mode = 0;
                    }

                  }

                  flight_mode = CLIMB;

		  //                   <<[2]"setting flight_mode to CLIMB transition %V$i $delta_baro $flight_phase $cr_val\n"
                  break;


               case DESCENT:
      
                  if (flight_mode == DESCENT) {

	   printf("updating hold_flight_phase %6.4f to flight_phase %6.4f min_flight_phase_reached?%d \n", hold_flight_phase, flight_phase,min_flight_phase_reached) ;

                   if (min_flight_phase_reached) {
                      flight_phase = Min_flight_phase ; // should be sticky as long as in descent mode
		      //<<[2]"setting %V$flight_phase to min \n"
                    }
 

                   hold_flight_phase = flight_phase;   // when we transistion - hold the last descent flight phase  
                   hold_climb_mode = 0;
                   hold_mode = 0;

                   if (flight_phase <= Min_flight_phase) {
                         min_flight_phase_reached = 1;
			 //<<[2]" %V$min_flight_phase_reached\n"
                   }

                  }

                  flight_mode = DESCENT;
		  printf(" flight_mode to descent %d\n", flight_mode);

                 break;

               case LEVEL:
                   // we are level or less than 100 climb/descent rate
         

                    if (flight_mode == DESCENT) {

                     if (min_flight_phase_reached ) {
                        flight_phase = Min_flight_phase;
                     }

		     // <<[2]"setting descent hold_mode from LEVEL transition %V$flight_phase  $min_flight_phase_reached \n"
 
                      if (flight_phase > 0.0) {
                      // reset FPfilter to current flight_phase
  //                     FPfilter = (flight_phase * TCR);   //
                      }

                     if (flight_phase < 0.0) {
                      hold_descent_mode = hold_descent_secs; // for our hold countdown
                      hold_mode = 1;
                      hold_flight_phase = flight_phase;

   //                   FPfilter = (hold_flight_phase * TCR);   // vector set
                      min_flight_phase_reached = 0;
                      }

                       hold_climb_mode = 0;

                      }

                      if (flight_mode == CLIMB) {

                          if (flight_phase > 0.0) {
                           hold_climb_mode = hold_climb_secs; // for our hold countdown
                           hold_mode = 1;
                           }

                         hold_flight_phase = flight_phase;
       
                        if (max_flight_phase_reached == 1) {
                          hold_flight_phase = Max_flight_phase;
                          flight_phase = Max_flight_phase;
                          max_flight_phase_reached =0;
     //                     FPfilter = (hold_flight_phase * TCR);   // vector set
                         }

			// <<[2]"setting hold_climb_mode from LEVEL transition %V$flight_phase $cr_val\n"

                       }

                        flight_mode = LEVEL;
                      break;
	   }



        printf("flight_mode now %d\n", flight_mode);

      checkHold(flight_mode, &flight_phase, &hold_flight_phase, dsecs, &hold_mode, &hold_descent_mode, &hold_climb_mode);

        printf("after hold now flight_phase %6.2f \n", flight_phase);

      flight_phase = limitVal(flight_phase,Min_flight_phase, Max_flight_phase);

      fprintf (logfile,
	       "tim %d dsecs %d d_alt_fpm %6.1f  hold_mode %d flight_mode %d cr_val %6.2f hold_fp %6.2f flt_phs %6.2f\n",
	       e_tim, dsecs, delta_alt_fpm, hold_mode, flight_mode, cr_val,
	       hold_flight_phase, flight_phase);



      printf("%d %f %f %f\n",tim,alt,delta_baro,flight_phase);
      fprintf(ofp,"%d %f %f %f\n",tim,alt,delta_baro,flight_phase);

      printf("fphase out %6.4f \n",flight_phase);

      *the_flight_phase = flight_phase;

    }

}


FILE *ifp;

int
main (int argc, char *argv[])
{
char line[1024];
char test_case[120];
float alt = 0;
float ftim = 0;
float c_flight_phase;
int tim;
int j = 0;
  // read in a txt file with rows of  time alt

 strcpy(test_case,argv[1]);

 ifp = fopen(test_case,"r");

 while (1) {
   if (fgets(line, 1024, ifp) == NULL)   break;
    sscanf(line,"%f %f",&ftim,&alt);
   //   printf("%d tim %f alt %f\n",++j,ftim,alt);
    tim = (int) ftim;
    calcFlightPhase (tim, alt, &c_flight_phase);
 }

  // output test rows of time alt delta_baro fphase ...

 fclose(ofp);
}

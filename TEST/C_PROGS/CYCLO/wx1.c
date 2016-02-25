/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** Header File:  
**
** Description:   This file contains all the routines used for hazard assessment
** 
** $Id: wx1.c 543 2010-04-27 20:17:41Z amterry $
**----------------------------------------------------------------------------
*/


/*  Added multiscan long and short range processes 02/5/01  */
/*  DSP1 Weather Process to match current FLW code 10/9/00  */

#include <math.h>
#include <sys\stat.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <mem.h>

#include "defines.h"
#include "IQ_Proc.h"
#include "wx2.h"
#include "units.h"
#include "radar.h"
#include "terr_max.h"
#include "flight_path_threat.h"
#include "flight_phase.h"
#include "auxiliary_threat_features.h"
#include "utilities.h"
#include "vert_features.h"
#include "dsp1.h"



//  TBD
//  Notes -- splitting LR and SR into separate functions
//  --- which phi_offset scheme to use  SB4 --- altitude dependent RE
//  --- what do we pick up in playback file that will determine this


// Gui Variables
extern GUI_PROC_DATA_TYPE GuiProcData;

float Panel_flight_phase = 0.0;
int   Use_PanelFlightPhase = 0;
int   Use_PanelSeeMoreSeeLess = 0;

float   SeeMoreSeeLess = 0;


/*NOTE: wx_init2( ), located in wx2.c, needs to be called if(init) is true.
                     init is true at the beginning of each sweep*/

float max_terr_angle;
float max_terr_angle_n;

void get_max_terrain_angle(unsigned int *bin_terrain,     // Terrain nibble code - need to convert to feet
                           unsigned int baro_alt,
                           unsigned int starting_bin);

void get_max_terrain_angle_nathan(unsigned int *bin_terrain,     // Terrain nibble code - need to convert to feet
                           unsigned int baro_alt,
                           unsigned int starting_bin);

void get_max_terrain_angle_re_da(unsigned int *bin_terrain, int baro_alt, float start_range); // for variable Re dependent on alt

float get_tilts( unsigned int baro_alt,
                unsigned int field_alt,
                float *phi_low,
                float *phi_high,
                float flight_phase
                ) ;

FILE *vfe_log = NULL;
FILE *logfile = NULL;  // MAT fp output for new flight_phase -- flight path threat assessment
FILE *fpdbfile = NULL;  // MAT fp debug output for new flight_phase -- flight path threat assessment
float theFlightPhase = 0.0; // MAT debug

float wx1_LR(  int range,
               float noise_floor,
               int init,
               short int *i,
               short int *q,
               float *output_power,
               float *r1_mag,
               float *r2_mag,
               int rb_count,
               int num_prfs,
               int scan_cnt,
               float scan_rate,
               unsigned long int *stc,
               DSP1_TERR_MAX_TYPE *terr_max,
               float baro_alt,
               int sweep_direction,
               int new_scan,
               unsigned char Bar,
               FLIGHT_PATH_THREAT_TYPE *flight_pta)   // this also contains flight_phase 
                                              
{

   FILE *fpt;
   char tmp_str[32];
   int pulses, bin, pulse, start_pulse, input_index;
   float pin, real_product, imag_product, temp, beta1, beta2, lag2beta1, lag2beta2;

   static int last_scan_cnt = 0;
   float init_beta;

   static unsigned int bin_terrain[512];
   static unsigned int bin_terrain_extra[2][512/TERRAIN_SPREAD_BIN_STEP];
   unsigned int tmp_terrain;
   float horizon_range;
   int horizon_bin;

   unsigned int temp_elev;
   unsigned int temp_baro_alt;
   float temp_scan_stretch;
   float temp_scan;
   float temp_float;
   int temp_int;
   unsigned int uint_temp;

   static unsigned int equatorial_pct;
   static unsigned int under_max = 0;
   static unsigned int under_min = 0;
   static int terr_angle = -85;
   static unsigned int addr_hits[256];
   static unsigned int total_hits;
   static unsigned int sea_hits;
   static int terrain_startup = 0;
   static int first_wx_proc1_call = 1;
   static unsigned int land_sea_pct = 0;

   static unsigned int max_terrain_under_plane = 0;
   static unsigned int min_terrain_under_plane = 0;
   static unsigned int max_min_elev_update; // 0 for false, 1 for true Test variable
   // variables for FPHA Flight Based Antenna Control


   static float sb4_phi_low = 0;


   if (first_wx_proc1_call == 1)
   {
      // init addr_hits to zero
      memset(addr_hits, 0,sizeof(unsigned int)*256);
      first_wx_proc1_call = 0;
      max_terr_angle = -20.0;
      max_terr_angle_n = -20.0;
   }


   // Do end of sweep processes...
   if (new_scan)
   {
      temp_baro_alt = max(terr_max->baro_alt,0);

      if (max_min_elev_update == 1)
      {
         // update prev_max_elev & prev_min_elev

         // choose greater of (max - 6000 ft) or (2*min + LimMax)/3
         //        where LimMax = lessor of max or (min + 3000)
         terr_max->current_sweep_max_elev &= 0x3f;
         terr_max->current_sweep_min_elev &= 0x3f;
        
         if (Terrain_table[terr_max->current_sweep_max_elev] >
            (Terrain_table[terr_max->current_sweep_min_elev] + 3000))
               temp_int = Terrain_table[terr_max->current_sweep_min_elev] + 3000;
         else
            temp_int = Terrain_table[terr_max->current_sweep_max_elev];

         temp_int = (int)(0.33333*(float)(temp_int + 2*Terrain_table[terr_max->current_sweep_min_elev]));

         if ((Terrain_table[terr_max->current_sweep_max_elev] - 6000) > temp_int)
            temp_int = Terrain_table[terr_max->current_sweep_max_elev] - 6000;

         if (terrain_startup <= 3)
         {
            // initialize terrain elev on first three sweeps //
            terr_max->prev_sweep_max_elev = temp_int;
            terrain_startup += 1;
         }
         else
         {
            // limit the change in terrain elev to 1000 ft per sweep //
            if ((terr_max->prev_sweep_max_elev - temp_int) > 1000)
               terr_max->prev_sweep_max_elev -= 1000;
            else
               terr_max->prev_sweep_max_elev = temp_int;
         }

         // divide this value by 250 so it fits in a byte //  This value is not currently used anywhere.  It is (nibble-1)*2+1
         terr_max->prev_sweep_min_elev =
            (unsigned int)(0.004*(float)Terrain_table[terr_max->current_sweep_min_elev]);

         // Calculate computed_alt_offset
         terr_max->computed_altitude_offset = -(int)terr_max->prev_sweep_max_elev;

         // keep the offset < -32k ft so that it fits in 16 bit representation //
         if (terr_max->computed_altitude_offset < -32000)
            terr_max->computed_altitude_offset = -32000;
      }

      // calculate equatorial pct
      uint_temp = (unsigned int)fabs(terr_max->lat_rad*57.29577951);
      if (uint_temp > 25)
         equatorial_pct = 0;
      else
      {
         if (uint_temp < 20)
            equatorial_pct = 100;
         else
            equatorial_pct = 20*(25 - uint_temp);
      }

      // if <= 30000ft, decrease equatorial percent until 0 at 20000ft //
      if (temp_baro_alt <= 30000.0)
      {
         temp_baro_alt = max(1,temp_baro_alt);
         temp_float = 3.0 * (float)equatorial_pct * ((temp_baro_alt - 20000.0)/temp_baro_alt);
         if (temp_float < 0.0)
            temp_float = 0.0;
         equatorial_pct = (int)(temp_float + 0.5);
      }

      // calculate clutter_start (don't need to calculate radar_horiz or mtn_radar_horiz like in the box
      terr_max->clutter_rng = (int)(1.476 + 0.0015*temp_baro_alt -
                                       3.896e-9*temp_baro_alt*temp_baro_alt);

      terr_max->horiz_rng = (int)(1.229*sqrt(temp_baro_alt)) + 20;
      if (terr_max->horiz_rng < MIN_RADAR_HORIZON_RANGE)
         terr_max->horiz_rng = MIN_RADAR_HORIZON_RANGE;

      // set max_elev and min_elev and under_max
      max_min_elev_update = 0;
      terr_max->current_sweep_max_elev = 0;
      terr_max->current_sweep_min_elev = 63;
      under_max = 0;
      under_min = 63;

      // init total_hits and sea_hits
      terr_angle = -85;
      total_hits = 0;
      sea_hits = 0;

      // Do a loop to find Land_Sea_Pct
      while (terr_angle <= 85)
      {
         // terr_angle lsb = 1 deg, convert it to radians //
         temp_scan = terr_max->hdg_rad + 1.74532925e-2*(float)terr_angle;

         uint_temp = land_sea_calc(terr_max->lat_rad,
                              terr_max->lon_rad,
                              temp_scan,
                              terr_max->clutter_rng,
                              terr_max->horiz_rng,
                              total_hits,
                              addr_hits);

         // Update total_hits and sea_hits
         total_hits = total_hits + (uint_temp & 0xff);
         sea_hits = sea_hits + ((uint_temp >> 8) & 0xff);

         // Increment Loop counter
         terr_angle += 7;

         //------------------------------------------------------------
         // Call terrain_max with clutter start range = 0 and
         // radar_horizon_range = 20 to get value of terrain patch directly below.
         //------------------------------------------------------------

         // Pass terr_angle in the sweep_direction parameter.  This forces
         // each call to use the current data

         // Set mountain horizon to max range //
         temp_elev = terrain_max(terr_max->lat_rad,
                                 terr_max->lon_rad,
                                 0.0,                // hdg_rad
                                 temp_scan,        // tgt_hdg
                                 0,                // clutter_rng or start_rng
                                 20,               // horiz_rng or end_rng
                                 1,
                                 bin_terrain);

         // Set under_max
         if ((temp_elev & 0x3f) > under_max)
            under_max = temp_elev & 0x3f;

         if ( ( ( temp_elev >> 8) & 0x3f ) < under_min )
            under_min = ( ( temp_elev >> 8) & 0x3f );

      }

      // Test
      terr_max->under_max = under_max;  // under_max is in nibble land
      terr_max->under_min = under_min;  // under_min is in nibble land
      terr_max->total_hits = total_hits;
      terr_max->sea_hits = sea_hits;
      terr_max->land_sea_ratio = (float)sea_hits/(float)total_hits;

      // Compute Land_Sea_Pct
      if (total_hits != 0)
         temp_float = (float)sea_hits/(float)total_hits;
      else
         temp_float = 0;

      // if > 90% hits are water then set % to 100 //
      if (temp_float >= 0.9)
         land_sea_pct = 100;
      else
      {
         // if < 70% hits are water then set % to 0 //
         if (temp_float <= 0.7)
            land_sea_pct = 0;
         else
            land_sea_pct = (int)500.0*(temp_float - 0.7);
      }
      // if baro alt <= 30000ft, decrease land_sea_pct until 0 at 20000ft //
      if (temp_baro_alt <= 30000.0)
      {
         temp_baro_alt = max(temp_baro_alt,1); // Keep temp_baro_alt positive so we don't divide by zero
         temp_float = 3.0 * (float)land_sea_pct * ((temp_baro_alt - 20000.0)/temp_baro_alt);
         if (temp_float < 0.0)
            temp_float = 0.0;
         land_sea_pct = (int)(temp_float + 0.5);
      }

      // Compute Terrain_Under_Plane
      // divide this value by 250 so it fits in a byte //  This is what chuck does...
      //max_terrain_under_plane = (unsigned int)(0.004*(float)Terrain_table[under_max & 0x3f]);
      //min_terrain_under_plane = (unsigned int)(0.004*(float)Terrain_table[under_min & 0x3f]);
      // I don't want to do it that way because it's confusing, just use the actual terrain in feet.

      max_terrain_under_plane = (unsigned int)((float)Terrain_table[under_max & 0x3f]);
      min_terrain_under_plane = (unsigned int)((float)Terrain_table[under_min & 0x3f]);


      // MAT max   L45  cen    R45  - slope of terrain lower beam intersect ?

         temp_elev = terrain_max(terr_max->lat_rad,
                                 terr_max->lon_rad,
                                 (flight_pta->thdg * DEGREES_TO_RADIANS),                // hdg_rad
                                 (DEGREES_TO_RADIANS * 45),        // tgt_hdg
                                 0,                // clutter_rng or start_rng
                                 80,               // horiz_rng or end_rng
                                 1,
                                 bin_terrain);

         flight_pta->R45_max = (unsigned int)((float)Terrain_table[temp_elev & 0x3f]);


         temp_elev = terrain_max(terr_max->lat_rad,
                                 terr_max->lon_rad,
                                 (flight_pta->thdg * DEGREES_TO_RADIANS),                // hdg_rad
                                 0,        // tgt_hdg
                                 0,                // clutter_rng or start_rng
                                 80,               // horiz_rng or end_rng
                                 1,
                                 bin_terrain);

         flight_pta->CH_max = (unsigned int)((float)Terrain_table[temp_elev & 0x3f]);


         temp_elev = terrain_max(terr_max->lat_rad,
                                 terr_max->lon_rad,
                                 (flight_pta->thdg * DEGREES_TO_RADIANS),                // hdg_rad
                                 (-45 * DEGREES_TO_RADIANS),        // tgt_hdg
                                 0,                // clutter_rng or start_rng
                                 80,               // horiz_rng or end_rng
                                 1,
                                 bin_terrain);

        flight_pta->L45_max = (unsigned int)((float)Terrain_table[temp_elev & 0x3f]);






      // Save equatorial_pct, land_sea_pct, and terrain_under_plane to terr_max
      terr_max->equatorial_pct = equatorial_pct;
      terr_max->land_sea_pct = land_sea_pct;
      terr_max->min_terrain_under_plane = min_terrain_under_plane;

      // Save the max_terr_angle for looking at later on
      terr_max->max_terr_angle = max_terr_angle;
      terr_max->max_terr_angle_n = max_terr_angle_n;

      // New flight phase code
      if( (Horiz_Sweep(Bar)) ) //do not run during vertical sweeps
      {  // New flight phase code
      // MAT I don't think this is the best place to call flight-phase
      // New flight phase code
         flight_pta->scan_cnt = scan_cnt;
         flight_pta->baro_alt = baro_alt;

         if (scan_cnt != last_scan_cnt) {   // do this per scan_cnt increment

            // calcFlightPhase(flight_pta );
            checkFPThreat(flight_pta);                      
         }


         last_scan_cnt = scan_cnt;


      }

      // Call tilt computing function, limits tilts at low alt and flat terrains
      sb4_phi_low = get_tilts(  (unsigned int)baro_alt,
                                 min_terrain_under_plane, //(unsigned int)( (under_min * 500)-250 ),
                                 &terr_max->phi_low,
                                 &terr_max->phi_high,
                                 flight_pta->FlightPhase.flight_phase );

      // Reset these for the next sweep
      max_terr_angle = -20.0;
      max_terr_angle_n = -20.0;

   }  // End of End of Sweep processes

   memset( bin_terrain, 0, 512*sizeof(unsigned int) );

   temp_baro_alt = max(terr_max->baro_alt,0);

   terr_max->horiz_rng = (int)(1.229*sqrt(temp_baro_alt)) + 20;
   if (terr_max->horiz_rng < MIN_RADAR_HORIZON_RANGE)
      terr_max->horiz_rng = MIN_RADAR_HORIZON_RANGE;

   temp_elev = terrain_max(   terr_max->lat_rad,
                              terr_max->lon_rad,
                              terr_max->hdg_rad,
                              terr_max->scan_angle_rad[0],
                              terr_max->clutter_rng,
                              terr_max->horiz_rng,
                              1,
                              bin_terrain);

   if ( fabs(terr_max->scan_angle_rad[0]) <= 1.48352986 ) // |angle| < 85 degrees; 85*pi/180 = 1.48352986
   {
      if ((temp_elev & 0x3f) > terr_max->current_sweep_max_elev)
         terr_max->current_sweep_max_elev = temp_elev & 0x3f;

      if (((temp_elev >> 8) & 0x3f) < terr_max->current_sweep_min_elev)
         terr_max->current_sweep_min_elev = (temp_elev >> 8) & 0x3f;

      max_min_elev_update = 1;

   }

   // Put in new Ant Tilt Calculation Code
   // Call my function for max_angle_to_terr
   get_max_terrain_angle_nathan( bin_terrain,terr_max->baro_alt, 0);

   // Call chuck's function for max_angle_to_terr
   get_max_terrain_angle( bin_terrain,terr_max->baro_alt, 3);


   // MAT TBD
   // use new variable Re dependent on alt --- what should start range be
   // find out and use
   // following call goes in when the variable Re dependent of Alt version is in the radio
   // and we want to play back

   //get_max_terrain_angle_re_da(bin_terrain, terr_max->baro_alt, start_range);



   // Do Terrain Spreading Calls... (Fondly referred to as Psycho Desense)
   if ((GuiProcData.PsychoDesense) && (Bar == 1)) // Only do the desense for the terrain on the lower beam, which is bar 1
   {
      temp_elev = terrain_max(terr_max->lat_rad,
                              terr_max->lon_rad,
                              terr_max->hdg_rad,
                              (terr_max->scan_angle_rad[0] - TERRAIN_SPREAD_OFFSET),
                              350,
                              0,
                              TERRAIN_SPREAD_BIN_STEP,
                              bin_terrain_extra[0]);

      temp_elev = terrain_max(terr_max->lat_rad,
                              terr_max->lon_rad,
                              terr_max->hdg_rad,
                              (terr_max->scan_angle_rad[0] + TERRAIN_SPREAD_OFFSET),
                              350,
                              0,
                              TERRAIN_SPREAD_BIN_STEP,
                              bin_terrain_extra[1]);

      /*------------------------------------------------------------
      ** Get max of three radials, then max of bin, bin+/- offset.
      **------------------------------------------------------------
      */
      terrain_spreader(TERRAIN_SPREAD_BIN_STEP, bin_terrain_extra, bin_terrain);
   }


   // Finish Terrain work - Only done for long range data
 

   if( scan_rate == 0 )
      scan_rate = 1;

   if (rb_count > 504) {
     rb_count = 504; // what should this be ?
   }
   for (bin = 0; bin < rb_count; bin++)
   {
         pin = (i[bin] * i[bin]) + (q[bin] * q[bin]);
         output_power[bin] = pin;

         //put terrain in bits 8 - 12 of the STC word
         if(stc[bin] > 255)
            stc[bin] = 255;

         //because stc starts at bin 8 and terrain starts at bin 0, offset terrain bin
         stc[bin] = ((bin_terrain[max(bin+8, 0)] & 0x3f) << 8) | stc[bin];
   }



   return sb4_phi_low;

} // end wx1_LR()



void wx1_SR(   int range,
               float noise_floor,
               int init,
               short int *i,
               short int *q,
               float *output_power,
               float *r1_mag,
               float *r2_mag,
               int rb_count,
               int num_prfs,
               int scan_cnt,
               float scan_rate,
               float baro_alt,
               int sweep_direction,
               int new_scan,
               unsigned char Bar
               )
{
  
   int pulses, bin, pulse, start_pulse, input_index;
   float pin, real_product, imag_product, temp, beta1, beta2, lag2beta1, lag2beta2;
   static float lp_pwr[2][512], ilast[2][512], qlast[2][512], i2last[2][512],
             q2last[2][512], test_lp[2][512], p1_avg[2][512], pin_last[2][512];
   static float lag1_auto_real[2][512], lag1_auto_imag[2][512], lag2_auto_real[2][512],
             lag2_auto_imag[2][512];
   static init_count= 0;
  // static int last_scan_cnt = 0;
   float init_beta;
 
   unsigned int tmp_terrain;
   float horizon_range;
   int horizon_bin;
 
   unsigned int temp_elev;
   unsigned int temp_baro_alt;   
   float temp_scan_stretch;
   float temp_scan;
   float temp_float;
   int temp_int;
   unsigned int uint_temp;

   // variables for FPHA Flight Based Antenna Control


   // we need this to happen for SR

   if( init  )
   {  /*once per sweep*/
      init_count = 0;
   }

   
   init_count++;

   init_beta = 1/init_count;

   if( scan_rate == 0 )
      scan_rate = 1;

   beta1 = 0.0625 * scan_rate/16.0;
   beta1 = max( beta1, init_beta);
   beta2 = 1 - beta1;
   lag2beta1 = beta1 * 1.5; //1.5 * 1/16 * scan_rate/16
   lag2beta2 = 1 - lag2beta1;


   if (init  )
   {  //init mode, short range

      if (rb_count > 253) {
         rb_count = 253; // what should this be ? --- guard because of EOS FIX! 
      }
 
      for (bin = 0; bin < rb_count; bin++)
      {
         qlast[SR][bin] = q[bin];
         ilast[SR][bin] = i[bin];
         lag1_auto_real[SR][bin] = 0;//auto_cor_real
         lag1_auto_imag[SR][bin] = 0;//auto_cor_imag
         lag2_auto_real[SR][bin] = 0;
         lag2_auto_imag[SR][bin] = 0;
         pin = (i[bin] * i[bin]) + (q[bin] * q[bin]);
         p1_avg[SR][bin] = pin;
         lp_pwr[SR][bin] = pin;
         test_lp[SR][bin] = 0;
         pin_last[SR][bin] = pin;
         //lp_pwr[SR][bin] = ti_10log10(noise_floor);//10 * log10(noise_floor);
      }
   }



   for (bin = 0; bin < rb_count; bin++)
   {
      if (init == 0)
      {   /* first pulse process */
         pin = (i[bin] * i[bin]) + (q[bin] * q[bin]);
         ilast[SR][bin] = i[bin];
         qlast[SR][bin] = q[bin];
         i2last[SR][bin] = 0;
         q2last[SR][bin] = 0;
         //p1_avg[SR][bin] = pin;
         //lp_pwr[SR][bin] = pin;
         /* test for alien */
         if (pin <= 5 * fabs(test_lp[SR][bin]))
         {
            p1_avg[SR][bin] = 0.1875 * pin +
                                     0.8125 * fabs(p1_avg[SR][bin]);
            test_lp[SR][bin] = 0.5 * fabs(test_lp[SR][bin]) +
                                      0.5 * pin;
            /* test for tail clip */
            if (test_lp[SR][bin] < 0.4*lp_pwr[SR][bin])
            {  //clip tail
               lp_pwr[SR][bin] = 0.1 * lp_pwr[SR][bin] +
                                        0.9*pin - 50;
               lag1_auto_real[SR][bin] *= 0.4;
               lag1_auto_imag[SR][bin] *= 0.4;
            }

         }
         else
         {//alien
            if (test_lp[SR][bin] < noise_floor)
               test_lp[SR][bin] = noise_floor;
            test_lp[SR][bin] *= -10;
         }
      }
      for (pulse = 1; pulse < 4; pulse++)
      {
         input_index = (rb_count * pulse) + bin;
         pin = (i[input_index] * i[input_index]) +
               (q[input_index] * q[input_index]);
         if (p1_avg[SR][bin] >= 0)
         {  /*last pulse not noise*/
            if (pin <= 5*fabs(test_lp[SR][bin]) )
            {  /*not alien*/
               temp = test_lp[SR][bin];
               test_lp[SR][bin] = 0.5 * pin +
                                         0.5 * fabs(test_lp[SR][bin]);
               if (temp > 0)
               {  /* last pulse is not alien */
                  imag_product = i[input_index]*qlast[SR][bin] -
                                 q[input_index]*ilast[SR][bin];
                  real_product = q[input_index]*qlast[SR][bin] +
                                 i[input_index]*ilast[SR][bin];
                  lp_pwr[SR][bin] = beta1 * pin +
                                          beta2 * lp_pwr[SR][bin];
                  lag1_auto_imag[SR][bin] = beta1 * imag_product +  //Autocor_imag
                                        beta2 * lag1_auto_imag[SR][bin];
                  lag1_auto_real[SR][bin] = beta1 * real_product +  //Autocor_real
                                        beta2 * lag1_auto_real[SR][bin];

                  imag_product = i[input_index] * q2last[SR][bin] -
                                 q[input_index] * i2last[SR][bin];
                  real_product = q[input_index] * q2last[SR][bin] +
                                 i[input_index] * i2last[SR][bin];
                  lag2_auto_imag[SR][bin] = lag2beta1 * imag_product +  //Lag2Auto_imag
                                  lag2beta2 * lag2_auto_imag[SR][bin];
                  lag2_auto_real[SR][bin] = lag2beta1 * real_product +
                                  lag2beta2 * lag2_auto_real[SR][bin];
               }
            }
            else
               /*alien*/
               test_lp[SR][bin] = -2 * fabs(test_lp[SR][bin]);
         }
         q2last[SR][bin] = qlast[SR][bin];
         i2last[SR][bin] = ilast[SR][bin];
         qlast[SR][bin] = q[input_index];
         ilast[SR][bin] = i[input_index];
      }/* all pulses done */

      output_power[bin] = lp_pwr[SR][bin];
      r1_mag[bin] = (lag1_auto_real[SR][bin] *
                     lag1_auto_real[SR][bin]) +
                    (lag1_auto_imag[SR][bin] *
                     lag1_auto_imag[SR][bin]);
      r2_mag[bin] = (lag2_auto_real[SR][bin] *
                     lag2_auto_real[SR][bin]) +
                    (lag2_auto_imag[SR][bin] *
                     lag2_auto_imag[SR][bin]);

      /*second range detection*/
      if( (fabs(p1_avg[SR][bin]) * K1) < lp_pwr[SR][bin] )
      {  /*second range contamination*/
         /*set output power to the clear region estimate*/
         output_power[bin] = fabs(p1_avg[SR][bin]);
         /*set turb producing r1_mag to remove turb alarm*/
         //r1_mag[bin] = //p1_avg[SR][bin] * p1_avg[SR][bin] *
         //              p1_avg[SR][bin] * p1_avg[SR][bin] * K2;
         /*set GCS producing r2_mag to remove clutter detection*/
         r2_mag[bin] = //p1_avg[SR][bin] * p1_avg[SR][bin] *
                       p1_avg[SR][bin] * p1_avg[SR][bin] * K3;
      }
   } // end for loop on bin #

} // end wx1_SR()

/*.BH------------------------------------------------------------------------
;* Routine:       get_max_terrain_angle
;*
;* Syntax:        get_max_terrain_angle(*bin_terrain, baro_alt, starting_bin)
;*
;* Description:   Determines highest depression angle to all the bins considered.
;*
;* Calls:         None
;*
;* Returns:       Void
;*
;* Algorithm:     Uses recursive method to determine maximum angle.
;*
;*                Depression angle = -asin(alt/(R*6076) + R/(2*re))
;*                alt = corrected altitude, R = range in NM, re = effective earth radius
;*                Using small angle asin approximation;
;*                Depression angle = -(alt/(R*6076) + R/(2*re))
;*                Multiplying both sides by R;
;*                R*a = -alt/6076 - R^2/(2*re)
;*                if R*a for current bin > R*amax, increment amax by 1/4 degree
;*
;* Special Notes: None
;*.EH------------------------------------------------------------------------
*/

void get_max_terrain_angle_nathan(unsigned int *bin_terrain,     // Terrain nibble code - need to convert to feet
                                  unsigned int baro_alt,
                                  unsigned int starting_bin)
{

   float temp_alt;
   float ft_to_current_bin;
   const float Re_ft = EARTH_RADIUS_NM * 6076.1155 * 0.8;
   unsigned int bin;
   //float max_terr_angle = -20.0;
   unsigned int start_bin;
   float terr_angle;

   for ( bin = starting_bin; bin < 512; bin++)
   {
      temp_alt = baro_alt - (bin_terrain[bin]*500.0 - 250.0);   // convert nibbles to feet

      ft_to_current_bin = (bin+1)*FT_PER_LR_BIN;                // Compute feet to the current bin

      terr_angle = - ( ( (temp_alt) / (ft_to_current_bin) ) +
                           ( ft_to_current_bin /(2*Re_ft) ) );
      terr_angle *= 180/PI;
      max_terr_angle_n = max(max_terr_angle_n,terr_angle);
   }

}

/*.BH------------------------------------------------------------------------
;* Routine:       get_max_terrain_angle
;*
;* Syntax:        get_max_terrain_angle(*bin_terrain, baro_alt, starting_bin)
;*
;* Description:   Determines highest depression angle to all the bins considered.
;*
;* Calls:         None
;*
;* Returns:       Void
;*
;* Algorithm:     Uses recursive method to determine maximum angle.
;*
;*                Depression angle = -asin(alt/(R*6076) + R/(2*re))
;*                alt = corrected altitude, R = range in NM, re = effective earth radius
;*                Using small angle asin approximation;
;*                Depression angle = -(alt/(R*6076) + R/(2*re))
;*                Multiplying both sides by R;
;*                R*a = -alt/6076 - R^2/(2*re)
;*                if R*a for current bin > R*amax, increment amax by 1/4 degree
;*
;* Special Notes: None
;*.EH------------------------------------------------------------------------
*/

void get_max_terrain_angle(unsigned int *bin_terrain,     // Terrain nibble code - need to convert to feet
                           unsigned int baro_alt,
                           unsigned int starting_bin)
{

   int temp_alt;
   float R;            // Range in feet to the Current Bin
   unsigned int bin;
   //float max_terr_angle = -20.0;
   unsigned int start_bin;
   float terr_angle;
   float K_Re;
   float K_nm;

   K_nm = 1.0/6076.0;
   K_Re = 1.0/(2.0 * EARTH_RADIUS_NM * 0.8); // changed this to match the box... There is some problems here b/c not all our data looks like this


   for ( bin = starting_bin; bin < 512; bin++)
   {
      temp_alt = baro_alt - (bin_terrain[bin]*500 - 250);   // convert nibbles to feet

      R = (bin + 4)*NM_PER_LR_BIN;                // Compute nautical miles to the current bin

      terr_angle = - temp_alt * K_nm - ( R * R * K_Re );
      terr_angle *= 180/PI;

      if ( (terr_angle) > (R * max_terr_angle) )
      {
         max_terr_angle += .125;
      }
   }
}

float eeR( int alt_feet)
{
// Ke = (1.356 + 0.1296 * H)/ (1 +0.1318 *H)  --- H in km
// Ke is effective earth radius factor

   float H = (alt_feet * FEET_TO_KM);
   float Ke = (1.356 + 0.1296 * H)/ (1 +0.1318 *H) ;       // from Northrop - B00NA1050ZR001 page 22
   float Re = Ke * ROE_NM;
   return ( Re);
}

float eeRpoly4 (int alt)
// alt in feet
{
// poly 4th order fit to
// Ke = (1.356 + 0.1296 * H)/ (1 +0.1318 *H)  --- H in km
   float alt2 = alt * alt;
   float Re = 4659.639 -0.046042577*alt
               +1.19789538e-6f*alt2 - 1.7472342e-11f * alt * alt2
               +1.0269501e-16*alt2*alt2;
   return Re;
}


/*
**.BH------------------------------------------------------------------------
** Routine:       get_max_terrain_angle_re_da
**
** Syntax:        get_max_terrain_angle(*bin_terrain, baro_alt, start_range)
**
** Description:   Determines highest depression angle to all the bins considered.
**
** Calls:         None
**
** Returns:       Void
**
** Algorithm:     Uses recursive method to determine maximum angle.
**
**                Depression angle = -asin(alt/(R*6076) + R/(2*re))
**                alt = corrected altitude, R = range in NM, re = effective earth radius
**                Using small angle asin approximation;
**                Depression angle = -(alt/(R*6076) + R/(2*re))
**                Multiplying both sides by R;
**                R*a = -alt/6076 - R^2/(2*re)
**                if R*a for current bin >= R*amax, increment amax by 1/8 degree
**
** Special Notes: this version uses an Re dependent on altitude
**    Ke = (1.356 + 0.1296 * H)/ (1 +0.1318 *H)  --- H in km     effective earth radius factor
**.EH------------------------------------------------------------------------
*/
void get_max_terrain_angle_re_da(unsigned int *bin_terrain, int baro_alt, float start_range)
{
 //  static int ktimes = 0;
 //  static int ta_errors =0;

   int alt_over_terrain;
   float R;            // Range in feet to the Current Bin
   unsigned int bin;
   //float max_terr_angle = -20.0;
   unsigned int start_bin;
   float terr_angle;

   float angles[512];
   float ire;
//   float ire2;
   float Re;
   float R2;
   int i;

   start_bin = (int)(start_range*NM_TO_BIN + 0.5f);

   R = (float)(start_bin+4)*BIN_TO_NM;
   Re = eeRpoly4(baro_alt);
   //ire =  1.0 / (2 * eeRpoly4(baro_alt)) ;    // poly seems to good to 0.1 deg
   //ire2 =  1.0 /  (2 * eeR(baro_alt)) ;  //  debug check with exact


   for (i = 0; i < 512; i++)
        angles[i] =0.0;


   for ( bin = start_bin; bin < 512; bin++)
   {
      alt_over_terrain = baro_alt - (bin_terrain[bin]*500 - 250);   // convert nibbles to feet

      terr_angle= -Re * alt_over_terrain*FEET_TO_NM - (R *R )/2.0;
      angles[bin] = terr_angle/R;
      R2 = Re *R * max_terr_angle;      // referencing a GLOBAL here - pass in struct instead?
      if (terr_angle > R2)
      {
         max_terr_angle += ANGLE_STEP;
      }


      R += BIN_TO_NM;                // Compute nautical miles to the next bin
//      if (ktimes++ < 26)
// fprintf(logfile,"V2a bin %d ba %d alt_ovt %d terr_ang %f mta %f R %f\n",bin,baro_alt,alt_over_terrain,terr_angle,max_terrain_angle, R);
#if 0
      if ( fabs(terr_angle2 -terr_angle) > 0.1) {
          ta_errors++;
      }
#endif
   }
}

/*-----------------------------------------------------------------------------
*  This routine is designed to compute the tilts for the upper and lower beams
*  Inputs
*     Field_Alt - lowest alt in the 20nm range
*     Baro_Alt - self_expanatory
*     max_terr_angle - most positive angle to terrain in view (in degrees)
*
*
*----------------------------------------------------------------------------*/
float get_tilts( unsigned int baro_alt,
                unsigned int field_alt,
                float *phi_low,
                float *phi_high,
                float flight_phase
                )
{

   unsigned int alt_correct;
   float phi_base;
   float sb4_C1 = -3.386e-4;
   float C1 = -3.126e-4;//-3.386e-4; //-3.524e-4;  The new value is used b/c of using 80% * 4/3 Re
   float phi_offset_max;
   float phi_offset;
   float sb4_phi_low;

   //calc sb4_phi_low, sb4_phi_low is only for comparison purposes
   alt_correct = max( (baro_alt - field_alt), 1);
   phi_base = sb4_C1 * alt_correct + 3.5; // when the airplane is on the ground on a flat field, we still want the antenna to be pointed up 3.5 deg

   // Something here is busted...
   if (phi_base > max_terr_angle)
      sb4_phi_low = phi_base;
   else
      sb4_phi_low = max_terr_angle;
   //end calc sb4_phi_low

   //calc phi_low for FPHA V2.0
   phi_offset_max = min( max((baro_alt*5e-5 - 0.5),0),0.5 );
   phi_offset = min(flight_phase * phi_offset_max , 0);

   alt_correct = max( (baro_alt - field_alt), 0);
   phi_base = C1 * alt_correct + 1.5;
   *phi_low = max((phi_base + 1.4375), max_terr_angle) - 1.4375;
   *phi_low = max( *phi_low, (phi_offset - 0.01716 * sqrt(baro_alt)) );
   //end calc phi_low for FPHA V2.0

   //calc phi_high
   *phi_high = *phi_low + 1.4375;

   return sb4_phi_low;
}


/*
**.BH------------------------------------------------------------------------
** Routine:      calculate_antenna_tilt_re_da
**
** Syntax:       calculate_antenna_tilt_da(baro_alt, lowest_nearby_terrain, *angle_array, float flight_phase)
**
** Description:  Converts max terrain angle to 1/64 degree scaling,
**               returns it to calling routine.
**
** Calls:        None
**
** Returns:      max terrain angle
**
** Algorithm:    Correct baro for lowest nearby terrain
**               Calculate base tilt value based on altitude
**               Use max of base tilt value and most max terrain angle
**               Limit tilt value
**               Convert to degrees
**               Convert to 1/64 degrees
**               Round off to integer
**
** Special Notes: this is the variable Re dependent on altitude version - instead of the 80% of 4/3 earth radius
**.EH------------------------------------------------------------------------
*/

//float Phi_offset_max;
//float Phi_offset;
//float Phi_low;


void calculate_antenna_tilt_re_da(int baro_alt, int lowest_nearby_terrain, int *angle_array, float flight_phase )
{
  //static int last_baro_alt =0;
  // static int last_lnt = 0;
   // static float last_flight_phase = 0.0;
   unsigned int alt_correct;
   float phi_base;
   float max_angle_degrees;
   float phi_low;
   //static float phi_low_1;

   int i;

   float result;
   float InvRe;  // nmiles
   float phi_offset;
   float phi_offset_max;
   float phi_low_fp;
   float mba;
   float AlphaHoriz;     // 1.039587 * sqrt(baro_alt/ re)   - where re  is
      InvRe = 1.0 / (eeRpoly4(baro_alt)) ;    // new effective earth radius dependent on alt

   phi_low = 0.0;
   mba = max ((baro_alt * 5e-5f - 0.5),0);     //  this is null atorbelow 10,000
 //  phi_offset_max = min( max((baro_alt * 5e-5f - 0.5),0),.5);

   phi_offset_max = min(mba, 0.5);

   // need to read out flight phase - flight_phase 1 is climb, 0 cruise, -1 descent
  // in climb mode we want the beam to be looking higher into weather we are about
  // to climb into?



    phi_offset = min(flight_phase * phi_offset_max,0);   // climb and steady state no offset



   alt_correct = max( (baro_alt - lowest_nearby_terrain), 0);
   // ? if below nearby terrain


   phi_base = PHI_BASE_K_V2a * alt_correct + 1.5;
// phi_base = PHI_BASE_K_V2a * alt_correct + 2.5;  // just compare Re adjustment
   // when the airplane is on the ground on a flat field, we still want the antenna to be pointed up 1.5 deg
   // MAT  N.B. new lower angle 1.5
   //  max_terrain_angle in radians
   max_angle_degrees = min(UPPER_TILT_LIMIT, max(LOWER_TILT_LIMIT,max_terr_angle));
   max_angle_degrees *= RADIANS_TO_DEGREES;


   {
      phi_low = max(phi_base + MULTISCAN_BEAM_SEPARATION/64.0, max_angle_degrees) - MULTISCAN_BEAM_SEPARATION/64.0;


        AlphaHoriz = 1.039587 * sqrt( baro_alt * InvRe);
        phi_low_fp =  (phi_offset-AlphaHoriz);

 //     if (FlightPhase != 0.0)                 // and not below 10000
        phi_low = max(phi_low, phi_low_fp);   // MAT debug
   }


   angle_array[0] = (int)floor(phi_low * 64.0f + 0.5f);
   angle_array[1] = angle_array[0] + MULTISCAN_BEAM_SEPARATION;

#if 0
   if (baro_alt != last_baro_alt ||
       lowest_nearby_terrain != last_lnt ||
       last_flight_phase != flight_phase)
   {
      if (logfile != NULL) {
         fprintf(logfile,"V2a ANT_TILT ba %d  lnt %d fphase %d phi_low %f phi_offset %f phi_off_max %f phi_low_fp %f\n",baro_alt,lowest_nearby_terrain,
         flight_phase,phi_low,phi_offset,phi_offset_max, phi_low_fp);
      }
      last_baro_alt = baro_alt;
      last_lnt = lowest_nearby_terrain;
      last_flight_phase = flight_phase;
   }
#endif

} // end calculate_antenna_tilt_re_da()


void vert_fe_write (AUX_SCAN_TYPE *aux_scan,AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe, float sr_dbz_img[][VSDW_X_AXIS_LEN_SR])
{
  // write out vert sweep dbz arrays for WAT processing
  // time of sweep - ac_posn - cell_posn -- azimuth of the sweep
  //  csv ints ?
  static int vfe_wc = 0;
     VERT_FE_TYPE *vert_fe  = &aux_cell_vert_fe->data[0];
     int rai;   
     int k,j;
     int ele;
  if (vfe_log == NULL) {

    vfe_log = fopen(getFilename("vfe_log",IQ_file.path), "w");

  }

  fprintf(vfe_log,"\n\n VFE n_scans %d n_epochs %d n_vsweeps %d n_writes %d \n\n",aux_scan->n_scans,aux_scan->n_epochs,
  aux_scan->n_vert_sweeps, ++vfe_wc);

  for ( rai = 0; rai < 60; rai++) {

      fprintf(vfe_log,"%d %d %f %f %f %f %f %f\n", vert_fe[rai].alt, vert_fe[rai].temp, vert_fe[rai].peak_dbz, 
      vert_fe[rai].peak_dbz_range_nm,
      vert_fe[rai].dbz_variance,   vert_fe[rai].dbz_max_grad , vert_fe[rai].range[0].min_range, vert_fe[rai].range[0].max_range);
  }

#if 0  
     fprintf(vfe_log,"\n\n   SR DBZ \n\n");

   for ( rai = 0; rai < VSDW_Y_AXIS_LEN ; rai++) {
      fprintf(vfe_log,"row [%d]\n", rai);
      for (j = 0; j < 16; j++) {
         k = 0;
         ele = (j*16+k);
         fprintf(vfe_log,"subrow %d ele %d\n", j, ele);
         for (k = 0; k < 16; k++) {
            ele = (j*16+k);
            if (sr_dbz_img[rai][ele] > 0) {
               fprintf(vfe_log,"[%d][%d]%6.2f ",rai,ele, sr_dbz_img[rai][ele]);
            }
         }
         fprintf(vfe_log,"\n");
      }
      fprintf(vfe_log,"\n");
   }
#endif

} // end vert_fe_write()




////



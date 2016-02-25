/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** Header File:   dsp3_main.h
**
** Description:   This file contains all basic dsp3 functions including display of 453 data,
**                cell tracking and hazard assessment.
** Nathan Meyer   2010-04-16
** $Id $
**----------------------------------------------------------------------------
*/

// This file will contain the dsp3 main stuff track stuff

#include <stdlib.h>
#include <math.h>
#include <stdio.h>    // needed for file write
#include <string.h>   // needed for memset
#include <sys\stat.h> // needed for writing to output files

#include "windows.h"
#include "dsp3_main.h"
#include "defines.h"
#include "erib.h"
#include "merge_desense.h"
#include "interpolate.h"
#include "pack.h"
#include "ctrl453.h"
#include "dbzto453.h"
#include "wx_disp.h"
#include "cell_track_defines.h"
#include "cell_track_radial.h"
#include "cell_track_sweep.h"
#include "cell_track_shape.h"
#include "cell_track_compute.h"
#include "horizontal_threats.h"
#include "horizontal_threat_write.h"
#include "cell_write.h"
#include "cell_debug.h"
#include  "flight_path_threat.h"
#include "send453toWxiCtrl.h"


#define CELL_TRACK_SWEEP_HOLDOFF    3


extern GUI_PROC_DATA_TYPE GuiProcData;
extern FILE_WRITE_TYPE File_Writes;

extern FILE *arch_db_file;
FILE *fp_test;

int prep_for_tool_display( float scan_angle,
                    int compass_rose_on,
                    unsigned long int *wx_array,
                    unsigned long int *int_merge_scan,
                    float color_spacing_k,
                    unsigned char mode);

void combine_wx_radials(WX_INPUT_TYPE *wx_input,
                        WX_INPUT_TYPE *prev_wx_input,
                        float *dsp3_scan_angle,
                        int current_problem,
                        unsigned int *output_dbz,
                        float beta);

float new_combine_wx_radials(
                        WX_INPUT_TYPE *wx_input,
                        WX_INPUT_TYPE *prev_wx_input,
                        float *dsp3_scan_angle,
                        int current_problem,
                        unsigned int *output_dbz_and_flags,
                        DATA_FROM_DSPM_TYPE *DataFromDspm,
                        DATA_FROM_DSPM_TYPE *PrevDataFromDspm,
                        DATA_FROM_DSPM_TYPE *CurDataFromDspm,
                        RADIAL_TYPE *rad);

void output_cells_to_Wxi (CELL_TYPE * cell, float ac_heading);


// *************************************************************************//
// dsp3_main
//
// needs to return an array with that is *merge_scan_tool* which is dbz and
// includes the range and angle marking lines for the display...
// Also needs to include these lines on the 453 display, so write the lines
// right before the 453 call... *merge_scan_453*
//
//
//
// *************************************************************************//

void dsp3_main(int first_dspm_call,
               int new_scan,
               unsigned long int *out_to_disp_p0,
               unsigned long int *out_to_disp_p2,
               WX_INPUT_TYPE *wx_input,
               WX_INPUT_TYPE *prev_wx_input,
               struct SCAN_DATA_TYPE *scan_data,
               short int auto_mode,
               unsigned char mode,
               int compass_rose_on,
               float display_range,
               float lagged_scan_angle,     //filtered scan_angle for box car filter
               float merge_scan_angle,      //leading angle in scan_to_scan memory
               float dsp3_scan_angle,       //scan_angle set in combine_wx_radials
               float beta,
               unsigned int current_problem,
               unsigned char *data_453,
               DATA_FOR_ERIB_TYPE *dfe,
               _453_VECTOR_TYPE *wxrv,
               float pac,
               int sizeof_453data,
               int eos_call,
               int synth_gain_start_range,
               DATA_FROM_DSPM_TYPE *DataFromDspm,
               DATA_FROM_DSPM_TYPE *PrevDataFromDspm,
               struct CLIMATE_MODEL_TYPE *ClimateModel)
{
   float color_spacing_k;
   float temp_dbz[512], junk_dbz[512];
   float temp_y[512];
   unsigned long int temp_flags[512];
   unsigned int i, bin;
   float prev_rad[512];
   unsigned int wx_array[512];      // This is in the form of dby,y,flags, but it will be dbz,0's,flags
   static int epoch_counter = 0;
   unsigned int wx_array2[512];
   static int swp_count = 0;  // experimental variable for testing
   FILE *fpt;
   char test_name[32];
   unsigned int range;
   float manual_gain;
   static float baro_altitude;
   unsigned char gcs_on;
   unsigned int debug;
   unsigned int Current_problem = 0;
   unsigned int *out_ptr;
   DATA_FROM_DSPM_TYPE CurDataFromDspm;
   RADIAL_TYPE rad;
   int altitude_offset = 0;
   float temp;
   float horizon_range;
   static int horizon_bin;
   static int sweep_type;
   AREA_TYPE *area_current;
   int number_of_areas;
   SEGMENT_TYPE * segment;
   unsigned int out_p2[512];
   static int first_eos_call = 0;
   float tmp_flt[512];
   int tmp_int[512];
   int *db_cell;
   static float db_threshold = NOISE_FLOOR + 10.0f;
   float track_angle;
   static float heading;
   static CELL_TYPE * cell = NULL;
   int number_of_cells;
   static int threat_schedule_flag = 0;
   static struct UNDEFINED_HORIZONTAL_INPUTS_TYPE undefined_input;
   struct AREA_NEW_TYPE *tmp_ptr;
   static int area_finished_time;
   int area_delta_time;
   int debug_array[5];
   WAT_CELL_INFO_HDR_TYPE hdr;
   char date_str[30];
   int block_size = min (WXR453_PKT_SIZE, sizeof_453data);
   float ac_heading; // in degrees
   int disp_dbz_val;
   unsigned int temp_horz_bin;


   if (eos_call == 0) // if eos_call is false, i.e. not end of sweep
   {
      first_eos_call = 1;

      epoch_counter++;

      // Future Location: Do init for cell_track radial processes here

      if ( first_dspm_call ){
         // Init calls -  for new cell track
         init_cell_track_radial(1,1,1,DETECTING);     // cell_track_radial.c
         memset(&rad,0,sizeof(RADIAL_TYPE));
         cell = NULL;
         area_finished_time = DataFromDspm->current_time;
      }

      /*---------------------------------------------------------------
      ** Calculate color spacing k:
      **   want it to be 1.0 at freezing level and below, up to
      **   1.1428 at 15kft above freezing level and above.  Must also
      **   be oceanic.
      **   Set to 1.0 if manual mode.
      **---------------------------------------------------------------
      */

      if( dfe->sat_valid_flag && auto_mode )
         color_spacing_k = (-4.7619e-3 * dfe->static_air_temperature * dfe->ramp) + 1.0;
      else
         color_spacing_k = 1.0;   // Set to 1.0 for manual mode

      if( color_spacing_k < 1.0 )
         color_spacing_k = 1.0;
      if( color_spacing_k > 1.1428 )
         color_spacing_k = 1.1428;

      // Combine Wx Radials from 3/8 deg to 1/4 deg radials
      beta = new_combine_wx_radials(  wx_input,
                           prev_wx_input,
                           &dsp3_scan_angle,  // generates dsp3_scan_angle and returns it.
                           Current_problem,
                           wx_array,         // dbz's, lower_dbz's, flags  This is the output
                           DataFromDspm,
                           PrevDataFromDspm,
                           &CurDataFromDspm,
                           &rad);

      // Write the count directly from the scan_angle made to be number of radials, with zero being zero degrees
      scan_data->count = (int)(dsp3_scan_angle*4);

      baro_altitude = dfe->baro_alt;

      // **********************************************************************
      // Section 3 for Cell_Track
      // **********************************************************************

      if (DataFromDspm->auto_mode) // Only do cell track if we're in Auto
      {
         // Cell Track Processes that are done per radial
         if(fabs(dsp3_scan_angle) <= 89.0)
         {
            for( bin = 0; bin < NUMBER_OF_BINS; bin++)
            {
               rad.cell_no[bin] = 63;
            }

            rad.num_bins = NUMBER_OF_BINS;
            rad.db_threshold = db_threshold; // Shouldn't need to load this all the time,
                                             // but rad.db_threshold isn't a static

            heading = INT_ANGLE_TO_FLOAT * ((float)PrevDataFromDspm->heading +
                           beta*(float)(DataFromDspm->heading - PrevDataFromDspm->heading));

            rad.bearing = pi_limit( dsp3_scan_angle + heading );

            if (swp_count > CELL_TRACK_SWEEP_HOLDOFF)
            {
               if (sweep_type == DETECTING) 
               {

                  // This is the detecting sweep  
               
		 //                  fprintf(arch_db_file," init_radial %d\n", sweep_type);  
                  // Initialize the radial process with a per radial initialization
                  init_cell_track_radial(0,0,1,sweep_type);  // (SWEEP_START,RADIAL_START)

                  // First find wx segments
                  segment = (SEGMENT_TYPE *) detect_segments(&rad, DataFromDspm->milliseconds);

                  if ((DataFromDspm->milliseconds >= 73524578) && (DataFromDspm->milliseconds <= 7))
                     write_power(&rad, dsp3_scan_angle, DataFromDspm->milliseconds);

                  convert_to_dbz();

                  memset(out_p2,0,sizeof(int)*512);

                  for (i = 0; i < MAX_SEGMENTS; i++) 
                  {
                     if(segment[i].state > SEGMENT_INACTIVE) 
                     {
                        for (bin = segment[i].min_bin; bin < (unsigned int) segment[i].max_bin; bin++) 
                        {
                           //out_p2[bin] = 35;
                           out_p2[bin] = (int) max(min(rad.db[bin],60.0),15.0);
                        }
                     }
                  }
                  write_segments(segment, &rad, DataFromDspm->milliseconds);
               
                  // Next, find best existing area to match with each new segment
                  match_segments_with_areas(&rad, cell, DataFromDspm->milliseconds);

                  // Next create new areas with unmatched segments, close unmatched areas,
                  // measure overlap with existing cells
                  create_new_areas(&rad, cell);

               }
               else
               {

                  // This is the qualifying sweep  

                  // Fill qualified areas
                  db_cell = fill_qual_areas(&rad);  // cell_track_radial.c

                  memcpy(out_p2,db_cell,sizeof(int)*512);

                  // Since there is not much executing during the qualifying sweep;
                  // Put horizontal threat detection routine calls here, set to execute
                  // one call per epoch.  If radar has trouble completing any of these in
                  // a single epoch, these may be split into finer detail.
                  if (threat_schedule_flag > 7)
                     threat_schedule_flag = 0;
                  
                  if (cell != NULL)     
                  switch (threat_schedule_flag)
                  {
                     case 0:
                        break;
                     case 1:
                        horizontal_threat_cleanup(cell);
                        threat_schedule_flag++;
                        break;
                     case 2:
                        horizontal_growth_assessment(cell, ClimateModel, undefined_input);
                        threat_schedule_flag++;
                        break;
                     case 3:
                        horizontal_lightning_assessment(cell, dfe, ClimateModel);
                        threat_schedule_flag++;
                        break;
                     case 4:
                        horizontal_hail_assessment(cell, ClimateModel);
                        threat_schedule_flag++;
                        break;
                     case 5:
                        horizontal_convectivity_assessment(cell);
                        threat_schedule_flag++;
                        break;
                     case 6:
                        horizontal_maturity_assessment(cell);
                        threat_schedule_flag++;
                        break;
                     case 7:
                        horizontal_anvil_assessment(cell, dfe, ClimateModel, undefined_input);
                        // need to decide when to do this based on an input output mode flag
                        horizontal_threat_write(cell);
                        threat_schedule_flag = 0;
                        break;

                  } // end switch on threat_schedule_flag
                  
               } // end if-else on whether sweep was detection or qualifying
            } // end if sweep count > CELL_TRACK_SWEEP_HOLDOFF
         } // end if scan angle <= 89
      } // end if auto mode


      for(Current_problem = 0; Current_problem < 3; Current_problem++)
      {
         switch (Current_problem)
         {
            case 0:
               range = dfe->range;
               gcs_on = dfe->gcs;
               manual_gain = dfe->manual_gain;
               //mode = all_modes & 0x3F;
               out_ptr = (unsigned int *)out_to_disp_p0;  // This way I only need 1 set of code below
               break;

            case 1:
               range = dfe->range;
               gcs_on = dfe->gcs;
               manual_gain = dfe->manual_gain;
               //mode = (all_modes >> 8) & 0x3F;
               //out_ptr = (unsigned int *)out_to_disp_p1; // This way I only need 1 set of code below
               // Currently there is no case 1;
               break;

            case 2:
               range = PROB3_RANGE;
               gcs_on = 0xFF;
               manual_gain = CAL_GAIN;
               //mode = WX_TURB_MODE;
               out_ptr = (unsigned int *)out_to_disp_p2;  // This way I only need 1 set of code below
               break;

            default:
               range = dfe->range;
               gcs_on = dfe->gcs;
               manual_gain = dfe->manual_gain;
               //mode = all_modes & 0x3F;
               out_ptr = (unsigned int *)out_to_disp_p0;  // This way I only need 1 set of code below
               break;
         } // end switch on current problem

         // Currently we do not have full functionality for 3 problems in the sim
         // Only for problem 0 and problem 2 - only do problem zero if in auto_mode
         if( (Current_problem == 0) ||
            ((Current_problem == 2) && (DataFromDspm->auto_mode)) )
         {
            combine_wx_radials(  wx_input,
                                 prev_wx_input,
                                 &dsp3_scan_angle, // generates dsp3_scan_angle and returns it.
                                 Current_problem,
                                 wx_array,         // dbz's, lower_dbz's, flags  This is the output
                                 beta );

            // Create a second wx_array as a copy of the first
            memcpy(wx_array2,wx_array,(512*sizeof(unsigned int)));
    
            // wx_array is sent to three routes:
            //    1. Encode and saved for Greg's Tool Display
            //    2. Encode and written as 453 data to a .wxr file or out to the Wxi-708 app
            //    3. Used by the cell track process

            // **********************************************************************

            if (Current_problem == 0)
            {
               // Turn the display filter on
               if (GuiProcData.allow_disp_filter)
               {
                  if (gcs_on && (mode != MAP) && (swp_count > 4)){
       
                     limit_wx_data( scan_data->count,  //Scan.count
                                    heading, // changed to use interpolated heading per Sim status meeting 03-29-2010 (sls)
                                    range,
                                    mode,
                                    manual_gain,
                                    Current_problem,
                                    wx_input->ground_speed*16,
                                    1,  // This is always true for our simulation, chuck's code this is only true for the first_call each radial
                                    wx_array);
                  }
                  else{
                     clear_wx_data(Current_problem);
                  }
               }
               else{
                  clear_wx_data(Current_problem);
               }
               // End of the display filter
   
               // desense clutter if gcs is on and not map mode
               if (DataFromDspm->auto_mode && gcs_on && (mode != MAP)) {
                  clutter_desense(range, horizon_bin, wx_array, &rad, &DataFromDspm->flight_pta);
               }
   
            } // end if Current_problem == 0
   
            // **********************************************************************
            // Section 1 for the Sim2100 Display
            // Used to be color_squeezer
            // Prep for tool display - do this for both problems 0 and 2
            prep_for_tool_display( lagged_scan_angle,
                            compass_rose_on,
                            (unsigned long int *)wx_array,       // send in as dbz's and flags, but no y's
                            (unsigned long int *)out_ptr, // comes out as dbz's
                            color_spacing_k,
                            mode );
       
            // Add pack for Greg's Tool Display
            if ( (pac > 10.0) && (Current_problem < 2) ){
               for( bin = (256-8); bin < 256; bin++)
                  out_ptr[bin] = 50;
            }
               
            if(Current_problem == 2)
               for (bin = 0; bin < 256; bin++)
                  out_ptr[bin] = 15;
   
            if((Current_problem == 2) ) {
               for (bin = 0; bin < 512; bin++) {
                  out_ptr[bin/2] = max(out_ptr[bin/2],out_p2[bin]);
               }
            }

            // Output the leakage rates
            if (Current_problem == 0){

               if(fabs(dsp3_scan_angle) < 89.0){
                  // Unpack the dBz data from the wx_array
                  unpack_dbz_vdata( (unsigned long int *)wx_array, temp_dbz, junk_dbz,
                                 (unsigned long int *)temp_flags, 16.0 );
                                 
                  // Test for showing leakage rates on the GUI
                  GuiProcData.LkgRads++;

                  //temp_horz_bin = (int)(horizon_bin * 331.0f / 512.0f) * 256.0 / (range*5);

                  temp_horz_bin = (int)((0.85 * DataFromDspm->bams_horz_rng) * 256.0 / (range*5));

                  temp_horz_bin = min(temp_horz_bin,256);

                  for (i = (int)(80.0f*256.0f/320.0f); i < temp_horz_bin; i++){
                  //for (i = (int)(temp_horz_bin * 0.28f); i < temp_horz_bin; i++){
                     // Test for showing Leakage Rates on the Gui
                     GuiProcData.tot_bins++;

                     disp_dbz_val = (int)((temp_dbz[i] - 20.0) * color_spacing_k) + 20.0 + 0.5;

                     if(disp_dbz_val >= 20)
                        GuiProcData.lkg_bins++;
                  }
               }
            }

            // **********************************************************************
            // Section 2 for the 453 Display
            /* Only call this if outputting 453 data */
            if(
               ( (wxrv->fp453 != NULL) && (wxrv->ctrl.label_1_8 != 0xFF) ) ||
               ( (TRUE == Wxi453ctrl.tx) && (0 == Current_problem) && (wxrv->ctrl.label_1_8 != 0xFF) )
              )
            {
               // Prep for 453 display
               stuff_scan_angle( (float) dsp3_scan_angle, &wxrv->ctrl ); //write_scan_angle, &wxrv->ctrl );
       
               // Make sure to set the range correctly...
               wxrv->ctrl.range_43_48 = (short int) min(64.0,(display_range/5.0));

               // pack the control word into first 8 elements of data_453
               conv_ctrldata_to_453ctrlword( &wxrv->ctrl, data_453 );
       
               unpack_dbz_vdata( (unsigned long int *)wx_array, temp_dbz, junk_dbz,
                                 (unsigned long int *)temp_flags, 16.0 );
   
               // Insert Pac into data
               if ( (pac > 10.0) && (Current_problem < 2) ){
       
                  for( bin = (256-8); bin < 256; bin++)
                     temp_dbz[bin] = 50;
               }
       
               // draw_wx_cells will draw centroid in the arinc data
               if (Current_problem == 2){
                  // Spot to draw weather cells
       
               }

               // load bin data into 453 output array //
               convert_dbz_to_453bindata( temp_dbz,               // 256 bins for 453 output
                                          temp_flags,             // flags for the temp data
                                          &data_453[8],           // array for outputting 453 data
                                          dsp3_scan_angle,        // merge scan angle
                                          256,                    // number of bins on display
                                          wxrv->plug,             // toggle for plugging holes
                                          mode,                   // mode of radar
                                          synth_gain_start_range,
                                          display_range,
                                          color_spacing_k );      // color spacing constant computed above

               // MAKE 453 DATA FILE *******************************
               // write 453 word to file
               if (wxrv->fp453 != NULL)
               {
                  if(Current_problem == 0)
                     fwrite(data_453, sizeof_453data, 1, wxrv->fp453);
                  else if(Current_problem == 2)
                     fwrite(data_453, sizeof_453data, 1, wxrv->fp453_p3);
               }
               // send 453 words to Wxi-708 (some may be filtered out on that side)
               if (TRUE == Wxi453ctrl.tx)
               {
                  memset (Wxi453ctrl.data, 0, sizeof(Wxi453ctrl.data));
                  memcpy (Wxi453ctrl.data, data_453, block_size);
                  send_453_to_Wxi (Wxi453ctrl.data);
               }
            } // end if( (wxrv->fp453 != NULL) || 453 out to Wxi-708 display )

         } // end if((Current_problem == 0) || (Current_problem == 2))

      } // end for-loop on Current_problem

   } // end if not eos_call

   else // End of Sweep Processes Place Holder (Mostly Cell Track)
   {
      if((first_eos_call == 1) && (DataFromDspm->auto_mode))
      {
         // Sometimes there is a lot of junk in the first few sweeps, this is to be
         // able to skip that
         if (swp_count > CELL_TRACK_SWEEP_HOLDOFF)
         {
            // This is used by both area and cell translate functions
            track_angle = (float)DataFromDspm->track * INT_ANGLE_TO_FLOAT;

            translate_cells(DataFromDspm->current_time,
                            DataFromDspm->ground_speed,
                            track_angle,
                            DataFromDspm->lat_rad,
                            DataFromDspm->lon_rad);                     // cell_track_sweep.c

            // pack up cell info and output to Wxi-708
            if (TRUE == Wxi453ctrl.tx && cell != NULL)
            {
               fprintf(arch_db_file," cell_to_wxi %d\n", cell->id);  
               ac_heading = (float)DataFromDspm->heading * INT_ANGLE_TO_FLOAT;
               output_cells_to_Wxi (cell, ac_heading);
            }

            if (sweep_type == DETECTING)
            {
               // This is the EOS after the detecting sweep

               // call this to get a pointer to the radially computed data
               area_current = get_eos_ptr(&rad,sweep_type);   // cell_track_radial.c

               // Now call the rest of the end of sweep structures
               // send a pointer to the data from the radial processes...
               get_area_structure(area_current);              // cell_track_sweep.c

               // Compute how many active areas and set the radial power threshold
               number_of_areas = 0;
               for (i = 0; i < MAX_WX_AREAS; i++)
               {
                  if (area_current[i].state != AREA_INACTIVE)
                     number_of_areas++;
               }
               // Adjust the power threshold depending on how many areas were detected
               if(number_of_areas > 0.8 * MAX_WX_AREAS)
                  db_threshold += 1.0f;
               else if(number_of_areas == 0)
                  db_threshold = max( NOISE_FLOOR+3.0, db_threshold - 1.0f );

               // Write threshold to output file
               debug_array[0] = number_of_areas;
               debug_array[1] = (int)(100.0 * db_threshold);
               debug_array[2] = swp_count;
               write_debug(3, debug_array, DataFromDspm->milliseconds);

               if (swp_count >= 59)
                  debug_array[0] = swp_count;

               find_best_overlaps();

               // Write areas to output file
               write_areas(1, swp_count, area_current, DataFromDspm->milliseconds);

               // Write overlaps to output file
               write_temp_data(swp_count, area_current, DataFromDspm->milliseconds);

               find_small_areas();

               combine_small_areas_to_links(AREAS_WITH_OVERLAPS, DataFromDspm->milliseconds);

               combine_small_areas(AREAS_WITH_OVERLAPS, DataFromDspm->milliseconds);

               combine_small_areas_to_links(ALL_AREAS, DataFromDspm->milliseconds);

               combine_small_areas(ALL_AREAS, DataFromDspm->milliseconds);

               combine_edge_areas(DataFromDspm->milliseconds);

               combine_close_extents(DataFromDspm->milliseconds);

               combine_overlapping_areas(DataFromDspm->milliseconds);

               kill_small_areas(DataFromDspm->milliseconds);

               write_areas(2, swp_count, area_current, DataFromDspm->milliseconds);    // see how we've done so far

               finish_areas();

               // This is used in the translate_areas function:
               area_finished_time = DataFromDspm->current_time;

               number_of_areas = 0;
               for (i = 0; i < MAX_WX_AREAS; i++)
               {
                  if(area_current[i].state != AREA_INACTIVE)
                     number_of_areas ++;
               }

               create_qual_areas(); //cell_track_sweep.c
               
               look_for_cell_merges();

               sweep_type = QUALIFYING;
            }
            else 
            {
               // This is the EOS after the qualifying sweep  

               // Get a pointer to the area structure
               area_current = get_eos_ptr(&rad,sweep_type);
   
               // Decide which areas are qualified to be displayed
               qualify_areas(area_current);    // cell_track_sweep.c
   
               // Cell processes

               // Calculate time since areas were finished, check for midnight overflow (probably not needed for radar)
               area_delta_time = DataFromDspm->current_time - area_finished_time;
               if (area_delta_time < 0)
                  area_delta_time += ONE_DAY;

               // Translate areas to account for movement during qualifying sweep
               translate_areas(area_delta_time, DataFromDspm->ground_speed, track_angle);

               update_previous_attributes();                               // cell_track_sweep.c

               associate_overlapped_cells(DataFromDspm->current_time, DataFromDspm->milliseconds);     // cell_track_sweep.c
               calculate_filtered_attributes(DataFromDspm->current_time);  // cell_track_sweep.c
               update_unmatched_cells(DataFromDspm->current_time);         // cell_track_sweep.c

               cell = create_new_cells(DataFromDspm->current_time);        // cell_track_sweep.c

               number_of_cells = 0;
               if (cell != NULL) { // ...
               get_cell_temperature_altitude(cell, dfe, ClimateModel);     // cell_track_compute.c
               get_cell_land_ocean(cell, &rad);                            // cell_track_compute.c
               get_priority_range(cell, heading);                          // cell_track_compute.c
   
               number_of_cells = 0;
               if (cell != NULL) // ...
               

               for (i = 0; i < MAX_WX_CELLS; i++)
               {
                  if(cell[i].state != CELL_INACTIVE)
                     number_of_cells++;
               }
               }
               // write cell information out to text file
               write_cells(number_of_cells, cell, DataFromDspm->milliseconds);
               // write cell information out to binary file for WAT use
               if (TRUE == File_Writes.wat_cell_bin)
               {
                  // timestamp of current record in IQ file
                  snprintf (hdr.utc, sizeof(hdr.utc), "%02d:%02d:%02d",
                            dfe->date_time.hour, dfe->date_time.minute, dfe->date_time.second);
                  // always construct this datestamp in case IQ filename does not have an embedded datestamp
                  snprintf (date_str, sizeof(date_str), "%d%02d%02d",
                           (dfe->date_time.year+2000), dfe->date_time.month, dfe->date_time.day);
                  hdr.num_cells = number_of_cells;
                  hdr.number_of_scans = DataFromDspm->number_of_scans;
                  hdr.heading = DataFromDspm->heading;
                  hdr.upper_tilt = dfe->upper_tilt;
                  hdr.filt_lower_tilt = dfe->filtered_lower_tilt;
                  hdr.baro_altitude = dfe->baro_alt;
                  hdr.static_air_temp = dfe->static_air_temperature;
                  hdr.latitude = DataFromDspm->lat_rad;
                  hdr.longitude = DataFromDspm->lon_rad;

                  wat_cell_bin_out (date_str, &hdr, cell);
               }

               sweep_type = DETECTING;
               threat_schedule_flag = 1;

            } // end if-else on sweep type being detection or qualifying

            get_priority_range(cell, heading);         // cell_track_compute.c

         } // end if sweep count > CELL_TRACK_SWEEP_HOLDOFF

         init_cell_track_radial(0,1,1,sweep_type);     // cell_track_radial.c
   
         // Calculate the horizon range at end of sweep so it's not changing during a sweep
         altitude_offset = 0;                                            // May need later ?
         temp = 0.01 * (baro_altitude + altitude_offset - 2000);
         temp = max(0, min(35.0f, temp));
         horizon_range = min(max((1.229f * sqrt(baro_altitude) + temp), 20.0f), 330.0f);
         horizon_bin = (int)(((float)NUMBER_OF_BINS)/((float)MAX_RANGE_NM) * horizon_range + 0.5);
         rad.horizon_bin = horizon_bin;
         rad.test_sweep_num = swp_count;
   
         // this is an experimental sweep count variable for testing purposes
         swp_count++;
         if (swp_count > CELL_TRACK_SWEEP_HOLDOFF + 1)
         {
            write_ac(sweep_type, swp_count, heading,
                     baro_altitude, DataFromDspm->lat_rad, 
                     DataFromDspm->lon_rad, 
                     DataFromDspm->milliseconds);
         }
      }

      first_eos_call = 0;

   } // end if first_eos_call or not

} // end dsp3_main()
//------------------------------------------------------------------------------

/*******************************************************************************
int write_to_merge_plane( double scan_angle,
                          ROT_TRAN_TYPE *rot_tran,
                          unsigned long int *plane )

   Writes merged dbz data to the Merge Plane.
      scan_angle - current scan angle
      rot_tran - contains rotate and translation parameters
      plane - memory containing data in various stages of the process

*******************************************************************************/
// Used to be color_squeezer
int prep_for_tool_display( float scan_angle,
                    int compass_rose_on,
                    unsigned long int *wx_array,
                    unsigned long int *int_merge_scan, // Output ptr
                    float color_spacing_k,
                    unsigned char mode  )
{
   int bin;
   float merge_dbz[512], junk_dbz[512];
   unsigned long int merge_flags[512];
   int arc = 0, tic = 0;

   unpack_dbz_vdata(wx_array, merge_dbz, junk_dbz, merge_flags, 16.0 );

   for (bin = 0; bin < 512; bin++)
   {
      if( bin < 256 )//(bin&0xFFE) == 0 ) //even numbers from 0 - 511
      {  //apply the color_spacing_k that CJD does in DSP3 (wx_encode.asm)
         //Remove these and put them back in dbzto453 5 April 06
         merge_dbz[bin] = (int)(((merge_dbz[bin] - 20.0) * color_spacing_k) + 20.0 + 0.5);// + merge_y[bin]);
         merge_dbz[bin] = min( merge_dbz[bin], 63 );//keep it red for labview

         //DO TURB IN 453 DATA ONLY
         //set turb, this may mess up dbz_to_453????
         /*
         if( (mode == TURB) || (mode == WX_T) )
         {
            if( (merge_flags[bin] & 0x2) == 2 )
               merge_dbz[bin] = 65;

            //add the turb fill in stuff that is in wx_encode.asm and dbzto453.c
         }
         */
         //calc arc's
         if( (bin == 255) ||
             (bin == 191) ||
             (bin == 127) ||
             (bin == 63) )
             arc = 1;
         if( ((fabs(scan_angle) > 59.8) && (fabs(scan_angle) < 60.1)) ||
             ((fabs(scan_angle) > 29.8) && (fabs(scan_angle) < 30.1)) ||
             ((fabs(scan_angle) < 0.15)) )
             tic = 1;
         if( compass_rose_on && (arc || tic) )
            merge_dbz[bin] = 65;

         arc = 0; tic = 0;
         int_merge_scan[bin] = merge_dbz[bin];
      }
      else
         int_merge_scan[bin] = 0;

   }
   return 1;
}
//------------------------------------------------------------------------------

void combine_wx_radials(WX_INPUT_TYPE *wx_input,
                        WX_INPUT_TYPE *prev_wx_input,
                        float *dsp3_scan_angle,
                        int current_problem,
                        unsigned int *output_dbz_and_flags,
                        float beta)
{
   int i;
   float tmp_upper;
   float tmp_lower;
   unsigned int tmp_int;
   unsigned int flags_upper;
   unsigned int flags_lower;
   float upper_dbz[512], lower_dbz[512];
   float upper_dbz_packed[512], lower_dbz_packed[512];
   float upper_y[512], lower_y[512];
   unsigned long int upper_flags[512], lower_flags[512];

      // **************************************************************************
   // ***** This is the old style data interpolation between radials ***********
   // **************************************************************************

   // unpack data into upper_dbz and remove the packed in dbz for problem 3 and 4
   unpack_dbz_vdata(  (unsigned long int *)&wx_input->data[current_problem].mag_dev[0], upper_dbz, upper_dbz_packed,
         (unsigned long int *)upper_flags, 16.0 );
   unpack_dbz_vdata(  (unsigned long int *)&prev_wx_input->data[current_problem].mag_dev[0], lower_dbz, lower_dbz_packed,
         (unsigned long int *)lower_flags, 16.0 );

   (*dsp3_scan_angle) = prev_wx_input->lagged_scan_angle +
         beta*(wx_input->lagged_scan_angle - prev_wx_input->lagged_scan_angle);

   for (i = 0; i<256; i++)
   {
      upper_dbz[i] = floor((upper_dbz[i] * (1-beta)) + (lower_dbz[i]*beta) + 0.5);
      upper_flags[i] = ( (upper_flags[i] | lower_flags[i]) & 0xFF );
      upper_dbz_packed[i] = floor( (upper_dbz_packed[i] * (1-beta)) + (lower_dbz_packed[i]*beta) + 0.5 );
   }

   wx_input->dsp3_scan_angle = dsp3_scan_angle[0];

   // Pack dbz and packed dbz values and flags into the output vector
   pack_dbz_vdata(  (unsigned long int *)output_dbz_and_flags, upper_dbz, upper_dbz_packed,
         (unsigned long int *)upper_flags, 16.0 );
}
//------------------------------------------------------------------------------

float new_combine_wx_radials(
                        WX_INPUT_TYPE *wx_input,
                        WX_INPUT_TYPE *prev_wx_input,
                        float *dsp3_scan_angle,
                        int current_problem,
                        unsigned int *output_dbz_and_flags,
                        DATA_FROM_DSPM_TYPE *DataFromDspm,
                        DATA_FROM_DSPM_TYPE *PrevDataFromDspm,
                        DATA_FROM_DSPM_TYPE *CurDataFromDspm,
                        RADIAL_TYPE *rad)
{
   float beta;
   int i;
   float tmp_upper;
   float tmp_lower;
   unsigned int tmp_int;
   unsigned int flags_upper;
   unsigned int flags_lower;
   float upper_dbz[512], lower_dbz[512];
   float upper_dbz_packed[512], lower_dbz_packed[512];
   float upper_y[512], lower_y[512];
   unsigned long int upper_flags[512], lower_flags[512];

   static int scan_angle_scaled_out = -90*4;
   static float prev_scan_angle_out = -90.0f;
   static float scan_angle_out = 90*4;
   float cur_temp, prev_temp;
   int out_temp;

   if(current_problem == 0){
      if(DataFromDspm->auto_mode){
         // Set the scan angle and the beta
         if(DataFromDspm->SweepInitFlag){
            scan_angle_scaled_out = -90*4;
            prev_scan_angle_out = scan_angle_scaled_out*0.25f;
         }
         else{
            if(prev_wx_input->lagged_scan_angle != wx_input->lagged_scan_angle){
               prev_scan_angle_out = scan_angle_scaled_out*0.25f;
               scan_angle_scaled_out ++;
            }
         }
      }
      else{
         // Set the scan angle for manual mode
         if(DataFromDspm->SweepInitFlag){
            scan_angle_scaled_out = DataFromDspm->scan_dir*90*4; // Might still need a -1 in front of this
            prev_scan_angle_out = scan_angle_scaled_out*0.25f;
         }
         else{
            prev_scan_angle_out = scan_angle_scaled_out*0.25f;
            scan_angle_scaled_out += DataFromDspm->scan_dir;
         }
      }
      scan_angle_out = scan_angle_scaled_out / 4.0f;
   }

   beta = 1.0f;
   if( (prev_wx_input->lagged_scan_angle != wx_input->lagged_scan_angle) &&
       (scan_angle_out <= wx_input->lagged_scan_angle) )
      beta = (scan_angle_out - prev_wx_input->lagged_scan_angle) /
          (wx_input->lagged_scan_angle - prev_wx_input->lagged_scan_angle);

   beta = max(min(beta,1.0f),0.0f);

   (*dsp3_scan_angle) = prev_wx_input->lagged_scan_angle +
         beta*(wx_input->lagged_scan_angle - prev_wx_input->lagged_scan_angle);

   // **************************************************************************
   // ***** This is the new style data interpolation between radials ***********
   // ***** Used in new cell track and new DSP3 process              ***********
   // **************************************************************************

   memset(CurDataFromDspm->db_packed,0,sizeof(unsigned int)*512);
   memset(CurDataFromDspm->l_diff_thr,0,sizeof(unsigned int)*512);
   memset(CurDataFromDspm->s_diff_thr,0,sizeof(unsigned int)*512);

  for (i=0; i<512; i++){

      /*
      // Upper Power
      cur_temp = (float)((DataFromDspm->db_packed[i]>>16)&0x0000ffff);
      prev_temp = (float)((PrevDataFromDspm->db_packed[i]>>16)&0x0000ffff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      rad->db[i] = (float)out_temp/16.0f;
      CurDataFromDspm->db_packed[i] = ((out_temp<<16)&0xffff0000) ;

      // Pilot dbz and flags / Co-Pilot dbz and flags
      // dbz
      cur_temp = (float)((DataFromDspm->db_packed[i]>>4)&0x00000fff);
      prev_temp = (float)((PrevDataFromDspm->db_packed[i]>>4)&0x00000fff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      CurDataFromDspm->db_packed[i] |= ((out_temp<<4)&0x0000fff0);

      // flags
      out_temp = (DataFromDspm->db_packed[i]&0x0000000f) |
                  (PrevDataFromDspm->db_packed[i]&0x0000000f);

      CurDataFromDspm->db_packed[i] |= out_temp;

      // Long delta_track
      cur_temp = (float)((DataFromDspm->l_diff_thr[i]>>16)&0x0000ffff);
      prev_temp = (float)((PrevDataFromDspm->l_diff_thr[i]>>16)&0x0000ffff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      rad->delta_conf[i] = out_temp;
      CurDataFromDspm->l_diff_thr[i] = ((out_temp<<16)&0xffff0000);
      // Long delta_disp
      cur_temp = (float)((DataFromDspm->l_diff_thr[i])&0x0000ffff);
      prev_temp = (float)((PrevDataFromDspm->l_diff_thr[i])&0x0000ffff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      rad->delta_disp[i] = out_temp;
      CurDataFromDspm->l_diff_thr[i] |= ((out_temp)&0x0000ffff);

      // Short delta_track
      cur_temp = (float)((DataFromDspm->s_diff_thr[i]>>16)&0x0000ffff);
      prev_temp = (float)((PrevDataFromDspm->s_diff_thr[i]>>16)&0x0000ffff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      CurDataFromDspm->s_diff_thr[i] = ((out_temp<<16)&0xffff0000);
      // Short delta_disp
      cur_temp = (float)((DataFromDspm->s_diff_thr[i])&0x0000ffff);
      prev_temp = (float)((PrevDataFromDspm->s_diff_thr[i])&0x0000ffff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      CurDataFromDspm->s_diff_thr[i] |= ((out_temp)&0x0000ffff);
      */

      // Upper Power  added signed int casting into db_packed to ensure
      // we have the sign.  04/19/2010
      cur_temp = (float)(((signed int)DataFromDspm->db_packed[i])>>16);
      prev_temp = (float)(((signed int)PrevDataFromDspm->db_packed[i])>>16);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      rad->db[i] = (float)out_temp/16.0f;
      CurDataFromDspm->db_packed[i] = ((out_temp<<16)&0xffff0000) ;

      // Pilot dbz and flags / Co-Pilot dbz and flags
      // dbz
      cur_temp = (float)((DataFromDspm->db_packed[i]>>4)&0x00000fff);
      prev_temp = (float)((PrevDataFromDspm->db_packed[i]>>4)&0x00000fff);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      CurDataFromDspm->db_packed[i] |= ((out_temp<<4)&0x0000fff0);

      // flags
      out_temp = (DataFromDspm->db_packed[i]&0x0000000f) |
                  (PrevDataFromDspm->db_packed[i]&0x0000000f);
      // Move turb and land/ocean flags from bits 2-3 to bits 0-1.
      rad->flags[i] = out_temp >> 2;
      CurDataFromDspm->db_packed[i] |= out_temp;

      // Long delta_track
      cur_temp = (float)((DataFromDspm->l_diff_thr[i]>>16));
      prev_temp = (float)((PrevDataFromDspm->l_diff_thr[i]>>16));
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      rad->delta_conf[i] = out_temp;
      CurDataFromDspm->l_diff_thr[i] = ((out_temp<<16)&0xffff0000);
      // Long delta_disp
      cur_temp = (float)((DataFromDspm->l_diff_thr[i]<<16)>>16);
      prev_temp = (float)((PrevDataFromDspm->l_diff_thr[i]<<16)>>16);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      rad->delta_disp[i] = out_temp;
      CurDataFromDspm->l_diff_thr[i] |= ((out_temp)&0x0000ffff);
      
      // Short delta_track
      cur_temp = (float)((DataFromDspm->s_diff_thr[i]>>16));
      prev_temp = (float)((PrevDataFromDspm->s_diff_thr[i]>>16));
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      CurDataFromDspm->s_diff_thr[i] = ((out_temp<<16)&0xffff0000);
      // Short delta_disp
      cur_temp = (float)((DataFromDspm->s_diff_thr[i]<<16)>>16);
      prev_temp = (float)((PrevDataFromDspm->s_diff_thr[i]<<16)>>16);
      out_temp = (int)(prev_temp + beta*(cur_temp - prev_temp));
      CurDataFromDspm->s_diff_thr[i] |= ((out_temp)&0x0000ffff);
  }

   rad->radial = scan_angle_scaled_out + 90*4;
   return beta;
}
//------------------------------------------------------------------------------

void output_cells_to_Wxi (CELL_TYPE * cell, float ac_heading)
{
   WXI_CELLDATA_HDR_TYPE wxicellhdr;
   WXI_CELLDATA_TYPE wxicell;
   unsigned char wxicelldata[WXR453_PKT_SIZE];
   unsigned char * wxipkt_ptr;
   int block_size = min (WXR453_PKT_SIZE, sizeof(wxicelldata));
   int i;

   if (NULL == cell )  // MAT
   {
      MessageBox(0, "NULL cell pointer", "output_cells_to_Wxi",
                 (MB_OK | MB_ICONWARNING | MB_TOPMOST));
      return;
   }

   // send enough 453 packets to transfer data for all cells
   memset (&wxicelldata, 0, sizeof(wxicelldata));
   wxipkt_ptr = wxicelldata;
   wxicellhdr.num_cells = 0;
   wxicellhdr.label = WXI_CELL_453_LABEL;
   wxicellhdr.format_version = WXI_CELL_453_FORMAT_VERSION;
   for (i = 0; i < MAX_WX_CELLS; i++)
   {
      if (cell[i].state != CELL_INACTIVE)
      {
         if (wxicellhdr.num_cells++ > 0) // advance ptr to next cell block
            wxipkt_ptr += sizeof(wxicell);
         else // new packet; advance ptr to first cell block
            wxipkt_ptr += sizeof(wxicellhdr);
         wxicell.cell_id = cell[i].id;
         wxicell.state   = cell[i].state;
         /* centroid, side extent angle offsets (degrees) from compass north;
            convert to aircraft scan angles (degrees) */
         wxicell.c_brg = cell[i].centroid_brg - ac_heading;
         if (wxicell.c_brg < -180.0)
            wxicell.c_brg += 360.0;
         wxicell.l_brg = cell[i].centroid_brg - cell[i].az_width.left - ac_heading;
         if (wxicell.l_brg < -180.0)
            wxicell.l_brg += 360.0;
         wxicell.r_brg = cell[i].centroid_brg + cell[i].az_width.right - ac_heading;
         if (wxicell.r_brg < -180.0)
            wxicell.r_brg += 360.0;
         wxicell.c_bin  = cell[i].centroid_bin + 0.5;
         wxicell.cn_bin = cell[i].centroid_bin - cell[i].near_depth.center + 0.5;
         wxicell.cf_bin = cell[i].centroid_bin + cell[i].far_depth.center  + 0.5;
         wxicell.ln_bin = cell[i].centroid_bin + cell[i].delta_bin.left  - cell[i].near_depth.left  + 0.5;
         wxicell.lf_bin = cell[i].centroid_bin + cell[i].delta_bin.left  + cell[i]. far_depth.left  + 0.5;
         wxicell.rn_bin = cell[i].centroid_bin + cell[i].delta_bin.right - cell[i].near_depth.right + 0.5;
         wxicell.rf_bin = cell[i].centroid_bin + cell[i].delta_bin.right + cell[i]. far_depth.right + 0.5;
         memcpy (wxipkt_ptr, &wxicell, sizeof(wxicell));
         // send packet to Wxi app when full or last 'active' cell in table
         if (MAX_CELLS_IN_453_PKT == wxicellhdr.num_cells || i == (MAX_WX_CELLS-1))
         {
            // write cell packet header
            memcpy (&wxicelldata, &wxicellhdr, sizeof(wxicellhdr));
            memset (Wxi453ctrl.data, 0, sizeof(Wxi453ctrl.data));
            memcpy (Wxi453ctrl.data, &wxicelldata, block_size);
            // send data
            send_453_to_Wxi (Wxi453ctrl.data);
            wxicellhdr.num_cells = 0;
            memset (&wxicelldata, 0, sizeof(wxicelldata));
            wxipkt_ptr = wxicelldata;
         } // end if sending packet to Wxi app
      } // end if cell state is not 'inactive'
   } // end for-loop thru cell table
}
//------------------------------------------------------------------------------

/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** Header File:   auxiliary_threat_features.c
**
** Description:   This file contains all the routines used for hazard assessment
**
** $Id: auxiliary_threat_features.c 619 2010-05-06 22:42:11Z cjdicker $
**----------------------------------------------------------------------------
*/


/*----------------------------------------------------------------------------
**                  Include Files
**----------------------------------------------------------------------------
*/
#include <mem.h>    /*needed for memset*/
#include <stdio.h>  
#include <string.h>
#include "units.h"
#include "auxiliary_threat_features.h"
#include "geograph.h"           // needed to access climate structure
#include "auxiliary_lightning_tables.h"
#include "aux_vert_threat_write.h"
#include "aux_vert_correlate.h"


#include "navig.h"  //  used for range determination.
// #include "units.h"

/*----------------------------------------------------------------------------
**                  Private Data
**----------------------------------------------------------------------------
*/







float ReflectArrayMem [N_VERT_SHORT_REFLECT_Y * N_VERT_SHORT_REFLECT_Z + N_VERT_LONG_REFLECT_Y * N_VERT_LONG_REFLECT_Z] ;

// CellThreatAttributes needs to be available to composite threat assessment
// for a threaded version (e.g. like the radar) the full struct has to
// sent/copied to DSP3 -- the composite threat assessment engine with handshake
// before the auxiliary processing sweep restarts




AUX_THREAT_FE_INPUT_TYPE  AuxFeatureIn;
AUX_CELL_HORZ_FE_TYPE     AuxHrz;
AUX_CELL_VERT_FE_TYPE     AuxVert;
AUX_VERT_DEBUG_TYPE       aux_vert_debug;
AUX_VERT_WAT_ELEMENTS_TYPE  AuxVertWAT[MAX_VERT_CELLS];
int aux_vert_count;

// N.B. if we have a threaded version of sim2100
// may have double-buffering scheme and use two of each of the aux structs
// so we can ping-pong between the buffers and allow threads to be more effective
// in processing the list of cells

AUX_CELL_THREAT_ATTRIBUTES_TYPE CellThreatAttributes;

// return a pointer to our CellTthreatAttributes
// will need this for a double bufffering scheme

AUX_CELL_THREAT_ATTRIBUTES_TYPE * auxiliary_threat_attributes_get(void)
{
//
// for a threaded version of sim2100 - we will have a read and write copy
// of this struct for reference to incoming and outgoing data
// for functional blocks upstream and downstream from the DSP2 block
// only one struct for now



   return &CellThreatAttributes;
}

AUX_THREAT_FE_INPUT_TYPE *  auxiliary_threat_feature_get(void)
{
// only 1 for now

     return &AuxFeatureIn;

}

AUX_CELL_HORZ_FE_TYPE    *  auxiliary_threat_horz_fe_get (void)
{
// only 1 for now
      return &AuxHrz;
}

AUX_CELL_VERT_FE_TYPE    *  auxiliary_threat_vert_fe_get (void)
{
 // only 1 for now
      return &AuxVert;
}

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_init
**
** Syntax:          int auxiliary_threat_feature_init( void)
**
** Description:      inits the memory - and sets reflectivity pointers
**
**
**
** Returns:         0 on failure else the memory size
**
** Algorithm:       TBD
**
** Special Notes:   Only needs to be called at init & reset
**.EH-------------------------------------------------------------------------
*/

int auxiliary_threat_feature_init( AUX_THREAT_FE_INPUT_TYPE * auxFeatureIn )
{

 int sz =0;

   auxFeatureIn->aux_vert_short_reflect = (float *)ReflectArrayMem;
   auxFeatureIn->aux_vert_long_reflect = &ReflectArrayMem[N_VERT_SHORT_REFLECT_Y * N_VERT_SHORT_REFLECT_Z];
   auxFeatureIn->aux_horz_short_reflect = (float *)ReflectArrayMem;
   auxFeatureIn->aux_horz_long_reflect = &ReflectArrayMem[N_VERT_SHORT_REFLECT_Y * N_VERT_SHORT_REFLECT_Z];
    // these will be set in the sweep processing --- make sure here they are pointing in default positions


   sz  = sizeof(ReflectArrayMem);

   sz += sizeof(AUX_THREAT_FE_INPUT_TYPE);
   sz += sizeof(AUX_CELL_HORZ_FE_TYPE);
   sz += sizeof(AUX_CELL_VERT_FE_TYPE);
   sz += sizeof(AUX_CELL_THREAT_ATTRIBUTES_TYPE);



   memset(auxFeatureIn,0, sizeof(AUX_THREAT_FE_INPUT_TYPE));

   memset(&AuxVert,0, sizeof(AUX_CELL_VERT_FE_TYPE ));

   memset(&AuxHrz,0, sizeof(AUX_CELL_HORZ_FE_TYPE ));

   // initialization of  AuxVertWAT  variables
   // aux_vert_count = 0;
   // memset(&AuxVertWAT,0,sizeof(AuxVertWAT));


   return sz;
}


/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_check
**
** Syntax:          int auxiliary_threat_feature_check( void)
**
** Description:     checks the state of the  auxiliary_threat_feature structure
**
**
**
** Returns:         1 if OK 0 on failure
**
**
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/


int auxiliary_threat_feature_check( AUX_THREAT_FE_INPUT_TYPE *threat_fe )
{
  // check threat feature struct is ready and populated
   int ok = 1;
   if  ( threat_fe->cell_info->cell_id == -1)
             ok = 0;
   // other integrity checks to follow
   // this struct can be updated in sections
   // routine should verify it is valid for processing


   return ok;

}

/// routines to be called which will populate the Threat Feature extraction struct
/// some will only need to be called occassionally  - not every sweep


/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_set_centroid
**
** Syntax:
**
** Description:     called in aux Wx processing to set centroid cell information
**
**
**
** Returns:         1 on success
**
** Algorithm:
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/

int
auxiliary_threat_feature_set_centroid( AUX_THREAT_FE_INPUT_TYPE *threat_fe , CELL_INFO_TYPE cell_info)

{
  int ok =1;
   // called in aux Wx processing
 
      return ok;
}



/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_set_aircraft
**
** Syntax:          void auxiliary_threat_feature_set_aircraft( AUX_THREAT_FE_INPUT_TYPE *threat_fe,uint32 time_of_sweep,
**                   ALT_TYPE ac_alt, TEMP_C_TYPE sat)
**
** Description:     called in aux Wx processing to set aircraft information
**
**
**
** Returns:      void
**
**
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/



void
auxiliary_threat_feature_set_aircraft( AUX_THREAT_FE_INPUT_TYPE *threat_fe,uint32 time_of_sweep,
                   ALT_TYPE ac_alt, TEMP_C_TYPE sat)
{
      threat_fe->time_of_sweep =  time_of_sweep;
     // threat_fe->ac_alt =  ac_alt;
     // threat_fe->sat =  sat;
}

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_set_reflect
**
** Syntax:          void auxiliary_threat_feature_set_reflect( AUX_THREAT_FE_INPUT_TYPE *threat_fe,
**                  int sweep_type, BIN_RANGE_TYPE low_reflect_cell_extent)
**
** Description:     called in aux Wx processing to set sweep type and reflectivity features
**
**
**
** Returns:      void
**
**
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/


void
auxiliary_threat_feature_set_reflect( AUX_THREAT_FE_INPUT_TYPE *threat_fe, int sweep_type, BIN_RANGE_TYPE low_reflect_cell_extent)
{
  // called in reflectivity processing
  //  other features may be set
      threat_fe->aux_sweep_type =  sweep_type;
  // will also set/check  reflectivity pointers depending on vert versus horizontal sweep
       threat_fe-> low_reflect_cell_extent = low_reflect_cell_extent;


}

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_set_flags
**
** Syntax:          void auxiliary_threat_feature_set_flags( AUX_THREAT_FE_INPUT_TYPE *threat_fe,
**                   int flags )
**
** Description:     called in aux Wx processing to set flags
**
**
**
** Returns:      void
**
**
**
** Special Notes:   currently we just have land-ocean but we probably will need others
**                  just need to reference individual bit values using bit mask
**.EH-------------------------------------------------------------------------
*/

void
auxiliary_threat_feature_set_flags( AUX_THREAT_FE_INPUT_TYPE *threat_fe, int flags )
{
 // we have a word -- we can use 32 bits for flags --- if we want to add more flags
 // for now we just have land_ocean

    threat_fe->cell_info->land_ocean_flag =  flags;


}

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_set_wind
**
** Syntax:          void auxiliary_threat_feature_set_wind( AUX_THREAT_FE_INPUT_TYPE *threat_fe,
**                    WIND_TYPE wind,  WIND_TYPE *vert_wind_profile)
**
** Description:     called in aux Wx processing to set wind profiles
**
**
**
** Returns:      void
**
**
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/

void
auxiliary_threat_feature_set_wind ( AUX_THREAT_FE_INPUT_TYPE *threat_fe,
 WIND_TYPE wind,  WIND_TYPE *vert_wind_profile)
 {
 int i;
    threat_fe->wind = wind;
     for (i = 0; i < N_LAPSE_PROFILE; i++) {

         // threat_fe->vert_wind_profile[i] = vert_wind_profile[i];
     }

 }


/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_feature_set_geographic
**
** Syntax:          void auxiliary_threat_feature_set_geographic( AUX_THREAT_FE_INPUT_TYPE *threat_fe,
**                   ALT_TYPE fms_tropo_alt,  ALT_TYPE climate_tropo_alt,int env_vert_prof_model)
**
** Description:     called in aux Wx processing to set tropopause features and vert profile
**
**
**
** Returns:      void
**
**
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/

void
auxiliary_threat_feature_set_geographic (AUX_THREAT_FE_INPUT_TYPE *threat_fe, ALT_TYPE fms_tropo_alt,
ALT_TYPE climate_tropo_alt,int env_vert_prof_model)

{
// may be more geographic features
     threat_fe-> geo.fms_tropo_alt= fms_tropo_alt;
     threat_fe-> geo.climate_tropo_alt = climate_tropo_alt;
     threat_fe-> geo.env_vert_prof_model = env_vert_prof_model;

}



void
auxiliary_threat_feature_set_antenna_poly (AUX_THREAT_FE_INPUT_TYPE *threat_fe, ANT_POLY_TYPE ant_poly)
{
//
     int i;
     int nc;
     nc = threat_fe-> ant_poly.nc = ant_poly.nc;
     if (nc > N_ANT_POLY_COEF)
         nc = N_ANT_POLY_COEF;  // max nc required?
     for (i = 0 ;i < nc ; i++) {
         threat_fe-> ant_poly.coef[i] = ant_poly.coef[i];
     }

}




///  vert fe
/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_set_vert_fe
**
** Syntax:          void  auxiliary_threat_set_vert_fe(AUX_CELL_VERT_FE_TYPE *vert_fe, int level, ALT_TYPE alt,
**                   TEMP_C_TYPE temp, DBZ_TYPE peak_dbz, BIN_TYPE peak_dbz_range_bin,
**                   float dbz_variance, BIN_RANGE_TYPE *range)
**
**
** Description:     set vert_feature -- alt, temp and peak_dbz
**
**
**
** Returns:      void
**
**
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/

void auxiliary_threat_set_vert_fe(AUX_CELL_VERT_FE_TYPE *vert_fe, int level, ALT_TYPE alt,
                   TEMP_C_TYPE temp, DBZ_TYPE peak_dbz, BIN_TYPE peak_dbz_range_bin,
                   float dbz_variance, NM_RANGE_TYPE *range)
{
 int i;
  // alt probably encoded via level
  if (level >= 0 && level < 60) {
  vert_fe->data[level].alt = alt;
  vert_fe->data[level].temp = temp;
  vert_fe->data[level].peak_dbz = peak_dbz;
  vert_fe->data[level].peak_dbz_range_nm = peak_dbz_range_bin * BIN_TO_NM;
  vert_fe->data[level].dbz_variance= dbz_variance;
  for ( i = 0; i < N_DBZ_RES_VERT; i++) {
  vert_fe->data[level].range[i] = range[i];
  }
  }

}




void auxiliary_threat_set_vert_cell_id(AUX_CELL_VERT_FE_TYPE *vert_fe, CELL_ID_TYPE cell_id, uint32 time_of_sweep)
{
    vert_fe->cell_id= cell_id;
    vert_fe->time_of_sweep = time_of_sweep;
}

///  horz fe


void auxiliary_threat_set_horz_cell_id(AUX_CELL_HORZ_FE_TYPE *horz_fe, CELL_ID_TYPE cell_id, uint32 time_of_sweep)
{
    horz_fe->cell_id= cell_id;
    horz_fe->time_of_sweep = time_of_sweep;
}


void auxiliary_threat_set_horz_alt_temp(AUX_CELL_HORZ_FE_TYPE *horz_fe, ALT_TYPE alt,
                   TEMP_C_TYPE temp)
{
    horz_fe->alt = alt;
    horz_fe->temp = temp;
}




void auxiliary_threat_set_horz_aux_tilt(AUX_CELL_HORZ_FE_TYPE *horz_fe, float tilt)

{
    horz_fe->aux_tilt = tilt;
}

void auxiliary_threat_set_horz_dbz(AUX_CELL_HORZ_FE_TYPE *horz_fe,  DBZ_TYPE peak_dbz,
                   BIN_TYPE peak_dbz_range_bin,
                        int peak_dbz_bearing,
                      float peak_dbz_variance)
 {

      horz_fe-> peak_dbz = peak_dbz;
      horz_fe-> peak_dbz_range_bin = peak_dbz_range_bin;
      horz_fe-> peak_dbz_bearing  = peak_dbz_bearing;
      horz_fe-> peak_dbz_variance = peak_dbz_variance;

 }

void auxiliary_threat_set_NF(AUX_CELL_HORZ_FE_TYPE *horz_fe,BEARING_RANGE_TYPE nf_bearing,
             BIN_RANGE_TYPE nf_range,
    REFLECTIVITY_SHAPE_TYPE *NF_reflect_shape)
{
     horz_fe-> nf_bearing = nf_bearing;
     horz_fe-> nf_range = nf_range;
     memcpy ( (void *) &horz_fe-> NF_reflect_shape , (void *) NF_reflect_shape, sizeof ( REFLECTIVITY_SHAPE_TYPE));


}

void auxiliary_threat_set_dbz_reflect_shape(AUX_CELL_HORZ_FE_TYPE *horz_fe,REFLECTIVITY_SHAPE_TYPE *dbz20_reflect_shape,
    REFLECTIVITY_SHAPE_TYPE *dbz30_reflect_shape,
    REFLECTIVITY_SHAPE_TYPE *dbz40_reflect_shape)
{

   memcpy ( (void *) &horz_fe-> dbz20_reflect_shape , (void *) dbz20_reflect_shape, sizeof ( REFLECTIVITY_SHAPE_TYPE));
   memcpy ( (void *) &horz_fe-> dbz30_reflect_shape , (void *) dbz30_reflect_shape, sizeof ( REFLECTIVITY_SHAPE_TYPE));
   memcpy ( (void *) &horz_fe-> dbz40_reflect_shape , (void *) dbz40_reflect_shape, sizeof ( REFLECTIVITY_SHAPE_TYPE));
}


///  Threat Processing

int auxiliary_threat_lightning( AC_INFO_TYPE *ac_info, AUX_CELL_VERT_FE_TYPE *cell_vert_fe , CELL_INFO_TYPE *cell_info, AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr)
{

   float isotherm_0C_alt;  // in feet
   float altitude_n10C;    // in feet
   float altitude_n20C;    //
   const float LAPSE_RATE_INV  = 505.0505; // in feet
   float cell_range_in_nm;
   float initial_dbZ;
   float lower_dbZ;
   float upper_dbZ;
   float temp_dbZ;
   float delta;
   float raw_confidence;
   float confidence;
   int start_index;
   int end_index;
   float aux_prob_centroid;
   double ac_lat;                   
   double ac_lon;
   double cell_lat;
   double cell_lon;
   int i;
   int using_overall_too;
   int   prime_start_index, prime_end_index; // -10C to -20C based on static air temp
   AUX_OOB_RESULTS_TYPE overall_oob;              // for analysis
   AUX_THREAT_LOCAL_RESULTS_TYPE max_overall;    // for analysis

   AUX_OOB_RESULTS_TYPE prime_oob;
   AUX_THREAT_LOCAL_RESULTS_TYPE max_prime;
   AUX_REGION_TYPE cell_region;
   AUX_POLY_RESULTS_TYPE aux_pol_results;
   // SYDD outputs not requested by Roy or Kevin
   float sum_dbz_0n40C;
   int dbz_0n40C_count;
   float peak_dbz_0n40C;
   float area_dbz_0n40C;
   float altitude_n40C;
   int zero_C_index;
   int n40C_index;
   float max_range_30dbz;
   float temp_range;

   // Analysis Block: 0
   int sum_30_dbz_count = 0;
   int sum_30_dbz_index = 0;
   float sum_30_dbz = 0.0;
   float sum_30_dbz_alt = 0.0;
   float average_30_dbz = 0.0;

   DBZ_RES dbz_res = DBZ_30;

 //  will reference CellThreatAttributes read storm info and write lightning threat rating

 // 1) identify the 0C isotherm altitude - the zero c isotherm altitude
 //    is used to assist in the identifying the most likely spot for lightning
 //    to occur, which has been determined globally to be around -15C, where
 //    a mix between partially melting,partially freezing hail and grabble occur
 //    which creates static charging.

   isotherm_0C_alt =  ( ac_info->ac_baro_alt + ac_info->sat * LAPSE_RATE_INV );

   // for old sydd output
   zero_C_index = (int)(isotherm_0C_alt * 0.001);
   altitude_n40C = isotherm_0C_alt + 40.0*LAPSE_RATE_INV;
   n40C_index = (int)(altitude_n40C * 0.001);

   //  2) determine predicted altitude of -10C
   altitude_n10C = isotherm_0C_alt + 10.0*LAPSE_RATE_INV;

   //  3) determine predicted altitude of -20C
   altitude_n20C = isotherm_0C_alt + 20.0*LAPSE_RATE_INV;

   //  4) determine range of cell
   ac_lat = ac_info->ac_loc.lat;
   ac_lon = ac_info->ac_loc.lon;
   cell_lat = cell_info->centroid_loc.lat;
   cell_lon = cell_info->centroid_loc.lon;
   
   cell_range_in_nm = navig_howFar( ac_lat , ac_lon , cell_lat , cell_lon );
   cell_range_in_nm = 0.539956 * cell_range_in_nm; // navig returns value in km

   //  5) determine prime zone indices
   prime_start_index =  (int)(altitude_n10C * 0.001 ); // looking only for thousands of feet
   prime_end_index   =  (int)(altitude_n20C * 0.001 );

   //  6) loop through the array selecting both max dbz in prime
   //      and  overall max dbz record. ( What kind of floor do we
   //     do we want on starting altitude? Should I run through all
   //     60 or start at -10C altitude whatever that index is?

   // initialize to zero intermediate results
   max_overall.dbZ = 0.0;
   max_overall.alt = 0;
   max_overall.temp = 0.0;
   max_overall.index = 0;
   max_overall.range_nm = 0.0;

   max_prime.dbZ = 0.0;
   max_prime.alt = 0;
   max_prime.temp = 0.0;
   max_prime.index = 0;
   max_prime.range_nm = 0.0;
   max_range_30dbz = 0.0;
   temp_range = 0.0;
   for ( i = 0; i<=N_DBZ_TEMP_PROFILE; i++ )       // -1 N_DBZ need to check this
   {
      if (  (i >= zero_C_index) && ( cell_vert_fe->data[i].peak_dbz >= max_overall.dbZ )) // highest altitude for max overall
      {
           max_overall.alt      = cell_vert_fe->data[i].alt;
           max_overall.dbZ      = cell_vert_fe->data[i].peak_dbz;
           max_overall.temp     = cell_vert_fe->data[i].temp;
           max_overall.range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
           max_overall.index = i;
      }
      // from old sydd

      if (( i >= zero_C_index ) && (i <= n40C_index ) )
      {
          if ( cell_vert_fe->data[i].peak_dbz >= peak_dbz_0n40C ) peak_dbz_0n40C = cell_vert_fe->data[i].peak_dbz;
          // picking 30dbz range for area of n40C_index
          //
          temp_range = (cell_vert_fe->data[i].range[dbz_res].max_range - cell_vert_fe->data[i].range[DBZ_30].min_range);
          if ( temp_range > max_range_30dbz ) max_range_30dbz = temp_range;
      }
      // for prime looking for max dbZ in the -10C through -20C range ( altitude
      // then stop  max_overall will show us where the max dbz occurred if it is
      // not in the prime zone then we have an not well behaved storm.
      if ( ( ( i >= prime_start_index ) &&  ( i <= prime_end_index ) ) && (  cell_vert_fe->data[i].peak_dbz >= max_prime.dbZ ) )
      {
           max_prime.alt      = cell_vert_fe->data[i].alt;
           max_prime.dbZ      = cell_vert_fe->data[i].peak_dbz;
           max_prime.temp     = (float)cell_vert_fe->data[i].temp;
           max_prime.range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
           max_prime.index = i;

      }

      // Analysis Block: 1
      // sum 30 dbz values, and indicate highest alt
      // above -10C incountered
      if ( ( cell_vert_fe->data[i].peak_dbz >= 30.0 ) &&
           ( i >= prime_start_index )                 &&
           ( cell_vert_fe->data[i].peak_dbz < 40.0 ))
      {
         sum_30_dbz = cell_vert_fe->data[i].peak_dbz + sum_30_dbz;
         sum_30_dbz_count = sum_30_dbz_count + 1;
         sum_30_dbz_alt = cell_vert_fe->data[i].alt;
      }

   }  // end for

   // Analysis Block: 2
   if ( sum_30_dbz_count != 0 )
   {
     average_30_dbz = sum_30_dbz / sum_30_dbz_count;
   }

   cell_region = aux_determine_region( cell_info->centroid_loc.lat , cell_info->centroid_loc.lon , cell_info->land_ocean_flag );

   // !!!! cell_info->land_ocean_flag not filled in by current
   cell_region = TEMPRL; // Temporary cludge since most or our test cases are over land.
                                   
   
   // do we use max overall ?
   if ( max_overall.index >= prime_start_index )
   {

      overall_oob = aux_check_oob( max_overall.temp , max_overall.dbZ + aux_z_correction() , cell_region );
      using_overall_too = 1;
   }
   max_prime.dbZ = max_prime.dbZ + aux_z_correction(); // make z correction to dbZ
   prime_oob = aux_check_oob ( max_prime.temp , max_prime.dbZ  , cell_region );

   if ( prime_oob.flags.oob != 0 )
   {
      cellThreatAttr->lightning.score = prime_oob.pol * 100.0;
      cellThreatAttr->lightning.confidence = prime_oob.confidence * 100.0 ;
   }
   else
   {
      // find indices that bracket the dbz
      //  find indices that bracket the dbz
      // each row is 5 dbz higher
      initial_dbZ = 20.0;
      start_index = 0;
      end_index = 0;
      for ( i=0; i<= dbz_row_max-1; i++ )
      {
         if (( max_prime.dbZ >= ( initial_dbZ + 5.0*i ) ) &&
            ( max_prime.dbZ < ( initial_dbZ + 5.0*(i+1)) ) )
         {
            // found the bracket
            start_index = i;
            end_index = i+1;
            break;
         }
      }

      aux_pol_results =  aux_get_pol( cell_region, max_prime.temp, start_index , end_index );
      // --------

      // linearly interpolate between the two poly nomials that are dbz based.
      // [(input dB - lower reflectivity)/(upper reflectivity - lower reflectivity)]*
      // [pol at upper reflectivity - pol at lower reflectivity] +
      // [pol at lower reflectivity]
      upper_dbZ = end_index * 5.0 + initial_dbZ;
      lower_dbZ = start_index * 5.0 + initial_dbZ;

      // if the start_index and the end_index are equal then
      // the dbz exactly matches one of Zipser curves so set
      // the prob_centroid = to the results of either one.
      if ( start_index == end_index )
      {
         aux_prob_centroid = aux_pol_results.upper_pol;
      }
      else
      {

         temp_dbZ = ( ( max_prime.dbZ - lower_dbZ )/(upper_dbZ-lower_dbZ) );
         delta = ( aux_pol_results.upper_pol - aux_pol_results.lower_pol );
         aux_prob_centroid = ( temp_dbZ * delta ) + aux_pol_results.lower_pol;
      }


      //below equation is based on the assumption that the we have high confidence in
      // lightning probability for centroid ranges less than or equal to 40 and no
      // confidence for centroid ranges greater that or equal to 80.
               
      raw_confidence = (-0.025 * max_prime.range_nm + 2) * 100.0;
      confidence =  min( (max(raw_confidence,0.0)), 100.0);

      aux_prob_centroid =  min(  (max(aux_prob_centroid,0.0)), 100.0 ); // normalize to 0 - 100 int only range

      cellThreatAttr->lightning.score =  (int)(aux_prob_centroid);
      cellThreatAttr->lightning.confidence =  (int)(confidence);



   } // oob check


  // debug only
  aux_vert_debug.lightn_using_overall = using_overall_too;
  aux_vert_debug.lightn_overall = max_overall;
  aux_vert_debug.lightn_prime.dbZ     = max_prime.dbZ;
  aux_vert_debug.lightn_prime.range_nm = max_prime.range_nm;
  aux_vert_debug.lightn_prime.alt = max_prime.alt;
  aux_vert_debug.lightn_prime.temp = max_prime.temp;
  aux_vert_debug.lightn_prime.index   = max_prime.index;
  aux_vert_debug.lightn_sum_30_dbz = sum_30_dbz;
  aux_vert_debug.lightn_sum_30_avg = average_30_dbz;
  aux_vert_debug.lightn_sum_30_count = sum_30_dbz_count;
  aux_vert_debug.lightn_sum_30_index = sum_30_dbz_index;
  aux_vert_debug.lightn_sum_30_alt   = sum_30_dbz_alt;


   return 1;
}




// 12.2
int auxiliary_threat_hail( AC_INFO_TYPE *ac_info , AUX_CELL_VERT_FE_TYPE *cell_vert_fe , AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr  )
{

   //  Inputs:
   //    Aux_Vert_Feature_
   //  will reference CellThreatAttributes
   // Local variables
   //
   float isotherm_0C_alt;
   float altitude_n10C;
   const float LAPSE_RATE_INV  = 505.0505; // in feet
   int prime_start_index; // will change based on static air temp
   AUX_THREAT_LOCAL_RESULTS_TYPE highest[7];

   int i;
   float freezing_alt;  // The 0 degree C altitude
   float delta_alt;      // The delta between the centroid altitude and iso_therm_alt
   float delta_alt_km;   // Polynomial requires km not feet
   float peak_dbZ;       // The individual cell centroid dbz
   float confidence;     // confidence for the probability, range based, dbz based
   float range_confidence; // range based confidence
   
   float poh;                   // Intermediate probability of hail
   float aux_hail_prob;         // The final hail probability/score
   float aux_hail_conf;         // The final hail confidence

   float aux_hail_average_prob; // requested for analysis
   int   average_count;         // requested for analysis
   int   selected_highest;      // requested for analysis
   
   float cell_range_miles; // The range in nautical miles to the centroid.
   float cell_temp;        // centroid temperature
   const float HAIL_LAPSE_RATE_INV = 505.050505;
   const float peak_dbz_upper = 53.0; // the upper dbz bound we can extrapolate to
   const float peak_dbz_lower = 20.0; // the lower dbz bound we can extrapolate to
;

   // want to do several contours, i.e.  dbz values so we do
   // highest altitude for each contour.

   // 1) identify the 0C isotherm altitude - the zero c isotherm altitude
   //    is used to assist in the identifying the most likely spot for lightning
   //    to occur, which has been determined globally to be around -15C, where
   //    a mix between partially melting,partially freezing hail and grabble occur
   //    which creates static charging.

   isotherm_0C_alt =  ( ac_info->ac_baro_alt + ac_info->sat * HAIL_LAPSE_RATE_INV );


   //  2) determine predicted altitude of -10C
   altitude_n10C = isotherm_0C_alt + 10.0*LAPSE_RATE_INV;

   //  3) determine -10C index
   prime_start_index =  (int)(altitude_n10C * 0.001 ); // looking only for thousands of feet

   // initialize all highest values
   for ( i=0; i<=6; i++ )
   {
      highest[i].index = 0;
      highest[i].dbZ = 0.0;
      highest[i].temp = 0.0;
      highest[i].alt = 0.0;
      highest[i].prob = 0.0;
      highest[i].conf = 0.0;
      highest[i].range_nm = 0.0;
   }

   for ( i = 0; i<=N_DBZ_TEMP_PROFILE; i++ )       // -1 N_DBZ need to check this
   {
      // we only want values for altitudes above the -10C line

      if ( i >= prime_start_index )
      {
         peak_dbZ = cell_vert_fe->data[i].peak_dbz;
         // one might think that we should compare against the
         // the highest value but we are looking for highest value
         // at the highest altitude.
         if ( peak_dbZ >= 45 )
         {
            highest[6].index    = i;
            highest[6].dbZ      = peak_dbZ;
            highest[6].temp     = cell_vert_fe->data[i].temp;
            highest[6].alt      = cell_vert_fe->data[i].alt;
            highest[6].range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
         }
         if (( peak_dbZ >= 40 ) && (peak_dbZ < 45))
         {
            highest[5].index    = i;
            highest[5].dbZ      = peak_dbZ;
            highest[5].temp     = cell_vert_fe->data[i].temp;
            highest[5].alt      = cell_vert_fe->data[i].alt;
            highest[5].range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
         }
         if ( ( peak_dbZ >= 35 )  && ( peak_dbZ < 40 ))
         {
            highest[4].index    = i;
            highest[4].dbZ      = peak_dbZ;
            highest[4].temp     = cell_vert_fe->data[i].temp;
            highest[4].alt      = cell_vert_fe->data[i].alt;
            highest[4].range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
         }
         if ( ( peak_dbZ >= 30 ) && ( peak_dbZ < 35 ))
         {
            highest[3].index    = i;
            highest[3].dbZ      = peak_dbZ;
            highest[3].temp     = cell_vert_fe->data[i].temp;
            highest[3].alt      = cell_vert_fe->data[i].alt;
            highest[3].range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
         }
         if  ( ( peak_dbZ >= 25 )  && ( peak_dbZ < 30 ) )
         {
            highest[2].index    = i;
            highest[2].dbZ      = peak_dbZ;
            highest[2].temp     = cell_vert_fe->data[i].temp;
            highest[2].alt      = cell_vert_fe->data[i].alt;
            highest[2].range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;
         }
         if  ( ( peak_dbZ >= 20 )  && ( peak_dbZ < 25 ) )
         {
            highest[1].index    = i;
            highest[1].dbZ      = peak_dbZ;
            highest[1].temp     = cell_vert_fe->data[i].temp;
            highest[1].alt      = cell_vert_fe->data[i].alt;
            highest[1].range_nm = cell_vert_fe->data[i].peak_dbz_range_nm;

         }
      }  // end altitude above prime start index
   }

   // Produce probability for each contour
   // initialize internals
   aux_hail_prob = 0.0;
   aux_hail_average_prob = 0.0;
   average_count = 0;
   for ( i=1; i<=6; i++)
   {

      // now for each of the contours run the hail probability and
      // then select the highest probability. Normalizing to 0-100 range
      // for both confidence and probability.

      // Algorithm from Horizontal Hail SyDD
      // use the following third degree polynomial
      // Wadvogal Dat fit to third degree polynomial
      // f(Y) = -1.20231 + 1.00184X - 0.17018X**2 + 0.01086 X ** 3

      // Compute the altitude freezing level delta by subtracting the
      // freezing level altitude from the centroid temperature for the
      // peak dbz.

      // Check for confidence of dbz value ( if dbz < 30 dbz ) then
      // low confidence that we can tell that whether hail will occur.

      // Check for confidence of altitude of dbz value. If the dbz is at an
      // altitude below the freezing altitude then low confidence in the
      // calculate and low/0 probability. ( if dbz altitude freezing level
      // is less than zero )  then confidence is low.



      // Compute the altitude freezing level delta
      // adjustment above the topopause
      freezing_alt = isotherm_0C_alt;
      delta_alt = highest[i].alt - freezing_alt;
      // convert feet to km
      delta_alt_km = delta_alt * FEET_TO_KM;  // Wadvogal requires km not feet

      // set the peak_dbz
      peak_dbZ = highest[i].dbZ;


      // f(Y) = -1.20231 + 1.00184X - 0.17018X**2 + 0.01086 X ** 3
      //   where X is the delta altitude in km - the dbz offset in
      //   km.

      // out of box/bounds restrictions
      // top edge maybe.

      if ( ( delta_alt_km  > 0.0 ) && ( peak_dbZ >= peak_dbz_upper ))
      {
         highest[i].prob = 100.0;
         highest[i].conf = 100.0;
      }
      else if ( ( delta_alt_km < 1.65 ) || (peak_dbZ < peak_dbz_lower ))
      {
         highest[i].prob = 0.0;
         highest[i].conf = 0.0;
      }
      else
      {

         // set the probability curve offset based on the the whether the
         // peak dbz is above the probability curve or below it. And adjust
         if ( peak_dbZ <= 45.0 )
         {
            delta_alt_km = delta_alt_km + ((  peak_dbZ - 45.0 )*0.12);  // the offset will be negative or zero
         }
         else
         {
            delta_alt_km = delta_alt_km + (( peak_dbZ - 45.0 )*0.50); // higher shifts more
         }

         // Calculate the probability of hail
         // f(Y) = -1.20231 + 1.00184X - 0.17018X**2 + 0.01086 X ** 3
         //   where X is the delta altitude in km - the dbz offset in km.


         poh = -1.20231 + 1.00184*delta_alt_km - 0.17018*delta_alt_km*delta_alt_km + 0.01086 * delta_alt_km * delta_alt_km * delta_alt_km;

         // don't normalize the highest[i] probs so that even if they
         // exceed 100 we can distinguish which one was the highest probability
         // and what it's altitude was for which peak_dbz
         // normalize to 0- 100
 //        highest[i].prob = (int) ( min ((max((poh*100.0),0.0) ),100.0));
         highest[i].prob = (int) ( poh*100.0 );

         // Determine range confidence
         // using the range calculated in the cellVertFeature type for
         // the peak_dbz

         //below equation is based on the assumption that the we have high confidence in
         // hail probability for centroid ranges less than or equal to 40 and no
         // confidence for centroid ranges greater that or equal to 80.

         range_confidence = (-0.025 * highest[i].range_nm + 2) * 100.0;
         highest[i].conf = ( int) (min (( max(range_confidence,0.0) ),100.0));  // normalize to 0.0 if value -0

      }

      // Selecting the highest hail probability from all the contours.
      // Should be the dbZ with the highest altitude above -10C isotherm.
      if ( highest[i].prob >= aux_hail_prob )
      {

         aux_hail_prob = highest[i].prob;
         aux_hail_conf = highest[i].conf;
         selected_highest = i;
      }
      if ( highest[i].prob > 0.0 )
      {
         average_count = average_count + 1;
      }
      aux_hail_average_prob = highest[i].prob + aux_hail_average_prob;

   }  // end of final for loop to calculate prob
   if ( average_count != 0 )
   {
       aux_hail_average_prob = aux_hail_average_prob/average_count;
   }
   else
   {
       aux_hail_average_prob = -1; // average not computed indicator
   }


   // Fill SIM2100 output structure with debug info
   //
   aux_vert_debug.aux_hail_selected_highest = selected_highest;
   aux_vert_debug.aux_hail_average_prob  = aux_hail_average_prob;
   aux_vert_debug.aux_hail_average_count = average_count;
   for ( i=1; i<=6; i++ )
   {
      aux_vert_debug.aux_hail_highest[i] = highest[i];
   }

   // now set the  final
   // normalize to 0- 100
   aux_hail_prob = (int) ( min ((max((aux_hail_prob),0.0) ),100.0));

   cellThreatAttr->hail.score = aux_hail_prob;        // 0 to 100
   cellThreatAttr->hail.confidence = aux_hail_conf;           // 0 to 100

   return 1;
}


// 12.3
int auxiliary_threat_convective( AC_INFO_TYPE *ac_info, CELL_INFO_TYPE *cell_info , AUX_CELL_VERT_FE_TYPE *cell_vert_fe , AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr  )
{
   int i,j;

   SCORE_TYPE convective_score;

   int   conv_selected_score;
   SCORE_TYPE conv_threat_scores[5];
   CONFIDENCE_TYPE convective_confidence;
   float range_confidence;

   // for max variance score
   float max_variance = 0.0;


   // for dbz30 count score
   int   dbz30_count = 0;
   int   dbz30_max_alt = 0;


   // for max peak_dbz score
   float max_peak_dbz  = 0.0;
   float peak_dbz_range = 5000.0;
   float max_peak_dbz_alt = 0.0;


   // for max gradient score
   float max_dbzmax_grad    = 0.0;



   // Vertical profile
   int   vert_prof_20dbz_alt = 0; // altitude index for 20 dbz value
   int   vert_prof_1 = 0; // vertical profile condition 1 met
   int   vert_prof_2 = 0; // vertical profile condition 2 met
   float vertical_profile_score = 0.0;
   float vertical_profile_confidence = 0.0;
   float vert_prof_1_rng = 0.0;  // picking range of 30 dbz range for vp conf

   // vertical profile analysis
   int   vert_prof_1_alt = 0;   // analysis
   float vert_prof_1_dbz = 0.0; // analysis
   float vert_prof_2_rng = 0.0; // analysis
   int   vert_prof_2_alt = 0;   // analysis
   float vert_prof_2_dbz = 0.0; // analysis



   float LAPSE_RATE_INV = 505.0505;


   //  0-60,000 foot limiters
   float isotherm_0C_alt;    // isotherm 0C altitude
   int   isotherm_0C_index;  // isotherm 0C index of vertical features array


   // dbz30_range_avg,variance_avg,peak_dbz_avg,pdbz_max_grad_avg


   // 1) identify the 0C isotherm altitude - the zero c isotherm altitude
   //    is used to assist in the identifying the most probable convective
   //    indentifiers.  The current assumption is that convective indicators
   //    are higher peak dbz values above the 0C isotherm, steep gradients,
   //    high variance, and the number of 30dbZ values.

   isotherm_0C_alt =  ( ac_info->ac_baro_alt + ac_info->sat * LAPSE_RATE_INV );
   isotherm_0C_index = (int)(isotherm_0C_alt * 0.001);


   // 2) loop through the vertical features array for datum above the 0C isotherm

   // 3) Peform Various tests for datum above the 0C isotherm
   //    3a) Vertical Profile Test
   //       If land then use if 30 dbz+ is observed anywhere above the
   //       freezing level and 20 dbz+ is observed at eight kilometers+
   //       above ground level then convective_score = 100 , and confidence = range based

   //       If ocean then use if 30 dbz+ is observed anywhere above the
   //       freezing level and 20 dbz+ is observed at six kilometers+
   //       then convective_score = 100 , and confidence = range based *.75
   //       Note the separation between the oceanic convective and non-convective
   //       Zipser profiles intersect around 6-7km sea level which is why we are reducing
   //       the confidence.

   //    3b)  Maximum Peak dbZ score
   //         The maximum peak dbZ value is picked for all peak_dbZ values above
   //         the zero C isotherm.  The altitude of the peak_dbZ may eventually
   //         be used to adjust the peak_dbZ score. Peak_dbZ values at lower
   //         altitudes will be weighted less then pesk_dbZ at higher altitudes.
   //         However, this weighting value needs further analysis to determine
   //         what it should be.
   //    3c)  Maximum Peak dbz gradiant score
   //         The maximum peak dbz gradiant will be selected from the vert_fe
   //         array. There may eventually be a weighting on this value based on
   //         the peak dbz and altitude of the of it.  If the peak dbz is lower
   //         ( 15 > 25 ) then the score will be reduced, however if the gradiant
   //         is at a higher altitude or lower temperature it will be increased.
   //    3d)  Maximum Variance score
   //         The maximum variance will from the vert_fe array. There may eventually
   //         be a weighting value applied as in the scores for peak dbz and gradiant.
   //    3e)  Number of Peak dbZ's above 30 score
   //         The number of peak dbZ above 30 dbz are counted from the vert_fe
   //         array. The initial weighting is to multiply the count by 2 to get
   //         the score.
   //
   // 4) After the loop weighting is appiled to acheive the scores.
   //    The weighting values are yet to be determined pending further analysis.
   //
   // 5) Select the maximum score value from all the scores described in 3 above.
   // 6) Confidence determination - For all of the scores ranged based confidences
   //    are applied with 100 percent at range 40nm dropping linearly to 50 percent.
   //    In the case of vertical profile, if the land ocean flag is set to ocean
   //    then the range based confidence is reduced to 75% of it's normal range
   //    based value.
   // 7) Set the final score and confidence and exit the algoritm.

   //  3a)  set the vertical profile 20dbz altitude for condition
   //       2.
   if ( cell_info->land_ocean_flag == 1 )
   {
      vert_prof_20dbz_alt = 8.0 * KM_TO_FEET * 0.001;
   }
   else if ( cell_info->land_ocean_flag == 0 )
   {
      vert_prof_20dbz_alt = 6.0 * KM_TO_FEET * 0.001;
   }

   // 2) loop through the vertical feature array
   for ( i = 0; i<=N_DBZ_TEMP_PROFILE; i++ )
   {
      // 2) only look at values above the 0C isotherm.
      if ( i >= isotherm_0C_index )
      {

         // 3d)   determine the max variance above the 0C isotherm
         if ( cell_vert_fe->data[i].dbz_variance != 0 )
         {
            max_variance = max(cell_vert_fe->data[i].dbz_variance,max_variance);
         }

         // 3e) Number of Peak dbZ's above 30
         //     count the number of peak_dbz values above 30
         if ( cell_vert_fe->data[i].peak_dbz >= 30.0 )
         {
            // 3a)  Vertical Profile
            //      Condition 1) met have 30dbz above 0C isotherm
            //
            vert_prof_1 = 1;
            vert_prof_1_rng = cell_vert_fe->data[i].peak_dbz_range_nm  ;
            vert_prof_1_alt = i;

            // 3e) Number of Peak dbZ's above 30
            //     count the number of peak_dbz values above 30
            dbz30_count = dbz30_count + 1;
            dbz30_max_alt = i;
         }

         // find the overall peak_dbz and find the average
         // of all the peak_dbz's without the contribution
         // of the zero values and the average their ranges
         if ( cell_vert_fe->data[i].peak_dbz  > 0 )
         {

            // 3a) Vertical Profile
            //     Condition 2 met
            //     vert_prof_20dbz_alt is altitude that
            //     20dbZ must be above.
            if ( ( i >= vert_prof_20dbz_alt ) &&
                 ( cell_vert_fe->data[i].peak_dbz >= 20.0 ) &&
                 ( vert_prof_2 != 1 ) )
            {
               vert_prof_2 = 1;
               vert_prof_2_rng = cell_vert_fe->data[i].peak_dbz_range_nm;
               vert_prof_2_dbz = cell_vert_fe->data[i].peak_dbz;
               vert_prof_2_alt = i;
            }


            // 3c) Maximum dbZ Gradiant
            //     find the max of dbz max gradient
            max_dbzmax_grad = max(cell_vert_fe->data[i].dbz_max_grad,max_dbzmax_grad);
            // compute range gradient
            // 3b) Maximum Peak dbZ
            if (  cell_vert_fe->data[i].peak_dbz >= max_peak_dbz )
            {
               max_peak_dbz = cell_vert_fe->data[i].peak_dbz;
               max_peak_dbz_alt = i;
               // 6) get range at max_peak_dbz score
               peak_dbz_range = cell_vert_fe->data[i].peak_dbz_range_nm;

            }
         }
      }
   } // end for


   // 3a) Vertical Profile score
   // condition 1 and 2 met?
   if ( ( vert_prof_1 == 1 ) && ( vert_prof_2 == 1 ) )
   {

      vertical_profile_score = 100.0;  // how do we get percentages in between.

      vertical_profile_confidence = (-0.0017857 * vert_prof_1_rng + 1.072 ) * 100.0;
      // reduce confidence if over ocean
      if ( cell_info->land_ocean_flag == 0)  vertical_profile_confidence = vertical_profile_confidence * 0.75;
      vertical_profile_confidence = ( min ( max( vertical_profile_confidence , 0.0 ),100.0));
   }
   else
   {
      vertical_profile_score = 0.0;
      vertical_profile_confidence = 100.0;
   }


   // 4) Apply weighting values
   // Note: applying a weighting value on vertical profile score of 0.75 as it
   // is currently binary in function ( 0 or 100 ).  The final intent is to adjust
   // the single points for condition 2 ( 20 dbz altitude ) to a graduated scale
   // above and below the 20dbz altitude with 75% at the condition 2 point ( 8km
   // over land and 6km over ocean ).
   // We know these weightings need to change.  As an example
   conv_threat_scores[0] = (int)(vertical_profile_score * 0.75 );// vertical profile score
   conv_threat_scores[1] = (int)(max_peak_dbz * 2.0);   // max_peak_dbz score
   conv_threat_scores[2] = (int)(max_dbzmax_grad);      // max_gradiant score
   conv_threat_scores[3] = (int)(max_variance);         // max variance score
   conv_threat_scores[4] = (int)(dbz30_count * 2);      // dbz 30 count score


   // 5) Select max score as convective score
   convective_score = 0;
   for ( i=0; i<=4; i++)
   {
      if ( convective_score < conv_threat_scores[i] )
      {
          convective_score = conv_threat_scores[i];
          conv_selected_score = i;  //
      }
   }
   convective_score = min( convective_score , 100 ); // normalize to 100


   // 6)  convective confidence is range based
   // what we are using is the peak_dbz_range
   // below equation is based on the assumption that the we have high confidence in
   // probability for centroid ranges less than or equal to 40 and 50% confidence
   // out to 320 nm.
   //      100 at 40nm, 50 at 320nm
   range_confidence = (-0.0017857 * peak_dbz_range + 1.072 ) * 100.0;
   convective_confidence = (int)(min (( max(range_confidence,0.0) ),100.0));

   if ( conv_selected_score == 0 ) convective_confidence = (int)vertical_profile_confidence;


   // analysis output SIM2100 only block
   aux_vert_debug.conv.selected_score        = conv_selected_score;
   aux_vert_debug.conv.vertical_profile_score = conv_threat_scores[0]; // vertical_profile_score
   aux_vert_debug.conv.max_peak_dbz_score    = conv_threat_scores[1];  // max_peak_dbz_score;
   aux_vert_debug.conv.max_dbzmax_grad_score = conv_threat_scores[2];  // max_gradiant_score;
   aux_vert_debug.conv.max_variance_score    = conv_threat_scores[3];  // max_variance_score;
   aux_vert_debug.conv.dbz30_count_score     = conv_threat_scores[4];  // dbz30_count_score;
   aux_vert_debug.conv.dbz30_max_alt         = dbz30_max_alt;
   aux_vert_debug.conv.max_peak_dbz_raw      = max_peak_dbz;
   aux_vert_debug.conv.vert_profile_raw      = vertical_profile_score;
   aux_vert_debug.conv.max_grad_raw          = max_dbzmax_grad;
   aux_vert_debug.conv.max_variance_raw      = max_variance;
   aux_vert_debug.conv.dbz30_count_raw       = dbz30_count;
   aux_vert_debug.conv.isotherm_0C_alt       = isotherm_0C_alt;
   aux_vert_debug.conv.max_peak_dbz_alt      = max_peak_dbz_alt;
   aux_vert_debug.conv.vert_prof_20dbz_alt =  vert_prof_20dbz_alt;
 
   aux_vert_debug.conv.vert_prof_1 =  vert_prof_1;
   aux_vert_debug.conv.vert_prof_2 =  vert_prof_2;
   aux_vert_debug.conv.vert_prof_1_rng = vert_prof_1_rng;
   aux_vert_debug.conv.vert_prof_1_alt = vert_prof_1_alt;
   aux_vert_debug.conv.vert_prof_1_dbz = vert_prof_1_dbz;
   aux_vert_debug.conv.vert_prof_2_rng = vert_prof_2_rng;
   aux_vert_debug.conv.vert_prof_2_alt = vert_prof_2_alt;
   aux_vert_debug.conv.vert_prof_2_dbz = vert_prof_2_dbz;
//   aux_vert_debug.conv.vertical_profile_score = vertical_profile_score;
   aux_vert_debug.conv.vertical_profile_confidence = vertical_profile_confidence;
   // end SIM2100 analysis block

   cellThreatAttr->convective.score = convective_score;          // 0 to 100
   cellThreatAttr->convective.confidence = convective_confidence;   // 0 to 100
   return 1;

}

// 12.4
int auxiliary_threat_anvil( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreat  )
{
       // fill in anvil  scores
      cellThreat->anvil.score = 0;          // 0 t0 100
      cellThreat->anvil.confidence = 0;   // 0 to 100
      return 1;
}

// 12.5
int auxiliary_threat_storm_top( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreat )
{
       // fill in storm top  scores
       cellThreat->storm_top.vert_storm_top_neg = 0;     // test
       cellThreat->storm_top.vert_storm_top_pos = 0;
       cellThreat->storm_top.vert_storm_top = 0;
       cellThreat->storm_top.storm_top_weight = 0;   // 0 to 100 confidence typw
       return 1;
}

// 12.6
int auxiliary_threat_maturity( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreat )
{
      // fill in maturity scores
      cellThreat->maturity.score = 0;        // 0 to 100
      cellThreat->maturity.confidence = 0;   // 0 to 100

    return OK;
}

//  second-pass
int auxiliary_threat_consolidation( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreat )
{

    // sanity check on scores


    return OK;
}

//////////////////////////// SIM2100 dsp3 IO interface ////////////////////////////////////////////
// The following routine is used to pass 6 vertical data sets to dsp3 to be output into
// WAT cell binary file
int auxiliary_threat_set_auxvert_WAT( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr,AUX_VERT_DEBUG_TYPE *aux_vert_debug,AUX_CELL_VERT_FE_TYPE *cell_vert_fe, CELL_INFO_TYPE *cell_info, AC_INFO_TYPE *ac_info )
{
   unsigned int  temp_time;
   unsigned int hrs, mins, secs;
   char time_of_sweep[8];
   int hrs_tens;
   int hrs_units;
   int mins_tens;
   int mins_units;
   int secs_tens;
   int secs_units;
   //  tell cell_wat_bin write routine that this is new
   AuxVertWAT[aux_vert_count].has_been_output = 0;
   
   //  aux_vert_count is zero based so update it at end of routine
   AuxVertWAT[aux_vert_count].ac_heading =  ac_info->ac_hdg;
   AuxVertWAT[aux_vert_count].ac_baro_altitude = ac_info->ac_baro_alt;  // What if we are using gps_alt?
   AuxVertWAT[aux_vert_count].ac_static_air_temp = ac_info->sat;

   // get time of sweep from vert_fe and convert to hours minues seconds
   // in char 8

   temp_time = cell_vert_fe->time_of_sweep ;
   hrs = temp_time/3600000l;
   temp_time = temp_time - hrs*3600000l;
   mins = temp_time/60000l;
   temp_time = temp_time - mins*60000l;
   secs = temp_time/1000;

   hrs_tens = hrs/10;
   hrs_units = hrs-hrs_tens;
   mins_tens = mins/10;
   mins_units = mins - mins_tens;
   secs_tens = secs/10;
   secs_units = secs - secs_tens;

   sprintf(AuxVertWAT[aux_vert_count].time_of_sweep,"%c%c%c%c%c%c%c%c",hrs_tens,hrs_units,
                      mins_tens,mins_units,secs_tens,secs_units);

   AuxVertWAT[aux_vert_count].vert_sweep_cnt = aux_vert_count;
   AuxVertWAT[aux_vert_count].scan_count_at_sweep = 0; // current_scan;  // where do I get this from
   AuxVertWAT[aux_vert_count].correlation_value = aux_vert_debug->corr_val;
   AuxVertWAT[aux_vert_count].correlation_range = aux_vert_debug->corr_range;
   AuxVertWAT[aux_vert_count].range_peak_dbZ = aux_vert_debug->range;
   AuxVertWAT[aux_vert_count].bearing = aux_vert_debug->bearing;
   AuxVertWAT[aux_vert_count].latitude = cell_info->centroid_loc.lat;
   AuxVertWAT[aux_vert_count].longitude = cell_info->centroid_loc.lon;
   memcpy((void *)&AuxVertWAT[aux_vert_count].aux_vert_results,cellThreatAttr,sizeof(AuxVertWAT[aux_vert_count].aux_vert_results));
   memcpy((void *)&AuxVertWAT[aux_vert_count].aux_vert_debug,(void *)&aux_vert_debug,sizeof(AuxVertWAT[aux_vert_count].aux_vert_debug));
   memcpy((void *)&AuxVertWAT[aux_vert_count].aux_vert_features,(void *)cell_vert_fe,sizeof(AuxVertWAT[aux_vert_count].aux_vert_features));

   // attach the correlated cell id to vertical features array
   AuxVertWAT[aux_vert_count].aux_vert_features.cell_id =
        AuxVertWAT[aux_vert_count].aux_vert_results.cell_id;
   aux_vert_count = aux_vert_count + 1;
   if ( aux_vert_count >= 6 )
   {
     aux_vert_count = 0;
   }

   secs_units = 1;
   
   return 1;
}

/////////////////////////// Cell Attributes ///////////////////////////////////////////////////////

int auxiliary_threat_attributes_check( AUX_THREAT_FE_INPUT_TYPE *cellThreatAttr)
{
   // check cell_attributes is ready and populated
   int ok = 1;
   if  ( cellThreatAttr->cell_info->cell_id == -1)
             ok = 0;
   // other integrity checks to follow
   // this struct can be updated in sections
   // routine should verify it is valid for processing


   return ok;


}




int auxiliary_threat_send_cell_attributes(AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellAttributes)
{
// dummy call to communicate CellThreatAttributes to composite - for radar architecture
// threaded version will ping-pong between buffers  so that composite can be processing
// while this thread can begin on next cell
// on PC composite process thread will use get_cell_attributes
     return OK;

}


/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_get_cell_attributes
**
** Syntax:          int auxiliary_threat_get_cell_attributes(AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellAttributes)
**
** Description:     used by composite threat assessment to get cell attribute struct
**
**
**
** Returns:         1 on success
**
** Algorithm:
**
** Special Notes:
**.EH-------------------------------------------------------------------------
*/

int auxiliary_threat_get_cell_attributes(AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellAttributes)
{
    // composite processing will call this and get a copy of cell attributes struct
    // so just copy over

      memcpy ((void *) cellAttributes, (void *) &CellThreatAttributes, sizeof (AUX_CELL_THREAT_ATTRIBUTES_TYPE));

      // check cell_id is valid




    return OK;
}

/*.BH-------------------------------------------------------------------------
** SUBROUTINE:      auxiliary_threat_processing
**
** Syntax:          void auxiliary_threat_processing (void)
**
**
** Description:     sequence of processing  for threat
**
**
**
** Returns:      void
**
**
**
** Special Notes:   when processing is done -- have to send or signal to composite
**                  processing module that   CellThreatAttributes struct is ready
**.EH-------------------------------------------------------------------------
*/





int auxiliary_threat_processing( AC_INFO_TYPE *ac_info, AUX_CELL_VERT_FE_TYPE *cell_vert_fe , CELL_INFO_TYPE *cell_info, AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreat )
{

int ok;
int my_cell_id;

AUX_CELL_THREAT_ATTRIBUTES_TYPE loc_cellThreatAttributes;
AUX_CORRELATION_TYPE correlation_results;
char time_string[32];
int i;


     sprintf( time_string,"%02d:%02d:%02d", (cell_vert_fe->hms_UTC >> 16) & 0xFF, (cell_vert_fe->hms_UTC >> 8) & 0xFF, cell_vert_fe-> hms_UTC & 0xFF );

//  2.12.7 order

      // SIM2100 block
      correlation_results = aux_vert_corr(cell_info->cell_id, cell_info->centroid_loc.lat , cell_info->centroid_loc.lon , ac_info );
      // adjust cell_id
      if ( correlation_results.correlation_status >= 1 )
      {
         aux_vert_debug.corr_val = correlation_results.correlation_status;
         aux_vert_debug.corr_range = correlation_results.local_range;
         aux_vert_debug.iq_cell_id = cell_vert_fe->cell_id;
         aux_vert_debug.cell_id = correlation_results.cell_id;
         aux_vert_debug.temp    = correlation_results.temp;
         aux_vert_debug.altitude = correlation_results.alt;
         aux_vert_debug.range    = correlation_results.range;
         aux_vert_debug.bearing  = correlation_results.bearing;
         aux_vert_debug.iq_cell_lat = cell_info->centroid_loc.lat;
         aux_vert_debug.iq_cell_lon = cell_info->centroid_loc.lon;

         cell_info->cell_id    = correlation_results.cell_id;
         cell_vert_fe->cell_id = correlation_results.cell_id;
         cellThreat->cell_id = correlation_results.cell_id;


      }
      // end SIM2100 block

      ok =auxiliary_threat_storm_top(cellThreat);

      ok = auxiliary_threat_maturity(cellThreat);

      ok = auxiliary_threat_lightning(ac_info,cell_vert_fe,cell_info,cellThreat);

      ok = auxiliary_threat_hail(ac_info,cell_vert_fe,cellThreat);

      ok = auxiliary_threat_convective(ac_info,cell_info,cell_vert_fe,cellThreat);

      ok = auxiliary_threat_anvil(cellThreat);

      ok = auxiliary_threat_consolidation(cellThreat);

      // set the noodle  -- where does this really need to go
      for ( i=0; i<60; i++ )
      {
          cellThreat->dbz_temp_array[i].dbz = cell_vert_fe->data[i].peak_dbz;
          cellThreat->dbz_temp_array[i].temp = cell_vert_fe->data[i].temp;
      }

      // call the system test write routine
      aux_vert_system_test(cell_vert_fe,cellThreat,ac_info , aux_vert_debug );
      
      // call the text write routine
      aux_vert_threat_write(cellThreat, aux_vert_debug, cell_vert_fe, cell_info); 

      // need a single lat lon in cellThreat
      ok =auxiliary_threat_send_cell_attributes(cellThreat);     // communicate to composite threat assessment (13)

      // SIM2100 block
      // Set aux vert WAT array  ( SIM2100 only )
      ok = auxiliary_threat_set_auxvert_WAT(cellThreat,&aux_vert_debug,cell_vert_fe,cell_info,ac_info);
      // end SIM2100 block

      // DEBUG check get_cell_attributes
      ok =auxiliary_threat_get_cell_attributes(&loc_cellThreatAttributes);    // test a  get call from composite

      my_cell_id = loc_cellThreatAttributes.cell_id;    // test struct copied

      return my_cell_id;
}

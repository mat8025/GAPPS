/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** Header File:   auxiliary_threat_features.h
**
** Description:   This file contains all the routines used for hazard assessment
**
** $Id: auxiliary_threat_features.h 619 2010-05-06 22:42:11Z cjdicker $
**----------------------------------------------------------------------------
*/

//  Auxiliary Threat Feature Extraction
#ifndef _AuxiliaryThreatFeaturesH
#define _AuxiliaryThreatFeaturesH

#include "defines.h"
#include "cell_track_defines.h"

typedef unsigned int CELL_ID_TYPE;
typedef float   DBZ_TYPE;
typedef uint32 UTC_TYPE;
typedef float  TEMP_C_TYPE;
typedef int   BIN_TYPE;
typedef int   ALT_TYPE;
typedef int16 SPEED_TYPE;

typedef int   EXTENT_TYPE;
typedef float BEARING_TYPE;
typedef int   AUX_AREA_TYPE;
typedef int   SCORE_TYPE;       // changed to int per SyDD
typedef int   CONFIDENCE_TYPE;  // changed to int per SyDD 
typedef int16   RATE_TYPE;
typedef float  ANGLE_TYPE;
#define N_VERT_SHORT_REFLECT_Y  120
#define N_VERT_SHORT_REFLECT_Z  253
#define N_VERT_LONG_REFLECT_Y  120
#define N_VERT_LONG_REFLECT_Z  185

#define N_HORZ_SHORT_REFLECT_RAD 181
#define N_HORZ_SHORT_REFLECT_RNG 256

#define N_HORZ_LONG_REFLECT_RAD 181
#define N_HORZ_LONG_REFLECT_RNG 256



#define N_DBZ_RES_VERT  9

#define N_DBZ_TEMP_PROFILE 60
#define N_LAPSE_PROFILE    60    // each 1000'

#define N_ANT_POLY_COEF     10
#define OK   (1)

#define CELL_UNSET  -1

#define MAX_VERT_CELLS 6

//----------------------------------------------------------
// Typedef's
//----------------------------------------------------------

typedef struct {
                      float lat;
                      float lon;
} LOC_TYPE;




typedef struct {
                 SPEED_TYPE speed;
                      short dir;             // deg +/- 180

} WIND_TYPE;

typedef struct {
                  ALT_TYPE    alt;
                  TEMP_C_TYPE temp;
                  LOC_TYPE  loc;
                  WIND_TYPE wind;
                  UTC_TYPE  utc;

} LAPSE_TYPE;                                // This can be sampled as we climb...



TEMP_C_TYPE temp;

typedef struct {
                      float coef[N_ANT_POLY_COEF];
                      int nc;
} ANT_POLY_TYPE;


typedef struct {
                   DBZ_TYPE min;  
                   DBZ_TYPE max;
} DBZ_RANGE_TYPE;                            

typedef struct {
                   BIN_TYPE min_range;
                   BIN_TYPE max_range;   
} BIN_RANGE_TYPE;

typedef struct {
                   float min_range;
                   float max_range;   
} NM_RANGE_TYPE;

typedef struct {
               BEARING_TYPE min;
               BEARING_TYPE max;
} BEARING_RANGE_TYPE;



typedef struct {
      ALT_TYPE     ac_baro_alt;
      ALT_TYPE     ac_gps_alt;
      ALT_TYPE     ac_rave_alt;
      LOC_TYPE     ac_loc;
      SPEED_TYPE   ac_speed;  // knots
      ANGLE_TYPE   ac_hdg;    // deg
      ANGLE_TYPE   ac_track;

      SPEED_TYPE   ac_grd_speed;
      WIND_TYPE    wind;
      TEMP_C_TYPE  sat;
      int          ac_fphase; // radio flight_phase 

}  AC_INFO_TYPE;       //  this info is presumably present already in most of the DSP1,DSP2 etc
                       // but for easy ref we can fill in this so the aux_threat, composite threat assessment
                       // modules can use for easy reference


typedef struct {
               CELL_ID_TYPE cell_id;
                   LOC_TYPE centroid_loc;
                   ALT_TYPE centroid_alt;
                TEMP_C_TYPE centroid_temp;        // deg C
                        int land_ocean_flag;
                struct FLOAT_LR az_width;   // LEFT, RIGHT
                struct FLOAT_LR delta_bin;  // LEFT, RIGHT 
                struct FLOAT_LRC far_depth;  // LEFT, RIGHT, CENTER --- these are in fractional bins (LR unit) 
                                             // and relative to center posn
                struct FLOAT_LRC near_depth; // LEFT, RIGHT, CENTER
} CELL_INFO_TYPE;




typedef struct {
      ALT_TYPE fms_tropo_alt;         // Provisional
      ALT_TYPE climate_tropo_alt;     // climatological tropo alt ---byte 0 from Geographic climate array
      int env_vert_prof_model;   // comes from geographic table

}  GEO_TYPE;


/// Auxiliary Threat Feature Extraction Input
/// 2.12.7
typedef struct {
               CELL_INFO_TYPE *cell_info;
               AC_INFO_TYPE *ac_info;
                     uint32 time_of_sweep;         // Seconds since midnight
                        int aux_sweep_type;        //  vert or horz
                  WIND_TYPE wind;
                  LAPSE_TYPE wind_temp_lapse_profile[N_LAPSE_PROFILE];
                  GEO_TYPE geo; // tropo alts, env_vert_prof
                  BIN_RANGE_TYPE low_reflect_cell_extent;  // is this defunct now ?

              ANT_POLY_TYPE ant_poly;              // Holds up to 10 coef.  Can be adjusted if needed.

                      float *aux_vert_short_reflect;
                      float *aux_vert_long_reflect;
                      float *aux_horz_short_reflect;
                      float *aux_horz_long_reflect;
}  AUX_THREAT_FE_INPUT_TYPE;



// This is tied to the N_DBZ_RES_VERT
typedef enum {
         DBZ_50,
         DBZ_45,
         DBZ_40,
         DBZ_35,
         DBZ_30,
         DBZ_25,
         DBZ_20,
         DBZ_15,
         DBZ_NF,
} DBZ_RES;



typedef struct {
                   ALT_TYPE alt;
                TEMP_C_TYPE temp;
                   DBZ_TYPE peak_dbz;                 // the peak val   --- dbZ  range 63 1/4 db res  - 3025 --> 30.25
                   float peak_dbz_range_nm;       // bin where this occurs
                   float dbz_variance;
                   float dbz_max_grad;
             NM_RANGE_TYPE range[N_DBZ_RES_VERT];
} VERT_FE_TYPE;

/// Auxiliary Vertical Threat Feature Extraction
/// 2.12.7.1
typedef struct {
               CELL_ID_TYPE cell_id;
               uint32 time_of_sweep;      // seconds since midnight
               long   hms_UTC;  // easy ref for GPS UTC

               VERT_FE_TYPE data[60];  // 0-60,000'

} AUX_CELL_VERT_FE_TYPE;

typedef struct {
      int32 rshape[16];   // want 64 bytes ---
} REFLECTIVITY_SHAPE_TYPE;


/// Auxiliary Horizontal Threat Feature Extraction
/// 2.17.7.2
typedef struct {
               CELL_ID_TYPE cell_id;
                     uint32 time_of_sweep;     // seconds since midnight
                   ALT_TYPE alt;
                TEMP_C_TYPE temp;
                      float aux_tilt;
            //ANT_TILT_TYPE ant_tilt;
                   DBZ_TYPE peak_dbz;
                   BIN_TYPE peak_dbz_range_bin;
                        int peak_dbz_bearing;
                      float peak_dbz_variance;
         BEARING_RANGE_TYPE nf_bearing;
             BIN_RANGE_TYPE nf_range;
    REFLECTIVITY_SHAPE_TYPE NF_reflect_shape;
    REFLECTIVITY_SHAPE_TYPE dbz20_reflect_shape;
    REFLECTIVITY_SHAPE_TYPE dbz30_reflect_shape;
    REFLECTIVITY_SHAPE_TYPE dbz40_reflect_shape;
} AUX_CELL_HORZ_FE_TYPE;


typedef struct {
    SCORE_TYPE      score;
    CONFIDENCE_TYPE confidence;
 }  RATING_TYPE;


typedef struct {
             ALT_TYPE vert_storm_top;
             ALT_TYPE vert_storm_top_pos;
             ALT_TYPE vert_storm_top_neg;
             CONFIDENCE_TYPE storm_top_weight;
}  STORM_TOP_TYPE;

// noodle element type
typedef struct {
   DBZ_TYPE      dbz;
   TEMP_C_TYPE   temp;

}  DBZ_TEMP_TYPE;

//  local structures for aux lighnting and hail
typedef struct {
    int   index;
    float dbZ;
    float temp;
    float alt;
    float prob;
    float conf;
    float range_nm;

} AUX_THREAT_LOCAL_RESULTS_TYPE;

//  debug structure for output of aux_vert_threat_data
typedef struct {
  int    selected_score;
  float  vertical_profile_score;
  float  vert_profile_raw;
  float  max_peak_dbz_score;
  float  max_peak_dbz_raw;
  float  max_dbzmax_grad_score;
  float  max_grad_raw;
  float  max_variance_score;
  float  max_variance_raw;
  int    dbz30_count_score;
  int    dbz30_count_raw;
  int    peak_dbz_alt;
  int    dbz30_max_alt;
  float  isotherm_0C_alt;
  int    max_peak_dbz_alt;
  int    vert_prof_20dbz_alt;
  int    vert_prof_1;
  int    vert_prof_2;
  float  vert_prof_1_rng;
  int    vert_prof_1_alt;
  float  vert_prof_1_dbz;
  float  vert_prof_2_rng;
  int    vert_prof_2_alt;
  float  vert_prof_2_dbz;
  float  vertical_profile_confidence;

} AUX_CONV_THREAT_DEBUG_TYPE;

typedef struct {
  int corr_val;
  float corr_range;
  unsigned int iq_cell_id;
  unsigned int cell_id;
  float iq_cell_lat; // from vert_fe ( IQ file input )
  float iq_cell_lon; // from vert_fe ( IQ file input )
  float altitude;    // from correlation function ( alt of cell centroid )
  float temp;        // from correlation function ( temp of cell centroid )
  float range;       // calculated from iq lat lon
  float bearing;     // calculated from iq lat lon and airplane heading
  int vert_count; // total number of verticals
  AUX_THREAT_LOCAL_RESULTS_TYPE lightn_overall;
  AUX_THREAT_LOCAL_RESULTS_TYPE lightn_prime;
  // Analysis Block:  debug data
  int   lightn_using_overall;
  float lightn_sum_30_dbz;
  float lightn_sum_30_avg;
  float lightn_sum_30_count;
  float lightn_sum_30_index;
  float lightn_sum_30_alt;
  int aux_hail_selected_highest;
  float aux_hail_average_prob;
  float aux_hail_average_count;
  AUX_THREAT_LOCAL_RESULTS_TYPE aux_hail_highest[7];

  AUX_CONV_THREAT_DEBUG_TYPE conv;

} AUX_VERT_DEBUG_TYPE;

//static AUX_VERT_DEBUG_TYPE aux_vert_debug;

///  Auxiliary Cell Attributes (vertical tracks)
///  2.4.2
///  This struct will be filled by the auxiliary threat processing  12.1 - 12.6
///  for each cell in turn  and then sent on to Composite threat assessment
///  storm, maturity, lightning, hail, convective and anvil will read and write from this structure


typedef struct {
      CELL_ID_TYPE cell_id;
      RATING_TYPE lightning;
      RATING_TYPE hail;
      RATING_TYPE convective;
      RATING_TYPE anvil;
      RATING_TYPE electric_region;
      RATING_TYPE maturity;
      STORM_TOP_TYPE storm_top;
      DBZ_TYPE    peak_dbz_zero_n40C;  // what is this supposed to be
      AUX_AREA_TYPE   area_dbz_zero_n40C;  // what is this supposed to be
      DBZ_TEMP_TYPE  dbz_temp_array[N_DBZ_TEMP_PROFILE];    // the profile noodle

} AUX_CELL_THREAT_ATTRIBUTES_TYPE;

typedef struct {
     int   has_been_output;
     char  time_of_sweep[8];
     int   vert_sweep_cnt;
     int   scan_count_at_sweep;
     int   correlation_value;
     float correlation_range;
     float range_peak_dbZ;
     float bearing;
     float ac_heading;
     float ac_baro_altitude;
     float ac_static_air_temp;
     float latitude;
     float longitude;
     unsigned int iq_cell_id;
     AUX_CELL_THREAT_ATTRIBUTES_TYPE aux_vert_results;
     AUX_CELL_VERT_FE_TYPE aux_vert_features;
     AUX_VERT_DEBUG_TYPE aux_vert_debug;
} AUX_VERT_WAT_ELEMENTS_TYPE;

extern float ReflectArrayMem[];
extern AUX_CELL_THREAT_ATTRIBUTES_TYPE CellThreatAttributes;
extern AUX_THREAT_FE_INPUT_TYPE  AuxFeatureIn;
extern AUX_CELL_HORZ_FE_TYPE     AuxHrz;
extern AUX_CELL_VERT_FE_TYPE     AuxVert;
extern AUX_VERT_WAT_ELEMENTS_TYPE  AuxVertWAT[MAX_VERT_CELLS];
extern AUX_VERT_DEBUG_TYPE aux_vert_debug;

AUX_THREAT_FE_INPUT_TYPE *  auxiliary_threat_feature_get(void);

AUX_CELL_THREAT_ATTRIBUTES_TYPE * auxiliary_threat_attributes_get(void);

AUX_CELL_HORZ_FE_TYPE    *  auxiliary_threat_horz_fe_get (void);

AUX_CELL_VERT_FE_TYPE    *  auxiliary_threat_vert_fe_get (void);

int auxiliary_threat_feature_init( AUX_THREAT_FE_INPUT_TYPE * auxFeatureIn );


int auxiliary_threat_feature_set_centroid( AUX_THREAT_FE_INPUT_TYPE *threat_fe ,CELL_INFO_TYPE cell_info);
                 

void auxiliary_threat_feature_set_aircraft( AUX_THREAT_FE_INPUT_TYPE *threat_fe,uint32 time_of_sweep,
                   ALT_TYPE ac_alt, TEMP_C_TYPE sat);

void
auxiliary_threat_feature_set_flags( AUX_THREAT_FE_INPUT_TYPE *threat_fe, int flags );

void auxiliary_threat_feature_set_reflect( AUX_THREAT_FE_INPUT_TYPE *threat_fe, int sweep_type,
BIN_RANGE_TYPE low_reflect_cell_extent);

void auxiliary_threat_feature_set_wind ( AUX_THREAT_FE_INPUT_TYPE *threat_fe,
 WIND_TYPE wind,  WIND_TYPE *vert_wind_profile) ;

void auxiliary_threat_feature_set_geographic (AUX_THREAT_FE_INPUT_TYPE *threat_fe,ALT_TYPE fms_tropo_alt, ALT_TYPE climate_tropo_alt,
        int env_vert_prof_model) ;

void
auxiliary_threat_feature_set_antenna_poly (AUX_THREAT_FE_INPUT_TYPE *threat_fe, ANT_POLY_TYPE ant_poly);


void auxiliary_threat_set_vert_fe(AUX_CELL_VERT_FE_TYPE *vert_fe, int level, ALT_TYPE alt,
                   TEMP_C_TYPE temp, DBZ_TYPE peak_dbz, BIN_TYPE peak_dbz_range_bin,
                   float dbz_variance, NM_RANGE_TYPE *range);

void auxiliary_threat_set_vert_cell_id(AUX_CELL_VERT_FE_TYPE *vert_fe, CELL_ID_TYPE cell_id, uint32 time_of_sweep);


void auxiliary_threat_set_horz_alt_temp(AUX_CELL_HORZ_FE_TYPE *horz_fe, ALT_TYPE alt,
                   TEMP_C_TYPE temp);


void auxiliary_threat_set_horz_aux_tilt(AUX_CELL_HORZ_FE_TYPE *horz_fe, float tilt) ;



void auxiliary_threat_set_horz_dbz(AUX_CELL_HORZ_FE_TYPE *horz_fe,  DBZ_TYPE peak_dbz,
                   BIN_TYPE peak_dbz_range_bin,
                        int peak_dbz_bearing,
                      float peak_dbz_variance);

void auxiliary_threat_set_NF(AUX_CELL_HORZ_FE_TYPE *horz_fe,BEARING_RANGE_TYPE nf_bearing,
             BIN_RANGE_TYPE nf_range,
    REFLECTIVITY_SHAPE_TYPE *NF_reflect_shape);

void auxiliary_threat_set_dbz_reflect_shape(AUX_CELL_HORZ_FE_TYPE *horz_fe,REFLECTIVITY_SHAPE_TYPE *dbz20_reflect_shape,
    REFLECTIVITY_SHAPE_TYPE *dbz30_reflect_shape,
    REFLECTIVITY_SHAPE_TYPE *dbz40_reflect_shape);




int auxiliary_threat_feature_check( AUX_THREAT_FE_INPUT_TYPE *threat_fe );
int auxiliary_threat_attributes_check( AUX_THREAT_FE_INPUT_TYPE *cellThreatAttr) ;

int auxiliary_threat_lightning( AC_INFO_TYPE *ac_info, AUX_CELL_VERT_FE_TYPE *cell_vert_fe , CELL_INFO_TYPE *cell_info, AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr );
int auxiliary_threat_hail( AC_INFO_TYPE *ac_info, AUX_CELL_VERT_FE_TYPE *cell_vert_fe , AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr );
int auxiliary_threat_convective( AC_INFO_TYPE *ac_info, CELL_INFO_TYPE *cell_info, AUX_CELL_VERT_FE_TYPE *cell_vert_fe , AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr );
int auxiliary_threat_anvil( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr  ) ;
int auxiliary_threat_consolidation ( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr  ) ;
int auxiliary_threat_storm_top( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr ) ;
int auxiliary_threat_maturity( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr );
int auxiliary_threat_set_auxvert_WAT( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr, AUX_VERT_DEBUG_TYPE *aux_vert_debug, AUX_CELL_VERT_FE_TYPE *cell_vert_fe, CELL_INFO_TYPE *cell_info, AC_INFO_TYPE *ac_info );  // SIM2100 only
int auxiliary_threat_processing( AC_INFO_TYPE *ac_info, AUX_CELL_VERT_FE_TYPE *cell_vert_fe ,CELL_INFO_TYPE *cell_info,AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr );
int auxiliary_threat_send_cell_attributes( AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellThreatAttr );
int auxiliary_threat_get_cell_attributes(AUX_CELL_THREAT_ATTRIBUTES_TYPE *cellAttributes);



#endif

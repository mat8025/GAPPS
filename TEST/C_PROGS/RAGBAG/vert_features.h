/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** Header File:   vert_features.h
**
** Description:   This file contains all the routines used for hazard assessment
**
** $Id: vert_features.h 619 2010-05-06 22:42:11Z cjdicker $
**----------------------------------------------------------------------------
*/


#ifndef _VERT_FEATURES_H
#define _VERT_FEATURES_H

#define N_ALT_1K_LEVELS 60

#define SR_MAX_RANGE 40
#define SR_NM_STEP  0.161987
#define LR_NM_STEP  0.647948

#define LR_MAX_RANGE 320

#define PC_Y  120
#define PC_X  256


#define LAT_LON_SCALE   (90.0 /524288.0)    // scaling for int lat,lng values

#include "aux_scan.h"
#include "auxiliary_threat_features.h"


typedef struct {
  int id;
  float lat;
  float lng;
  float start_r;
  float end_r;
  float range_nm;   // from ac to cell
  float bearing; //
  float alt; // ac alt at time of start of sweep
  float ac_lat;
  float ac_lng; 

} VFE_FEAT_TYPE;


// need a binary stream of various ac/cell info features and images
// data header

#define SIM_DATA_KEY 0xAC01FEED   // versions will be 01,02 ...

typedef struct {

  int magic_id;
  int type;
  int nbytes;

} BINFO_HDR;


typedef enum {
  
  BI_VS_FEATS,  
  BI_VS_SR_IMG,
  BI_VS_LR_IMG,

} BINFO_TYPES;




float vfe_howFar(double lata, double lnga, double latb, double lngb);
void  vfe_tempProfile (float ac_baro_alt, float ac_sat, AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe);

void  vert_fe(AUX_SCAN_TYPE *aux_scan, AUX_THREAT_FE_INPUT_TYPE *aux_threat_fe_input,
 AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe, int t_epoch);


void runPC();
void buildPCinput();

extern FILE *vfe_log ; // error why?
extern int VFE_debug;

extern CELL_INFO_TYPE VFE_cell_info;

//extern "C" { void set_VFE_cell ( int vs_cell_id);}
//void set_VFE_cell ( int vs_cell_id);



#endif

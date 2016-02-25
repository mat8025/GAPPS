/*-----------------------------------------------------------------------------
**
** © Copyright 2010 All Rights Reserved
** Rockwell Collins, Inc. Proprietary Information
**
** 
**
** Description:   This file contains defines & protocols for 
**                flight_phase
**
**
** $Id$
**----------------------------------------------------------------------------
*/

#ifndef _FlightPhaseH
#define _FlightPhaseH


//////////////////////////////////

#define CRSIZE 3

typedef struct {

     int flight_mode;
     int previous_flight_mode;
     int hold_mode;
     int hold_descent_mode_secs; // count of secs to go in descent hold
     int hold_climb_mode_secs;
     int hold_descent_mins;

     int hold_climb_mins;
     int hold_descent_secs;
     int hold_climb_secs;
     int slew_mins;
     int max_flight_phase_reached;
     int min_flight_phase_reached;
     float slew_rate;
     float f_rate ;   // can be used to accelerate flight_phase change
                      // possibly in an emergency descent - this would be >4000'min and triggered by large descent
                      // values but for the current implementation
                      //  f_rate is 1 for all operations

     float hold_flight_phase;
     float flight_phase;
     float last_fp;
     float last_flight_phase;
     float max_flight_phase;
     float min_flight_phase;
     float climb_phase_max;
     float descent_phase_min;
     float climb_mode_thres ;   //
     float descent_mode_thres ;  // probably should be adjusted for more sensitivity
     float min_descent_phase_level;  // above this no descent hold
     float min_climb_phase_level;  // below this no climb hold

     float TCR ;// threshold  climb rate  any climb rate that exceeds this is limited to this threshold climb rate
     float MCR ; // minimum climb rate  dead-band
     float TCR_scale;
     float crfpm;
     float ave_cr_val;  // short term ave of baro-alt change
     float cr_val;
     float delta_baro;
     float delta_alt;
     float last_delta_baro;
     float last_baro;
     unsigned int tim;
     unsigned int last_tim;
     float alt;
     float gps_alt;
     float r_fphase;   // radio flight_phase from header
     float r_calc_fp;  // flight phase calc from radio fp module
     float r_phi_offset;  // phi_offset calc from radio fp module    
     int fp_update ;   // use bool?
     int fp_calc_init;
     unsigned int fp_cnt;
     int CRtrend[CRSIZE];	// descent/climb short-term average


} FLIGHT_PHASE_TYPE;




float ave (int *vec , int n);
void  shiftL(int *vec, int n, int val, int n_shift);
void  vecFill(int *vec, int n, int val);



void initFlightPhase( FLIGHT_PHASE_TYPE *flightP);
void setFlightPhaseHold(FLIGHT_PHASE_TYPE *flightP,
int flight_mode, float flight_phase, float hold_flight_phase,
int hold_mode, int hold_descent_mode, int hold_climb_mode);
void limitFlightPhase(  FLIGHT_PHASE_TYPE *flightP);
void limitDeltaBaro(FLIGHT_PHASE_TYPE *flight );
void slewFlightPhase(FLIGHT_PHASE_TYPE *flightP,int dsecs);
void aveCrFlightPhase( FLIGHT_PHASE_TYPE *flightP, int dsecs);
int checkFlightMode (FLIGHT_PHASE_TYPE *flightP);
void calcFlightPhase (FLIGHT_PHASE_TYPE *FlightP);
float raveAlt (float balt );

#define N_RAVE 750

#define RAVE_MULT  (0.0013333333)
#define DESCENT_HOLD_MINS 5
#define CLIMB_HOLD_MINS 5
#define SLEW_MINS 2

#define MAX_FLIGHT_PHASE (1.0)
#define MIN_FLIGHT_PHASE (-1.0)


void radio_fp(FLIGHT_PHASE_TYPE *FlightP);


#endif

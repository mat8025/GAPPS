
#ifndef FLIGHTPHASE_H
#define FLIGHTPHASE_H
#include <stdio.h>
#include <fcntl.h>

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
     float f_rate ;  // used to accelerate flight_phase change during emergency descent - this would be >4000'min
                     //  f_rate is 1 for normal operations
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
     float last_delta_baro;
     float last_baro;
     unsigned int tim;
     unsigned int last_tim;
     float alt;

     int fp_update ;   // use bool?
     int fp_calc_init;
     unsigned int fp_cnt;
     int CRtrend[CRSIZE];	// descent/climb mode


} FLIGHT_PHASE_TYPE;


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

#define DESCENT_HOLD_MINS 5
#define CLIMB_HOLD_MINS 5
#define SLEW_MINS 2

#define MAX_FLIGHT_PHASE (1.0)
#define MIN_FLIGHT_PHASE (-1.0)







extern float Alt[];
extern float Tim[];
extern float DA[];
extern float FP[];
int  readTestCase(void);
int  runTestCase(int wc);

void foo();





extern FILE *ifp;

extern char tc_comment[240];
extern char tc_intent[240];
extern char tc_profile[240];
#define N_TEST_CASES 15
#endif


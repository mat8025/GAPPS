/*-----------------------------------------------------------------------------
 **
 ** © Copyright 2010 All Rights Reserved
 ** Rockwell Collins, Inc. Proprietary Information
 **
 ** Header File:   IQ_Proc.c
 **
 ** Description:   This file is the main loop for the sim2100
 **  readIQ's ---->DSP1  ---> DSP2--> DSPM/M2  --->  DSP3 .....> DSP1
 **
 ** $Id: IQ_Proc.c 542 2010-04-27 20:11:53Z amterry $
 **----------------------------------------------------------------------------
 */

// History  2000? ---->

/* 04/04/01 Greg Koenigs Removed all warns generated from the compile.*/
/* 04/09/01 changed the 2100 short range to 256 bins*/
/* 04/10/01 adjusted azimuth filter and added gain in wx1.c. */

#include <windows.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <io.h>
#include <sys\stat.h>

#include "defines.h"
#include "utilities.h"
#include "erib.h"
#include "IQ_proc.h"
#include "id_size.h"
#include "wx1.h"
#include "wx2.h"
#include "datetime.h"

#include "display_tilt.h"
#include "pack.h"
#include "platform.h"
#include "gui_var_init.h"
#include "dspm_main.h"
#include "dspm_defines.h"
#include "send453toWxiCtrl.h"
#include "units.h"
#include "aux_scan.h"
#include "dsp1.h"
#include "dsp2.h"
#include "flight_path_threat.h"
#include "wx1_aux_vert_proc.h"
#include "wx2_aux_vert_proc.h"
#include "wx1_aux_horiz_proc.h"
#include "wx2_aux_horiz_proc.h"
#include "auxiliary_threat_features.h"
#include "cell_track_defines.h"




////////////// aux sweep gui stuff

#include "Unit4b.h"

#ifndef max
#define max(__a,__b)    (((__a) > (__b)) ? (__a) : (__b))
#endif
#ifndef min
#define min(__a,__b)    (((__a) < (__b)) ? (__a) : (__b))
#endif

#pragma hdrstop
#pragma argsused
#define L_RNG_NM_TO_BIN       101214.75           // 2^16 / (331.5172/512)
#define S_RNG_NM_TO_BIN       809717.06           // 2^16 / (41.4397/512)
#define NM_TO_DISPLAY_BIN     104857.6            // 2^16 / (320/512)
#define NM_TO_L_RNG_BIN       1.5444144
#define NM_TO_S_RNG_BIN       12.3553152
#define FT_PER_LR_BIN         3934.3              // (331.5172/512) * 6076.1155 ft
#define FT_PER_SR_BIN         491.78              // (41.4397/512) * 6076.1155 ft
#define HI_LO_BW_CONVERSION   0.265625


FILE *arch_db_file = NULL;
FILE *servo_db_file = NULL; // MAT

// constant factor used for short range scan and tilt angle adjustments
#define K_SR_SCAN_ANGLE_ADJ   0.00521  // horizontal scans = 2/3/128
#define K_SR_TILT_ANGLE_ADJ   0.01042  // vertical scans = 2/3/64




int Arch_db;
int Arch_db_swp_cnt = 38;

int info_to_next_l_r( long int *r_l_epoch_ptr,
FILE *,
long int *l_r_start );

void high_low_bw( short int *I,
short int *Q,
int bins );

static int first_dspm_call = FALSE;
_453_VECTOR_TYPE wxrv;                            /*453 data vector*/
char p1_453_file[256];
char p3_453_file[256];
IQ_FILE_TYPE IQ_file;
IQ_FILE_STATE_TYPE IQ_file_state;
enum                                              //MAT -made global for readPRF()
{
    WRT700, WRT2100
} data_format;

extern FILE_WRITE_TYPE File_Writes;
extern GUI_PROC_DATA_TYPE GuiProcData;

void readPRF (short int  num_prfs, int data_format, short int *num_pulses, int *bin, ushort *PWidth,
ulong freq_code[MAX_PRF_SETS][MAX_PULSES][3],
ulong phase[MAX_PRF_SETS][MAX_PULSES][3],
short int I[MAX_PRF_SETS][MAX_PULSES * MAX_RANGE_BIN],
short int Q[MAX_PRF_SETS][MAX_PULSES * MAX_RANGE_BIN],
ulong STC[MAX_PRF_SETS][MAX_RANGE_BIN],
ulong *buffer4 ,
	      long *bytes_read,
	      int lr_bw,
              int sr_bw);

void setGuiFromServo( GUI_VAR_TYPE  *gui_var, struct SERVO *servo_data);

typedef  struct
{
    float speed;
    float dir;
    float raw_angle;
    float filtered_angle;
    float hdg;
    float hdg_scan;
    float hdg_fscan;
    float ant_hdg;
    float dsp_hdg_delta;
} Scan;

//////////////////////////////////  ADD FUTURE MODULES INTO DSP1, DSP2, DSP3 and DSPM  ////////////////////////////

//*******************************************************
void iqproc ( unsigned long data_file_size,
unsigned long *plane_out,
GUI_VAR_TYPE *gui_var )
{
    char bar;
    FILE *plane1, *plane2, *merged_plane;
    unsigned long buffer4 [MAX_PRF_SET_SIZE];
/* Buffer size is determined
                                               by which is the number of
                                               range bins: max_pulses*max_range_bins */
    V1_AC_IQ_Header_Type ac_iq_header;            // = (V1_AC_IQ_Header_Type*)buffer4;
    AC_INFO_TYPE  ac_info;                        // fill this in and pass on to dsp1,dsp2 ...
    static int iqproc_init = 1;
    int  i,j,k;
    unsigned char dummy;
    short int dummy1;
    short int prf_index;
//MAT   short int pulse_index;
    unsigned long byte_cntr;
    unsigned int az_cnt = 0;
    unsigned char ACdate[9];
    unsigned char millisec_ctr_hrs;
    unsigned char millisec_ctr_minutes;
    unsigned char millisec_ctr_sec;
    char millisec_ctr_time_string[9];
    unsigned char hrs;
    unsigned char minutes;
    unsigned char sec;
    unsigned long time, temp_time;
    static unsigned long last_time = 0;
    unsigned long isecs;
    unsigned char label [4];
    unsigned long length = 0;
    static float t_head = 0.0;
    static float gspd = 0.0;
    static float gs_knots = 0.0;
    float bar_alt = 0.0;
    float track = 0.0;
    float pitch = 0.0;
    float roll = 0.0;
    float rad_alt = 0.0;
    float drift_angle = 0.0;
    float airspeed;
    int rad_alt_valid;
    static double prev_t_head = 0.0f;
    static double prev_gs_knots = 0.0f;
    static unsigned long int prev_time = 0;
    float  lat, lon, temp_64;
    unsigned long hms_UTC;
    unsigned char IQdate [9];
    unsigned char IQlabel [5];
    short int scan_value = 0;
    float scan_angle[2], prev_scan_angle = 999;
    enum scan_direction_type { UNKNOWN, LEFT_TO_RIGHT, RIGHT_TO_LEFT };
//MAT I am not sure what is  going on here
    static enum scan_direction_type scan_direction = SCAN_UNKNOWN_DIRECTION;
    enum scan_direction_type prev_scan_direction = scan_direction;
    enum scan_direction_type display_scan_direction, sw_dir;
    short int tilt_value = 0;
    float tilt_angle[2];
    static float upper_tilt =  0;
    static float lower_tilt = 0;
   int rcvr_delay = 0;
   int prev_rcvr_delay;
    int range[3];

    unsigned char wx_range;
/*storage for range before sending to wx1 , wx2,
                             tran_rot*/
    unsigned short int PWidth[MAX_PRF_SETS];
    unsigned char SweepDir = 0;
    char SweepSpd = 0;
    char TotalBar = 0;
    unsigned char EOS = 0;
    unsigned char Polar = 0;
    int EOS_flag = 0;
    char CurBar = 0;
    short int num_pulses[MAX_PRF_SETS];
    short int num_prfs = 2;
    short int prev_num_pulses[MAX_PRF_SETS];
    short int prev_num_prfs = 0;
// short int current_prf[MAX_PRF_SETS];
    int bin[MAX_PRF_SETS];
// unsigned char ant_switch_st = 0;

    unsigned long freq_code[MAX_PRF_SETS][MAX_PULSES][3];
    unsigned long phase[MAX_PRF_SETS][MAX_PULSES][3];
    short int I[MAX_PRF_SETS][MAX_PRF_SET_SIZE];  // max_pulses*max_range_bin
    short int Q[MAX_PRF_SETS][MAX_PRF_SET_SIZE];  // max_pulses*max_range_bin
    unsigned long int STC[MAX_PRF_SETS][MAX_RANGE_BIN];

    float std_input[MAX_PRF_SETS][MAX_RANGE_BIN];
    float power[MAX_PRF_SETS][MAX_RANGE_BIN];
    float r1mag[MAX_PRF_SETS][MAX_PRF_SET_SIZE];  // max_pulses*max_range_bin
    float r2mag[MAX_PRF_SETS][MAX_PRF_SET_SIZE];  // max_pulses*max_range_bin
    unsigned long int db[MAX_PRF_SETS][MAX_RANGE_BIN];
    unsigned int sdev[MAX_PRF_SETS][MAX_RANGE_BIN];
    unsigned int turb_threshold[MAX_PRF_SETS][MAX_RANGE_BIN],
        severe_turb_threshold[MAX_PRF_SETS][MAX_RANGE_BIN];
    double delta_hdg = 0.0f, avg_gs_knots = 0.0f;

/* Variable Initialization*/
    float temp_flt = 0.0;
    float noise_floor = 419;
    int init_mode[2];
    int noise_adjust = 0;                         //make something from header feed this
    long int bytes_read = 0;
    static unsigned char PrevBar = 0;             /*must remember*/
    short int len_chk;
    float prev_tilt_angle;
    float prev_range;
    short int first_pass = 0;
    unsigned long int big_db[MAX_PRF_SETS][MAX_BINS];
    int new_scan = TRUE;
    int file_utc;
    static int OldEndOfSweep = 0;
    unsigned char master_mode[4];
    unsigned char temp_char1;
    unsigned char temp_char2;
    short int temp_short1;
    short int temp_short2;
    int rb_total;
    int rb_lr_total;
    int rb_sr_total;

    unsigned int plane_num;
/*tran_rot(), select memory plane  to store the
                             processed IQ data*/
    static float cumulative_delta_hdg = 0.0f;
    char filename453[16];
    static ROT_TRAN_TYPE rot_tran;
    double test_pin[1];                           //test only
    static DATA_FOR_ERIB_TYPE dfe;                //data for ERIB
    static double filtered_scan_angle[3] = {0.0,0.0,0.0};
/*1 and 2 for long and
                                            short filter, 3 temp for 453 count*/
    long int comp_alt_offset;
    long int man_alt_offset;

/*init from header*/
    short int manual_gain = gui_var->manual_gain;
    unsigned long int rotate_translate = 1;       //debug switch
//int rev_R_L_sweep = 0;//(int)header[33]; //debug switch
    double s_s_beta = gui_var->s_s_beta;
    int compass_rose_on =  gui_var->compass_rose_on;
    double res_constant =  gui_var->res_constant; //test only
    int tilt_resolution =  gui_var->tilt_resolution;
/*0 = 1/4 deg res and greater the 0 is
                            //           1/64th deg res*/
                                                  /* 1 = GCS  0 = no GCS*/
    unsigned char gcs = (unsigned char)  gui_var->gcs;
    unsigned char mode = (unsigned char) gui_var->mode;
    double new_range =  gui_var->new_range;
    double scan_angle_adjustment =  gui_var->scan_angle_adj;
    int apply_harsh_edit = gui_var->apply_harsh_edit;

//float altitude_offset = header[53];  //test only
                                                  //test only
    double coeff_const_offset =  gui_var->coeff_const_offset;
                                                  //test only
    int short_range_bins_256 = gui_var->short_range_bins_256;
    int angle_status = 1;                         // status = ok
    float sigma_turb;

    int r_l_cnt = -3;
    int tmp_cnt;
    long int r_l_epoch_ptr[1024], l_r_start;
    float upper_db[512];
    float tmp_db[512], tmp_y[512];
    unsigned long int tmp_flags[512];
    unsigned short flags[512];
    static int scan_cnt = 0;
    FILE *fpt = NULL;
    char filename[32];
    struct stat statbuf;
    double test[2][512];
    int bin_start[3], set;
    static DSP1_TERR_MAX_TYPE terr_max;
    float scan_adder;
    char time_string[32];
    static struct SERVO servo_data;
    unsigned int estimates_available;
    float roll_angle;
    float heading_angle;
    unsigned int antenna_sat_flag;
    static int num_scans = 0;
    float temp_power[512];
    char test_name[64];
    char vdbz_filepath[256];                      // high-res dbz output filename for vertical scans
    char date_string[20];
    char file_time_string[20];
    char data_time_string[20];
    FILE * vdbz_fptr;

    int leave = 0;
// Test variables
    float g_load_save[512];

    TURB_PARAMETER_TYPE turb_para;
    DATE_TIME_TYPE date_time;
    static VERT_SWP_TYPE vert_swp;
    static CLUTTER_CALC_TYPE clutter_calc_data;
    float ft_to_current_bin;
    float temp_alt;
    const float Re_ft = EARTH_RADIUS_NM * 6076.1155;
    unsigned int temp_nibble;
    double rng_nm_to_bin[3] = { L_RNG_NM_TO_BIN,S_RNG_NM_TO_BIN, NM_TO_DISPLAY_BIN };
    float nm_to_rng_bin[2] = {NM_TO_L_RNG_BIN, NM_TO_S_RNG_BIN};
    unsigned long int temp_int[512];
    long int D_Pos[2] = {0, 33554431};
    float cturb_factor;
    float real_scan_angle;
    Scan scan;

    short int lr_bw = 6;
    short int sr_bw = 5;
    unsigned char test_buf[4];
    unsigned int num_extra_words;
    unsigned int num_extra_429;
    unsigned int *temp_utc;
    char antenna_mode[8];
    char hdr_found;
    UTC_Type pc_UTC;
    int air_gnd_disc;
    static int windshear_sweep = 0;
    int windshear_on = 0;
    int auto_mode = 0;
    int radial_ctr = 0;

    DSP2_TO_DSPM_TYPE data_to_dspm;

    Date_Type CMS_Date;
    UTC_BCD_Type CMS_Time;
    CELL_TYPE *which_cell;
    SDEV_CORR_OUTPUT_PARMS_TYPE sdev_corr_parms;

#if 0                                         // extra words reference **************
// Extra words
    V1_Extra_Words_Type* extra_wds_ptr;

// exd_vcl_wds is declared in the header file for access all over the place
// This section was removed due to using a different method.  However, the final method has not yet been determined. - NAM
    EXD_VCL_WDS_TYPE * exd_vcl_wds;
    EXD_429_WDS_TYPE * exd_429_wds;
    EXD_DIS_WDS_TYPE * exd_dis_wds;
    EXD_AGC_WDS_TYPE * exd_agc_wds;
    int num_ext_word;
    int i_seed;
    unsigned int ext_429_wds[32];
    int ext_dis_wds[8];
    int wpe_disc;
    V1_Cell_Track_Type ext_vcl_wds[32];
    V1_AGC_Type ext_agc_wds;
    float rec_flight_phase;
    int A429_label;
#endif                                        // extra words reference ************

/////////////////////////////////// CELL TYPE ///////////////////////////////////////////////
//  should be passed to us back from DSP3 --- so pass and fill in when dsp3_main called

    CELL_INFO_TYPE cell_info;
    cell_info.cell_id = CELL_UNSET;

////////////////////////////////  AUX_SWEEP STRUCTS and ARRAYS ////////////////////////////////////
// making  all aux arrays,structs global for now
//
// vertical scan display variables
// static int aux_vert_scan = FALSE;

// auxiliary horizontal variables
//static int aux_horiz_scan = FALSE;

// use a struct for these
//   int lb, ub, last_lb, last_ub, match_to_ub, col; // LR,SR scan-angle filter
// int centroid_LR_bin, lrb, urb; // LR radial bin index marks
// float hscan;
// float * hsptr;
// variables common to auxiliary vertical and horizontal processes
//int size;
//int fret;
//unsigned int cell_id;
//float aux_tilt_angle; // LR and SR scans
//float aux_scan_angle[2]; // LR and SR scans

/****************************************************************************
 ******                      Start Of Functionality                     ******
 ****************************************************************************/

    if (arch_db_file == NULL)
    {
        arch_db_file = fopen ("arch_db.txt","w");
    }

    if (servo_db_file == NULL)
    {
        servo_db_file = fopen ("servo_db.txt","w");
    }


    byte_cntr = ftell(IQ_file.fptr);

    vert_swp.first_vert_rad = 1;                  // init for start
    vert_swp.prev_rad_vert = 0;

///////////////////////////////////////////////////////////////////////////////////////////////////

    if (iqproc_init)
    {
        initFlightPathThreat(&data_to_dspm.flight_pta);
        initAuxScan(&Aux_scan);
        iqproc_init = 0;
    }

    Aux_scan.n_epochs = 0;                        // reset
    Aux_scan.n_scans++;                           // incr

    vert_swp.first_vert_rad = 1;
    vert_swp.prev_rad_vert = 0;
    dfe.clutter_range = 0;
    dfe.horiz_range = 320;

    wxrv.centroid_debug = gui_var->centroids;
    wxrv.plug = /*(int)header[46]*/ gui_var->plug;/*used in dbz_to_453 to enable singleton*/

/*init range array*/
    range[0] = 0;                                 /*MultiScan Long Range 320, currently not used*/
    range[1] = 0;                                 /*MultiScan Short Range 40, currently not used*/
    range[2] = 0;

/* inits to avoid invalid math ops due to vertical sweep data occurring at
beginning of dat file */
    range[0] = 320;
    range[1] = 40;
    clutter_calc_data.real_range[0] = 331.5176;
    clutter_calc_data.real_range[1] = 41.4397;

/*init init_mode array*/
    init_mode[0] = 255;
    init_mode[1] = 255;

//memset( prev_stc, 0xff, MAX_RANGE_BIN * MAX_PRF_SETS * 4);

    for( k = 0; k < MAX_PRF_SETS; ++k )
    {
        for( j = 0; j < MAX_PULSES; ++j)
        {
            for( i = 0; i < 3; ++i )
                freq_code[k][j][i] = 0;
        }
    }

    if (new_scan)
        memset( plane_out + 12*MAX_BINS_X_2*MAX_BINS_X_2, 0, MAX_BINS_X_2 * MAX_BINS_X_2 * 4 );

/****************************************************************************
 ******                    Start Of Main Process Loop                   ******
 ****************************************************************************/

/* Start reading the file one epoch at a time*/
    while ( (data_file_size - byte_cntr > 9728)     &&
        (scan_direction == prev_scan_direction) &&
        (r_l_cnt != -2)                         &&
        (leave == 0 ) )                           /*data_file_size 1536 */
    {
        radial_ctr++;                             // scan counter; reset after a horizontal sweep
        len_chk = 0;
        while( len_chk == 0 )
        {
            hdr_found = FALSE;
            while (!hdr_found)
            {
                findAC( IQ_file.fptr );
/* Read AC Data from the file */
//fread (buffer4, 4, 128, IQ_file.fptr);
                                                  //read AC and IQ headers
                fread (&ac_iq_header, 1, 139*4, IQ_file.fptr);
                memcpy( buffer4, &ac_iq_header, 139*4);
/* Capture AC IQ Data Block Length */
//length = (unsigned long)((ceil((float)buffer4[4]/512))*512);
                length = (unsigned long)((ceil((float)ac_iq_header.Number_Of_Bytes/512))*512);
                if ((length == 9760) || (length == 10240) || (length == 1024)  || (length == 18944 ) )
                {
                    hdr_found = TRUE;
                    if (length == 18944 )
                    {                             //ws sweep
//if( windshear_sweep == 0)
//   new_scan = 1;
                        windshear_sweep = 1;
                    }
                    else
                        windshear_sweep = 0;
                }
                else                              // Bad length
                {
//MessageBox (0, "Bad Length detected, skipping 1 radial", 0, 0);
                    fseek (IQ_file.fptr, 9760-128, SEEK_CUR);
                }
            }                                     // end WHILE !hdr_found
            len_chk = lengthchk( IQ_file.fptr, length, &byte_cntr, &bytes_read, &az_cnt );
        }                                         // end WHILE len_chk = 0
        byte_cntr += length;

        memset (ACdate, 0, sizeof(ACdate));
        memcpy(&ACdate[0],&ac_iq_header.AC_Date[3],1);
        memcpy(&ACdate[1],&ac_iq_header.AC_Date[2],1);
        memcpy(&ACdate[2],&ac_iq_header.AC_Date[1],1);
        memcpy(&ACdate[3],&ac_iq_header.AC_Date[0],1);
        memcpy(&ACdate[4],&ac_iq_header.AC_Date[7],1);
        memcpy(&ACdate[5],&ac_iq_header.AC_Date[6],1);
        memcpy(&ACdate[6],&ac_iq_header.AC_Date[5],1);
        memcpy(&ACdate[7],&ac_iq_header.AC_Date[4],1);

/* Determine Time */
//time =  buffer4[2];
        time = ac_iq_header.AC_Millisecond_Time_Stamp;
        temp_time = time;
        hrs = (unsigned char)floor(temp_time/3600000l);
        temp_time = temp_time - hrs*3600000l;
        minutes = (unsigned char)floor(temp_time/60000l);
        temp_time = temp_time - minutes*60000l;
        sec = (unsigned char)floor(temp_time/1000);

        millisec_ctr_hrs = hrs;
        millisec_ctr_minutes = minutes;
        millisec_ctr_sec = sec;
        sprintf(millisec_ctr_time_string,"%.2d:%.2d:%.2d",
            millisec_ctr_hrs, millisec_ctr_minutes, millisec_ctr_sec);
        millisec_ctr_time_string[8] = 0;

        if ((time - last_time) >= 1000)
        {
// get secs
            isecs = time/1000;
            last_time = time;
            data_to_dspm.flight_pta.secs = isecs;
        }
/* Label */
//bytextract (buffer4[3], &label[0], &label[1], &label[2], &label[3]);
        label[4] = 0;
        label[3] = (char)(ac_iq_header.Header_Label & 0xff);
        label[2] = (char)((ac_iq_header.Header_Label>>8) & 0xff);
        label[1] = (char)((ac_iq_header.Header_Label>>16) & 0xff);
        label[0] = (char)((ac_iq_header.Header_Label>>24) & 0xff);

/*Master Mode*/
//bytextract (buffer4[5], &dummy, &master_mode[2], &master_mode[1], &master_mode[0] ); /*new 2100 Data Format*/

//if( (master_mode[1] | (master_mode[2] << 8) )== 2100 )   /* 2 is for 2100 radar */
        if( ac_iq_header.Master_Mode_Int == 2100 )/* 2 is for 2100 radar */
            data_format = WRT2100;
        else
            data_format = WRT700;

/* decode ARINC data */
        drift_angle = 0.005493164*(float)ac_iq_header.Drift_Angle.Drift_Angle;
        if (drift_angle < 0.0)
            drift_angle += 360;

        track = 0.005493164*(float)ac_iq_header.IRS_True_Track_Angle.IRS_True_Track_Angle ;
        if( track < 0 )
            track +=360;

        t_head = 0.005493164*(float)ac_iq_header.IRS_True_Heading_Angle.IRS_True_Heading_Angle;
        if( t_head < 0 )
            t_head +=360;

        scan.hdg = t_head;
        ac_info.ac_hdg = t_head;
        gspd = (1852.0/(8.0*3600.0))*(float)ac_iq_header.IRS_Ground_Speed.IRS_Ground_Speed;

        gs_knots = 0.125*(float)ac_iq_header.IRS_Ground_Speed.IRS_Ground_Speed;

        bar_alt = (float) ac_iq_header.ADC_Baro_Altitude_1013mb.ADC_Baro_Altitude_1013mb;

        ac_info.ac_baro_alt = bar_alt;
        ac_info.ac_rave_alt = raveAlt(bar_alt);

        ac_info.ac_gps_alt = (int) (0.125 * (float) ac_iq_header.GPS_Altitude_MSL.GPS_Altitude_MSL_1 + 0.5);

        ac_info.ac_fphase = (int) ac_iq_header.Flight_Phase;

        if(GuiProcData.BaroAltOverride)
            bar_alt = (float) (int) (0.125 * (float) ac_iq_header.GPS_Altitude_MSL.GPS_Altitude_MSL_1 + 0.5);

        dfe.ms_baro_altitude = bar_alt;

        rad_alt = 0.125*(float)ac_iq_header.ALT_Radio_Altitude.ALT_Radio_Altitude;
//rad alt SSM bits are currently set good all the time
//Chuck will fix some day.  for now use below

        rad_alt_valid = 0;                        //force to zero
        if( (rad_alt < 2500) && (rad_alt > 0) )
            rad_alt_valid = 1;

//bar_alt += altitude_offset;
//man_alt_offset = (long int)(buffer4[29]<<16)>>16;  /*manual altitude offsets*/
        man_alt_offset = ac_iq_header.Manual_Altitude_Offset;
        if( (man_alt_offset > 32000) || (man_alt_offset < -32000) )
/*not used by this data set*/
            man_alt_offset = 0;

//comp_alt_offset = (long int)(buffer4[30]<<16)>>16; /*rt computed altitude offsets*/
        comp_alt_offset = ac_iq_header.Computed_Altitude_Offset;

//if( comp_alt_offset == 0x202020 )
/*not used by this data set*/
//   comp_alt_offset = 0;

        pitch = 0.010986328*(float)ac_iq_header.IRS_Pitch_Angle.IRS_Pitch_Angle;

        roll = 0.010986328*(float)ac_iq_header.IRS_Roll_Angle.IRS_Roll_Angle;

        lat = 0.000171661*ac_iq_header.IRS_Latitude.IRS_Latitude;
        ac_info.ac_loc.lat = lat;
        lat += GuiProcData.lat_offset;            //add offset from gui

        lon = 0.000171661*ac_iq_header.IRS_Longitude.IRS_Longitude;
        ac_info.ac_loc.lon = lon;
        lon += GuiProcData.lon_offset;            //add offset from gui


        


        if ( ac_iq_header.Version == V2_MS)
        {
            air_gnd_disc = ac_iq_header.AirGnd;
        }
        else
        {
// some where in extra words we might know but default to AIR until we find out
            air_gnd_disc = AIR;
        }

        hms_UTC = ac_iq_header.GPS_UTC_Course.BNR_Hours<<16 |
            ac_iq_header.GPS_UTC_Course.BNR_Minutes<<8 |
            ac_iq_header.GPS_UTC_Course.BNR_Seconds;

        if( GuiProcData.TimeSrc == USE_PC_MILLISECOND )
        {
            hms_UTC = (hrs&0x1F)<< 16 |
                (minutes&0x3F)<< 8 |
                sec&0x3F;

            pc_UTC.BNR_Seconds = sec&0x3F;
            pc_UTC.BNR_Minutes = minutes&0x3F;
            pc_UTC.BNR_Hours = hrs&0x1F;
        }

        sprintf( time_string,"%02d:%02d:%02d", (hms_UTC >> 16) & 0xFF, (hms_UTC >> 8) & 0xFF, hms_UTC & 0xFF );

//   MAT copy UTC time - to our flight_path_threat
//   sprintf(data_to_dspm.flight_pta.time_string,"%02d:%02d:%02d", (hms_UTC >> 16) & 0xFF, (hms_UTC >> 8) & 0xFF, hms_UTC & 0xFF );

        airspeed = 0.0625*(float)ac_iq_header.True_Airspeed.True_Airspeed;
        ac_info.ac_speed = airspeed;

        dfe.static_air_temperature = 0.25*(float)ac_iq_header.Static_Air_Temp.Static_Air_Temp;
        ac_info.sat = (float)ac_iq_header.Static_Air_Temp.Static_Air_Temp;

        servo_data.rec_pitch_offset = 0.01098901*(float)ac_iq_header.Commanded_Pitch_Offset;
        servo_data.rec_roll_offset = 0.01098901*(float)ac_iq_header.Commanded_Roll_Offset;
        servo_data.rec_elev_offset = 0.015625*(float)ac_iq_header.Commanded_Elevation_Offset;
        servo_data.rec_pitch_error = 0.01098901*(float)ac_iq_header.Computed_Pitch_Error;
        servo_data.rec_roll_error = 0.01098901*(float)ac_iq_header.Computed_Roll_Error;
        servo_data.rec_elev_error = 0.015625*(float)ac_iq_header.Computed_Elevation_Error;
        servo_data.rec_pitch = pitch;
        servo_data.rec_roll = roll;
        servo_data.rec_hdg = t_head;

// set air-ground discrete value; older versioned iq streams may not have this field
        if (0 == ac_iq_header.Version)            // legacy
            air_gnd_disc = AIR;
        else
            air_gnd_disc = ac_iq_header.AirGnd;

#if 0                                     // extra words reference section ************************************** >>

// Try to read in the extra words...

// Set a point to the extra words.

        extra_wds_ptr = (V1_Extra_Words_Type *)&ac_iq_header.Ext_Wd_Label;

//sort out the extra words into specific arrays
//********will need to revisit when the counts get added*****
        i = 0;

        exd_429_wds = NULL;
                                                  //"429"
        if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x343239 )
        {
            num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
            exd_429_wds = (EXD_429_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
            i += num_ext_word + 1;
        }

        exd_dis_wds = NULL;
                                                  //"DIS"
        if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x444953 )
        {
            num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
            exd_dis_wds = (EXD_DIS_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
            i += num_ext_word + 1;
        }

        exd_vcl_wds = NULL;
                                                  //"VCL"
        if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x56434C )
        {
            num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
            exd_vcl_wds = (EXD_VCL_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
            i += num_ext_word + 1;
        }

        exd_agc_wds = NULL;
                                                  //"AGC"
        if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x414743 )
        {
            num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
            exd_agc_wds = (EXD_AGC_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
            i += num_ext_word + 1;
        }
// Do a check here.
// i should equal extra_wds_ptr->EXD.Num_Ext_Wds - if not we gots a problem...

        wpe_disc = 0;
        num_extra_429 = 0;
        rec_flight_phase = 0;
        i = 0;
        i_seed = i+1;
                                                  //"429"
        if( ac_iq_header.Ext_Wds[i]>>8 == 0x343239 )
        {
            memcpy( ext_429_wds, &ac_iq_header.Ext_Wds[i], ac_iq_header.Ext_Wds[i]&0xff );
            num_extra_429 = max(ac_iq_header.Ext_Wds[i]&0xff, 4);
        }
        i += num_extra_429;
        i_seed = i+1;
                                                  //"DIS"
        if( ac_iq_header.Ext_Wds[i]>>8 == 0x444953 )
//memcpy( ext_dis_wds, &ac_iq_header.Ext_Wds[i], ac_iq_header.Ext_Wds[i]&0xff );
//read and decode the discrete words
            for( i = i_seed; i < (int)(ac_iq_header.Ext_Wds[i]&0xff + i_seed); ++i )
        {
                                                  //"A/G"
            if( ac_iq_header.Ext_Wds[i]>>8 == 0x412F47 )
                air_gnd_disc = ac_iq_header.Ext_Wds[i]&0xff;
                                                  //"WPE"
            if( ac_iq_header.Ext_Wds[i]>>8 == 0x575045 )
                wpe_disc = ac_iq_header.Ext_Wds[i]&0xff;
        }
        i += max(ac_iq_header.Ext_Wds[i]&0xff, 4);

        if( ac_iq_header.Version == 1 )
        {                                         //this data only in version 1 format
                                                  //"VCL"
            if( ac_iq_header.Ext_Wds[i]>>8 == 0x56434C )
                memcpy( ext_vcl_wds, &ac_iq_header.Ext_Wds[i], ac_iq_header.Ext_Wds[i]&0xff );
            i += max(ac_iq_header.Ext_Wds[i]&0xff,4);

                                                  //"AGC"
            if( ac_iq_header.Ext_Wds[i]>>8 == 0x414743 )
                memcpy( &ext_agc_wds, &ac_iq_header.Ext_Wds[i], ac_iq_header.Ext_Wds[i]&0xff );
            i += max(ac_iq_header.Ext_Wds[i]&0xff,4);

                                                  //"F_P"
            if( ac_iq_header.Ext_Wds[i]>>8 == 0x485F50 )
                rec_flight_phase =(((int)ac_iq_header.Ext_Wds[i]&0xff)<<24>>24) * 1/127;
        }
#endif                                    // extra words reference section << *************************************

// Test for accurate date time not equal to zero...

        extract_date_time(hms_UTC, (unsigned char *) ACdate, &dfe.date_time);
        dfe.date_time.milliseconds = time;

/*end decode ARINC data*/

//****************continue from here***************

        if( ac_iq_header.Static_Air_Temp.SSM == 0x3 )
        {                                         /*normal operation*/
            dfe.sat_valid_flag = 1;
        }
        else
        {
            dfe.sat_valid_flag = 0;
        }

        if( (wxrv.fp453 == NULL) && File_Writes._453)
        {                                         /*create filename453 from current UTC time*/
            filename453[0] = 0;
            hrs = (hms_UTC >> 16) & 0xFF;
            minutes = (hms_UTC >> 8) & 0xFF;
            sec = hms_UTC & 0xFF;

            sprintf( filename453, "%02d%02d%02d_p1.wxr", hrs, minutes, sec);
            wxrv.fp453 = fopen(filename453, "wb");
            strcpy ( p1_453_file, filename453 );  // copy this filename

            sprintf( filename453, "%02d%02d%02d_p3.wxr", hrs, minutes, sec);
            wxrv.fp453_p3 = fopen(filename453, "wb");
            strcpy ( p3_453_file, filename453 );  // copy this filename
        }

//test code
        memcpy( buffer4, &ac_iq_header.Stabilized_Scan, 44 );

/* IQ Label */
        bytextract(buffer4[3], &IQlabel[0], &IQlabel[1], &IQlabel[2], &IQlabel[3]);
        IQlabel[4] = 0;
        IQlabel[3] = (char)(ac_iq_header.IQ_Label & 0xff);
        IQlabel[2] = (char)((ac_iq_header.IQ_Label >>8) & 0xff);
        IQlabel[1] = (char)((ac_iq_header.IQ_Label >>16) & 0xff);
        IQlabel[0] = (char)((ac_iq_header.IQ_Label >>24) & 0xff);

/* Scan and Tilt Angles */
        tilt_value = ac_iq_header.Tilt_Angle;
        scan_value = ac_iq_header.Scan_Angle;

        if( tilt_resolution > 0 )
                                                  //* 1/64
            tilt_angle[0] = (float)ac_iq_header.Tilt_Angle * 0.015625;
        else
            tilt_angle[0] = (float)tilt_value*0.25;  //* 1/4
        tilt_angle[1] = tilt_angle[0];
// set tilt_angle --> aux_scan

                                                  //*1.0f/64.0f;
        scan_angle[0] = (float)scan_value * 0.015625;
// Save the scan_angle here for making sure it is the one being compared for swp_dir_changes
        real_scan_angle = scan_angle[0];
// Set the short range scan angle before affecting the short range scan angles - matches the box
        scan_angle[1] = scan_angle[0];

/* Gate Delay and Range, Pulse Width, Number of PRF and Pulses */
        if( data_format != WRT2100 )
        {
            bytextract (buffer4[6], &dummy, &dummy, (unsigned char *)&range[2], (unsigned char *)&rcvr_delay);
            shortxtract (buffer4[6], &temp_short1, &dummy1);
            PWidth[0] = temp_short1;
            shortxtract (buffer4[10], &num_pulses[0], &num_prfs);
        }
        else if( (data_format == WRT2100) && (ac_iq_header.Version == 0) )
        {                                         /*new 2100 Data Format*/

// This is to be able to process variable bandwidth data...
// Currently this is only in v0 data and only 1 or 2 flights

            lr_bw = (buffer4[10] >> 16) & 0xFF;
            if(lr_bw == 0) lr_bw = 6;             // Oldest data left this blank, fill it in correctly
            sr_bw = (buffer4[10] >> 24) & 0xFF;
            if(sr_bw == 0) sr_bw = 5;             // Oldest data left this blank, fill it in correctly

            bytextract (buffer4[6], &dummy, &dummy, &dummy, (unsigned char *)&range[2]);
            shortxtract (buffer4[10], &dummy1, &num_prfs );
        }
        else if( (data_format == WRT2100) && (ac_iq_header.Version == 1) )
        {                                         /*MultiScan V2.0 Data*/
            rcvr_delay = ac_iq_header.Receiver_Delay;
            num_prfs = ac_iq_header.Number_of_prfs;
        }

//antenna mode
        strncpy(antenna_mode, ac_iq_header.Antenna_Mode, sizeof(antenna_mode));
// currently all mode description strings have the same length

/* Sweep Information */
        SweepSpd = ac_iq_header.Sweep_Speed;
        SweepDir = ac_iq_header.Sweep_Direction;

      /* Bar Information */
      if( ac_iq_header.Version != 1 ) // non-MultiScan legacy
         bytextract (buffer4[9], &Polar, &EOS, &CurBar, &TotalBar);
      else // MultiScan
      {
         EOS = ac_iq_header.End_of_Sweep;
         CurBar = ac_iq_header.Current_Bar;
         TotalBar = ac_iq_header.Total_Bars;
      }

      // adjust scan_angle[] and filtered_scan_angle[] for horizontal scans;
      // adjust tilt_angle[] for vertical scans

      if (CurBar > 3 && CurBar < 127) // vertical scans (v2.0 only; 04-20-2010)
      {
         // U_D shift adder for short range tilt angle
         if( SweepDir == 0x00 ) // down-to-up
            tilt_angle[1] += (K_SR_TILT_ANGLE_ADJ * (float)abs(SweepSpd));
         else if( SweepDir == 0xFF ) // up-to-down
            tilt_angle[1] -= (K_SR_TILT_ANGLE_ADJ * (float)abs(SweepSpd));

         // no gui adjustment to filtered_scan_angle[]
         filtered_scan_angle[0] = (double)scan_angle[0];
         filtered_scan_angle[1] = (double)scan_angle[1];
      }
      else // everything else
      {
         if( ac_iq_header.Version == 1 ) // MultiScan
         {
            // L_R shift for short range scan angle
            /* note that abs(SweepSpd) is used only for consistency with tilt adjustment;
               value for horiz scans has always been positive (as of 04-21-2010) */
            if( SweepDir == 0x00 ) //L_R
               scan_angle[1] += (K_SR_SCAN_ANGLE_ADJ * (float)abs(SweepSpd));
            else if( SweepDir == 0xFF ) //R_L
               scan_angle[1] -= (K_SR_SCAN_ANGLE_ADJ * (float)abs(SweepSpd));
         }
         else if( ac_iq_header.Version == 0 ) // Version 0 data
         {
            // This is the LONG range correction we used for SB4 Data (Version 0 data)
            if(SweepDir == 0x00) // L_R
               scan_angle[0] += 0.25;
            else if(SweepDir == 0xFF) // R_L
               scan_angle[0] -= 0.25;
         }
   
         // Test code to allow LONG range adjustments from the GUI
         if(SweepDir == 0x00) // L_R
            scan_angle[0] += GuiProcData.IQProcShift;
         else if(SweepDir == 0xFF) // R_L
            scan_angle[0] -= GuiProcData.IQProcShift;
   
         // gui adjustment for filtered_scan_angle[]
         // This is set on the Gui in the Light Blue box on the right
         scan_adder = scan_angle_adjustment;
         if( SweepDir == 0x00 ) //L_R
         {
            filtered_scan_angle[0] = scan_adder;   // For long range
            filtered_scan_angle[1] = scan_adder;   // For short range
         }
         else if( SweepDir == 0xFF ) //R_L
         {
            filtered_scan_angle[0] = -scan_adder;  // For long range
            filtered_scan_angle[1] = -scan_adder;  // For short range
         }
      }

      scan.speed = (float)SweepSpd;
      scan.dir = SweepDir;
      scan.raw_angle = scan_angle[0];
      /*1/32 scan angle error injection*/

        EOS_flag = EOS;
        bytes_read = 44;

//*************************************

/*load up values to be stored in array, then passed out*/
        if(first_pass < 10 )
        {                                         /*set prev_tilt_angle on the first few epochs of this sweep*/
            prev_tilt_angle = tilt_angle[0]; // use LR value
            prev_range = (float)range[2] * 5;
            prev_num_pulses[0] = num_pulses[0];
            prev_num_prfs = num_prfs;
            prev_num_pulses[1] = num_pulses[1];
            prev_rcvr_delay = rcvr_delay;
            bar = CurBar;
            display_scan_direction = scan_direction;
            first_pass++;

            if( CurBar == 2 )
            {
                upper_tilt = tilt_angle[0]; // use LR value
                dfe.upper_tilt = tilt_angle[0];
            }
            else if( CurBar == 1 )
            {
                lower_tilt = tilt_angle[0]; // use LR value
                dfe.lower_tilt = tilt_angle[0];
            }
        }                                         // end IF first_pass < 10

//set windshear_on to bit 1 of windshear enable
        windshear_on = ac_iq_header.WSEnable;

//set windshear_sweep if current sweep is the windshear sweep
        windshear_sweep = 0;
        if( (ac_iq_header.IQ_Label == 0x57532020) || ((ac_iq_header.WSEnable&0x0E)>0) )
            windshear_sweep = 1;

        if (!windshear_sweep || !EOS)
        {
	  readPRF ( num_prfs, data_format, num_pulses, bin, PWidth, freq_code, phase,  I, Q, STC, buffer4, &bytes_read, lr_bw, sr_bw) ;
        }
        else if( windshear_sweep )
        {
            fseek(IQ_file.fptr, ac_iq_header.Number_Of_Bytes - 556, SEEK_CUR);
        }

/* Move pointer to end of block */
        ++az_cnt;

        plane_num = CurBar;

        dfe.range = new_range;
        if( TotalBar > 1 )
        {
            dfe.ms_mode = CurBar;
            dfe.tilt =  multiscan_display_tilt( rad_alt,
                bar_alt,
                upper_tilt,
                lower_tilt,
                new_range*5,
                mode ) ;
        }
        else
        {
            dfe.ms_mode = 0;
            dfe.tilt = lower_tilt;
        }

//init parameters for DSP1 and Terrain_Max

        terr_max.lat_rad = lat * 17.45329e-3;     //convert to radians
        terr_max.lon_rad = lon * 17.45329e-3;
        terr_max.hdg_rad = t_head * 17.45329e-3;

        terr_max.scan_angle_rad[0] = scan_angle[0] * 17.45329e-3;
        terr_max.scan_angle_rad[1] = (scan_angle[0]+(0.375*4)) * 17.45329e-3;
        terr_max.scan_angle_rad[2] = (scan_angle[0]-(0.375*4)) * 17.45329e-3;
//terr_max.scan_angle_rad[3] = (scan_angle[0]+(0.375*4)) * 17.45329e-3;
//terr_max.scan_angle_rad[4] = (scan_angle[0]-(0.375*4)) * 17.45329e-3;

        terr_max.baro_alt = bar_alt;
        terr_max.horiz_rng = dfe.horiz_range;




// set new_scan flag
        if((new_scan == TRUE) && (ac_iq_header.End_of_Sweep == 255 ))
            new_scan = TRUE;
        else
        {
            if ((ac_iq_header.End_of_Sweep == 0 ) && ( OldEndOfSweep == 255 ))
                new_scan = TRUE;
            else
                new_scan = FALSE;
        }
        OldEndOfSweep = ac_iq_header.End_of_Sweep;

// Test code
        if (new_scan)
            num_scans++;

        updateAuxScan(&Aux_scan, num_pulses, CurBar, first_dspm_call, scan_angle, tilt_angle);

        estimates_available = 1;                  //MAT, Nathan -check where these go
        roll_angle = roll;
        heading_angle = t_head;
        antenna_sat_flag = 0;                     //add code to set antenna_sat_flag correctly
        servo_data.maneuver_flag = (unsigned int) get_maneuver_flag( estimates_available,
            roll_angle,
            heading_angle,
            antenna_sat_flag);

///  UnWrap the prf_index loop  so we call wx1_LR, wx1_SR , wx2_LR, wx2_SR

///////////////////////////////////////////////////////////////////////////////////////////////////
///////// ----  DSP1 ---->  DSP2 ----> DSPM/M2   ------> DSP3   ///////////////////////////////////
/// TBD currently we are doing  wx1_LR, wx2_LR  then wx1_SR, wx2_SR --- and we want
//  wx1_LR,SR   then wx2_LR,SR ---

        rb_lr_total = 512;                        /*long range or old (< 04/09/01) data set*/

        rb_sr_total = 256;                        /*short range data set*/

        dfe.iq_proc_scan_num = num_scans;

        if (!EOS && !first_dspm_call && num_prfs > 0)
        {
////////////////////////////////////// DSP1  ///////////////////////////////////////////////////////////

            dsp1_main (range,
                noise_floor,
                init_mode,
                I,  Q,
                power,
                r1mag, r2mag,
                bin,
                num_prfs,
                scan_cnt,
                (float)SweepSpd,
                STC,
                &terr_max,
                bar_alt,
                scan_direction,
                new_scan,
                CurBar,
                air_gnd_disc,
                &data_to_dspm.flight_pta,
                &ac_iq_header,
                &ac_info,
                &cell_info,
                &Aux_scan);

//////////////////////////////  DSP2   //////////////////////////////////////////////////////////////////////

//////////////////// TURB call goes to DSP2  ///////////////////////////////
            cturb_factor = (0.045 - 9.37e-17 * (bar_alt * bar_alt * bar_alt)) *
                (KTS_TO_MS * max(airspeed, 100.0))/(min(3.57e-3 * bar_alt + 119.15, 231));

                                                  //VAS
            sigma_turb =  1.00 * cturb_factor * TURB_BB_CONST * airspeed * sin(scan_angle[SR] * RAD_PER_DEG);

/* This factor converts m/s to g's  */
/* Limit airspeed used to >= 100kts */

//dsp2_main call
// hardwire cell_info for vert_fe test

// not currently being set
            cell_info.cell_id = 1;

#if 0

// stick cell lat,lon 30 nm off the nose
// MAT --- REMOVE next @ next cell_track update
            cell_info. centroid_loc.lat = ac_info.ac_loc.lat;
            cell_info. centroid_loc.lon = ac_info.ac_loc.lon;
#endif

/* fill sdev_corr parameter structure fields (only those not being passed
   in already to wx2) for WAT output of wx2 processing */
            memset (&sdev_corr_parms, 0, sizeof(sdev_corr_parms));
            strncpy (sdev_corr_parms.utc, time_string, sizeof(sdev_corr_parms.utc));
// always construct this datestamp in case IQ filename does not have an embedded datestamp
            snprintf (sdev_corr_parms.date_str, sizeof(sdev_corr_parms.date_str), "%d%02d%02d",
                (dfe.date_time.year+2000), dfe.date_time.month, dfe.date_time.day);
            sdev_corr_parms.tilt_angle = tilt_angle[0];
            sdev_corr_parms.ground_speed = avg_gs_knots;
            sdev_corr_parms.heading = heading_angle;
            sdev_corr_parms.track_angle = track;

            dsp2_main( range,
                noise_floor,
                noise_adjust,
                power,
                STC,
                r1mag,
                r2mag,
                db,
                sdev,
                init_mode,
                bin,
                num_prfs,
                (float)SweepSpd,

                sigma_turb,
                bar_alt,
                (float)comp_alt_offset,
                TotalBar,
                CurBar,
                scan_angle,
                airspeed,
                cturb_factor,
                &ac_iq_header,
                &ac_info,
                &cell_info,                       // make sure we fill this in
                &Aux_scan,
                &sdev_corr_parms );

                                                  // LR
            filtered_scan_angle[0] += scan_angle[0];
                                                  // SR
            filtered_scan_angle[1] += scan_angle[1];

            memset( big_db[LR], 0, 512 * sizeof(unsigned long int) );
//////  db  seems to  go thru DSPM to DSP3 ////////////////

/*   copy db directly to db_big for tran_rot*/
/*   short range data has 256 bins, data newer than 04/09/01 10:00:00AM*/

/*504 or so bins into 512*/
            for( i = (rb_lr_total - bin[LR]); i < rb_lr_total; i++ )
                big_db[LR][i] = db[LR][i - (rb_lr_total - bin[LR])];

            memset( big_db[SR], 0, 512 * sizeof(unsigned long int) );

/* copy db directly to db_big for tran_rot */
/* short range data has 256 bins, data newer than 04/09/01 10:00:00AM */

/* copy 244 bins into 512*/
            for( i = (rb_sr_total - bin[SR]); i < rb_sr_total; i++ )
            {
                big_db[SR][i * 2]     = db[SR][i - (rb_sr_total - bin[SR])];
                big_db[SR][i * 2 + 1] = db[SR][i - (rb_sr_total - bin[SR])];
            }

        }
/////////////////////////////////////////////////////////////////////////////////////////////////

///  some AC info and then  ---> DSPM  //////////////////////////

        if (first_dspm_call)
        {                                         /*new file or foundNewTime, initialize previous parameters*/
            prev_time = 0;
            prev_t_head = 0.0f;
            prev_gs_knots = 0.0f;
            cumulative_delta_hdg = 0.0f;
//delta_sec = 0.00f;
            delta_hdg = 0.0;
            avg_gs_knots = 0.0;
        }

        if(prev_t_head != 0.0f)
        {                                         /*calc delta heading*/
            delta_hdg = t_head - prev_t_head;
            cumulative_delta_hdg += delta_hdg;
        }

        if( prev_gs_knots != 0.0f)
/*calc delta gspd*/
            avg_gs_knots = (gs_knots + prev_gs_knots) / 2;

        if( rotate_translate == 0 )
        {                                         /*no rotation or translation will be performed*/
//delta_sec = 0.00f;
            delta_hdg = 0.0;
            avg_gs_knots = 0.0;
        }

        if (first_dspm_call)
            scan_direction = SCAN_UNKNOWN_DIRECTION;

        if( prev_scan_angle != 999 )
        {                                         /*this is the first epoch*/
            if( SweepDir == 0x0 )
                scan_direction = SCAN_LEFT_TO_RIGHT;
            else if( SweepDir == 0xFF )
                scan_direction = SCAN_RIGHT_TO_LEFT;

            if (prev_scan_direction == SCAN_UNKNOWN_DIRECTION)
                prev_scan_direction = scan_direction;
        }

        sw_dir = scan_direction;                  // MAT, Nathan double-check this assignment; was under horizontal sweep only

/*************************************************************************
 ******              Populate 453 Output Data Structures             ******
 **************************************************************************/

// populate and output the 453 zero-label data structure every epoch

        if ((wxrv.fp453 != NULL && TRUE == (Horiz_Sweep(CurBar))) ||
            TRUE == Wxi453ctrl.tx)
        {
            memset (&wxrv.zero, 0, sizeof(wxrv.zero));
// if new file output, tell Wxi to clear cell list
            if (TRUE == Wxi453ctrl.tx && TRUE == Wxi453ctrl.new_file)
            {
                Wxi453ctrl.new_file = FALSE;
                wxrv.zero.new_file = TRUE;
            }
            memcpy (wxrv.zero.AC_date, ACdate, sizeof(wxrv.zero.AC_date));
            wxrv.zero.epoch_ctr = ac_iq_header.Epoch_Count;
            wxrv.zero.format_version = ZERO_LABEL_453_FORMAT_VERSION;
// number of A429 words that can fit into packet after header
            wxrv.zero.buffer_size = (WXR453_PKT_SIZE - 18) / sizeof(unsigned long);
// number of A429 words that are in packet after header
            wxrv.zero.n = wxrv.zero.buffer_size - (sizeof(wxrv.zero.spare1) / sizeof(unsigned long));

// send debug-output synch flag thru zero-label to Wxi708
            if (TRUE == Wxi453ctrl.tx && 1 == radial_ctr)
            {
                wxrv.zero.mark = TRUE;
                gui_var->bytes_sent2wxi = Wxi453ctrl.bytes_sent;
            }

// populate A429 words in zero-label structure

// output utc timestamp to A453 data file
            if (wxrv.fp453 != NULL && TRUE == (Horiz_Sweep(CurBar)))
            {
//reverse UTC label for A453 data file
                                                  // Arinc 150 label
                temp_utc = (unsigned int *) &ac_iq_header.GPS_UTC_Course;
                if( GuiProcData.TimeSrc == USE_PC_MILLISECOND )
                    temp_utc = (unsigned int *) &pc_UTC;
                wxrv.zero.utc = ((*temp_utc>>24) & 0xFF) |
                    ((*temp_utc>> 8) & 0xFF00) |
                    ((*temp_utc<< 8) & 0xFF0000) |
                    0x68000000;
            }
// output utc timestamp to Wxi app
            if (TRUE == Wxi453ctrl.tx)
                                                  // Arinc 150 label
                memcpy (&wxrv.zero.utc, &ac_iq_header.GPS_UTC_Course,
                    sizeof(wxrv.zero.utc));
                                                  // Arinc 312 label
            memcpy (&wxrv.zero.ground_speed,  &ac_iq_header.IRS_Ground_Speed,
                sizeof(wxrv.zero.ground_speed));
                                                  // Arinc 314 label
            memcpy (&wxrv.zero.heading_angle, &ac_iq_header.IRS_True_Heading_Angle,
                sizeof(wxrv.zero.heading_angle));
                                                  // Arinc 313 label
            memcpy (&wxrv.zero.track_angle,   &ac_iq_header.IRS_True_Track_Angle,
                sizeof(wxrv.zero.track_angle));
                                                  // Arinc 324 label
            memcpy (&wxrv.zero.pitch_angle,   &ac_iq_header.IRS_Pitch_Angle,
                sizeof(wxrv.zero.pitch_angle));
                                                  // Arinc 325 label
            memcpy (&wxrv.zero.roll_angle,    &ac_iq_header.IRS_Roll_Angle,
                sizeof(wxrv.zero.roll_angle));
                                                  // Arinc 310 label
            memcpy (&wxrv.zero.irs_lat,       &ac_iq_header.IRS_Latitude,
                sizeof(wxrv.zero.irs_lat));
                                                  // Arinc 311 label
            memcpy (&wxrv.zero.irs_long,      &ac_iq_header.IRS_Longitude,
                sizeof(wxrv.zero.irs_long));
                                                  // Arinc 110 label
            memcpy (&wxrv.zero.latitude,      &ac_iq_header.GPS_Latitude,
                sizeof(wxrv.zero.latitude));
                                                  // Arinc 111 label
            memcpy (&wxrv.zero.longitude,     &ac_iq_header.GPS_Longitude,
                sizeof(wxrv.zero.longitude));

// populate the pre-453 control-data structure; 453 data compressed and output in dsp3

            memset (&wxrv.ctrl, 0, sizeof(wxrv.ctrl));
            if (TRUE == (Horiz_Sweep(CurBar)))
                wxrv.ctrl.label_1_8 = 0xB4;       // from Wxi708/file_453.h
            else if (TRUE == (Aux_Vert_Sweep(CurBar)))
                wxrv.ctrl.label_1_8 = 0x6A;       // from Wxi708/file_453.h
            else if (TRUE == (Aux_Horiz_Sweep(CurBar)))
                wxrv.ctrl.label_1_8 = 0xB4;       // temporary label value
            else
                wxrv.ctrl.label_1_8 = 0xFF;       // invalid: transitions, etc...

            if (wxrv.ctrl.label_1_8 != 0xFF)      // allowed 453 output
            {
                wxrv.ctrl.ctrl_accept_9_10 = IND_1;
                if( TotalBar > 1 )                // in auto-mode
                    wxrv.ctrl.ctrl_accept_9_10 = ALL;
                if( TotalBar > 1 )                // in auto-mode; otherwise, manual mode's value is 0
                    wxrv.ctrl.status_11_19.wx_alert_15 = 0x1;
                wxrv.ctrl.status_11_19.anti_clutter_16 = gcs;
                wxrv.ctrl.faults_20_25 = NO_DETECTED;
                wxrv.ctrl.stabilization_26 = 0x1;
                wxrv.ctrl.mode_27_29 = mode;
                if( TotalBar > 1 )
                    temp_flt =  multiscan_display_tilt( rad_alt,
                        bar_alt,
                        upper_tilt,
                        lower_tilt,
                        new_range*5,
                        mode );
                else
                    temp_flt = lower_tilt;
                                                  /*set tilt bits 30 - 36*/
                stuff_tilt_angle( temp_flt, &wxrv.ctrl );
                wxrv.ctrl.gain_37_42 = manual_gain;
                wxrv.ctrl.data_accept_50_51 = IND_1;
                if( TotalBar > 1 )                // in auto-mode
                    wxrv.ctrl.data_accept_50_51 = ALL;
/* note: following was not being initialized; is return value from filter_scan_angle()
which is currently not being called; as of 03-11-2010, initialized to 1 in declaration */
                if( angle_status != 1 )
//angle_status is BAD => antenna fault
                    wxrv.ctrl.faults_20_25 = 0x10;

/*stuff scan angle bits 52 - 63 with filtered scan angle; is done in dsp3 */

            }                                     // end 453 output filtered on label value
        }                                         // end if 453 output

/*************************************************************************
 ******                Pass Processed Epoch Data to DSPM             ******
 **************************************************************************/

// populate data_to_dspm structure; pass data even during a windshear sweep

        data_to_dspm.first_dspm_call        = first_dspm_call;
        data_to_dspm.new_scan               = new_scan;
        data_to_dspm.scan_angle_adjustment  = 0;
        data_to_dspm.scan_dir               = sw_dir;
        data_to_dspm.db                     = &big_db[0][0];
        data_to_dspm.cur_bar                = plane_num;
        data_to_dspm.total_bars             = TotalBar;
        data_to_dspm.s_s_beta               = s_s_beta;
        data_to_dspm.compass_rose_on        = compass_rose_on;
        data_to_dspm.apply_harsh_edit       = apply_harsh_edit;
        data_to_dspm.manual_gain            = manual_gain;
        data_to_dspm.gcs                    = gcs;
        data_to_dspm.mode                   = mode;
        data_to_dspm.track                  = track;
        data_to_dspm.heading                = t_head;
        data_to_dspm.drift_angle            = drift_angle;
        data_to_dspm.average_ground_speed   = avg_gs_knots;
        data_to_dspm.ground_speed           = gs_knots;
        data_to_dspm.display_range          = new_range*5;
        data_to_dspm.tilt_angle             = (double) tilt_angle[0]; // use LR value
        data_to_dspm.baro_alt               = bar_alt;
        data_to_dspm.coeff_const_offset     = coeff_const_offset;
        data_to_dspm.plane                  = plane_out;
        data_to_dspm.rb_total               = rb_total;
        data_to_dspm.rad_alt                = rad_alt;
        data_to_dspm.rad_alt_valid          = rad_alt_valid;
        data_to_dspm.res_constant           = res_constant;
        data_to_dspm.filtered_scan_angle    = filtered_scan_angle;
        data_to_dspm.comp_alt_offset        = comp_alt_offset;
        data_to_dspm.stc                    = STC[0];
        data_to_dspm.time_string            = time_string;
        data_to_dspm.millisec_time_string   = millisec_ctr_time_string;
        data_to_dspm.iq_version             = ac_iq_header.Version;
        data_to_dspm.eos                    = ac_iq_header.End_of_Sweep;
        data_to_dspm.windshear_on           = windshear_on;
        data_to_dspm.time_msec              = ac_iq_header.AC_Millisecond_Time_Stamp;

///////////////////////////////////  DSPM //////////////////////////////////////////////////////////////////

// transfer to DSPM

        dspm_main( &data_to_dspm,
            &rot_tran,
            &dfe,
            &servo_data,
            &wxrv,
            &terr_max,
            &vert_swp,
            &clutter_calc_data );

/*************************************************************************
 ******                         Main Loop Updates                    ******
 **************************************************************************/

                                                  // vertical scan
        if (TRUE == (Aux_Vert_Sweep(CurBar)) && FALSE == first_dspm_call)
        {
            vert_swp.prev_rad_vert = 1;
            vert_swp.first_vert_rad = 0;
            vert_swp.scan_angle = scan_angle[0];
            new_scan = 0;
        }
                                                  // valid horizontal scan; CurBar datatype implies >= 0
        else if ( ((TRUE == (Horiz_Sweep(CurBar)))  &&
            (data_format == WRT2100)         &&
            (fabs(real_scan_angle) <= 90.0)  &&
            (FALSE == windshear_sweep))
            ||
                                                  // auxiliary horizontal scan
            ((TRUE == (Aux_Horiz_Sweep(CurBar))) &&
            (FALSE == first_dspm_call)) )
        {
            vert_swp.prev_rad_vert = 0;
            vert_swp.first_vert_rad = 1;
            init_mode[0] = 0;
            init_mode[1] = 0;
            new_scan = 0;
            first_dspm_call = FALSE;              // important logic-flow flag
        }

        leave = 0;
        if( ( PrevBar != CurBar ) && (abs( CurBar - PrevBar ) == 1) )
            leave = 1;

// Set leave for Manual Mode
        if (TotalBar == 1)
        {
            if ( scan_direction != prev_scan_direction )
                leave = 1;
        }

/*set values for next time around*/
        PrevBar = CurBar;
        prev_t_head = t_head;
        prev_gs_knots = gs_knots;
        prev_time = time;
        prev_scan_angle = real_scan_angle;        // from scan_angle[0];
        prev_scan_direction = scan_direction;

    }                                             // end main process while-loop reading thru IQ file epoch records

/****************************************************************************
 ******                          End Of Main Loop                       ******
 *****************************************************************************/

    if( ((SweepDir == 0xFF) && (scan_direction == SCAN_LEFT_TO_RIGHT) ) ||
        ((SweepDir == 0x0)  && (scan_direction == SCAN_RIGHT_TO_LEFT)) )
    {
        if(SweepDir == 0xFF)
            scan_direction = SCAN_RIGHT_TO_LEFT;
        else if(SweepDir == 0x0)
            scan_direction = SCAN_LEFT_TO_RIGHT;
    }

    if (scan_cnt > Arch_db_swp_cnt) {

          // check_cells
          //which_cell = checkCells();
      Arch_db =2;
    }


    scan_cnt++;


    // MAT ROLL SERVO DEBUG -- remove when done
    fprintf(servo_db_file,"%d %f %f %f %f %f %f %f %f %f %f %f %f %f\n", scan_cnt,
	    (float)ac_info.ac_baro_alt,
            (float)ac_info.ac_rave_alt,
            ac_info.ac_loc.lat,
            ac_info.ac_loc.lon,
            (float)ac_info.ac_hdg,
            roll,
            servo_data.rec_roll_error,
            servo_data.comp_roll_error,
            (float)terr_max.current_sweep_max_elev,
            (float)terr_max.current_sweep_min_elev,
	    (float)data_to_dspm.flight_pta.L45_max,
	    (float)data_to_dspm.flight_pta.CH_max,
            (float) data_to_dspm.flight_pta.R45_max

            );





          fflush(arch_db_file);
          fflush(servo_db_file);


    if(track < 0)
        gui_var->track = track + 360;             /*make it 0 to 360*/
    else
        gui_var->track = track;

    gui_var->heading = t_head;
    gui_var->baro_alt = bar_alt;
    gui_var->lat = lat;
    gui_var->lon = lon;
    gui_var->utc = (double)hms_UTC;
    gui_var->gs_knots = gs_knots;
    gui_var->g_speed = gspd;                      /* meters/sec*/
    gui_var->pitch = pitch;
    gui_var->roll = roll;
    gui_var->cd_hdg = cumulative_delta_hdg;
    gui_var->man_alt = man_alt_offset;
    gui_var->comp_alt = comp_alt_offset;
    gui_var->static_air_temp = dfe.static_air_temperature;
    gui_var->merge_alt = bar_alt + comp_alt_offset;
    gui_var->format = (master_mode[1] | (master_mode[2] << 8) );
    gui_var->total_bar = (double)TotalBar;
    gui_var->bar = (double)bar;
    gui_var->rad_alt = rad_alt;
    gui_var->tilt = prev_tilt_angle;
    gui_var->gate_delay = (double)prev_rcvr_delay;
    gui_var->prev_num_pulses = (double)prev_num_pulses[0];
    gui_var->prfs = (double)prev_num_prfs;
                                                  // Added this 030407 per Greg for outputting to the labview interface
    gui_var->vert_scan_angle = (double)vert_swp.scan_angle;
    gui_var->range = prev_range;
    gui_var->display_scan_direction = (float)display_scan_direction;
    gui_var->scan_direction = (float)scan_direction;
    gui_var->pulses = num_pulses[1];
    gui_var->d_tilt = dfe.upper_tilt - dfe.lower_tilt;
    gui_var->bytes_read = byte_cntr;
    gui_var->length = length;

    setGuiFromServo( gui_var, &servo_data);

    GuiProcData.PrevTilt = prev_tilt_angle;
}                                                 /* end main scheduler iqproc() */


//---------------------------------------------------------------------------

void setGuiFromServo( GUI_VAR_TYPE  *gui_var, struct SERVO *servo_data)
{
    gui_var->rec_pitch_offset = servo_data->rec_pitch_offset;
    gui_var->rec_roll_offset = servo_data->rec_roll_offset;
    gui_var->rec_elev_offset = servo_data->rec_elev_offset;
    gui_var->rec_pitch_error = servo_data->rec_pitch_error;
    gui_var->rec_roll_error = servo_data->rec_roll_error;
    gui_var->rec_elev_error = servo_data->rec_elev_error;
    gui_var->comp_pitch_error = servo_data->comp_pitch_error;
    gui_var->comp_roll_error = servo_data->comp_roll_error;
    gui_var->comp_elev_error = servo_data->comp_elev_error;
    gui_var->maneuver_flag = servo_data->maneuver_flag;
    gui_var->second_order_error = servo_data->second_order_error;
    gui_var->sectors_good = servo_data->sectors_good;
    gui_var->qual_sweep = servo_data->qual_sweep;
    gui_var->num_qual_sweeps = servo_data->num_qual_sweeps;
    gui_var->init_too_high = servo_data->init_too_high;

}


/******************************************************************************/
/* expand ( ) is called to convert dbz data from the collected range to a     */
/* lesser displayed range.                                                    */
/* old_range = range of the collected data, old_dbz.                          */
/* new_range = range for new_dbz data                                         */
/* old_dbz = 320 or 40 nm range dbz data                                      */
/* new_dbz = range interpolated data                                          */
/*                                                                            */
/* NOTE: Only call this procedure with WXR2100 data!!!                        */
/******************************************************************************/
int expand( int old_range, int new_range, float *old_dbz, float *new_dbz )
{
    int i, j, div_factor;

/*check for valid range*/
    if ((old_range != 0.0) &&
        (new_range != 0.0))
    {
        div_factor = (int) (old_range / new_range);

        for( i = 0; i < 512; ++i )
            *(new_dbz + i) = *(old_dbz +  (i / div_factor));
        return new_range;
    }
    else
        return old_range;
}


//---------------------------------------------------------------------------

void OpenIQFile (char * filename, FILE ** fptr, unsigned long * filesize)
{
/* Open the selected IQ file */
    *fptr = fopen (filename, "rb");
    if (NULL == *fptr)
    {
        *filesize = 0;
        return;
    }
    first_dspm_call = TRUE;
    Wxi453ctrl.new_file = TRUE;
/* Calculate file size */
    *filesize = filelength (fileno(*fptr));
}


//---------------------------------------------------------------------------

int findNewTime( unsigned long int goto_time, GUI_VAR_TYPE * gui_var )
{
   unsigned long int temp_array[32];
   int done = 0;
   int error = 0;
   unsigned long Month_Day_Year;

   /* Moves IQ file pointer to the epoch data timestamped by 'goto_time' */

   if (IQ_SEL == IQ_file.state)
      first_dspm_call = TRUE;
   Wxi453ctrl.new_file = TRUE; // clear current Wxi display image

   // read current data block timestamp and compare to desired timestamp
   findAC( IQ_file.fptr );
   fread(temp_array, 4, 32, IQ_file.fptr);
   if( (goto_time < temp_array[2]) ) /*go back to start of data file*/
   {
      fseek( IQ_file.fptr, 0, SEEK_SET );
      gui_var->sw_count = 0;
   }

   while( !done )
   {
      findAC( IQ_file.fptr );
      fread(temp_array, 4, 32, IQ_file.fptr);
      if( goto_time < temp_array[2]) //go back to beginning of block and exit
      {
         fseek( IQ_file.fptr, -32*4, SEEK_CUR);
         done = 1;
      }
      else  //fseek to next block
      {
         if( fseek( IQ_file.fptr, temp_array[4] - 32*4, SEEK_CUR ) != 0 )
         {
            error = 1; // probably end of file
            done = 1;
         }
      }
   }
   return error;

} /* end findNewTime() */
//---------------------------------------------------------------------------

unsigned long int getLastTime( unsigned short int *last_time_array,
unsigned short *first_time_array,
FILE *fp, char return_last  )
{
    int time_found = 0;
    int count = 1;
    unsigned int long time, temp_array[4];
    unsigned char start_date [9];
    unsigned char end_date [9];
    unsigned int long return_time;

/*Looking for the A/C label in -512 increments from end-of-file.  Returns milliseconds
passed midnight from AC Data Block*/

    findAC( fp );

/*read first 3 words of AC Header in first epoch of data file*/
    fread(temp_array, 4, 3, fp);

/*decode start date*/
    bytextract( temp_array[0], &start_date[0],&start_date[1],
        &start_date[2],&start_date[3] );
    bytextract( temp_array[1], &start_date[4],&start_date[5],
        &start_date[6],&start_date[7] );

/* Decode Time */
    time = temp_array[2];
    return_time = temp_array[2];                  // Initialize return_time
    first_time_array[0] = (unsigned short)floor(time/3600000l);
    time = time - first_time_array[0]*3600000l;
    first_time_array[1] = (unsigned short)floor(time/60000l);
    time = time - first_time_array[1]*60000l;
    first_time_array[2] = (unsigned short)floor(time/1000);
    first_time_array[3] = (unsigned short)floor(time - first_time_array[2]*1000);

    first_time_array[6] = start_date[0];
    first_time_array[7] = start_date[1];
    first_time_array[8] = start_date[2];
    first_time_array[9] = start_date[3];
    first_time_array[10] = start_date[4];
    first_time_array[11] = start_date[5];
    first_time_array[12] = start_date[6];
    first_time_array[13] = start_date[7];
    first_time_array[14] = 0;

    while( time_found == 0)
    {
        fseek( fp, -512 * count, SEEK_END );
        if (fp == NULL )
        {
            MessageBox (0,"fp == NULL", 0,0);
            break;
        }
        if( (time_found = findAC(fp)) == 0 )
            ++count;
    }
/*read first 3 words of AC Header in last epoch of data file*/
    fread(temp_array, 4, 3, fp);

/*decode start date*/
    bytextract( temp_array[0], &end_date[0],&end_date[1],
        &end_date[2],&end_date[3] );
    bytextract( temp_array[1], &end_date[4],&end_date[5],
        &end_date[6],&end_date[7] );

/* Decode Time */
    time = temp_array[2];
    last_time_array[0] = (unsigned short)floor(time/3600000l);
    time = time - last_time_array[0]*3600000l;
    last_time_array[1] = (unsigned short)floor(time/60000l);
    time = time - last_time_array[1]*60000l;
    last_time_array[2] = (unsigned short)floor(time/1000);
    last_time_array[3] = (unsigned short)floor(time - last_time_array[2]*1000);

    last_time_array[6] = end_date[0];
    last_time_array[7] = end_date[1];
    last_time_array[8] = end_date[2];
    last_time_array[9] = end_date[3];
    last_time_array[10] = end_date[4];
    last_time_array[11] = end_date[5];
    last_time_array[12] = end_date[6];
    last_time_array[13] = end_date[7];
    last_time_array[14] = 0;

/*go back to start of data file*/
    fseek( fp, 0, SEEK_SET );

    if (return_last)
        return_time = temp_array[2];

    return return_time;

}                                                 /* end getLastTime() */


//---------------------------------------------------------------------------

void bytextract (unsigned long inbuffer, unsigned char *outdata3, unsigned char *outdata2,
unsigned char *outdata1, unsigned char *outdata0)
{
    unsigned long tempbuffer;
    unsigned int masking;
    unsigned int temp [4];
    int i;

    tempbuffer = inbuffer;
    masking = 0xff;

    for (i=0; i<4; ++i)
    {
        temp[i] = (int)(tempbuffer & (masking));
        tempbuffer = tempbuffer >> 8;
    }

/* Capture the lowest 8 bits */
    *outdata3 = (char)temp[3];
    *outdata2 = (char)temp[2];
    *outdata1 = (char)temp[1];
    *outdata0 = (char)temp[0];
}


//---------------------------------------------------------------------------

void shortxtract (unsigned long inbuffer, short int *outdata1, short int *outdata0)
{
    unsigned long tempbuffer;
    unsigned long masking;
    short int temp [2];
    int i;

    tempbuffer = inbuffer;
    masking = 0x0000ffffl;

    for (i=0; i<2; ++i)
    {
        temp[i] = (short int)(tempbuffer & masking);
        tempbuffer = tempbuffer >> 16;
    }
    *outdata1 = temp[1];
    *outdata0 = temp[0];
}


//---------------------------------------------------------------------------

/* Find the A/C Label then fseek back 16 bytes */
short int findAC( FILE *fp )
{
    char cbuf[1];
    short int ac_found = 0;
    short int done = 0;

    while (done == 0)
    {
        if( fread(cbuf, 1, 1, fp) != 1 )
            done = 1;
        if (cbuf[0] == 'C')
        {
            if( fread(cbuf, 1, 1, fp) != 1 )
                done = 1;
            if (cbuf[0] == '/')
            {
                if( fread(cbuf, 1, 1, fp) != 1)
                    done = 1;
                if (cbuf[0] == 'A')
                {
                    ac_found = 1;
                    done = 1;
                    fseek(fp, -16, SEEK_CUR);
                }
            }
        }
    }

    return ac_found;
}


//---------------------------------------------------------------------------

int info_to_next_l_r( long int *r_l_epoch_ptr, FILE *fp, long int *l_r_start )
{
    int r_l_cnt = 0;
    unsigned char sweep_dir = 0x1;                //0;//
    unsigned long int buffer[128];
    unsigned char dummy;
    unsigned char curbar = 1;
    unsigned char eos = 0;
    long int temp;
    long int temp1;

    memset( buffer, 0, 512);

    while( (sweep_dir != 0x00) )                  //(sweep_dir == 0) )//
    {                                             //not end_of_sweep
        findAC( fp );

//chk sweep direction
        temp = ftell( fp );
        fseek(fp, 512, SEEK_CUR );
        fread( buffer, 4, 11 , fp );
        bytextract (buffer[8], &dummy, &sweep_dir, &dummy, &dummy);
        bytextract (buffer[9], &dummy, &eos, &curbar, &dummy);

        if( (sweep_dir == 0x00))                  // || (curbar != 1) )//sweep_dir != 0 )//
        {                                         //end_of_sweep
            fseek(fp, temp, SEEK_SET );
            *l_r_start = temp;
        }
        else
        {                                         //save pointer to start of r_l epoch
            *(r_l_epoch_ptr + r_l_cnt) = temp;
            r_l_cnt++;
        }
    }

    return r_l_cnt-1;

}                                                 /* end info_to_next_l_r() */


//---------------------------------------------------------------------------

/* Checks to see that data block length is between 1536 and 68096. */
short int lengthchk( FILE *fp, unsigned long length, unsigned long *byte_cntr,
long int *bytes_read, unsigned int *az_cnt )
{
    unsigned int indx_loc;
    short int len_chk = 0;
    char line [255];
    if (length > 68096)                           //5632)
    {
        if (length != 134144l)
        {
            sprintf (line, "Bad block size : %u ", length );
            MessageBox (0, line, 0, 0);
            printf ("\n*****   Bad block size:  %u   *****", length);
            printf ("\n     attempt to search for next block   ");
            *bytes_read = ftell(fp);
            indx_loc = id_size(fp);
            fseek (fp, (indx_loc)+*bytes_read-12, SEEK_SET);
        }
        else
            fseek (fp, 134060l, SEEK_CUR);        // 134060=134144bytes blocksize-84bytes read
        *az_cnt+=1;
        *byte_cntr += length;
    }
    else if (length < 1024)
    {
        sprintf (line, "Bad block size : %u ", length );
        MessageBox (0, line, 0, 0);
        printf ("\n*****   Bad block size:  %ld   *****", length);
        printf ("\n     attempt to search for next block   ");
        *bytes_read = ftell(fp);
        indx_loc = id_size(fp);
        fseek (fp, (indx_loc)+*bytes_read-12, SEEK_SET);
        *az_cnt+=1;
        *byte_cntr += length;
    }
    else
        len_chk = 0xff;

    return len_chk;

}                                                 /* end lengthchk() */


//---------------------------------------------------------------------------

void high_low_bw( short int *I,
short int *Q,
int bins)
{
    short int bin;
    short int *I_loc, *Q_loc;
    short int I_old, Q_old;
    float beta = HI_LO_BW_CONVERSION;

    if (NULL == I || NULL == Q)
        return;

    I_loc = (short int *) malloc(sizeof(short int)*bins);
    Q_loc = (short int *) malloc(sizeof(short int)*bins);
    if (NULL == I_loc || NULL == Q_loc)
        return;

    memcpy(I_loc,I,bins*sizeof(short int));
    memcpy(Q_loc,Q,bins*sizeof(short int));

    for(bin = 1; bin < bins; bin++)
    {
        I_old = I[bin-1];
        Q_old = Q[bin-1];

        I[bin] = (short int) (I_old + beta * (I_loc[bin] - I_old));
        Q[bin] = (short int) (Q_old + beta * (Q_loc[bin] - Q_old));
    }

    free(I_loc);  I_loc=NULL;
    free(Q_loc);  Q_loc=NULL;
}


//-----------------------------------------------------------------------------

void readPRF (
short int  num_prfs, int data_format, short int *num_pulses, int *bin, ushort *PWidth,
ulong freq_code[MAX_PRF_SETS][MAX_PULSES][3],
ulong phase[MAX_PRF_SETS][MAX_PULSES][3],
short int I[MAX_PRF_SETS][MAX_PULSES * MAX_RANGE_BIN],
short int Q[MAX_PRF_SETS][MAX_PULSES * MAX_RANGE_BIN],
ulong STC[MAX_PRF_SETS][MAX_RANGE_BIN],
ulong *buffer4,
long *bytes_read,
int lr_bw,
int sr_bw)

{
    int i;
    int k;
    int prf_index;
    short temp_short2;
    short temp_short1;
    uchar cdummy;
    short int idummy1;
    short int current_prf[MAX_PRF_SETS];
    uchar temp_char1;
    short int pulse_index;
    unsigned char ant_switch_st = 0;

    if( data_format == WRT2100 )
    {

        for (prf_index=0; prf_index < num_prfs; ++prf_index)
        {

            fread (buffer4, 4, 1, IQ_file.fptr);
            shortxtract (buffer4[0], &temp_short1, &idummy1);
            current_prf[prf_index] = temp_short1;
            bytextract (buffer4[0], &cdummy, &cdummy, &cdummy, &temp_char1);
            num_pulses[prf_index] = temp_char1;

            for (pulse_index=0; pulse_index < num_pulses[prf_index]; ++pulse_index)
            {

                fread (buffer4, 4, 5, IQ_file.fptr);
                shortxtract (buffer4[0], &temp_short2, &temp_short1);
                PWidth[prf_index] = temp_short1;
                bin[prf_index] = temp_short2;
                shortxtract (buffer4[1], &temp_short2, &temp_short1);
                freq_code[prf_index][pulse_index][1] = temp_short2;
                freq_code[prf_index][pulse_index][0] = temp_short1;
                shortxtract (buffer4[2], &idummy1, &temp_short1);
                freq_code[prf_index][pulse_index][2] = temp_short1;
                shortxtract (buffer4[3], &temp_short2, &temp_short1);
                phase[prf_index][pulse_index][0] = temp_short1;
                phase[prf_index][pulse_index][1] = temp_short2;
                shortxtract (buffer4[4], &idummy1, &temp_short1);
                phase[prf_index][pulse_index][2] = temp_short1;

                                                  /*read the  IQ block*/
                fread (buffer4, 4, bin[prf_index], IQ_file.fptr);

                if (pulse_index < MAX_PULSES)     /*make sure we don't overfill the array*/
                {
                    k = (pulse_index*bin[prf_index]);
                    for( i = 0; i < (bin[prf_index]); ++i )
                        shortxtract( buffer4[i],&Q[prf_index][k+i],&I[prf_index][k+i]);

                }
            }                                     /*end of pulse_index loop*/

   // Do range filter adjustment for new High Bandwidth data
            if(lr_bw == 5){
               high_low_bw(   &I[0][0], &Q[0][0],  bin[0]);
            }


            *bytes_read += 8 + (4*bin[prf_index]);
            fread( STC[prf_index], 4, bin[prf_index], IQ_file.fptr );
            *bytes_read += 4*bin[prf_index];
        }                                         /*end of prf_index loop*/

    }
    else
    {

        for (prf_index=0; prf_index < num_prfs; ++prf_index)
        {
            for (pulse_index=0; pulse_index < num_pulses[prf_index]; ++pulse_index)
            {
                fread (buffer4, 4, 2, IQ_file.fptr);
                shortxtract (buffer4[0], &idummy1, &temp_short1);
                current_prf[prf_index] = temp_short1;
                bytextract (buffer4[0], &ant_switch_st, &temp_char1, &cdummy, &cdummy);
                bin[prf_index] = temp_char1;
                bin[prf_index]+=(char)1;          /*add on eto bin count if old data. CJD can explain.*/
                freq_code[prf_index][pulse_index][0] = buffer4[1];

                                                  /*read the  IQ block*/
                fread (buffer4, 4, bin[prf_index], IQ_file.fptr);

                if (pulse_index < MAX_PULSES)     /*make sure we don't overfill the array*/
                {
                    k = (pulse_index*bin[prf_index]);
                    for( i = 0; i < (bin[prf_index]); ++i )
                        shortxtract( buffer4[i],&Q[prf_index][k+i],&I[prf_index][k+i]);

                }
            }                                     /*end of pulse_index loop*/



 // Do range filter adjustment for new High Bandwidth data  --- 
            if(lr_bw == 5){
               high_low_bw(   &I[0][0], &Q[0][0],  bin[0]);
            }


            *bytes_read += 8 + (4*bin[prf_index]);
            fread( STC[prf_index], 4, bin[prf_index], IQ_file.fptr );
            *bytes_read += 4*bin[prf_index];
        }                                         /*end of prf_index loop*/


    }




}


//////////////////////////////////  ADD MODULES INTO DSP1, DSP2, DSP3 and DSPM  ////////////////////////////

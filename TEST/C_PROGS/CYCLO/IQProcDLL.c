/* 04/04/01 Greg Koenigs Removed all warns generated from the compile.*/
/* 04/09/01 changed the 2100 short range to 256 bins*/
/* 04/10/01 adjusted azimuth filter and added gain in wx1.c. */

/* TO GET THIS BACK TO NORMAL
   1. Re-enable the 0.3125 deg scan angle lag
   2. Remove anything for box car filter
   3. Remove the constant time stamp
   4. Remove the scan_angle -= 4.0*0.375; stuff
   5. Unforce reversal with header[33]
*/

#include <windows.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <io.h>
#include <sys\stat.h>

#include "defines.h"
#include "erib.h"

#include "iqprocdll.h"
#include "conv_gs.h"
#include "id_size.h"
#include "conv_ll.h"
#include "conv_msc.h"
#include "conv_pr.h"
#include "conv_utc.h"
#include "wx1.h"
#include "wx2.h"
#include "datetime.h"

#include "display_tilt.h"
#include "pack.h"
#include "platform.h"
#include "gui_var_init.h"
#include "dspm_defines.h"
#include "units.h"
#include "flight_path_threat.h"


#ifndef max
#define max(__a,__b)    (((__a) > (__b)) ? (__a) : (__b))
#endif
#ifndef min
#define min(__a,__b)    (((__a) < (__b)) ? (__a) : (__b))
#endif

#pragma hdrstop
#pragma argsused
#define L_RNG_NM_TO_BIN   101214.75      // 2^16 / (331.5172/512)
#define S_RNG_NM_TO_BIN   809717.06      // 2^16 / (41.4397/512)
#define NM_TO_DISPLAY_BIN 104857.6       // 2^16 / (320/512)
#define NM_TO_L_RNG_BIN   1.5444144
#define NM_TO_S_RNG_BIN   12.3553152
#define FT_PER_LR_BIN   3934.3            // (331.5172/512) * 6076.1155 ft
#define FT_PER_SR_BIN   491.78            // (41.4397/512) * 6076.1155 ft


int info_to_next_l_r( long int *r_l_epoch_ptr,
                      FILE *,
                      long int *l_r_start );

extern FILE_WRITE_TYPE File_Writes;
extern GUI_PROC_DATA_TYPE GuiProcData;
extern char file_name [255];
extern char * getFilename (char * preName, char * file_name);

/*
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void* lpReserved)
{
        return 1;
}
//*/


static int first_dspm_call = FALSE;
static _453_VECTOR_TYPE wxrv; /*453 data vector*/
FILE *iqfp, *fp453, *fpr453, *fp453_p3;
char p1_453_file [255] = "";
char p3_453_file [255] = "";

enum { WRT700, WRT2100 } data_format;


void readPRF (int  num_prfs, int data_format, int *num_pulses, int *bin, ushort *PWidth,
ulong freq_code[MAX_PRF_SETS][max_pulses][3],
ulong phase[MAX_PRF_SETS][max_pulses][3],
short int I[MAX_PRF_SETS][max_pulses * max_range_bin],
short int Q[MAX_PRF_SETS][max_pulses * max_range_bin],
ulong STC[MAX_PRF_SETS][max_range_bin],
ulong *buffer4 ,
long *bytes_read);

void setGuiFromServo( GUI_VAR_TYPE  *gui_var, struct SERVO *servo_data);


unsigned long* iqproc(
            unsigned long int data_file_size,
				char *bar,
            unsigned long int *bytes,
            unsigned long int *plane_out,
            GUI_VAR_TYPE *gui_var)

{
	FILE *plane1, *plane2, *merged_plane;
	unsigned long buffer4 [max_range_bin*max_pulses];/* Buffer size is determined
                                                       by which is the number of
                                                       range bins. */
   V1_AC_IQ_Header_Type ac_iq_header;// = (V1_AC_IQ_Header_Type*)buffer4;


        int  data_format;
	int  i,j,k;
	unsigned char dummy;
	short int dummy1;
	short int prf_index;
      //	short int pulse_index;
	unsigned long int byte_cntr = ftell(iqfp);
	unsigned int az_cnt = 0;
	unsigned char ACdate [9];
	unsigned char hrs;
	unsigned char minutes;
	unsigned char sec;
	unsigned long time, temp_time;
        static unsigned long last_time = 0;
        unsigned long isecs;
	unsigned char label [4];
	unsigned long length = 0;
	static float   t_head = 0.0, gspd = 0.0, gs_knots = 0.0;
	float bar_alt = 0.0, track = 0.0, pitch = 0.0, roll = 0.0, rad_alt = 0.0, drift_angle = 0.0;
        float airspeed;
        int rad_alt_valid;

	static double prev_t_head = 0.0f, prev_gs_knots = 0.0f;//, prev_trk = 0.0;
	static unsigned long int prev_time = 0;
	float  lat, lon, temp_64;
	unsigned long hms_UTC;
	unsigned char IQdate [9];
	unsigned char IQlabel [5];
	short int scan_value = 0;
	float scan_angle[2], prev_scan_angle = 999;

	static enum scan_direction_type scan_direction = SCAN_UNKNOWN_DIRECTION;
	enum scan_direction_type prev_scan_direction = scan_direction;
 	enum scan_direction_type display_scan_direction, sw_dir;
	short int tilt_value = 0;
	float tilt_angle;
        static float upper_tilt =  0;
        static float lower_tilt = 0;
  	unsigned char rcvr_delay = 0;
	unsigned char prev_rcvr_delay;
	unsigned char range[3];
        unsigned char wx_range; /*storage for range before sending to wx1 , wx2,
                             tran_rot*/
	unsigned short int PWidth[MAX_PRF_SETS];
	unsigned char Azimuth = 0;
	unsigned char SweepRange = 0;
	static unsigned char SweepDir = 0;
	unsigned char SweepSpd = 0;
	unsigned char TotalBar = 0,EOS = 0, Polar = 0;
	static unsigned char CurBar = 0;
	short int num_pulses[MAX_PRF_SETS];
	short int num_prfs;
	short int prev_num_pulses[MAX_PRF_SETS];
	short int prev_num_prfs;
//	short int current_prf[MAX_PRF_SETS];
	int bin[MAX_PRF_SETS];
//	unsigned char ant_switch_st = 0;
	unsigned long freq_code[MAX_PRF_SETS][max_pulses][3];
	unsigned long phase[MAX_PRF_SETS][max_pulses][3];
	short int I[MAX_PRF_SETS][max_pulses * max_range_bin];
	short int Q[MAX_PRF_SETS][max_pulses * max_range_bin];
	unsigned long int STC[MAX_PRF_SETS][max_range_bin];
   //unsigned long int prev_stc[MAX_PRF_SETS][max_range_bin];
	float std_input[MAX_PRF_SETS][max_range_bin];
	float power[MAX_PRF_SETS][max_range_bin];
	float r1mag[MAX_PRF_SETS][max_pulses * max_range_bin];
   float r2mag[MAX_PRF_SETS][max_pulses * max_range_bin];
   unsigned long int db[MAX_PRF_SETS][max_range_bin];
   unsigned int sdev[MAX_PRF_SETS][max_range_bin];
	unsigned int turb_threshold[MAX_PRF_SETS][max_range_bin],
                severe_turb_threshold[MAX_PRF_SETS][max_range_bin];
	double delta_hdg = 0.0f, avg_gs_knots = 0.0f;//, delta_sec = 0.0f;//,
          //delta_trk = 0.0f;

	/* Variable Initialization*/
        float temp_flt = 0.0;
	float noise_floor = 419;
	int init_mode[2];
	int noise_adjust = 0;  //make something from header feed this
	long int bytes_read = 0;
	static unsigned char PrevBar = 0; /*must remember*/
	short int len_chk;
	float prev_tilt_angle;
	float prev_range;
	short int first_pass = 0;
	unsigned long int big_db[MAX_PRF_SETS][MAX_BINS];
	int new_scan = TRUE;
        static int OldEndOfSweep = 0;
   unsigned char master_mode[4];
//   unsigned char temp_char1;
   unsigned char temp_char2;
   short int temp_short1;
   short int temp_short2;
   int rb_total;
   unsigned int plane_num; /*tran_rot(), select memory plane  to store the
                             processed IQ data*/
   int max_bar;
   static float cumulative_delta_hdg = 0.0f;
   char filename453[16];
   static ROT_TRAN_TYPE rot_tran;
   double test_pin[1];//test only
   static DATA_FOR_ERIB_TYPE dfe;   //data for ERIB
   static double filtered_scan_angle[3] = {0.0,0.0,0.0}; /*1 and 2 for long and
                                            short filter, 3 temp for 453 count*/
   long int comp_alt_offset;
   long int man_alt_offset;

	/*init from header*/
   short int manual_gain = gui_var->manual_gain;
   unsigned long int rotate_translate = 1;  //debug switch
   //int rev_R_L_sweep = 0;//(int)header[33]; //debug switch
   double s_s_beta = gui_var->s_s_beta;
   int compass_rose_on =  gui_var->compass_rose_on;
   double res_constant =  gui_var->res_constant;//test only
   int tilt_resolution =  gui_var->tilt_resolution; /*0 = 1/4 deg res and greater the 0 is
                            //           1/64th deg res*/
   unsigned char gcs = (unsigned char)  gui_var->gcs;/* 1 = GCS  0 = no GCS*/
   unsigned char mode = (unsigned char) gui_var->mode;
   double new_range =  gui_var->new_range;
   double scan_angle_adjustment =  gui_var->scan_angle_adj;
   int apply_harsh_edit = gui_var->apply_harsh_edit;

   //float altitude_offset = header[53];  //test only
   double coeff_const_offset =  gui_var->coeff_const_offset; //test only
   int status453 = gui_var->status453;   /*0 = no action, 1 = open data file and save,
                                   2 = close open file*/
   int short_range_bins_256 = gui_var->short_range_bins_256;  //test only
   int angle_status;
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
   char filename[32];   char tmp_str[32];
   struct stat statbuf;
   double test[2][512];
   int bin_start[3], set;
   static DSP1_TERR_MAX_TYPE terr_max;
   float scan_adder;//,scan_angle_old;
   //static float hi_turn_rate_hdg = 0.0, lo_turn_rate_hdg = 0.0;
   int radial_cnt = 0;
   //int flag = 0;
   char time_string[32];
   static struct SERVO servo_data;

   unsigned int estimates_available;
   float roll_angle;
   float heading_angle;
   unsigned int antenna_sat_flag;
   static int num_scans = 0;
   float temp_power[512];
   char test_name[32];

   //int exponent = 4;
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
   extern char makeFilenameExtension [255];
   float cturb_factor;
   float real_scan_angle;
   float flight_phase = 0;
   float sb4_phi_low = 0;
   struct{ float speed;
           float dir;
           float raw_angle;
           float filtered_angle;
           float hdg;
           float hdg_scan;
           float hdg_fscan;
           float ant_hdg;
           float dsp_hdg_delta;}
           scan;
   unsigned char test_buf[4];
   unsigned int num_extra_words;
   unsigned int num_extra_429;
   FLIGHT_PHASE_CALC_TYPE fp_calc;
   float rec_stab_elev_angle;
   float rec_stab_scan_angle;
   int i_seed;
   unsigned int *temp_utc;
   int binwidth;
   char antenna_mode[8];
   short int ac_found;
   char hdr_found;

   DSP2_TO_DSPM_TYPE data_to_dspm;

   // Extra words
   V1_Extra_Words_Type* extra_wds_ptr;

   // exd_vcl_wds is declared in the header file for access all over the place

   EXD_VCL_WDS_TYPE * exd_vcl_wds;
   EXD_429_WDS_TYPE * exd_429_wds;
   EXD_DIS_WDS_TYPE * exd_dis_wds;
   EXD_AGC_WDS_TYPE * exd_agc_wds;

   int num_ext_word;

   unsigned int ext_429_wds[32];
   int ext_dis_wds[8];
   int wpe_disc;
   int air_gnd_disc = AIR; // MAT make AIR (255) the default  since currently it does not seem to be set anywhere
                           // in new versions of data files the V1_AC_IQ_Header_Type has an air_gnd flag
   V1_Cell_Track_Type ext_vcl_wds[32];
   V1_AGC_Type ext_agc_wds;
   float rec_flight_phase;
   int A429_label;

   if (first_pass == 0) {
    initFlightPathThreat(&data_to_dspm.flight_pta);
   }

   vert_swp.first_vert_rad = 1;
   vert_swp.prev_rad_vert = 0;
   dfe.clutter_range = 0;
   dfe.horiz_range = 320;

   //wxrv.plug = (int)header[46];/*used in dbz_to_453 to enable singleton*/
   wxrv.plug = /*(int)header[46]*/ gui_var->plug;/*used in dbz_to_453 to enable singleton*/
	/*init range array*/
	range[0] = 0; /*MultiScan Long Range 320, currently not used*/
	range[1] = 0;  /*MultiScan Short Range 40, currently not used*/
	range[2] = 0;

	/*init init_mode array*/
	init_mode[0] = 255;
	init_mode[1] = 255;

   //memset( prev_stc, 0xff, max_range_bin * MAX_PRF_SETS * 4);

   for( k = 0; k < MAX_PRF_SETS; ++k )
   {
      for( j = 0; j < max_pulses; ++j)
      {
	      for( i = 0; i < 3; ++i )
		      freq_code[k][j][i] = 0;
      }
   }


   if (new_scan)
     memset( plane_out + 12*MAX_BINS_X_2*MAX_BINS_X_2, 0, MAX_BINS_X_2 * MAX_BINS_X_2 * 4 );

   /* Start reading the file one epoch at a time*/
   while ( (data_file_size - byte_cntr > 9728) && (scan_direction == prev_scan_direction) && (r_l_cnt != -2) && (leave == 0 ) )//(radial_cnt < 320) ) /*data_file_size 1536 */
   {
      radial_cnt++;
      len_chk = 0;

      //if( (scan_direction != RIGHT_TO_LEFT) || (rev_R_L_sweep == 0) )
      //{  //normal process

         while( len_chk == 0 )
         {
           *bytes = byte_cntr;
           hdr_found = FALSE;

            while (!hdr_found)
            {
               ac_found = findAC( iqfp );
	            /* Read AC Data from the file */
	            //fread (buffer4, 4, 128, iqfp);
               fread (&ac_iq_header, 1, 139*4,iqfp);  //read AC and IQ headers
               memcpy( buffer4, &ac_iq_header, 139*4);
	            /* Capture AC IQ Data Block Length */
   	         //length = (unsigned long)((ceil((float)buffer4[4]/512))*512);
               length = (unsigned long)((ceil((float)ac_iq_header.Number_Of_Bytes/512))*512);
               if ((length == 9760) || (length == 10240) || (length == 1024) )
                  hdr_found = TRUE;
               //else if(length = 1024){
               //   hdr_found = TRUE;
                  //ac_iq_header.Current_Bar = 127;
               //}
               else // Bad length
               {
                  //MessageBox (0, "Bad Length detected, skipping 1 radial", 0, 0);
                  fseek (iqfp,9760-128, SEEK_CUR);
               }
            }
	         len_chk = lengthchk( iqfp, length, &byte_cntr, &bytes_read, &az_cnt );
	      } /*end while*/
         byte_cntr += length;

         /////////////////////////////////////////////

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
      if ((time - last_time) >= 1000) {
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
      if( ac_iq_header.Master_Mode_Int == 2100 )   /* 2 is for 2100 radar */
         data_format = WRT2100;
      else
         data_format = WRT700;

		/* decode ARINC data */
      //conv_pr (&drift_angle, buffer4[28]);               /*DRIFT ANGLE*/
      drift_angle = 0.005493164*(float)ac_iq_header.Drift_Angle.Drift_Angle;
      if (drift_angle < 0.0)
         drift_angle += 360;

      //conv_pr (&track, buffer4[8]);                      /*track*/
      track = 0.005493164*(float)ac_iq_header.IRS_True_Track_Angle.IRS_True_Track_Angle ;

      if( track < 0 )
         track +=360;

		//conv_pr (&t_head, buffer4[9]);                     /*heading*/
      t_head = 0.005493164*(float)ac_iq_header.IRS_True_Heading_Angle.IRS_True_Heading_Angle;
      if( t_head < 0 )
         t_head +=360;

      scan.hdg = t_head;

		//conv_gs (&gspd, buffer4[10]);                      /*ground speed meters/sec*/
      gspd = (1852.0/(8.0*3600.0))*(float)ac_iq_header.IRS_Ground_Speed.IRS_Ground_Speed;

		//conv_gs_knots( &gs_knots, buffer4[10] );           /*ground speed knots*/
      gs_knots = 0.125*(float)ac_iq_header.IRS_Ground_Speed.IRS_Ground_Speed;

		//conv_msc (&bar_alt, buffer4[14]);                  /*barometric altitude*/
      bar_alt = ac_iq_header.ADC_Baro_Altitude_1013mb.ADC_Baro_Altitude_1013mb;

      if(GuiProcData.BaroAltOverride)
         bar_alt = (float) (int) (0.125 * (float) ac_iq_header.GPS_Altitude_MSL.GPS_Altitude_MSL_1 + 0.5);

      dfe.ms_baro_altitude = bar_alt;

      //conv_msc (&rad_alt, buffer4[15]);                  /*radio altitude*/
      rad_alt = 0.125*(float)ac_iq_header.ALT_Radio_Altitude.ALT_Radio_Altitude;
      //rad alt SSM bits are currently set good all the time
      //Chuck will fix some day.  for now use below
      rad_alt_valid = 0;//force to zero
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

		//conv_msc(&pitch, buffer4[6]);/*pitch*/
      pitch = 0.010986328*(float)ac_iq_header.IRS_Pitch_Angle.IRS_Pitch_Angle;

		//conv_msc(&roll, buffer4[7]);/*roll*/
      roll = 0.010986328*(float)ac_iq_header.IRS_Roll_Angle.IRS_Roll_Angle;

		//conv_ll(&lat, buffer4[11]);/*IRS latitude*/
      lat = 0.000171661*ac_iq_header.IRS_Latitude.IRS_Latitude;
      lat += GuiProcData.lat_offset;  //add offset from gui

		//conv_ll(&lon, buffer4[12]);/*IRS longitude*/
      lon = 0.000171661*ac_iq_header.IRS_Longitude.IRS_Longitude;
      lon += GuiProcData.lon_offset;  //add offset from gui


      if ( ac_iq_header.Version == V2_MS) {
            air_gnd_disc = ac_iq_header.AirGnd;
      }
      else {
        // some where in extra words we might know but default to AIR until we find out
          air_gnd_disc = AIR;
      }


		//conv_utc(&hms_UTC, buffer4[19]);/*UTC*/
      hms_UTC = ac_iq_header.GPS_UTC_Course.BNR_Hours<<16 |
                ac_iq_header.GPS_UTC_Course.BNR_Minutes<<8 |
                ac_iq_header.GPS_UTC_Course.BNR_Seconds;

      // This accounts for new IQ Data With out UTC label - Load the buffer4
      //if (     (((hms_UTC >> 16) & 0xFF) == 0) &&
      //         (((hms_UTC >>  8) & 0xFF) == 0) &&
      //         (( hms_UTC        & 0xFF) == 0) )


      if( hms_UTC == 0 )
      {
         //buffer4[19] = ( (sec & 0x3F) | ((minutes & 0x3F) << 6) | ((hrs & 0x1F) << 12) ) << 11;
         //conv_utc(&hms_UTC, buffer4[19]); /*UTC*/
         hms_UTC = (hrs&0x1F)<< 16 |
                   (minutes&0x3F)<< 8 |
                   sec&0x3F;
      }

      sprintf( time_string,"%02d:%02d:%02d", (hms_UTC >> 16) & 0xFF, (hms_UTC >> 8) & 0xFF, hms_UTC & 0xFF );

      // MAT copy UTC time - to our flight_path_threat
   //   sprintf(data_to_dspm.flight_pta.time_string,"%02d:%02d:%02d", (hms_UTC >> 16) & 0xFF, (hms_UTC >> 8) & 0xFF, hms_UTC & 0xFF );


      //conv_msc( &airspeed, buffer4[26] );/*airspeed*/
      airspeed = 0.0625*(float)ac_iq_header.True_Airspeed.True_Airspeed;

      //conv_msc( &temp_64, buffer4[27]);/*Static Air Temperature*/
      dfe.static_air_temperature = 0.25*(float)ac_iq_header.Static_Air_Temp.Static_Air_Temp;

      //servo_data.rec_pitch_offset = (int)buffer4[31]/91.0;
      //servo_data.rec_roll_offset = (int)buffer4[32]/91.0;
      //servo_data.rec_elev_offset = (int)buffer4[33]/64.0;
      //servo_data.rec_pitch_error = (int)buffer4[34]/91.0;
      //servo_data.rec_roll_error = (int)buffer4[35]/91.0;
      //servo_data.rec_elev_error = (int)buffer4[36]/64.0;

      servo_data.rec_pitch_offset = 0.01098901*(float)ac_iq_header.Commanded_Pitch_Offset;
      servo_data.rec_roll_offset = 0.01098901*(float)ac_iq_header.Commanded_Roll_Offset;
      servo_data.rec_elev_offset = 0.015625*(float)ac_iq_header.Commanded_Elevation_Offset;
      servo_data.rec_pitch_error = 0.01098901*(float)ac_iq_header.Computed_Pitch_Error;
      servo_data.rec_roll_error = 0.01098901*(float)ac_iq_header.Computed_Roll_Error;
      servo_data.rec_elev_error = 0.015625*(float)ac_iq_header.Computed_Elevation_Error;
      servo_data.rec_pitch = pitch;
      servo_data.rec_roll = roll;
      servo_data.rec_hdg = t_head;

      // Try to read in the extra words...

      // Set a point to the extra words.

      extra_wds_ptr = (V1_Extra_Words_Type *)&ac_iq_header.Ext_Wd_Label;

      //sort out the extra words into specific arrays
      //********will need to revisit when the counts get added*****
      i = 0;

      exd_429_wds = NULL;
      if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x343239 ){  //"429"
         num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
         exd_429_wds = (EXD_429_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
         i += num_ext_word + 1;
      }

      exd_dis_wds = NULL;
      if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x444953 ){ //"DIS"
         num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
         exd_dis_wds = (EXD_DIS_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
         i += num_ext_word + 1;
      }

      exd_vcl_wds = NULL;
      if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x56434C ){ //"VCL"
         num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
         exd_vcl_wds = (EXD_VCL_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
         i += num_ext_word + 1;
      }

      exd_agc_wds = NULL;
      if( extra_wds_ptr->Ext_Wds[i]>>8 == 0x414743 ){ //"AGC"
         num_ext_word = (extra_wds_ptr->Ext_Wds[i]&0xff);
         exd_agc_wds = (EXD_AGC_WDS_TYPE *) &extra_wds_ptr->Ext_Wds[i];
         i += num_ext_word + 1;
      }
      // Do a check here.
      // i should equal extra_wds_ptr->EXD.Num_Ext_Wds - if not we gots a problem...



      // Test for accurate date time not equal to zero...

      extract_date_time(hms_UTC, (unsigned char *) ACdate, &dfe.date_time);
      dfe.date_time.milliseconds = time;

      /*
      lat = 19.5;
      lon = -153.0;
      t_head = 270.0;
      track = 270.0;
      bar_alt = 25000;
      gs_knots = 0.0;
      gspd = 0.0;
      airspeed = 0.0;
      */


      /*end decode ARINC data*/

      //****************continue from here***************
      //scan.ant_hdg = ((int)(buffer4[19]<<16)>>16 )* 0.015625;
      //scan.dsp_hdg_delta = ((int)buffer4[19]>>16)* 0.015625;

      //load up the 453 zero label
      wxrv.zero.label = 0;  //char
      wxrv.zero.date_time = 0x0; //long
      wxrv.zero.spare1 = 0x0; //long
      wxrv.zero.spare2 = 0x0; //char
      wxrv.zero.buffer_size = 0x2E; //char
      wxrv.zero.n = 0x2E;     //char
      //wxrv.zero.utc = ((buffer4[19]>>24) & 0xFF) |
      //                ((buffer4[19]>>8) & 0xFF00) |
      //                ((buffer4[19]<<8) & 0xFF0000) |
      //                0x68000000;//load utc to zero label 453 word

      //reverse UTC label for A453 data file
      temp_utc = (unsigned int *) &ac_iq_header.GPS_UTC_Course;
      wxrv.zero.utc = ((*temp_utc>>24) & 0xFF) |
                      ((*temp_utc>>8) & 0xFF00) |
                      ((*temp_utc<<8) & 0xFF0000) |
                      0x68000000;//load utc to zero label 453 word

      memset( wxrv.zero.spare3, 0x00, 45 * 4 );

      //if( ((buffer4[27] >> 29) & 0x3) == 0x3 )
      if( ac_iq_header.Static_Air_Temp.SSM == 0x3 )
      {   /*normal operation*/
         dfe.sat_valid_flag = 1;
      }
      else
      {
         dfe.sat_valid_flag = 0;
      }
      if( (wxrv.fp453 == NULL) && (status453 == OPEN453) )
      {  /*create filename453 from current UTC time*/
         filename453[0] = 0;
         hrs = (hms_UTC >> 16) & 0xFF;
         minutes = (hms_UTC >> 8) & 0xFF;
         sec = hms_UTC & 0xFF;
         sprintf( filename453, "%02d%02d%02d_p1%s.wxr", hrs, minutes, sec,
                               makeFilenameExtension );
         wxrv.fp453 = fopen(filename453, "wb");
         strcpy ( p1_453_file, filename453 ); // copy this filename

         sprintf( filename453, "%02d%02d%02d_p3%s.wxr", hrs, minutes, sec,
                               makeFilenameExtension );
	      wxrv.fp453_p3 = fopen(filename453, "wb");
         strcpy ( p3_453_file, filename453 ); // copy this filename

         fp453 = wxrv.fp453;
         fp453_p3 = wxrv.fp453_p3;

      }
      else if( (wxrv.fp453 != NULL) && (status453 == CLOSE453) )
      {
         fclose(wxrv.fp453);
         fclose(wxrv.fp453_p3);
         wxrv.fp453 = NULL;
         wxrv.fp453_p3 = NULL;
         fp453 = wxrv.fp453;/*global ptr to 453 file used in quitiqproc()*/
         fp453_p3 = wxrv.fp453_p3;
      }

      wxrv.centroid_debug = gui_var->centroids;


		/* Read IQ Block Data */
		//fread (buffer4, 4, 11, iqfp);

      //test code
      memcpy( buffer4, &ac_iq_header.Stabilized_Scan, 44 );

		/* Extract Date Info */
		//bytextract(buffer4[0], &IQdate[0],&IQdate[1],&IQdate[2],&IQdate[3]);
		//bytextract(buffer4[1], &IQdate[4],&IQdate[5],&IQdate[6],&IQdate[7]);
      if( ac_iq_header.Version == 1)
      {
         rec_stab_scan_angle = (float)ac_iq_header.Stabilized_Scan * 0.015625 * 0.5;
         rec_stab_elev_angle = (float)ac_iq_header.Stabilized_Elevation * 0.015625 * 0.5;
      }

		/* IQ Label */
		bytextract(buffer4[3], &IQlabel[0], &IQlabel[1], &IQlabel[2], &IQlabel[3]);
      IQlabel[4] = 0;
      IQlabel[3] = (char)(ac_iq_header.IQ_Label & 0xff);
      IQlabel[2] = (char)((ac_iq_header.IQ_Label >>8) & 0xff);
      IQlabel[1] = (char)((ac_iq_header.IQ_Label >>16) & 0xff);
      IQlabel[0] = (char)((ac_iq_header.IQ_Label >>24) & 0xff);

		/* Scan and Tilt Angles */
		//shortxtract( buffer4[5], &tilt_value, &scan_value );
      tilt_value = ac_iq_header.Tilt_Angle;
      scan_value = ac_iq_header.Scan_Angle;

      if( tilt_resolution > 0 )
         tilt_angle = (float)ac_iq_header.Tilt_Angle * 0.015625; //* 1/64
      else
		   tilt_angle = (float)tilt_value*0.25;//* 1/4

      scan_angle[0] = (float)scan_value * 0.015625; //*1.0f/64.0f;
      // Save the scan_angle here for making sure it is the one being compared for swp_dir_changes
      real_scan_angle = scan_angle[0];
      // Set the short range scan angle before affecting the short range scan angles - matches the box
      scan_angle[1] = scan_angle[0];

		/* Gate Delay and Range, Pulse Width, Number of PRF and Pulses */
		if( data_format != WRT2100 )
		{
			bytextract (buffer4[6], &dummy, &dummy, &range[2], &rcvr_delay);
			shortxtract (buffer4[6], &temp_short1, &dummy1);
         PWidth[0] = temp_short1;
			shortxtract (buffer4[10], &num_pulses[0], &num_prfs);
		}
		else if( (data_format == WRT2100) && (ac_iq_header.Version == 0) )
		{  /*new 2100 Data Format*/
			bytextract (buffer4[6], &dummy, &dummy, &dummy, &range[2]);
			shortxtract (buffer4[10], &dummy1, &num_prfs );
		}
		else if( (data_format == WRT2100) && (ac_iq_header.Version == 1) )
      {  /*MultiScan V2.0 Data*/
         binwidth = ac_iq_header.Bin_Width;
         rcvr_delay = ac_iq_header.Receiver_Delay;
         num_prfs = ac_iq_header.Number_of_prfs;
      }

      //antenna mode
      strcpy(&antenna_mode, ac_iq_header.Antenna_Mode);

		/* Sweep Information */
		//bytextract (buffer4[8], &SweepSpd, &SweepDir, &SweepRange, &Azimuth);

      SweepSpd = ac_iq_header.Sweep_Speed;
      SweepDir = ac_iq_header.Sweep_Direction;
      SweepRange = ac_iq_header.Sweep_Range;
      Azimuth = ac_iq_header.Center_Azimuth;

      // This is the correction we used for SB4 Data (Version 0 data)
      if( ac_iq_header.Version == 0 ){
         if(SweepDir == 0x00) // L_R
            scan_angle[0] += 0.25; //GuiProcData.scan_angle_shift;
         else if(SweepDir == 0xFF) // R_L
            scan_angle[0] -= 0.25; //GuiProcData.scan_angle_shift;
      }

      // Test code to still allow adjustments from the GUI
      if(SweepDir == 0x00) // L_R
         scan_angle[0] += GuiProcData.IQProcShift; //GuiProcData.scan_angle_shift;
      else if(SweepDir == 0xFF) // R_L
         scan_angle[0] -= GuiProcData.IQProcShift; //GuiProcData.scan_angle_shift;

      scan.speed = SweepSpd;
      scan.dir = SweepDir;
      scan.raw_angle = scan_angle[0];
      /*1/32 scan angle error injection*/


      //L_R shift adder for short range scan angle
      if( SweepDir == 0x00 ) //L_R
         scan_angle[1] -= 0.25; //FROM RADAR
      else if( SweepDir == 0xFF ) //R_L
         scan_angle[1] += 0.25; //FROM RADAR

		/* Bar Information */
      if( ac_iq_header.Version != 1 )
		   bytextract (buffer4[9], &Polar, &EOS, &CurBar, &TotalBar);
      else
      {
         EOS = ac_iq_header.End_of_Sweep;
         CurBar = ac_iq_header.Current_Bar;
         TotalBar = ac_iq_header.Total_Bars;
      }
      /*
		if (CurBar == 0)
		{
			++az_cnt;
			fseek (iqfp, byte_cntr, SEEK_SET);
		//	continue;
		}
		else
		{
      	if (PrevBar == 0)
			{
            //Not sure what this does, but it make tool and radar look the same.
				init_mode[0] = 255;
            init_mode[1] = 255;
			}
      }
      */
		bytes_read = 44;

      //grid test
      //tilt_angle = -0.01627 * sqrt(bar_alt);
      //if( CurBar == 2 )
      //   tilt_angle += 2.125;
      //*************************************

		/*load up values to be stored in array, then passed out*/
		if(first_pass < 10 )
		{  /*set prev_tilt_angle on the first few epochs of this sweep*/
			prev_tilt_angle = tilt_angle;
			prev_range = (float)range[2] * 5;
			prev_num_pulses[0] = num_pulses[0];
			prev_num_prfs = num_prfs;
			prev_num_pulses[1] = num_pulses[1];
			prev_rcvr_delay = rcvr_delay;
			*bar = CurBar;
         display_scan_direction = scan_direction;
			first_pass++;

         if( CurBar == 2 )
         {
            upper_tilt = tilt_angle;
            dfe.upper_tilt = tilt_angle;
            //memset(plane_out + 2*MAX_BINS_X_2*MAX_BINS_X_2, 0, MAX_BINS_X_2 * MAX_BINS_X_2 * 4 );
         }
         else if( CurBar == 1 )
         {
            //memset(plane_out + 1*MAX_BINS_X_2*MAX_BINS_X_2, 0, MAX_BINS_X_2 * MAX_BINS_X_2 * 4 );
            lower_tilt = tilt_angle;
            dfe.lower_tilt = tilt_angle;
         }
		}


        readPRF ( num_prfs, data_format, num_pulses, bin, PWidth, freq_code, phase,  I, Q, STC, buffer4, &bytes_read) ;



		/* Move pointer to end of block */
		++az_cnt;

      /*set prev_scan_direction*/
      // I don't think this should be done here...
      //prev_scan_direction = scan_direction;

      plane_num = CurBar;
      if( data_format == WRT2100 )
         max_bar = 3;
      else
         max_bar = 6;

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


      // Let's set new_scan differently for different data version types...
      //if(ac_iq_header.Version == 1){

      if((new_scan == TRUE) && (ac_iq_header.End_of_Sweep == 255 ))
         new_scan = TRUE;
      else{

         if ((ac_iq_header.End_of_Sweep == 0 ) && ( OldEndOfSweep == 255 ))
            new_scan = TRUE;
         else
            new_scan = FALSE;
      }
         OldEndOfSweep = ac_iq_header.End_of_Sweep;
      //}

      // Test code
      if (new_scan)
         num_scans++;


      // Switch Center for Deciding for Switching to a New Sweep
      // States
      // Manual Mode
      // Multiscan Mode
      // Multiscan Mode






         
      if(((CurBar > 3) && (CurBar < 127)) && (first_dspm_call == FALSE)){

         data_to_dspm.first_dspm_call = first_dspm_call;
         data_to_dspm.new_scan = new_scan;
         data_to_dspm.scan_angle_adjustment = 0;//scan_angle_adjustment,
         data_to_dspm.scan_dir = sw_dir;
         data_to_dspm.db = &big_db[0][0];
         data_to_dspm.cur_bar = plane_num;
         data_to_dspm.total_bars = TotalBar;
         data_to_dspm.s_s_beta = s_s_beta;
         data_to_dspm.compass_rose_on = compass_rose_on;
         data_to_dspm.apply_harsh_edit = apply_harsh_edit;
         data_to_dspm.manual_gain = manual_gain;
         data_to_dspm.gcs = gcs;
         data_to_dspm.mode = mode;
         data_to_dspm.track = track;
         data_to_dspm.heading = t_head;
         data_to_dspm.drift_angle = drift_angle;
         data_to_dspm.average_ground_speed = avg_gs_knots;
         data_to_dspm.ground_speed = gs_knots;
         data_to_dspm.display_range = new_range*5;
         data_to_dspm.tilt_angle = (double) tilt_angle;
         data_to_dspm.baro_alt = bar_alt;
         data_to_dspm.coeff_const_offset = coeff_const_offset;
         data_to_dspm.plane = plane_out;
         data_to_dspm.rb_total = rb_total;
         data_to_dspm.rad_alt = rad_alt;
         data_to_dspm.rad_alt_valid = rad_alt_valid;
         data_to_dspm.res_constant = res_constant;
         data_to_dspm.filtered_scan_angle = filtered_scan_angle;
         data_to_dspm.comp_alt_offset = comp_alt_offset;
         data_to_dspm.stc = STC[0];
         data_to_dspm.time_string = time_string;
         data_to_dspm.iq_version = ac_iq_header.Version;
         data_to_dspm.eos = ac_iq_header.End_of_Sweep;

         dspm_main(  &data_to_dspm,
                     &rot_tran,
                     &dfe,
                     &servo_data,
                     &wxrv,
                     &terr_max,
                     &vert_swp,
                     &clutter_calc_data );
         // */
         vert_swp.prev_rad_vert = 1;
         vert_swp.scan_angle = scan_angle[0];
         vert_swp.first_vert_rad = 0;
         new_scan = 0;
      }


      if ( ((CurBar == 127) || (ac_iq_header.End_of_Sweep)) &&
            (first_dspm_call == FALSE)){

         data_to_dspm.first_dspm_call = first_dspm_call;
         data_to_dspm.new_scan = new_scan;
         data_to_dspm.scan_angle_adjustment = 0;//scan_angle_adjustment,
         data_to_dspm.scan_dir = sw_dir;
         data_to_dspm.db = &big_db[0][0];
         data_to_dspm.cur_bar = plane_num;
         data_to_dspm.total_bars = TotalBar;
         data_to_dspm.s_s_beta = s_s_beta;
         data_to_dspm.compass_rose_on = compass_rose_on;
         data_to_dspm.apply_harsh_edit = apply_harsh_edit;
         data_to_dspm.manual_gain = manual_gain;
         data_to_dspm.gcs = gcs;
         data_to_dspm.mode = mode;
         data_to_dspm.track = track;
         data_to_dspm.heading = t_head;
         data_to_dspm.drift_angle = drift_angle;
         data_to_dspm.average_ground_speed = avg_gs_knots;
         data_to_dspm.ground_speed = gs_knots;
         data_to_dspm.display_range = new_range*5;
         data_to_dspm.tilt_angle = (double) tilt_angle;
         data_to_dspm.baro_alt = bar_alt;
         data_to_dspm.coeff_const_offset = coeff_const_offset;
         data_to_dspm.plane = plane_out;
         data_to_dspm.rb_total = rb_total;
         data_to_dspm.rad_alt = rad_alt;
         data_to_dspm.rad_alt_valid = rad_alt_valid;
         data_to_dspm.res_constant = res_constant;
         data_to_dspm.filtered_scan_angle = filtered_scan_angle;   // this is setting a pointer to the iqproc array
         data_to_dspm.comp_alt_offset = comp_alt_offset;
         data_to_dspm.stc = STC[0];
         data_to_dspm.time_string = time_string;
         data_to_dspm.iq_version = ac_iq_header.Version;
         data_to_dspm.eos = ac_iq_header.End_of_Sweep;

         dspm_main(  &data_to_dspm,
                     &rot_tran,
                     &dfe,
                     &servo_data,
                     &wxrv,
                     &terr_max,
                     &vert_swp,
                     &clutter_calc_data );
      }

      if( (CurBar >= 0) &&
          (CurBar <= max_bar) &&
          (data_format == WRT2100) &&
          (fabs(real_scan_angle) <= 90.0) )
      {  /*start wx process loop*/

         estimates_available = 1;
         roll_angle = roll;
         heading_angle = t_head;
         antenna_sat_flag = 0;  //add code to set antenna_sat_flag correctly
         servo_data.maneuver_flag = (unsigned int) get_maneuver_flag( estimates_available,
                                          roll_angle,
                                          heading_angle,
                                          antenna_sat_flag);

      //  setFlightPathThreat(&data_to_dspm.flight_pta,hrs, minutes, sec , air_gnd_disc); //

         for( prf_index = 0; prf_index < num_prfs; ++prf_index )
         {
         if( (prf_index == 0) || (!short_range_bins_256) )
               rb_total = 512; /*long range or old (< 04/09/01) data set*/
            else
               rb_total = 256; /*short range data set*/

            dfe.iq_proc_scan_num = num_scans;



            sb4_phi_low = wx_proc1( range[prf_index],
                      noise_floor,
                      init_mode[prf_index],
                      I[prf_index],
                      Q[prf_index],
                      power[prf_index],
                      r1mag[prf_index],
                      r2mag[prf_index],
                      bin[prf_index],
                      rb_total,
                      prf_index,
                      num_prfs,
                      scan_cnt,
                      SweepSpd,
                      STC[prf_index],
                      &terr_max,
                      bar_alt,
                      (int) scan_direction,
                      new_scan,
                      CurBar,
                      air_gnd_disc,
                      &flight_phase,
                      &fp_calc,
                      &data_to_dspm.flight_pta);   //add first time call to reset flight phase parameters

            //output V2.0 phi_low vs sb4_phi_low
            if( (prf_index == 0) && new_scan && GuiProcData.Test4 )
            {
               sprintf( tmp_str,"phi_low_" );
               fpt = fopen( getFilename(tmp_str, file_name), "a+t");
               //scan count - baro alt - rec low tilt - calc sb4 low tilt - calc V2 low tilt, flight phase

               fprintf(fpt,"%d\t %f\t %f\t %f\t %f\t %f\t %\n", scan_cnt, bar_alt, lower_tilt, sb4_phi_low, terr_max.phi_low, flight_phase );
               fclose(fpt);
            }
            //end output V2.0 phi_low vs sb4_phi_low

            if( (prf_index == 0) && (File_Writes.record_on_iq_proc))
            {
               sprintf( tmp_str,"pwr_out_%d_", scan_cnt );
               fpt = fopen( getFilename(tmp_str, file_name), "a+t");

               fprintf(fpt,"%f\t",scan_angle[prf_index]);
               for (i = 0; i < 512; i++)
               {
                  fprintf(fpt,"%f\t",power[prf_index][i]);
               }
               fprintf(fpt,"%\n");
               fclose(fpt);
            }
            // */

            scan.raw_angle = scan_angle[prf_index]; //filtered_scan_angle[0];

            /* This factor converts m/s to g's  */
            /* Limit airspeed used to >= 100kts */

            //////////////////// TURB call goes to DSP2  ///////////////////////////////
            cturb_factor = (0.045 - 9.37e-17 * (bar_alt * bar_alt * bar_alt)) *
               (KTS_TO_MS * max(airspeed, 100.0))/(min(3.57e-3 * bar_alt + 119.15, 231));


            sigma_turb =  1.00 * cturb_factor * TURB_BB_CONST * airspeed * sin(scan_angle[prf_index] * RAD_PER_DEG); //VAS
            //////////////////////////////////////////////////////////////////////////




            wx_proc2( (int)range[prf_index],
                      noise_floor,
                      noise_adjust,
                      power[prf_index],
                      STC[prf_index],
                      r1mag[prf_index],
                      r2mag[prf_index],
                      db[prf_index],
                      sdev[prf_index],
                      init_mode[prf_index],
                      (int)bin[prf_index],
                      (int)prf_index,
                      (int)num_prfs,
                      SweepSpd,
                      test[prf_index],
                      sigma_turb,
                      bar_alt,
                      (float)comp_alt_offset,
                      TotalBar,
                      CurBar,
                      &scan_angle[prf_index],
                      airspeed,
                      &turb_para,
                      cturb_factor,
                      &data_to_dspm.flight_pta); //scan angle is lagged by 5 sweeps

            
            // */
            scan_adder = scan_angle_adjustment;//0.0;

            if( SweepDir == 0x00 ) //L_R
            {
               filtered_scan_angle[prf_index] = scan_adder;
            }
            else if( SweepDir == 0xFF ) //R_L
            {
               filtered_scan_angle[prf_index] = -scan_adder;
            }

            filtered_scan_angle[prf_index] += scan_angle[prf_index];
            
            memset( big_db[prf_index], 0, 512 * sizeof(unsigned long int) );

            /*copy db directly to db_big for tran_rot*/
            /*short range data has 256 bins, data newer than 04/09/01 10:00:00AM*/
            if( rb_total == 256 )
            {  /* copy 244 bins into 512*/
               for( i = (rb_total - bin[prf_index]); i < rb_total; i++ )
               {
                  big_db[prf_index][i * 2]     = db[prf_index][i - (rb_total - bin[prf_index])];
                  big_db[prf_index][i * 2 + 1] = db[prf_index][i - (rb_total - bin[prf_index])];
               }
            }
            else
            {  /*504 or so bins into 512*/
               for( i = (rb_total - bin[prf_index]); i < rb_total; i++ )
                  big_db[prf_index][i] = db[prf_index][i - (rb_total - bin[prf_index])];
            }
         }/*end wx process loop*/

         if (first_dspm_call)
         {  /*new file or foundNewTime, initialize previous parameters*/
            prev_time = 0;
            prev_t_head = 0.0f;
            prev_gs_knots = 0.0f;
            cumulative_delta_hdg = 0.0f;
            //delta_sec = 0.00f;
            delta_hdg = 0.0;
            avg_gs_knots = 0.0;
         }

         if(prev_t_head != 0.0f)
         {  /*calc delta heading*/
            delta_hdg = t_head - prev_t_head;
            cumulative_delta_hdg += delta_hdg;
         }

         if( prev_gs_knots != 0.0f)
            /*calc delta gspd*/
            avg_gs_knots = (gs_knots + prev_gs_knots) / 2;

         if( rotate_translate == 0 )
         {  /*no rotation or translation will be performed*/
            //delta_sec = 0.00f;
            delta_hdg = 0.0;
            avg_gs_knots = 0.0;
         }

         if (first_dspm_call)
            scan_direction = SCAN_UNKNOWN_DIRECTION;

         if( prev_scan_angle != 999 )
         {  /*this is the first epoch*/
            if( SweepDir == 0x0 )
               scan_direction = SCAN_LEFT_TO_RIGHT;
            else if( SweepDir == 0xFF )
               scan_direction = SCAN_RIGHT_TO_LEFT;

            if (prev_scan_direction == SCAN_UNKNOWN_DIRECTION)
               prev_scan_direction = scan_direction;
         }

         //if( (prev_scan_direction == scan_direction) &&
         //    (real_scan_angle != prev_scan_angle) && (data_format == WRT2100) )
             //((scan_angle[0] != prev_scan_angle) || (data_format == WRT2100)) &&
             //angle_status )
         //{
            /*initialize the wxr(453) control data struct*/
 	         wxrv.ctrl.label_1_8 = 0xB4;
     	      wxrv.ctrl.ctrl_accept_9_10 = IND_1;
            if( TotalBar > 1 )
               wxrv.ctrl.ctrl_accept_9_10 = ALL;
				wxrv.ctrl.status_11_19.slave_11 = 0x0;
				wxrv.ctrl.status_11_19.spare_12 = 0x0;
				wxrv.ctrl.status_11_19.spare_13 = 0x0;
				wxrv.ctrl.status_11_19.turb_alert_14 = 0x0;
            if( TotalBar > 1 )
                /*auto mode*/
  					wxrv.ctrl.status_11_19.precip_alert_15 = 0x1;
            else
               /*manual mode*/
               wxrv.ctrl.status_11_19.precip_alert_15 = 0x0;
				wxrv.ctrl.status_11_19.ident_16 = gcs;
            wxrv.ctrl.status_11_19.sector_17 = 0x0;
				wxrv.ctrl.status_11_19.stab_sat_18 = 0x0;
				wxrv.ctrl.status_11_19.erase_19 = 0x0;
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
 				stuff_tilt_angle( temp_flt, &wxrv.ctrl );/*set tilt bits 30 - 36*/
 				wxrv.ctrl.gain_37_42 = manual_gain;
 				wxrv.ctrl.range_43_48 = new_range;
 				wxrv.ctrl.spare_49 = 0x0;

            wxrv.ctrl.data_accept_50_51 = IND_1;
            if( TotalBar > 1 )
               wxrv.ctrl.data_accept_50_51 = ALL;
            if( angle_status != 1 )
               //angle_status is BAD
 				   wxrv.ctrl.faults_20_25 = 0x10;

            /*stuff scan anlge bits 52 - 63 with fitlered scan angle is done in
              the rotate_and_translate() routine*/
 				wxrv.ctrl.spare_64 = 0x0;

            sw_dir = scan_direction;


            data_to_dspm.first_dspm_call = first_dspm_call;
            data_to_dspm.new_scan = new_scan;
            data_to_dspm.scan_angle_adjustment = 0; //scan_angle_adjustment,
            data_to_dspm.scan_dir = sw_dir;
            data_to_dspm.db = &big_db[0][0];
            data_to_dspm.cur_bar = plane_num;
            data_to_dspm.total_bars = TotalBar;
            data_to_dspm.s_s_beta = s_s_beta;
            data_to_dspm.compass_rose_on = compass_rose_on;
            data_to_dspm.apply_harsh_edit = apply_harsh_edit;
            data_to_dspm.manual_gain = manual_gain;
            data_to_dspm.gcs = gcs;
            data_to_dspm.mode = mode;
            data_to_dspm.track = track;
            data_to_dspm.heading = t_head;
            data_to_dspm.drift_angle = drift_angle;
            data_to_dspm.average_ground_speed = avg_gs_knots;
            data_to_dspm.ground_speed = gs_knots;
            data_to_dspm.display_range = new_range*5;
            data_to_dspm.tilt_angle = (double) tilt_angle;
            data_to_dspm.baro_alt = bar_alt;
            data_to_dspm.coeff_const_offset = coeff_const_offset;
            data_to_dspm.plane = plane_out;
            data_to_dspm.rb_total = rb_total;
            data_to_dspm.rad_alt = rad_alt;
            data_to_dspm.rad_alt_valid = rad_alt_valid;
            data_to_dspm.res_constant = res_constant;
            data_to_dspm.filtered_scan_angle = filtered_scan_angle;
            data_to_dspm.comp_alt_offset = comp_alt_offset;
            data_to_dspm.stc = STC[0];
            data_to_dspm.time_string = time_string;
            data_to_dspm.iq_version = ac_iq_header.Version;
            data_to_dspm.eos = ac_iq_header.End_of_Sweep;

            dspm_main(  &data_to_dspm,
                        &rot_tran,
                        &dfe,
                        &servo_data,
                        &wxrv,
                        &terr_max,
                        &vert_swp,
                        &clutter_calc_data );


            vert_swp.prev_rad_vert = 0;
            vert_swp.first_vert_rad = 1;
            first_dspm_call = FALSE;

            init_mode[0] = 0;
            init_mode[1] = 0;
            new_scan = 0;
			//}
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
		prev_scan_angle = real_scan_angle; //scan_angle[0];
      prev_scan_direction = scan_direction;
	}

   if( ((SweepDir == 0xFF) && (scan_direction == SCAN_LEFT_TO_RIGHT) ) || ((SweepDir == 0x0) && (scan_direction == SCAN_RIGHT_TO_LEFT) ))
   {
      if(SweepDir == 0xFF)
         scan_direction = SCAN_RIGHT_TO_LEFT;
      else if(SweepDir == 0x0)
         scan_direction = SCAN_LEFT_TO_RIGHT;
   }

   scan_cnt++;

	/*load feadback to labview*/
	if(track < 0)
                gui_var->track = track + 360;/*make it 0 to 360*/
        else
                gui_var->track = track;

    gui_var->heading = t_head;
    gui_var->baro_alt = bar_alt;
    gui_var->lat = lat;
    gui_var->lon = lon;
    gui_var->utc = (double)hms_UTC;
    gui_var->gs_knots = gs_knots;
    gui_var->g_speed = gspd; /* meters/sec*/
    gui_var->pitch = pitch;
    gui_var->roll = roll;
    gui_var->cd_hdg = cumulative_delta_hdg;
    gui_var->man_alt = man_alt_offset;
    gui_var->comp_alt = comp_alt_offset;
    gui_var->static_air_temp = dfe.static_air_temperature;
    gui_var->merge_alt = bar_alt + comp_alt_offset;
    gui_var->format = (master_mode[1] | (master_mode[2] << 8) );
    gui_var->total_bar = (double)TotalBar;
    gui_var->bar = (double)*bar;
    gui_var->rad_alt = rad_alt;
    gui_var->tilt = prev_tilt_angle;
    gui_var->gate_delay = (double)prev_rcvr_delay;
    gui_var->prev_num_pulses = (double)prev_num_pulses[0];
    gui_var->prfs = (double)prev_num_prfs;
    gui_var->vert_scan_angle = (double)vert_swp.scan_angle;  // Added this 030407 per Greg for outputting to the labview interface
    gui_var->range = prev_range;
    gui_var->display_scan_direction = (float)display_scan_direction;
    gui_var->scan_direction = (float)scan_direction;
    gui_var->pulses = num_pulses[1];
    gui_var->d_tilt = dfe.upper_tilt - dfe.lower_tilt;
    gui_var->bytes_read = byte_cntr;
    gui_var->length = length;

    setGuiFromServo( gui_var, &servo_data);


    GuiProcData.PrevTilt = prev_tilt_angle;

   return GOOD;
}


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
/* lesser displayed range.  																	*/
/* old_range = range of the collected data, old_dbz.									*/
/*	new_range = range for new_dbz data 														*/
/* old_dbz = 320 or 40 nm range dbz data													*/
/* new_dbz = range interpolated data														*/
/*																										*/
/* NOTE: Only call this procedure with WXR2100 data!!!								*/
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

void _export quitiqproc( void )
{
	fclose(iqfp);
   fclose(fp453);
   fp453 = NULL;
}

void closewxrs ()
{
  fclose(wxrv.fp453);
  fclose(wxrv.fp453_p3);
  fclose (iqfp);
  wxrv.fp453 = NULL;
  wxrv.fp453_p3 = NULL;
  iqfp = NULL;
  //fclose (fp453);
  //fp453 = NULL;
}

long int startiqproc(char *filename)
{
	short int i;
	short int save;//, new_disk;
	short int fp_disk;
	short int ndx;
   char line [255];
   char dirName [255];

	long int done;
	unsigned long int data_file_size;
   long int handle;

	char gcsfilename[13];
   char disk;
   char bar;

   struct _finddata_t ffblk;

	first_dspm_call = TRUE;

	for (i=0; i<13; ++i)
	{
		gcsfilename[i] = 0;
	}

	/* Open the file */
        if ( (openFile( filename, disk )) == FILE_ERROR )
	{
                sprintf (line, "Could not open file %s", filename );
                MessageBox (0, line, 0, 0);
		exit(1);
	}

	/* Constructing File names */
	ndx = 0;
	for (i=29; i>=0; --i)
	{	if ((filename[i] == 46)||((ndx < 9)&&(ndx >= 1)))
		{  ++ndx;
			gcsfilename[strlen(filename) - 3 -ndx] = filename[i];
		}
		if (ndx == 0)
			continue;	// for loop
	}

	strncat (gcsfilename, "g", 1);

	/* Calculate file size */
	data_file_size = filelength(fileno(iqfp));
   return data_file_size;
}

/******************************************************************************/
/* Moves file pointer to the data specified by goto_time.                     */
int findNewTime( unsigned long int goto_time )
{
        unsigned long int temp_array[32];
        int done = 0;
		  int error = 0;
        unsigned long Month_Day_Year;

        first_dspm_call = TRUE;

        findAC( iqfp );
        fread(temp_array, 4, 32, iqfp);
        if( (goto_time < temp_array[2]) )
                /*go back to start of data file*/
                fseek( iqfp, 0, SEEK_SET );

        while( !done )
        {
                findAC( iqfp );
                fread(temp_array, 4, 32, iqfp);
                if( goto_time < temp_array[2])
                {
                        //go back to beginning of block and exit
                        fseek( iqfp, -32*4, SEEK_CUR);
                        done = 1;
                }
                else
                {       //fseek to next block
                        if( fseek( iqfp, temp_array[4] - 32*4, SEEK_CUR ) != 0 )
                        {
                                error = 1; // probably end of file
                                done = 1;
                        }
					 }
        }
        return error;
}

/*Looking for the A/C label in -512 increments from end-of-file.  Returns milliseconds
passed midnight from AC Data Block*/
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
   return_time = temp_array[2]; // Initialize return_time
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
}

enum ERROR_CODE openFile( char *filename, char disk_char )
{
	/* Open the file */
	if ((iqfp = fopen(filename, "rb")) == NULL)
     return FILE_ERROR;
	else
     return GOOD;
}
/******************************************************************************/

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

int info_to_next_l_r( long int *r_l_epoch_ptr, FILE *fp, long int *l_r_start )
{
   int r_l_cnt = 0;
   unsigned char sweep_dir = 0x1;//0;//
   unsigned long int buffer[128];
   unsigned char dummy;
   unsigned char curbar = 1;
   unsigned char eos = 0;
   long int temp;
   long int temp1;

   memset( buffer, 0, 512);

   while( (sweep_dir != 0x00) )//(sweep_dir == 0) )//
   {  //not end_of_sweep
      findAC( fp );

      //chk sweep direction
      temp = ftell( fp );
      fseek(fp, 512, SEEK_CUR );
      fread( buffer, 4, 11 , fp );
		bytextract (buffer[8], &dummy, &sweep_dir, &dummy, &dummy);
		bytextract (buffer[9], &dummy, &eos, &curbar, &dummy);

      if( (sweep_dir == 0x00))// || (curbar != 1) )//sweep_dir != 0 )//
      {  //end_of_sweep
         fseek(fp, temp, SEEK_SET );
         *l_r_start = temp;
      }
      else
      {  //save pointer to start of r_l epoch
        *(r_l_epoch_ptr + r_l_cnt) = temp;
         r_l_cnt++;
      }
   }
   return r_l_cnt-1;
}

/* Checks to see that data block length is between 1536 and 68096. */
short int lengthchk( FILE *fp, unsigned long length, unsigned long *byte_cntr,
							long int *bytes_read, unsigned int *az_cnt )
{
	unsigned int indx_loc;
	short int len_chk = 0;
        char line [255];
	if (length > 68096) //5632)
	{
		if (length != 134144l)
		{
                        sprintf (line, "Bad block size : %u ", length );
                        MessageBox (0, line, 0, 0);
                        printf ("\n*****   Bad block size:  %u   *****", length);
			printf ("\n		 attempt to search for next block	");
			*bytes_read = ftell(fp);
			indx_loc = id_size(fp);
			fseek (fp, (indx_loc)+*bytes_read-12, SEEK_SET);
		}
		else
			fseek (fp, 134060l, SEEK_CUR);		// 134060=134144bytes blocksize-84bytes read
		*az_cnt+=1;
		*byte_cntr += length;
	}
	else if (length < 1024)
	{
                sprintf (line, "Bad block size : %u ", length );
                MessageBox (0, line, 0, 0);
		printf ("\n*****   Bad block size:  %ld   *****", length);
		printf ("\n		 attempt to search for next block	");
		*bytes_read = ftell(fp);
		indx_loc = id_size(fp);
		fseek (fp, (indx_loc)+*bytes_read-12, SEEK_SET);
		*az_cnt+=1;
		*byte_cntr += length;
	}
	else
		len_chk = 0xff;

   return len_chk;
}

void readPRF (
int  num_prfs, int data_format, int *num_pulses, int *bin, ushort *PWidth,
ulong freq_code[MAX_PRF_SETS][max_pulses][3],
ulong phase[MAX_PRF_SETS][max_pulses][3],
short int I[MAX_PRF_SETS][max_pulses * max_range_bin],
short int Q[MAX_PRF_SETS][max_pulses * max_range_bin],
ulong STC[MAX_PRF_SETS][max_range_bin],
ulong *buffer4,
long *bytes_read)



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

       if( data_format == WRT2100 ) {


 	for (prf_index=0; prf_index < num_prfs; ++prf_index)
		{

				fread (buffer4, 4, 1, iqfp);
				shortxtract (buffer4[0], &temp_short1, &idummy1);
                                current_prf[prf_index] = temp_short1;
				bytextract (buffer4[0], &cdummy, &cdummy, &cdummy, &temp_char1);
                                num_pulses[prf_index] = temp_char1;

			for (pulse_index=0; pulse_index < num_pulses[prf_index]; ++pulse_index)
			{

					fread (buffer4, 4, 5, iqfp);
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


                                fread (buffer4, 4, bin[prf_index], iqfp); /*read the  IQ block*/

				if (pulse_index < max_pulses)  /*make sure we don't overfill the array*/
				{
                                   k = (pulse_index*bin[prf_index]);
					for( i = 0; i < (bin[prf_index]); ++i )
						shortxtract( buffer4[i],&Q[prf_index][k+i],&I[prf_index][k+i]);


				}
			}/*end of pulse_index loop*/

			*bytes_read += 8 + (4*bin[prf_index]);
			fread( STC[prf_index], 4, bin[prf_index], iqfp );
			*bytes_read += 4*bin[prf_index];
		}/*end of prf_index loop*/

         }
         else {

              for (prf_index=0; prf_index < num_prfs; ++prf_index)
		 {
 			for (pulse_index=0; pulse_index < num_pulses[prf_index]; ++pulse_index)
			{
       					fread (buffer4, 4, 2, iqfp);
					shortxtract (buffer4[0], &idummy1, &temp_short1);
                                        current_prf[prf_index] = temp_short1;
					bytextract (buffer4[0], &ant_switch_st, &temp_char1, &cdummy, &cdummy);
                                        bin[prf_index] = temp_char1;
					bin[prf_index]+=(char)1;/*add on eto bin count if old data. CJD can explain.*/
					freq_code[prf_index][pulse_index][0] = buffer4[1];

                                fread (buffer4, 4, bin[prf_index], iqfp); /*read the  IQ block*/

				if (pulse_index < max_pulses)  /*make sure we don't overfill the array*/
				{
                                k = (pulse_index*bin[prf_index]);
					for( i = 0; i < (bin[prf_index]); ++i )
						shortxtract( buffer4[i],&Q[prf_index][k+i],&I[prf_index][k+i]);

      				}
			}/*end of pulse_index loop*/

			*bytes_read += 8 + (4*bin[prf_index]);
			fread( STC[prf_index], 4, bin[prf_index], iqfp );
			*bytes_read += 4*bin[prf_index];
		}/*end of prf_index loop*/

         }
 }

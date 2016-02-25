/*-----------------------------------------------------------------------------
 **
 ** © Copyright 2010 All Rights Reserved
 ** Rockwell Collins, Inc. Proprietary Information
 **
 ** Header File:   vert_feature.c
 **
 ** Description:   This file contains all the routines used for hazard assessment
 **
 ** $Id: vert_features.c 615 2010-05-06 22:11:49Z amterry $
 **----------------------------------------------------------------------------
 */

/*----------------------------------------------------------------------------
 **                  Include Files
 **----------------------------------------------------------------------------
 */


#include <stdlib.h>
#include <stdio.h>
#include <sys\stat.h>
#include <mem.h>                                  /*needed for memset*/
#include <string.h>
#include <math.h>
#include <fcntl.h>
#include "auxiliary_threat_features.h"
#include "geograph.h"                             // needed to access climate structure

#include "defines.h"
#include "vert_features.h"
#include "units.h"
#include "utilities.h"
#include "IQ_Proc.h"
#include "dspm_defines.h"
#include "version.h"
#include "aux_vert_correlate.h"

FILE *vfe_log = NULL;
FILE *vfe_sri = NULL;
FILE *vfe_lri = NULL;
FILE *vfe_bin = NULL;

int VFE_debug = 1;
int log_VS_image = 0;
char VS_vers[32] = "VS_1.0";


CELL_INFO_TYPE VFE_cell_info;


float PC_dbz_input[PC_Y][PC_X];                   //  use sr resolution  -- move the cell to left hand edge



void set_binfo_hdr(BINFO_HDR *bhdr, int btype)
{


bhdr->magic_id = SIM_DATA_KEY;  // just to mark the boudary
bhdr->type = btype;  // just to mark the boudary

   switch (btype) {
      case BI_VS_SR_IMG:
         bhdr->nbytes =  (120 * 256 * 4);
         break;

      case BI_VS_LR_IMG:
         bhdr->nbytes =  (120 * 185 * 4);
         break;

      case   BI_VS_FEATS:
         bhdr->nbytes =  sizeof(VFE_FEAT_TYPE);
         break;

      default: // not known break;
         break;
   }

}

void vert_fe_write (    AUX_SCAN_TYPE *aux_scan, 
               AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe, 
		                   AC_INFO_TYPE *ac_info, 
		                  VFE_FEAT_TYPE *vfe_info, 
		                 CELL_INFO_TYPE *cell_info ,  
		                          float *sr_dbz_img, 
		                          float *lr_dbz_img)
{
   //  this function is for debug only -- 
   //  write out vert sweep dbz arrays for WAT processing
   //  time of sweep - ac_posn - cell_posn -- azimuth of the sweep
   //  csv ints ?
 
   static int vfe_wc = 0;
   char time_string[32];
   char vs_id[64];
   VERT_FE_TYPE *vert_fe  = &aux_cell_vert_fe->data[0];
   int rai;   
   int k,j;
   int ele;
   float f_imgval;
   float *srfp = sr_dbz_img;
   float *lrfp = lr_dbz_img;
   float range_nm = vfe_info->range_nm;
   BINFO_HDR bhdr;
   long ft;
   int kw;
   int nir;
   static int bin_wrt_error = 0;
   AUX_CORRELATION_TYPE correlation_results;

   // We'll call this correlation function here.  It's called in auxiliary_threat_features.c
   // also, but we won't worry about that for right now.
   correlation_results = aux_vert_corr(cell_info->cell_id, cell_info->centroid_loc.lat , cell_info->centroid_loc.lon , ac_info );

   if (File_Writes.aux_vert) {
      log_VS_image =1;
   }
   
   if (vfe_log == NULL) {
      vfe_log = fopen(getFilename("vfe_log",IQ_file.path), "w");
      fprintf(vfe_log,"\n cell_id,time,tos,lat,lng,sr,er,n_scans,n_epochs,n_vsweeps\n");
      fprintf(vfe_log,"\n\n alt,tempC,peak_dbz,peak_dbz_rnm,peak_var,peak_grad,DBZ_25_min_range,DBZ_25_max_range,\n\n");
   }

   if (  (log_VS_image) && 
         (vfe_lri == NULL) ) {


     if ( log_VS_image  && vfe_lri == NULL) {


      vfe_lri = fopen(getFilename("vfe_IMG",IQ_file.path), "w");
      fprintf(vfe_lri,"%s,%s\n",VS_vers,sim2100_rev);
      fprintf(vfe_lri,"HH:MM:SS,secSinceMidnight,acHdg,acAlt,sat,auto_mode,windShearState,totalbars,currBar,Azimuth,ERIB,scanN,cell_id_iq,cell_id_corr,cell_corr_rng,cell_corr_status,cell_lat,cell_lng,range,start_range,end_range,bearing,ac_lat,ac_lng\n");

      fprintf(vfe_lri,"SRI 120 x 256, LRI 120 x 185 \n");
      
      vfe_bin = fopen(getFilenameExt("vfe_VS",IQ_file.dir,"bin"), "w");
      if (vfe_lri == NULL)
         log_VS_image = NULL;

   }


    sprintf( time_string,"%02d:%02d:%02d", (aux_scan->hms_UTC >> 16) & 0xFF, (aux_scan->hms_UTC >> 8) & 0xFF,aux_scan-> hms_UTC & 0xFF );
    // sprintf( time_string,"%02d_%02d_%02d", (aux_cell_vert_fe->hms_UTC >> 16) & 0xFF, (aux_cell_vert_fe->hms_UTC >> 8) & 0xFF, aux_cell_vert_fe-> hms_UTC & 0xFF );


   fprintf(vfe_log,"\n-----------------------------------------------------------------------\n");
   fprintf(vfe_log,"\n%d,%s,%d,%f,%f,%f,%f,%d,%d,%d\n",aux_cell_vert_fe->cell_id,
      time_string,
      aux_cell_vert_fe->time_of_sweep,
      cell_info->centroid_loc.lat,
      cell_info->centroid_loc.lon,
      vfe_info->start_r, vfe_info->end_r,
      aux_scan->n_scans,aux_scan->n_epochs,
      aux_scan->n_vert_sweeps);
   fprintf(vfe_log,"\n-----------------------------------------------------------------------\n");

    


   for ( rai = 0; rai < N_ALT_1K_LEVELS ; rai++) {
   
      fprintf(vfe_log,"%d,%4.3f,%4.3f,%4.3f,%4.3f,%4.3f,%4.3f,%4.3f\n", vert_fe[rai].alt, vert_fe[rai].temp, vert_fe[rai].peak_dbz,
         vert_fe[rai].peak_dbz_range_nm,
         vert_fe[rai].dbz_variance,   vert_fe[rai].dbz_max_grad , vert_fe[rai].range[DBZ_25].min_range, vert_fe[rai].range[DBZ_25].max_range);
   }

  // dump SR image

  

   if (log_VS_image) {
      // image is Col x Row
      
      //sprintf(vs_id,"vs_SRI_%d_%s",aux_cell_vert_fe->cell_id,  time_string);
      // fprintf(vfe_lri,"------------------------------------------------------\n");
      
     //      fprintf(vfe_lri,"HH:MM:SS,secSinceMidnight,acHdg,acAlt,sat,auto_mode,windShearState,totalbars,currBar,Azimuth,ERIB,scanN,cell_id_iq,cell_id_corr,cell_corr_rng,cell_corr_status,cell_lat,cell_lng,range,start_range,end_range,bearing,ac_lat,ac_lng\n");

      fprintf(vfe_lri,"%s,%d,%4.1f,%d,%4.2f,%d,%d,%d,%d,%4.1f,%d,%d,%d,%u,%4.3f,%d,%4.4f,%4.4f,%4.3f,%4.3f,%4.3f,%4.3f,%4.4f,%4.4f\n",time_string,
         aux_cell_vert_fe->time_of_sweep, 
         ac_info->ac_hdg,
         ac_info->ac_baro_alt,
         ac_info->sat,
         aux_scan->auto_mode,                                                
         aux_scan->windShearState,                                                
         aux_scan->total_bars,                                                
         aux_scan->CurBar,                                                
         aux_scan->aux_scan_angle[0],  // azimuth where vertical sweep started?
         aux_scan->ERIB,  
         aux_scan->n_scans,
         cell_info->cell_id,
         correlation_results.cell_id,
         correlation_results.range,
         correlation_results.correlation_status,
         cell_info->centroid_loc.lat,
         cell_info->centroid_loc.lon,
         vfe_info->range_nm,
	 vfe_info->start_r,
	 vfe_info->end_r,
         vfe_info->bearing, // correct for ac -heading
         ac_info->ac_loc.lat, 
         ac_info->ac_loc.lon);

      
      set_binfo_hdr(&bhdr,BI_VS_FEATS);    
      fwrite((void *) &bhdr, sizeof (BINFO_HDR),1, vfe_bin); 
      ft = ftell(vfe_bin);
      
      fwrite((void *) vfe_info, sizeof (VFE_FEAT_TYPE), 1, vfe_bin); 
      ft = ftell(vfe_bin);
      
      set_binfo_hdr(&bhdr,BI_VS_SR_IMG);
      fwrite((void *) &bhdr, sizeof (BINFO_HDR),1, vfe_bin); 
      ft = ftell(vfe_bin);
   
      for (kw = 0; kw < 120; kw++) {
         nir = fwrite((void *) srfp, sizeof (float), 256, vfe_bin); 
         if (nir != 256) {
            bin_wrt_error++;
         }
         ft = ftell(vfe_bin);
      }

      //    vfe_sri = fopen(getFilenameExt("vfe_SRI",IQ_file.dir,"csv"), "w");
      //   fprintf(vfe_sri,"\n\n   SR DBZ \n\n");

      //fprintf(vfe_lri,"SRI,%d,%s,%f\n",aux_cell_vert_fe->cell_id,  time_string, range_nm);
      fprintf(vfe_lri,"SRI\n");
      // lets do Sky to Ground order


      for ( rai = VSDW_Y_AXIS_LEN-1 ; rai >= 0; rai--) {
         // fprintf(vfe_sri,"row [%d]\n", rai);
         for (j = 0; j < VSDW_X_AXIS_LEN_SR; j++) {
            ele = rai +  VSDW_Y_AXIS_LEN * j;
            f_imgval  = srfp[ele];
	    if (f_imgval < -5.0)
                  f_imgval  = -5.0;
            fprintf(vfe_lri,"%2.1f,",f_imgval);

         }
         fprintf(vfe_lri,"\n");
      }
   
      fflush (vfe_lri);
   

      // image is Col x Row ---
      // sprintf(vs_id,"vs_LRI_%d_%s",aux_cell_vert_fe->cell_id,  time_string);
      //    fprintf(vfe_lri,"------------------------------------------------------\n");
      //fprintf(vfe_lri,"LRI,%d,%s,%f\n",aux_cell_vert_fe->cell_id,time_string,range_nm);
      fprintf(vfe_lri,"LRI\n");
      // fprintf(vfe_lri,"------------------------------------------------------\n");
      //    vfe_lri = fopen(getFilenameExt(vs_id,IQ_file.dir,"csv"), "w");
      set_binfo_hdr(&bhdr,BI_VS_LR_IMG);

      fwrite((void *) &bhdr, sizeof (BINFO_HDR),1, vfe_bin); 
      ft = ftell(vfe_bin);

      for (kw = 0; kw < 120; kw++) {
         nir = fwrite((void *) srfp, sizeof (float), 185, vfe_bin); 
         if (nir != 185) {
            bin_wrt_error++;
         }
         ft = ftell(vfe_bin);
      }

      // lets do Sky to Ground order
      for ( rai = VSDW_Y_AXIS_LEN-1; rai >= 0; rai--) {
         //fprintf(vfe_lri,"row [%d]\n", rai);
         for (j = 0; j < VSDW_X_AXIS_LEN_LR; j++) {
            ele = rai +  VSDW_Y_AXIS_LEN * j;
            f_imgval  = lrfp[ele];
	    if (f_imgval < -5.0)
                  f_imgval  = -5.0;
            fprintf(vfe_lri,"%2.1f,",f_imgval);
         }
         fprintf(vfe_lri,"\n");
      }

      fflush (vfe_lri);
   } 

   }   

} // end vert_fe_write()








void vfe_tempProfile (float ac_baro_alt, float ac_sat, AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe)
{
int i;
float row_alt;
float row_temp;

VERT_FE_TYPE *vert_fe  = &aux_cell_vert_fe->data[0];


   for ( i = 0; i < N_ALT_1K_LEVELS ; i++)
   {
      row_alt  = (i+1) *1000.0;
      
      row_temp = (ac_baro_alt-row_alt)* 0.00198+ ac_sat;  // standard lapse 1.98 per 1000'
      vert_fe[i].alt = row_alt;
      vert_fe[i].temp = (TEMP_C_TYPE) row_temp;
   }

}


void buildPCinput(void)
{

// use the peak DBZ routine to refine the cell dimensions and fill in array

}


void runPC(void)
{
// run pattern classifier -- this could deliver score/probabilties for different TS cell stages ?
//  HMM? ANN?
// what is cell type --- building, mature, dissipating ?


}



//float get_dbz_SR(float c_range_nm, int row_alt_index, float sr_dbz_img[][VSDW_X_AXIS_LEN_SR])

float get_dbz_SR(float c_range_nm, int alt_index, float *sr_dbz_img)
{
  // alt_index -- this will be 1000' increments
  // convert c_range_nm into index into SR array [500ft_inc][300m]
  // we access into SR reflectivity array that is in 500' increments -- just average the two entries
  static uint32 too_high = 0;
  static uint32 too_far = 0;
   
   float dbz = 0.0;
   float dbz_l = 0.0;
   float dbz_h = 0.0;
   int ele;
   int si = c_range_nm / SR_NM_STEP;  // check we get the last index and not overstep
   
   // image array is laid out Col x Row - 

   if (si >= VSDW_X_AXIS_LEN_SR)
   {
      
      printf("LINE %d\n",__LINE__);
      printf("FILE %s\n",__FILE__);
      si = VSDW_X_AXIS_LEN_SR -1;               // should not happen 
      too_far++;
   }


   if (si >= 0){
   
      //  DBPASSERT(((2*alt_index+1) < VSDW_Y_AXIS_LEN),"dbz_array_bound_error");
      //  DBPTRY(((2*alt_index+1) < VSDW_Y_AXIS_LEN),"dbz_array_bound_error");
      
      ele = (si * VSDW_Y_AXIS_LEN) + alt_index * 2;   // image array is laid out Col x Row - 
  
      dbz_l = sr_dbz_img[ele];
      
      dbz_h = sr_dbz_img[ele+1]; // next in the column - since this array is Col x Row!
      
      if (dbz_l < 0) dbz_l = 0;
      if (dbz_h < 0) dbz_h = 0;
      
      dbz = (dbz_l + dbz_h) / 2.0;
      
      if (dbz > 100)
      {
         too_high++;
      }
   
   }
   
   return dbz;
}




float get_dbz_LR(float c_range_nm, int alt_index, float *lr_dbz_img)
{
//float lr_dbz_img[VSDW_Y_AXIS_LEN][VSDW_X_AXIS_LEN_LR])

// alt_index -- this will be 1000' increments
// convert c_range_nm into index into SR array [500ft_inc][1200m]
// we access into LR reflectivity array that is in 500' increments -- just ave the two enteries

  float dbz = 0.0;
  float dbz_l = 0.0;
  float dbz_h = 0.0;


    int si = c_range_nm / LR_NM_STEP;
    int ele;


    //DBPASSERT((si < VSDW_X_AXIS_LEN_LR),"dbz_array_bound_error");
   // DBPTRY((si < VSDW_X_AXIS_LEN_LR),"dbz_array_bound_error");




    if (si < VSDW_X_AXIS_LEN_LR) {

      ele = (si * VSDW_Y_AXIS_LEN) + alt_index * 2 ;

      dbz_l = lr_dbz_img[ele];

      ele +=  1;
      //      ele = (2 * k_row + 1) * VSDW_X_AXIS_LEN_LR + si;
    
        dbz_h = lr_dbz_img[ele];

        if (dbz_l < 0) dbz_l = 0;
        if (dbz_h < 0) dbz_h = 0;

        dbz = (dbz_l + dbz_h) / 2.0;


    }


    return dbz;
}


void vfe_findDBZstats (AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe, int alt_index, float start_range, float end_range,
float *sr_dbz_img, float *lr_dbz_img)
{
// need cell start and end range in nm
// alt_index
// fills peak_dbz , peak_dbz_range, variance, max_gradient

    float c_range  = start_range;
    float dbz;
    float dbz_max = 0;
    float dbz_max_range = 0;
    int N = 0;
    double mean = 0.0;
    double var = 0.0;
    double Max_grad = 0;
    double last_dbz = 0;
    double delta;
    float nm_step = SR_NM_STEP;
    double grad;
    double diff;

    VERT_FE_TYPE *vert_fe  = &aux_cell_vert_fe->data[0];

    while (c_range < end_range)
    {
        dbz = 0.0;

        if (c_range < SR_MAX_RANGE)               // TBD - check we access last element
        {
          dbz = get_dbz_SR(c_range, alt_index, sr_dbz_img);
          //dbz = get_dbz_SR(c_range, alt_index, (float (*)[VSDW_Y_AXIS_LEN]) sr_dbz_img);

        }
        else
        {
            dbz = get_dbz_LR(c_range, alt_index,lr_dbz_img);
            //dbz = get_dbz_LR(c_range, alt_index, (float (*)[VSDW_Y_AXIS_LEN])   lr_dbz_img);
            nm_step = LR_NM_STEP;
        }

        if (dbz > dbz_max)
        {
            dbz_max = dbz;
            dbz_max_range = c_range;
        }

        c_range +=  nm_step;

        if (dbz > 5.0)
        {
            N = N + 1;

            delta = dbz - mean;

            mean = mean + delta/(float) N;
            var = var + delta * ( dbz - mean);

            if  (N > 2)
            {
                if (dbz > 5.0)
                {
                    diff =  dbz - last_dbz;

//grad =  fabs(diff) /  (float) nm_step;
                    if (diff != 0)
                        grad =  diff /  (float) nm_step;
                    if (grad < 0) grad *= -1;
                                                  // dbz above the Noise floor
                    if  (grad > Max_grad  && dbz > 9)
                        Max_grad = grad;
                }
            }
            last_dbz = dbz;
        }
    }

    if (N > 1)
    {
        var = var/ (float )(N - 1);
    }

// fill in peak_dbz , peak_dbz_range, variance, max_gradient

    vert_fe[alt_index].peak_dbz = dbz_max;
    vert_fe[alt_index].peak_dbz_range_nm = dbz_max_range;
    vert_fe[alt_index].dbz_variance = var;
    vert_fe[alt_index].dbz_max_grad = Max_grad;

}


//  extract the vert features

void vfe_findDBZrange (AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe, int alt_index, float start_range, float end_range,
float *sr_dbz_img, float *lr_dbz_img)
{
    float Min_X[10];
    float Max_X[10];
    float dbZ_Val[10] =                           // for now our noise floor is 10 dbZ
    {
        50, 45, 40, 35, 30, 25, 20, 15, 10 , 5
    };
// init

    int j;
    float dbz;
    float c_range = start_range;
    float nm_step = SR_NM_STEP;

    VERT_FE_TYPE *vert_fe  = &aux_cell_vert_fe->data[0];

    for (j = 0; j < 10; j++)
    {
        Min_X[j] = 0.0;
        Max_X[j] = 0.0;
    }

// for this alt --- get the dbZ ranges

    while (c_range < end_range)
    {

        if (c_range < SR_MAX_RANGE)               // TBD - check we access last element
        {
           dbz = get_dbz_SR(c_range, alt_index, sr_dbz_img);
           //dbz = get_dbz_SR(c_range, row_alt_index, (float (*)[VSDW_Y_AXIS_LEN]) sr_dbz_img);
        }
        else
        {
              dbz = get_dbz_LR(c_range, alt_index,lr_dbz_img);
       //dbz = get_dbz_LR(c_range, row_alt_index,(float (*)[VSDW_Y_AXIS_LEN]) lr_dbz_img);
            nm_step = LR_NM_STEP;
        }

        c_range +=  nm_step;

// add threshold crossing

        for (j = 0; j < 9; j++)
        {

            if (dbz >= dbZ_Val[j] && Min_X[j]  == 0.0)
                Min_X[j] = c_range;

            if (dbz >= dbZ_Val[j])
                Max_X[j] = c_range;
        }

    }

    for (j = 0; j < 9; j++)
    {
        vert_fe[alt_index].range[j].min_range = Min_X[j];
        vert_fe[alt_index].range[j].max_range = Max_X[j];
    }

// fill in our VFE array
}




void  vert_fe(AUX_SCAN_TYPE *aux_scan, AUX_THREAT_FE_INPUT_TYPE *aux_threat_fe_input,AUX_CELL_VERT_FE_TYPE  *aux_cell_vert_fe,
	      int t_epoch)
{

// cell_info  - should tell us the extents of the cell and centroid range
// use this to select start and end range of the cell so we limit the features to the cell
// and not the entire horizontal range of the vertical sweep
// for now lets do +/- 15 nm of cell range

// extract the features from vertical sweep
// we will have several epochs in which to do feature extraction
// need some assessment of time required --- profiling
// and balance the work
// for now just work through

    VFE_FEAT_TYPE vfe_info;
    AC_INFO_TYPE *ac_info = aux_threat_fe_input->ac_info;
    CELL_INFO_TYPE *cell_info = aux_threat_fe_input->cell_info;
    int row_i;

    float *sr_dbz_img = aux_threat_fe_input->aux_vert_short_reflect;
    float *lr_dbz_img = aux_threat_fe_input->aux_vert_long_reflect;
    //
    // N.B.   currently the reflectivity images are in 2d array ---  range x altitude
    // in C we have row x col order -- [0][1] will be next altitude for 0 (300m) range
    // the [0][0] cell is the upper left i.e. Sky and minimum range
    // might have been better to have C like altitude x range
    // the correct indexing is provided by get_DBZ_SR and get_DBZ_LR 

    float *srfp;
    
    float start_range = 0.0;                     // default -- cell is 10 nmiles out
    float end_range  = 120.0;
    // MAT this is short range only - long range ??
    float start_offset;
    float end_offset;
    float range_nm = 0.0;
    float tc = 0.0;
// get start_range and end_range from cell info ---
// determine range and range bin from lat,lng comparison

    vfe_info.alt = ac_info->ac_baro_alt;
    vfe_info.id = cell_info->cell_id;

    if (t_epoch <= 1)                             // run twice per end of vert sweep for now -- later until all processing done
    {
// how many epochs do we have to do processing ??

  range_nm = navig_howFar(cell_info->centroid_loc.lat, cell_info->centroid_loc.lon, ac_info->ac_loc.lat, ac_info->ac_loc.lon) * KM_TO_NM;
  tc = navig_trueCourse( ac_info->ac_loc.lat, ac_info->ac_loc.lon,cell_info->centroid_loc.lat, cell_info->centroid_loc.lon);

   start_offset = (NM_PER_LR_BIN * cell_info->near_depth.center); 
   end_offset = (NM_PER_LR_BIN * cell_info->far_depth.center); 


  // get search range for vertical features
  start_range = range_nm - start_offset;  // TBD want to use cell extents to refine search range


  if (start_range < 0) start_range = 0;

  end_range = range_nm + end_offset;  // we were using +/- 15 nm from cell centroid posn


  if (end_range > 120) end_range = 120;  // LR_MAX  ---- only goes out 120 nm

  vfe_info.start_r = start_range;
  vfe_info.end_r = end_range;
  vfe_info.range_nm = range_nm;
  vfe_info.bearing = tc; // correct for ac -heading
  vfe_info.lat = cell_info->centroid_loc.lat;
  vfe_info.lng = cell_info->centroid_loc.lon;

  vfe_info.ac_lat = ac_info->ac_loc.lat;
  vfe_info.ac_lng = ac_info->ac_loc.lon;




        vfe_tempProfile (ac_info->ac_baro_alt, ac_info->sat,  aux_cell_vert_fe) ;

        for (row_i = 0; row_i < N_ALT_1K_LEVELS ; row_i++)
        {
            vfe_findDBZstats (aux_cell_vert_fe, row_i, start_range, end_range, sr_dbz_img, lr_dbz_img) ;
        }

        buildPCinput();                           // build pattern classifier dbz input

        for (row_i = 0; row_i < N_ALT_1K_LEVELS ; row_i++)
        {
	  vfe_findDBZrange (aux_cell_vert_fe, row_i, start_range, end_range, sr_dbz_img, lr_dbz_img) ;
          
        }

        runPC();


       if (VFE_debug)
	 vert_fe_write (aux_scan, aux_cell_vert_fe, ac_info, &vfe_info, cell_info, sr_dbz_img, lr_dbz_img);

    }
}





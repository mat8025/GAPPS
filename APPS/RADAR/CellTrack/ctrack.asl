//  functions to read IQ dat file
//  and extract ac_info == power from IQ stream
opendll("uac")

// useage
// asl ctrack.asl ~/radar_ct/cell_track_vecs_CTRK_MULT_vh_HH_00093F2.bin 
//


float RV[]

float DB[512]
float DB_LR[512]
float DB_SR[512]
float DBZ[512]

float DBZ_SEG_YR[512]
float DBZ_SEG_G[512]

float DBZ_YR_LSEGS[50][4]
float DBZ_G_LSEGS[50][4]

int DBZ_CMAP[512]

///  vecs are referenced in setting up glines

//setdebug(1)
include "ctrack_g"




//a=i_read()

A=ofw("vs.dat")



enum sweep_types {

   HORIZ_SWEEP,         // normal operation
   TRANSITION_HORIZ,    // after horiz scan
   AUX_VERT_UP,
   AUX_VERT_DOWN,       // legacy vert scan direction
   AUX_END_OF_VERT,     // 1st epoch after vert scan
   TRANSITION_AUX_VERT, // 2nd epoch... after vert scan
   AUX_HORIZ,
   AUX_END_OF_HORIZ,     // 1st epoch after aux horiz scan
   TRANSITION_AUX_HORIZ, // 2nd epoch... after aux horiz scan
   TRANSITION_UNKNOWN,   // in transition from unknown state
   AUX_UNKNOWN,          // unknown auxiliary type
}







na = argc();

rad_date = ""

fname = _clarg[1]

<<"$fname \n"

B= ofr(fname)

int start_swp_num = 1

if (na > 1) {
start_swp_num = atoi(_clarg[2])
}


k = 0


show_segs =0

uint swp_cnt;
uint msec;
float sca;
float radbrg;
last_swp_cnt = 0

int r_cnt = 0
ra = 180

float hdg ;

float hdg_a 

rel_brg = 0.0;

   do_db_plot = 0
   do_plot_rad = 1
   rad_range = 80
   rad_range = 320
   rad_range = 160


   set_range(511)

   if (rad_range == 160) {
      set_range(255)
   }

   else if (rad_range == 80) {
      set_range(127)
   }

   else if (rad_range == 40) {
      set_range(63)
   }



  while (1) {


    RV = getradvecs(B,&swp_cnt,&msec,&sca,&radbrg,&hdg) 

      if (swp_cnt > last_swp_cnt) {
          new_sweep()
          last_swp_cnt = swp_cnt
      }


    if (swp_cnt > start_swp_num) {

    if (f_error(B)) {
       break;
    }


//<<"%V$swp_cnt $msec $sca $radbrg\n";
//<<"db $RV[0:20] \n"
//<<"db_lr $RV[512:531] \n"
//<<"db_sr $RV[1024:1043] \n"
//<<"dbz $RV[1536:1555] \n"



k++

   DB = RV[0:511]

//<<"db $DB[0:20] \n"

   DB_LR = RV[512:1023]

//<<"dblr $DB_LR[0:20] \n"

   DB_SR = RV[1024:1535]

//<<"dbsr $DB_SR[0:20] \n"

   DBZ = RV[1536:2047]

//<<"dbz $DBZ[0:99] \n"

   //DBZ_SEG_YR = 0

   //DBZ_SEG_G = 0

//<<"buildsegs \n"
   DBZ_SEG_G = 5   

   buildsegs(radbrg,DBZ,DBZ_SEG_YR,DBZ_SEG_G,DBZ_G_LSEGS,DBZ_YR_LSEGS)


//<<"done \n"

    DBZ_CMAP = DBZ
    mapvec(DBZ_CMAP,-40,20,WHITE,20,29,GREEN,30,39,YELLOW,40,100,RED)
//<<"$DBZ_CMAP\n"

    if (rad_range == 320) {
    radius = 511
    }
    else if (rad_range == 160) {
    DBZ_CMAP_160 = DBZ_CMAP[0:255]
    radius = 255
    }
    else if (rad_range == 80) {
    DBZ_CMAP_80 = DBZ_CMAP[0:127]
    radius = 127
    }
    else if (rad_range == 40) {
    DBZ_CMAP_40 = DBZ_CMAP[0:63]
    radius = 63
    }

  if (show_segs) {
   plot(radwo,@lines,DBZ_YR_LSEGS,"green")
   plot(radwo,@lines,DBZ_G_LSEGS,"yellow")
 }


   hdg_a = hdg

   if (hdg_a > 180.0) {
    hdg_a -= 360
   }

   rel_brg = (radbrg - hdg_a)

   ra = (rel_brg - 90) * -1   

   if (do_plot_rad) {

    yr= radius * sin(deg2rad(ra))
    xr= radius * cos(deg2rad(ra))

    plot(radwo,@line,0,0,xr,yr, WHITE,"copy")  // draw as xor - so next draw will undo

    if (rad_range == 320) {
    plot(radwo,@radialpoints,ra,0,0,1,DBZ_CMAP)
    }
    else if (rad_range == 160) {
    plot(radwo,@radialpoints,ra,0,0,1,DBZ_CMAP_160)
    }
    else if (rad_range == 80) {
    plot(radwo,@radialpoints,ra,0,0,1,DBZ_CMAP_80)
    }
    else if (rad_range == 40) {
    plot(radwo,@radialpoints,ra,0,0,1,DBZ_CMAP_40)
    }


   }
   // this should be   radbrg -heading  ---> -90 <-> 90

   if (do_db_plot) {
      plot_db()
   }

   plot_dbz()



  Update()


  r_cnt++

  }


}

<<"sweep_cnt $swp_cnt $k\n"


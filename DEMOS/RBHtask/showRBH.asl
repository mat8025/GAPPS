/* 
 *  @script showRBH.asl                                                 
 * 
 *  @comment run, bike, hike - track,speed, hbeat                       
 *  @release Carbon                                                     
 *  @vers 1.5 B Boron [asl 6.46 : C Pd]                                 
 *  @date 07/10/2024 14:34:04                                           
 *  @cdate 1/1/2020                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//
//    show run, bike and hike tracks,speed, bpm
//
///            
///            
///            

#define __CPP__ 0
#define __ASL__ 1

#if __CPP__      
#include "cpp_head.h"

   Str myvers = MYFILE;
#endif         
#if _ASL_      
#include "hv.asl"

   myvers =Hdr_vers;
#define cout //
#define COUT //
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define AST matans=query("?","ASL DB go_on?",__LINE__,__FILE__);

   <<"ASL   $(_ASL_) CPP $(_CPP_)\n";

   printf("_ASL_ %d _CPP_ %d\n", _ASL_,_CPP_);
#define CDBP //
#define  ASLGEV_ 1
#include "consts.asl"
#endif         
#if __CPP__      
#warning USING_CPP
#define  ASLGEV_ 0
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define  CHKNISEQ(x,y)  chkN(x,y,EQU_, __LINE__);
#endif         
#include "debug.asl"
/////////////  Arrays : Globals //////////////
/// time correction for garmin timestamp  to convert to unix epoch ?
// UTC 00:00 Dec 31 1989.

   tc = 631062000;

   LatS= 37.5;

   LatN = 40.2;

   LongW= -105.5;

   LongE= -102.8;

   <<"%V $LatS $LatN  $LongW $LongE \n";

   MidLat = (LatN - LatS)/2.0 + LatS;

   MidLong = (LongW - LongE)/2.0 + LongE;

   LoD = 30;

   char MS[240];

   char Word[128];

   char Long[128];

   num_tpts = 700;

   void showMeasures (int index)
   {
        // tim = Tim[index] -Tim[0]

        tim = Tim[index] - ztim;

        lat = Lat[index];

        lon = Lon[index];

        elev = Elev[index];

        bpm =  Bpm[index];

        spd =  Spd[index];

        dist =  Dist[index];

        dist = dist/1000.0 * 0.621;

        text(txtwo,"$index $Elev[index] $Bpm[index] $Spd[index] ",0.5,0.5);

        int mins = tim/60;

        int secs = tim - (mins*60);

        <<"%V $Tim[index] $Tim[0] $ztim $tim $mins  $secs \n";

        tim_str = "${mins}:$secs";

        sWo(_WOID,timwo,_WVALUE,tim_str,_WUPDATE,ON_);

        sWo(_WOID,distwo,_WCLEAR,ON_,_WVALUE,dist,_WUPDATE,ON_,_WREDRAW,ON_);

        sWo(_WOID,bpmwo,_WCLEAR,ON_,_WVALUE,bpm,_WUPDATE,ON_);

        sWo(_WOID,spdwo,_WCLEAR,ON_,_WVALUE,spd,_WUPDATE,ON_);

        sWo(_WOID,elevwo,_WCLEAR,ON_,_WVALUE,elev,_WUPDATE,ON_);

        sWo(_WOID,latwo,_WCLEAR,ON_,_WVALUE,lat,_WUPDATE,ON_);

        sWo(_WOID,lonwo,_WCLEAR,ON_,_WVALUE,lon,_WUPDATE,ON_);

        sGl(pos_gl,_WCURSOR,rbox(index,0,index,20)); // this does a draw;

   }
//========================//
//////////////////////////  CPP BEGIN MAIN /////////////////////
#if __CPP__

   int main( int argc, char *argv[] ) {

        init_cpp(argv[0]) ;

        init_debug ("showRBH.dbg", 1, "1.2");

        cprintf("%s\n",MYFILE);
#endif               

#if __ASL__
       allowDB("spe,spil,ds,ic",1)
#endif
        data_file = GetArgStr();

        if (data_file @= "") {

             data_file = "bike.tsv"  // open turnpoint file;

        }

        <<"using $data_file\n";

        A=ofr(data_file);

        if (A == -1) {

             <<" can't find turnpts file \n";

             exit();

        }

        vec_type = getArgStr();

        <<"%V $vec_type \n";

        do_float_vecs = 0;

        if (vec_type == "float") {

             do_float_vecs = 1;

        }

        Mat R(DOUBLE_,200,10);
///  Read data to 2D float array

        R.readRecord(A,_RTYPE,DOUBLE_,_RDEL,-1,_RPICKCOND,">",0,0,_RPICKCOND,">",6,0);
//  Mat R 
//

        sz = Caz(R);

        R.pinfo();

        <<"%V $sz\n";

        bd = Cab(R);

        <<"%V  $bd \n";

        val = R[0][1];

        <<"%V $val\n";

        <<"%V $R[0][::]\n";

        <<"%V $R[1][::]\n";

        <<"%V $sz\n";

        <<"%V $R[2][1]\n";

        <<"%V $R[2][2]\n";

        <<"%V $R[2][3]\n";

        <<"///\n";

        <<"$R[0:9][0] \n";

        <<"$(Caz(R)) $(Cab(R))\n";

        <<"$R[1:9][1] \n";

      //  long Tim[];  // TBF CPP Vec<long> Tim(10,-1)  ;  //dynamic

        Vec<long> Tim(10,1)

        Tim.pinfo()

        ans= ask("Tim info?",1)

        Tim = R[::][0];  // TBF  CPP veriosn will be R(-1,0)   ?  all rows col 0

        Tim.redimn();

        Tim.pinfo();

        C=ofw("rbh_tim");

       // <<[C]"%(1,,,\n) $Tim \n";

        cf(C);

        ztim = R[1][0];

        ztim.pinfo();

        <<"%V $ztim \n";

        ztim = Tim[0];

        <<"zero Tim $Tim[0]\n";

        if (do_float_vecs) {

             float Secs[];

             float Lat[];

             float Lon[];

             float Dist[];

             float Spd[];

             float Elev[];

             float Bpmp[];

        }

        else {

             double Secs[];

             double Lat[];

             double Lon[];

             double Dist[];

             double Spd[];

             double Elev[];

             double Bpmp[];

        }

        Secs = Tim - ztim;

        C=ofw("rbh_secs");

        <<[C]"%(1,,,\n) $Secs \n";

        cf(C);

        Secs.pinfo();
// what is date

        sdate= time2date(ztim+tc);

        Lat = R[::][1];

        Lat.redimn();

        <<"Lat %6.4f $Lat[0:9]\n";

        C=ofw("rbh_lat");

        <<[C]"%(1,,,\n) $Lat \n";

        cf(C);

        Lon = R[::][2];

        Lon.redimn();

        <<"Lon %8.6f $Lon[0:9] \n";

        C=ofw("rbh_lon");

        <<[C]"%(1,,,\n) $Lon \n";

        cf(C);

        Dist = R[::][3];

        Dist.redimn();

        <<"Dist %6.2f $Dist[0:9]\n";

        Spd = R[::][4];

        Spd.redimn();

        C=ofw("rbh_spd");

        <<[C]"%(1,,,\n) $Spd \n";

        cf(C);

        <<"Spd %6.2f $Spd[100:109]  \n";
// smooth spd 
 //SSpd = vsmooth(Spd,7)
 //Spd = SSpd;

        Elev = R[::][5];

        Elev.redimn();

        <<"Elev $Elev[0:9]\n";
// convert to feet

        Elev *= m2ft_;

        C=ofw("rbh_elev");

        <<[C]"%(1,,,\n) $Elev \n";

        cf(C);

        Bpm = R[::][6];

        Bpm.redimn();

        <<"Bpm $Bpm[0:9]\n";

        C=ofw("rbh_bpm");

        <<[C]"%(1,,,\n) $Bpm \n";

        cf(C);

        Npts = Caz(Lon);

        <<"%V $Npts\n";
////////////////////////////////////

        Units = "M";
//////////////// PARSE COMMAND LINE ARGS ///////////////////////
///////////////////// SETUP GRAPHICS ///////////////////////////

        Graphic = CheckGwm();

        if (!Graphic) {

             Xgm = spawnGwm("BikeTask");

        }
// create window and scale
#include "tbqrd.asl"

        mapvp = cWi("MAP_RBH");

        sWi(_WOID,mapvp,_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_,_WBHUE,WHITE_,_WRESIZE,wbox(0.1,0.4,0.95,0.95));

        <<"%V $LatS $LatN  $LongW $LongE \n";

        sWi(_WOID,mapvp,_WSCALES, wbox(LongW, LatS, LongE, LatN), _WPIXMAP,ON_,_WBHUE,WHITE_);
 // but we don't draw to a window!
 // sWi(mapvp,@clip,0.01,0.1,0.95,0.99);
 // bikewo= cWo(mapvp,@BN,@name,"b",@color,WHITE_,@resize_fr,0.55,0.5,0.57,0.57);

        bikewo = cWo(mapvp,WO_BN_);

        sWo(_WOID,bikewo,_WNAME,"B", _WRESIZE,rbox(0.55,0.5,0.57,0.53),_WHVMOVE,ON_,_WDRAW,ON_, _WPIXMAP,ON_,_WREDRAW,ON_);

        mapwo= cWo(mapvp,WO_GRAPH_);

        sWo(_WOID,mapwo,_WRESIZE,wbox(0.2,0.1,0.95,0.95),_WNAME,"MAP_RBH",_WBHUE,MAGENTA_);

        sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN),  _WPIXMAP,ON_,_WREDRAW,ON_);
     //latwo= cWo(mapvp,@BV,@name,"LAT",@color,WHITE_,@style,"SVB");

        latwo= cWo(mapvp,WO_BV_);

        sWo(_WOID,latwo,_WNAME,"LAT",_WCOLOR,WHITE_,_WSTYLE,SVB_,_WDRAW,ON_);
   //  lonwo= cWo(mapvp,@BV,@name,"LON",@color,WHITE_,@style,SVB_);

        lonwo= cWo(mapvp,WO_BV_);

        sWo(_WOID,lonwo,_WNAME,"LON",_WCOLOR,WHITE_,_WSTYLE,SVB_);

   int mapwos[] = {latwo,lonwo,-1 };

   wovtile(mapwos,0.05,0.3,0.15,0.9,0.01);
///  MEASURES

   titleButtonsQRD(mapvp);

   vp= cWi("Measures");

   sWi(_WOID, vp,_WRESIZE,wbox(0.1,0.01,0.95,0.38),_WCOLOR,LILAC_,_WBHUE,TEAL_);
 // txtwo= cWo(vp,@TEXT,@resize_fr,0.55,0.80,0.95,99,@name,"TXT",@color,WHITE_,@save,@drawon,@pixmapoff);

   txtwo= cWo(vp,WO_TEXT_);

   sWo(_WOID,txtwo,_WRESIZE,wbox(0.55,0.80,0.95,99),_WNAME,"TXT",_WCOLOR,WHITE_,_WSAVE,ON_,   _WDRAW,ON_);

   vvwo= cWo(vp,WO_GRAPH_);

   sWo(_WOID,vvwo, _WRESIZE,wbox(0.2,0.11,0.95,0.79),_WNAME,"MEASURES",_WCOLOR,ORANGE_);

   sWo(_WOID,vvwo, _WSCALES, wbox(0, 0, 86400, 6000),_WREDRAW,ON_ );

   timwo= cWo(vp,WO_BV_);

   sWo(_WOID,timwo,_WNAME,"TIME",_WCOLOR,WHITE_,_WSTYLE,SVB_,_WDRAW,OFF_,_WPIXMAP,ON);

   bpmwo= cWo(vp,WO_BV_);

   sWo(_WOID,bpmwo, _WNAME,"BPM",_WCOLOR,GREEN_,_WFONTHUE,RED_,_WSTYLE,SVB_);

   elevwo= cWo(vp,WO_BV_);

   sWo(_WOID,elevwo,_WNAME,"ELEV",_WCOLOR,RED_,_WDRAW,ON_,_WSTYLE,SVB_);

   spdwo= cWo(vp,WO_BV_);

   sWo(_WOID,spdwo,_WNAME,"SPD",_WCOLOR,BLUE_,_WFONTHUE,WHITE_,_WSTYLE,SVB_);

   distwo= cWo(vp,WO_BV_);

   sWo(_WOID,distwo,_WNAME,"DIST",_WCOLOR,WHITE_,_WSTYLE,SVB_,_WREDRAW,ON_);

  int measwos[] = {timwo,distwo,elevwo,bpmwo,spdwo,-1 };

   wovtile(measwos,0.05,0.1,0.15,0.9,0.01);

   titleMessage(mapvp,sdate);

   c= "EXIT";

   sWi(_WOID,vp,_WREDRAW,ON_); // need a redraw proc for app;
# main

   sslng= Stats(Lon);

   <<"%V $sslng \n";

   sslt= Stats(Lat);

   <<"%V $sslt \n";

   ssele= Stats(Elev,">",0);

   <<"%V $ssele \n";

   min_ele = ssele[5];

   max_ele = ssele[6];

   <<" min ele $ssele[5] max $ssele[6] \n";

   min_lng = sslng[5];

   max_lng = sslng[6];

   <<"%V $min_lng $max_lng \n";

   min_lat = sslt[5];

   max_lat = sslt[6];

   <<"%V $min_lat $max_lat \n";

   spd_stats = Stats(Spd,">",0);

   max_spd = spd_stats[6];

   ave_spd = spd_stats[1];

   top_speed = ave_spd * 2 ; // run walk bike ?;

   <<"%V $max_spd  $ave_spd $top_speed\n";

   LatS = min_lat -0.01;

   LatN = max_lat+0.01;

   LongW = min_lng -0.01;

   LongE = max_lng +0.01;

   sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WREDRAW,ON_);
//  set up the IGC track for plot

   igc_tgl = cGl(mapwo);

   <<"%V $igc_tgl\n";

   sGl(_GLID,igc_tgl,_GLXVEC,Lon,_GLYVEC,Lat,_GLCOLOR,BLUE_);

   elev_gl = cGl(vvwo);

   <<"%V $elev_gl\n";

   sGl(_GLID,elev_gl,_GLXVEC,Secs,_GLYVEC,Elev,_GLCOLOR,RED_);

   bpm_gl = cGl(vvwo);

   <<"%V $bpm_gl\n";

   sGl(_GLID,bpm_gl,_GLXVEC,Secs,_GLYVEC,Bpm,_GLCOLOR,GREEN_);
    //@TY,Bpm,@color,GREEN_);

   spd_gl = cGl(vvwo);

   sGl(_GLID,spd_gl,_GLXVEC,Secs,_GLYVEC,Spd,_GLCOLOR,BLUE_);
    //@TY,Spd,@color,BLUE_);
    // curs @x vertical line  and/or curs @ y horizontal

   pos_gl   = cGl(vvwo);
    //@type,"CURSOR",@color,"orange",@ltype,"cursor")
  //  sGl(pos_gl,@cursor,0,0,0,6000,1)

   <<"%V $Npts $pos_gl $top_speed\n";

   if (Npts > 0) {
     //sWo(_WOID,mapwo,_WCLEARPIXMAP,ON_);
//<<"%V $igc_tgl\n"

        igc_tgl.pinfo();

        dGl(igc_tgl);  // plot the igc track -- if supplied;
    // sWo(_WOID,mapwo,_WSAVE,ON_,_WSHOWPIXMAP,ON_,_WSAVEPIXMAP,ON_);
   //  sWo(_WOID,vvwo, _WSCALES, rbox(0, min_ele, Npts, (max_ele+50)) )

        sWo(_WOID,vvwo, _WSCALES, 0, min_ele, Npts, (max_ele+50) );

        <<"%V $min_ele $max_ele \n";

        dGl(elev_gl);  // plot the igc climb -- if supplied;
//<<"%V $elev_gl\n"
//     sWo(_WOID,vvwo, _WSCALES,rbox( 0.0, 40, Npts, 200) )

        sWo(_WOID,vvwo, _WSCALES, 0.0, 40, Npts, 200 );

        dGl(bpm_gl);
//<<"%V $bpm_gl\n"
   //  sWo(_WOID,vvwo, _WSCALES, rbox(0.0, 0, Npts, top_speed) )

        <<"%V $Npts $top_speed \n";

        sWo(_WOID,vvwo, _WSCALES, 0.0, 0, Npts, top_speed );

        dGl(spd_gl);

   }

   int wwo = 0;

   int witp = 0;

   int drawit = 0;

   msgv = "";

   float d_ll = 0.05;

   float lat;

   float lon;

   float mrx;

   float mry;

   str wcltpt="XY";
//#include  "gevent.asl"

   int mindex = 0;

   int Kindex = 0;

   int bpm;

   int tim;

   sWi(mapvp,_Wscales,LongW, LatS, LongE, LatN);

   sWo(_WOID,mapwo,_WCLEARPIXMAP,ON_);

   dGl(igc_tgl);  // plot the igc track -- if supplied;

   sWo(_WOID,mapwo,_WSAVE,ON_,_WSAVEPIXMAP,ON_);


//////////////////// EVENT BKG LOOP ////////////////////////////////

  Gevent Gev ;
  Gev.pinfo();
int GEV_button;
int GEV_woid;
int GEV_type;
int GEV_keyc;
int GEV_keyw;
float GEV_ry;
float GEV_rx;

   int n_gev_msg =0;

   while (1) {

        Gev.eventWait()

       GEV_button=Gev.getEventButton();
       GEV_woid = Gev.getEventWoid();
       GEV_type =Gev.getEventType();
       GEV_keyc = Gev.getEventKey();
       GEV_keyw = Gev.getEventKeyWord();
       GEV.getEventRxRy (&GEV_rx,&GEV_ry);

        n_gev_msg++;

        sWo(_WOID,txtwo,_WCLEAR,1); //
		 //text(txtwo,"$_emsg  $_ekeyc ",0.2,0.7);
//<<"%V $mindex $(typeof(mindex)) $Kindex \n"	 	 	 

        <<"%V $GEV_type $GEV_woid $GEV_keyc  $GEV_keyw\n";

        if (GEV_type == PRESS_) {

             if (GEV_woid == vvwo) {


                  mindex = trunc(GEV_rx);

                  <<"%V $GEV_rx  $GEV_ry $mindex $(typeof(mindex)) \n";

                  swo(txtwo,_WCLEAR,1);

                  showMeasures (mindex);

                  Kindex = mindex;
//<<"%V $mindex $(typeof(mindex)) $Kindex \n"	 
       //  dGl(igc_tgl);

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  sWo(_WOID,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);

                  sWo(_WOID,vvwo,_WCLEARPIXMAP,1);

                  sWo(_WOID,vvwo, _WSCALES, rbox(0, min_ele, Npts, (max_ele+50)));

                  dGl(elev_gl);  // plot the igc climb -- if supplied;

                  sWo(_WOID,vvwo, _WSCALES,  rbox(0, 40, Npts, 200));

                  dGl(bpm_gl);

                  sWo(_WOID,vvwo, _WSCALES, rbox(0, 0, Npts, top_speed));

                  dGl(spd_gl);
        // sWo(_WOID,vvwo,_Wshowpixmap);

                  <<"draw cursor @ $GEV_rx \n";

                  sGl(pos_gl,_WCURSOR,rbox(GEV_rx,0,GEV_rx,20)); // this does a draw;
        // dGl(pos_gl)

             }

             if (GEV_woid == mapwo) {

                  <<"doing mapwo \n";

                  swo(txtwo,_WCLEAR,1);

                  text(txtwo,"$GEV_rx $GEV_ry  ",0.5,0.4);

                  lat = GEV_ry;

                  lon = GEV_rx;

                  sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN) ) ; // TBD put lon in W > neg form;

                  sWo(_WOID,mapwo,_WCLEARPIXMAP, ON_);

                  dGl(igc_tgl);
        //  sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_);

                  sWo(_WOID,mapwo,_WSAVE,ON,_WSAVEPIXMAP,ON_);

                  sWo(_WOID,latwo, _WVALUE,lat,_WUPDATE,ON_);

                  sWo(_WOID,lonwo,_WVALUE,lon,_WUPDATE,ON_);
	 //<<"%V$mapwo \n"

                  sWo(_WOID,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);	 ; // lon is neg ?;

             }

        }

        if (GEV_type == KEYPRESS_) {

             <<"Have keypress \n";

             if (GEV_keyc == 'R') {

                  <<"Have keyc R\n";

                  Kindex = Kindex + 5;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];
     //    sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_);
       //  sWo(_WOID,bikewo,_WMOVE,wpt(lon,lat,mapwo),_WREDRAW,ON_);

                  sWo(_WOID,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);

                  showMeasures (Kindex);

                  mindex = Kindex;

                  <<"%V $mindex $(typeof(mindex)) $Kindex \n";

             }

             else if (  GEV_keyc == 'S') {

                  Kindex -= 5;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  <<" S $Kindex $lat $lon\n";
          //sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_);

                  sWo(_WOID,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);

                  showMeasures (Kindex);
	//  sGl(pos_gl,_Wcursor,Kindex,0,Kindex,20); 

             }

             else if   (GEV_keyc== 'Q') {

                  Kindex += 10;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  <<" got Q $Kindex $lat $lon\n";
          //sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_);

                  sWo(_WOID,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);

                  showMeasures (Kindex);

                  mindex = Kindex;
	 // sGl(pos_gl,_Wcursor,Kindex,0,Kindex,20); 	 

                  <<"%V $mindex $(typeof(mindex)) $Kindex \n";

             }

             else if (  GEV_keyc == 'T') {

                  Kindex -= 10;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];
//<<"$_eloop got T $Kindex $lat $lon\n"
         //sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_);

                  sWo(_WOID,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);

                  showMeasures (Kindex);

             }

        }

        if (GEV_keyw == "REDRAW") {

             <<"doing redraw \n";

             sWo(_WOID,mapwo,_WCLEARPIXMAP,ON_);

             dGl(igc_tgl);  // plot the igc track -- if supplied;
   //  sWo(_WOID,mapwo,_WSAVE,ON_,_WSHOWPIXMAP,ON_,_WSAVEPIXMAP,ON_);
  //   sWo(_WOID,vvwo, _WSCALES, wbox(0, min_ele, Npts, (max_ele+50)) )

             sWo(_WOID,vvwo, _WSCALES, rbox(0, min_ele, Npts, (max_ele+50)) );

             dGl(elev_gl);  // plot the igc climb -- if supplied;

             sWo(_WOID,vvwo, _WSCALES, rbox(0, 40, Npts, 200 ));

             dGl(bpm_gl);

             sWo(_WOID,vvwo, _WSCALES, rbox(0, 0, Npts, top_speed ));

             sWo(_WOID,vvwo, _WSCALES, rbox(0, 0, Npts, top_speed ));

             dGl(spd_gl);

             sGl(pos_gl,_GLCURSOR,rbox(Kindex,0,Kindex,20,1)); // TBC this inits the cursor;

        }

   }
#if __CPP__              
  //////////////////////////////////

   cprintf("Exit CPP \n");

   exit(0);

   }  ; /// end of C++ main;
#endif               
///
//////////////////////////// TBD ///////////////////////////////////////////
/*


 BUGS:  
        not showing all WOS -- title button

1.  want to compare two separate tracks - 
  show progress - faster  slower hb  etc

2.  speed scale adjust  bike,walk - or use stats from whole track

3. plot against map (open street ?  sectional - google image?)

4. Show date at start of track -DONE


CPP version check record access/assign   7/10/24

*/


//==============\_(^-^)_/==================//

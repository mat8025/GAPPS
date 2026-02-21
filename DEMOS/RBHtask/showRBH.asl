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

   char LongP[128];

   num_tpts = 700;

   void showMeasures (int index)
   {
       

        tim = Tim[index] - ztim;

<<"%V $index $tim $ztim  $Tim[index] \n"

        lat = Lat[index];

        lon = Lon[index];

        elev = Elev[index];

        bpm =  Bpm[index];

        spd =  Spd[index];

        dist =  Dist[index];

        dist = dist/1000.0 * 0.621;

        text(txtwo,"$index $Elev[index] $Bpm[index] $Spd[index] ",0.5,0.5);

        mins = tim/60;

        secs = tim - (mins*60);

        <<"%V $Tim[index] $Tim[0] $ztim $tim $mins  $secs \n";


        tim_str = "${mins}:$secs";

        <<" %V $index, $dist $bpm $spd $elev $lat $lon \n" 
        sWo(_woid,timwo,_wvalue,tim_str,_wupdate,ON_);

        sWo(_woid,distwo,_wclear,ON_,_wvalue,dist,_wupdate,ON_);

        sWo(_woid,bpmwo,_wclear,ON_,_wvalue,bpm,_wredraw,ON_);

        sWo(_woid,spdwo,_wclear,ON_,_wvalue,spd,_wupdate,ON_);

        sWo(_woid,elevwo,_wclear,ON_,_wvalue,elev,_wupdate,ON_);

        sWo(_woid,latwo,_wclear,ON_,_wvalue,lat,_wupdate,ON_);

        sWo(_woid,lonwo,_wclear,ON_,_wvalue,lon,_wupdate,ON_);

        sGl(pos_gl,_WCURSOR,wbox(index,0,index,20)); // this does a draw;

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

        

//        Record R;
//        R.pinfo()
            float Secs[];

             float Lat[];

             float Lon[];

             float Dist[];

             float Spd[];

             float Elev[];

             float Bpmp[];


     Mat R(DOUBLE_,200,10);

///  Read data to 2D float array

    // R.pinfo()

     R.readRecord(A,_RTYPE,DOUBLE_,_RDEL,-1,_RPICKCOND,">",0,0,_RPICKCOND,">",6,0);


    <<"%6.2f  $R[0:10:][0] \n"

    <<"%6.2f  $R[0:10:][1] \n"
    ans = ask("$R[0:10:][0] ",0)

    //R.pinfo()
    <<" $(Cab(R)) \n"
   
ans = ask(" readRecord OK?",0)
   // R.setVType(MAT_V_)


   // lets now convert Record R to  a matrix DOUBLE 




//  Mat R 
//

        <<"%V $R[0][::]\n";


        <<"%V $R[1][::]\n";

    
        sz = Caz(R);

       // R.pinfo();

        <<"%V $sz\n";

        bd = Cab(R);


        <<"%V  $bd \n";

        val = R[0][1];

        <<"%V $val\n";



        <<"%V $R[0][::]\n";


        <<"%V $R[1][::]\n";

//ans= ask(" date file read OK?",1)

        <<"%V $sz\n";

        <<"%V $R[2][1]\n";

        <<"%V $R[2][2]\n";

        <<"%V $R[2][3]\n";

        <<"///\n";

        <<"$R[0:9][0] \n";


        <<"$(Caz(R)) $(Cab(R))\n";

        <<"%V $R[1:9][1] \n";


 //ans = ask("%6.4f $R[0:10:][1] OK \n",1)


      //
     //R.pinfo()
ans= ask("R still DOUBLE?",0)

      long Tim[]


      ;  // TBF CPP Vec<long> Tim(10,-1)  ;  //dynamic

      //  Vec<long> Tim(100,1)

    //    Tim.pinfo()

    Tim = R[::][0]     //

    Tim.redimn()
    
    Tim.pinfo()

ans=ask("Tim should be long[] ",1)



    //R.pinfo()
	
        C=ofw("rbh_tim");

       <<[C]"%(1,,,\n) $Tim \n";

        cf(C);

        ztim = Tim[0];

        ztim.pinfo();

        <<"%V $ztim \n";

        <<"zero Tim $Tim[0]  $ztim \n";

 ans= ask(" Time OK? $ztim",1)

         Secs.pinfo();

        Secs = Tim - ztim;

        C=ofw("rbh_secs");

        <<[C]"%(1,,,\n) $Secs \n";

        cf(C);

        Secs.pinfo();

// what is date ?


        sdate= time2date(ztim+tc);

//        R.pinfo()
       
 //ans = ask("Date ? $sdate",1)

ans = ask("%6.4f $R[0:20:][1] OK? \n",1)
 
        Lat = R[::][1];

        Lat.redimn();

        <<"Lat %6.4f $Lat[0:20]\n";
        Lat.pinfo()
	

ans = ask("Lat ? $Lat[0:20][1]",1)


        C=ofw("rbh_lat");

        <<[C]"%(1,,,\n) $Lat \n";

        cf(C);

        Lon = R[::][2];

        Lon.redimn();

        Lon.pinfo();
	
        <<"Lon %8.6f $Lon[0:9] \n";

        C=ofw("rbh_lon");

        <<[C]"%(1,,,\n) $Lon \n";

        cf(C);

        Dist = R[::][3];

        Dist.redimn();

        <<"Dist %6.2f $Dist[0:20]\n";

        Dist.pinfo()

ans=ask(" $Dist[0] OK",1)
        Spd = R[::][4];

        Spd.redimn();

        Spd.pinfo()
	
        C=ofw("rbh_spd");

        <<[C]"%(1,,,\n) $Spd \n";

        cf(C);
ans=ask(" $Spd[0] OK",1)

        <<"Spd %6.2f $Spd[100:109]  \n";

 // smooth spd 
 // SSpd = vsmooth(Spd,7)
 // Spd = SSpd;

        Elev = R[::][5];

        Elev.redimn();

        <<"Elev $Elev[0:20]\n";
// convert to feet

  Elev.pinfo()
	
  ans=ask("$Elev[0:20] ?",1)

      //  Elev *= m2ft_;

        C=ofw("rbh_elev");

        <<[C]"%(1,,,\n) $Elev \n";

        cf(C);

        Bpm = R[::][6];

        Bpm.redimn();

        <<"Bpm $Bpm[0:9]\n";

        Bpm.pinfo()

ans=ask("%V $Bpm[0] OK",1)

        C=ofw("rbh_bpm");

        <<[C]"%(1,,,\n) $Bpm \n";

        cf(C);

        Npts = Caz(Lon);

        <<"%V $Npts\n";
	ans=ask("%V $Npts ",1)
////////////////////////////////////

        Units = "M";
//////////////// PARSE COMMAND LINE ARGS ///////////////////////
///////////////////// SETUP GRAPHICS ///////////////////////////


 ans= ask("Goto Graphics?",1)
 
        Graphic = CheckGwm();

        if (!Graphic) {

             Xgm = spawnGwm("BikeTask");

        }
// create window and scale

#include "wevent.asl"
#include "tbqrd.asl"



        mapvp = cWi("MAP_RBH");

        sWi(_woid,mapvp,_wpixmap,OFF_,_wdraw,ON_,_wsave,ON_,_wbhue,WHITE_,_wresize,wbox(0.1,0.4,0.95,0.95));

        <<"%V $LatS $LatN  $LongW $LongE \n";

        sWi(_woid,mapvp,_wscales, wbox(LongW, LatS, LongE, LatN), _wpixmap,OFF_,_wbhue,WHITE_);

// but we don't draw to a window!
 // sWi(mapvp,@clip,0.01,0.1,0.95,0.99);
 // bikewo= cWo(mapvp,@BN,@name,"b",@color,WHITE_,@resize_fr,0.55,0.5,0.57,0.57);

        bikewo = cWo(mapvp,WO_BN_);

        sWo(_woid,bikewo,_WNAME,"B", _wresize,wbox(0.55,0.5,0.57,0.53),_whvmove,ON_,_wdraw,ON_, _wpixmap,OFF_,_wredraw,ON_);

        mapwo= cWo(mapvp,WO_GRAPH_);

        sWo(_woid,mapwo,_wresize,wbox(0.2,0.1,0.95,0.95),_wname,"MAP_RBH",_wbhue,MAGENTA_);

        sWo(_woid,mapwo, _wscales, wbox(LongW, LatS, LongE, LatN),  _wpixmap,OFF_,_wredraw,ON_);


        latwo= cWo(mapvp,WO_BV_);

        sWo(_woid,latwo,_WNAME,"LAT",_wcolor,WHITE_,_wstyle,SVB_,_wdraw,ON_);

        lonwo= cWo(mapvp,WO_BV_);

        sWo(_woid,lonwo,_wname,"LON",_wcolor,WHITE_,_wstyle,SVB_);

   int mapwos[] = {latwo,lonwo,-1 };

   wovtile(mapwos,0.05,0.3,0.15,0.9,0.01);
///  MEASURES

   titleButtonsQRD(mapvp);

   vp= cWi("Measures");

   sWi(_woid, vp,_wresize,wbox(0.1,0.01,0.95,0.38),_wcolor,LILAC_,_wbhue,TEAL_);


   txtwo= cWo(vp,WO_TEXT_);

   sWo(_woid,txtwo,_wresize,wbox(0.55,0.80,0.95,99),_wname,"TXT",_wcolor,WHITE_,_wsave,ON_,   _wdraw,ON_);

   vvwo= cWo(vp,WO_GRAPH_);

   sWo(_woid,vvwo, _wresize,wbox(0.2,0.11,0.95,0.79),_wname,"MEASURES",_wcolor,ORANGE_);

   sWo(_woid,vvwo, _wscales, wbox(0, 0, Npts, 6000),_wredraw,ON_ );

   timwo= cWo(vp,WO_BV_);

   sWo(_woid,timwo,_wname,"TIME",_wcolor,WHITE_,_wstyle,SVB_,_wdraw,OFF_,_wpixmap,ON);

   bpmwo= cWo(vp,WO_BV_);

   sWo(_woid,bpmwo, _wname,"BPM",_wcolor,GREEN_,_wfonthue,RED_,_wstyle,SVB_);

   elevwo= cWo(vp,WO_BV_);

   sWo(_woid,elevwo,_wname,"ELEV",_wcolor,RED_,_wdraw,ON_,_wstyle,SVB_);

   spdwo= cWo(vp,WO_BV_);

   sWo(_woid,spdwo,_wname,"SPD",_wcolor,BLUE_,_wfonthue,BLACK_,_wstyle,SVB_);

   distwo= cWo(vp,WO_BV_);

   sWo(_woid,distwo,_wname,"DIST",_wcolor,BLACK__,_wstyle,SVB_,_wredraw,ON_);

  int measwos[] = {timwo,distwo,elevwo,bpmwo,spdwo,-1 };

   wovtile(measwos,0.05,0.1,0.15,0.9,0.02);

   titleMessage(mapvp,sdate);

   c= "EXIT";

   sWi(_woid,vp,_wredraw,ON_); // need a redraw proc for app;
# main

   sslng= Stats(Lon);

   <<"%V $sslng \n";

   sslt= Stats(Lat);

   <<"%V $sslt \n";

   //ssele= Stats(Elev,">",0);
   ssele= Stats(Elev);

   <<"%V $ssele \n";

   min_ele = ssele[5];

   max_ele = ssele[6];

   <<" min ele $ssele[5] max $ssele[6] \n";


ans = ask("Stats OK?",1)
   min_lng = sslng[5];

   max_lng = sslng[6];

   <<"%V $min_lng $max_lng \n";

   min_lat = sslt[5];

   max_lat = sslt[6];

   <<"%V $min_lat $max_lat \n";

   spd_stats = Stats(Spd,GT_,0);

   max_spd = spd_stats[6];

   ave_spd = spd_stats[1];

   top_speed = ave_spd * 2 ; // run walk bike ?;

   <<"%V $max_spd  $ave_spd $top_speed\n";

   LatS = min_lat -0.01;

   LatN = max_lat+0.01;

   LongW = min_lng -0.01;

   LongE = max_lng +0.01;

   sWo(_woid,mapwo, _wscales, wbox(LongW, LatS, LongE, LatN), _wredraw,ON_);
//  set up the IGC track for plot

   igc_tgl = cGl(mapwo);

   <<"%V $igc_tgl\n";

   sGl(_glid,igc_tgl,_GLTXY,Lon,Lat,_GLCOLOR,BLUE_);

   elev_gl = cGl(vvwo);

   <<"%V $elev_gl\n";

   sGl(_glid,elev_gl,_GLTXY,Secs,Elev,_GLHUE,RED_);

   bpm_gl = cGl(vvwo);

   <<"%V $bpm_gl\n";

   sGl(_GLID,bpm_gl,_GLTXY,Secs,Bpm,_glhue,GREEN_);

   spd_gl = cGl(vvwo);

   sGl(_GLID,spd_gl,_GLXVEC,Secs,_GLYVEC,Spd,_glcolor,BLUE_);

    // curs @x vertical line  and/or curs @ y horizontal

   pos_gl   = cGl(vvwo);

   <<"%V $Npts $pos_gl $top_speed\n";

   if (Npts > 0) {

//<<"%V $igc_tgl\n"

        igc_tgl.pinfo();

         ans=ask("%V $Npts $elev_gl $bpm_gl drew igc ?",0)

         dGl(igc_tgl);  // plot the igc track -- if supplied;


        sWo(_woid,vvwo, _wscales,wbox( 0, min_ele, Npts, (max_ele+50)) );

        <<"%V $min_ele $max_ele \n";

        dGl(elev_gl);  // plot the igc climb -- if supplied;

//<<"%V $elev_gl\n"


        sWo(_woid,vvwo, _wscales,wbox( 0.0, 40, Npts, 200) );

        dGl(bpm_gl);



        <<"%V $Npts $top_speed \n";

        sWo(_woid,vvwo, _wscales, wbox(0.0, 0, Npts, top_speed) );

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

   sWi(_woid,_wscales,wbox(LongW, LatS, LongE, LatN));

   sWo(_woid,mapwo,_wclearpixmap,ON_);

   dGl(igc_tgl);  // plot the igc track -- if supplied;

   sWo(_woid,mapwo,_wsave,ON_,_wsavepixmap,OFF_);


//////////////////// EVENT BKG LOOP ////////////////////////////////

   
   int n_gev_msg =0;

   while (1) {

        eventWait()

       <<"%V $erx_ $ery_ $ebutton_ $etype_ \n"

        n_gev_msg++;

        sWo(_woid,txtwo,_wclear,1); //


        <<"%V $etype_ $ewoid_ $ekeyc_  $ekeyw_\n";

        if (etype_ == PRESS_) {

             if (ewoid_ == vvwo) {


                 // mindex = trunc(erx_);
		  mindex = erx_;

                  <<"%V $erx_  $ery_ $mindex $(typeof(mindex)) \n";

                  swo(txtwo,_wclear,1);

                  showMeasures (mindex);

                  Kindex = mindex;

                  dGl(igc_tgl);

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  sWo(_woid,bikewo,_wmove,lon,lat,mapwo,_wredraw,ON_);

                 // sWo(_woid,vvwo,_wclearpixmap,1);

                  sWo(_woid,vvwo, _wscales, wbox(0, min_ele, Npts, (max_ele+50)));

                  dGl(elev_gl);  // plot the igc climb -- if supplied;

                  //sWo(_woid,vvwo, _wscales,  wbox(0, 40, Npts, 200));

                  //dGl(bpm_gl);

                  //sWo(_woid,vvwo, _wscales, wbox(0, 0, Npts, top_speed));

                  //dGl(spd_gl);

                  <<"draw cursor @ $_erx \n";

                  sGl(pos_gl,_wcursor,wbox(_erx,0,_erx,20)); // this does a draw;
        // dGl(pos_gl)

             }

             if (ewoid_ == mapwo) {

                  <<"doing mapwo \n";

                  swo(txtwo,_wclear,1);

                  text(txtwo,"$erx_ $ery_  ",0.5,0.4);

                  lat = ery_;

                  lon = erx_;

                  sWo(_woid,mapwo, _wscales, wbox(LongW, LatS, LongE, LatN) ) ; // TBD put lon in W > neg form;

                  sWo(_woid,mapwo,_wclearpixmap, ON_);

                  dGl(igc_tgl);


                  sWo(_woid,mapwo,_wsave,ON,_wsavepixmap,OFF_);

                  sWo(_woid,latwo, _wvalue,lat,_wupdate,ON_);

                  sWo(_woid,lonwo,_wvalue,lon,_wupdate,ON_);


                  sWo(_woid,bikewo,_wmove,lon,lat,mapwo,_wredraw,ON_);	 ; // lon is neg ?;

             }

        }

        if (etype_ == KEYPRESS_) {

             <<"Have keypress \n";

             if (ekeyc_ == 'R') {

                  <<"Have keyc R\n";

                  Kindex += 5;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  sWo(_woid,bikewo,_wmove,lon,lat,mapwo,_wredraw,ON_);

                  showMeasures (Kindex);

                  mindex = Kindex;

                  <<"%V $mindex $(typeof(mindex)) $Kindex \n";

             }

             else if (  ekeyc_ == 'S') {

                  Kindex -= 5;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  <<" S $Kindex $lat $lon\n";


                  sWo(_woid,bikewo,_wmove,lon,lat,mapwo,_WREDRAW,ON_);

                  showMeasures (Kindex);


             }

             else if   (ekeyc_ == 'Q') {

                  Kindex += 10;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  <<" got Q $Kindex $lat $lon\n";

                  sWo(_woid,bikewo,_WMOVE,lon,lat,mapwo,_wredraw,ON_);

                  showMeasures (Kindex);

                  mindex = Kindex;

                  <<"%V $mindex $(typeof(mindex)) $Kindex \n";

             }

             else if (  ekeyc_ == 'T') {

                  Kindex -= 10;

                  lat = Lat[Kindex];

                  lon = Lon[Kindex];

                  sWo(_woid,bikewo,_WMOVE,lon,lat,mapwo,_WREDRAW,ON_);

                  showMeasures (Kindex);

             }

        }

        if (ekeyw_ == "REDRAW") {

             <<"doing redraw \n";

             //sWo(_woid,mapwo,_wclearpixmap,ON_);

             dGl(igc_tgl);  // plot the igc track -- if supplied;

             sWo(_woid,vvwo, _wscales, wbox(0, min_ele, Npts, (max_ele+50)) );

             dGl(elev_gl);  // plot the igc climb -- if supplied;

             //sWo(_woid,vvwo, _wscales, wbox(0, 40, Npts, 200 ));

             //dGl(bpm_gl);

             //sWo(_woid,vvwo, _wscales, wbox(0, 0, Npts, top_speed ));

             //dGl(spd_gl);

             sGl(pos_gl,_GLCURSOR,wbox(Kindex,0,Kindex,20,1)); // TBC this inits the cursor;

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

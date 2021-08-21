/* 
 *  @script showrbh.asl 
 * 
 *  @comment run, bike, hike - track,speed, hbeat 
 *  @release CARBON 
 *  @vers 1.5 B Boron [asl 6.3.48 C-Li-Cd] 
 *  @date 08/21/2021 07:47:34 
 *  @cdate 1/1/2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                              
myScript = getScript();
//
//    show run, bike and hike tracks,speed, bpm
//
;//

<|Use_=
Demo  of show run,bike,hike track and BPM
convert FIT file to tsv using fitconv_sf.asl
///////////////////////
|>

#include "debug"
#include "hv"
#include "consts"




/// time correction for garmin timestamp  to convert to unix epoch ?
// UTC 00:00 Dec 31 1989.

tc = 631062000




proc showMeasures (int index)
{
        // tim = Tim[index] -Tim[0]
	 tim = Tim[index] -ztim
         lat = Lat[index];
         lon = Lon[index];	 
         elev = Elev[index];
         bpm =  Bpm[index];
	 spd =  Spd[index];
	 dist =  Dist[index];
         dist = dist/1000.0 * 0.621;

         text(txtwo,"$index $Elev[index] $Bpm[index] $Spd[index] ",0.5,0.5)
	 int mins = tim/60;
	 int secs = tim - (mins*60);
	 
	 <<"%V $Tim[index] $Tim[0] $ztim $tim $mins  $secs \n"
	 tim_str = "${mins}:$secs"
         sWo(timwo,@value,tim_str,@update)
         sWo(distwo,@value,dist,@update)
         sWo(bpmwo,@value,bpm,@update)
	 sWo(spdwo,@value,spd,@update)
	 sWo(elevwo,@value,elev,@update)
	 sWo(latwo,@value,lat,@update)
	 sWo(lonwo,@value,lon,@update);
	  sGl(pos_gl,@cursor,index,0,index,20); // this does a draw	 

}
//========================//

   data_file = GetArgStr()

  if (data_file @= "") {
    data_file = "bike.tsv"  // open turnpoint file 
   }


<<"using $data_file\n"

  A=ofr(data_file)
  

  if (A == -1) {
    <<" can't find turnpts file \n"
     exit();
  }

///  Read data to 2D float array
R=readRecord(A,@type,FLOAT_,@pickcond,">",1,0,pickcond,">",2,0)


sz = Caz(R);

<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"

<<"$sz\n"

<<"$R[2][1]\n"
<<"$R[2][2]\n"
<<"$R[2][3]\n"
<<"///\n"
<<"$R[0:9] \n"

<<"$(Caz(R)) $(Cab(R))\n"

<<"$R[1:9][1] \n"
 long Tim[]

 Tim = R[::][0] 

 Tim->redimn()

<<"Tim $Tim[0:9]\n"
ztim = Tim[0]
<<"zero Tim $Tim[0]\n"
// what is date

 sdate= time2date(ztim+tc)

 Lat = R[::][1] 

 Lat->redimn()

<<"Lat $Lat[0:9]\n"

 Lon = R[::][2] 

 Lon->redimn()

<<"Lon $Lon[0:9]\n"

 Dist = R[::][3] 

 Dist->redimn()

<<"Dist $Dist[0:9]\n"

 Spd = R[::][4] 

 Spd->redimn()

<<"Spd $Spd[0:9]\n"
// smooth spd 
 SSpd = vsmooth(Spd,7)
 Spd = SSpd;
 
 Elev = R[::][5] 

 Elev->redimn()

<<"Elev $Elev[0:9]\n"
// convert to feet
 Elev *= _m2ft;
 
 Bpm = R[::][6] 

 Bpm->redimn()

<<"Bpm $Bpm[0:9]\n"

  Npts = Caz(Lon);
<<"%V $Npts\n"  
////////////////////////////////////


Units = "M"




/////////////  Arrays : Globals //////////////

LatS= 37.5;

LatN = 40.2;

LongW= -105.5;

LongE= -102.8;

MidLat = (LatN - LatS)/2.0 + LatS;
MidLong = (LongW - LongE)/2.0 + LongE;



LoD = 30;

char MS[240]
char Word[128]
char Long[128]
num_tpts = 700




//////////////// PARSE COMMAND LINE ARGS ///////////////////////



///////////////////// SETUP GRAPHICS ///////////////////////////

Graphic = CheckGwm();

  if (!Graphic) {
    Xgm = spawnGwm("BikeTask")
  }

// create window and scale
 include "tbqrd"
 
  mapvp = cWi(@title,"Map",@resize,0.1,0.45,0.9,0.95,0)

  sWi(mapvp,@scales,LongW, LatS, LongE, LatN, @drawoff,@pixmapon,@save,@bhue,WHITE_); // but we dont draw to a window!

  sWi(mapvp,@clip,0.01,0.1,0.95,0.99);

  bikewo= cWo(mapvp,@BN,@name,"b",@color,WHITE_,@resize_fr,0.55,0.5,0.57,0.57);
  sWo(bikewo,@hvmove,1,@redraw,@drawon, @pixmapon);

  mapwo= cWo(mapvp,@GRAPH,@resize_fr,0.2,0.1,0.95,0.95,@name,"MAP",@bhue,MAGENTA_);
  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawoff, @pixmapon);



     latwo= cWo(mapvp,@BV,@name,"LAT",@color,WHITE_,@style,"SVB");

     lonwo= cWo(mapvp,@BV,@name,"LON",@color,WHITE_,@style,"SVB");


     int mapwos[] = {latwo,lonwo };

    wovtile(mapwos,0.05,0.3,0.15,0.9,0.01);


///  MEASURES


  vp = cWi(@title,"Measures",@resize,0.1,0.01,0.9,0.44,0,@color,LILAC_,@bhue,TEAL_)

  txtwo= cWo(vp,@TEXT,@resize_fr,0.55,0.80,0.95,99,@name,"TXT",@color,WHITE_,@save,@drawon,@pixmapoff);

  vvwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.11,0.95,0.79,@name,"MEASURES",@color,ORANGE_);

  sWo(vvwo, @scales, 0, 0, 86400, 6000, @save,@savepixmap, @redraw, @drawon, @pixmapoff);

    titleButtonsQRD(vp);


     timwo= cWo(vp,@BV,@name,"TIME",@color,WHITE_,@style,SVB_);


     bpmwo= cWo(vp,@BV,@name,"BPM",@color,GREEN_,@fonthue,RED_,@style,SVB_);

     elevwo= cWo(vp,@BV,@name,"ELEV",@color,RED_,@style,SVB_);

     spdwo= cWo(vp,@BV,@name,"SPD",@color,BLUE_,@fonthue,WHITE_,@style,SVB_);

     distwo= cWo(vp,@BV,@name,"DIST",@color,WHITE_,@style,SVB_);



     int measwos[] = {timwo,distwo,elevwo,bpmwo,spdwo };


    wovtile(measwos,0.05,0.1,0.15,0.9,0.01);



   titleMessage(sdate)


   c= "EXIT"

   sWi(vp,@redraw); // need a redraw proc for app

   
# main


     sslng= Stats(Lon)
<<"%V $sslng \n"

     sslt= Stats(Lat)
<<"%V $sslt \n"

     ssele= Stats(Elev,">",0)
<<"%V $ssele \n"
      min_ele = ssele[5];
      max_ele = ssele[6];
<<" min ele $ssele[5] max $ssele[6] \n"


      min_lng = sslng[5];
      max_lng = sslng[6];
<<"%V $min_lng $max_lng \n"

      min_lat = sslt[5];
      max_lat = sslt[6];
<<"%V $min_lat $max_lat \n"


     spd_stats = Stats(Spd,">",0)
     
     max_spd = spd_stats[6];
     ave_spd = spd_stats[1];

     top_speed = ave_spd * 2 ; // run walk bike ?

<<"%V $max_spd  $ave_spd $top_speed\n"

    
  LatS = min_lat -0.01;
  LatN = max_lat+0.01;

    LongW = min_lng -0.01;
    LongE = max_lng +0.01;

   sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawoff, @pixmapon);

//  set up the IGC track for plot
    igc_tgl = cGl(mapwo,@TXY,Lon,Lat,@color,BLUE_);

    elev_gl = cGl(vvwo,@TY,Elev,@color,RED_);

    bpm_gl = cGl(vvwo,@TY,Bpm,@color,GREEN_);

    spd_gl = cGl(vvwo,@TY,Spd,@color,BLUE_);
    // curs @x vertical line  and/or curs @ y horizontal
    pos_gl   = cGl(vvwo,@type,"CURSOR",@color,"orange",@ltype,"cursor")
    
  //  sGl(pos_gl,@cursor,0,0,0,6000,1)
<<"%V$pos_gl \n"
   if (Npts > 0) {

     sWo(mapwo,@clearpixmap);

     dGl(igc_tgl);  // plot the igc track -- if supplied

     sWo(mapwo,@save,@showpixmap,@savepixmap);
     
     sWo(vvwo, @scales, 0, min_ele, Npts, (max_ele+50) )
     
     dGl(elev_gl);  // plot the igc climb -- if supplied

     sWo(vvwo, @scales, 0, 40, Npts, 200 )

     dGl(bpm_gl);

     sWo(vvwo, @scales, 0, 0, Npts, top_speed )

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

include  "gevent";

int mindex = 0;
int Kindex = 0;
int bpm;
int tim;

     sWi(mapvp,@scales,LongW, LatS, LongE, LatN)

     sWo(mapwo,@clearpixmap);

     dGl(igc_tgl);  // plot the igc track -- if supplied

     sWo(mapwo,@save,@showpixmap,@savepixmap);

    while (1) {


       eventWait();

<<"main $_emsg %V $_ekeyw $_ewoid $_etype $_ekeyc %c $_ekeyc \n"
<<"%V $_ex $_ey $_erx $_ery \n"
<<"%V $_ewoid $vvwo \n"


	         sWo(txtwo,@clear); //

		 text(txtwo,"$_emsg  $_ekeyc ",0.2,0.7);


//<<"%V $mindex $(typeof(mindex)) $Kindex \n"	 	 	 

     if (_etype == PRESS_) {
       if (_ewoid == vvwo) {
<<"doing vv $_ewoid \n"
         mindex = trunc(_erx) 
<<"%V $_erx  $_ery $mindex $(typeof(mindex)) \n"
         swo(txtwo,@clear)
         showMeasures (mindex);
         Kindex = mindex;
//<<"%V $mindex $(typeof(mindex)) $Kindex \n"	 
       //  dGl(igc_tgl);
	 sWo(bikewo,@move,lon,lat,mapwo,@redraw);
	// sWo(vvwo,@clearpixmap);

        sWo(vvwo, @scales, 0, min_ele, Npts, (max_ele+50) )
     
        dGl(elev_gl);  // plot the igc climb -- if supplied

        sWo(vvwo, @scales, 0, 40, Npts, 200 )

        dGl(bpm_gl);


         sWo(vvwo, @scales, 0, 0, Npts, top_speed )

         dGl(spd_gl);  

        // sWo(vvwo,@showpixmap);
	 <<"draw cursor @ $_erx \n"
         sGl(pos_gl,@cursor,_erx,0,_erx,20); // this does a draw

      

        // dGl(pos_gl)
         
         
        }

        if (_ewoid == mapwo) {
	         swo(txtwo,@clear)

                 text(txtwo,"$_erx $_ery  ",0.5,0.4)
		 lat = _ery;
		 lon = _erx;

          sWo(mapwo, @scales, LongW, LatS, LongE, LatN ) ; // TBD put lon in W > neg form
          sWo(mapwo,@clearpixmap);
	  dGl(igc_tgl);
          sWo(mapwo,@showpixmap);

         sWo(mapwo,@save,@savepixmap);	
         sWo(latwo,@value,lat,@update);
	 sWo(lonwo,@value,lon,@update);
	 //<<"%V$mapwo \n"
         sWo(bikewo,@move,lon,lat,mapwo,@redraw); // lon is neg ?
        }

      }


    if (_etype == KEYPRESS_) {
	if (_ekeyc == 'R') {

         Kindex = Kindex + 5;
         lat = Lat[Kindex];
         lon = Lon[Kindex];	 
//<<"$_eloop got R $Kindex $(typeof(Kindex)) $lat $lon\n"
          sWo(mapwo,@showpixmap);
         sWo(bikewo,@move,lon,lat,mapwo,@redraw);
         showMeasures (Kindex);
	 mindex = Kindex;
<<"%V $mindex $(typeof(mindex)) $Kindex \n"	 	 
        }

	else if (_ekeyc == 'S') {

         Kindex -= 5;
         lat = Lat[Kindex];
         lon = Lon[Kindex];	 
//<<"$_eloop got S $Kindex $lat $lon\n"
          sWo(mapwo,@showpixmap);
          sWo(bikewo,@move,lon,lat,mapwo,@redraw);
         showMeasures (Kindex);

	//  sGl(pos_gl,@cursor,Kindex,0,Kindex,20); 
        }

	else if (_ekeyc == 'Q') {

         Kindex += 10;
         lat = Lat[Kindex];
         lon = Lon[Kindex];	 
//<<"$_eloop got Q $Kindex $lat $lon\n"
          sWo(mapwo,@showpixmap);
          sWo(bikewo,@move,lon,lat,mapwo,@redraw);
         showMeasures (Kindex);
	 mindex = Kindex;
	 // sGl(pos_gl,@cursor,Kindex,0,Kindex,20); 	 
<<"%V $mindex $(typeof(mindex)) $Kindex \n"	 	 	 
        }

	else if (_ekeyc == 'T') {

         Kindex -= 10;
         lat = Lat[Kindex];
         lon = Lon[Kindex];	 
//<<"$_eloop got T $Kindex $lat $lon\n"
         sWo(mapwo,@showpixmap);
         sWo(bikewo,@move,lon,lat,mapwo,@redraw); 
         showMeasures (Kindex);
    }
   }

     if (_ekeyw @= "REDRAW") {

     sWo(mapwo,@clearpixmap);

     dGl(igc_tgl);  // plot the igc track -- if supplied

     sWo(mapwo,@save,@showpixmap,@savepixmap);
     
     sWo(vvwo, @scales, 0, min_ele, Npts, (max_ele+50) )
     
     dGl(elev_gl);  // plot the igc climb -- if supplied

     sWo(vvwo, @scales, 0, 40, Npts, 200 )

     dGl(bpm_gl);


     sWo(vvwo, @scales, 0, 0, Npts, top_speed )

     dGl(spd_gl);  

     sGl(pos_gl,@cursor,Kindex,0,Kindex,20,1); // this inits the cursor	 

     }



}
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

*/









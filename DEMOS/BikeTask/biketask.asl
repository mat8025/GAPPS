//
//    bike task
//

setDebug(1,@keep)

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
R=readRecord(A,@type,FLOAT_)


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

 Tim = R[::][0] 

 Tim->redimn()

<<"Tim $Tim[0:9]\n"

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


 Elev = R[::][5] 

 Elev->redimn()

<<"Elev $Elev[0:9]\n"


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

  bikewo= cWo(mapvp,@BN,@name,"B->",@color,WHITE_,@resize_fr,0.55,0.5,0.58,0.55);
  sWo(bikewo,@hvmove,1,@redraw,@drawon, @pixmapon);

  mapwo= cWo(mapvp,@GRAPH,@resize_fr,0.2,0.1,0.95,0.95,@name,"MAP",@color,WHITE_);
  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawoff, @pixmapon);



     latwo= cWo(mapvp,@BV,@name,"LAT",@color,WHITE_,@style,"SVB");

     lonwo= cWo(mapvp,@BV,@name,"LON",@color,WHITE_,@style,"SVB");


     int mapwos[] = {latwo,lonwo };

    wovtile(mapwos,0.05,0.3,0.15,0.9,0.01);


///  MEASURE


  vp = cWi(@title,"Measures",@resize,0.1,0.01,0.9,0.44,0)

  txtwo= cWo(vp,@TEXT,@resize_fr,0.55,0.80,0.95,99,@name,"TXT",@color,WHITE_,@save,@drawon,@pixmapoff);

  vvwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.11,0.95,0.79,@name,"MAP",@color,WHITE_);

  sWo(vvwo, @scales, 0, 0, 86400, 6000, @save, @redraw, @drawon, @pixmapon);

    titleButtonsQRD(vp);


     timwo= cWo(vp,@BV,@name,"TIME",@color,WHITE_,@style,"SVB");


     bpmwo= cWo(vp,@BV,@name,"BPM",@color,WHITE_,@style,"SVB");

     elevwo= cWo(vp,@BV,@name,"ELEV",@color,WHITE_,@style,"SVB");

     spdwo= cWo(vp,@BV,@name,"SPD",@color,WHITE_,@style,"SVB");

     distwo= cWo(vp,@BV,@name,"DIST",@color,WHITE_,@style,"SVB");



     int measwos[] = {timwo,distwo,elevwo,bpmwo,spdwo };


    wovtile(measwos,0.05,0.1,0.15,0.9,0.01);






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


    
  LatS = min_lat -0.1;
  LatN = max_lat+0.1;

    LongW = min_lng -0.1;
    LongE = max_lng +0.1;

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawoff, @pixmapon);

//  set up the IGC track for plot
    igc_tgl = cGl(mapwo,@TXY,Lon,Lat,@color,BLUE_);

    elev_gl = cGl(vvwo,@TY,Elev,@color,RED_);

    bpm_gl = cGl(vvwo,@TY,Bpm,@color,GREEN_);

    spd_gl = cGl(vvwo,@TY,Spd,@color,BLUE_);

    

   if (Npts > 0) {
     DrawGline(igc_tgl);  // plot the igc track -- if supplied

     sWo(mapwo,@save,@savepixmap);
     
     sWo(vvwo, @scales, 0, min_ele, Npts, (max_ele+50) )
     
     dGl(elev_gl);  // plot the igc climb -- if supplied

     sWo(vvwo, @scales, 0, 40, Npts, 200 )

     dGl(bpm_gl);


     sWo(vvwo, @scales, 0, 0, Npts, 20 )

     dGl(spd_gl);  

   }





int wwo = 0;
int witp = 0;
int drawit = 0;
msgv = "";

float d_ll = 0.05;



float mrx;
float mry;
str wcltpt="XY";

include  "gevent";
int index = 0;
int kindex = 0;
int bpm;
int tim;

        sWi(mapvp,@scales,LongW, LatS, LongE, LatN)

while (1) {

    drawit = 1

       eventWait()


<<"$_emsg $_ekeyc %c $_ekyc \n"
	         swo(txtwo,@clear)
		 text(txtwo,"$_emsg  $_ekeyc ",0.2,0.7)

      if (_ewoid == vvwo) {

//<<"%V $_erx  $_ery \n"
         index = trunc(_erx) 
         swo(txtwo,@clear)
         tim = Tim[index];
         lat = Lat[index];
         lon = Lon[index];	 
         elev = Elev[index];
         bpm =  Bpm[index];
	 spd =  Spd[index];
	 dist =  Dist[index];
         dist = dist/1000.0 * 0.621;

         text(txtwo,"$index $Elev[index] $Bpm[index] $Spd[index] ",0.5,0.5)
         sWo(timwo,@value,tim,@update)
         sWo(distwo,@value,dist,@update)
         sWo(bpmwo,@value,bpm,@update)
	 sWo(spdwo,@value,spd,@update)
	 sWo(elevwo,@value,elev,@update)
	 sWo(latwo,@value,lat,@update)
	 sWo(lonwo,@value,lon,@update);
		  dGl(igc_tgl);
          sWo(mapwo,@showpixmap); 
         sWo(bikewo,@move,lon,lat,mapwo,@redraw); // lon is neg ?

        }

        if (_ewoid == mapwo) {
	         swo(txtwo,@clear)

                 text(txtwo,"$_erx $_ery  ",0.5,0.4)
		 lat = _ery;
		 lon = _erx;

        sWo(mapwo, @scales, LongW, LatS, LongE, LatN ) ; // TBD put lon in W > neg form
        sWo(mapwo,@clearpixmap,@clipborder);

	if (Npts > 0) {
           sWo(mapwo,@clear,@clearpixmap);
	  dGl(igc_tgl);
          sWo(mapwo,@showpixmap);
	}
         sWo(mapwo,@save,@savepixmap);	
         sWo(latwo,@value,lat,@update);
	 sWo(lonwo,@value,lon,@update);
	 //<<"%V$mapwo \n"
         sWo(bikewo,@move,lon,lat,mapwo,@redraw); // lon is neg ?
        }


	if (_ekeyc == 'R') {

         kindex = kindex + 5;
         lat = Lat[kindex];
         lon = Lon[kindex];	 
<<"$_eloop got R $kindex $lat $lon\n"
sWo(bikewo,@move,lon,lat,mapwo,@redraw); 
        }

	if (_ekeyc == 'S') {

         kindex -= 5;
         lat = Lat[kindex];
         lon = Lon[kindex];	 
<<"$_eloop got S $kindex $lat $lon\n"
sWo(bikewo,@move,lon,lat,mapwo,@redraw); 
        }

	if (_ekeyc == 'Q') {

         kindex += 10;
         lat = Lat[kindex];
         lon = Lon[kindex];	 
<<"$_eloop got Q $kindex $lat $lon\n"
sWo(bikewo,@move,lon,lat,mapwo,@redraw); 
        }

	if (_ekeyc == 'T') {

         kindex -= 10;
         lat = Lat[kindex];
         lon = Lon[kindex];	 
<<"$_eloop got T $kindex $lat $lon\n"
sWo(bikewo,@move,lon,lat,mapwo,@redraw); 
        }



}
///

//////////////////////////// TBD ///////////////////////////////////////////
/{/*


 BUGS:  
        not showing all WOS -- title button



/}*/









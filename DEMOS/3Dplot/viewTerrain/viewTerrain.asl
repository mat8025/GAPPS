#

setdebug(0)

proc Usage()
{
  <<" asl viewTerrain.asl ~/NED/NED_51067233 \n"

}


Graphic = CheckGwm()

//<<"%V$Graphic \n"

     if (!Graphic) {
        X=spawngwm()
     }


include "viewlib"

include "ReadDEM"


///////////////////////////  Scenery /////////////////////////////////////////////

int scene[]

wobj = 1


// our elevation files usually in NED directory 

  ned_name = _clarg[1]

//  read in a NED -- 1 arc second approx 30 m resolution

  ReadNED(ned_name)


  <<"%V $LatN $LongW $LatS $LongE \n"


// sWo(mapwo, "scales", LongW, LatS, LongE, LatN )



nw_mh = getElev(LatN,LongW)

<<"%V$nw_mh \n"


se_mh = getElev( LatS,LongE)

<<"%V$se_mh \n"

Lat_mid = (LatN-LatS)/2.0 + LatS
Long_mid = (LongW-LongE)/2.0 + LongE

mh = getElev( Lat_mid,Long_mid)
Elev_mid = mh;

<<"%V$Lat_mid  $Long_mid $mh \n"

 for (j = 0; j < 10; j++) {

     <<"$Map[0][j] "

 }

<<"\n"

<<"%V $LatN $LongW $LatS $LongE \n"
/{
Track = getTrack(LatN,LongW,LatS,LongE)

sz = Caz(Track)
dmn = Cab(Track)

<<"Track %V$sz $dmn \n"

 for (j = 0; j < 100; j++) {

  <<"$j $Track[j][0] $Track[j][1] $Track[j][2]\n "

 }


 Elev = getElev(Track)

 sz= Caz(Elev)
 dmn = Cab(Elev)

<<"Elev %V$sz $dmn \n"

<<"%(1,, ,\n)6.0f$Elev"


A=ofw("ElevNW_SE")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)

Track = getTrack(LatS,LongW,LatN,LongE)
Elev = getElev(Track)

A=ofw("ElevSW_NE")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)

PTrack = parallelTrack(Track,-90,20)
Elev = getElev(PTrack)

A=ofw("ElevSW_NE_PL")
<<[A]"%(1,, ,\n)6.0f$Elev"
cf(A)

<<"MAP \n"

 for (j = 0; j < 10; j++) {

<<"$Map[0][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$Map[1][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$Map[2][j] "

 }




<<"\n"

ssz = 128
ssu = ssz -1

short SG[ssz][ssz]

   sgsz = Caz(SG)
   sgdm = Cab(SG)

<<"%V $sgsz $sgdm \n"


   SG[0][::] = Map[0][0:ssu]
   SG[1][::] = Map[1][0:ssu]



   sgsz = Caz(SG)
   sgdm = Cab(SG)

<<"SG %V $sgsz $sgdm \n"



 for (j = 0; j < 10; j++) {

<<"$SG[0][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$SG[1][j] "

 }

<<"\n"



   SG[0:ssu][::] = Map[0:ssu][0:ssu]


   sgsz = Caz(SG)
   sgdm = Cab(SG)

<<"SG %V $sgsz $sgdm \n"


 for (j = 0; j < 10; j++) {

<<"$SG[2][j] "

 }

<<"\n"

 for (j = 0; j < 10; j++) {

<<"$SG[3][j] "

 }

<<"\n"
/}

/{
//  get a subset of the Wgrid for display as a Matrix Object!
   offr = 10
   offc = 200
   er = offr+ssu
   ec = offc+ssu

   SG[0:ssu][::] = Map[offr:er][offc:ec]

 for (j = 0; j < 20; j++) {
    <<"$SG[3][j] "
 }
<<"\n"
/}

 //obid1 = MakeObject("MATRIX",SG,-100,0,10,4,2,10,10,180,180,0,1)

  // sgsz = Caz(SG)
 //  sgdm = Cab(SG)

//<<"SG %V $sgsz $sgdm \n"


// obid1 = MakeObject("MATRIX",SG,-100,0,-100,1,0.1,1,20,0,0,0,0)

 //scene[0] = obid1;

scene = CreateScene("cube")


  <<"%V $LatN $LongW $LatS $LongE \n"

int GridON = 1;

Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

//float azim = 270
float azim = 270

float elev = 0.0
float speed = 2.0
int elewo = 0;


float obpx = Long_mid  // lng deg
float obpy = Elev_mid + 200;    // ht meters
float obpz = Lat_mid    // lat deg


float targ_x = obpx
float targ_y = obpy
float targ_z = obpz

obsdz = 2

//float distance = 50.0
float distance = 1000.0 // 500

radius = 20

# setup buttons
dty = 0.05
twY = 0.98
twy = twY - dty
dtx = 0.07
twx = 0.02
twX = twx + dtx

twx = 0.5
twX = twx + dtx

do_sidev = 1

type = 1
len = 1
wid = 1


zdst = 1
togd = 1
toga = 1
rotd = 2
rang = 1

  //resetobs(1)

  // scene is array of objects


   //sWo(vpwo,@scales,-100, -100 ,600,110,0); // works

   sWo(vpwo,@scales,-100, -100 ,700,110,0); // works too

   sWo(vpwo,@scales,-200, -100 ,700,110,0);  // maybe

   sWo(vpwo,@scales,-400, -100 ,700,310,0);  // maybe
  
   sWo(svwo,@scales,-106,500,-104,5000);

   sWo(pvwo,@scales,0,-100000,500000,100000);

   //lngW,latS,lngE,LatN
   sWo(llwo,@scales,LongW-0.5, LatS-0.5, LongE+0.5, LatN+0.5);



<<"try plot \n"
<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

//  plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev, distance)
  
 // plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev, distance,1,1,1)


     TerrPlanView(0)

//iread("->")

  viewlock = 1

  cullit = 1  

  wang = Pi/2.0
  rang = 0.01
  pang = 0.01
  float rwa = 0.0

// obj zero is the eye

 allobjs = -1
// rotation applied to all objs
  hx = 50
  hy = 10

  float cir_d = 0.5

  SideView(0)

  int kev = 0
  int go_on = 0
  go_rotate = 0
  go_circle = 0
  go_loop = 0
  go_straight = 0
  o_speed = 0.5

 // map_home()

  uint ml = 0


include "gevent.asl";

  eventWait();



  while (1) {

    ml++

      //<<"$kev %v $go_on \n"

     eventWait();
    
    
    
    kev++

   sWo(vptxt,@clear,@clipborder,"red",@textr,Emsg,0,0.8) 

    did_cont = 1

  if (ev_type @= "PRESS") {

          <<"%V$Ekeyw  $Woid  $svwo $pvwo \n"

          if (ev_woid == svwo) {
             //look_to()
             <<" sv $svwo\n"
             xy_move_to(ev_button,ev_rx,ev_ry)
             look_at()
          }

          if (ev_woid == llwo) {
             <<" pv $pvwo \n"
             xz_move_to(ev_button,ev_rx,ev_ry)
             look_at()
          }

          if (ev_woid == elevwo) {
            elev = atof(getWoValue(elevwo));
          }
          if (ev_woid == azimwo) {
            azim = atof(getWoValue(azimwo));
          }
	  
	  if (ev_woid == olatwo) {
            obpz = atof(getWoValue(olatwo));
          }
	  if (ev_woid == olngwo) {
            obpx = atof(getWoValue(olngwo));
          }

	  if (ev_woid == altwo) {
            obpy = atof(getWoValue(altwo));
          }

	  if (ev_woid == distwo) {
            distance = atof(getWoValue(distwo));
          }



      }
      else if (ev_type @= "KEYPRESS") {

         //sWo(vptxt,@scrollclip,UP_,8,@clipborder,"blue",@textr," [%c${ev_keyc}] ",0,0) 

       keyControls(ev_keyc)

       sWo(azimwo,@VALUE, "%5.1f$azim" , @update)
       sWo(distwo,@VALUE, "%5.1f $distance" , @update)
       sWo(elevwo,@VALUE, "%5.1f$elev" , @update)
       sWo(olatwo,@VALUE, "%5.1f$obpz" , @update)
       sWo(olngwo,@VALUE, "%5.1f$obpx" , @update)
       sWo(altwo,@VALUE, "%5.1f$obpy" , @update)       
       
      }
      
//<<"%V$ml $go_on \n"
//<<[CFH]"%V$ml $go_on \n"

  did_cont = checkGoDir(go_on);
  
  did_cont = 1; // DBG

 if (did_cont ) {

   azim = fmod(azim,360.0)

   if (azim < 0) {
    azim = 360.0 + azim
   }   

   //elev = fmod(elev,360.0)

   if (elev > 90) {
     elev = 90
   }   

   if (elev < -90) {
     elev = -90
   }
   
   sWo(azimwo,@VALUE, "%5.1f$azim" , @update)
   sWo(distwo,@VALUE, "%5.1f $distance" , @update)
   sWo(elewo,@VALUE, "%5.1f$elev" , @update)
   sWo(olatwo,@VALUE, "%5.1f$obpz" , @update)
   sWo(olngwo,@VALUE, "%5.1f$obpx" , @update)
   sWo(altwo,@VALUE, "%5.1f$obpy" , @update)       

<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"
<<"%V %5.1f$targ_x , $targ_y , $targ_z  \n"

    sWo(vpwo,@clearpixmap);
    
<<"PlottingTerrain ! $ml \n"

    plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev,distance,1,1, GridON)
    
    sWo(vpwo,@showpixmap,@clipborder);
    
<<" Done 3D \n"

    txtmsg = "%V$obpx , %5.1f$obpy , $obpz , $azim , $elev , $o_speed"

  //  sWo(vptxt,"text",txtmsg,@update)

     TerrPlanView(1)
<<" Done Plan \n"
     SideView(1)
<<" Done Side \n"
  }

     if (ev_woid == qwo ) {
       break
     }

//     sleep(0.1)

     gsync()
     
    if (scmp(ev_woname,"QUIT",4)) {
       break;
    }


 } // main loop


exitgs()

stop!

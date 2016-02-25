//  Dolphin flight profile
OpenDll("math","plot")


include "GlideFuncs"

LX = 40

 nm_to_km = 6080.0/3281.0


// headwind

WindSpeed = 0.0



/////////////////////////////  Funcs  ////////////////////////////////////////////////////////////////

proc  GetSink ( ispeed) 
{
// use Ventus Polar
// ispeed knots
// quad fit of polar to give sink fpm
   float osink_fpm;

   osink_fpm = PolarSpeed( ispeed)

   return osink_fpm    


}


proc GetLift ( ipos, ialt) 
{
// very crude estimate of lift given the lift profile
// stored in terrain position vector PV
//  and ht of wave in LV
//  approaching into wind
//  for the +ve half of cycle if glider is above wave crest/envelope -- lift/sink is zero
//  else difference in glider alt and wave ht is lift rate
//  for the -ve half of cycle (downgoing wave)  
//  difference in glider alt and wave ht is sink rate
//  if glider is below wave trough/envelope -- lift is zero

//   zero crossing is -- set via Base variable  -- top of stable layer
//   if wave ht > Base -- in +ve upgoing wave
//   below in -ve downgoing trough


//   where in terrain vector ?
     float fpos;

     lsr = 0.0
     fpos = ipos/ dtv
     i = trunc(fpos)

//     i = trunc( ipos / dtv)

     wht = LV[i]
     wstr = WASV[i]
     lsr = wstr - Base

//<<" $i $wht $wstr $lsr \n"
     return lsr
}



proc CR_Speed_to_Fly (vr)
{
// for now crude

   if (vr > 0.0) {

      return 40.0

   }

   return 85.0
}








//////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = CreateGwindow("title","DolphinFlight","resize",0.05,0.01,0.99,0.95,0)
    SetGwindow(vp,"pixmapon","drawon","save","bhue","white")
    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    liftpwo=CreateGWOB(vp,"GRAPH","resize_fr",0.15,0.7,0.99,0.95,@name,"LP",@color,"white")
    setgwob(liftpwo,"clip",cx,cy,cX,cY)
    setgwob(liftpwo,"scales",0,5000,LX,25000, "save", "redraw","drawon", "pixmapon")


    altpwo=CreateGWOB(vp,"GRAPH","resize_fr",0.15,0.4,0.99,0.65,"name","ALTP",@color,"white")
    setgwob(altpwo,"clip",cx,cy,cX,cY)
    setgwob(altpwo,"scales",0,5000,LX,45000, "save","redraw","drawon","pixmapon")

    

    speedpwo=CreateGWOB(vp,"GRAPH","resize_fr",0.15,0.1,0.99,0.35,"name","SPEEDP",@color,"white")
    setgwob(speedpwo,"clip",cx,cy,cX,cY)
    setgwob(speedpwo,"scales",0,20,LX,200, "save","redraw","drawon","pixmapon")



    //SetGwindow(vp,"woredrawall")

    do_laser = 0

    if (do_laser) {
      OpenLaser("xcdolphin.ps")
      ScrLaser(vp)
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////
Pi = 4.0 * atan(1.0)
<<" $Pi \n"
// LiftProfile

 dtv = 0.25    // terrain resolution in KM

 float TV[]
 float LV[]
 float WASV[]
 Base = 12000.0
 wf = 0.75
 wamp = 4000.0

<<" %v $LX \n"
      npts = LX/ dtv

      TV = Frange(npts,0.0,LX)

<<" $TV[0:30] \n"
//      LV = Sin(TV * wf * 2 * Pi) * Wa

      LV = Sin(TV * wf) * wamp  + Base

//      WASV = Cos(TV + Pi/2 * wf) * wamp  + Base

      WTV = TV + 3*Pi/2.0
      WASV = Sin(WTV * wf) * wamp  + Base

<<" $LV[0:30] \n"

//  SetGwob(liftpwo,"hue","red")
  lift_gl = CreateGline("wid",liftpwo,"type","XY","xvec",TV,"yvec",LV,"color","orange")
  //DrawGline(lift_gl)

  was_gl = CreateGline("wid",liftpwo,"type","XY","xvec",TV,"yvec",WASV,"color","red")
  DrawGline(was_gl)
  SetGwob(liftpwo,"clipborder","black")


//  DrawXY(liftpwo,TV,LV)


//  DrawXY(altpwo,TV,LV)

  Text(liftpwo,"Wave Pos & Strength",0.2,0.9,2)
  Text(liftpwo," Km ---> Rocky Mtn Continental Divide",0.3,-0.18,2)


  axnum(liftpwo,1,0.0,LX,10,1.5,"g")
  SetGwob(liftpwo,"showpixmap")
  SetGwob(liftpwo,"clipborder","black")
//  RedrawGlines(vpwo)



/////////////////////////////////////////////////////// FLIGHT - Constant Speed ///////////////////////////////////
//  lift/sink     FPM
//  dx KM

float init_glider_speed = 60.0
float init_glider_alt = 15000.0

float CSP[]

float CSALT[]



float dt = 1.0      //  one sec resolution
pos = 0.0
goal = LX
sink = 0.0

//<<"%i $sink\n"
float gspeed = init_glider_speed         // Knots

float alt;
float lift;
float alt_gain;
float vr;

alt = init_glider_alt

        k = 0

        while (pos < goal) {


             dx = (gspeed - WindSpeed) * nm_to_km * dt / 3600.0

             pos += dx

             lift = GetLift (pos, alt)   // lift-profile 

             sink = GetSink (gspeed)      // from speed polar

             vr = (lift -sink)

             alt_gain = (lift - sink) * dt/60.0   // assume constant over dt -- ave this rate and previous    

             alt += alt_gain;

             <<"%V $k $pos $vr  $alt_gain $goal\n"

             CSALT[k] = alt 
 
             CSP[k] = pos 

//             sz = Caz(CSALT)

//<<"%V $k $pos $alt ${CSALT[k]} $gspeed $sink $sz\n"             
             k++

        }

//    sz = Caz(CSALT)
//<<"%v $sz \n"

             CSP[k] = goal
             CSALT[k] = alt


<<" $k $pos $alt $gspeed $lift $sink\n"             
// plot   CS vecs

    sz = Caz(CSALT)

//<<" %5r $CSALT[0:20] \n"

//<<"%v $sz \n"


  csalt_gl = CreateGline("wid",altpwo,"type","XY","xvec",CSP,"yvec",CSALT,"color","red")

  SetGwob(altpwo,"hue","green")

  DrawGline(csalt_gl)



  setgwob(speedpwo,"plotline",0,init_glider_speed,LX,init_glider_speed,"red")

  SetGwob(altpwo,"showpixmap")

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////   Flight at using simple Speed-to-fly ///////////////////////////////////////


float STFP[]
float STFALT[]
float STFSPD[]

float vsink;

        gspeed = init_glider_speed
        pos = 0.0
        alt = init_glider_alt

        k = 0

        while (pos < goal) {


             dx = (gspeed - WindSpeed) * nm_to_km * dt / 3600
             
             pos += dx

             lift = GetLift (pos, alt)   // lift-profile 

             vsink = GetSink (gspeed)      // from speed polar

//<<"$vsink $gspeed $lift  \n"           

             vr = lift - vsink

             alt_gain = (lift - vsink) * dt/60.0   // assume constant over dt -- ave this rate and previous    


//<<"%V $k  $vr  $alt_gain \n"

             alt += alt_gain
 
             STFP[k] = pos 
             STFALT[k] = alt 
             STFSPD[k] = gspeed 

             gspeed = CR_Speed_to_Fly( vr)     // new speed to fly _crude

             k++

//<<" $k $pos $alt $vr $gspeed $lift $vsink \n"             


        }

<<"%i $STFP[0] \n"


<<" $k $pos $alt $vr $gspeed $lift $vsink \n"             

             STFP[k] = goal
             STFALT[k] = alt
             STFSPD[k] = 0

sz = Caz(STFALT)
<<"%v $sz \n"


// Plot STF vecs

  stfalt_gl = CreateGline("wid",altpwo,"type","XY","xvec",STFP,"yvec",STFALT,"color","green")

  DrawGline(stfalt_gl)


  SetGwob(altpwo,"showpixmap")

  stfspd_gl = CreateGline("wid",speedpwo,"type","XY","xvec",STFP,"yvec",STFSPD,"color","green")

  DrawGline(stfspd_gl)

  SetGwob(speedpwo,"showpixmap")


////////////////////////////////////////////////   Flight at 'Correct' Speed-to-fly ///////////////////////////////////////


float CSTFP[]
float CSTFALT[]
float CSTFSPD[]

        gspeed = init_glider_speed
        pos = 0.0
        alt = init_glider_alt

        k = 0
        while (pos < goal) {


             dx = (gspeed - WindSpeed) * nm_to_km * dt / 3600
             
             pos += dx

             lift = GetLift (pos, alt)   // lift-profile 

             vsink = GetSink (gspeed)      // from speed polar

//<<"$vsink $gspeed $lift  \n"           

             alt_gain = (lift - vsink) * dt/60.0   // assume constant over dt -- ave this rate and previous    

             alt += alt_gain
 
             CSTFP[k] = pos 
             CSTFALT[k] = alt 
             CSTFSPD[k] = gspeed 
             


             vr = lift - vsink
  

             gspeed = SpeedToFly(-lift, 0)


             k++

//<<" $k $pos $alt $vr $gspeed $lift $vsink \n"             


        }

<<" $k $pos $alt $vr $gspeed $lift $vsink \n"             

sz = Caz(CSTFALT)
<<"%v $sz \n"

            CSTFP[k] = goal
             CSTFALT[k] = alt
             CSTFSPD[k] = 0

sz = Caz(CSTFALT)

<<"%v $sz \n"



// Plot STF vecs

  cstfalt_gl = CreateGline("wid",altpwo,"type","XY","xvec",CSTFP,"yvec",CSTFALT,"color","blue")

  DrawGline(cstfalt_gl)

  Text(altpwo,"Glider Altitude",0.1,0.9,1,0,0,"black")

  SetGwob(altpwo,"showpixmap")
  axnum(altpwo,1,0.0,LX,5,1.5,"g")
  axnum(altpwo,2,5000.0,45000,10000,1.5,"g")

  cstfspd_gl = CreateGline("wid",speedpwo,"type","XY","xvec",CSTFP,"yvec",CSTFSPD,"color","blue")

  DrawGline(cstfspd_gl)
  Text(speedpwo,"Glider Speed",0.1,0.9,1)

  SetGwob(speedpwo,"clipborder","black")
  SetGwob(altpwo,"clipborder","black")
  axnum(speedpwo,1,0.0,LX,10,1.5,"g")
  axnum(speedpwo,2)

  SetGwob(speedpwo,"showpixmap")

  SetGwindow(vp,"clipborder")



    if (do_laser) {
      LaserScr(vp)
      CloseLaser()

    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    RedrawGlines(vp)
    




/// check


   for (tas = 40; tas < 140 ; tas += 10) {
       
      sink = GetSink(tas)

   <<"%V $tas $sink \n"


   }


 STOP()


STOP!
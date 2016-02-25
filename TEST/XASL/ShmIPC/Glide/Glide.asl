#/* -*- c -*- */
# "$Id: Glide.asl,v 1.1 2007/02/18 22:01:42 mark Exp mark $"
// threaded  version

SetPCW("writeexe","writepic")

Main_init = 1

OpenDll("math","plot")



//   

include "ootlib"
include "GlideFuncs"
include "Instruments"
include "Controls"


include "ScreenGlide"

SetDebug(0)

<<" read all include files \n"


// need to select from NED database automatically

proc Useage()
{

  <<" Glide <scene - 3d description of buildings> <mapfile elevation data> \n"

  <<" Glide cube  NED/NED_04312054 \n"

}

set_ap(0)

Pi =  4.0 * Atan(1.0)

float azim = 0.0
float elev = 5.0

zalpha = 0
yalpha = 0
xalpha = 0

Seeit = 1

float ReplayRate = 1.0

// Units

Altitude = 3000
Glider = 1
// else car,tank

// speed in knots
Knots = 60.0

// feet per sec
float Speed

Speed = Knots * 6280 / (3600.0)


<<" %V $Knots  $Speed \n"

//  knots
// WindTriangle 
float Windspeed = 8.0
float Winddir =  280.0


// attitude - 


float Bankang = 0.0
float Gtrack = 0.0
float Gspeed = 0.0

// feet pre min
float Sinkrate = 150.0









int scene[]



NoseTail = 10

proc resetobs()
{

zalpha = 0
yalpha = 0
xalpha = 0
// observer position


obpx = LongW -1.0 
obpz = LatN - 0.5
obpy = 5000

azim = 0.0
elev = 0.0

distance = 1200
radius = 50

<<" DONE RESET %v $obpx $obpy $obpz \n"

}




proc rotate_z(n,dir)
{
       zalpha  += 2.0 * Pi / 360  * n * dir 
       obpx = radius * Cos(zalpha)
       obpy = radius * Sin(zalpha)
}


proc rotate_y(n,dir)
{
	 yalpha += 2.0 * Pi /  360 * n * dir 
         obpz = radius * Cos(yalpha)
	 obpx = radius * Sin(yalpha)
}


proc rotate_x(n,dir)
{
	 xalpha += 2.0 * Pi /  360 * n * dir
         obpy = radius * Cos(xalpha)
	 obpz = radius * Sin(xalpha)
}

dc = 0.0
oldcompass = 0
mapscale = 3000


CLASS Event
{
 public:
   Svar msg;
   int minfo[20];
   float wms[20];
   float ems[16];
   int wid
   int button
 #  method list


   CMF Wait()
   {
      msg= MessageWait(minfo,ems)
//<<" $msg $minfo\n"
      wms=GetMouseState()
      wid = wms[0]
      button = wms[2]
   }    


  CMF Read()
   {

     msg= MessageRead(minfo,ems)
      wms=GetMouseState()
      wid = wms[0]
      button = wms[2]


   }


}


Event E

//////////////////////////// COLOR MAP ///////////////////////////////////
ngl = 200
cmi = 25
float RGB[200][3]


 redv = 0.98
 greenv = 0.7
 bluev = 0.30
 
 rdf = (0.98 - 0.6) / 120.0
 gdf = (0.7- 0.38) / 120.0
 bdf = (0.3- 0.10) / 120.0

 for (j = 0; j < 200; j++) {

    RGB[j][0] = redv
    RGB[j][1] = greenv
    RGB[j][2] = 0.12
    redv -= rdf
    greenv -= gdf
    bluev -= bdf
 }

 setRGB(cmi, RGB)

//////////////////////////////////////////////////////////////////////////////////

fname = "village"
//fname = "churchR"
nc = GetArgC()
if (nc < 2) {
  Useage()
  Stop!

}


fname = GetArgStr()

scene = CreateScene(fname)

<<"scene is  $scene \n"



int nrows = 10
int ncols = 10

// this is a must do --- to read in NED -- 1 arc second approx 30 m resolution

ned_stem = GetArgStr()

<<"input  NED directory is $ned_stem \n"

if (scmp(ned_stem,"NED/",4)) {
  ned_stem = spat(ned_stem,"NED/",1)
}

<<" NED directory is $ned_stem \n"


map_ul_lat = 0.0
map_ul_long = 0.0
map_deg = 1.0

Wd=""
nf = ofr("NED/$ned_stem/${ned_stem}.blw")

if (nf == -1) {

<<" can't open ${ned_stem}.blw \n"

 STOP!
}

   nwr=Wd->Read(nf)
   map_deg = atof(Wd[0])
<<" $map_deg \n"
   nwr=Wd->Read(nf)
   nwr=Wd->Read(nf,3)
   map_ul_long = atof(Wd[0])
   map_ul_long *= -1
<<"  $map_ul_long \n"
   nwr=Wd->Read(nf)
   map_ul_lat = atof(Wd[0])

<<" $map_ul_lat $map_ul_long $map_deg \n"

cf(nf)
nf = ofr("NED/$ned_stem/${ned_stem}.hdr")

   nwr=Wd->Read(nf,2)

<<" $Wd \n"
   nrows = atoi(Wd[1])
   nwr=Wd->Read(nf)
<<" $Wd \n"
   ncols = atoi(Wd[1])

<<" %V $nrows $ncols \n"

 Map = ReadBIL("NED/$ned_stem/${ned_stem}.bil", nrows, ncols)

 mapok = SetDEM(Map,map_ul_lat,map_ul_long, map_deg)


<<" %V $mapok $(Cab(Map)) $(Caz(Map)) \n"


 wg =GetWgrid()

 <<" %v $wg \n"

 LatN=wg[0]
 LongW=wg[1]

 LatS = LatN - (wg[2] * wg[5])
 LongE = LongW - (wg[2] * wg[6])

<<" %V $LatN $LongW $LatS $LongE \n"


 setgwob(mapwo, "scales", LongW, LatS, LongE, LatN )

///////////////////////////////  AIRPORTS ////////////////////////////////////////////


turnpt  Wtp[500]


  tp_file = "turnpts"  // open turnpoint file 
  A=ofr(tp_file)

  if (A == -1) {
    <<" can't find turnpts file \n"
    STOP!
  }



 //  Read in a Task via command line
  Ntaskpts = 0
  Ntp = 0


  while (1) {

            nwr = Wtp[Ntp]->Read(A)

            if (nwr == -1) break

            if (nwr > 6) { 

     //         Wtp[Ntp]->Print()

              Ntp++
            }

      }


<<" Read $Ntp turnpts \n"

// set all Wtp as ViewObjects
   for (k = 0 ; k < Ntp ; k++) {

         isairport = Wtp[k]->GetTA()

         if (isairport) { 

//<<"dir $Wtp[k]->Dir \n"

              ReadAirport(Wtp[k]->GetPlace(),Wtp[k]->Ladeg,Wtp[k]->Longdeg, Wtp[k]->Alt, Wtp[k]->Dir)
         }
         else {
             ReadTurnPoint(Wtp[k]->GetPlace(),Wtp[k]->Ladeg,Wtp[k]->Longdeg, Wtp[k]->Alt)
         }
   }

//////////////////////////////////////////////////////////////////////////////////////

mapname = fname

float ssecs = 0.1

//<<"  $ssecs \n"

float obpx = 105.2
float obpy = 3000
float obpz = 40

float distance = 800.0
float radius = 20.0


zmn = 1
type = 1
len = 1
wid = 1

cullface(0)

zdst = 1
togd = 1
toga = 1
rotd = 2
rang = 1


msg = ""


  resetobs()

   <<" %V %6.2f $obpx $obpy $obpz  $distance \n"


  N = 30
  col = 2
  dir = -1
  bhue = 3


  viewlock = 1
  Driving = 1
// plot mini-map
    last_obpx = obpx
    last_obpy = obpy

      dex = 10
      dey = -10
  
  resetobs()


  if (Glider) {
      SetAltitude(3000)
  }

// Going North
 Heading = 0.0
 Dtc = 0.0
// S&L 


 T=fineTime()

//  TownMap()
  kloop = 0

 dcont = 0

 msg = ""

proc CheckMsg()
{

  tid = GthreadGetId()

 JumpTo("AFAcad")
 FlyTo("Granby")

  while (1) {

    w_activate(vp)

    E->Read()

    msg = E->msg

    dcont = 0

    if ( ! (msg @= "NO_MSG") ) {
       <<" <<$msg>> \n"
        zmn = msg 
       dcont = Controls()

    }
    else {
       sleep(0.1)
    }
 }

  GthreadExit(tid)

}



proc DisplayScene()
{
   int kloop = 0
   tid = GthreadGetId()
  int tdp = 0
  float gdur = 0.0
  float cdur = 0.0

  while (1) {

    dt=fineTimeSince(T,1)

    ssecs = dt/ 1000000.0

    //Compass()

// add in rate

      ssecs *= ReplayRate

      gdur += ssecs
      cdur += ssecs

      if (cdur > 120) {

          SetLift()

          cdur = 0.0
      }


      Move_vec(ssecs)

      Glide(ssecs)

// want elev 100m ahead of track
     oelev = GetElev(obpx,obpz)

     if (obpy < (oelev -50)) {
       Altitude += 200
     }

    azim = Heading + Vang 

    Setgwob(vpwo,"clearpixmap") 

    plot3D(vpwo,scene,obpx,obpy,obpz, azim, elev,distance,1, 1, 1, -1)

    Track[tdp++] = obpx
    Track[tdp++] = obpz

    SetGwob(vpwo,"showpixmap","clipborder") 

    gsync()

    kloop++

//<<" $kloop $ssecs \n"
//    sleep(0.01)
    }

  GthreadExit(tid)

}

////////////////////////////   Flight Tracking ///////////////////////////////


float Track[10+]

 igc_gl = CreateGline("wid",mapwo,"type","XYP","xyvec",Track,"color","blue")




////////////////////////////////////////////////////////////////////////////
flyto = 1

 whereto = "BuenaV"
 where_pz =  38.75
 where_px = 106.1

 where_key = FindKey(whereto)

<<" $flyto $whereto $where_key\n"

 JumpTo("AFAcad")


 FlyTo("Boulder")


 FlyTo("Granby")





int fly_loop = 0
float kmfr = 150

pilot_msg = ""

UpdateMap()

    SetGwob(winddirwo,"value",trunc(Winddir),"redraw","showpixmap") 
    SetGwob(windspdwo,"value",trunc(Windspeed),"redraw","showpixmap") 

      Prop("DISPLAY THREAD")

      displayid = gthreadcreate("DisplayScene")

      Prop("MESSAGE THREAD")

      msgid = gthreadcreate("CheckMsg")


 JumpTo("AFAcad")

flyto =0
Heading = 0

<<" %v $Windspeed \n"

  while (1) {

   fly_loop++

   dlat = LatN - obpz

    if (flyto) {

            Dtc = TrueCourse(obpz,obpx, where_pz, where_px)

           if (kmfr < 2) {
            pilot_msg = "Approaching "
            ArrivalMode()
           }
    }

    kmfr = HowFar(obpz,obpx, where_pz, where_px)

//<<" $fly_loop $obpz $obpx $dlat $azim $Gtrack $km\n"
    setgwob(vptxt,"clear")

    Text(vptxt,"$pilot_msg $whereto ---> %6.2f $kmfr  $Dtc  $dm  $ssecs $Aspeed",0,0.05,1)

         Instruments() 

         plotgw(mapwo,"symbol",obpx,obpz,"diamond",5,"red",0)

         if ((fly_loop % 500) == 0) {
            UpdateMap()
         }

         sleep(0.5)

  }




   if (msg @= "!") {
      gthreadSetFlag(recid,1)
      gthreadExit(displayid)
      gthreadExit(msgid)
      Gthreadwait()
      break
   }


STOP!




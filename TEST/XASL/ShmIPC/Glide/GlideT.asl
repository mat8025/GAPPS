#/* -*- c -*- */
# "$Id: Glide.g,v 1.1 2003/02/16 17:55:24 mark Exp mark $"

SetPCW("writeexe")
Main_init = 1


OpenDll("math")

SetDebug(1)

include "ScreenGlide"


set_ap(0)

Pi =  4.0 * Atan(1.0)

float azim = 0.0
float elev = 5.0

zalpha = 0
yalpha = 0
xalpha = 0


Seeit = 1



proc Prop( what )
{
 <<" /////////////////////////////////////////// \n"
 <<" // setting up $what    \n" 
 <<" /////////////////////////////////////////// \n"
}


// Units

proc  Kspeed(v)
{
 knts = v * 0.573248408
 return knts
}


proc pol2cdir( ang)
{
float cd
  cd =  450.0 - ang  

     if (cd > 360.0) {
       cd -= 360.0
     }
//<<"%V $cd $ang\n"
    return cd
}

Altitude = 1500
Glider = 1
// else car,tank

// speed in knots
Knots = 120

// feet per sec
Speed = Knots * 6280 / (60 * 60)


//  knots
Windspeed = 10

//
Winddir =  280

// WindTriangle 


// feet pre min
float Sinkrate = 150.0


float Track[4000+][3]

int scene[]


// pilot inputs

roll_dba = 0
roll_rate = 30


DBA = 0.0
proc RollTo( ang)
{
//<<" $_cproc \n"
 DBA = ang
 roll_dba = 1

//<<" %v $DBA \n"

}



proc RollToDBA(t) 
{
//<<" $_cproc $t\n"

	      if (DBA > Bankang) {
                 Bankang += roll_rate * t                  
		   if (Bankang >= DBA) {
                    Bankang = DBA
                    roll_dba = 0 
                   }
	      }
              else {
                 Bankang -= roll_rate * t                  
		   if (Bankang <= DBA) {
                    Bankang = DBA
                    roll_dba = 0 
                   }
              }

 //<<" %v $DBA %v $Bankang \n"
              SetBank(Bankang)
}



int compass

int trki = 0

proc PlotTrack(x,y,z)
{
  Track[trki][0] = x
  Track[trki][1] = y
  Track[trki][2] = z
  trki++
  //PlotPoint(dp,x,y,"red")
}


proc  AttitudeInd()
{
    float y = tan(d2R(Bankang))

    SetGwob(bankwo,"scales",-2,-2, 2, 2)

    PlotLine(bankwo,-1,0,1,0,"black")

    if (Bankang > 0.0) {
    PlotLine(bankwo,-1,-y,1,y,"red")
    }
    else {
    PlotLine(bankwo,-1,-y,1,y,"blue")
    }


}

proc Instruments() 
{
    SetGwob(altwo,"value",trunc(obpy))

    SetGwob(speedwo,"value",trunc(Speed))

    SetGwob(bankwo,"value",trunc(Bankang))

    AttitudeInd()

    SetGwob(variowo,"value",trunc(-1*Sinkrate))

    SetGwob(compwo,"value",trunc(compass))

    SetGwob(rotwo,"value","%3.1f $Rot")

    SetGwob(gswo,"value",trunc(Gspeed))
    SetGwob(xlongwo,"value",trunc(obpx))
    SetGwob(zlatwo,"value",trunc(obpz))
}

proc Compass()
{
float CD
     CD = Heading 

     if (CD < 0.0) {
         CD = 360.0 + CD
     }
     if (CD > 360) {
      CD -= 360.0
     }

//     CD = CD % 360
     Heading = CD
		     //<<" $Heading $CD \n"
     compass = trunc(CD)
}

proc SetBank( ba)
{
         Bankang = ba
         WoSetRotate(vpwo,Bankang)
         if (Bankang == 0.0) {
          Rot = 0.0
         }
}

proc AddBank( ba)
{
         roll_dba = 0
         Bankang += ba
         WoSetRotate(vpwo,Bankang)
         if (Bankang == 0.0)  {
                Rot = 0.0
         }
}


proc  SetAltitude(h)
{
  Altitude = h
  obpy = Altitude
}


proc check_hwind(wd,tc)
{
int rtval = 1

//   <<" $_cproc %I $tc $wd \n"
    dw = abs( wd -tc)

      if ( (dw > 90) && (dw <270)) {
//		<<"tail wind \n"
		//          return 0
           rtval = 0
	  }
       else  {
//           <<"head wind \n"
      }

         return rtval
}


proc check_loc(wd,tc)
{
int rtval = 0

  // FIX returning out of if??
  if ( abs(wd -tc) > 180) {
    //         return 1
      rtval = 1
	   }

         return rtval
}




proc WindTri (wspeed, wdir, tas, hd )
{

// c^2 = a^2 +b^2 - 2ab Cos C


//<<" $_cproc %V $wspeed $wdir $tas  $hd \n"

  float c = wspeed
  float a = tas
  float x
  float Cr

//<<" $_cproc %I $c $a \n"

  float A
  float B
  float C
  float wca 

    if (a == 0.0) {
      // drifting with the wind??
      // vertical velocity??
      a= 0.05
    }

 if ( wdir >= hd ) { 
      A = wdir - hd
	}
 else {
      A = hd - wdir
	}


 if ( A > 180 ) {
      A = 360 -A
	}

  Cr = c/a * sin(d2r(A))
//<<"%v $Cr \n"

  Cr = asin(Cr)

//  if (Cr < 0.000001)  {
//      Cr = 0
//   }

  C = r2d(Cr)

//<<"%v $C \n"

  B = 180 - (A+C)

    if ( B < 0 ) {

      <<"NOT POSSIBLE to make headway on course in this wind ! $wspeed $wdir $tas $hd  \n"

    }

  Br = d2r(B)

  bc = a*a + c*c - 2 * a * c * Cos(Br)

  gs = Sqrt(bc) 

    //  :x = abs ( wdir - hd )

  x = fabs ( wdir - hd )

  wca = C

    hw = check_hwind(wdir,hd)

    if ( hw && (tas <= wspeed) ) {
            <<"NOT POSSIBLE to make headway on course in this wind ! $wspeed $wdir $tas $hd  \n"
    }


# wind left or right of course

  //       wloc = check_loc(wdir,hd) 

   if ( check_loc(wdir,hd) ) {

//         <<"wind left of course \n"

          wca *=  -1
        }
      else {
//	          <<"wind right of course \n"
	      }

      if ( (x == 180) || (x == 0)) {
          wca = 0
	    }

	    // <<" $wca \n"

      rhe = hd - wca

	if ( rhe >= 360) {
          rhe = rhe -360
        }

      gs = fround(gs,2)

      rhe = Fround(rhe,2)

	    //      <<"GS %4.1f $gs \n"

      if (rhe < 0) {
        rhe = 360 + rhe
      }
		     //      <<"Track %4.0f $rhe \n"

      Gtrack = rhe

//<<" $_cproc $Gtrack \n"
//<<" exit Wtri \n"

      return gs
}


proc  SetSpeed(k)
{
  Speed = k * 6280 / (60 * 60)
    //<<" $cproc $k $Speed \n"
}



proc  AltitudeR(h)
{

  Altitude += h

  if (Altitude <= 1) {
      Altitude = 1
  }

  obpy = Altitude
}



proc Horizon(compass)
 {
//   y = 0.0 - obsdy

    hy = 50.0 
    float hx = 80

    if ( (compass > 315) && (compass < 45)) {
      PlotLine(vp,-hx,hy,hx,hy,"blue")
    }
    else if ((compass > 45) && (compass < 175)) {
     PlotLine(vp,-hx,hy,hx,hy,"yellow")
    }
    else if ((compass > 175) && (compass < 235)) {
     PlotLine(vp,-hx,hy,hx,hy,"green")
    }
    else  {
     PlotLine(vp,-hx,hy,hx,hy,"red")
    }

 }


proc CheckSpeed()
{
   if (Glider) {
     if (Altitude <= 2) {
       Speed *= 0.9
     }
   }

}



proc LiftSink(m )
{

// every x secs get new trend

     clift = (3.0 * Grand() * m )

     return clift
}

proc Glide( secs )
{

// Random lift Sink

    mins = secs / 60.0

    df =  mins * Sinkrate * -1.0 + LiftSink(mins)

    <<" %v $df \n"
    AltitudeR(df)

    CheckSpeed()    
}


//  Turn
//   CF = W*V^2 / (g * R)
//   R  = V^2 / (32.16 * tan( phi))     fps
//   R = V^2/ (11.26 * tan(phi))     knots
//   Rot =  1091 * tan(phi)/ V     knots

float Rot

proc rotate_vec( cdir)
{
          rpx = 10

//          dx = rpx * Sin(d2R(Heading))
//          dy = rpx * Cos(d2R(Heading))


          Heading +=  cdir

          if (Heading > 360) {
                  Heading -= 360.0
          }

          if (Heading < 0)  {
              Heading = 360 + Heading
          }

<<" %v  $Heading\n"

}


proc OrientVec( hd)
{

// nose-tail length fixed??
          rpx = NoseTail
          dx = rpx * Sin(d2R(hd))
          dy = rpx * Cos(d2R(hd))

}


proc Move_vec( t)
{
// move for t secs
// if banked keep vechicle turning

//<<" $_cproc %I $t $Speed\n"
//<<" %V $roll_dba $Bankang \n"

         if (Speed < 0.001) {
              return
		}
//     

              Gspeed = Kspeed(Speed)
              Gtrack = Heading
              
	    if (roll_dba) {
               RollToDBA(t)
            }


          if (Bankang  != 0.0 ) {
// need to deal with > 0 < 90 > 90 < 180 - inverted turn

             phi = d2r(Bankang)

//<<" %v $phi \n"
             phi = tan(phi)

             tradius = (Speed * Speed) / (32.16 * phi)

//<<" %V $Bankang $phi $tradius \n"

             Rot = 1091 * phi / Kspeed(Speed)


             ta = (Rot * t)
//<<" %v $tradius %v $rot  $ta\n"
             tar = d2R(ta)
             dz = tradius * Sin(tar)
             dx = tradius - (tradius * Cos(tar))
             Heading += ta

	       }

// wind triangle


             if (Speed > 20.0) {
               Gspeed = Kspeed(Speed)
//             Gspeed = WindTri (Windspeed, Winddir, Kspeed(Speed), Heading)          

             }

	    // show these in HUD

          pgt = pol2cdir(Gtrack)

          dm = (t/360.0 * Gspeed) * 1.852

          np = latlongfromRadialOpaD(Gtrack, obpz,obpx, dm)

          obpz = np[0]
          obpx = np[1]

<<" %V $t $Gspeed $Gtrack $pgt $dm $obpz $obpx\n"

// need to orientate nose & tail

//          OrientVec(Heading)
//          azim = pol2cdir(Heading)

          azim = Heading 
}



proc JumpVec( jump)
{

          dx = jump * Sin(d2R(Heading))
          dz = jump  * Cos(d2R(Heading))
          obpx += dx
          obpz += dz

          <<"JV %V $rpx %v $dx %v $dy $Heading\n"

}


proc Controls()
{

  done_control = 1

      if (msg @= "Q") {
          rotate_vec(-5)
      }
      else if (msg @= "S") {
          rotate_vec(5)
      }
      elif (msg @= "R") {
         JumpVec(5)
      }
      elif (msg @= "T") {
         JumpVec(-5)
      }
      elif (msg @= "~") {
          resetobs()
      }
      elif (msg @= "n") {

      }
      else {
         done_control = 0

      }

      if (done_control) {
           return 1
      }

      done_control = 1

      if (msg @= "h") {

      }

      elif (msg @= "j") {

      }
      elif (msg @= "/") {
       Driving = 1
      }
      elif (msg @= ".") {
       Driving = 0
      }
      elif (msg @= "p") {
          AltitudeR(200)
      }
      else {
      done_control = 0

      }

      if (done_control) {
           return 1
      }

    done_control = 1

    if (msg @= "o") {
          AltitudeR(-200)
         return 1
    }


      if (msg @= "i") {
         elev += 2
      }


      if (msg @= ",") {
         elev -= 2
      }


    if (msg @= "c") {
        AddBank(-5.0)
         return 1
    }


    if (msg @= "v") {
// two inputs in short time 5 deg else 0.5 deg ?
        AddBank(5.0)
         return 1
    }



    if (msg @= "e") {
        RollTo(-45.0)
         return 1
    }

    if (msg @= "r") {
        RollTo(-30.0)
         return 1
    }

    if (msg @= "t") {
        RollTo(0.0)
         return 1
    }

    if (msg @= "y") {
        RollTo(30.0)
         return 1
    }

    if (msg @= "u") {
        RollTo(45.0)
         return 1
    }

    if (msg @= "z") {
        Speed *= 0.9
         return 1
    }


    if (msg @= "x") {
        Speed *= 1.1
         return 1
    }

    if (msg @= "X") {
       SetSpeed(60)
         return 1
    }


    if (msg @= "k") {

         return 1
    }

    elif (msg @= "l") {

         return 1
    }



    elif (msg @= "[") {
        Sinkrate *= 1.1
        if (Sinkrate > 1200) {
            Sinkrate = 1200.0
        }
           return 1
    }

    elif (msg @= "]") {
        Sinkrate *= 0.8
        if (Sinkrate < 120) {
            Sinkrate = 120.0
        }
         return 1
    }

    if (msg @= "@") {
        Seeit = !Seeit
    }

   done_control = 0

   return 0

}


NoseTail = 10

proc resetobs()
{

zalpha = 0
yalpha = 0
xalpha = 0
// observer position


obpx = 105.5   
obpz = 40.0
obpy = 2500

azim = 0.0
elev = 0.0

distance = 800
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

proc TownMap()
{
// put this in XX mode
// this needs to worldmap


     if (compass != oldcompass) {
     dc=compass - oldcompass
//     RotateObject(0,0,0,-dc)
     oldcompass = compass
     }


     rx = obpx - mapscale
     rX = obpx + mapscale
     ry = obpz - mapscale
     rY = obpz + mapscale
//<<" %V $rx $rX \n"


     SetGwob(mapwo,"scales",rx,ry,rX,rY,"clearpixmap") 
     plot3D(mapwo,scene,obpx,obpy,obpz, azim, elev,distance,4)
     //plotgw(mapwo,"symbol",obpx,obpz,1,10,"red")
     plotgw(mapwo,"symbol",obpx,obpz,"arrow",25,"blue", pol2cdir(azim)-90,1)
//     trkX= Track[*][0]
//     trkY= Track[*][1]
//<<"\n $trki $Track \n"
//     vv_draw(dp,trkX,trkY)
//     vv_draw(dp,Track[*][0],Track[*][1])

  SetGwob(mapwo,"showpixmap") 

    setgwob(vptxt,"redraw")
    Text(vptxt,"%5.1f $obpx,$obpy,$obpz az $azim el $elev  D $distance",0,0.05,1)
}

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

//<<" $msg $minfo\n"

      wms=GetMouseState()
      wid = wms[0]
      button = wms[2]

   }    

}



Event E


fname = "village"
//fname = "churchR"

fname = GetArgStr()

scene = CreateScene(fname)

//<<" $scene \n"



int nrows = 10
int ncols = 10

// this is a must do --- to read in NED -- 30 m resolution
ned_stem = GetArgStr()
// Map = ReadBIL("GTO/NED_27661353/NED_27661353.bil", 11805, 8132)

map_ul_lat = 0.0
map_ul_long = 0.0
map_deg = 1.0

Wd=""
nf = ofr("NED/$ned_stem/${ned_stem}.blw")
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

#{
   for (i= 0; i < 10; i++) {
     obid = MakeObject("G_CUBE",i*200,0,4000,1,1,1,5)
   <<" $i $obid \n"
  }

   for (i= 0; i < 10; i++) {
     obid = MakeObject("G_CUBE",i*200,0,-4000,1,1,1,5)
   <<" $i $obid \n"
  }

   for (i= 0; i < 10; i++) {
     obid = MakeObject("G_PYRAMID",4000,0,i*200,1,1,1,20)
   <<" $i $obid \n"
  }

   for (i= 0; i < 10; i++) {
     obid = MakeObject("G_PYRAMID",-4000,0,i * -200,1,1,1,25)
   <<" $i $obid \n"
  }

#}

ngl = 200
cmi = 25
//set_gsmap(ngl,cmi)


float RGB[200][3]

 redv = 0.98
 greenv = 0.7
 bluev = 0.30
 
 rdf = (0.98 - 0.6) / 120.0
 gdf = (0.7- 0.38) / 120.0
 bdf = (0.3- 0.10) / 120.0


 for (j = 0; j < 200; j++) {
    RGB[j][2] = 0.12
    RGB[j][0] = redv
    RGB[j][1] = greenv
    redv -= rdf
    greenv -= gdf
    bluev -= bdf
 }



 setRGB(cmi, RGB)


mapname = fname
#set_debug(0)

float ssecs = 0.1

//<<"  $ssecs \n"

float obpx = 105.2
float obpy = 2500
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

int Minfo[10+]

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
      SetAltitude(1500)
  }

// Going North
 Heading = 0.0
// S&L 
 Bankang = 0.0
 Gtrack = 0.0
 Gspeed = 0.0

 T=fineTime()

//  TownMap()
  kloop = 0

 dcont = 0


msg = ""


proc CheckMsg()
{

  tid = GthreadGetId()

  while (1) {

    w_activate(vp)

    E->Read()

    msg = E->msg

    dcont = 0

    if ( ! (msg @= "NO_MSG") ) {

    <<"%v << $msg >> \n"

    zmn = msg 
    woid = Minfo[3]

     dcont = Controls()

    }

  }

  GthreadExit(tid)

}



proc DisplayScene()
{
   tid = GthreadGetId()
   int kloop = 0

   while (1) {

    dt=fineTimeSince(T,1)

    ssecs = dt/ 1000000.0

    Compass()

    if (Driving) {

      Move_vec(ssecs)

    }



        Glide(ssecs)




  //   <<" %v $kloop \n"

   if (kloop % 10 == 0) { 
         // refresh 1 persec?

      TownMap()

      Instruments()
    }


    if (Seeit) {
    Setgwob(vpwo,"clearpixmap") 
    plot3D(vpwo,scene,obpx,obpy,obpz, azim, elev,distance,1, 1, 1, -1)
    SetGwob(vpwo,"showpixmap","clipborder") 
    }

  
      Horizon(compass)

// <<" %4.1f $ssecs $obpx $obpy  Alt $obpz $obsdz $Heading  Bank $Bankang %v $Heading %4.0f $Speed $Sinkrate \n"

	   // <<" %4.1f $ssecs $obsdz Bank $Bankang \n"

    kloop++

  }

  GthreadExit(tid)
}





   



      Prop("DISPLAY THREAD")

      displayid = gthreadcreate("DisplayScene")

      Prop("MESSAGE THREAD")

      msgid = gthreadcreate("CheckMsg")




 Prop("MAIN THREAD WAITS")

   nt = gthreadHowMany()

mtk = 0

  while (1) {




   if (msg @= "!") {
      gthreadSetFlag(recid,1)
      gthreadExit(displayid)
      gthreadExit(msgid)
      Gthreadwait()
      break
   }

    sleep(0.9)
    gsync()

    mtk++

<<" mt $mtk \n"

  }




STOP!

// TO DO
// clip out object if it is behind observer
//  wo_move not working


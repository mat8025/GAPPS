#/* -*- c -*- */
# "$Id: Glide.g,v 1.1 2003/02/16 17:55:24 mark Exp mark $"
//  non-threaded main loop version


SetPCW("writeexe")

  Main_init = 1

OpenDll("math","plot")

SetDebug(1)

include "GlideFuncs"
include "ScreenGlide"
include "ootlib"


set_ap(0)

Pi =  4.0 * Atan(1.0)

float azim = 0.0
float elev = 5.0

zalpha = 0
yalpha = 0
xalpha = 0

Seeit = 1


// Units

Altitude = 3000
Glider = 1
// else car,tank

// speed in knots
Knots = 60.0

// feet per sec
float Speed

Speed = Knots * 6280 / (360.0)


<<" %V $Knots  $Speed \n"

//  knots
float Windspeed = 8.0
float Winddir =  280

// WindTriangle 


// feet pre min
float Sinkrate = 150.0



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

// <<" %v $DBA %v $Bankang \n"

              SetBank(Bankang)
}



int compass

int trki = 0



proc FlyTo( whereto )
{
<<" $_cproc $whereto  \n"

 where_key = FindKey(whereto)

<<" $whereto $where_key \n"
 Setgwob(flytowo,"value", whereto, "redraw" ,"showpixmap") 

 if (where_key != -1) {
   where_pz =  Wtp[where_key]->Ladeg
   where_px = Wtp[where_key]->Longdeg
<<" found airport $where_pz $where_px \n"
    flyto = 1
    RollTo(0)
 }
 else {
   flyto = 0
 }

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

    SetGwob(bankwo,"redraw")

}

proc Instruments() 
{


    SetGwob(altwo,"value",trunc(obpy * meter_to_feet),"redraw","showpixmap") 

    SetGwob(speedwo,"value",trunc(Aspeed),"redraw","showpixmap") 

    SetGwob(bankwo,"value",trunc(Bankang),"redraw") 

    AttitudeInd()

    SetGwob(variowo,"value",trunc(-1*Sinkrate))

    SetGwob(compwo,"value",trunc(Heading),"redraw") 

    SetGwob(rotwo,"value","%3.1f $Rot","redraw") 

    SetGwob(winddirwo,"value",trunc(Winddir),"redraw","showpixmap") 
    SetGwob(windspdwo,"value",trunc(Windspeed),"redraw","showpixmap") 
    SetGwob(gtwo,"value",trunc(Gtrack),"redraw","showpixmap") 

    SetGwob(gswo,"value",trunc(Gspeed),"redraw") 
    SetGwob(distwo,"value",trunc(kmfr),"redraw") 
    SetGwob(xlongwo,"value","%6.3f $obpx","redraw","showpixmap") 
    SetGwob(zlatwo,"value","%6.3f $obpz","redraw","showpixmap") 


}




proc  SetAltitude(h)
{
  Altitude = h
  obpy = Altitude
}




proc  SetSpeed(k)
{
  Speed = k * 6280 / (360.0)
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

    //<<" %v $df \n"

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

//<<" %v  $Heading\n"

}


proc OrientVec( hd)
{

// nose-tail length fixed??
          rpx = NoseTail
          dx = rpx * Sin(d2R(hd))
          dy = rpx * Cos(d2R(hd))

}



proc pol2cdir( ang)
{
//  FIX_ME !! --- proc declaration nested depth two ---
// causes malloc/free crash 

// float cd   


  cd =  450.0 - ang  

     if (cd > 360.0) {
       cd -= 360.0
     }

// <<"%V $cd $ang\n"

    return cd
}

float Aspeed

float dm

proc Move_vec( t)
{
float tradius

          Aspeed = Kspeed(Speed)

	    if (roll_dba) {
               RollToDBA(t)
            }

          vgt = 0



          dm = (t/360.0 * Gspeed) * 1.852

          if (Bankang  != 0.0 ) {

// need to deal with > 0 < 90 > 90 < 180 - inverted turn

             phi = d2r(Bankang)

//<<" %v $phi \n"

             phi = tan(phi)

//<<" %V $phi $Speed \n"

             tradius = (Speed * Speed) / (32.16 * phi)

//<<" %V $Bankang $phi $tradius  $Heading\n"

             Rot = 1091.0 * phi / Kspeed(Speed)


             ta = (Rot * t)

             Heading += ta

             if (Heading < 0) {
                 Heading += 360
             }

             Heading = fmod(Heading, 360)

//<<" %v $tradius %v $rot  $ta $Heading\n"

             tar = d2R(ta)


             dz = tradius * Sin(tar)
             dx = tradius - (tradius * Cos(tar))

// conver into lat,long
//             dm = Sqrt(dx *dx + dz *dz )



//<<" %V $dx $dz \n"

          WindTri ( Windspeed, Winddir, Aspeed, Heading , &vgt)

   if (!flyto) {
               Dtc = Heading

               }

	       }
          else {

          GetHGS(Winddir, Windspeed, Aspeed, Dtc, &vgt )

          }

          np = latlongfromRadialOpaD(Gtrack, obpz,obpx, dm)

          obpz = np[0]
          obpx = np[1]

//<<" %V $t $Gspeed $Gtrack $pgt $dm $obpz $obpx\n"


//<<" $Heading \n"
}



proc JumpVec( jump)
{

          dx = jump * Sin(d2R(Heading))
          dz = jump  * Cos(d2R(Heading))
          obpx += dx
          obpz += dz

          <<"JV %V $rpx %v $dx %v $dy $Heading\n"

}

float Vang = 0.0

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
      <<" h \n"
      }
      elif (msg @= "j") {
      <<" j \n"
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


      if (msg @= ">") {
         Vang += 15
      }

      if (msg @= "<") {
         Vang -= 7.5
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

    if (msg @= "FLYTO") {

        val = GetWobValue(flytowo)
  <<" $msg $val \n"
        FlyTo(val)

    }

    if (msg @= "WindSpeed") {

        val = GetWobValue(windspdwo)
  <<" $msg $val    setting WS \n"
        Windspeed = val
         <<"%V $Windspeed \n"
    SetGwob(windspdwo,"value",trunc(Windspeed),"redraw","showpixmap") 



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
        RollTo(-15.0)
         return 1
    }

    if (msg @= "t") {
        RollTo(0.0)
         return 1
    }

    if (msg @= "y") {
        RollTo(15.0)
         return 1
    }

    if (msg @= "u") {
        RollTo(45.0)
         return 1
    }

    if (msg @= "1") {
        Speed *= 0.9
         return 1
    }


    if (msg @= "2") {
        Speed *= 1.1
         return 1
    }

    if (msg @= "x") {
         mzoom *= 0.95
         UpdateMap()
         return 1
    }

    if (msg @= "X") {
         mzoom *= 1.1
         UpdateMap()
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
    RGB[j][2] = 0.12
    RGB[j][0] = redv
    RGB[j][1] = greenv
    redv -= rdf
    greenv -= gdf
    bluev -= bdf
 }

 setRGB(cmi, RGB)

//////////////////////////////////////////////////////////////////////////////////

fname = "village"
//fname = "churchR"

fname = GetArgStr()

scene = CreateScene(fname)

<<" $scene \n"



int nrows = 10
int ncols = 10

// this is a must do --- to read in NED -- 30 m resolution

ned_stem = GetArgStr()

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

              Wtp[Ntp]->Print()

              Ntp++
            }

      }


<<" Read $Ntp turnpts \n"

// set all Wtp as ViewObjects
   for (k = 0 ; k < Ntp ; k++) {

         isairport = Wtp[k]->GetTA()

         if (isairport) { 
<<"dir $Wtp[k]->Dir \n"
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
 Bankang = 0.0
 Gtrack = 0.0
 float Gspeed = 0.0

 T=fineTime()

//  TownMap()
  kloop = 0

 dcont = 0

 msg = ""

proc CheckMsg()
{

    w_activate(vp)

    E->Read()

    msg = E->msg

    dcont = 0

    if ( ! (msg @= "NO_MSG") ) {

    <<"%v << $msg >> \n"

    zmn = msg 

     dcont = Controls()

    }


}



proc DisplayScene()
{
   int kloop = 0
   tid = GthreadGetId()

  while (1) {

    dt=fineTimeSince(T,1)

    ssecs = dt/ 1000000.0

    //Compass()


      Move_vec(ssecs)

      Glide(ssecs)

     oelev = GetElev(obpx,obpz)
     if (obpy < (oelev -50)) {
       Altitude += 200
     }

    azim = Heading + Vang 
    Setgwob(vpwo,"clearpixmap") 
    plot3D(vpwo,scene,obpx,obpy,obpz, azim, elev,distance,1, 1, 1, -1)
    SetGwob(vpwo,"showpixmap","clipborder") 
    kloop++
//<<" $kloop $ssecs \n"
    }

  GthreadExit(tid)

}

flyto = 1

 whereto = "BuenaV"
 where_pz =  38.75
 where_px = 106.1

where_key = FindKey(whereto)

<<" $flyto $whereto $where_key\n"

 FlyTo("Boulder")

int fly_loop = 0
float kmfr = 150

pilot_msg = ""

UpdateMap()

      Prop("DISPLAY THREAD")

      displayid = gthreadcreate("DisplayScene")

flyto = 0

  while (1) {

    CheckMsg()

   fly_loop++

   dlat = LatN - obpz

   if (flyto) {

            Dtc = TrueCourse(obpz,obpx, where_pz, where_px)

           if (kmfr < 10) {
            pilot_msg = "Approaching "
            RollTo(-30)
            flyto = 0
           }
   }

    kmfr = HowFar(obpz,obpx, where_pz, where_px)

//<<" $fly_loop $obpz $obpx $dlat $azim $Gtrack $km\n"
    setgwob(vptxt,"clear")

    Text(vptxt,"$pilot_msg $whereto ---> %6.2f $kmfr  $Dtc  $dm  $ssecs",0,0.05,1)

         Instruments() 

         plotgw(mapwo,"symbol",obpx,obpz,"diamond",5,"red",0)

       if ((fly_loop % 500) == 0) {
        UpdateMap()
       }

      sleep(0.5)
       

  }




STOP!




# "$Id: GlideFuncs.asl,v 1.1 2003/02/16 17:55:44 mark Exp mark $"

////  Globals ///////////
float gRot = 0.0


int compass
int trki = 0


/////////////////////////

proc Prop( what )
{
 <<" /////////////////////////////////////////// \n"
 <<" // setting up $what    \n" 
 <<" /////////////////////////////////////////// \n"
}

proc  Kspeed(v)
{
 knts = v * 0.573248408
//<<" %v $knts \n"
 return knts
}


proc SetBank( ba)
{
         Bankang = ba
         
         WoSetRotate(vpwo,Bankang/2.0)
         if (Bankang == 0.0) {
          gRot = 0.0
         }
}

proc AddBank( ba)
{
         roll_dba = 0
         Bankang += ba
         WoSetRotate(vpwo,Bankang)
         if (Bankang == 0.0)  {
                gRot = 0.0
         }
}

proc WindTri (wdir,  wspeed,   tas, hd , gt)
{
// c^2 = a^2 +b^2 - 2ab Cos C
// given WS,WD and TAS and HD compute GS,GT

  float b = wspeed
  float a = tas
  float c //  ground speed

  float A
  float B
  float Cwtri
  float wca 

// zero case

//<<" %V $wspeed  $wdir $tas $hd \n"

// right or left of course ??
     dw = wdir -hd
     loc = 1

     if (dw < 0) {
        dw += 360
     }

    if (dw < 180) {

      loc = 0
    }

//  head or tail wind ??

hwind = 0

    if (( dw < 90) || (dw > 270)) {
  //    <<" Hwind \n"
      hwind = 1
    }


    if (a == 0.0) {
      // drifting with the wind??
      // vertical velocity??
        Gspeed = wspeed
        Gtrack = fmod(wdir + 180, 360);
        return Gspeed
    }

// negative case 

    if (a < 0 ) {
      // drifting with the wind??
      // vertical velocity??
         a *= -1;
         hd = fmod((hd + 180), 360)
    }


  owdir = fmod((wdir + 180), 360)

// head or tail wind ??
//<<"%v $owdir \n"
  

  Cwtri = fabs(wdir - hd)

//<<" $Cwtri \n"

  if (Cwtri == 0.0) {
// just add
    gs = tas - wspeed
    Gspeed = gs
    Gtrack = hd
    gt = hd
    return gs
  }

  if (Cwtri == 180.0) {
// just add
    gs = tas + wspeed
    Gtrack = hd
    Gspeed = gs
    gt = hd
    return gs
  }




// use cosine form
  cr = d2r(Cwtri)

  bc = a*a + b*b - 2 * a * b * Cos(cr)

//<<" $bc \n"

  gs = Sqrt(bc) 

//<<" $gs \n"

// now find wca

  num = (wspeed * wspeed - gs * gs - tas * tas )

  denom = ( -2 * gs * tas )

  wca = 0.0

  if (denom != 0.0) {
   cr = acos( num / denom )
   wca = r2d(cr)
  }
//<<"%v $wca \n"

  if (!loc) {
      wca *=  -1
  }

  Gtrack = hd + wca
  Gspeed = gs

  gt = Gtrack

  return gs
}



proc GetHGS ( wdir, wspeed,   tas, gtrack , xx)
{
// given WS,WD and TAS and HD compute GS,GT
// wind aloft given in knots and True direction

   Gtrack = gtrack

   rwdir =  fmod((wdir + 180), 360)

// angle between TN and wind

   wa = fmod(rwdir -360, 360)

//   <<"%V $wdir  $wspeed   $tas  $gtrack \n"
//   <<" $wa $rwdir \n"

   if (wa < 0) {
      wa += 360
   }




   ga = fmod(gtrack - 360, 360)

   if (ga < 0) {
      ga += 360
   }


 // angle between gtrack and the  dir the wind is blowing to !


   wdt = fabs(ga - wa)

//   <<"%V $ga $wa $rwdir   $wdt\n"

   if (wdt > 180) {
      wdt = 360 - wdt
   }

//   <<"%V $ga $wa $rwdir   $wdt\n"

#{
   if (wa > 180) {
      wa = 360 - wa
   }
#}

   dw = wdir - gtrack
     loc = 1
     if (dw < 0) {
        dw += 360
     }

    if (dw < 180) {
      loc = 0
    }

   if (wdt > 180) {
       wdt -= 180
   }


//<<" %V %5.1f $wdir $gtrack $rwdir $wa $ga $wdt %d $loc \n" 

   if (wdt == 180.0) {
         Gspeed = tas - Windspeed
         Heading = gtrack
         <<" direct HW \n"
         
   }

  else {

// angle between heading and gtrack

  asa = wspeed/ tas * sin (d2r(wdt))

//<<" %v $asa \n"

  if ( (asa < -1) || (asa > 1)) {

    <<" ERROR wind too strong to keep on track !! \n"
     Heading = wdir
     Gspeed = Windspeed - tas
     Gtrack = rwdir
  }

  else {

  wcar = asin( asa )

  wca = r2d(wcar)

//<<"%V $wcar  $wca  \n"

  if (wca < 0) 
      wca *= -1

  if (loc) {
  Heading = gtrack - wca
  }
  else {
  Heading = gtrack + wca
  }

  if (Heading < 0) {
      Heading += 360
  }
// now gspeed


// <<"%V $wca $wdt \n"

   Cwtri= ( 180 - (wca + wdt))


//<<" %v $Cwtri \n"


  backtrack = 0
  if (Cwtri < 0) {
<<"ERROR will be going backwards !!\n"
  backtrack = 1
  }


   gs = Sqrt( tas * tas + wspeed * wspeed - 2 * tas * wspeed * Cos(d2r(Cwtri)))

   if (backtrack) {
    gs *= -1
   }



   Gspeed = gs 
   xx = gs
  }
 }

  if (Heading > 360) {
      Heading -= 360
  }

  if (Heading < 0) {
      Heading += 360
  }

//  <<"%V %5.1f $Heading  Deg %12.6f  $gs Knots\n"


}

// POLAR QUAD COEFFS

qa = 0.082025 
qb = -6.069850 
qc = 216.546036

VB_ms = 37.0
VB_vne = 140.0

int Under_power = -1

proc PolarSpeed (in_knts)
{
// out is sink fpm
// applied polar of glider here
// VentusB coffs : qa 0.082025 qb -6.069850 qc 216.546036
// Stalled

   if (in_knts <30) {
     out_fpm = 1000  
   }
   else {
      out_fpm = qa * in_knts * in_knts + qb * in_knts + qc 
   }

   if (Under_power == 1) {

        out_fpm = 0
//<<" Under_power - no _sink !! $out_fpm \n"
   }

//<<" $in_knts $out_fpm \n"
   return out_fpm
}


proc SpeedToFly( wm  , ecl  )
{
// given wind, loading, alt  --- what is correct speed to fly
// maximize cruise speed ??
// wm is sink of airmass 
//  ecl is expected lift
//   


    qnum = (qc + wm  + ecl)
    if (qnum < 0) {
           // return min_sink
          
         return VB_ms 

    }

    vstf = Sqrt ( qnum / qa )

    if (vstf < VB_ms) {
       vstf = VB_ms
    }

// will depend on alt
    if (vstf > VB_vne) {
       vstf = VB_vne
    }

    return vstf
}





float mzoom = 0.75
proc UpdateMap()
{
         setgwob(mapwo, "scales", obpx+mzoom, obpz-mzoom, obpx-mzoom, obpz+mzoom )
         setgwob(mapwo,"drawoff","clear","clearpixmap")
         DrawMap(mapwo)
         setgwob(mapwo,"drawon")
         DrawGline(igc_gl)
         plotgw(mapwo,"symbol",obpx,obpz,"diamond",5,"red",0)
         
         setgwob(mapwo,"showpixmap","drawon")
}



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



//////////////////////////  ATMOSPHERE --- LIFT/SINK ///////////////////////////////////////////////////////

float Clift = 10.0
float Bamlift = 10.0

proc LiftSink(m )
{
// every x secs get new trend

     clift = 30.0 * Grand() * m 
 //    Clift = clift
     return clift
}

proc SetLift()
{

   Clift = 500.0 * Grand()


}

////////////////////////////////////////////////////////////////////////////////////////////////////////////






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


proc ArrivalMode()
{
            ReplayRate = 1.0
            RollTo(-5)
            flyto = 0
}



proc JumpTo( whereto )
{
<<" $_cproc $whereto  \n"

 where_key = FindKey(whereto)

<<" $whereto $where_key \n"
 Setgwob(jumptowo,"value", whereto, "redraw" ,"showpixmap") 

 if (where_key != -1) {
   where_pz =  Wtp[where_key]->Ladeg
   where_px = Wtp[where_key]->Longdeg
<<" found airport $where_pz $where_px \n"
   obpz = where_pz
   obpx = where_px

 }


}





proc Glide( secs )
{
float df
// Random lift Sink
   Sinkrate = PolarSpeed(Aspeed)

    mins = secs / 60.0

    Sinkrate += Grand() * 2

//<<"%V $mins  $Sinkrate \n"

    df =  mins * Sinkrate * -1.0 + LiftSink(mins)
    df =  mins * Sinkrate * -1.0 + Clift * mins + Bamlift * mins

    Sinkrate += Clift

    df /= ReplayRate

    //<<" %v $df \n"

    AltitudeR(df)

    CheckSpeed()    
}


//  Turn
//   CF = W*V^2 / (g * R)
//   R  = V^2 / (32.16 * tan( phi))     fps
//   R = V^2/ (11.26 * tan(phi))     knots
//   Rot =  1091 * tan(phi)/ V     knots



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

proc foo(ang)
{
float tang 
    tang = ang + 45
    tang =pol2cdir( tang)
    return tang
}


proc pol2cdir( ang)
{
//  fix_ME !! --- proc declaration nested depth two ---causes malloc/free crash 
//  fixed ?? 1.2.28 

float cd   


  cd =  450.0 - ang  

     if (cd > 360.0) {
       cd -= 360.0
     }

 <<"%V $cd $ang\n"

    return cd
}

float Aspeed

float dm


proc Move_vec( t)
{

float tradius
float phi
float ta
float tar
float dz
float dx


          Aspeed = Kspeed(Speed)

	    if (roll_dba) {
               RollToDBA(t)
            }

          vgt = 0



          dm = (t/3600.0 * Gspeed) * 1.852
//<<"%v $t $Gspeed $dm \n"

// km moved since last update

          if (Bankang  != 0.0 ) {

// need to deal with > 0 < 90 > 90 < 180 - inverted turn

             phi = d2r(Bankang)

//<<" %v $phi $(Caz(phi)) \n"

             phi = tan(phi)

//<<" %V $phi $Speed \n"

             tradius = (Speed * Speed) / (32.16 * phi)

//<<" %V $Bankang $phi $tradius  $Heading\n"

             gRot = 1091.0 * phi / Kspeed(Speed)


             ta = (gRot * t)

             Heading += ta

             if (Heading < 0) {
                 Heading += 360
             }

             Heading = fmod(Heading, 360)

//<<" %v $tradius %v $rot  $ta $Heading\n"

             tar = d2R(ta)

             dz = tradius * Sin(tar)
             dx = tradius - (tradius * Cos(tar))

// convert into lat,long
//             dm = Sqrt(dx *dx + dz *dz )



//<<" %V $dx $dz \n"

          WindTri ( Winddir, Windspeed, Aspeed, Heading , &vgt)

   if (!flyto) {
               Dtc = Heading

               }

         }

          else {

                  GetHGS(Winddir, Windspeed, Aspeed, Dtc, &vgt )

          }

          np = latlongfromRadialOpaD(Gtrack, obpz,obpx, dm)

          kmdm = HowFar(obpz,obpx, np[0], np[1])

          obpz = np[0]
          obpx = np[1]

//<<" %V $t $Gspeed $Gtrack  $dm $kmdm  $obpz $obpx\n"

 //        if (!flyto) {
 //         na = foo(Heading)
 //  <<" $na \n"
 //       }

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


<<" Done GlideFuncs \n"
///////////////////////////////////////////////////////////////////////////
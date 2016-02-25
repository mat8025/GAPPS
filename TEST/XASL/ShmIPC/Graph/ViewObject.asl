# view 3D object

SetPCW("writeexe")


Main_init = 1

OpenDll("math")

set_ap(0)
SetDebug(0)


Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

float azim = 0.0
float elev = 0.0

float speed = 500.0

int scene[]


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


}



Event E

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

proc cd2pol( ang)
{
float cd
  cd =  450.0 - ang  
     if (cd > 360.0) {
       cd -= 360.0
     }
//<<"%V $cd $ang\n"

    return cd
}

proc cdir2pol( ang)
{
float cd
  cd =  450.0 - ang  

     if (cd > 360.0) {
       cd -= 360.0
     }
//<<"%V $cd $ang\n"
    return cd
}

proc rotate_vec( cdir)
{

         azim +=  cdir

}

proc look_to()
{
          rpx = 15

          ang = atan(MS[7]/rpx)
<<" %V $MS[7] $ang $rpx \n"
          dx = rpx * cos(ang)
          dy = rpx * sin(ang)
//          ang = atan((MS[8]-obpz)/rpx)
//<<" %V $MS[8] $ang $obpz \n"
 //         dz = rpx * cos(ang)
}


proc lookup( ve)
{
   elev += ve

}


proc move_to()
{
   if (E->button == 1) {
          obpx =  E->wms[7]
          obpz =  E->wms[8]
   }

   if (E->button == 4) {
          targ_x =  E->wms[7]
          targ_z =  E->wms[8]
   }


   r1 = Sqrt( (obpx - targ_x)^2 + (obpz - targ_z)^2 )

   ma = acos((obpx - targ_x)/r1)

   azim = r2d(ma) -90


}


proc circle_obs( cdir)
{
// current center is 0,0

          rpd =  100

          x1 = rpd * Cos(wang)
          y1 = rpd * Sin(wang)

          wang += d2r(cdir)
          wang = fmod(wang,2*Pi)

          x2 = rpd * Cos(wang)
          y2 = rpd * Sin(wang)

          obpx += (x1 - x2)
          obpz += (y1 - y2)

          wdeg = r2d(wang)
          azim = pol2cdir(wdeg)
          azim = fmod(azim , 360.0)

//<<" %V $cdir $wang $azim $obpx $obpy $dx $dy\n"

}






proc roll ( cdir)
{
//<<" rolling $cdir \n"
          rpd = 10
          dx = rpd * Sin(rang)
          dz = rpd * Cos(rang)
          rang += (0.0175 * cdir)
          if (rang > 2*Pi){
                 rang = 0.0
          }
          if (rang < 0) {
             rang = 2*Pi -rang
          }

           WoSetRotate(vpwo,(rang/Pi * 180))
}



proc pitch ( cdir)
{
// azim will flip 180 if we go past 90/270
   old_e = elev
            elev += cdir
            elev = fmod(elev,360.0)
   if (elev < 0) {
    elev = 360.0 + elev
   }   

   if ((old_e < 90) && (elev >= 90)) {
       azim += 180
   }

   if ((old_e < 270) && (elev >= 270)) {
       azim += 180
   }

   if ((old_e > 90) && (elev <= 90)) {
       azim += 180
   }

   if ((old_e > 270) && (elev <= 270)) {
       azim += 180
   }

}


proc loop ( cdir)
{
//<<" pitching $cdir \n"

          rpd = 0.5

          pang += d2r(cdir)
          pang = fmod(pang,2*Pi)

          dz = rpd * Sin(pang)
          dy = rpd * Cos(pang)

          obpy += dy
          obpz += dz

<<"%V $dy $dz $obpy $obpz \n"
          pitch(cdir)

}


proc move_vec( mdir)
{
float ma
       // if banked keep vehicle turning

          if (rwa != 0.0) {
              rotate_vec(rwa * 0.125)
           }

          ma = cd2pol(azim)
          ma = d2r(ma)

          dx = mdir * Cos(ma )
          dz = mdir * Sin(ma)

          obpz += dz
          obpx += dx

//<<"mv %V $mdir $azim $obpx   $obpy  \n"

}


proc resetobs()
{

zalpha = 0
yalpha = 0
xalpha = 0
// observer position


obpx = 12    
obpz = -90
obpy = 1000

azim = 0.0
elev = 0.0

distance = 300
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
mapscale = 500

proc PlanView()
{

#{
     rx = obpx - mapscale
     rX = obpx + mapscale
     ry = obpz - mapscale
     rY = obpz + mapscale
#}

     rx =  -mapscale
     rX = mapscale
     ry = -mapscale
     rY = mapscale

//<<" %V $rx $rX \n"

     SetGwob(dpwo,"scales",rx,ry,rX,rY)
     SetGwob(dpwo,"clearpixmap")

     plot3D(dpwo,scene,obpx,obpy,obpz, azim, elev,distance,4)

     plotgw(dpwo,"symbol",obpx,obpz,"diamond",10,"blue",0)
     plotgw(dpwo,"symbol",obpx,obpz,"arrow",15,"blue",cd2pol(azim)-90,1)
     plotgw(dpwo,"symbol",targ_x,targ_z,"tri",7,"red",0)

     Setgwob(dpwo,"hue","black","showpixmap","save")

//     plotgw(dpwo,"symbol",obpx,obpz,"arrow",25,"blue",cd2pol(azim)-90,1)
//     plotgw(dpwo,"symbol",obpx,obpz,"tri",25,"blue",cd2pol(azim)-90,1)

     SetGwob(dpwo,"showpixmap")

}

proc SideView()
{
     float srx = obpx - mapscale
     float srX = obpx + mapscale
     float sry =  -50
     float srY =  50

//<<" %V $rx $rX \n"

     SetGwob(epwo,"scales",srx,sry,srX,srY)

     SetGwob(epwo,"clearpixmap")
     plot3D(epwo,scene,obpx,obpy,obpz,azim,elev,distance,2)
     SetGwob(epwo,"showpixmap")

}




//fname = "cube"

fname = GetArgStr()
<<" %v $fname \n"

//fname = "top"
   scene = CreateScene(fname)

if ( ! fname @= "") {

<<" $scene \n"
<<" read scene \n"

}



//  we know have some objects 

//   obid = MakeObject("G_CUBE",0,0,0,1,1,1,5)

#{

   for (i= 0; i < 2; i++) {
     obid = MakeObject("G_CUBE",i*100,0,350,1,1,1,5)
   <<" $i $obid \n"
  }


   for (i= 0; i < 10; i++) {
     obid = MakeObject("G_PYRAMID",i*100,0,250,1,1,1,2)
   <<" $i $obid \n"
  }
#}



  vp = CreateGwindow("title","vp","resize",0.1,0.01,0.9,0.95,0)

  SetGwindow(vp,"scales",-200,-200,200,200,0, "drawoff","pixmapon","save","bhue","white")
  SetGwindow(vp,"clip",0.01,0.1,0.95,0.99)


  vptxt=CreateGWOB(vp,"TEXT","resize_fr",0.1,0.01,0.75,0.1,"name","TXT","color","blue")

  vpwo=CreateGWOB(vp,"GRAPH","resize",0,0.2,0.11,0.95,0.95,"name","VP","color","white")
  setgwob(vpwo,"scales",-200,-200,200,200, "save","redraw","drawoff","pixmapon")

  dpwo = CreateGWOB(vp,"GRAPH","resize",0,0.01,0.11,0.19,0.5,"name","VP","color","white")
  setgwob(dpwo,"scales",-200,-200,200,200, "save","redraw","drawoff","pixmapon")

  epwo = CreateGWOB(vp,"GRAPH","resize",0,0.01,0.51,0.19,0.95,"name","VP","color","white")
  SetGwob(epwo,"scales",-100,-50,100,50, "save","redraw")



float obpx = 30
float obpy = 10
float obpz = -25


float targ_x = 0
float targ_y = 10
float targ_z = 35


obsdz = 2
float distance = 100.0
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


do_sidev = 0
zmn = 1
type = 1
len = 1
wid = 1


zdst = 1
togd = 1
toga = 1
rotd = 2
rang = 1


int Minfo[]

 Map = ReadDEM("GTO/W020N90.DEM")
 nrr = SetDEM(Map)


  resetobs()

  plot3D(vpwo,scene,obpx,obpy,obpz,azim,elev,distance)


  viewlock = 1
  driving = 0
  cullit = 1  

  wang = Pi/2.0
  rang = 0.01
  pang = 0.01
  float rwa = 0.0
 wobj = 0
 allobjs = -1
// rotation applied to all objs
  hx = 50
  hy = 10

  float MS[16]

  SideView()

  svar msg

  while (1) {

    w_activate(vp)

    E->Wait()

   did_cont = 0

    msg = E->msg

   if ( ! (msg @= "NO_MSG")) {

//<<"%v $msg \n"

    zmn = msg 
    woid = Minfo[3]

    did_cont = 1

      if (msg @= "EVENT") {
          if (E->wid == dpwo) {
             move_to()
          }
      }

      if (msg @= "EVENT") {
          if (E->wid == ep) {
             look_to()
          }
      }


      if (msg @= "Q") {
          rotate_vec(-2)
      }

      if (msg @= "L") {
          circle_obs(2.0)
      }

      if (msg @= "N") {
          circle_obs(-2.0)
      }

      if (msg @= "S") {
          rotate_vec(2)
      }


      if (msg @= "[") {
          roll(-2)
      }

      if (msg @= "]") {
          roll(2)
      }

      if (msg @= "8") {
          pitch(-2)
      }

      if (msg @= "9") {
          pitch(2)
      }

      if (msg @= "6") {
          loop(-2)
      }

      if (msg @= "7") {
          loop(2)
      }




      if (msg @= "M") {
          MoveObject(0,2,0,0)
      }

      if (msg @= "m") {
          MoveObject(0,-2,0,0)
      }

      if (msg @= "H") {
          MoveObject(0,0,2,0)
      }

      if (msg @= "h") {
          MoveObject(0,0,-2,0)
      }




      if (msg @= "R") {
        move_vec(speed)
      }

      if (msg @= "T") {
          move_vec (-speed)
      }


      if (msg @= "l") {
          obpx += 2
      }

      if (msg @= "k") {
          obpx -= 2
      }

      if (msg @= "K") {

          cullit *= -1

          cullface(cullit)
      }

      if (msg @= "l") {
          obpx += 2
      }


      if (msg @= "g") {
                            move_vec(-speed)
      }

      if (msg @= "f") {
                  move_vec(speed)
      }

      if (msg @= "y") {
          rotate_vec(5)
      }

      if (msg @= "u") {
          rotate_vec(speed)
      }

    if (msg @= "p") {
          obpy += 2
          //obsdz += 2
    }


    if (msg @= "o") {
          obpy -= 2
    }

    if (msg @= "i") {
          elev -= 2
    }

    if (msg @= "I") {
          elev += 2
    }



    if (msg @= "/") {
       driving = 1
     }

    if (msg @= ".") {
       driving = 0
     }

    if (msg @= "d") {
       distance *= 0.9
    }

    if (msg @= "D") {
       distance *= 1.1
    }


    if (msg @= "c") {
        rwa -= 2.0
       WoSetRotate(vpwo,rwa)
//<<"%v $rwa \n"
    }

    if (msg @= "v") {
        rwa += 2.0
       WoSetRotate(vpwo,rwa)
    }


    if (msg @= "x") {
          MoveObject(wobj,0,0,2)
    }

    if (msg @= "X") {
          MoveObject(wobj,0,0,-2)
    }



    if (msg @= "a") {
       // rotate obj 0

//        RotateObject(allobjs,0,0,10.0)

        RotateObject(wobj,0,0,10.0)
    }

    if (msg @= "s") {
       // rotate obj 0

        RotateObject(wobj,0,0,-10.0)
    }


    if (msg @= "q") {
       // rotate obj 0
        RotateObject(wobj,10,0,0.0)
    }

    if (msg @= "w") {
       // rotate obj 0
        RotateObject(wobj,-10,0,0.0)
    }

    if (msg @= "e") {
       // rotate obj 0
        RotateObject(wobj,0,10,0.0)
    }

    if (msg @= "r") {
       // rotate obj 0
        RotateObject(wobj,0,-10,0.0)
    }


      if (msg @= "Z") {
            resetobs()
      }


    }



 if (did_cont) {

   azim = fmod(azim,360.0)

   if (azim < 0) {
    azim = 360.0 + azim
   }   

   elev = fmod(elev,360.0)

   if (elev < 0) {
    elev = 360.0 + elev
   }   


    Setgwob(vpwo,"clearpixmap") 
    plot3D(vpwo,scene,obpx,obpy,obpz, azim, elev,distance,1,1)
    SetGwob(vpwo,"showpixmap","clipborder") 

    setgwob(vptxt,"redraw")
    Text(vptxt,"%5.1f $obpx,$obpy,$obpz az $azim el $elev  D $distance",0,0.05,1)

     PlanView()

     if (do_sidev) {
        SideView()
     }
 }

     gsync()

}



STOP("DONE !\n")



// TO DO
// clip out object if it is behind observer -DONE
// only process subset of objects in front
// reduced detail on objects too far in front to resolve
// set grid -- surface - read elevation from map
// threaded operation  --- control input and drawing 
// linear interpolation of objects -long lines generate pt per resolution
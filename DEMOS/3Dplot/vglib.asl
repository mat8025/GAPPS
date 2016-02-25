


proc pol2cdir( ang)
{
  float cd
  cd =  450.0 - ang  

     if (cd > 360.0) {
       cd -= 360.0
     }
//<<"%V$cd $ang\n"
    return cd
}

proc cd2pol( ang)
{
float cd
  cd =  450.0 - ang  
     if (cd > 360.0) {
       cd -= 360.0
     }
//<<"%V$cd $ang\n"

    return cd
}

proc cdir2pol( ang)
{
float cd
  cd =  450.0 - ang  

     if (cd > 360.0) {
       cd -= 360.0
     }
//<<"%V$cd $ang\n"
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
//<<" %V$MS[7] $ang $rpx \n"
          dx = rpx * cos(ang)
          dy = rpx * sin(ang)
//          ang = atan((MS[8]-obpz)/rpx)
//<<" %V$MS[8] $ang $obpz \n"
//         dz = rpx * cos(ang)
}


proc lookup( ve)
{
   elev += ve
}

proc xy_move_to(button,rx,ry)
{
   if (button == 1) {
          obpx =  rx
          obpy =  ry
     <<" moving observer $obpx $obpy \n"
   }

   if (button == 3) {
          targ_x =  rx
          targ_y =  ry
//<<" moving target $targ_x $targ_z \n"
   }
}

proc look_at()
{
// how about elev ??

   zdir = obpz - targ_z
   xdir = obpx - targ_x
   ydir = targ_y -obpy


   ss= xdir * xdir  + zdir * zdir 

   //r1 = Sqrt( ss )

   r1 = Sqrt( (xdir) * (xdir)  + (zdir) * (zdir) )

   acr = 0.0

   if (r1 != 0.0) {
   acr= xdir /r1 

 //  ma = acos( xdir /r1 )
   }
 
   ma = acos( acr)

   mad = r2d(ma)

   pazim = r2d(ma) 

   if (zdir > 0) {
    if (xdir > 0) {
     azim = -(pazim + 90)
    }
    else {
     azim =  (270 - pazim) 
    }
   }
   else {
     azim = pazim - 90
   }


#{
/////////
   r1 = Sqrt( (xdir) * (xdir)  + (ydir) * (ydir) )

   if (r1 != 0.0) {

     acr= ydir /r1 
 
     ma = asin( acr)

     elev = r2d(ma)

   }
#}


}


proc xz_move_to(button,rx,ry)
{

   if (button == 1) {
          obpx =  rx
          obpz = ry
<<" moving observer $obpx $obpz \n"
   }


   if (button == 3) {
          targ_x =  rx
          targ_z = ry
//<<" moving target $targ_x $targ_z \n"
   }

}


proc circle_obs( cdir)
{
//  center is 0,0

          rpd =  300

          x1 = rpd * Cos(wang)
          z1 = rpd * Sin(wang)

          wang += d2r(cdir)
          wang = fmod(wang,2*Pi)
          obpx = targ_x + x1
          obpz = targ_z + z1

          wdeg = r2d(wang)
          azim = pol2cdir(wdeg)
          azim += 180
          azim = fmod(azim , 360.0)

//<<" %V$cdir $wang $azim $obpx $obpy $dx $dy\n"

}

proc loop_obs( cdir)
{

//  center is 0,0
//  loop/circle should be able to occur in any plane
//  for now X/Y

          rpd =  200

          x1 = rpd * Cos(wang)
          y1 = rpd * Sin(wang)

          wang += d2r(cdir)
          wang = fmod(wang,2*Pi)
          obpx = targ_x + x1
          obpy = targ_y + y1

          wdeg = r2d(wang)

// leave azim alone

#{
          azim = pol2cdir(wdeg)
          azim += 180
          azim = fmod(azim , 360.0)
#}

//<<" %V$cdir $wang $azim $obpx $obpy $dx $dy\n"

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

//<<"%V$dy $dz $obpy $obpz \n"
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

//<<"mv %V$mdir $azim $obpx   $obpy  \n"

}





proc resetobs(ww)
{

zalpha = 0
yalpha = 0
xalpha = 0
// observer position

if (ww == 1) {
  obpx = 0    
  obpy = 50
  obpz = -250
  azim = 5.0
  elev = 0.0
}

if (ww == 2) {
  obpx = 200    
  obpy = 50
  obpz = 10
  azim = 270.0
  elev = 0.0
}

if (ww == 3) {
  obpx = 10    
  obpy = 50
  obpz = 200
  azim = 180.0
  elev = 0.0
}

if (ww == 4) {
  obpx = -250    
  obpy = 50
  obpz = 10
  azim = 90.0
  elev = 0.0
}

if (ww == 5) {
 // on top -- looking down
   obpx = 10    
   obpy = 200
   obpz = 10
   azim = 0.0
   elev = -90.0
}

if (ww == 6) {
 // underneath -- looking up
   obpx = 10    
   obpy = -200
   obpz = 10
   azim = 0.0
   elev = 90.0
}


distance = 50
radius = 50

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



proc center_map()
{


     rx = obpx - mapscale
     rX = obpx + mapscale
     ry = obpz - mapscale
     rY = obpz + mapscale

     SetGwob(pvwo,"scales",rx,ry,rX,rY)

}

proc map_home()
{
     rx =  -mapscale
     rX = mapscale
     ry = -mapscale
     rY = mapscale

//<<" %V$rx $rX \n"

     SetGwob(pvwo,"scales",rx,ry,rX,rY)
}


proc PlanView()
{

     SetGwob(pvwo,@clearpixmap)

     plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1,  GridON)

     plotgw(pvwo,"symbol",obpx,obpz,"diamond",10,"blue",0)
     plotgw(pvwo,"symbol",obpx,obpz,"arrow",15,"blue",cd2pol(azim)-90,1)

     plotgw(pvwo,"symbol",targ_x,targ_z,"tri",7,"red",0)

     Setgwob(pvwo,@hue,"black",@showpixmap,@clipborder,@save)


//     plotgw(pvwo,"symbol",obpx,obpz,"arrow",25,"blue",cd2pol(azim)-90,1)
//     plotgw(pvwo,"symbol",obpx,obpz,"tri",25,"blue",cd2pol(azim)-90,1)


}

proc SideView()
{

#{
     float srx = obpx - mapscale
     float srX = obpx + mapscale
     float sry =  -50
     float srY =  50
#}

     float srx =  -mapscale
     srX = mapscale
     sry = -mapscale/2
     srY = mapscale


//<<" %V$rx $rX \n"

     SetGwob(svwo,"scales",srx,sry,srX,srY)

     SetGwob(svwo,@clearpixmap)

     //plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1)


     plot3D(svwo,scene,obpx,obpy,obpz,azim,elev,distance,2,1)
     plotgw(svwo,"symbol",targ_x,targ_y,"tri",7,"red",0)
     plotgw(svwo,"symbol",obpx,obpy,"diamond",10,"green",0)

     //SetGwob(svwo,"showpixmap")
     Setgwob(svwo,@hue,"black",@showpixmap,@save,@clipborder)
}



/////////////////////// KEYBD CONTROL ////////////////////////////////////////

proc checkRotate(key)
{
 ret = 0
<<"$_proc $key\n"
      if (key @= "S") {
          rotate_vec(2)
          ret = 1
          setgwob(vptxt,"red",@textr,"S rotate ",0,-0.2) 
      }
      else if (key @= "Q") {
          rotate_vec(-2)
          setgwob(vptxt,"red",@textr,"R rotate ",0,-0.2) 
          ret = 1
      }

   return ret
}

proc checkRoll(key)
{
 ret = 0
<<"$_proc $key\n"
      if (key @= "[") {
          roll(-2)
          ret = 1
          setgwob(vptxt,"red",@textr,"[ roll ",0,-0.2) 
      }

      else if (key @= "]") {
          roll(2)
          ret = 1
          setgwob(vptxt,"red",@textr,"] roll ",0,-0.2) 
      }

   return ret
}


proc checkMove(key)
{
 ret = 0
<<"$_proc $key\n"

      if (key @= "R") {
        go_straight = 1
        move_vec(2.0)
        ret = 1
        setgwob(vptxt,"red",@textr,"R move forward ",0,-0.2) 
      }
      else if (key @= "T") {
        go_straight = 1
        move_vec(-2.0)
        ret = 1
        setgwob(vptxt,"red",@textr,"T move back ",0,-0.2) 
      }

  return ret
}

proc checkObserver(key)
{
 ret = 1
<<"$_proc $key\n"
    if (key @= "y") {
          obpy += 2
    }

    else if (key @= "Y") {
          obpy -= 2
    }

    else if (key @= "z") {
          obpz += 2

    }

    else if (key @= "Z") {
          obpz -= 2
    }

    else  if (key @= "x") {
          obpx += 2
    }

   else if (key @= "X") {
          obpx -= 2
   }
   else {
        ret = 0
   }
   
   if (ret == 1) {

          setgwob(vptxt,"red",@textr,"$key  Observer posn  ",0,-0.2) 
   }

     return ret
}

proc keyControls(key)

{
<<"$_proc $key\n"

     // key = E->geteventKey()

      if (checkRotate(key)) {
          return 1 
      }

      if (checkRoll(key)) {
          return 1 
      }

      if (checkMove(key)) {
          return 1 
      }

      if (checkObserver(key)) {
          return 1 
      }


      if (key @= "L") {
          go_circle = 1
          go_on = 1
          cir_d = 0.5
          go_straight = 0
      }

      else if (key @= "N") {
          go_circle = -1
          cir_d = -0.25
          go_on = 1
          go_straight = 0
      }


      if (key @= "8") {
          pitch(-2)
      }

      else if (key @= "9") {
          pitch(2)
      }

      else if (key @= "6") {
          go_on = 1
          go_loop = 1
      }

      else if (key @= "7") {
          loop(2)
      }


      if (key @= "M") {
          MoveObject(wobj,2,0,0)
      }

      else if (key @= "m") {
          MoveObject(wobj,-2,0,0)
      }

      if (key @= "H") {
          MoveObject(wobj,0,2,0)
      }

      else if (key @= "h") {
          MoveObject(wobj,0,-2,0)
      }

      if (key @= "K") {

          cullit *= -1

          cullface(cullit)
      }

      if (key @= "l") {
//          obpx += 2
      }


      if (key @= "g") {

          //GridON = !GridON
          
      }



      if (key @= "f") {
                  go_on = 1
                  o_speed = 2.0
                  go_rotate = 0
                  go_circle = 0
                  go_straight = 1

      }

      else if (key @= "p") {
          go_rotate = 1
          rotate_vec(5)
          go_circle = 0
      }

      else if (key @= "o") {
          go_rotate = 1
          rotate_vec(speed)
          go_circle = 0
      }

    if (key @= "i") {
          elev -= 2
          if (elev < -90)
              elev = -90.0
    }

    else if (key @= "I") {
          elev += 2
          if (elev > 90)
              elev = 90
    }



    if (key @= "/") {
       resetobs(2)
     }

    if (key @= ".") {
         go_on = 0
         go_loop = 0
         go_circle = 0
//       resetobs(3)
     }

     if (key @= ",") {

     // make observer postion center of map
        center_map()  
     }

    if (key @= "?") {
       resetobs(5)
     }

    if (key @= ";") {
//       resetobs(6)
        go_on = 0
        go_straight = 0
     }


    if (key @= "d") {
       distance *= 0.9
    }

    else if (key @= "D") {
       distance *= 1.1
    }


    if (key @= "c") {
        rwa -= 2.0
       WoSetRotate(vpwo,rwa)
//<<"%v $rwa \n"
    }

    if (key @= "v") {
        rwa += 2.0
       WoSetRotate(vpwo,rwa)
    }


      if (key @= "l") {
        go_on = 0
          MoveObject(wobj,0,0,2)
      }


      if (key @= ":") {
        go_on = 0
          MoveObject(wobj,0,0,-1)
      }



    if (key @= "a") {
       // rotate obj 0

//        RotateObject(allobjs,0,0,10.0)

        RotateObject(wobj,0,0,4.0)
    }

    if (key @= "s") {
        RotateObject(wobj,0,0,-2.0)
    }


    else if (key @= "q") {
       // rotate obj 0
        RotateObject(wobj,4,0,0.0)
    }

    else if (key @= "w") {
       // rotate obj 0
        RotateObject(wobj,-2,0,0.0)
    }

    else if (key @= "e") {
       // rotate obj 0
        RotateObject(wobj,0,4,0.0)
    }

    else if (key @= "r") {
       // rotate obj 0
        RotateObject(wobj,0,-2,0.0)
    }


      if (key @= "'") {
            resetobs(1)
      }
}

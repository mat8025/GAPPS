#
# view 3D object
#

//  TBD
//  fix wire mode -- missing outline
//  toggle fill mode
//  menu to select object --- cube , pyramid , diamond  ...
//  add other objects
//  select  object to move rotate



Main_init = 1

set_ap(0)

//SetDebug(1)

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

////////////////////////////////

 // aslw = asl_w("VO")   // function missing in XGS??

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
\\---------------------------------------

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
//---------------------------------------------


proc lookup( ve)
{
   elev += ve
}
//---------------------------------------------

proc xy_move_to()
{

   if (Ebutton == 1) {
          obpx =  Erx
          obpy =  Ery
     <<" moving observer $obpx $obpy \n"
   }

   if (Ebutton == 3) {
          targ_x =  Erx
          targ_y =  Ery
      <<" moving target $targ_x $targ_z \n"
   }


}
//---------------------------------------------

proc look_at()
{
// how about elev ??

   sWo(vptxt,@scrollclip,UP_,8,@textr,"$_proc %V$obpz $obpx ",0,-0.25) 

   zdir = obpz - targ_z
   xdir = obpx - targ_x
   ydir = targ_y -obpy

   ss= xdir * xdir  + zdir * zdir 

   r1 = Sqrt( (xdir) * (xdir)  + (zdir) * (zdir) )

   acr = 0.0

   if (r1 != 0.0) {

     acr= xdir /r1 

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

}
//---------------------------------------------


proc xz_move_to()
{

   if (Ebutton == 1) {
          obpx =  Erx
          obpz =  Ery
<<" moving observer $obpx $obpz \n"
   }

   if (Ebutton == 3) {
          targ_x =  Erx
          targ_z =  Ery
//<<" moving target $targ_x $targ_z \n"
   }
   

//<<"%V$pazim $azim $r1 $xdir $zdir $mad $ma\n"
}
//---------------------------------------------


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
//---------------------------------------------

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
//---------------------------------------------






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
//---------------------------------------------



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
//---------------------------------------------


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
//---------------------------------------------


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

<<"mv %V$mdir $azim $obpx $obpy  \n"

}
//---------------------------------------------


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


distance = 50;
radius = 50

}
//---------------------------------------------


proc rotate_z(n,dir)
{
       zalpha  += 2.0 * Pi / 360  * n * dir 
       obpx = radius * Cos(zalpha)
       obpy = radius * Sin(zalpha)
}
//---------------------------------------------


proc rotate_y(n,dir)
{
	 yalpha += 2.0 * Pi /  360 * n * dir 
         obpz = radius * Cos(yalpha)
	 obpx = radius * Sin(yalpha)
}
//---------------------------------------------


proc rotate_x(n,dir)
{
	 xalpha += 2.0 * Pi /  360 * n * dir
         obpy = radius * Cos(xalpha)
	 obpz = radius * Sin(xalpha)
}
//---------------------------------------------

dc = 0.0
oldcompass = 0
mapscale = 500



proc center_map()
{


     rx = obpx - mapscale
     rX = obpx + mapscale
     ry = obpz - mapscale
     rY = obpz + mapscale

     SWo(pvwo,"scales",rx,ry,rX,rY)

}
//---------------------------------------------

proc map_home()
{
     rx =  -mapscale
     rX = mapscale
     ry = -mapscale
     rY = mapscale

//<<" %V$rx $rX \n"

     SWo(pvwo,"scales",rx,ry,rX,rY)
}
//---------------------------------------------
//-------------------------------------------------

proc PlanView()
{
<<[CFH]" in $_proc \n"

     //sWo(vptxt,@scrollclip,UP_,8,@textr,"PlanView ",0,-0.2) 

     //SWo(pvwo,@clearpixmap)

     plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1,GridON)

     plotgw(pvwo,"symbol",obpx,obpz,"diamond",10,"blue",0)
     
     plotgw(pvwo,"symbol",obpx,obpz,"arrow",15,"blue",cd2pol(azim)-90,1)

     plotgw(pvwo,"symbol",targ_x,targ_z,"tri",7,"red",0)

     //SWo(pvwo,@hue,"black",@showpixmap,@clipborder,@save)


//     plotgw(pvwo,"symbol",obpx,obpz,"arrow",25,"blue",cd2pol(azim)-90,1)
//     plotgw(pvwo,"symbol",obpx,obpz,"tri",25,"blue",cd2pol(azim)-90,1)


}
//---------------------------------------------

proc SideView()
{
<<[CFH]" in $_proc \n"
     //sWo(vptxt,@scrollclip,UP_,8,@textr,"SideView ",0,-0.2) 


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

     SWo(svwo,"scales",srx,sry,srX,srY)

     //SWo(svwo,@clearpixmap)

     //plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1)


     plot3D(svwo,scene,obpx,obpy,obpz,azim,elev,distance,2,1)
     plotgw(svwo,"symbol",targ_x,targ_y,"tri",7,"red",0)
     plotgw(svwo,"symbol",obpx,obpy,"diamond",10,"green",0)

     //SWo(svwo,"showpixmap")
     //SWo(svwo,@hue,"black",@showpixmap,@save,@clipborder)
}
//---------------------------------------------

// Globals
int scene[]
int GridON = 0;

fname = getArgStr()

<<"%V$fname \n"

// no file -- then no objects

if ( ! (fname @= "") ) {

   scene = CreateScene(fname)

<<"array of object ids $scene \n"
<<" read scene \n"

   obid1 = MakeObject("G_CUBE",-200,0,50,1,1,1,50)

}
else {

//  we know we have to have some objects 
  
     obid1 = MakeObject("G_CUBE",-200,0,50,1,1,1,50)

<<"made simple cube to look at $obid1\n"

     scene[0] = obid1
}


  //obid9 = MakeObject("G_CUBE",0,200,50,1,1,1,50)

  //    RotateObject(obid9,180,0,0)

  obid2 = MakeObject("G_CUBE",200,0,400,1,1,1,75)
  scene[1] = obid2

  obid3 = MakeObject("G_CUBE",-400,0,800,20,1,1,10)
  scene[2] = obid3

<<"%V$obid3 \n"

<<"array of object ids $scene \n"

//        RotateObject(obid3,0,45,0)

  wobj = obid1


///////////////////////// SETUP WINDOWS AND WOBJS //////////////////////////////

  vp = CreateGwindow(@title,"vp",@resize,0.1,0.01,0.98,0.98,0)

  SetGwindow(vp,"clip",0.01,0.1,0.95,0.99)

  vptxt=cWo(vp,"TEXT",@name,"TXT",@resize,0.1,0.01,0.75,0.1,@color,"blue")

  sWo(vptxt,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw, @pixmapon, @drawon)

  sWo(vptxt,@scales,-1,-1,1,1)

  vpwo=cWo(vp,"GRAPH",@name,"VP",@resize,0.2,0.2,0.8,0.90,@color,"white")
  // pixmap draw error?
  sWo(vpwo,@scales,-20,-20,20,20, @save,@redraw,@drawoff,@pixmapoff,@drawon)


  pvwo = cWo(vp,"GRAPH",@resize,0.01,0.11,0.19,0.5,"name","PLANVIEW","color","white")

  sWo(pvwo,@scales,-200,-200,200,200, @save,@redraw,@drawoff,@pixmapon,@drawon,@savepixmap)

  svwo = cWo(vp,"GRAPH",@resize,0.01,0.51,0.19,0.95,@name,"SIDEVIEW","color","white")

  sWo(svwo,@scales,-200,-200,200,200, @save,@redraw,@drawoff,@pixmapon, @drawon,@savepixmap)


/////////////////////////////////////////////////// CONTROLS ////////////////////////////
 bx = 0.93
 bX = 0.99
 yht = 0.1
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 qwo=cWo(vp,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,bx,by,bX,bY)
 sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

 azimwo=cWo(vp,"BV",@name,"AZIM",@VALUE,"1.0",@color,"white")
 sWo(azimwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 distwo=cWo(vp,"BV",@name,"DIST",@VALUE,"1.0",@color,"white")
 sWo(distwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 elevwo=cWo(vp,"BV",@name,"ELEV",@VALUE,"1.0",@color,"white")
 sWo(elevwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 int conwos[] = {  azimwo, distwo, elevwo } 

 wo_vtile(conwos,bx,0.2,bX,0.75)

 sWo(conwos,@redraw)

/////////////////////////////////////////////////////////



proc checkEvents()
{
//   Mf = Split(msg)
   Etype = E->getEventType()

   E->getEventState(evs)

   Woname = E->getEventWoName()    
   
   
   Woid = E->getEventWoId()

   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   Ebutton = E->getEventButton()
   Ekeyc = E->getEventKey()
   Ekeyw = E->getEventKeyW()
   E->getEventRxy(Erx,Ery);
   
<<"%V $Etype $Woid  %c$Ekeyc\n"

if (Woid == qwo) {
       //deleteWin(vp)
       exit_gs()
   }
}
//----------------------------------------------
proc  checkGoDir(go_on)
{
int did_cont =0 
  if (go_on) {


     if (go_rotate) {
        rotate_vec(speed)
     } 

     if (go_circle) {
       circle_obs(cir_d)
    }

     if (go_loop) {
       loop_obs(cir_d)
     }

     if (go_straight) {
        <<" moving ON! \n"
         move_vec(o_speed)
     }

   did_cont = 1

  }
      return did_cont
}
//----------------------------------------------
/////////////////////// KEYBD CONTROL ////////////////////////////////////////

proc checkRotate(char wc)
{
 ret = 0

<<" in $_proc checkRotate $wc \n"

     switch (wc) {

     case 'Q':
          rotate_vec(-2)
          sWo(vptxt,@scrollclip,UP_,8,@textr,"R rotate ",0,-0.2) 
          ret = 1
      break;

     case 'S':
        <<" rotate S \n"
          rotate_vec(2)
          sWo(vptxt,@scrollclip,UP_,8,@textr,"S rotate ",0,-0.2) 
          ret = 1
      break;
     }


<<" out $_proc checkRotate $ret \n"

   return ret
}
//---------------------------------------------


proc checkRoll (char wc)
{
 ret = 0

//<<" in $_proc checkRoll $wc \n"

    switch (wc) {
       case '[':
          roll(-2)
          ret = 1
          sWo(vptxt,@scrollclip,UP_,8,@textr,"[ roll left",0,-0.25) 
       break;
       case ']':
          roll(2)
          ret = 1
          sWo(vptxt,@scrollclip,UP_,8,@textr,"] roll right",0,-0.25) 
          break;
      }

   return ret
}
//---------------------------------------------


proc checkMove(char wc)
{
 ret = 0

//<<" in $_proc checkMove $wc \n"

    switch (wc) {

        case 'R':
        go_straight = 1
        move_vec(2.0)
        ret = 1
        sWo(vptxt,@scrollclip,UP_,8,@textr,"$Enm R move forward ",0,-0.25) 
        break;

        case 'T':
        go_straight = 1
        move_vec(-2.0)
        ret = 1
        sWo(vptxt,@scrollclip,UP_,8,@textr,"$Enm T move back ",0,-0.25) 
        break;
      }

  return ret
}
//---------------------------------------------

proc checkObserver(char wc)
{
 ret = 1
//<<" in $_proc checkObserver $wc \n"

    switch (wc) {
     case 'y':
          obpy += 2
        <<"%V$obpy \n"
     break;
     case 'Y':
          obpy -= 2
     break;
     case 'z':
          obpz += 2
     break;
     case 'Z':
          obpz -= 2
     break;
     case 'x':
          obpx += 2
     break;
     case 'X':
          obpx -= 2
      break;
      default:
        ret = 0
     }

      if (ret == 1) {
          sWo(vptxt,@scrollclip,UP_,8,@textr,"$wc  Observer posn  ",0,-0.2) 
      }

     return ret
}
//---------------------------------------------

proc checkKeyCommands(char wc)
{
  ret = 1

<<" in $_proc $wc \n"

//    sWo(vptxt,@scrollclip,UP_,8,@textr,"$_proc $wc",0,-0.25) 

    switch (wc) {

      case 'H':
          MoveObject(wobj,0,2,0)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"MoveObject",0,-0.25) 
        break;
      case 'h':
          MoveObject(wobj,0,-2,0)
        break;
      case 'K':
          cullit *= -1
          cullface(cullit)
        break;
      case 'g':
          GridON = !GridON
        sWo(vptxt,@scrollclip,UP_,8,@textr,"Grid $GridON",0,-0.25) 
        break;
      case 'f':
          <<[CFH]"yep got go forward \n"
        sWo(vptxt,@scrollclip,UP_,8,@textr,"forward ",0,-0.25) 
                  go_on = 1
                  o_speed = 2.0
                  go_rotate = 0
                  go_circle = 0
                  go_straight = 1
        break;
      case 'p':
          go_rotate = 1
          rotate_vec(5)
          go_circle = 0
        sWo(vptxt,@scrollclip,UP_,8,@textr,"p rotate ",0,-0.25) 
        break;
      case 'o':
          go_rotate = 1
          rotate_vec(speed)
          sWo(vptxt,@scrollclip,UP_,8,@textr,"o rotate ",0,-0.25) 
          go_circle = 0
        break;
      case '//':
        resetobs(2)
        break;
      case '.':
         go_on = 0
         go_loop = 0
         go_circle = 0
         sWo(vptxt,@scrollclip,UP_,8,@textr,". stop ",0,-0.25) 
//       resetobs(3)
        break;
      case ',':
     // make observer postion center of map
        sWo(vptxt,@scrollclip,UP_,8,@textr,"center observer ",0,-0.25) 
        center_map()  
        break;
      case '?':
       resetobs(5)
        break;
      case ';':
//       resetobs(6)
        go_on = 0
        go_straight = 0
        break;
      case 'd':
        distance *= 0.9
        sWo(vptxt,@scrollclip,UP_,8,@textr,"distance $distance ",0,-0.25) 
        break;
      case 'D':
       distance *= 1.1
      sWo(vptxt,@scrollclip,UP_,8,@textr,"distance $distance ",0,-0.25) 
        break;
      case 'c':
       rwa -= 2.0
       WoSetRotate(vpwo,rwa)
//<<"%v $rwa \n"
        break;
      case 'v':
        rwa += 2.0
       WoSetRotate(vpwo,rwa)
        break;
      case 'l':   
        go_on = 0
          MoveObject(wobj,0,0,2)
        break;
//      case ':':   
//        go_on = 0
//          MoveObject(wobj,0,0,-1)
//        break;
      case 'a':   
        RotateObject(wobj,0,0,4.0)
       sWo(vptxt,@scrollclip,UP_,8,@textr,"a rotate object ",0,-0.25) 
            break;
      case 's':   
        RotateObject(wobj,0,0,-2.0)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"s rotate object ",0,-0.25) 
            break;
      case 'q':     // rotate obj 0
        RotateObject(wobj,4,0,0.0)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"q rotate object ",0,-0.25) 
            break;
      case 'w':     // rotate obj 0   
        RotateObject(wobj,-2,0,0.0)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"w rotate object ",0,-0.25) 
            break;
      case 'e':     // rotate obj 0
        RotateObject(wobj,0,4,0.0)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"e rotate object ",0,-0.25) 
            break;
      case 'r':   
       // rotate obj 0
        RotateObject(wobj,0,-2,0.0)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"r rotate object ",0,-0.25) 
            break;
      case '\'':   
        resetobs(1)
        sWo(vptxt,@scrollclip,UP_,8,@textr,"%c$wc reset obs ",0,-0.25) 
            break;
      default:
           ret = 0;
      }
//<<[CFH]" out $_proc \n"
  return ret
}
//------------------------------------------------


proc keyControls(char ac)
{

<<"in keyControls $_proc  $ac \n"

int did_con = 0

      if (checkRoll(ac)) {
   <<[CFH]" checkRoll \n"
//          return 1 
      }
      else if (checkMove(ac)) {
   <<[CFH]" checkMove \n"
         // return 1 
      }
      else if (checkObserver(ac)) {
          <<"observer control \n"
   <<[CFH]" checkObserver \n"
//          return 1 
      }
      else if (checkRotate(ac)) {
   <<[CFH]" checkRotate \n"

      }
      else if (checkKeyCommands( ac)) {
   <<" keycommands \n"
        // return 1 
      }

     else {

      switch (ac) {

      case 'L':
          go_circle = 1
          go_on = 1
          cir_d = 0.5
          go_straight = 0
          break;
      case 'N':
          go_circle = -1
          cir_d = -0.25
          go_on = 1
          go_straight = 0
          break;
      case 8:
          pitch(-2)
          break;
      case 9:
          pitch(2)
          break;
      case 6:
          go_on = 1
          go_loop = 1
          break;
      case 7:
          loop(2)
          break;
      case 'i':
          elev -= 2
             if (elev < -90) {
              elev = -90.0
             }
         sWo(vptxt,@scrollclip,UP_,8,@textr,"%$ac %V$elev ",0,-0.25) 
       break;
      case 'I':
          elev += 2
          if (elev > 90) {
              elev = 90
          }
         sWo(vptxt,@scrollclip,UP_,8,@textr,"%$ac %V$elev ",0,-0.25) 
       break;
       case 'M':
        MoveObject(wobj,2,0,0)
       break;
       case 'm':
        MoveObject(wobj,-2,0,0)
       break;

      }
    }
    
<<" out $_proc \n"
      return 1 
}
//---------------------------------------------



wobj = 2

Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

float azim = 45.0
float elev = 0.0

float speed = 2.0


  for (i = 0; i < 10; i++)
      scene[i] = -1

CFH = ofw("vo.debug")

////////////////////////////////////////////////////////////////////////////////////////


float obpx = -50
float obpy = 50
float obpz = -100


float targ_x = 0
float targ_y = 10
float targ_z = 35


obsdz = 2
float distance = 50.0;
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


 //Map = ReadDEM("GTO/W020N90.DEM")
 //nrr = SetDEM(Map)


   resetobs(1)

  // scene is array of objects 

  plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev, distance)


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

  float MS[16]

  float cir_d = 0.5

  SideView()

  int kev = 0
  int go_on = 0
  go_rotate = 0
  go_circle = 0
  go_loop = 0
  go_straight = 0
  o_speed = 0.5


  map_home()



  uint ml = 0

  look_at()

Svar msg



E =1; // event handle

int evs[20];


Woid = 0
Ewoname = ""
Woproc = "foo"
Woval = ""
int Woaw = 0
Erx=0.0;
Ery=0.0;
Ebutton = 0
char Ekeyc = 0;
Ekeyw = "";
Etype = "";
Emsg="";



  while (1) {

    ml++

<<"at xgs interact ! $ml\n"
    //<<"$kev %v $go_on \n"

   Emsg= E->waitForMsg()

   checkEvents()

   kev++

   did_cont = 0

   sWo(vptxt,@scrollclip,UP_,8,@clipborder,"red",@textr,Emsg,0,0.8) 

//<<"%V$svwo $pvwo $vpwo \n"

<<"%V$Ekeyw %c$Ekeyc %d$Ekeyc  $Ewoname\n"

    if (!(Ekeyc @="")) {
   <<[CFH]"$Ekeyw  %V%c$Ekeyc \n"
    }

// sWo(vptxt,@scrollclip,UP_,8,@textr,"$Enm $Ekeyw %c$Ekeyc %$Ewoname",0,0.1) 


      did_cont = 1

      if (Etype @= "PRESS") {

          <<"%V$Ekeyw  $Woid  $svwo $pvwo \n"

          if (Woid == svwo) {
             //look_to()
             <<" sv $svwo\n"
             xy_move_to()
             look_at()
          }

          if (Woid == pvwo) {
             <<" pv $pvwo \n"
             xz_move_to()
             look_at()
          }
      }
      else if (Etype @= "KEYPRESS") {

sWo(vptxt,@scrollclip,UP_,8,@clipborder,"blue",@textr," [%c${Ekeyc}] ",0,0) 

          keyControls(Ekeyc)

       sWo(azimwo,@VALUE, "%5.1f$azim" , @update)
       sWo(distwo,@VALUE, "%5.1f $distance" , @update)
       sWo(elevwo,@VALUE, "%5.1f$elev" , @update)

      }

    

<<"%V$ml $go_on $kev\n"
<<[CFH]"%V$ml $go_on \n"

   did_cont = checkGoDir()


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
       sWo(elevwo,@VALUE, "%5.1f$elev" , @update)

    //SWo(vpwo,@clearpixmap) 

     plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev,distance,1,1, GridON)

    //SWo(vpwo,@showpixmap,@clipborder) 

     txtmsg = "%V$obpx , %5.1f$obpy , $obpz , $azim , $elev , $o_speed"

//   sWo(two,@text,txtmsg, @update) //wrong woid  causes crash - should be robust

     sWo(vptxt,@text,txtmsg,@update) 

//<<"%5.1f %V$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

     PlanView()

     SideView()

     //sWo(vptxt,@clear,@clipborder,"red",@textr,Ekeyw,0,0) 
     //sleep(0.05)

     fflush(CFH)
  }


  if (scmp(Ewoname,"QUIT",4)) {
       break;
  }
    // sleep(0.1)

//     gsync()

 } // 

// may not want to exit window manager --- but for now
 exit_gs()

;

STOP("DONE !\n")

/{

 TO DO


 txt - display on coors, msg  current operation
 clip out object if it is behind observer -DONE
 
 only process subset of objects in front
 reduced detail on objects too far in front to resolve
 set grid -- surface - read elevation from map
 threaded operation  --- control input and drawing 
 linear interpolation of objects -long lines generate pt per resolution


 05/03/2013 
     --- busted --- is pixmap draw working --
     --- xgs crashing



/}



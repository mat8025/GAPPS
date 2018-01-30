///////////  view routines ////////////////
// maybe have C versions of these ///////

<<"start load lib\n"

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
//====================================

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
//====================================
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
//====================================

proc rotate_vec( cdir)
{
         azim +=  cdir
}
//====================================

proc look_to(rx)
{
          rpx = 15

          ang = atan(rx/rpx)
//<<" %V$MS[7] $ang $rpx \n"
          dx = rpx * cos(ang)
          dy = rpx * sin(ang)
//          ang = atan((MS[8]-obpz)/rpx)
//<<" %V$MS[8] $ang $obpz \n"
//         dz = rpx * cos(ang)
}
//====================================

proc lookup( ve)
{
   elev += ve
}
//====================================

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
 <<" moving target $targ_x $targ_z \n"
   }
}
//====================================


proc look_at()
{
// how about elev ??

<<" look_at \n"
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
     azim = pazim - 90;
     }
}
//---------------------------------

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
<<" moving target $targ_x $targ_z \n"
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
//======================================

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

//==========================================
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
//==========================================

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
//--------------------------------------------------------------------------

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
//==========================================

proc rotate_z(n,dir)
{
       zalpha  += 2.0 * Pi / 360  * n * dir 
       obpx = radius * Cos(zalpha)
       obpy = radius * Sin(zalpha)
}
//==========================================

proc rotate_y(n,dir)
{
	 yalpha += 2.0 * Pi /  360 * n * dir 
         obpz = radius * Cos(yalpha)
	 obpx = radius * Sin(yalpha)
}
//==========================================

proc rotate_x(n,dir)
{
	 xalpha += 2.0 * Pi /  360 * n * dir
         obpy = radius * Cos(xalpha)
	 obpz = radius * Sin(xalpha)
}
//==========================================

dc = 0.0
oldcompass = 0
mapscale = 500

//==========================================

proc center_map()
{
     rx = obpx - mapscale
     rX = obpx + mapscale
     ry = obpz - mapscale
     rY = obpz + mapscale

     sWo(pvwo,"scales",rx,ry,rX,rY)

}
//==========================================

proc map_home()
{
     rx =  -mapscale
     rX = mapscale
     ry = -mapscale
     rY = mapscale

//<<" %V$rx $rX \n"

     sWo(pvwo,"scales",rx,ry,rX,rY)
}
//==========================================

proc PlanView(plt_it)
{
     sWo(pvwo,@clearpixmap)

     if (plt_it) {
       plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1,  GridON)
     }
     
     plotgw(pvwo,@symbol,obpx,obpz,"diamond",3,"blue",0)
     plotgw(pvwo,@symbol,obpx,obpz,"arrow",2,"blue",cd2pol(azim)-90,1)
     plotgw(pvwo,@symbol,targ_x,targ_z,"tri",3,"red",0)

     sWo(pvwo,@hue,"black",@showpixmap,@clipborder)
}
//==========================================

proc TerrPlanView(plt_it)
{
     sWo(pvwo,@clearpixmap)
     sWo(llwo,@clearpixmap)

     if (plt_it) {
       plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1,  GridON)
     }
     
     plotgw(llwo,@symbol,obpx,obpz,"diamond",3,"blue",0)
     plotgw(llwo,@symbol,obpx,obpz,"arrow",2,"blue",cd2pol(azim)-90,1)
     plotgw(llwo,@symbol,targ_x,targ_z,"tri",3,"red",0)

     sWo(pvwo,@hue,"black",@showpixmap,@clipborder)
     sWo(llwo,@hue,"black",@showpixmap,@clipborder)
}
//==========================================

proc SideView(plt_it)
{

/{
     float srx =  -mapscale
     srX = mapscale
     sry = -mapscale/2
     srY = mapscale
/}

//<<" %V$rx $rX \n"

     //sWo(svwo,@scales,srx,sry,srX,srY)

     sWo(svwo,@clearpixmap);

     //plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1)

     if (plt_it) {
       plot3D(svwo,scene,obpx,obpy,obpz,azim,elev,distance,2,1)
     }
     
     plotgw(svwo,"symbol",targ_x,targ_y,"tri",4,RED_,0)
     plotgw(svwo,"symbol",obpx,obpy,"diamond",6,GREEN_,0)

     sWo(svwo,@hue,"black",@showpixmap,@clipborder,@savepixmap)
}

/////////////////////////////////////////////////////////////////////////////
/////////////////////// KEYBD CONTROL ////////////////////////////////////////

proc checkRotate(char wc)
{
 ret = 0

//<<" in $_proc checkRotate $wc \n"

     switch (wc) {

     case 'Q':
          rotate_vec(-2)
          sWo(vptxt,@textr,"R rotate ",0,-0.2) 
          ret = 1
      break;

     case 'S':
        <<" rotate S \n"
          rotate_vec(2)
          sWo(vptxt,@textr,"S rotate ",0,-0.2) 
          ret = 1
      break;
     }


//<<" out $_proc checkRotate $ret \n"

   return ret
}
//=============================================

proc checkRoll (char wc)
{
 ret = 0

//<<" in $_proc checkRoll $wc \n"

    switch (wc) {
       case '[':
          roll(-2)
          ret = 1
          sWo(vptxt,@textr,"[ roll left",0,-0.25) 
       break;
       case ']':
          roll(2)
          ret = 1
          sWo(vptxt,@textr,"] roll right",0,-0.25) 
          break;
      }

   return ret
}
//==================================================

float Mvec_step = 0.2

proc checkMove(char wc)
{
 ret = 0

//<<" in $_proc checkMove $wc \n"

    switch (wc) {

        case 'R':
        go_straight = 1
        //move_vec(2.0)
	move_vec(Mvec_step)
        ret = 1
        sWo(vptxt,@textr," R move forward ",0,-0.25) 
        break;

        case 'T':
        go_straight = 1
        //move_vec(-2.0)
	move_vec(-Mvec_step)
        ret = 1
        sWo(vptxt,@textr," T move back ",0,-0.25) 
        break;
      }

  return ret
}
//================================================

float obs_step = 0.05;
proc checkObserver(char wc)
{
 ret = 1

 <<" in $_proc checkObserver $wc \n"

    switch (wc) {
     case 'y':
          obpy += 2;
        <<"%V$obpy \n";
     break;
     case 'Y':
          obpy -= 2;
     break;
     case 'z':
          obpz += obs_step;
     break;
     case 'Z':
          obpz -= obs_step;
     break;
     case 'x':
          obpx += obs_step;
     break;
     case 'X':
          obpx -= obs_step;
      break;

      default:
        ret = 0;
     }

      if (ret == 1) {
          sWo(vptxt,@textr,"$wc  Observer posn  ",0,-0.2) 
      }

     return ret
}
//====================================


proc checkKeyCommands(char wc)
{
  ret = 1
//<<" in $_proc checkKeyCommands $wc \n"
//<<[CFH]" in $_proc checkKeyCommands $wc \n"

    switch (wc) {

      case 'H':
          MoveObject(wobj,0,2,0)
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
        break;
      case 'f':
          <<"yep got go forward \n"
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
        sWo(vptxt,@textr,"p rotate ",0,-0.25) 
        break;
      case 'o':
          go_rotate = 1
          rotate_vec(speed)
sWo(vptxt,@textr,"o rotate ",0,-0.25) 
          go_circle = 0
        break;
      case '//':
        resetobs(2)
        break;
      case '.':
         go_on = 0
         go_loop = 0
         go_circle = 0
sWo(vptxt,@textr,". stop ",0,-0.25) 
//       resetobs(3)
        break;
      case ',':
     // make observer postion center of map
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
        break;
      case 'D':
       distance *= 1.1
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
        RotateObject(wobj,0,0,10.0)
       sWo(vptxt,@textr,"a rotate object ",0,-0.25) 
            break;
      case 's':   
        RotateObject(wobj,0,0,-4.0)
            break;
      case 'q':     // rotate obj 0
        RotateObject(wobj,10,0,0.0)
            break;
      case 'w':     // rotate obj 0   
        RotateObject(wobj,-4,0,0.0)
            break;
      case 'e':     // rotate obj 0
        RotateObject(wobj,0,10,0.0)
            break;
      case 'r':   
       // rotate obj 0
        RotateObject(wobj,0,-4,0.0)
            break;
      case '\'':   
            resetobs(1)
            break;
      default:
           ret = 0;
      }

  return ret
}
//===================================


proc keyControls(char ac)
{

//<<[CFH]"in keyControls $_proc  $ac \n"

int did_con = 0

      if (checkRoll(ac)) {
//          return 1 
      }
      else if (checkMove(ac)) {
           // return 1 
      }
      else if (checkObserver(ac)) {
          <<"observer control \n"
  //          return 1 
      }
      else if (checkRotate(ac)) {
        ;
      }
      else if (checkKeyCommands( ac)) {
        ;
      }

     else {

      switch (ac) {

      case 'L':
          go_circle = 1
          go_on = 1;
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
       break;
      case 'I':
          elev += 2
          if (elev > 90) {
              elev = 90
          }
       break;
       case 'M':
        MoveObject(wobj,2,0,0)
       break;
       case 'm':
        MoveObject(wobj,-2,0,0)
       break;

      }
    }

      return 1 
}
//=============================================

proc  checkGoDir( move_along)
{
int moved =0 ;


  if (move_along) {


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

   moved = 1;

  }
      return moved;
}
//----------------------------------------------

////////////////////  Event Handling ////////////////////

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

////////////////////////////////////////////////

proc checkEvents()
{

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



///////////////////////// SETUP WINDOWS AND WOBJS //////////////////////////////

  vp = cWi(@title,"vp",@resize,0.1,0.1,0.98,0.98,0)

  sWi(vp,"clip",0.01,0.1,0.95,0.99)

  vptxt=cWo(vp,"TEXT",@name,"TXT",@resize,0.3,0.01,0.75,0.1,@color,"blue")

  sWo(vptxt,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw, @pixmapoff, @drawon)

  sWo(vptxt,@scales,-1,-1,1,1)

  vpwo=cWo(vp,"GRAPH",@name,"VP",@resize,0.2,0.2,0.8,0.90,@color,"white")

  sWo(vpwo,@scales,-20,-20,20,20, @save,@redraw,@drawoff,@pixmapon,@savepixmap)

  pvwo = cWo(vp,"GRAPH",@resize,0.01,0.21,0.19,0.5,"name","PLANVIEW","color","white")

  sWo(pvwo,@scales,-300,-300,300,300, @save,@redraw,@pixmapon,@drawon,@savepixmap)

  svwo = cWo(vp,@GRAPH,@resize,0.01,0.51,0.19,0.95,@name,"SIDEVIEW","color","white")

  sWo(svwo,@scales,-300,-300,300,300, @save,@redraw,@drawoff,@pixmapon, @drawon,@savepixmap)

  sWo(vpwo,@redraw);


  llwo = cWo(vp,"GRAPH",@resize,0.01,0.01,0.19,0.2,"name","LLVIEW","color","white")

  sWo(llwo,@scales,-107,36,-104,42, @save,@redraw,@pixmapon,@drawon,@savepixmap)




/////////////////////////////////////////////////// CONTROLS ////////////////////////////
 bx = 0.91
 bX = 0.99
 yht = 0.1
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 qwo=cWo(vp,"BV",@name,"QUIT",@VALUE,"QUIT",@color,"orange",@resize,bx,by,bX,bY)
 sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 azimwo=cWo(vp,"BV",@name,"AZIM",@VALUE,"1",@color,"white")
 sWo(azimwo,@FUNC,"inputValue",@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 distwo=cWo(vp,"BV",@name,"DIST",@VALUE,"1",@color,"white")
 sWo(distwo,@FUNC,"inputValue",@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 elevwo=cWo(vp,@BV,@name,"EYE_ELEV",@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB",@VALUE,"10",@FUNC,"inputValue")
 sWo(elevwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 olatwo=cWo(vp,@BV,@name,"OLAT",@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB",@VALUE,"40",@FUNC,"inputValue")
 sWo(olatwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 olngwo=cWo(vp,@BV,@name,"OLNG",@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB",@VALUE,"-104",@FUNC,"inputValue")
 sWo(olngwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 altwo=cWo(vp,@BV,@name,"ALT",@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB",@VALUE,"2000",@FUNC,"inputValue")
 sWo(altwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")



 int conwos[] = {  azimwo, distwo, elevwo, olatwo, olngwo, altwo } 

 wo_vtile(conwos,bx,0.2,bX,0.75)

 sWo(conwos,@redraw)



////////////////////////////////////////////////////////////////////////////////////////








<<"DONE loading of viewlib\n"
//////////////////////////////////////////////////////////////////////////


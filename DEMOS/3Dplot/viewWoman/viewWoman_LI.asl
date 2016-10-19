#
# view 3D object
#

Main_init = 1


set_ap(0)

SetDebug(0)

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("VO")


int GridON = 0;

wobj = 2

Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

float azim = 320.0
float elev = 0.0

float speed = 2.0
int elewo = 0;

int scene[]

CFH = ofw("vo.debug")

include "event"

Event E

  E->minfo[0] = 1.0
  E->minfo[2] = 7.0

//<<"%V$E->minfo \n"




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

          ang = atan(E->rx/rpx)
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

proc xy_move_to()
{

   if (E->button == 1) {
          obpx =  E->rx
          obpy =  E->ry
     <<" moving observer $obpx $obpy \n"
   }

   if (E->button == 3) {
          targ_x =  E->rx
          targ_y =  E->ry
      <<" moving target $targ_x $targ_z \n"
   }


}

proc look_at()
{
// how about elev ??

//<<" look_at \n"


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


proc xz_move_to()
{

   if (E->button == 1) {
          obpx =  E->rx
          obpz =  E->ry
<<" moving observer $obpx $obpz \n"
   }


   if (E->button == 3) {
          targ_x =  E->rx
          targ_z =  E->ry
//<<" moving target $targ_x $targ_z \n"
   }

   

//<<"%V$pazim $azim $r1 $xdir $zdir $mad $ma\n"
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

<<"mv %V$mdir $azim $obpx $obpy  \n"

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

     //plot3D(pvwo,scene,obpx,obpy,obpz, azim, elev,distance,4,1,  GridON)

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


     //plot3D(svwo,scene,obpx,obpy,obpz,azim,elev,distance,2,1)
     plotgw(svwo,"symbol",targ_x,targ_y,"tri",7,"red",0)
     plotgw(svwo,"symbol",obpx,obpy,"diamond",10,"green",0)

     //SetGwob(svwo,"showpixmap")
     Setgwob(svwo,@hue,"black",@showpixmap,@save,@clipborder)
}


//MX = vgen(FLOAT,50,5,0)

//redimn(MX,5,10)

fp =  ofr("woman.pic")

npx = 512*512
uchar PX[npx+]

// read in image file

 nc=v_read(fp,PX,(512*512),"uchar")

 redimn(PX,512,512)
 PX=reflectRow(PX)

// int MX[]

 MX = PX[0::4][0::4]

 Redimn(MX,128,128)

// ramp - but just rotate
// SX = vgen(INT,128,0,2)
// MX  = MX + SX

 msz = Caz(MX)

 <<" $(Cab(MX)) $sz\n"

fname = getArgStr()

<<"%V$fname \n"

// no file -- then no objects

if ( ! (fname @= "") ) {
   scene = CreateScene(fname)
<<"array of object ids $scene \n"
<<" read scene \n"
}
else {

//  we know we have to have some objects 

      //obid0 = MakeObject("G_GRID",-200,0,50,1,1,1,2)  

      obid1 = MakeObject("MATRIX",MX,-100,0,10,4,0.2,4,0.5,180,180,0,1)

      obid2 = MakeObject("G_CUBE",-200,0,50,1,1,1,50)

      //RotateObject(obid1,-90,0,0)



}


  //obid9 = MakeObject("G_CUBE",0,200,50,1,1,1,50)

    //    RotateObject(obid9,180,0,0)

  //obid2 = MakeObject("G_CUBE",200,0,400,1,1,1,75)

//  obid3 = MakeObject("G_CUBE",400,0,800,20,1,1,10)

//        RotateObject(obid3,0,45,0)

  wobj = obid1


///////////////////////// SETUP WINDOWS AND WOBJS //////////////////////////////

  vp = CreateGwindow(@title,"vp",@resize,0.1,0.01,0.98,0.98,0)

  SetGwindow(vp,"scales",-200,-200,200,200,0, "drawoff","pixmapon","save","bhue","white")

  SetGwindow(vp,"clip",0.01,0.1,0.95,0.99)

 //gwo=createGWOB(vp,"BV",@name,"B_V",@color,"green",@resize,bx,by,bX,bY)

  vptxt=CreateGWOB(vp,"TEXT",@name,"TXT",@resize,0.1,0.01,0.75,0.1,@color,"blue")

  setgwob(vptxt,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw,@pixmapoff,@drawon)

  setgwob(vptxt,@scales,-1,-1,1,1)

  vpwo=CreateGWOB(vp,"GRAPH",@name,"VP",@resize,0.2,0.2,0.8,0.90,@color,"white")

  setgwob(vpwo,@scales,-20,-20,20,20, @save,@redraw,@drawoff,@pixmapon)

  pvwo = CreateGWOB(vp,"GRAPH",@resize,0.01,0.11,0.19,0.5,"name","PLANVIEW","color","white")

  setgwob(pvwo,@scales,-200,-200,200,200, @save,@redraw,@drawoff,@pixmapon)

  svwo = CreateGWOB(vp,"GRAPH",@resize,0.01,0.51,0.19,0.95,@name,"SIDEVIEW","color","white")

  SetGwob(svwo,@scales,-200,-200,200,200, @save,@redraw,@drawoff,@pixmapon)


/////////////////////////////////////////////////// CONTROLS ////////////////////////////
 bx = 0.93
 bX = 0.99
 yht = 0.1
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 qwo=createGWOB(vp,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,bx,by,bX,bY)
 setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

 azimwo=createGWOB(vp,"BV",@name,"AZIM",@VALUE,"1",@color,"white")
 setgwob(azimwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 distwo=createGWOB(vp,"BV",@name,"DIST",@VALUE,"1",@color,"white")
 setgwob(distwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 elevwo=createGWOB(vp,"BV",@name,"ELEV",@VALUE,"1",@color,"white")
 setgwob(elevwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 int conwos[] = {  azimwo, distwo, elevwo } 

 wo_vtile(conwos,bx,0.2,bX,0.75)

 setgwob(conwos,@redraw)


/////////////////////// KEYBD CONTROL ////////////////////////////////////////

proc checkRotate(char wc)
{
 ret = 0

//<<" in $_proc checkRotate $wc \n"

     switch (wc) {

     case 'Q':
          rotate_vec(-2)
          setgwob(vptxt,@textr,"R rotate ",0,-0.2) 
          ret = 1
      break;

     case 'S':
        <<" rotate S \n"
          rotate_vec(2)
          setgwob(vptxt,@textr,"S rotate ",0,-0.2) 
          ret = 1
      break;
     }


//<<" out $_proc checkRotate $ret \n"

   return ret
}


proc checkRoll (char wc)
{
 ret = 0

//<<" in $_proc checkRoll $wc \n"

    switch (wc) {
       case '[':
          roll(-2)
          ret = 1
          setgwob(vptxt,@textr,"[ roll left",0,-0.25) 
       break;
       case ']':
          roll(2)
          ret = 1
          setgwob(vptxt,@textr,"] roll right",0,-0.25) 
          break;
      }

   return ret
}


proc checkMove(char wc)
{
 ret = 0

//<<" in $_proc checkMove $wc \n"

    switch (wc) {

        case 'R':
        go_straight = 1
        move_vec(2.0)
        ret = 1
        setgwob(vptxt,@textr,"$E->nm R move forward ",0,-0.25) 
        break;

        case 'T':
        go_straight = 1
        move_vec(-2.0)
        ret = 1
        setgwob(vptxt,@textr,"$E->nm T move back ",0,-0.25) 
        break;
      }

  return ret
}

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
          setgwob(vptxt,@textr,"$wc  Observer posn  ",0,-0.2) 
      }

     return ret
}


proc checkKeyCommands(char wc)
{
  ret = 1
//<<" in $_proc checkKeyCommands $wc \n"
<<[CFH]" in $_proc checkKeyCommands $wc \n"

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
          <<[CFH]"yep got go forward \n"
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
        setgwob(vptxt,@textr,"p rotate ",0,-0.25) 
        break;
      case 'o':
          go_rotate = 1
          rotate_vec(speed)
setgwob(vptxt,@textr,"o rotate ",0,-0.25) 
          go_circle = 0
        break;
      case '//':
       resetobs(2)
        break;
      case '.':
         go_on = 0
         go_loop = 0
         go_circle = 0
setgwob(vptxt,@textr,". stop ",0,-0.25) 
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
setgwob(vptxt,@textr,"a rotate object ",0,-0.25) 
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



proc keyControls(char ac)
{

<<[CFH]"in keyControls $_proc  $ac \n"

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
   <<[CFH]" keycommands \n"
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





////////////////////////////////////////////////////////////////////////////////////////


float obpx = 75
float obpy = 50
float obpz = -140


float targ_x = 0
float targ_y = 10
float targ_z = 35


obsdz = 2
float distance = 50.0
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


  // resetobs(1)
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



<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

  uint ml = 0

  while (1) {

    ml++

    w_activate(vp)

    //<<"$kev %v $go_on \n"

    E->readMsg()

    kev++

    did_cont = 0

   if ( ! (E->keyw @= "NO_MSG")) {

     setgwob(vptxt,@clear,@clipborder,"red",@textr,E->emsg,0,0.8) 

//<<"%V$svwo $pvwo $vpwo \n"

//<<"%V$E->keyw %c$E->keyc %d$E->keyc  $E->woname\n"

    if (E->keyc != 0) {
   <<[CFH]"$E->keyw  %V%c$E->keyc \n"
    }

 setgwob(vptxt,@textr,"$E->nm $E->keyw %c$E->keyc %$E->woname",0,0.1) 


     did_cont = 1


      if (E->kws[1] @= "PRESS") {

          //<<"%V$E->keyw  $E->woid  $svwo $pvwo \n"

          if (E->woid == svwo) {
             //look_to()
             <<" sv $svwo\n"
             xy_move_to()
             look_at()
          }

          if (E->woid == pvwo) {
             <<" pv $pvwo \n"
             xz_move_to()
             look_at()
          }
      }
      else if (E->etype @= "KEYPRESS") {

         setgwob(vptxt,@clear,@clipborder,"blue",@textr,E->kws[2],0,0) 


          keyControls(E->keyc)

      }

    }

//<<"%V$ml $go_on \n"
//<<[CFH]"%V$ml $go_on \n"

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

       setgwob(azimwo,@VALUE, "%5.1f$azim" , @redraw)
       setgwob(distwo,@VALUE, "%5.1f$distance" , @redraw)
       setgwob(elewo,@VALUE, "%5.1f$elev" , @redraw)

    Setgwob(vpwo,@clearpixmap) 

<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

    plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev,distance,1,1, GridON)

    SetGwob(vpwo,@showpixmap,@clipborder) 

    

//    txtmsg = "%5.1f %V$obpx , $obpy , $obpz , $azim , $elev , $o_speed"
    txtmsg = "%V$obpx , %5.1f$obpy , $obpz , $azim , $elev , $o_speed"

//    setgwob(two,"text",txtmsg,"redraw") wrong woid  causes crash - should be robust

    //setgwob(vptxt,@text,txtmsg,@redraw) 

//<<"%5.1f %V$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

     PlanView()

     SideView()

     //setgwob(vptxt,@clear,@clipborder,"red",@textr,E->keyw,0,0) 

     sleep(0.05)

     fflush(CFH)
  }


  if (scmp(E->woname,"QUIT",4)) {
       break
  }


     sleep(0.1)

     gsync()

 } // while forever

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


/}




#{
  obidX = MakeObject("G_CUBE",0,0,0,40,1,1,10)

   moveObject(obidX,-205,0,0)

  obidPX = MakeObject("G_CUBE",0,0,0,40,1,1,10)

   moveObject(obidPX,205,0,0)

        RotateObject(obidPX,90,0,0)



  obidY = MakeObject("G_CUBE",0,0,0,1,50,1,10)

      moveObject(obidY,0,-255,0)

  obidPY = MakeObject("G_CUBE",0,0,0,1,50,1,10)

       moveObject(obidPY,0,255,0)


       RotateObject(obidPY,0,90,0)

  obidZ = MakeObject("G_CUBE",0,0,0,1,1,50,10)

       moveObject(obidZ,0,0,-255)

  obidPZ = MakeObject("G_CUBE",0,0,0,1,1,50,10)

       moveObject(obidPZ,0,0,255)

       RotateObject(obidPZ,0,0,180)


  obid4 = MakeObject("G_PYRAMID",0,0,0,1,1,1,10)



// circle at y 50 - center x,z 0,0 rad 50
   for (i = 0 ; i < 36 ; i++) {
   ar = d2r(i*10)
   xp = 150.0 * sin(ar)
   zp = 150.0 * cos(ar)
   obid5 = MakeObject("G_PYRAMID",xp,75,zp,1,1,1,10)

   }


  obid4 = MakeCbar(-10,-100,-50,80,200,200,10)


   for (i = 0 ; i < 4 ; i++) {
   ar = d2r(i*30)
   xp = 1000.0 * sin(ar)
   zp = 1000.0 * cos(ar)
   obid5 = MakeObject("G_PYRAMID",xp,0,zp+200,1,1,1,40)
   }

#}

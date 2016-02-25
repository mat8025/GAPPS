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


int GridON = 0;

wobj = 2

Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

float azim = 45.0
float elev = 0.0

float speed = 2.0
int elewo = 0;
int scene[]

//CFH = ofw("vs.debug")

////////////////////////////////////////////////////////////////
include "viewlib"



fname = getArgStr()

<<"%V$fname \n"

//fname = "top"

// no file -- then no objects

if ( ! (fname @= "") ) {
   scene = CreateScene(fname)
<<"array of object ids $scene \n"
<<" read scene \n"

}



//  we know we have to have some objects 


  //obid0 = MakeObject("G_PYRAMID",0,0,0,1,1,1,50)
  
     obid1 = MakeObject("G_CUBE",-200,0,50,1,1,1,50)

    nc = 4

      zp = 50

    for (kb = 0; kb < nc; kb++) {
       obidLL = MakeObject("G_CUBE",0,0,zp,1,1,1,50)
       MakeObject("G_PYRAMID",0,300,zp,1,1,1,50)

       zp += 100
    }

      zp = 50

    for (kb = 0; kb < nc; kb++) {
       obidRR = MakeObject("G_CUBE",200,0,zp,1,1,1,50)
       MakeObject("G_PYRAMID",200,300,zp,1,1,1,50)
       zp += 100
    }


  wobj = obid1


///////////////////////// SETUP WINDOWS AND WOBJS //////////////////////////////

  vp = CreateGwindow(@title,"vp",@resize,0.1,0.01,0.98,0.98,0)

  SetGwindow(vp,@scales,-200,-200,200,200,0, "drawoff","pixmapon","save","bhue","white")

  SetGwindow(vp,"clip",0.01,0.1,0.95,0.99)

 //gwo=createGWOB(vp,"BV",@name,"B_V",@color,"green",@resize,bx,by,bX,bY)

  vptxt=CreateGWOB(vp,"TEXT",@name,"TXT",@resize,0.1,0.01,0.75,0.1,@color,"blue")

  setgwob(vptxt,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw,@pixmapoff,@drawon)

  setgwob(vptxt,@scales,-1,-1,1,1)

  vpwo=CreateGWOB(vp,"GRAPH",@name,"VP",@resize,0.2,0.2,0.8,0.90,@color,"white")

  setgwob(vpwo,@scales,-20,-20,20,20, @save, @savepixmap, @redraw,@drawoff,@pixmapon)


  pvwo = CreateGWOB(vp,"GRAPH",@resize,0.01,0.11,0.19,0.5,@name,"PLANVIEW",@color,"cyan")

  setgwob(pvwo,@scales,-200,-200,200,200, @save,@savepixmap, @redraw,@drawon,@pixmapon)

  svwo = CreateGWOB(vp,"GRAPH",@resize,0.01,0.51,0.19,0.95,@name,"SIDEVIEW",@color,"pink")

  SetGwob(svwo,@scales,-200,-200,200,200, @save,@savepixmap,@redraw,@drawon,@pixmapon)


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


//////////////////////////////////////////////////////////////////////////

float obpx = -50
float obpy = 50
float obpz = -100

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


  //resetobs(1)

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
////////  Event variables //////////////////
  E =1
  svar msg
  woname = ""
  woid = 0
  float rx
  float ry
  button = 0
  keyc = 'c'
///////////////////////////////////////////


kev = 0

  while (1) {

    ml++

//    w_activate(vp)
//<<"$kev %v $go_on \n"

    msg =E->readMsg()

    keyw =  E->checkKeyw()
    etype = E->geteventType()
    kev++


    kev++

    did_cont = 0

     if ( ! (msg @= "NO_MSG")) {

     setgwob(vptxt,@clear,@clipborder,"red",@textr,msg,0,0) 

//<<"%V$svwo $pvwo $vpwo \n"

<<"%V$keyw %c$keyc %d$keyc  $woname\n"

/{
    if (keyc != 0) {
   <<[CFH]"$keyw  %V%c$keyc \n"
    }
/}

     did_cont = 1

 if (etype @= "PRESS") {

          woid = E->getEventWoid()
          button = E->getButton()
          E->geteventrxy(&rx,&ry)

<<"$button  $woid $rx $ry\n"


          //<<"%V$E->keyw  $woid  $svwo $pvwo \n"

          if (woid == svwo) {
             //look_to(rx)
             <<" sv $svwo\n"
             xy_move_to(button,rx,ry)
             look_at()
          }

          if (woid == pvwo) {
             <<" pv $pvwo \n"
             xz_move_to(button,rx,ry)
             look_at()
          }
      }
      else if (etype @= "KEYPRESS") {
          keyc = E->geteventKey()
          setgwob(vptxt,@clear,@clipborder,"blue",@textr,$keyc,0,0) 
          keyControls(keyc)
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

     sleep(0.1)

//   fflush(CFH)

  }


  if (scmp(woname,"QUIT",4)) {
       break
  }


     gsync()

 } // while forever

// may not want to exit window manager --- but for now
 exit_gs()

;

STOP("DONE !\n")



// TO DO
// txt - display on coors, msg  current operation
// clip out object if it is behind observer -DONE
// 
// only process subset of objects in front
// reduced detail on objects too far in front to resolve
// set grid -- surface - read elevation from map
// threaded operation  --- control input and drawing 
// linear interpolation of objects -long lines generate pt per resolution
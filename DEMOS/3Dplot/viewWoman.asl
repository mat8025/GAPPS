#
# view 3D woman (grid) plus object
#


Main_init = 1

set_ap(0)

SetDebug(0)

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

include "viewlib"

//====================================================

int scene[];
int GridON = 0;

wobj = 2

Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

float azim = 320
float elev = 0.0
float speed = 2.0
int elewo = 0;



CFH = ofw("vo.debug")

//Event E
E =1

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

 MX = PX[0:-1:4][0:-1:4]

 msz = Caz(MX)
 <<" $(Cab(MX)) $sz\n"


// Redimn(MX,128,128)


// ramp - but just rotate
// SX = vgen(INT,128,0,2)
// MX  = MX + SX

 msz = Caz(MX)

 <<" $(Cab(MX)) $sz\n"

/{
fname = getArgStr()

<<"%V$fname \n"

// no file -- then no objects

if ( ! (fname @= "") ) {
   scene = CreateScene(fname)
<<"array of object ids $scene \n"
<<" read scene \n"
}
/}

//  we know we have to have some objects 

<<"make some Objects - matrix/grid cube \n"

  aslw = asl_w("VO")

  obid1 = MakeObject("MATRIX",MX,-100,0,10,4,0.2,4,0.5,180,180,0,1)

  obid2 = MakeObject("G_CUBE",-200,0,50,1,1,1,50)

<<"%V$obid1 $obid2 \n"

//        RotateObject(obid2,0,45,0)

  wobj = obid1


///////////////////////// SETUP WINDOWS AND WOBJS //////////////////////////////
<<" start window setup \n"

  vp = CreateGwindow(@title,"vp",@resize,0.1,0.1,0.98,0.98,0)

  SetGwindow(vp,@clip,0.01,0.1,0.95,0.99)

// stray argument causes crash?
SetGwindow(vp, @scales,-200,-200,200,200,0, @drawon,@pixmapon,@save,@bhue,"white")

 // SetGwindow(vp,@scales,-200,-200,200,200,0, "drawoff","pixmapon","save","bhue","white")

 //gwo=createGWOB(vp,"BV",@name,"B_V",@color,"green",@resize,bx,by,bX,bY)

  vptxt=CreateGWOB(vp,"TEXT",@name,"TXT",@resize,0.1,0.01,0.75,0.1,@color,"blue")

  sWo(vptxt,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw,@pixmapoff,@drawon)

  sWo(vptxt,@scales,-1,-1,1,1)

  vpwo=cWo(vp,"GRAPH",@name,"VP",@resize,0.2,0.2,0.8,0.90,@color,"white")

//  sWo(vpwo,@scales,-20,-20,20,20, @save, @savepixmap,@redraw,@pixmapon,@drawoff)

  sWo(vpwo,@scales,-20,-20,20,20, @save, @savepixmap, @redraw,@drawoff,@pixmapon)

  pvwo = cWo(vp,"GRAPH",@resize,0.01,0.11,0.19,0.5,@name,"PLANVIEW",@color,"cyan")

  sWo(pvwo,@scales,-200,-200,200,200, @save,@savepixmap,@redraw,@drawon,@pixmapon)

  svwo = cWo(vp,"GRAPH",@resize,0.01,0.51,0.19,0.95,@name,"SIDEVIEW",@color,"pink")

  SWo(svwo,@scales,-200,-200,200,200, @save,@savepixmap,@redraw,@pixmapon,@drawon)

<<" finish window setup \n"

/////////////////////////////////////////////////// CONTROLS ////////////////////////////
<<" start control setup \n"
 bx = 0.93
 bX = 0.99
 yht = 0.1
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 qwo=createGWOB(vp,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,bx,by,bX,bY)
 sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

 azimwo=cWo(vp,"BV",@name,"AZIM",@VALUE,"1",@color,"white")
 sWo(azimwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 distwo=cWo(vp,"BV",@name,"DIST",@VALUE,"1",@color,"white")
 sWo(distwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 elevwo=cWo(vp,"BV",@name,"ELEV",@VALUE,"1",@color,"white")
 sWo(elevwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@style,"SVB")

 int conwos[] = {  azimwo, distwo, elevwo } 

 wo_vtile(conwos,bx,0.2,bX,0.75)

 sWo(conwos,@redraw)

<<" finish control setup \n"



////////////////////////////////////////////////////////////////////////////////////////
<<"@main \n"
//setdebug(1)

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

  //resetobs(1)

  // scene is array of objects 

<<"try plot \n"
<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

  plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev, distance)
 // plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev, distance,1,1,1)

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


////////  Event variables //////////////////
  svar msg

  float Erx;
  float Ery;

  woname = ""
  etype = "" 
  button = 0
  Woid = 0;
  Woval = ""

  int evs[16];

  E =1;
///////////////////////////////////////////

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

  while (1) {

    ml++

      //<<"$kev %v $go_on \n"

    msg =E->waitForMsg()

    kev++

    sWo(vptxt,@clear,@clipborder,"red",@textr,msg,0,0.8) 

    did_cont = 0

   if ( ! (msg @= "NO_MSG")) {

    etype = E->geteventType();

    E->geteventstate(evs)



<<"%V$msg $etype $button $Erx $Ery \n"

     sWo(vptxt,@textr,"%V $etype $button $Woval ",0,0.1) 

     did_cont = 1

      if (etype @= "PRESS") {

          Woid = E->getEventWoId()
    
          button = E->getButton();

          Woval = getWoValue(Woid)
    
<<"$button  $Woid $Erx $Ery\n"


          //<<"%V$keyw  $woid  $svwo $pvwo \n"

          if (Woid == svwo) {
             //look_to(rx)
             <<" sv $svwo\n"
	     E->geteventrxy(&Erx,&Ery)
             xy_move_to(button,Erx,Ery)
             look_at()
          }

          if (Woid == pvwo) {
             <<" pv $pvwo \n"
	     E->geteventrxy(&Erx,&Ery)
             xz_move_to(button,Erx,Ery)
             look_at()
          }
      }
      else if ((etype @= "KEYPRESS") || (etype @= "KEYRELEASE")) {
      
          keyc = E->geteventKey();
	  
          sWo(vptxt,@clear,@clipborder,BLUE_,@textr,"KEY was %c$keyc",0,0)
	  
          keyControls(keyc);
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
        //<<" moving ON! \n"
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

   sWo(azimwo,@VALUE, "%5.1f$azim" , @redraw)
   sWo(distwo,@VALUE, "%5.1f$distance" , @redraw)
   sWo(elewo,@VALUE, "%5.1f$elev" , @redraw)

<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

    sWo(vpwo,@clearpixmap) 

    plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev,distance,1,1, GridON)
    
    sWo(vpwo,@showpixmap,@clipborder) 


//    txtmsg = "%5.1f %V$obpx , $obpy , $obpz , $azim , $elev , $o_speed"

    txtmsg = "%V$obpx , %5.1f$obpy , $obpz , $azim , $elev , $o_speed"
    sWo(vptxt,"text",txtmsg,"redraw")

    // PlanView()

   //  SideView()

  }

     if (Woid == qwo ) {
       break
     }

//     sleep(0.1)

     gsync()

 } // main loop

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

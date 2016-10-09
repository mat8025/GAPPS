#
# view 3D object
#

Main_init = 1

//OpenDll("math")

set_ap(0)

SetDebug(0)

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

  aslw = asl_w("VG")


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

CFH = ofw("vo.debug")


include "viewlib"





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

// MX = PX[0::4][0::4]

 MX = PX[0:-1:4][0:-1:4]
 
// Redimn(MX,128,128)

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

     // obid2 = MakeObject("G_CUBE",-200,0,50,1,1,1,50)

      //RotateObject(obid1,-90,0,0)

     scene[0] = obid1
    // scene[1] = obid2


}



  wobj = obid1


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



  float cir_d = 0.5

  SideView()

  woname = "XX";
  
  int kev = 0;
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

    //w_activate(vp)

    //<<"$kev %v $go_on \n"
   //Emsg= E->readMsg()
   Emsg= E->waitForMsg()

   checkEvents()

     sWo(vptxt,@textr," $woname",0,0.1) 

     did_cont = 1;
     
 if (Etype @= "PRESS") {

          <<"%V$Ekeyw  $Woid  $svwo $pvwo \n"

          if (Woid == svwo) {
             //look_to()
             <<" sv $svwo\n"
             xy_move_to(Ebutton,Erx,Ery)
             look_at()
          }

          if (Woid == pvwo) {
             <<" pv $pvwo \n"
             xz_move_to(Ebutton,Erx,Ery)
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
    

   did_cont = checkGoDir(go_on);


   did_cont = 1; // DBG


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
    sWo(vpwo,@clearpixmap) 

    plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev,distance,1,1, GridON)

    sWo(vpwo,@showpixmap,@clipborder) 

    

//    txtmsg = "%5.1f %V$obpx , $obpy , $obpz , $azim , $elev , $o_speed"
    txtmsg = "%V$obpx , %5.1f$obpy , $obpz , $azim , $elev , $o_speed"

//   sWo(two,"text",txtmsg,"redraw") wrong woid  causes crash - should be robust
//  sWo(vptxt,@text,txtmsg,@redraw) 

//<<"%5.1f %V$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

     PlanView()

     SideView()

     //sWo(vptxt,@clear,@clipborder,"red",@textr,E->keyw,0,0) 

     sleep(0.5)

     fflush(CFH)
  }


  if (scmp(woname,"QUIT",4)) {
       break;
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

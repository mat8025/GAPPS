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

SetDebug(0)

  Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

////////////////////////////////

 // aslw = asl_w("VO")   // function missing in XGS??

include "viewlib"

//-------------------------------------------------

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
     obid2 = MakeObject("G_CUBE",-300,0,45,1,1,1,50)
     
<<"made simple cube to look at $obid1\n"

     scene[0] = obid1
     scene[1] = obid2


      nc = 4

      zp = 50
      obn = 3
      osz = 50.0;
      
    for (kb = 0; kb < nc; kb++) {
       obid = MakeObject("G_CUBE",0,0,zp,1,1,1,osz)
       scene[obn++] = obid
       obid = MakeObject("G_PYRAMID",0,300,zp,1,1,1,osz)
       scene[obn++] = obid
       zp += 100
       osz * 1.1;
    }


}


  //obid9 = MakeObject("G_CUBE",0,200,50,1,1,1,50)

  //    RotateObject(obid9,180,0,0)



<<"array of object ids $scene \n"

//        RotateObject(obid3,0,45,0)

  wobj = obid1

  //wobj = 2

Pi =  4.0 * Atan(1.0)

zalpha = 0
yalpha = 0
xalpha = 0

float azim = 45.0
float elev = 20.0

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
float distance = 20.0;
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
  int go_on = 0;
  go_rotate = 0
  go_circle = 0
  go_loop = 0
  go_straight = 0
  o_speed = 0.5


  map_home()

  uint ml = 0

  look_at()

Svar msg





  while (1) {

    ml++;

<<"at xgs interact ! $ml\n"
    //<<"$kev %v $go_on \n"

 //  Emsg= E->waitForMsg()
   Emsg= E->readMsg()

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
    

     //PlanView();

<<"%V$ml $go_on $kev\n"
<<[CFH]"%V$ml $go_on \n"

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



     sWo(azimwo,@VALUE, "%5.1f$azim" , @update)
     sWo(distwo,@VALUE, "%5.1f $distance" , @update)
     sWo(elevwo,@VALUE, "%5.1f$elev" , @update)
     
<<"%V %5.1f$obpx , $obpy , $obpz , $azim  $elev  $distance \n"

     sWo(vpwo,@clearpixmap) 

     plot3D(vpwo, scene, obpx, obpy, obpz, azim, elev,distance,1,1, GridON)

     sWo(vpwo,@showpixmap,@clipborder) 

     txtmsg = "%V$obpx , %5.1f$obpy , $obpz , $azim , $elev , $o_speed"

//   sWo(two,@text,txtmsg, @update) //wrong woid  causes crash - should be robust

     sWo(vptxt,@text,txtmsg,@update) 

//<<"%5.1f %V$obpx , $obpy , $obpz , $azim  $elev  $distance \n"
     if ((ml % 5) == 0) {
      PlanView()

      SideView()
     }
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



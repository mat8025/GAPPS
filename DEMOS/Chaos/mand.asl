
// MANDELBROT

set_debug(0)

//opendll("plot")

Graphic = CheckGwm()

/////////////////////////////////////////////////////////////////////
float RS[]
float R[10]

//Event E 
E = 1
float rinfo[12]
int iv[16]
int woival = 0
int button
float xr;

//////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////
// an enum to hold wo ivalues

enum Woval {

  WLUP = 1,
  WUP,
  WRUP,
  WLEFT,
  WCEN,
  WRIGHT,
  WLDWN,
  WDOWN,
  WRDWN,
}


DB = 1
float MS[]
float MBS[10+]

do_mag = 0
set_ap(50)
do_zoom = 0

proc the_menu (the_choice)
{

<<"%v  $the_choice \n"

                  if (the_choice @= "zoom")  { 
                   do_zoom =1
                  return zoom_mand(w)
                  }
                 
                  if (the_choice @= "magnify") {
                    do_mag = 1
                    return ( setup(w))
             
		      }

             if ( the_choice @= "MAIN_MENU" ) {
                mand_menu(w)
                return 1
              }

              if ( the_choice @= "rotate_cmap" ) {
      if ( ( ! mono ) ) {
        for (j = 0 ; j < 10 ; j++) {
        w_store(w)
        rotate_map(0,15,1,2)
        ff=w_refresh(w)
        }
      }
            
             return 1
        }
}

proc resize_mand()
{
 int I[10]
  ff=get_w_clip(w,&I[0])
   // o_print(I[0]," ",I[1]," ",I[2]," ",I[3])
 nyp = I[3] - I[1]
 nx = I[2] - I[0]
  if ( nyp % 2 ) nyp++
   nxp = nyp

}
//=========================================
proc screen_print()
{
                  for (x0 = 0 ; x0 < nxp ; x0++ ) {
                    c1 = xr0 + (xrange * x0 / nxp)
                    Mandel(c1,yr0,yr1,4,nyp,ni,CM,C)
                    vpc(w,C,x0,0,1);
                    x0 = x0 + 1
                  }
                close_laser()
                laser_scr(w)
                laser = 0
}



proc setup(the_w)
{

  show_curs(1,-1,-1,"resize")

  RS=WGetRS(the_w)


<<"$_cproc %V$the_w $(Cab(RS)) $RS \n"

  dx = (RS[3] - RS[1])/4.0
  dy = (RS[4] - RS[2])/4.0

<<" %V $dx $dy \n"

#{
  RS[1] += dx
  RS[2] += dy
  RS[3] -= dx
  RS[4] -= dy
#}

   RS[1] = RS[1] + dx
   RS[2] = RS[2] + dy
   RS[3] = RS[3] - dx
   RS[4] = RS[4] - dy



RS[0] = the_w

<<"$_cproc %V$the_w $(Cab(RS)) $RS \n"

  show_curs(1,-1,-1,"resize")

  select_real(the_w,RS)

<<"$_cproc %V$the_w $(Cab(RS)) $RS \n"

  show_curs(1,-1,-1,"cross")

    if (the_w != -1) {

      xr0 = RS[1]
      xr1 = RS[3]
      yr0 = RS[2]
      yr1 = RS[4]
<<" $xr0 $xr1 \n"
      xr = xr1-xr0

	   SetGwindow(the_w,"scales",xr0,yr0,xr1,yr1)
           SetGW(the_w,"redraw")
       x0 = 0
    }

}

proc zoom_mand(the_w)
{

  RS=GetWinRS(the_w)

  rx= RS[1]
  rX= RS[3]
  ry= RS[2]
  rY= RS[4]

  dx = rX-rx
  dy = rY-ry
  scf = 1.0
  ctype ="hand"

     while (1) {
    MBS = get_mouse_state(the_w)
    <<"ZOOM $MBS[4] $MBS[5] \n"
     rbutton = MBS[2]
     if (rbutton == 1.0) {
     scf = 0.90
     ctype ="cross"
     break
    }
    else  if ( rbutton == 4.0) {
     scf = 1.1
     ctype ="resize"
     break
       }
    else  if (rbutton == 2.0) {
     scf = 1.0
     ctype ="bi_arrow"
     break
    }


     }
      dx *= scf
      dy *= scf

     xr0 = MBS[4] - dx/2.0
     xr1 = MBS[4] + dx/2.0
     yr0 = MBS[5] - dy/2.0
     yr1 = MBS[5] + dy/2.0

      xr = xr1-xr0
      set_w_rs(the_w,xr0,yr0,xr1,yr1)
      w_show_curs(the_w,2,ctype,MBS[4],MBS[5])
      x0 = 0
}
//========================================================

proc new_coors(w_num)
{
  par_menu = "mand_coors"

  rx=get_w_rs(w_num,0)
  ry=get_w_rs(w_num,1)
  rX=get_w_rs(w_num,2)
  rY=get_w_rs(w_num,3)

  set_menu_value(par_menu,"x0",rx)
  set_menu_value(par_menu,"x1",rX)
  set_menu_value(par_menu,"y1",rY)

  ff=set_menu_value(par_menu,"y0",ry)

  value = table_menu(par_menu)

    if ( value == 1 ) {

      xr0= get_menu_value(par_menu,"x0")
      xr1= get_menu_value(par_menu,"x1")
      yr1= get_menu_value(par_menu,"y1")
      yr0= get_menu_value(par_menu,"y0")

      xrange = xr1-xr0
      set_w_rs(w,xr0,yr0,xr1,yr1)
	//      w_clip_clear(w)
      ff=w_redraw_wo(w)
      x0 = 0
    }
}
//========================================================


proc pickCoors()
{
// find a location -- adjust range symmetrically around location
// where in current clip scales --- these are fixed between 0 and 1
  <<"pickcoors\n"
  E->geteventrxy(rinfo)


  woival2  = iv[13]

  woival = E->geteventwoivalue() 

  button2 = iv[8]

  button = E->getbutton()


  rcx = rinfo[1]
  rcy = rinfo[2]

<<"%V$rcx $rcy \n"

// where in Mandel coors
//  rcx = 0.5
//  rcy = 0.5


  mcx = xrange * rcx + xr0
  mcy = yrange * rcy + yr0

  woname = E->geteventwoname()
  etype = E->geteventtype()

  setgwob(msgwo,@border,@textr,"%V$button $button2 $woname $woival $woival2",0.1,0.3)
  setgwob(msgwo,@border,@textr,"$iv ",0.1,0.1)


// adjust in/out

  if (etype @= "PRESS") {

  if (button == 1) {
    xrange *= 0.85
    yrange *= 0.85
  }
  else if (button == 3) {
    xrange *= 1.1
    yrange *= 1.1
  }

  if (woival == WCEN) {

     if (button == 1) {
      xrange *= 0.85
      yrange *= 0.85
     }
     else {
    xrange *= 1.1
    yrange *= 1.1
     }

  }
 }

  drx = xrange * 0.5
  dry = yrange * 0.5


// new positions in Mandel space
<<"%V$woname $button $woival \n"

  if (etype @= "PRESS") {
  xr0 = mcx - drx
  xr1 = mcx + drx
  yr0 = mcy - dry
  yr1 = mcy + dry
  }

// xrange, yrange have been adjusted in,out

<<"%V$button setting scales %12.8f$xr0 $yr0 $xr1 $yr1 $xrange $yrange \n"

}
//========================================================
proc moveCoors()
{
<<"moveCoors %V  $xr0 $yr0 $xr1 $yr1 \n"
  woival = E->geteventwoivalue() 

  drx = xrange * 0.1
  dry = yrange * 0.1

<<"%V $drx $dry $xrange $yrange \n"
<<"%V $woival \n"
  switch (woival) {

  case WLEFT:
   xr0 -= drx;
   xr1 -= drx;
<<"shift LEFT $xr0 $xr1 \n"
  break;

  case WUP:
   yr0 += dry
   yr1 += dry
<<"shift UP $yr0 $yr1 \n"
  break;

  case WDOWN:
   yr0 -= dry
   yr1 -= dry
<<"shift DOWN $yr0 $yr1 \n"
  break;

  case WRIGHT:
   xr0 += drx
   xr1 += drx
<<"shift RIGHT $xr0 $xr1 \n"
  break;

  case WLDWN;

   xr0 -= drx;
   xr1 -= drx;
   yr0 -= dry;
   //yr1 -= dry;
   yr1 = yr1 -dry;
<<"WLDWN   %V  $xr0 $yr0 $xr1 $yr1   \n";
   break;


  case WCEN:

/{
   xr0 = mcx - drx
   xr1 = mcx + drx
   yr0 = mcy - dry
   yr1 = mcy + dry
/}

   xr0 += drx
   xr1 -= drx
  // yr0 += dry
  // yr1 -= dry
   yr0 += drx
   yr1 -= drx
  break;
 }

<<"moveCoors DONE  $xr0 $yr0 $xr1 $yr1 \n";

  sWo(mandwo,@scales,xr0,yr0,xr1,yr1);


}
//========================================================
laser = 0


proc mand_menu(w)
{

  ur_c=choice_menu("mandelbrot")

    if (ur_c @= "save") 
      save_image(w,"mand_pic")


    if (ur_c @= "magnify") {
      do_mag = 1
      setup(w)
    }

    if (ur_c @= "coors")
      new_coors(w)
    

    if (ur_c @= "rmap") 
      rmap *= -1
    

                  if (ur_c @= "zoom")  { 
                    do_zoom =1
                    return zoom_mand(w)
                  }

    if (ur_c @= "laser") {
      setup(w)
      open_laser("pic.ps")
      scr_laser(w)
      laser = 1
    }

}

# make window

 if (!Graphic) {
     X=spawngwm()
  }

if (Graphic) {
aslw = asl_w ("MAND_")
}

wx = 10
wy = 10
wX = 300
wY = 300

 vp =  cWi("title","Mand",@resize,0.1,0.05,0.99,0.99,0)

 <<"$vp \n"
     
 w =vp

 int wc[] = {1,200,200,750,750};


 bx = 0.05
 by = 0.05
 bX = 0.75
 bY = 0.80

 mandwo=cWo(vp,"GRAPH",@name,"MANDEL_1",@color,"white",@resize,bx,by,bX,bY)
 sWo(mandwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red", @redraw)
 sWo(mandwo,@SCALES,0,0,1,1)
 sWo(mandwo,@pixmapon,@drawon,@savepixmap)
 sWo(mandwo,@clip,0.05,0.05,0.95,0.95)



  msgwo=cWo(vp,"TEXT",@name,"COOR",@VALUE,"0.0 0.0",@color,"white",@resize,0.1,0.89,0.9,0.99)

  sWo(msgwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @pixmapoff,@drawon,@redraw,@save)


 bx = bX + 0.02
 bX = 0.98
 by = 0.82
 bY = 0.87
 yht = bY-by 
 pad = 0.02



 qwo=cWo(vp,"BV",@name,"QUIT",@color,RED_,@resize,bx,by,bX,bY)
 sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"ON")


 bY = by - pad
 by = bY - yht

 selwo=cWo(vp,"BN",@name,"SELECT",@VALUE,"SELECT",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(selwo,@help," click to select box")
 sWo(selwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 bY = by - pad
 by = bY - yht

 resetwo=cWo(vp,"BN",@name,"RESET",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(resetwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw, @help," click to reset coors")

 bY = by - pad
 by = bY - yht

 initwo=cWo(vp,"BN",@name,"INIT",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(initwo,@help," click to reset coors",@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 bY = by - pad
 by = bY - yht

 xr0wo=cWo(vp,"BV",@name,"XR0",@VALUE,"0.0",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(xr0wo,@help," show xr0")
 sWo(xr0wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@STYLE,"SVR", @redraw)

 bY = by - pad
 by = bY - yht

 xr1wo=cWo(vp,"BV",@name,"XR1",@VALUE,"0.0",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(xr1wo,@help," show xr1")
 sWo(xr1wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@STYLE,"SVR", @redraw)

 bY = by - pad
 by = bY - yht

 yr0wo=cWo(vp,"BV",@name,"YR0",@VALUE,"0.0",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(yr0wo,@help," show yr0")
 sWo(yr0wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@STYLE,"SVR", @redraw)

 bY = by - pad
 by = bY - yht

 yr1wo=cWo(vp,"BV",@name,"YR1",@VALUE,"0.0",@color,"blue",@resize_fr,bx,by,bX,bY)
 sWo(yr1wo,@help," show yr1")
 sWo(yr1wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@STYLE,"SVR", @redraw)


 upwo=cWo(vp,SYMBOL_,@name,"UP",@value,WUP,@color,"green",@symbolshape,"tri")

 dwnwo=cWo(vp,SYMBOL_,@name,"DOWN",@value,WDOWN,@color,"green",@symbol,"tri",@symang,180)

 ltwo=cWo(vp,SYMBOL_,@name,"LEFT",@value,WLEFT,@color,"green",@symbol,"tri",@rotate,90,@symang,90)

 rtwo=cWo(vp,SYMBOL_,@name,"RIGHT",@value,WRIGHT,@color,"green",@symbol,"tri",@symang,-90)

 ruwo=cWo(vp,SYMBOL_,@name,"RU",@value,WRUP,@color,"green",@symbol,"tri",@symang,-45)

 rdwo=cWo(vp,SYMBOL_,@name,"RD",@value,WRDWN,@color,"green",@symbol,"tri",@symang,-135)

 luwo=cWo(vp,SYMBOL_,@name,"LU",@value,WLUP,@color,"green",@symbolhape,"tri",@symang,45)

 ldwo=cWo(vp,SYMBOL_,@name,"LD",@value,WLDWN,@color,"green",@symbolshape,"tri",@symang,135)

 cenwo=cWo(vp,SYMBOL_,@name,"CEN",@value,WCEN,@color,"orange",@symbol,"dia",@symang,0)

 int pos_array[] = { luwo, upwo, ruwo,  ltwo,  cenwo, rtwo, ldwo, dwnwo, rdwo }

  sWo(pos_array ,@BORDER,@PIXMAPON,@CLIPBORDER,@FONTHUE,"black")

  wo_rctile(pos_array,0.78, 0.05, 0.98, 0.25,3,3)

  setgwin(vp ,"woredrawall")

  sWo(cenwo,@pixmapon,@symbolshape,"cross",@symsize,5,@redraw)
  sWo(pos_array,@symsize,3,@showpixmap)
  // nxpixs = SGCL[3] -  SGCL[1]
  // nypixs = SGCL[4] -  SGCL[2]

 <<"%V$wc \n"


   // make drawing clip area square !
   wc = wogetclip(mandwo)

// wc[1] to wc[4] clip boundaries
// wc[7] to wc[10] wob boundaries



   nyp = wc[4]-wc[2]
   nx =  wc[3]-wc[1] 

   if ((nyp % 2)) {
         nyp++
   }

    nxp = nyp

    nx2 = (nx-nxp)/2

   cx = 4
   cX = cx + nxp
   cy = 2
   cY = 30

     x= -1.4
     y = -1.4

     dx = 0.01
     dy = 0.03

     hue = 1

  offx = wc[1] - wc[7]
  offy = wc[2] - wc[8]

<<"%V$offx $offy \n"


// reset the clip 

    sWo(mandwo,@CLIP,offx,offy,nxp,nyp,2,@redraw)
    sWo(mandwo,@ClipBorder,"pink")

//  the clip plot area is going to be square  --- nxp == nyp
//  keep yscale 0-1 --- adjust xscale 0 --- nx/nxp

    float cwx1  = nx / (1.0 * nxp)

    sWo(mandwo,@SCALES,0,0,cwx1,1)


int kt



double z

rmap = -1

char C[1024]
short CM[1024]


# black
// num colors 


int nc = 64
int ni = nc * 4

    RGBV = Urand(nc * 3)
    RGBV->Redimn(nc,3)

CM[ni] = 0
CM[ni-1] =0
CM[ni-2] =0

np = 16
    //np = get_planes()

<<"%V$np \n"

//np =2;

  if (np <= 2) {
    mono = 1
    CM[ni] =0
      for ( i = 0 ; i < (ni-4); i += 2 ) {
        CM[i] = 1;
      }
      for ( i = 1 ; i < (ni-4); i +=  2 ) {
        CM[i] = 0;
      }
  }
  else {
    mono =0
    cz = ni / nc
    j = 1
    k = 1
    top = ni -2
      //for ( i = 0 ; i++ < top ;  ) {
        for ( i = 0 ; i < top ; i++ ) {
           CM[i] = k
           j++
          if ( j >= cz ) {
            j = 1
            k++
          }
      }
  }


double yr0 = -2.0
double yr1 = 2.0
double xr0 = -2.0
double xr1 = 2.0
double x0 = 0.0
double c1 = 0.0

// initial coors and range
double xrange = xr1 - xr0 
double yrange = yr1 - yr0
double mcx = 0.0
double mcy = 0.0
double rcx = 0
double rcy = 0
double rsfactor = 1.0  // current scale factor
double drx = xrange * 0.85
double dry = yrange * 0.85

// our window scales are float -- want to leave them set and maintain a double or ap scale value
// get an x,y location in clip  which is always in the range -1,1
// then use scale factor to determine input values for Mandel calc

// x^2 * y^2 + c


int kk = 1
int jj = 0

double dinxp = 1.0/(1.0 * nxp)

  cmapi = 0

// first calc

        c1 = xr0 + (xrange * x0 * dinxp)
        kmp = Mandel(c1,yr0,yr1,4.0,nyp,ni,CM,C)

//<<"%V$x0 $c1 $yr0 $yr1 $nyp $nxp $ni\n"
//<<"%V $kmp \n"

//<<"$CM \n"
//<<"$C \n"


  x0 = 0.0

<<"$CM\n"
<<"%V$ni\n"
        while (1) {

        x0++

        kmp = Mandel(c1,yr0,yr1,4.0,nyp,ni,CM,C)

        vpc(mandwo,C,cmapi,x0,0,-1);

        //sWo(mandwo,@clipborder,@showpixmap)

//<<"%V$x0 $c1 $yr0 $yr1 $nyp $nxp $ni\n"
//<<"%V $kmp \n"
//<<"$CM \n"
//<<"$C \n"


        if ( x0 >= nxp) {
            break
         }

        }
//////////////

         flush_messages()


<<"%V$xr0 $xr \n"
<<"%V$nxp $nyp \n"

  x0 = 0.0


///////////////////////////////////////////  INTERACTIVE //////////////////////////////////////////////

  c= "EXIT"



  setGwindow(vp,@border,@redraw)

  //pickCoors(vp)     

  sWo(mandwo,@clipborder,@showpixmap,@savepixmap,@save)
  sWo(xr0wo,@VALUE,"%5.4f$xr0",@update)
  sWo(yr0wo,@VALUE,"%5.4f$yr0",@update)

  reset_xr0 = xr0
  reset_xr1 = xr1
  reset_yr0 = yr0
  reset_yr1 = yr1

  x0 = 0

  dinxp = xrange /(1.0 * nxp)

  while (1) {

        kk++

        if ( x0 <= nxp) {
           // draw until done
           c1 = xr0 + x0 * dinxp

           kmp = Mandel(c1, yr0, yr1, 4.0, nyp, ni,CM,C)

//<<"%V$yr0 $yr1 $c1 $x0 $kmp\n"
//<<"$C\n"
//iread()
           vpc(mandwo,C,cmapi,x0,nyp,1);

// plot vector of pixels
// <<" $(Cab(C)) \n"
// <<"%V$C[::] \n"

           x0++;

          //sWo(mandwo,@clipborder,@showpixmap)

      }
      else {
        // then check
        sWo(mandwo,@clipborder,@showpixmap,@savepixmap,@save)

  //sWo(cenwo,@pixmapon,@symbolshape,"tri",@symsize,5,@redraw)
  //sWo(cenwo,@showpixmap)
  sWo(pos_array,@redraw)
  sWo(pos_array,@showpixmap)
//        save_image(mandwo,"mand_pic")
        jj++

# recheck window 

       msg = messageWait()

       sWo(msgwo,@border,@clearclip,@textr,"$msg",0.1,0.5)

       woname = E->getEventWoName()    

<<"$woname   "

       E->getEventState(iv)    

       if (scmp(woname,"QUIT",4)) {
             exit_gs()
             break
       }

       if (scmp(woname,"RESET")) {

       xr0 = reset_xr0 
       xr1 = reset_xr1 
       yr0 = reset_yr0 
       yr1 = reset_yr1 


       sWo(mandwo,@scales,xr0,yr0,xr1,yr1)

       }

       else if (scmp(woname,"INIT")) {

          yr0 = -2.5 ; yr1 = 2.5 ; xr0 = -2.5 ; xr1 = 2.5 ;

          sWo(mandwo,@scales,xr0,yr0,xr1,yr1)

       }
       else if (scmp(woname,"SELECT",6)) {
    
<<"%V$xr0 $yr0 $xr1 $yr1 $xrange $yrange\n"

        RS=selectreal(mandwo)

        <<"%V$RS\n"

        sWo(msgwo,@border,@textr,"%V6.4f$RS",0.1,0.1)
        // now rescale 
        xr0 = RS[1]
        xr1 = RS[3]
        yr0 = RS[2]
        yr1 = RS[4]

        sWo(mandwo,@scales,xr0,yr0,xr1,yr1)

<<"%V$xr0 $yr0 $xr1 $yr1 $xrange $yrange $dinxp\n"

       xval = xrange / 5.0 
       yval = yrange / 5.0

       reset_xr0 = xr0
       reset_xr1 = xr1 
       reset_yr0 = yr0
       reset_yr1 = yr1

       }
       else if (iv[3] == mandwo) {

       <<"in MANDEL_1 \n"

          pickCoors()     

       }
       else {
         moveCoors()
       }

         // setup the parameters for the calculation

          sWo(xr0wo,@VALUE,"%5.4f$xr0",@update)
          sWo(xr1wo,@VALUE,"%5.4f$xr1",@update)
          sWo(yr0wo,@VALUE,"%5.4f$yr0",@update)
          sWo(yr1wo,@VALUE,"%5.4f$yr1",@update)
          sWo(mandwo,@BORDER,@CLIPBORDER, @redraw)

          xrange = xr1-xr0
          yrange = yr1-yr0
          xval = xrange / 5.0 
          yval = yrange / 5.0
          axnum(mandwo,1,xr0,xr1,xval,0.5,"4.3f")
          axnum(mandwo,2,yr0,yr1,yval,0.5,"4.3f")
          dinxp = xrange /(1.0 * nxp)
          x0 = 0.0 // reset     

    }

  }

STOP!


/{
proc rand_coors()
{

/{
 MS= GetMouseEvent(w_num)


 button = MS[2]

  <<"$kt $button %6.2f $MS[0:12] \n"
kt++
   RS=WGetRS(w_num)
//<<"%v  $RS[*] \n"


 // button = 0

  drx = (RS[3] - RS[1])  * rsfactor
  dry = (RS[4] - RS[2]) * rsfactor

//  double rcx = MS[7]   * rsfactor
//  double rcy = MS[8]  * rsfactor

  rcx = MS[7]   * rsfactor
  rcy = MS[8]  * rsfactor

<<" %V $drx $dry $rcx $rcy \n"

  


  if ( button == 1) {
      <<" zooming in \n"
  mscale = 2.5

  xr0= rcx - drx/mscale
  xr1= rcx + drx/mscale
  yr0= rcy - dry/mscale
  yr1= rcy +  dry/mscale

  }
  else if ( button == 3 ) {
<<" zooming out \n"

   setup(w_num)

#{
  mscale = 0.6
  xr0= rcx - drx/mscale
  xr1= rcx + drx/mscale
  yr0= rcy - dry/mscale
  yr1= rcy + dry/mscale
#}


  }
  else if ( button == 0) {

  xr0= Urand() * -2.0
  xr1= Urand() * 2.0
  yr1= Urand() * 2.0
  yr0= Urand() * -2.0


  }

  else if ( button == 2) {
   mscale = 1

<<" centering \n"

  xr0= rcx - drx/mscale
  xr1= rcx + drx/mscale
  yr0= rcy - dry/mscale
  yr1= rcy + dry/mscale


  }

/}




//  rcx = Rinfo[1]
//  rcy = Rinfo[2]

  rcx = rinfo[1]
  rcy = rinfo[2]

  xr0= rcx - drx
  xr1= rcx + drx
  yr0= rcy - dry
  yr1= rcy +  dry

  if (Minfo[8] == 1) {
  drx *= 0.50
  dry *= 0.50
  }
  else {
  drx *= 1.6
  dry *= 1.6
  }

//  xr0= Urand() * -2.0
//  xr1= Urand() * 2.0
//  yr1= Urand() * 2.0
//  yr0= Urand() * -2.0

  xr = xr1-xr0

  if (xr < 0.01) {
    rsfactor = 0.01
  }
  else if (xr < 0.00001) {
    rsfactor = 0.00001
  }
  else if (xr < 0.0000001) {
    rsfactor = 0.0000001
  }
  else {
  rsfactor = 1.0
  }


  <<"$E->button setting scales $w_num   %12.8f$xr0 $yr0  $xrange $yrange \n"


  if (rsfactor == 1.0) {
   sWo(mandwo,@scales,xr0,yr0,xr1,yr1)
  }
  else {
    sWo(mandwo,@scales,xr0,yr0,xr1,yr1)
   //SetGwindow(mandwo,@scales,xr0/rsfactor,yr0/rsfactor,xr1/rsfactor,yr1/rsfactor)
  }

  x0 = 0
}
/}
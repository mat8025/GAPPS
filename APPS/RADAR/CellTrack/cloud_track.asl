// (1) show how clouds track with turning/drift
// (2) show how clouds move with stormtrack


//  radar_screen
//  range-rings
//  Monitors
//  heading/ relative bearing/ track/ altitude / turn-rate
//  time, sweep


// some clouds
// lat,long positioning = big,medium, small, shape


// merge - if hot core area - neighbouring small green - merge as edge
// split - if two/multiple distinct hot cores and sufficient 
// intermediate lower level area




// sweep timing

// Monitor resources


// read in reflectivity area 
// contour extraction of areas 
// build clouds

// off-screen positioning = for turning and clouds falling behind the plane
setdebug(0)


//////////////////////////////// RADAR SCREEN ///////////////////////////
opendll("plot")

Graphic = CheckGwm()
     if (!Graphic) {
        X=spawngwm()
     }

    svar Wtitle = "CLOUD_TRACK"
    // main window on screen
    vp = CreateGwindow(@title,Wtitle,@resize,0.05,0.01,0.99,0.99,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    cx = 0.01
    cX = 0.95
    cy = 0.1
    cY = 0.99

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    svar Woname = "RADAR_SCREEN"

    gwo=CreateGWOB(vp,@GRAPH,@resize,0.05,0.05,0.99,0.99,@name,Woname,@color,"white")

    setgwob(gwo,@clip,cx,cy,cX,cY)

    // scales 
    sx = -80
    sX = 80
    sy = 0
    sY = 80
    // units  - nautical miles

    setgwob(gwo,@scales,sx, sy, sX, sY, @save,@redraw,@drawoff,@pixmapon)

    SetGwob(gwo,@clearpixmap,@clipborder,@redraw,@save)




/////////////////////////////////////////////////////////////////////////////////////////////////

// sample cloud
// the bearings are relative to the nose
// if hdg changes  add the delta


proc get_ang( rel_brg)
{

  rad_a = deg2rad(90 - rel_brg)

  return rad_a
}

///////////////////////////////////////////////////////////////////////////////////////////////////


Cid = 0;

class Cloud {

 public:
 
 float cen_brg ;
 float right_brg ;
 float left_brg ;

 float  cen_bin 
 float  left_cen_bin 
 float  right_cen_bin

 float  ln_extent 
 float  lf_extent 

 float  rn_extent 
 float  rf_extent 

 float  cn_extent 
 float  cf_extent 

 int hue;
 int id;


 CMF Cloud ()
  {

   cen_brg = 0;
   right_brg = 1;
   left_brg = -1;
   cen_bin = 20
   left_cen_bin = 20 
   right_cen_bin = 20 

   ln_extent = 1
   lf_extent = 1

   rn_extent = 1
   rf_extent = 1

   cn_extent = 1
   cf_extent = 1

   hue = GREEN
   id = Cid++;

  }


  CMF Set (sbrg, dbrg, srng, dbin)
  {
    cen_brg = sbrg
    left_brg = cen_brg - dbrg
    right_brg = cen_brg + dbrg

   cen_bin = srng
   left_cen_bin = srng 
   right_cen_bin = srng

   ln_extent = dbin
   lf_extent = dbin

   rn_extent = dbin
   rf_extent = dbin

   cn_extent = 1.5 * dbin
   cf_extent = 1.5 * dbin


  }

  CMF SetHue (wc)
   {

     hue = wc


   }

 CMF Plot()
 {
  wc = hue
// from near center clockwise round cloud
// as the aircraft moves/turns relative bearing will change
  r = cen_bin - cn_extent
  ra = get_ang(cen_brg)
  x = r * cos(ra)
  y = r * sin(ra)
  r = left_cen_bin - ln_extent
  ra = get_ang(left_brg)
  X = r * cos(ra)
  Y = r * sin(ra)

  plot(gwo,@line, x,y,X,Y, wc)

  r = left_cen_bin 
  X = r * cos(ra)
  Y = r * sin(ra)
  
  plot(gwo,@lineto,X,Y, wc)
  r = left_cen_bin + lf_extent 
  X = r * cos(ra)
  Y = r * sin(ra)
  
  plot(gwo,@lineto,X,Y, wc)
  ra = get_ang(cen_brg)
  r = cen_bin + cf_extent 
  X = r * cos(ra)
  Y = r * sin(ra)
  
  plot(gwo,@lineto,X,Y, wc)
  ra = get_ang(right_brg)
  r = right_cen_bin + rf_extent 
  X = r * cos(ra)
  Y = r * sin(ra)
  
  plot(gwo,@lineto,X,Y, wc)
  r = right_cen_bin 
  X = r * cos(ra)
  Y = r * sin(ra)
  
  plot(gwo,@lineto,X,Y, wc)
  r = right_cen_bin - rn_extent
  X = r * cos(ra)
  Y = r * sin(ra)

  plot(gwo,@lineto,X,Y, wc)
  r = cen_bin - cn_extent
  ra = get_ang(cen_brg)
  X = r * cos(ra)
  Y = r * sin(ra)

  plot(gwo,@lineto,X,Y, wc)
 }

 CMF AdjustBrg(hdg_change, range_change)
   {
// +ve change is clockwise
 
  cen_brg -= hdg_change
  right_brg -= hdg_change
  left_brg -= hdg_change
//  <<"%V$cen_brg $right_brg $left_brg \n"
 }


}


delta_brg = 7

//////////////// Sky //////////////

proc set_reflec_patch( isx, isy, r_rad, col)
{

 rad = r_rad
 ixp = isx
 iyp = isy

 istart = iyp - rad
 iend = iyp + rad

 jstart = ixp - rad
 jend = ixp + rad

 for (i = istart; i < iend; i++) {
  for (j = jstart; j < jend; j++) {
             ix = j - ixp
             iy = i - iyp
             fr = Sqrt( ix * ix + iy * iy)
             if (fr < rad) {
               Sky[i][j] = col
             }
  }
 }

}




uchar Sky[500][500]
// make up sky patches ( reflect areas) 

 lb_hue = getColorIndexFromName("lightblue")
 orange_hue = getColorIndexFromName("orange")
 setrgbIndexFromName(17,"lilac")
 lilac_hue = 17
 Sky[0:99][::] = 0
 //Sky[100:149][::] = 1
 //Sky[150:199][::] = orange_hue
 Sky[200:299][::] = lb_hue
 Sky[350:399][::] = lilac_hue

 //Sky[350:352][::] = 5

 set_reflec_patch( 175, 200, 25, RED)

 set_reflec_patch( 450, 100, 10, GREEN )

 set_reflec_patch( 450, 400, 30, YELLOW )

 set_reflec_patch( 50, 100, 40, PINK)




proc plot_sky()
{




 plotPixRect(gwo,Sky,0)


  

}


////////////////////////////

Cloud C[5]

  C[0]->Set(80,5,40,5)
  C[0]->SetHue(RED)

  C[1]->Set(-45,7,60,7)
  C[1]->SetHue(BLUE)
  C[2]->Set(0,3,60,4)

  C[3]->Set(-5,3,60,4)

  C[4]->Set(30,3,66,4)
  C[4]->SetHue(CYAN)


  hdg = 0.0  // North
  last_hdg = hdg
  d_brg = 0.0
  d_rng = 0.0
// some test lines
 dt= 4.0/180

   radius = 80

 while (1) {

   ang = 180.0

//   plot_cloud(GREEN)
     hue = RED
     for (i = 0; i < 5; i++) {
         C[i]->Plot(hue)
         hue++
     }

   SetGwob(gwo,@showpixmap)
   SetGwob(gwo,@drawon)

   plot_sky()


   for (ang = 180 ; ang > 0; ang -= 2) {
    ra = deg2rad(ang)
    y= radius * sin(ra)
    x= radius * cos(ra)
    plot(gwo,@line,0,0,x,y, BLUE,"xor")  // draw as xor - so next draw will undo
    si_pause(dt)
    plot(gwo,@line,0,0,x,y, BLUE,"xor")  // the undo
   }   


   setgc("copy")

   hdg += 12 ;
   hdg = (hdg % 360)
   d_hdg = hdg - last_hdg
   last_hdg = hdg
   setgwob(gwo,@clearpixmap)

   //plot_cloud(RED)
   //adjust_cloud_brg(d_hdg, d_rng)

     for (i = 0; i < 5; i++) {
        C[i]->AdjustBrg(d_hdg, d_rng)
     }

}



/{
     C[0]->AdjustBrg(d_hdg, d_rng)
     C[1]->AdjustBrg(d_hdg, d_rng)
     C[2]->AdjustBrg(d_hdg, d_rng)
     C[3]->AdjustBrg(d_hdg, d_rng)
/}

   
///////////////////////////////////////////////////////////////////////////////////////////////


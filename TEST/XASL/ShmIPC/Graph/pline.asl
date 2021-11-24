/// 

include "debug"
include "graphic"
include "hv.asl"

include "gevent"



//pi = 4.0 * atan(1.0)

// PLINE DEMO 
/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = cWi("title","XYPLOT","resize",0.05,0.01,0.99,0.95,0)
    sWi(vp,@pixmapff,@drawon,@save,@bhue,WHITE_)

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=cWo(vp,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"LP",@color,"white")
    sWo(gwo,@clip,cx,cy,cX,cY)
    sWo(gwo,@scales,0,-1.2,4,1.2, @save,@drawon,@pixmapoff)
    sWo(gwo,@rhtscales,-4,-2.2,4,2.2)

titleButtonsQRD(vp);
  
////////////////////////////// PLINE ////////////////////////////////////////
void Pline()
{

  sWo(gwo,@usescales,0,@hue,RED_,@line,0,0,1,1,"green")
  sWo(gwo,@hue,"red",@line,0.2,0,1,0.9,"orange")

  sWo(gwo,@clipborder,BLACK_,@line,0,1,1,0,BLUE_)


  plot(gwo,@line,0,0.5,1,0.5,BLUE_)

  plot(gwo,@symbol,0.5,0.5,"star5")

  plot(gwo,@circle,0.5,0.5,0.5,GREEN_)

  plot(gwo,@box,0.5,0.5,0.7,0.7,BLACK_)

  //plotgw(vp,@symbol,0.5,0.5,"triangle")

  //sWo(gwo,@showpixmap)

  sWo(gwo,@usescales,1,@clipborder,BLUE_,@border,BLACK_)

  x = 0.2
  y = 0.2
  last_x = x
  last_y = y
  int i;
  /*
  for (i = 0; i < 200; i++) {
    plot(gwo,@symbol,x,y,"triangle",5,RED_)
    x += 0.05
    y =  Sin(x)
    plot(gwo,@line,last_x,last_y,x,y,GREEN_)
  last_x = x
  last_y = y
  }
*/
//  sWo(gwo,@showpixmap)

  axnum(gwo,1)
  axnum(gwo,2)
  axnum(gwo,3)
  axnum(gwo,4)

//  sWo(gwo,@gridhue,BLUE_)

//  grid(gwo)
}


  Pline();


 // test  postscript print
do_laser = 1;

ans=query("replot to postscript?")


 if (do_laser) {
     OpenLaser("pline.ps",1) ; //landscape 1 0 portrait
  
      ScrLaser(vp)
// ScrLaser(gwo)  //  not required the window scrlaser operates on all wobs
      Pline()

      CloseLaser()
<<" did we produce a postscript ?\n"
    }











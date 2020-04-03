/// 

include "debug.asl"
include "graphic"
include "hv.asl"

include "gevent"



//pi = 4.0 * atan(1.0)

// PLINE DEMO 
/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = cWi("title","XYPLOT","resize",0.05,0.01,0.99,0.95,0)
    sWi(vp,"pixmapon","drawon","save","bhue","white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=cWo(vp,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"LP",@color,"white")
    sWo(gwo,@clip,cx,cy,cX,cY)
    sWo(gwo,@scales,0,-1.2,4,1.2, @save,@drawon,@pixmapon)
    sWo(gwo,@rhtscales,-4,-2.2,4,2.2)

titleButtonsQRD(vp);
  
////////////////////////////// PLINE ////////////////////////////////////////


  sWo(gwo,@usescales,0,@hue,"red",@line,0,0,1,1,"green")
  sWo(gwo,@hue,"red",@line,0.2,0,1,0.9,"orange")

  sWo(gwo,@clipborder,"black",@line,0,1,1,0,BLUE_)


  plot(gwo,@line,0,0.5,1,0.5,BLUE_)

  plot(gwo,@symbol,0.5,0.5,"star5")

  plot(gwo,@circle,0.5,0.5,0.5,GREEN_)

  //plotgw(vp,@symbol,0.5,0.5,"triangle")

  SWo(gwo,@showpixmap)

  sWo(gwo,@usescales,1,@clipborder,BLUE_,@border,BLACK_)

  x = 0.2
  y = 0.2
  last_x = x
  last_y = y
  int i
  for (i = 0; i < 200; i++) {
    plot(gwo,@symbol,x,y,"triangle",5,RED_)
    x += 0.05
    y =  Sin(x)
    plot(gwo,@line,last_x,last_y,x,y,GREEN_)
  last_x = x
  last_y = y
  }

  SWo(gwo,@showpixmap)

  axnum(gwo,1)
  axnum(gwo,2)
  axnum(gwo,3)
  axnum(gwo,4)

  sWo(gwo,@gridhue,BLUE_)

  grid(gwo)



while (1) {


 eventWait();
}






///
///   Move wo --- via mouse - or keyb
///


setDebug(1,@keep,@filter,0)



Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

include "tbqrd"

    vp = cWi(@title,"MoveV",@resize,0.01,0.01,0.45,0.49,0)

   titleButtonsQRD(vp);


    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_)
    sWi(vp,"scales",0,-0.2,1.5,1.5)
    sWi(vp,"clip",0.2,0.2,0.9,0.9)
    sWi(vp,@clipborder,BLACK_,@redraw,@save)

   vp2 = cWi(@title,"MoveH",@resize,0.46,0.01,0.95,0.49,0)


    sWi(vp2,@pixmapon,@drawon,@save,@bhue,WHITE_)
    sWi(vp2,"scales",0,-0.2,1.5,1.5)
    sWi(vp2,"clip",0.2,0.2,0.9,0.9)
    sWi(vp2,@clipborder,BLACK_,@redraw,@save)


   vp3 = cWi(@title,"MoveVH",@resize,0.46,0.51,0.95,0.98,0)


    sWi(vp3,@pixmapon,@drawon,@save,@bhue,WHITE_)
    sWi(vp3,"scales",0,-0.2,1.5,1.5)
    sWi(vp3,"clip",0.2,0.2,0.9,0.9)
    sWi(vp3,@clipborder,BLACK_,@redraw,@save)



  rx = 0.2
  rX = 0.3

  gx = 0.4
  gX = 0.5

  bx = 0.6
  bX = 0.7

  cby = 0.1
  cbY = 0.3

  cbx = 0.1
  cbX = 0.6

 redv = 0.5
 greenv = 0.5
 bluev = 0.5


  rwo=cWo(vp,"BV",@name,"Red",@value,"$redv",@style,"SVB")

  sWo(rwo,@color,"red",@penhue,"black")

  gwo=cWo(vp,"BV",@resize,gx,cby,gX,cbY,@NAME,"Green",@VALUE,"$greenv")

  sWo(gwo,@color,"green",@penhue,"black",@style,"SVB",@symbol,"tri")

  bwo=cWo(vp,"BV",@resize,bx,cby,bX,cbY,@NAME,"Blue",@VALUE,bluev)

  sWo(bwo,@color,"blue",@penhue,"black",@style,"SVB")


  int rgbwo[] = { rwo, gwo, bwo }
 
  wo_htile( rgbwo, cbx,cby,cbX,cbY,0.02)

  sWo( rgbwo, @vmove,1,@redraw)




  r2wo=cWo(vp2,"BV",@name,"Red",@value,"$redv",@style,"SVB")

  sWo(r2wo,@color,"red",@penhue,BLACK_)

  g2wo=cWo(vp2,"BV",@resize,gx,cby,gX,cbY,@NAME,"Green",@VALUE,"$greenv")

  sWo(g2wo,@color,"green",@penhue,BLACK_,@style,"SVB",@symbol,"tri")

  b2wo=cWo(vp2,"BV",@resize,bx,cby,bX,cbY,@NAME,"Blue",@VALUE,bluev)

  sWo(b2wo,@color,"blue",@penhue,BLACK_,@style,"SVB")


  int rgb2wo[] = { r2wo, g2wo, b2wo };
 
  wo_vtile( rgb2wo, 0.1,0.1,0.3,0.9,0.02);

  sWo( rgb2wo, @hmove,1,@redraw);




  r3wo=cWo(vp3,"BV",@name,"Red",@value,"$redv",@style,"SVB")

  sWo(r3wo,@color,"red",@penhue,BLACK_)

  g3wo=cWo(vp3,"BV",@resize,gx,cby,gX,cbY,@NAME,"Green",@VALUE,"$greenv")

  sWo(g3wo,@color,"green",@penhue,BLACK_,@style,"SVB",@symbol,"tri")

  b3wo=cWo(vp3,"BV",@resize,bx,cby,bX,cbY,@NAME,"Blue",@VALUE,bluev)

  sWo(b3wo,@color,"blue",@penhue,BLACK_,@style,"SVB")


  int rgb3wo[] = { r3wo, g3wo, b3wo };
 
  wo_vtile( rgb3wo, 0.3,0.1,0.35,0.9,0.1);

  sWo( rgb3wo, @hvmove,1,@redraw);



include "gevent"


   while (1) {

     eventWait()

<<"$_emsg \n"


   }

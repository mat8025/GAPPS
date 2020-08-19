opendll("math")
setdebug(1)
    ms=getMsecs()

     if (!CheckGwm()) {
       X=spawngwm()
       spawn_it  = 0;
     }
    ms=getMsecs()

pi = 4.0 * atan(1.0)

// PLINE DEMO 
/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = CreateGwindow("title","ARGAND","resize",0.05,0.01,0.99,0.95,0)
    SetGwindow(vp,"pixmapon","drawon","save","bhue","white")
    ms=getMsecs()
    gsync()
    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=CreateGWOB(vp,"GRAPH",@resize,0.15,0.2,0.95,0.95,@name,"LP",@color,"white")
    setgwob(gwo,@clip,cx,cy,cX,cY)
    setgwob(gwo,@scales,-10,-10,10,10, @save,@redraw,@drawon,@pixmapon)


    vptxt=CreateGWOB(vp,"TEXT",@name,"TXT",@resize,0.1,0.01,0.75,0.19,@color,"blue")

    setgwob(vptxt,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK, @redraw,@pixmapoff,@drawon)
    setgwob(vptxt,@scales,-1,-1,1,1)


////////////////////////////// PLOT some complex points ////////////////////////////////////////

  cmplx a
  cmplx b
  cmplx c


  a->Set(2.5,3.5)
  b->Set(4,-2)

  c = a + b
  d = a * b
  mag = a->Mag()
  ph = a->Phase()
  re = a->getReal()
  im = a->getImag()

<<"%V$mag $ph $re $im\n"

  setgwob(vptxt,@scrollclip,UP,8) 
  setgwob(vptxt,@textr,"%V$mag $ph $re $im",-0.4,-0.2) 

  
  plotgw(gwo,@symbol,re,im,"star")

  setgwob(gwo,@clipborder,BLUE,@border,BLACK)

  plotline(gwo,0,0,re,im,BLUE)

  re = b->getReal()
  im = b->getImag()

  plotgw(gwo,@symbol,re,im,"triangle",5,RED)

  plotline(gwo,0,0,re,im,"yellow")

  setgwob(vptxt,@scrollclip,UP,8) 
  setgwob(vptxt,@textr,"%V$mag $ph $re $im",-0.4,-0.2)  
  
  re = c->getReal()
  im = c->getImag()
  setgwob(vptxt,@scrollclip,UP,8,@textr,"%V$mag $ph $re $im",-0.4,-0.2)  
  plotgw(gwo,@symbol,re,im,"triangle",5,GREEN)
  re = d->getReal()
  im = d->getImag()
  setgwob(vptxt,@scrollclip,UP,8,@textr,"%V$mag $ph $re $im",-0.4,-0.2)  
  plotgw(gwo,@symbol,re,im,"diamond",5,YELLOW)


  SetGwob(gwo,@showpixmap)

  axnum(gwo,1,0)
  axnum(gwo,2,0)


  X = -10
  dt = _PI/100.0;
  for (i = 0; i < 200; i++) {
       x = sin(i *dt) * 3
       y = cos(i *dt) * 3
   X += (dt * 10.0/_PI)
   plotgw(gwo,@symbol,x,y,"triangle",5,GREEN)
   plotgw(gwo,@symbol,X,y,"triangle",5,RED)
   plotgw(gwo,@symbol,X,x,"triangle",5,BLUE)
   setgwob(vptxt,@scrollclip,UP,8,@textr,"%V6.2f$x $y",-0.4,-0.8)  
//   sleep(0.05)
  }

  sleep(20)



STOP!



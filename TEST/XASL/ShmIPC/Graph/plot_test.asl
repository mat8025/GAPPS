/// 

     if (!CheckGwm()) {
       X=spawngwm()
       spawn_it  = 0;
     }

/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = CreateGwindow("title","XYPLOT","resize",0.05,0.01,0.99,0.95,0)
    SetGwindow(vp,"pixmapon","drawon","save","bhue","white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=CreateGWOB(vp,"GRAPH",@resize,0.15,0.1,0.95,0.95,@name,"LP",@color,"white")
    setgwob(gwo,@clip,cx,cy,cX,cY)
    setgwob(gwo,@scales,0,-1.2,4,1.2, "save","redraw",@drawon,@pixmapon)
    setgwob(gwo,@rhtscales,-4,-2.2,4,2.2)


////////////////////////////// PLINE ////////////////////////////////////////



  setgwob(gwo,@clipborder,"black",@line,0,-1,1,-1,BLUE_)

  x =0.1
  y = 0.1
  X = 1.3
  Y = 1.4

  plot(gwo,@box,x,y,X,Y,BLUE_,@line,x,y,X,Y,RED_,@line,x,Y,X,y,GREEN_)

  plot(gwo,@circle,x,y,0.7,GREEN_)

  //plotgw(vp,@symbol,0.5,0.5,"triangle")

  SetGwob(gwo,@showpixmap)

  setgwob(gwo,@usescales,1,@clipborder,BLUE,@border,BLACK_)

  SetGwob(gwo,@showpixmap)

  axnum(gwo,1)
  axnum(gwo,2)
  axnum(gwo,3)
  axnum(gwo,4)

//  SetGwob(gwo,@gridhue,BLUE)

  sleep(5)



STOP!



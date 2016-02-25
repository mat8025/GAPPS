/// 



     if (!CheckGwm()) {
       X=spawngwm()
       spawn_it  = 0;
     }


//pi = 4.0 * atan(1.0)

// PLINE DEMO 
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


  setgwob(gwo,@usescales,0,@hue,"red",@line,0,0,1,1,"green")
  setgwob(gwo,@hue,"red",@line,0.2,0,1,0.9,"orange")

  setgwob(gwo,@clipborder,"black",@line,0,1,1,0,BLUE)


  plot(gwo,@line,0,0.5,1,0.5,BLUE)

  plot(gwo,@symbol,0.5,0.5,"star5")

  plot(gwo,@circle,0.5,0.5,0.5,GREEN)

  //plotgw(vp,@symbol,0.5,0.5,"triangle")

  SetGwob(gwo,@showpixmap)

  setgwob(gwo,@usescales,1,@clipborder,BLUE,@border,BLACK)

  x = 0.2
  y = 0.2
  last_x = x
  last_y = y
  int i
  for (i = 0; i < 200; i++) {
    plot(gwo,@symbol,x,y,"triangle",5,RED)
    x += 0.05
    y =  Sin(x)
    plot(gwo,@line,last_x,last_y,x,y,GREEN)
  last_x = x
  last_y = y
  }

  SetGwob(gwo,@showpixmap)

  axnum(gwo,1)
  axnum(gwo,2)
  axnum(gwo,3)
  axnum(gwo,4)

  SetGwob(gwo,@gridhue,BLUE)

  grid(gwo)


  sleep(5)



STOP!



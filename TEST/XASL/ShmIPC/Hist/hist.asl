# plot a histogram of the values in input vector
// 
OpenDll("plot")
opendll("stat")

F = vgen(FLOAT,10,0,2)
<<"%6.1f$F\n"

H=Hist(F,5)

<<"$H \n"
float HF[] 

HF = H

F[3] = 4.3
F[4] = 4.3
<<"%6.1f$F\n"
H=Hist(F,5)

<<"$H \n"



/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    vp = CreateGwindow(@title,"XYPLOT",@resize,0.05,0.01,0.99,0.95,0)

    SetGwindow(vp,@pixmapoff,@drawon,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=CreateGWOB(vp,@GRAPH,@resize,0.15,0.5,0.99,0.95,@name,"LP",@color,"white")

    setgwob(gwo,@clip,cx,cy,cX,cY)

    setgwob(gwo,@scales,-5, 0, 47, 79, @save,@redraw,@drawon,@pixmapon)


////////////////////////////// GLINE ////////////////////////////////////////

<<"$HF\n"

//     xn_gl = CreateGline(@wid,gwo,@type,"HIST",@yvec,HF,@color,"red")

     xn_gl = CreateGline(@wid,gwo,@type,"HIST",@yvec,H,@color,GREEN)

     setGline(xn_gl,@X,5)


  
  //SetGwob(gwo,@clearpixmap,@clipborder)

  DrawGline(xn_gl)


  //SetGwob(gwo,@showpixmap)


     setGline(xn_gl,@color,RED)
  DrawGline(xn_gl)

  SetGwob(gwo,@clipborder)


  sleep(5)
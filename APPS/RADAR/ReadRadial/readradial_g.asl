

//A=ofr("vs.dat")

float Y[256]
float Y2[256]
float LY[512]


OpenDll("plot")
Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

////////////////////// Window //////////////////
    vp = CreateGwindow(@title,"XYPLOT",@resize,0.05,0.01,0.99,0.95,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

///////////////////// Wob //////////////////////
    gwo=CreateGWOB(vp,@GRAPH,@resize,0.15,0.6,0.99,0.95,@name,"SP",@color,"white")

    setgwob(gwo,@clip,0.1,0.1,0.9,0.9)
    setgwob(gwo,@scales,0,0,256 ,30, @save,@redraw,@drawoff,@pixmapon)
//////////////////// Gline //////////////////////

    vec_gl = CreateGline(@wid,gwo,@type,"Y",@yvec,Y,@color,"red")
    vec_sp2_gl = CreateGline(@wid,gwo,@type,"Y",@yvec,Y2,@color,"green")

    SetGwob(gwo,@hue,"green",@refresh)

    SetGwob(gwo,@clearpixmap,@clipborder)


///////////////////// Wob //////////////////////
    lpwo=CreateGWOB(vp,@GRAPH,@resize,0.15,0.2,0.99,0.55,@name,"LP",@color,"white")

    setgwob(lpwo,@clip,0.1,0.1,0.9,0.9)
    setgwob(lpwo,@scales,0,0,512 ,30, @save,@redraw,@drawoff,@pixmapon)
//////////////////// Gline //////////////////////

    vec_lp_gl = CreateGline(@wid,lpwo,@type,"Y",@yvec,LY,@color,"red")

    SetGwob(lpwo,@hue,"green",@refresh)

    SetGwob(lpwo,@clearpixmap,@clipborder)

/////////////////// status ////////////////////


  hwo=createGWOB(vp,"BV",@name,"FRAME",@VALUE,"O",@color,"green",@resize,0.1,0.1,0.2,0.14)

  setgwob(hwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(hwo,@bhue,"teal",@clipbhue,"magenta")
  setgwob(hwo,@value,k,@redraw)


  two=createGWOB(vp,"BV",@name,"TIME",@VALUE,"O",@color,"green",@resize,0.3,0.1,0.6,0.14)

  setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(two,@bhue,"teal",@clipbhue,"cyan")
  setgwob(two,@value,0,@redraw)



proc plot_sp_pwr()
{
    Y = Pwr 

    Y += 1

    Y = Log(Y)

    SetGwob(gwo,@clearpixmap,@clipborder)

    DrawGline(vec_gl)

    Y2 = SP2_pwr

    Y2 += 1

    Y2 = Log(Y2)

    DrawGline(vec_sp2_gl)

    SetGwob(gwo,@showpixmap)


}



proc plot_lp_pwr()
{
    LY = Lpwr 

    LY += 1

    LY = Log(LY)

    SetGwob(lpwo,@clearpixmap,@clipborder)

    DrawGline(vec_lp_gl)

   SetGwob(lpwo,@showpixmap)

}

proc Update()
{
    setgwob(hwo,@value,Swp,@update)

//    wat = date(5)

    setgwob(two,@value,"$rad_date",@update)

    SetGwob(gwo,@border,@clipborder)

}

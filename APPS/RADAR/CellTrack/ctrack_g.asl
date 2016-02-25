



OpenDll("plot")
Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

so_far = getErrors()
<<"$so_far \n"

////////////////////////////////////  PLOT PROCS ////////////////////////////////


proc plot_db()
{

    SetGwob(gwo,@clearpixmap,@clipborder)

    DrawGline(vec_gl)

    DrawGline(vec_lr_gl)

    DrawGline(vec_sr_gl)

    SetGwob(gwo,@showpixmap)
//    Axtext(gwo,1,"DB",0.5,-1)
//    Axtext(gwo,3,"DB",0.7,1)

//     Text(gwo,"DB",0.6,-1,3)
}

//------------------------------------------------------------------------------\\

proc plot_dbz()
{

    SetGwob(dbzwo,@clearpixmap,@clipborder)

    DrawGline(vec_dbz_gl)
    DrawGline(vec_yrdbz_gl)
    DrawGline(vec_gdbz_gl)

    SetGwob(dbzwo,@showpixmap)
//    Axtext(dbzwo,1,"DBZ",0.5,-1,"red")
//    Axtext(dbzwo,3,"DBZ",0.7,1,"black")
//      Text(dbzwo,"DBZ",0.5,-1,3)

}

//------------------------------------------------------------------------------\\

proc plot_radial_gyr()
{
  for (i = 0 ; i < 512; i++) {

     // if above compute x,y pos -- 
         

  }
}

//------------------------------------------------------------------------------\\

proc new_sweep()
{

   setgwob(swpwo,@value,swp_cnt,@update)

}

proc set_range( rng)
{

      setgwob(radwo,@scales,-rng,0,rng ,rng)


}

//------------------------------------------------------------------------------\\

proc Update()
{
    setgwob(hwo,@value,fround(radbrg,2),@update)
    setgwob(relbwo,@value,fround(rel_brg,2),@update)
    setgwob(hdgwo,@value,"$(fround(hdg,2))",@update)
 //   setgwob(swpwo,@value,swp_cnt,@update)

//    wat = date(5)
    rad_date = "$msec"

    setgwob(two,@value,"$msec",@update)

    SetGwob(gwo,@border,@clipborder)
 // setgwob(monitors, @redraw)
}

//------------------------------------------------------------------------------\\





////////////////////// Window //////////////////
    vp = CreateGwindow(@title,"XYPLOT",@resize,0.01,0.01,0.99,0.99,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

///////////////////// Wob //////////////////////
    gwo=CreateGWOB(vp,@GRAPH,@resize,0.02,0.6,0.45,0.95,@name,"SP",@color,"blue")

    setgwob(gwo,@clip,0.1,0.2,0.9,0.9)
    setgwob(gwo,@scales,0,0,512 ,70, @save,@redraw,@drawon,@pixmapon)

    Axtext(gwo,1,"DB",350,1)

    axnum(gwo,1)
    axnum(gwo,2)
    setgwob(gwo,@drawoff,@pixmapon)
//////////////////// Gline //////////////////////

    vec_gl = CreateGline(@wid,gwo,@type,"Y",@yvec,DB,@color,"red")

    vec_lr_gl = CreateGline(@wid,gwo,@type,"Y",@yvec,DB_LR,@color,"green")

    vec_sr_gl = CreateGline(@wid,gwo,@type,"Y",@yvec,DB_SR,@color,"blue")

    SetGwob(gwo,@hue,"green",@refresh)

    SetGwob(gwo,@clearpixmap,@clipborder)


///////////////////// Wob //////////////////////

    dbzwo=CreateGWOB(vp,@GRAPH,@resize,0.02,0.2,0.45,0.55,@name,"DBZ",@color,"white")

    setgwob(dbzwo,@clip,0.1,0.2,0.9,0.9)
    setgwob(dbzwo,@scales,0,-20,512 ,70, @save,@redraw,@drawon,@pixmapon)
    SetGwob(dbzwo,@clearpixmap,@clipborder)

    Axtext(dbzwo,1,"DBZ",350,1.2)

    axnum(dbzwo,1)
    axnum(dbzwo,2)

    setgwob(dbzwo,@drawoff,@pixmapon)
//////////////////// Gline //////////////////////

    vec_dbz_gl = CreateGline(@wid,dbzwo,@type,"Y",@yvec,DBZ,@color,"blue")
    vec_yrdbz_gl = CreateGline(@wid,dbzwo,@type,"Y",@yvec,DBZ_SEG_YR,@color,"red")
    vec_gdbz_gl = CreateGline(@wid,dbzwo,@type,"Y",@yvec,DBZ_SEG_G,@color,"green")

    SetGwob(dbzwo,@hue,"green",@refresh)

    SetGwob(dbzwo,@clearpixmap,@border,@clipborder)
    Axtext(dbzwo,1,"DBZ",200,1)
    Axtext(dbzwo,3,"DBZ",300,1)

//////////////////////////////////////////////////////////////////////////////
    radwo=CreateGWOB(vp,@GRAPH,@resize,0.46,0.3,0.99,0.95,@name,"RADAR_SCREEN",@color,"white")

    setgwob(radwo,@clip,0.02,0.1,0.98,0.9)

    setgwob(radwo,@scales,-255,0,255 ,255, @save,@redraw,@drawon,@pixmapon)

    SetGwob(radwo,@clearpixmap,@border,@clipborder,@redraw)

/////////////////// status ////////////////////

 
  hwo=createGWOB(vp,"BV",@name,"RAD_BRG",@VALUE,"O",@color,"green",@resize,0.1,0.12,0.28,0.18)

  setgwob(hwo,@DRAWON,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(hwo,@bhue,"teal",@clipbhue,"magenta")
  


  hdgwo=createGWOB(vp,"BV",@name,"HDG",@VALUE,"O",@color,"green",@resize,0.1,0.08,0.28,0.12)

  setgwob(hdgwo,@DRAWON,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(hdgwo,@bhue,"teal",@clipbhue,"magenta")
  


  relbwo=createGWOB(vp,"BV",@name,"REL_BRG",@VALUE,"O",@color,"green",@resize,0.1,0.12,0.28,0.18)

  setgwob(relbwo,@DRAWON,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(relbwo,@bhue,"teal",@clipbhue,"green")
  

  swpwo=createGWOB(vp,"BV",@name,"SWEEP_CNT",@VALUE,"O",@color,"green",@resize,0.1,0.01,0.28,0.08)

  setgwob(swpwo,@DRAWON,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(swpwo,@bhue,"teal",@clipbhue,"magenta")
  

  int monitors[] = {relbwo,hdgwo,hwo, swpwo}

// <<"$monitors\n"


  wovtile(monitors, 0.72,0.02,0.85,0.2,0.01)

  setgwob(monitors, @redraw)

  two=createGWOB(vp,"BV",@name,"TIME",@VALUE,"O",@color,"green",@resize,0.3,0.1,0.6,0.14)

  setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVR")
  setgwob(two,@bhue,"teal",@clipbhue,"cyan")
  setgwob(two,@value,0,@redraw)



so_far_so_good = getErrors()
<<"%V$so_far_so_good \n"

/{
// not good seg faults
if ( so_far_so_good[0] > 1) {
<<" not so far so good $so_far_so_good\n"
a=i_read()
}
/}
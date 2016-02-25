//////////////////// DISPLAY /////////////////////////////
////////////////////////////// GLINE ////////////////////////////////////////



proc  drawGoals(ws)
  {

   if (ws == 0) {
    PlotLine(gwo,sc_startday,165,sc_endday,165, "green")
    PlotLine(calwo,sc_startday,day_burn,sc_endday,day_burn, "green")
    PlotLine(calwo,sc_startday,out_cal,sc_endday,out_cal, "blue")
    PlotLine(calwo,sc_startday,in_cal,sc_endday,in_cal, "red")
   PlotLine(carbwo,0,30,sc_endday,30, "blue")
   PlotLine(carbwo,0,55,sc_endday,55, "red")
   }

  if (ws == 1) {
   PlotLine(swo,0,150,kdays-10,250, "blue")

   }


  }

proc  drawMonths(ws)
 {

   int sd
   int k
   int yd
   int wd
   int wm

   sd = julday("01/01/2011")

   int wwo = gwo

   float lty = 0

   if (ws == 1) {
       wwo = swo
   }

   for (k = 0; k < 12 ; k++) {
 
    wm = k + 1
 
   the_date = "$wm/01/2011"

   yd = julday(the_date) 

 //   wd = julday("$wm/01/2011") -sd

    wd = yd - sd

//<<"PMonths $Mo[k] $wm $wd $sd $yd $the_date\n"

    //Text(gwo,Mo[k], wd,150)

    fwd = wd/360.0

    AxText(wwo, 1, Mo[k], wd, 2, BLACK)

   }


 }


proc  drawGrids( ws )
{
// <<" $ws \n"

 if (ws == 0) {

 //<<"drawing Grids for screen 0 \n"

  //SetGwob(extwo,@axnum,1,0,kdays,7,1)

  //SetGwob(gwo,@axnum,2,155,205,10,5)

  axnum(gwo,2)

  SetGwob(gwo,@axnum,4)
  //SetGwob(gwo,@axnum,1)

  //SetGwob(calwo,@axnum,2,500,5500,500,100)
  SetGwob(calwo,@axnum,2)
  SetGwob(extwo,@axnum,2)

  //SetGwob(extwo,@axnum,2,0,sc_endday,20,10)

  Text(gwo,"Weight lbs",-4,0.7,4,-90)
  Text(extwo,"Exercise mins",-4,0.7,4,-90)
  Text(calwo,"Cals In/Out",-4,0.7,4,-90)


 }
 else {

  axnum(swo,2)

  //SetGwob(swo,@axnum,2,150,bp_upper,50,10)
  //SetGwob(carbwo,@axnum,2,0,carb_upper,50,10)

  SetGwob(carbwo,@axnum,2)
  SetGwob(xwo,@clipborder,@save,@store)

 }
//  SetGwob(allwo,@showpixmap,@save,@store)

  SetGwob(allwo,@clipborder)


}


proc drawScreens()
{
 
      if ( wScreen == 0) {

       SetGwob(wedwo,@clearclip,@save,@clearpixmap,@store,@clipborder)
       SetGwob(extwo,@clipborder,@save,@store)
  
      //DrawGline(wedgl)
     

      DrawGline(ext_gl)
      DrawGline(gw_gl)
      DrawGline(pwt_gl)
      DrawGline(wt_gl)
      DrawGline(calc_gl)
      DrawGline(calb_gl)
      DrawGline(carb_gl)


      drawGoals(0)
      drawGrids(0) 
      drawMonths(0)

      setgwob(wedwo,@showpixmap)
      SetGwob(allwo,@clipborder,"black")

      drawMonths(0)

      Text(carbwo,"Carbs", 0.8,0.8,1)
   


       Text(calwo,"Calories", 0.8,0.8,1)

       Text(extwo,"ExerciseTime", 0.8,0.8,1)

  setgwob(gwo,@showpixmap)

     }

      if ( wScreen == 1) {

//<<" drawscreen 1 \n"

 
      drawGoals(1)
      drawGrids(1)
      drawMonths(1)
      DrawGline(xedgl)
      DrawGline(bp_gl)
      setgwob(swo,@showpixmap)
       SetGwob(allwo,@clipborder)
//      SetGwob(swo,@clipborder,"green")
      }

}


////////////////////////////////////////


Graphic = CheckGwm()
<<"%V$Graphic \n"

     if (!Graphic) {
        X=spawngwm()
     }


/////////////////////////////  SCREEN --- WINDOW ////////////////////////////////////////////////////////////

    vp = CreateGwindow(@title,"WED",@resize,0.01,0.01,0.99,0.99,0)
    vp1 = CreateGwindow(@title,"XED",@resize,0.01,0.01,0.99,0.99,1)

    int allwin[] = {vp,vp1}

    SetGwindow(allwin,@drawon,@pixmapoff,@save,@bhue,"white")


/////////////////////////////  WOBS /////////////////////////////////////////////////////////////////////
    sc_startday = 80
    sc_endday = 180


    gwo=createGWOB(vp,@GRAPH,@name,"WTLB",@clipborder,"black")

    calwo=createGWOB(vp,@GRAPH,@name,"CAL",@clipborder,"black")

    extwo=createGWOB(vp,@GRAPH,@name,"EXT",@clipborder,"black")

    carbwo=createGWOB(vp,@GRAPH,@name,"CARB_COUNT",@color,"white")

    int wedwo[] = { gwo, extwo, calwo, carbwo }

<<"%V$wedwo \n"

    // vtile before set clip!

    wo_vtile(wedwo,0.03,0.05,0.97,0.97,0.02)   // vertically tile the drawing areas into the main window

    cx = 0.08 ;    cX = 0.95 ; cy = 0.2 ; cY = 0.97


    setgwob(wedwo,@clip,cx,cy,cX,cY, @color,"white")

    setgwob(wedwo,@border,@clipborder)

    setgwob(gwo,@scales,sc_startday,150,sc_endday+10,220) 

    setgwob(extwo,@scales,sc_startday,0,sc_endday+10,260) 

    setgwob(calwo,@scales,sc_startday,0,sc_endday+10,4500)

    setgwob(carbwo,@scales,sc_startday,0,sc_endday+10,1200)

//    SetGwob(extwo,@axnum,1,sc_startday,sc_endday,7,1)

    SetGwob(extwo,@axnum,1)


    swo=createGWOB(vp1,@GRAPH,@name,"BenchPress",@color,"white")
    
    int xwo[] = { swo }

    wo_vtile(xwo,0.01,0.05,0.97,0.97)   // vertically tile the drawing areas into the main window


    setgwob(xwo,@clip,cx,cy,cX,cY,@color,"white", @clipborder,"black")




//<<" $DVEC[0:10] \n"

//<<" %5\s\nR$WTVEC \n"

//<<" %5\s->\s,\s<-\nR$CARBV \n"

//<<" %10\s\nr$WTPMV \n"


//////////////////////////// SCALES //////////////////////////////////////////
<<" Days $k \n"

    bp_upper = 400
    carb_upper = 400
 
   //  defaults are ?  @save,@redraw,@drawon,@pixmapon

    setgwob(swo,@scales,sc_startday,110,sc_endday+10,bp_upper)

    setgwob(carbwo,@scales,sc_startday,0,sc_endday+10,carb_upper)


    int allwo[] = {gwo,swo,carbwo,calwo,extwo}

<<"%V $allwo \n"

    setgwob(allwo,@save,@redraw,@drawon,@pixmapon)




//////////////////////////// GLINES & SYMBOLS //////////////////////////////////////////
 ext_gl  = CreateGline(@wid,extwo,@type,"XY",@xvec,DVEC,@yvec,EXTV,@color,"blue",@ltype,"symbols","diamond",@symsize,0.75,@symhue,GREEN)
 wt_gl   = CreateGline(@wid,gwo,@type,"XY",@xvec,DVEC,@yvec,WTVEC,@color,"red",@ltype,"symbols","diamond",@symsize,0.75,@symhue,RED)

 pwt_gl  = CreateGline(@wid,gwo,@type,"XY",@xvec,DVEC,@yvec,PWTVEC,@color,"orange",@ltype,"line")
 wtpm_gl = CreateGline(@wid,gwo,@type,"XY",@xvec,DVEC,@yvec,WTPMV,@color,"blue",@ltype,"symbol")
 gw_gl   = CreateGline(@wid,gwo,@type,"XY",@xvec,WDVEC,@yvec,GVEC,@color,"blue")
 bp_gl   = CreateGline(@wid,swo,@type,"XY",@xvec,DVEC,@yvec,BPVEC,@color,"green",@ltype,"symbols")
 carb_gl = CreateGline(@wid,carbwo,@type,"XY",@xvec,DVEC,@yvec,CARBV,@color,"brown",@ltype,"symbols","diamond",@symhue,"brown")
 calb_gl = CreateGline(@wid,calwo,@type,"XY",@xvec,DVEC,@yvec,CALBURN,@color,"blue",@ltype,"symbols","diamond")
// calc_gl = CreateGline(@wid,calwo,@type,"XY",@xvec,DVEC,@yvec,CALCON,@color,"red",@ltype,"symbols","triangle",@symsize,2.0,@symhue,BLUE)
 calc_gl = CreateGline(@wid,calwo,@type,"XY",@xvec,DVEC,@yvec,CALCON,@color,"red",@ltype,"symbols","triangle",@symhue,BLUE)

 se_gl   = CreateGline(@wid,extwo,@type,"XY",@xvec,DVEC,@yvec,SEVEC,@color,"green",@ltype,"symbols","diamond")

  
  int allgl[] = {wtpm_gl,wt_gl,gw_gl,bp_gl,carb_gl,ext_gl,se_gl,calb_gl, calc_gl, pwt_gl}

  int wedgl[] = {wtpm_gl,wt_gl,gw_gl, ext_gl, calb_gl, se_gl, calc_gl, pwt_gl}

  int xedgl[] = {carb_gl,bp_gl}

  SetGline(allgl,@missing,0,@symbol,"diamond",5)

  SetGline(ext_gl,@symbol,"diamond",10, @fill_symbol,1)
  SetGline(wt_gl,@symbol,"triangle",10, @fill_symbol,1)
  SetGline(se_gl,@symbol,"diamond",10)
  SetGline(carb_gl,@symbol,"triangle",10,@fill_symbol,1)
  SetGline(calb_gl,@symbol,"diamond",10,@fill_symbol,1)
  SetGline(calc_gl,@symbol,"triangle",@symsize,7,@symhue,BLUE)
  SetGline(bp_gl,@symbol,"inverted_triangle",5)


  SetGwob(gwo,@hue,"green")


////////////////////////////////////// PLOT  ////////////////////////////////////////////

<<" $allgl \n"

//  DrawGline(wt_gl)
//  DrawGline(ext_gl)
//  DrawGline(allgl)


  setgwob(gwo,@showpixmap,@save)
  setgwob(calwo,@showpixmap)
  setgwob(carbwo,@showpixmap)





//////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//
//  Test of readchannel and plot via gline
//
////////////////////////////////////////////////////////////
OpenDll("plot","stat")

Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

setDebug(1)

fname = _clarg[1]

chn = atoi(_clarg[2])


<<"%V$fname $chn \n"

////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////

    str vptitle = "WAVES"

// main window on screen
//
//    CreateGwindow      cWi

    vp = cWi(@title,"ChannelPlot",@resize,0.1,0.1,0.90,0.90,0)

    // setGwindow     sWi
    sWi(vp,@pixmapon,@drawooff,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily


    gwo= cWo(vp,@GRAPH,@resize,0.05,0.1,0.99,0.95,@name,"GL",@color,"white")

    sWo(gwo,@clip,cx,cy,cX,cY)
    
    // scales 
    sx = 0.0
    sX = 10.0
    sy = 0.0
    sY = 200.0
    // units  - radians
<<"$sx $sX $sy $sY \n"

float YC[];





   YC= readChannel(fname,chn)

<<"%(5,, ,\n)$YC\n"
   start = 0.0;
   fs = getChannelPara(fname,"FS",1)
   nvals = getChannelPara(fname,"NOB",1)
   stp = getChannelPara(fname,"STP",1)
   
<<"%V$fs $stp\n"

  chn_gl = cGl(gwo,@TY,YC,@XI,fs,@XO,start,@color,BLUE_)
 // chn_gl = cGl(gwo,@TY,YC,@color,RED_)

  pnvals = 1000;

  sWo(gwo,@ClearPixMap,@clearclip,@scales,5,0,stp-5,300,@savescales,0,@usescales,0);
 // sGl(chn_gl,@scales,0,0,pnvals,300,@ltype,1, @symbol,"diamond")
  sGl(chn_gl,@ltype,"solid", @symbol,"diamond")
  sWo(gwo,@axnum,1)

  drawGline(chn_gl)


   iread()


  sWo(gwo,@ClearPixMap,@clear,@clearclip,@scales,15,0,20,300,@savescales,0,@usescales,0);
  sGl(chn_gl,@color,RED_,@ltype,"solid", @symbol,"diamond")
  sWo(gwo,@axnum,1)

  drawGline(chn_gl)

   iread()


  sWo(gwo,@ClearPixMap,@clear,@clearclip,@scales,25,0,30,300,@savescales,0,@usescales,0);
  sGl(chn_gl,@ltype,"symbol","diamond",@color,GREEN_)
  sWo(gwo,@axnum,1,@axnum,2)

  drawGline(chn_gl)

   iread()

   exitgs()
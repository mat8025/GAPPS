

///////////////////////////////// WINDOW - GRAPH SETUP ////////////////////////////////////////////////


  ssw = CreateGwindow(@title,"TA_and_Spec",@resize,0.02,0.02,0.99,0.99,0)   // Main Window
  sWi(ssw,@bhue,"skyblue")
  // whole signal
  wox = 0.01
  woX = 0.98

  ts = ds / Freq
  
  voxwo=CreateGwob(ssw,"GRAPH",@resize,wox,0.85,woX,0.98)

  sWo(voxwo,@name,"Vox",@clip,0.01,0.01,0.99,0.99, @pixmapon, @drawon,@save,@border, @clipborder,"red",@penhue,"green")
  sWo(voxwo,@scales,0,mm[0],ts,mm[1])
  setgwob(voxwo,@help," audio signal in buffer ")

  RP = wogetrscales(voxwo)

   <<"%V%6.2f$RP\n"

  //

  taswo=CreateGwob(ssw,"GRAPH",@resize,wox,0.70,woX,0.84)
  sWo(taswo,@name,"TA",@clip,0.01,0.15,0.99,0.99, @pixmapon, @drawon,@save,@border, @clipborder,"green",@penhue,"pink")
  sWo(taswo,@scales,0,mm[0],ts/2,mm[1])
  setgwob(taswo,@help," selected section of audio signal ")

<<"%V$taswo \n"

  // spectograph window 
  sgwo=CreateGwob(ssw,"GRAPH",@resize,wox,0.5,woX,0.68)
  sWo(sgwo,@penhue,"green",@name,"SG",@pixmapon,@drawon,@save)
  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @border, @clipborder,"red")
  sWo(sgwo,@scales,0,0,npts,120)
  setgwob(sgwo,@help," spectrograph ")

<<"%V$sgwo \n"

  cosg_gl  = CreateGline(@wid,sgwo,@type,"CURSOR",@color,"red") 


  // slice windows
  spwo=CreateGwob(ssw,"GRAPH",@resize,0.05,0.15,0.45,0.48)
  setgwob(spwo,@scales,0,-20,1024,90)
  //sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawon,@save)
  sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawoff,@save)
  sWo(spwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  setgwob(spwo,@help," spectral_slice ")

<<"%V$spwo \n"


  tawo=CreateGwob(ssw,"GRAPH",@resize,0.5,0.15,0.95,0.48)
  setgwob(tawo,@scales,0,mm[0],1024,mm[1])
  sWo(tawo,@penhue,"blue",@name,"timeamp",@pixmapon,@drawoff,@save)
  sWo(tawo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  setgwob(tawo,@help," time signal for spectral slice ")

<<"%V$tawo \n"


//  co_gl  =  CreateGline(@wid,voxwo,@type,"CURSOR",@color,"red")  // start time
  co_gl  =  cGl(voxwo,@type,"CURSOR",@color,"red")  // start time
  co1_gl  = CreateGline(voxwo,@type,"CURSOR",@color,"blue") // finish time


  cop_gl  = CreateGline(voxwo,@type,"CURSOR",@color,"orange") // compute frame time

<<"%V $co_gl $co1_gl \n"

  co2_gl = CreateGline(taswo,@type,"CURSOR",@color,"red")
  co3_gl = CreateGline(taswo,@type,"CURSOR",@color,"blue")



  // Buttons for AUDIO ops

 bx = 0.2
 by = 0.1
 bX = 0.3
 bY = 0.14
 bwidth = 0.1
 bpad = 0.01

 //qwo=createGWOB(ssw,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,bx,by,bX,bY)
 qwo=createGWOB(ssw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"orange")
 setgwob(qwo,@help," click to quit")
 setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

 bx = bX + bpad
 bX = bx + bwidth

 playsr_wo=createGWOB(ssw,"BN",@name,"PLAY_SR",@VALUE,"ON",@color,"skyblue")
 setgwob(playsr_wo,@help," click to play selected region")
 setgwob(playsr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 bx = bX + bpad
 bX = bx + bwidth

 playbc_wo=createGWOB(ssw,"BN",@name,"PLAY_BC",@VALUE,"ON",@color,"magenta")
 setgwob(playbc_wo,@help," click to play between cursors")
 setgwob(playbc_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)


 slicesr_wo=createGWOB(ssw,"BN",@name,"SLICE_SR",@VALUE,"ON",@color,"green")
 setgwob(slicesr_wo,@help," click to show spec slice for region")
 setgwob(slicesr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 selectsr_wo=createGWOB(ssw,"BN",@name,"SELECT_SR",@VALUE,"ON",@color,"teal")
 setgwob(selectsr_wo,@help," click to activate selected region")
 setgwob(selectsr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

 res_wo=createGWOB(ssw,"BS",@name,"RESOL",@VALUE,"ON",@color,"lime")
 setgwob(res_wo,@help," frame resolution ")
 setGWOB(res_wo,@STYLE,"SVR",@CSV,"low,med,high,fine")
 setgwob(res_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)


 int butawo[] = { playsr_wo, playbc_wo, slicesr_wo, selectsr_wo, res_wo, qwo }

// do a htile
    wohtile(butawo, 0.2, by, 0.9, bY, 1, 0.1)
    setgwob(butawo,@redraw)

  //  text/command wo

  commwo=CreateGwob(ssw,"GRAPH",@resize,0.1,0.02,0.95,0.09)
  sWo(commwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  sWo(commwo,@penhue,"black",@name,"comms",@pixmapon,@drawon,@save)

  setgwob(commwo,@clear,@clipborder,@textr,"ta_spec",0.1,0.5)


  setGwindow(ssw,@redraw)

////////////////////////////////////////////
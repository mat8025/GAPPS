

///////////////////////////////// WINDOW - GRAPH SETUP FOR SEESPEC //////////////
int commwo = -1;

float y0 = -20000;
float y1 = 20000;
float mm[];
float vox_tX = 30.0;
  
  int sigwos[];
  int nsigwo = 0;

  ssw = cWi(@title,"SeeSpec_$version",@resize,0.02,0.02,0.99,0.99,0);
  sWi(ssw,@bhue,"skyblue")
  // whole signal
  wox = 0.01
  woX = 0.98

  sigwos[nsigwo++] = ssw;
  //ts = ds / Freq
  
  voxwo=cWo(ssw,"GRAPH",@resize,wox,0.85,woX,0.98)
  sWo(voxwo,@name,"Vox",@clip,0.01,0.01,0.99,0.99, @pixmapon, @drawon,@save,@border, @clipborder,"red",@penhue,"green")
  
  sWo(voxwo,@scales,0,y0,10.0,y1)

  sigwos[nsigwo++] = voxwo;

  //sWo(voxwo,@help," audio signal in buffer ")
  RP = wogetrscales(voxwo)

   //<<"%V%6.2f$RP\n"

  
  taswo=cWo(ssw,"GRAPH",@resize,wox,0.70,woX,0.84)
  sWo(taswo,@name,"TA",@clip,0.01,0.15,0.99,0.99, @pixmapoff, @drawon,@save,@border, @clipborder,"green",@penhue,"pink")
  sWo(taswo,@scales,0,y0,10,y1)

  sigwos[nsigwo++] = taswo;

  // spectograph wob
  sgwo=cWo(ssw,"GRAPH",@resize,wox,0.55,woX,0.68)
  sWo(sgwo,@penhue,"green",@name,"SG",@pixmapon,@drawon,@save)
  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @border, @clipborder,"red")
  sWo(sgwo,@scales,0,0,npts,120)
  sWo(sgwo,@help," spectrograph ")

  sigwos[nsigwo++] = sgwo;


  // raw speech features
  fewo=cWo(ssw,GRAPH_,@resize,wox,0.46,woX,0.54,@scales,0,-0.1,50,10.1)
  sWo(fewo,@hue,RED_,@name,"rmswave",@redraw,@save,@drawoff,@pixmapon,@savepixmap)
  sWo(fewo,@clip,0.01,0.01,0.99,0.99, @clipborder,GREEN_)


  sigwos[nsigwo++] = fewo;


  cosg_gl  = cGl(sgwo,@type,"CURSOR",@color,RED_,@ltype,"cursor")

  // slice windows
  spwo=CWo(ssw,"GRAPH",@resize,0.5,0.15,0.95,0.45)
  sWo(spwo,@scales,0,-20,8000,90)
  //sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawon,@save)
  sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawon,@save)
  sWo(spwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  //sWo(spwo,@help," spectral_slice ")

  sigwos[nsigwo++] = spwo;

  tawo=CWo(ssw,"GRAPH",@resize,0.05,0.15,0.45,0.45)
  sWo(tawo,@scales,0,y0,FFTSZ,y1)
  sWo(tawo,@penhue,"blue",@name,"timeamp",@pixmapon,@drawon,@save)
  sWo(tawo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  //sWo(tawo,@help," time signal for spectral slice ")

  sigwos[nsigwo++] = tawo;

  co_gl  = cGl(voxwo,@type,"CURSOR",@color,"red")  // start time
  co1_gl  = cGl(voxwo,@type,"CURSOR",@color,"blue") // finish time


  cop_gl  = cGl(@wid,voxwo,@type,"CURSOR",@color,"orange") // compute frame time

//<<"%V $co_gl $co1_gl \n"
  co2_gl = cGl(voxwo,@type,"CURSOR",@color,"red")
  co3_gl = cGl(voxwo,@type,"CURSOR",@color,"blue")


  /// Buttons for AUDIO ops

 qwo=cWo(ssw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,ORANGE_,@help," quit application!")
 
 playsr_wo=cWo(ssw,"BN",@name,"PLAY_SR",@VALUE,"ON",@color,"skyblue",@help," Play selected region")

 playbc_wo=cWo(ssw,"BN",@name,"PLAY_BC",@VALUE,"ON",@color,"magenta",@help," Play section between cursors")

 slicesr_wo=cWo(ssw,"BN",@name,"SLICE_SR",@VALUE,"ON",@color,GREEN_, " Show spec slice for region")
 
 selectsr_wo=cWo(ssw,"BN",@name,"SELECT_SR",@VALUE,"ON",@color,"teal",@help," Process selected region")
  
 //res_wo=cWo(ssw,"BS",@name,"RESOL",@VALUE,"ON",@color,"lime", @help," frame resolution ")
 //        sWo(res_wo,@STYLE,"SVR",@CSV,"low,med,high")

 record_wo=cWo(ssw,"BN",@name,"RECORD_SR",@VALUE,"ON",@color,"teal",@help," record into selected region")

 read_wo=cWo(ssw,"BN",@name,"READ FILE",@VALUE,"ON",@color,"teal",@help," read a vox file")

 write_wo=cWo(ssw,"BN",@name,"WRITE FILE",@VALUE,"ON",@color,"blue",@help," write a vox file")

 int butawo[] = { read_wo, playsr_wo, playbc_wo, slicesr_wo, selectsr_wo, write_wo, record_wo, qwo }

 wohtile(butawo, 0.2, 0.1, 0.9, 0.14)
 sWo(butawo,@border,@drawon,@clipborder,@fonthue,BLACK_,@redraw)


///  text/command  area /////////

  commwo=cWo(ssw,"GRAPH",@resize,0.1,0.02,0.95,0.09)
  sWo(commwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  sWo(commwo,@penhue,BLACK_,@name,"comms",@pixmapon,@drawon,@save)
  sWo(commwo,@clear,@clipborder,@textr,"ta_spec",0.1,0.5)


////////////////////////////////// GLINES for FEATURE TRACKS ///////////////////////////////////////

// RMS
 rmsgl = cGl(fewo,@TY,RmsTrk,@color,RED_,@name,"RMS")

 sGl(rmsgl,@scales,0,0,200,30,@ltype,1, @symbol,"diamond",@savescales,0,@usescales,0)

 zxgl = cGl(fewo,@TY,ZxTrk,@color,BLUE_,"name","ZX")

 sGl(zxgl,@scales,0,0,200,1.0,@ltype,1, @symbol,"diamond",@savescales,1,@usescales,1)
//





  setGwindow(ssw,@redraw)
  gflush()
  gsync()
  sleep(1)





// wait till XGS responds ??

///

proc displayComment ( cmsg) 
{
    <<" $cmsg "
    if (commwo != -1) {
      sWo(commwo,@clear,@clipborder,@textr,cmsg,0.1,0.5)
    }
}
//=======================================

proc getNpixs()
{
   SGCL = wogetclip(sgwo)

   nxpixs = SGCL[3] -  SGCL[1]
   nypixs = SGCL[4] -  SGCL[2]

<<"%V$SGCL \n"

   CL = wogetclip(taswo)

<<"%V$CL \n"

    nf = npts/ wshift

    nxpts = nxpixs  *  wshift

<<"%V$nxpixs $nypixs $nf\n"
<<"%V $npts $nxpts \n"

   bufend = nxpts - FFTSZ
   return nxpixs
}
//-----------------------------



int ncb = 90

uchar pixstrip[2][ncb]

////////////////////////////////////////// GREY SCALE ////////////////////////////////////////////////
 ng = 128
 Gindex = 150  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng


 SetGSmap(ng,Gindex)  // grey scale  



//////////////////////////////////////////////////////////////////
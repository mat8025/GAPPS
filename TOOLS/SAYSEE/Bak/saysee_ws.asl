
///////////////////////////////////  WINDOW SETUP   ///////////////////////////////////////////

 Vamp = 5000

     <<" create TAW \n"

 tassw = cWi(@title,"TimeAmp",@scales,0,-Vamp,256,Vamp,@savescales,0)


 allwins[nw++] = tassw

 SetGwindow(tassw,@resize,0.1,0.1,0.6,0.48,0)
 SetGwindow(@pixmapon,"drawoff",@hue,"blue",@clip,0.01,0.01,0.99,0.99)
 setgw("clear","redraw","save")

<<"%V$tw $nw $allwins \n"


     <<" create SGW \n"
 sgw = cWi(@title,"SG",@scales,0,0,800,140,@savescales,0)
 SetGwindow(@resize,0.1,0.50,0.65,0.95,0)
 SetGwindow(@pixmapon,@drawoff,@clear,@redraw,@save)


 allwins[nw++] = sgw

<<"%V $sgw $nw $allwins \n"

     wo_wd = 0.2
     wox = 0.1
     woX = wox + wo_wd/3

     woy = 0.1
     woY = 0.9

  Prop("Window Objects")

  sgtogwo=cWo(sgw,"TB_BUTTON",@resize,0.02,woy,0.07,woY)

  sWo(sgtogwo,@name,"SG",@color,"blue",@penhue,"red",@symbol,"triangle")

  sWo(sgtogwo,@help,"toggle SG display",@redraw,@drawon)

  sgwo=cWo(sgw,"GRAPH",@resize,0.05,0.35,0.95,0.70)
  sWo(sgwo,@scales,0,-Vamp,1024,Vamp)


  sWo(sgwo,@hue,"black",@name,"sgraph",@pixmapon,@drawoff,@redraw,@save)

  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")


  fewo=cWo(sgw,"GRAPH",@resize,0.05,0.05,0.95,0.33,@scales,0,-0.1,700,1.1)
 
  sWo(fewo,@hue,"red",@name,"rmswave",@redraw,"save",@drawoff,@pixmapon)
  sWo(fewo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")



  tawo=cWo(sgw,"GRAPH",@resize,0.05,0.71,0.95,0.99,@scales,0,-Vamp,1024,Vamp)
  sWo(tawo,@hue,"black",@name,"tawave",@drawoff,@redraw,@save)
  sWo(tawo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")


  msg_wo=cWo(tassw,"TB_BUTTON",@resize,0.97,0.1,0.99,0.25,@name,"MSG",@color,"blue",@penhue,"red","symbol","triangle")

//rms_wo=cWo(tassw,"BUTTON_SYM",@resize,0.1,0.1,0.13,0.25,@name,"RMS",@color,"blue",@penhue,"red","symbol","triangle")

  sWo(msg_wo,@help,"msg value","drawon","pixmapoff",@redraw, @style, "SVO")


  tt_wo=cWo(tassw,"BV",@resize,0.86,0.91,0.99,0.99,@name,"TT",@color,"white",@penhue,"red","value",0)
  sWo(tt_wo,@help,"total time","drawon",@redraw,@style, "SVO")

  rt_wo=cWo(tassw,"BV",@resize,0.75,0.91,0.85,0.99,@name,"RecordT",@color,"blue",@penhue,"black","value",0)
  sWo(rt_wo,@help,"rec time","drawon","pixmapoff",@redraw, @style, "SVO")

  st_wo=cWo(tassw,"BV",@resize,0.65,0.91,0.73,0.99,@name,"Power",@color,"blue",@penhue,"black","value",0)
  sWo(st_wo,@help,"power","drawon","pixmapoff",@redraw, @style, "SVO")

     wox = woX + 0.05
     woX = wox + wo_wd/3



  tagwo=cWo(tassw,"GRAPH",@resize,0.05,0.05,0.54,0.90)
  sWo(tagwo,"hue","blue",@name,"tawave",@redraw,"save","drawoff","pixmapon")
  sWo(tagwo,@clip,0.01,0.01,0.99,0.99, "clipborder","black")
  sWo(tagwo,@scales,0,-Vamp,1024,Vamp)




  TF_wo=cWo(tassw,"TB_BUTTON",@resize,0.8,woy,0.87,woY,@name,"TF",@color,"blue","symbol","triangle")
  sWo(TF_wo,@help,"toggle FIR convolve",@redraw,"pixmapon")

  TA_wo=cWo(tassw,"TB_BUTTON",@resize,0.75,woy,0.79,woY,@name,"TA",@color,"yellow","symbol","triangle")
  sWo(TA_wo,@help,"toggle TA display",@redraw)



  specwo=cWo(tassw,"GRAPH",@resize,0.55,0.05,0.95,0.90)
  sWo(specwo,"hue","red",@name,"specslice",@redraw,"save","pixmapon")
  sWo(specwo,@clip,0.01,0.01,0.99,0.99, "clipborder","black")
  sWo(specwo,@scales,0,-20,128,140)

     wox = woX + 0.05
     woX = wox + wo_wd/2

  FREQ_wo=cWo(tassw,"TB_MENU",@resize,0.1,woy,0.2,woY,  @color,"yellow", @style, "SVO", "drawon")
  sWo(FREQ_wo,@help,"Set Freq",@name,"Freq",@penhue,"black", @func, "wo_menu", @menu,"8000,12000,16000", "value", "12000")

  smw_wo=cWo(tassw,"TB_MENU",@resize,0.21,woy,0.32,woY,@name,"SMW", @color,"yellow", @style, "SVO", @drawon)

  sWo(smw_wo,@penhue,"black",@help,"smoothing window type",@func,"wo_menu",@menu,"Hanning,Kaiser,Hamming", @value, "Hanning",  @redraw)

     wox = woX + 0.05
     woX = wox + wo_wd



  CU_wo=cWo(tassw,"TB_BUTTON",@resize,0.02,woy,0.08,woY,@name,"CU",@color,"white",@penhue,"black","symbol","triangle")

  sWo(CU_wo,@help,"toggle TA display",@redraw)

  SS_wo=cWo(sgw,"TB_BUTTON",@resize,0.02,woy,0.07,woY,@name,"SS",@color,"yellow",@penhue,"black",@symbol,"triangle")

  sWo(SS_wo,@help,"toggle SS display",@redraw)

  <<" $allwins[*] \n"

  SetGwindow(allwins,"woredrawall")



//////////////////////////////////////////////////////////////////////////////////////
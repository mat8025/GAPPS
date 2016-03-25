///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////  WINDOW SETUP   ///////////////////////////////////////////

 int nw = 0
 int allwins[]
 int nwo = 0;
 int ncwo =0;
 int allwos[]
 int cntrlwos[]

 Vamp = 32000


<<" create TAW \n"

// setdebug(1,"pline")
 tassw = cWi(@title,"TimeAmp",@scales,0,-Vamp,256,Vamp,@savescales,0)


 allwins[nw++] = tassw

 sWi(tassw,@resize,0.1,0.05,0.8,0.49,0)
 sWi(tassw,@pixmapon,@drawoff,@hue,BLUE_,@clip,0.01,0.01,0.99,0.99)
 sWi(tassw,@clear,@redraw,@save,@savepixmap)

<<"%V$tw $nw $allwins \n"
<<" create SGW \n"


 sgw = cWi(@title,"SG",@scales,0,0,800,140,@savescales,0)
 sWi(sgw,@resize,0.1,0.50,0.8,0.95,0)
 sWi(sgw,@pixmapon,@drawoff,@clear,@redraw,@save,@savepixmap)
 allwins[nw++] = sgw

 cntrlw = cWi(@title,"SaySee_Control_$version")
 sWi(cntrlw,@resize,0.82,0.10,0.98,0.95,0)
 sWi(cntrlw,@pixmapon,@drawoff,@clear,@redraw,@save,@savepixmap)

 allwins[nw++] = cntrlw

<<"%V $tassw $sgw $nw $allwins \n"

     wo_wd = 0.2
     wox = 0.1
     woX = wox + wo_wd/3

     woy = 0.1
     woY = 0.9

  Prop("Window Objects")

  sgtogwo=cWo(sgw,TB_BUTTON_,@resize,0.02,woy,0.07,woY)
  sWo(sgtogwo,@name,"SG",@color,BLUE_,@penhue,RED_,@symbol,TRIANGLE_)
  sWo(sgtogwo,@help,"toggle SG display",@redraw,@drawon)

 allwos[nwo] = sgtogwo

<<"%V $nwo $sgtogwo  $allwos \n"
//iread()
 nwo = -1;
 allwos[nwo++] = sgtogwo
<<"%V $nwo $sgtogwo  $allwos \n"

//iread()

  sgwo=cWo(sgw,GRAPH_,@resize,0.05,0.35,0.95,0.70)
  sWo(sgwo,@scales,0,0,600,100)
  sWo(sgwo,@hue,BLACK_,@name,"sgraph",@pixmapon,@drawon ,@redraw,@save,@savepixmap)
  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @clipborder,RED_)

 allwos[nwo++] = sgwo

//allwos[nwo] = sgwo
 //nwo++;

<<"%V $nwo $sgwo  $allwos \n"




  fewo=cWo(sgw,GRAPH_,@resize,0.05,0.05,0.95,0.33,@scales,0,-0.1,50,10.1)
  sWo(fewo,@hue,RED_,@name,"rmswave",@redraw,@save,@drawoff,@pixmapon,@savepixmap)
  sWo(fewo,@clip,0.01,0.01,0.99,0.99, @clipborder,GREEN_)

 allwos[nwo++] = fewo

<<"%V $nwo $fewo  $allwos \n"

  tawo=cWo(sgw,GRAPH_,@resize,0.05,0.71,0.95,0.99,@scales,0,-Vamp,1024,Vamp)
  sWo(tawo,@hue,BLACK_,@name,"tawave",@drawoff,@redraw,@save,@savepixmap)
  sWo(tawo,@clip,0.01,0.01,0.99,0.99, @clipborder,BLACK_)

 allwos[nwo++] = tawo

<<"%V $nwo $tawo  $allwos \n"

  msg_wo=cWo(tassw,TB_BUTTON_,@resize,0.97,0.1,0.99,0.25,@name,"MSG",@color,BLUE_,@penhue,RED_,@symbol,TRIANGLE_)
  sWo(msg_wo,@help,"msg value",@drawon,@pixmapoff,@redraw, @style, "SVO")

 allwos[nwo++] = msg_wo
 <<"%V $nwo $msgwo  $allwos \n"



  rms_wo=cWo(tassw,BSYM_,@resize,0.1,0.1,0.13,0.25,@name,"RMS",@color,BLUE_,@penhue,RED_,@symbol,TRIANGLE_)

 allwos[nwo++] = rms_wo

<<"%V $nwo $rms_wo  $allwos \n"


tt_wo=cWo(tassw,BVALUE_,@resize,0.86,0.91,0.99,0.99,@name,"TT",@color,WHITE_,@penhue,RED_,"value",0)
  sWo(tt_wo,@help,"total time","drawon",@redraw,@style, "SVO")

 allwos[nwo++] = tt_wo
<<"%V $nwo $tt_wo  $allwos \n"



rt_wo=cWo(tassw,BVALUE_,@resize,0.75,0.91,0.85,0.99,@name,"RecordT",@color,BLUE_,@penhue,BLACK_,"value",0)
  sWo(rt_wo,@help,"rec time","drawon",@pixmapoff,@redraw, @style, "SVO")

 allwos[nwo++] = rt_wo
<<"%V $nwo $rt_wo  $allwos \n"


st_wo=cWo(tassw,BVALUE_,@resize,0.65,0.91,0.73,0.99,@name,"Power",@color,BLUE_,@penhue,BLACK_,"value",0)
  sWo(st_wo,@help,"power","drawon",@pixmapoff,@redraw, @style, "SVO")

 allwos[nwo++] = st_wo
<<"%V $nwo $st_wo  $allwos \n"

wox = woX + 0.05
     woX = wox + wo_wd/3



  tagwo=cWo(tassw,GRAPH_,@resize,0.05,0.05,0.54,0.90)
  sWo(tagwo,@hue,BLUE_,@name,"tawave",@redraw,@save ,@drawoff,@pixmapon,@savepixmap)
  sWo(tagwo,@clip,0.01,0.01,0.99,0.99, @clipborder,BLACK_)
  sWo(tagwo,@scales,0,-Vamp,1024,Vamp,@redraw,@save,@pixmapon,@savepixmap)

 allwos[nwo++] = tagwo

<<"%V $nwo $tag_wo  $allwos \n"


  TF_wo=cWo(tassw,TB_BUTTON_,@resize,0.8,woy,0.87,woY,@name,"TF",@color,BLUE_,@symbol,TRIANGLE_)
  sWo(TF_wo,@help,"toggle FIR convolve",@redraw,@pixmapon)

 allwos[nwo++] = TF_wo

<<"%V $nwo $TF_wo  $allwos \n"


  TA_wo=cWo(tassw,TB_BUTTON_,@resize,0.75,woy,0.79,woY,@name,"TA",@color,YELLOW_,@symbol,TRIANGLE_)
  sWo(TA_wo,@help,"toggle TA display",@redraw)

 allwos[nwo++] = TA_wo

<<"%V $nwo $TA_wo  $allwos \n"


  specwo=cWo(tassw,GRAPH_,@resize,0.55,0.05,0.95,0.90)
  sWo(specwo,@hue,RED_,@name,"specslice",@redraw,@save,@pixmapon,@savepixmap)
  sWo(specwo,@clip,0.01,0.01,0.99,0.99, @clipborder,BLACK_)
  sWo(specwo,@scales,0,-20,128,140,@redraw,@save,@pixmapon,@savepixmap)

 allwos[nwo++] = specwo

<<"%V $nwo $spec_wo  $allwos \n"


  wox = woX + 0.05
  woX = wox + wo_wd/2

  FREQ_wo=cWo(cntrlw,WOMENU_,@resize,0.1,0.8,0.2,0.9,  @color,YELLOW_, @style, "SVO", @drawon)
  
  sWo(FREQ_wo,@help,"Set Freq",@name,"Freq",@penhue,BLACK_, @func, "wo_menu", @menu,"8000,12000,16000", @value, "12000")


  allwos[nwo++] = FREQ_wo

<<"%V $nwo $FREQ_wo  $allwos \n"


  smw_wo=cWo(cntrlw,WOMENU_,@resize,0.3,0.8,0.42,0.9,@name,"SMW", @color,YELLOW_, @style, "SVO", @drawon)

  sWo(smw_wo,@penhue,BLACK_,@help,"smoothing window type",@func, "wo_menu", @menu,"Hanning,Kaiser,Hamming", @value, "Hanning")

  allwos[nwo++] = smw_wo

<<"%V $nwo $smw_wo  $allwos \n"



   wox = woX + 0.05
   woX = wox + wo_wd

  CU_wo=cWo(tassw,TB_BUTTON_,@resize,0.02,woy,0.08,woY,@name,"CU",@color,WHITE_,@penhue,BLACK_,@symbol,TRIANGLE_)

  sWo(CU_wo,@help,"toggle TA display",@redraw)


 allwos[nwo++] = CU_wo

<<"%V $nwo $CU_wo  $allwos \n"


  SS_wo=cWo(sgw,TB_BUTTON_,@resize,0.02,woy,0.07,woY,@name,"SS",@color,YELLOW_,@penhue,BLACK_,@symbol,TRIANGLE_)

  sWo(SS_wo,@help,"toggle SS display",@redraw)

  allwos[nwo++] = SS_wo


  qwo=cWo(cntrlw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,ORANGE_,@help," quit application!")

  allwos[nwo++] = qwo;

<<"%V $nwo $SS_wo  $allwos \n"



   int butawo[] = { FREQ_wo, smw_wo, qwo }

   wohtile(butawo, 0.2, 0.7, 0.9, 0.8)
   sWo(butawo,@border,@drawon,@clipborder,@fonthue,BLACK_,@redraw)

<<" $allwins[*] \n"

  sWi(allwins,@woredrawall)

  <<"Window Setup for saysee DONE\n"
  
<<" all_wos $nwo  $allwos \n"





//////////////////////////////////////////////////////////////////////////////////////
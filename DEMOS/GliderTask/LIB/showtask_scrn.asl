///
///  Screen setup for showtask
///



  Graphic = CheckGwm();

<<"%V $Graphic\n"



  if (!Graphic) {
    Xgm = spawnGwm("ShowTask")
  }

// create window and scales

#include "tbqrd"


  vp = cWi(@title,"vp",@resize,0.1,0.01,0.9,0.95,0)

  sWi(vp,@scales,-200,-200,200,200,0, @drawoff,@pixmapon,@save,@bhue,WHITE_);
  // but we don't draw to a window! = draw to Wob in a Window

  sWi(vp,@clip,0.01,0.1,0.95,0.99);

  titleButtonsQRD(vp);





  tdwo= cWo(vp, @BV,@resize_fr,0.01,0.01,0.14,0.1,@name,"TaskDistance")
  sWo(tdwo,@color,WHITE_,@style,"SVB");

  sawo= cWo(vp, @BV,@resize_fr,0.15,0.01,0.54,0.1,@name)

  sWo(sawo,@color,WHITE_,@style,"SVB");


  vvwo= cWo(vp, @GRAPH,@resize_fr,0.2,0.11,0.95,0.25,@name,"ALT",@color,WHITE_);


  

  sWo(vvwo, @scales, 0, 0, 100, 6000, @savepixmap, @redraw, @drawoff, @pixmapon);

  mapwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.26,0.95,0.95,@name,"MAP",@color,WHITE_);

<<"%V $mapwo \n"

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon,@savepixmap);


  int tpwo[>10];
  int ltpwo[>10];
  

  tpwo[0]=cWo(vp,@BV,@name,"_Start_",@style,"SVR",@drawon)

  tpwo[1] =cWo(vp,@BV,@name,"_TP1_",@style,"SVR",@drawon)

  tpwo[2] =cWo(vp,@BV,@name,"_TP2_",@style,"SVR", @drawon)

  tpwo[3] =cWo(vp,@BV,@name,"_TP3_",@style,"SVR", @drawon,@color,BLUE_,@fonthue,BLACK_)

  tpwo[4] =cWo(vp,@BV,@name,"_TP4_",@style,"SVR", @drawon,@color,BLUE_,@fonthue,BLACK_)

  tpwo[5] =cWo(vp,@BV,@name,"_TP5_",@style,"SVR", @drawon,@color,ORANGE_,@fonthue,BLACK_)

  tpwo[6] =cWo(vp,@BV,@name,"_TP6_",@style,"SVR", @drawon)

  tpwo[7] =cWo(vp,@BV,@name,"_TP7_",@style,"SVR", @drawon)

  tpwo[8] =cWo(vp,@BV,@name,"_TP8_",@style,"SVR", @drawon)

  tpwo[9] =cWo(vp,@BV,@name,"_TP9_",@style,"SVR", @drawon)

  finish_wo = tpwo[9]
  tpwos = tpwo[0:9];

  MaxSelTps = 10;
  
  <<"%V $tpwos\n"
  
  wovtile(tpwos, 0.02, 0.4, 0.15, 0.95)
  
  titleVers();
  gflush()
 sWo(tpwos,@color,ORANGE_,@fonthue,BLACK_,@font,F_TINY_,@redraw);

  TASK_wo=cWo(vp,@BV,@resize,0.05,0.25,0.15,0.34);
  
<<"%V$TASK_wo\n"

  sWo(TASK_wo, @help, "Set Task Type", @name, "TaskType", @func,  "wo_menu",  @menu, "SO,TRI,OAR,W,MT",  @value, "MT")


  TASK_menu_wo=cWo(vp,@BV,@resize,0.05,0.12,0.15,0.24);

  sWo(TASK_menu_wo, @help, "Set Task Type", @name, "TaskMenu")


  gflush()
  
  vptxt= cWo(vp, @TEXT,@resize_fr,0.55,0.01,0.95,0.1,@name,"TXT")
  sWo(vptxt,@color,WHITE_,@save,@drawon,@pixmapoff);
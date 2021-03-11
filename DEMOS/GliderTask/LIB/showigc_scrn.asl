
// create window and scale

  vp = cWi("title","vp","resize",0.1,0.01,0.9,0.95,0)

  sWi(vp,"scales",-200,-200,200,200,0, @drawoff,@pixmapon,@save,@bhue,WHITE_); // but we dont draw to a window!

  sWi(vp,"clip",0.01,0.1,0.95,0.99);

  vptxt= cWo(vp,@TEXT,@resize_fr,0.55,0.01,0.95,0.1,@name,"TXT",@color,WHITE_,@save,@drawon,@pixmapoff);

  tdwo= cWo(vp,@BV,@resize_fr,0.01,0.01,0.14,0.1,@name,"TaskDistance",@color,WHITE_,@style,"SVB");

  sawo= cWo(vp,@BV,@resize_fr,0.15,0.01,0.54,0.1,@name,"SafetyAlt",@color,WHITE_,@style,"SVB");

  vvwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.11,0.95,0.25,@name,"MAP",@color,WHITE_);

  sWo(vvwo, @scales, 0, 0, 86400, 8000, @save, @redraw, @drawon, @pixmapon);

  mapwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.26,0.95,0.95,@name,"MAP",@color,WHITE_);

<<"%V $mapwo \n"

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon);


   c= "EXIT"




   sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon);

    titleButtonsQRD(vp)

    sWi(vp,@redraw); // need a redraw proc for app
///
///   Graphic module for xor

////////////  Window Setup ///////////////////////

// get window for display
// FIX -- first line of include  is missed
   ;

    wid = cWi(@title,"ANN",@resize,0.05,0.01,0.99,0.95,0);

   // <<"Wid is $wid \n"

    sWi(wid,@pixmapon,@drawon,@save,@bhue,WHITE_)

/// window quit button
    tbwo=cWo(wid,@TB,@name,"tb_q",@color,"yellow",@VALUE,"QUIT",@func,"window_term",@resize,0.9,0.9,0.99,0.99);
    sWo(tbwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,@FONTHUE,"red", @symbol,"triangle", @symsize, 120, @redraw)

    cx = 0.05
    cX = 0.95
    cy = 0.05
    cY = 0.95

    gwo=cWo(wid,@GRAPH,@resize,0.1,0.01,0.95,0.84,@name,"P2D",@color,"cyan",@bhue,WHITE_)

<<"%V$gwo \n"

    sWo(gwo,@clip,cx,cy,cX,cY)

    sWo(gwo,@scales,0, 0, 1, 1, @save,@redraw,@drawon,@pixmapon)


    // to plot the rms_error

    rms_gwo=cWo(wid,@GRAPH,@resize,0.85,0.85,0.95,0.90,@name,"RMS",@color,"cyan",@bhue,"white",@drawoff);

    sWo(rms_gwo,@clip,cx,cy,cX,cY)

    sWo(rms_gwo,@scales,0, 0, 5000, 5, @save,@redraw,@drawoff,@pixmapon,@save,@savepixmap);


    w_y0 = 0.90
    w_y1 = w_y0 + 0.09

 rms_wo=cWo(wid,@BV,@color,"blue")

//<<"%V$rms_wo   \n"

 pc_wo=cWo(wid,@BV,@bhue,GREEN_)

 pcorr_wo=cWo(wid,@BV,@value,0,@bhue,BLUE_,@fhue,WHITE_)

//<<"%V$pc_wo    \n"

 pat_wo=cWo(wid,@BV,@bhue,YELLOW_,@func,"inputValue");


 nswps_wo=cWo(wid,@BV,@fhue,RED_)

<<"%V$nswps_wo \n"

   sWo(pc_wo,@name,"PC",@value,0,@fonthue,"black",@style,"SVB")
   sWo(pcorr_wo,@name,"CORRECT?",@value,0,@fonthue,WHITE_,@style,"SVB")
   sWo(rms_wo,@name,"RMS",@value,0,@color,"red",@bhue,"green",@fonthue,"black",@style,"SVB",@pixmapon,@save)
   sWo(pat_wo,@name,"PAT",@value,0,@color,"green",@fonthue,"black",@style,"SVB")
   sWo(nswps_wo,@name,"NSWEEPS",@value,0,@fonthue,"black",@style,"SVB")


int nwos[] = {pc_wo, pcorr_wo,rms_wo,pat_wo,nswps_wo};

wohtile(nwos,0.1,w_y0,0.9,w_y1);


   sWi(wid,@redraw);

   
   sWo(nwos,@redraw);

//////////////////  GLINE for RMS ///////////////////////////

  // create


  rms_gl = cGl(rms_gwo,@TY,Rms,@color,RED_)

  sGl(rms_gl,@hue,RED_)

///////////     Test Plot //////////////////////////////

//   if (wid > 0) {
//    plot_net(N,gwo,0,Input[0], Target)
//   }

////////////////////////////////////

proc  net_display(int wpat, Ip, Tp)
{

   sWo(rms_gwo,@clearpixmap,@border);

   drawGline(rms_gl);

   sWo(rms_gwo,@showpixmap);
 //for (p = 0 ; p < Npats ; p++) {

   plot_net(N,gwo,wpat,Ip, Tp,0)

//   si_pause(0.1)

   pc = nc/ (1.0* Npats) * 100
  net_sweeps = getNetSweeps(N);
  
  sWo(rms_wo,@value,rms,@update)
  sWo(pc_wo,@value,pc,@update)
  sWo(nswps_wo,@value,net_sweeps,@update)
  sWo(pat_wo,@value,wpat,@update);
  // update should just redisplay value 

 //}

}
//==========================================
proc net_show_result()
{
  sWo(rms_wo,@value,rms,@redraw)
  sWo(pc_wo,@value,pc)

 while(1) { 
 for (p = 0 ; p < Npats ; p++) {
  //sWo(gwo,@clear)
  plot_net(N,gwo,p,&Input[0], &Target[0],0)
  //print_net(N,p,&Input[0], &Target[0])
  sWo(pat_wo,@value,p,@redraw)
  si_pause(0.5);
  //ans=iread();
 }
 }

}
//==========================================

proc QUIT()
{
  wid = getAslWid()

<<"ASL wid is $wid \n"

  exitgs()

}

//=========================================
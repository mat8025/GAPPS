//   Graphic module for xor

////////////  Window Setup ///////////////////////

# get window for display
// FIX -- it is missed

<<" this is first statement in include !\n"


   wid = cGw(@title,"ANN",@resize,0.05,0.01,0.99,0.95,0)


<<"Wid is $wid \n"

    sGw(wid,@pixmapon,@drawon,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=CWo(wid,@GRAPH,@resize,0.15,0.1,0.8,0.5,@name,"XOR",@color,"cyan",@bhue,WHITE_)

<<"%V$gwo \n"

    sWo(gwo,@clip,cx,cy,cX,cY)

    sWo(gwo,@scales,0, 0, 1, 1, @save,@redraw,@drawon,@pixmapon)


    // to plot the rms_error

    rms_gwo=CWo(wid,@GRAPH,@resize,0.15,0.51,0.8,0.85,@name,"RMS",@color,"cyan",@bhue,"white")

    sWo(rms_gwo,@clip,cx,cy,cX,cY)

    sWo(rms_gwo,@scales,0, 0, 1000, 5, @save,@redraw,@drawon,@pixmapon)


    w_y0 = 0.90
    w_y1 = w_y0 + 0.09




 rms_wo=cWo(wid,"BV",@resize,0.45,w_y0,0.6,w_y1,@color,"blue")

<<"%V$rms_wo   \n"

 pc_wo=cWo(wid,"BV",@resize,0.62,w_y0,0.75,w_y1,@bhue,"green")

<<"%V$pc_wo    \n"

 pat_wo=cWo(wid,"BV",@resize,0.77,w_y0,0.9,w_y1)

 nswps_wo=cWo(wid,"BV",@resize,0.1,w_y0,.3,w_y1,@fhue,"red")

<<"%V$nswps_wo \n"

   sWo(pc_wo,@name,"PC",@value,0,@fonthue,"black",@style,"SVB")
   sWo(rms_wo,@name,"RMS",@value,0,@color,"red",@bhue,"green",@fonthue,"black",@style,"SVB")
   sWo(pat_wo,@name,"PAT",@value,0,@color,"green",@fonthue,"black",@style,"SVB")
   sWo(nswps_wo,@name,"NSWEEPS",@value,0,@fonthue,"black",@style,"SVB")

   setgwindow(wid,@redraw)

//////////////////  GLINE for RMS ///////////////////////////

  // create


  rms_gl = CreateGline(rms_gwo,@TY,Rms,@color,RED_)
  sGl(rms_gl,@hue,RED_)

///////////     Test Plot //////////////////////////////

//   if (wid > 0) {
//    plot_net(N,gwo,0,Input[0], Target)
//   }

////////////////////////////////////

proc  net_display(int wpat)
{

   sWo(rms_gwo,@clear,@border)

   drawGline(rms_gl)

 //for (p = 0 ; p < npats ; p++) {

   plot_net(N,gwo,wpat,&Input[0], &Target[0],1)

//   si_pause(0.1)

   pc = nc/ (1.0* npats) * 100

  sWo(rms_wo,@value,rms,@update)
  sWo(pc_wo,@value,pc,@update)
  sWo(nswps_wo,@value,net_sweeps,@update)
  sWo(pat_wo,@value,wpat,@update)  // update should just redisplay value 

 //}

}
//==========================================
proc net_show_result()
{
  sWo(rms_wo,@value,rms,@redraw)
  sWo(pc_wo,@value,pc)

 while(1) { 
 for (p = 0 ; p < npats ; p++) {
  //sWo(gwo,@clear)
  plot_net(N,gwo,p,&Input[0], &Target[0],1)
  //print_net(N,p,&Input[0], &Target[0])
  sWo(pat_wo,@value,p,@redraw)
  si_pause(1.0)
 }
 }

}
//==========================================
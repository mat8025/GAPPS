

///  seespec select and show 

proc showSlice ( tx )
{
<<"--> $_proc \n"
int sti;

     sti = (tx * Freq)

     end = sti + wlen - 1

<<" %V$sti $end $(end-sti)\n"

     real = YS[sti:end]

//<<"$real[0:24] \n"
// sWo({tawo,spwo},@clearpixmap)

     sWo(tawo, @redraw, @clearclip, LIGHTGRAY_,@clearpixmap);
     sWo(spwo, @redraw, @clearclip, WHITE_,@clearpixmap);

     vDraw(tawo,real[0:wlen-1],0,1.0,0);
     // the real size may not be set here - use full spec 0:wlen-1
//     vDraw(tawo,real,0,1.0)
// the real size may not be set here - use full spec 0:wlen-1

     sWo(tawo, @clipborder,BLACK_)
     rsz = Caz(real)


     // swindow and compute powspec

     real *= swin

     imag[wlen] = 0
         
     imag = 0.0
     
     spec(real,imag,FFTSZ,0)

     powspec = real[0:hwlen-1]

     Vdraw(spwo,real[0:hwlen-1],0,1.0,1,0,8000)

     sWo(spwo, @clipborder,BLACK_)

     RP = wogetrscales(taswo);   // via PIPE msg 

   //<<"%V$RP \n"

     rx = RP[1]
     ry = RP[2]
     rX = RP[3]
     rY = RP[4]

// FIX ? anonymous array causes crash?
    //sWo({tawo,spwo},@showpixmap,@clipborder) 
    //sWo(tawo,@showpixmap,@clipborder)
    //sWo(spwo,@showpixmap,@clipborder)

    displayComment("time $tx sample $sti %V6.2f$rx $rX  $tx\n")

//    sGl(co2_gl,@cursor,tx,y0,tx,y1)
//    sGl(co_gl,@cursor,tx,y0,tx,y1)
<<"<-- $_proc \n"
}//------------------------------------------

proc selSection( tx)
{
//int s1;

// display a section of the VOX buffer

<<" $_proc $tx \n"

    int s1 = tx * Freq

    //s1 = tx * Freq

<<" $s1 \n"
// bracket around

<<"%V$nxpts \n"

    s1 -= nxpts/2

    int s2 = s1 + nxpts

    float tx1 = s1/ Freq

<<" $tx1 \n"

    sGl(co_gl,@cursor,tx1,y0,tx1,y1)

// FIX   sGl(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed

    float tx2 = s2/ Freq


<<" $tx2 \n"

    sGl(co1_gl,@cursor,tx2,y0,tx2,y1)  // arg not parsed

//   sWo(taswo,@clearpixmap,@clipborder,@clearclip,BLUE_)
//   sWo(taswo,@clearpixmap,@clipborder,@clearclip,BLUE_)
//   drawSignal(tawo, sbn, s1, s2)

    displayComment("select  $tx1 $tx2  --- $s1 $s2 \n")

// sWo(tawo,@scales, tx1,-26000, tx2, 26000)  // via SHM
//    sGl(co2_gl,@cursor,0)  // show if it is already active  
//    sGl(co3_gl,@cursor)  // show if it is already active  


    //axnum(taswo, 1, tx1,tx2,0.25,-1,"g")
      axnum(tawo, -1)
    //sWo(taswo,@showpixmap)
    
    sGl(co2_gl,@cursor)  // show if it is already active  
    sGl(co3_gl,@cursor)  // show if it is already active  

<<"<-- $_proc \n"

}
//===============================================

proc showSelectRegion()
{
<<"--> $_proc  \n"

int s1;
int s2;

      GV = glineGetValues(co2_gl)
      GV1 = glineGetValues(co3_gl)

<<"cursors at %V$GV $GV1 \n"


     //sWo(commwo,@clear,@textr,"%V6.3f$GV \n",0.1,0.7)
     //sWo(commwo,@textr,"%V6.3f$GV1 \n",0.1,0.3)

     new_stx = GV[0]
     new_fin = GV1[0]

//     int s1 = new_stx * Freq
//     int s2 = new_fin * Freq

      s1 = new_stx * Freq
      s2 = new_fin * Freq

<<"%V$new_stx $new_fin $s1 $s2 $nxpts \n"

<<" clearing %V$taswo \n"

  //  sWo(taswo,@redraw,@clearclip,GREEN_)

   sWo(taswo,@redraw)

   sWo(taswo,@clearclip,RED_)
   
   sWo(taswo,@scales, new_stx,-26000, new_fin, 26000)  // via SHM

   drawSignal(taswo, sbn, s1, s2)

    // axnum(taswo, 1, new_stx,new_fin,1.0,-1,"g")

   axnum(taswo, -1)
    
   //displayComment("%V$rx $rX $ry $rY \n")

   sWo(sgwo,@clearclip,@clearpixmap)
//     sWo(taswo,@scales, new_stx,-32000, new_fin, 32000)  // via SHM

  computeSpecandPlot(new_stx, new_fin)

   RP = wogetrscales(taswo)   // via PIPE msg 

   //<<"%V$RP \n"
   rx = RP[1]
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]

  // <<"%V$rx $rX $ry $rY \n"

   sWo(taswo,@scales, new_stx,-26000, new_fin, 26000)  // via SHM
   sWo(sgwo,@scales, new_stx,0, new_fin, 100)  

   axnum(sgwo,-3)
   
   displayComment("%V6.2f$new_stx $new_fin $rx $rX\n")

<<"<-- $_proc \n"
}

//-------------------------------------------

proc showVox()
{
            sWo(voxwo,@scales,0,mm[0],vox_tX,mm[1])
            // position cursors
            sGl(co2_gl,@cursor,0,y0,0,y1)
            sGl(co3_gl,@cursor,10,y0,10,y1)  

            sWo(voxwo, @redraw,@clearclip,WHITE_)

            drawSignal(voxwo, sbn, 0, npts)

            axnum(voxwo,-3)

	 //   sWo(taswo, @redraw,@clearclip,WHITE_)
         //   drawSignal(taswo, sbn, 0, npts)	    

            showSelectRegion()
}
//======================================================
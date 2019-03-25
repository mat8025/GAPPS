// sgplot.asl


int ncb = 90

uchar pixstrip[2][ncb]



proc computeSpecandPlot( rtx)
{
// YS is our float buffer containing the whole signal
// want to compute spectrogram for subregion
// nxpts is number of xpixels in spectrograph window 
// one spec per pixel

   dt = FineTimeSince(T,1)  // reset timer

   st = rtx * Freq

   bufend = st + nxpts - FFTSZ

   xp = 0

   frames = 0


   while (1) {

     end = st + wlen - 1

     real = YS[st:end]

     rsz = Caz(real)

<<"%V$frames $st $rsz $real[0] $real[fftend]\n"

     if (show_tas) {
        setgwob(tawo,@clearclip)
        DrawY(tawo,real,0,1)
      }

     rtx = st / Freq

     setGline(cop_gl,@cursor,rtx,y0,rtx,y1)

    //setGline(co_gl,@cursor,end,y0,end,y1)

     zx = ZC(real,Zxthres)

     rmsv = RMS(real)

     real *= swin

     imag = 0.0
     isz = Caz(imag)
 //<<"$real[0:20]\n"

//<<"%V$st $FFTSZ $isz $imag[0] $imag[fftend]\n"
//<<"%V$zx $rmsv \n"
     
    spec(real,imag,FFTSZ,0)

    st += wshift 

    if (show_spec) {
     setgwob(spwo,@clearclip)
     DrawY(spwo,real[0:hwlen-1],0,1)
   }

   powspec = real[0:hwlen-1]

   if ((xp % 2) == 0) {
     pixstrip[0][::] = round(v_range(v_zoom(powspec,ncb),-10,100,0,ng))
   }
   else {
   
     pixstrip[1][::] = round(v_range(v_zoom(powspec,ncb),-10,100,0,ng))

<<"plotpix %V$xp $sgwo $Gindex\n"

     //plotPixRect(sgwo, pixstrip, Gindex, xp, 0, 2,1)
    plotPixRect(sgwo, pixstrip, Gindex, xp, 0, 1,1)
     
     //setgwob(commwo,@clear,@textr," $tx $frames \n",0.1,0.5)
   }

   xp++

    if (st > bufend)
        break

    if ((frames % 16)  == 0) {

        // sleep(0.7)  // SHM full check  -- need to check
    }


    frames++
  }



  dt = FineTimeSince(T,1)

  dtsecs = dt / 1000000.0

<<"compute and plot time took $dtsecs  frames $frames %V$xp\n"

  //setgwob(commwo,@clear,@clipborder,@textr,"compute & plot time took $dtsecs  frames $frames \n",0.1,0.5)

   displayComment("compute & plot time took $dtsecs  frames $frames %V$xp $wshift \n")

}


proc showSlice ( tx )
{

int sti;

  if (tx > 0 ) {

   <<"%V$tawo $spwo $tx\n"

     sti = (tx * Freq)

     end = sti + wlen - 1

     <<"%V $sti $end \n"

     real = YS[sti:end]

     //<<"%V $real \n"

     //setGwob({tawo,spwo},@clearpixmap)
     sWo(tawo,@clearpixmap)

    // setgwob(tawo,@clearclip)

     sWo(spwo,@clearpixmap)

     DrawY(tawo,real,0,1)

     // swindow and compute powspec

     real *= swin

//<<"%V$FFTSZ \n"

//<<"%V$real\n"

     imag = 0.0

//<<"%V$imag[0:9] \n"
//<<"%V$imag[255] \n"     

     spec(real, imag, FFTSZ, 0)


     powspec = real[0:hwlen-1]

    // setgwob(spwo,@clearclip)

     DrawY(spwo,real[0:hwlen-1],0,1)


   RP = wogetrscales(taswo)   // via PIPE msg 

   //<<"%V$RP \n"
   rx = RP[1]
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]

    //setGwob({tawo,spwo},@showpixmap,@clipborder)

    sWo(tawo,@showpixmap,@clipborder)

    sWo(spwo,@showpixmap,@clipborder)

    displayComment("time $tx sample $sti %V6.2f$rx $rX  $tx\n")

//    setGline(co2_gl,@cursor,tx,y0,tx,y1)
//    setGline(co_gl,@cursor,tx,y0,tx,y1)

   }
}



proc selSection( tx)
{
// display a section of the VOX buffer

<<" $_proc $tx \n"

    int s1 = tx * Freq

// bracket around

    s1 -= nxpts/2

    if (s1 < 0) {

        s1 = 0

    }

    int s2 = s1 + nxpts

    float tx1 = s1/ Freq

    setGline(co_gl,@cursor,tx1,y0,tx1,y1)

// FIX   setGline(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed

    float tx2 = s2/ Freq

    setGline(co1_gl,@cursor,tx2,y0,tx2,y1)  // arg not parsed

    setGwob(taswo,@clearpixmap,@clipborder)

    drawSignal(taswo, sbn, s1, s2)

    displayComment("select  $tx1 $tx2  --- $s1 $s2 \n")

    setGwob(taswo,@scales, tx1,-MaxTa, tx2, MaxTa)  // via SHM

//    setGline(co2_gl,@cursor,0)  // show if it is already active  
//    setGline(co3_gl,@cursor)  // show if it is already active  

    //axnum(taswo, 1, tx1,tx2,0.25,-1,"g")

    axnum(taswo, -1)

    setGwob(taswo,@showpixmap)

    setGline(co2_gl,@cursor)  // show if it is already active  
    setGline(co3_gl,@cursor)  // show if it is already active  
}



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

<<"%V $npts ta_pts $nxpts $wshift\n"

    bufend = nxpts - FFTSZ

}




proc showSelectRegion()
{

      GV = glineGetValues(co_gl)
      GV1 = glineGetValues(co1_gl)

     //setgwob(commwo,@clear,@textr,"%V6.3f$GV \n",0.1,0.7)
     //setgwob(commwo,@textr,"%V6.3f$GV1 \n",0.1,0.3)

     new_stx = GV[0]
     new_fin = GV1[0]

<<"%V$taswo $new_stx $new_fin $s1 $s2 $nxpts \n"

     int s1 = new_stx * Freq
     int s2 = new_fin * Freq

//     setGwob(taswo,@clearclip,@clear,@clearpixmap)
  //   drawSignal(taswo, sbn, s1, s2)

     setGwob(taswo,@scales, new_stx,-MaxTa, new_fin, MaxTa)  // via SHM

     setGwob(taswo,@save)

    // axnum(taswo, 1, new_stx,new_fin,1.0,-1,"g")
       axnum(taswo, -1)
    
   //displayComment("%V$rx $rX $ry $rY \n")

     setGwob(sgwo,@clearclip,@clearpixmap)

     computeSpecandPlot(new_stx)

   RP = wogetrscales(taswo)   // via PIPE msg 

   //<<"%V$RP \n"
   rx = RP[1]
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]

   <<"%V$rx $rX $ry $rY \n"

   setGwob(taswo,@scales, new_stx,-MaxTa, new_fin, MaxTa)  // via SHM
   setGwob(sgwo,@scales, new_stx,0, new_fin, 100)  

   axnum(sgwo,-3)

   displayComment("%V6.2f$new_stx $new_fin $rx $rX\n")
   setGwob({taswo,voxwo},@clipborder)  
}

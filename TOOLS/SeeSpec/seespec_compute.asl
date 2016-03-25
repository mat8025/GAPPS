
////////// seespec_compute /////////////////


proc computeSpecandPlot(rtb , rtf)
{

// YS is our float buffer containing the whole signal
// we want to compute spectrogram for the selected subregion
// nxpts is number of xpixels in spectrograph window 
// one spec per pixel

   int st = rtb * Freq;
   int stend = rtf * Freq;
   
<<"%V $rtb $rtf $st $stend \n"

   sbend = getSigbEnd(sbn);

   if ((st >=0) && (stend < sbend)) { 

   dt = FineTimeSince(Tim,1);  // reset timer

   nxp = getNpixs();

  // bufend = st + nxpts - FFTSZ
   bufend = npts - FFTSZ
   
   xp = 0

   frames = 0
   spi = st
   
   int winshift = 0
 
   winshift = (stend- st) / nxp

   ysz = Caz(YS);

//<<"%V $ysz  \n"
<<"$YS[0] $YS[ysz-1]\n"
   
    sWo(fewo,@ClearPixMap,@clearClip);
    
 while (spi < stend) {

     end = st + wlen - 1
    // <<"%V$st $wlen $end \n"

     if (end > ysz) {
<<"ERROR $end > $ysz \n"
     }

     real = YS[st:end]
     rsz = Caz(real)

//<<"%V$rsz\n"

//<<"%V$frames $st $rsz $real[0] $real[fftend]\n"

     if (show_tas_rf) {
        sWo(tawo,@redraw,@clearclip)
        vdraw(tawo,real,0,1,0)
      }

     rtx = st / Freq

     sGl(cop_gl,@cursor,rtx,y0,rtx,y1)

    //sGl(co_gl,@cursor,end,y0,end,y1)

     zx = ZC(real,Zxthres)

//<<"$frames $zx\n"

     ZxTrk[frames] = zx;

     rmsv = RMS(real)

     RmsTrk[frames] = 0.0;

     if (rmsv > 0.0) {
       RmsTrk[frames] = 10*log10(rmsv) -20
     }

     real *= swin

     imag[FFTSZ-1] = 0;
     
     imag = 0.0

     isz = Caz(imag)


//<<"%V$st $isz $imag[0] $imag[fftend]\n"
//<<"%V$zx $rmsv \n"
     
     spec(real,imag,FFTSZ,0)

//<<"$real[0:20]\n"

     st += winshift

    if (show_spec_rf) {
     sWo(spwo,@redraw,@clearclip,WHITE_)
     //vdraw(spwo,real[0:hwlen-1],0,1.0,0)
     Vdraw(spwo,real[0:hwlen-1],0,1.0,1,0,8000)
   }

   powspec = real[0:hwlen-1]

   if ((xp % 2) == 0) {
     pixstrip[0][::] = round(v_range(v_zoom(powspec,ncb),-10,100,0,ng))
   }
   else {
     pixstrip[1][::] = round(v_range(v_zoom(powspec,ncb),-10,100,0,ng))

     plotPixRect(sgwo, pixstrip, Gindex, xp,0,2,1)
     //sWo(commwo,@clear,@textr," $tx $frames \n",0.1,0.5)
   }

    xp++

    if (st > bufend) {
        break
    }

    if (xp > nxp) {
       break
    }


    if ((frames % 16)  == 0) {
        // sleep(0.7)  // SHM full check  -- need to check
    }

    frames++
  }


   sWo(fewo,@ClearPixMap,@scales,0,0,frames,30);
   sGl(rmsgl,@scales,0,0,frames,30,@ltype,1, @symbol,"diamond",@savescales,0,@usescales,0)
   
  drawGline(rmsgl);



  sWo(fewo,@scales,0,0,frames,1.5,@savescales,1,@usescales,1)
  sGl(zxgl,@scales,0,0,frames,1.5,@ltype,1, @symbol,"diamond",@savescales,1,@usescales,1)
  drawGline(zxgl);
    
  <<"%V$frames \n"
  <<"%V$ZxTrk[20]\n"
  
  sWo(fewo,@showPixMap) ;    
  sWo(fewo,@clipBorder,BLACK_);
  dt = FineTimeSince(Tim,1)

  dtsecs = dt / 1000000.0

  //<<"compute and plot time took $dtsecs  frames $frames \n"

  //sWo(commwo,@clear,@clipborder,@textr,"compute & plot time took $dtsecs  frames $frames \n",0.1,0.5)

   displayComment("compute & plot time took $dtsecs  frames $frames \n");
   
  }
  
}

//========================================

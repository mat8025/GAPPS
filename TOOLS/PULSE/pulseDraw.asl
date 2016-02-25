#/* -*- c -*- */
# "$Id: pulseDraw.g,v 1.1 2003/06/25 07:08:30 mark Exp mark $"



proc DrawPoxPars()
{
     DrawO2C()

     DrawO2()

     DrawPR()

     DrawCC()

     DrawSpecPI()

     DrawSPV(spvw)

}

proc DrawInput(aw)
  {

    W_ClearPixMap(aw)
   // find scaling
 
    MM = Stats( InIR)
    ymin = MM[5]
    ymax = MM[6]  

    dys = ymax - ymin 
    meanys = MM[1]

    // <<"$nloop %v $ymin $ymax  $dys $meanys\n"

   ymin = meanys - 1080128/2
   ymax = meanys + 1080128/2


    //  W_SetRS(aw,0,ymin,Fftsz,ymax)

    //  int wend = hfftsz -1
 
   int wend = Wlen -1
    //  <<" $start $wend \n"
    //    <<" %v $Red[start;start+5] \n"

    W_SetPen(aw,"blue")

      DrawY(aw,InIR[0 : wend],1,0.75)

    // DrawY(aw, real,1, 0.75)

    //  DrawY(aw,InIR[0 : wend],0)

  W_SetPen(aw,"red")
    //  W_DrawY(aw, Red[start : wend], 0.0,2)

    //DrawY(aw, InRed[0 : wend],0 )

      DrawY(aw, InRed[0 : wend],1, 0.75)

    // DrawY(aw, imag,1, 0.75)

  W_ShowPixMap(aw)

 }

proc DrawSPR()

{
  // spikeremoved ?








}



proc DrawTDD()
    {


  W_ClearPixMap(tdf)

  W_ClearPixMap(rrw)

  W_SetPen(tdf,"blue")

  DrawY(tdf, Tddir,1,1.0)

  W_SetPen(tdf,"red")

  DrawY(tdf, Stddir,1,1.0)

  DrawY(tdf,Pks,2,0.1)

  W_SetPen(tdf,"green")

  DrawY(tdf,Spks,2,0.1)

  W_ShowPixMap(tdf)

  W_SetPen(rrw,"red")

  MM = Stats(Rednd)

    ymin = MM[5]
    ymax = MM[6]  

  W_SetRS(rrw,ymin,ymin,ymax,ymax)

  VV_Draw(rrw,Rednd,IRnd)

  W_ShowPixMap(rrw)

  }

proc DrawTdd()
{
  W_ClearPixMap(tdf)

  W_SetPen(tdf,"blue")

  DrawY(tdf, Tddir,1,1.0)

  W_SetPen(tdf,"red")

  DrawY(tdf, Tddr,1,1.0)

  W_ShowPixMap(tdf)

}





proc DrawPR()
{

  W_ClearPixMap(prw)

  W_SetPen(prw,"red")
    DrawY(prw,TDpr)

    jit = SMEst * 0.5
    jit += 200
  W_SetPen(prw,"black")
    DrawY(prw,jit)


  W_SetPen(prw,"orange")
    DrawY(prw,Specpr)       

  W_SetPen(prw,"yellow")
    DrawY(prw,V_Smooth(Ceppr,5))

  W_SetPen(prw,"green")
    DrawY(prw,V_Smooth(FLTpr,5))

  W_SetPen(prw,"blue")
    DrawY(prw,V_Smooth(BestPR,5))

#{

  W_SetPen(prw,"blue")
  DrawY(prw,Epr)

#}

   ws=GetScreen()

  if (ws != 0)
  DrawAxis(prw)

    //  DrawAxis(prw)
  W_ShowPixMap(prw)
    gsync()
 }


proc DrawO2C()
 { 

  if (!Graphic) return

  W_ClearPixMap(o2cw)

  aw = o2cw

#{

  W_SetPen(aw,"blue")
      DrawY(aw,V_Smooth(Mso2,nsm))       // mean spectral Ac channels 
// energy spec based o2 - tracking peak
  W_SetPen(aw,"orange")
    DrawY(aw,V_Smooth(Epso2,nsm))
 // max spec peak o2
  W_SetPen(aw,"yellow")
    DrawY(aw,V_Smooth(Ep2so2,nsm))
  W_SetPen(aw,"red")
   DrawY(aw,V_Smooth(Ac2dco2,nsm)) 

#}


  W_SetPen(aw,"orange")
    DrawY(aw,V_Smooth(M0so2,nsm))       // scale/transform track to fit acdc track

  W_SetPen(aw,"yellow")
    DrawY(aw,V_Smooth(M1so2,nsm))       // first 1/4 mean spectral Ac channels 

  W_SetPen(aw,"blue")
    DrawY(aw,V_Smooth(M2so2,nsm))

  W_SetPen(aw,"lightgreen")
    DrawY(aw,V_Smooth(M3so2,nsm))

    //  W_SetPen(aw,"lightblue")
    //    DrawY(aw,V_Smooth(M4so2,nsm))



  W_SetPen(aw,"green")
       DrawY(aw,V_Smooth(Cp2so2,nsm))


    // these are all the spectral bins(channels)



  W_ShowPixMap(aw)

  W_SetPen(aw,"black")

 }


int nsm = 5

proc DrawO2()
 { 
  if (!Graphic) return   

   //   W_title(o2w,"SPO2  $last_siglock ")

  W_ClearPixMap(o2w)

  aw = o2w

    // <<" %V $last_siglock \n"

  // turn this into a track 104 GAC 100 Nogac

  W_SetPen(aw,"lightred")
        DrawY(aw, (Siglock + 100.0))     

  W_SetPen(aw,"black")
        DrawY(aw, (MeS + 100.0))     

// regression TD based o2 
  W_SetPen(aw,"red")
        DrawY(aw,V_Smooth(TDo2,nsm))     

// filtered pleth regression TD based o2 
  W_SetPen(aw,"lightred")
    DrawY(aw,V_Smooth(FPo2,nsm))

  // dc tracking
  W_SetPen(aw,"black")
        DrawY(aw,V_Smooth(DCso2,nsm))     

     // mean spectral energy band 30-330
  W_SetPen(aw,"lightblue")
      DrawY(aw,V_Smooth(Mso2,nsm))  

    // cep tracking peak 02
  W_SetPen(aw,"yellow")
       DrawY(aw,V_Smooth(Cpso2,nsm))

  W_SetPen(aw,"orange")
       DrawY(aw,V_Smooth(SprO2v,nsm))


 // rms energy using tracking filtered channel
  W_SetPen(aw,"green")
   DrawY(aw,V_Smooth(Acdco2,nsm)) 

  W_SetPen(aw,"blue")
    DrawY(aw,V_Smooth(BestO2,nsm))

    W_SetPen(aw,"red")
        DrawY(aw,V_Smooth(M3so2,nsm))

 <<" %V $last_siglock \n"

  PlotVLine(aw,last_siglock,0,1,"yellow")
    gsync()

   ws=GetScreen()

  if (ws != 0) {
  DrawAxis(aw)
  ShowFileN(aw, lstem)
  }

  W_ShowPixMap(aw)

  W_SetPen(aw,"black")


    }



proc DrawCC()
 { 
  if (!Graphic) return
  W_ClearPixMap(ccw)
  W_SetPen(ccw,"red")
    //  DrawY(ccw,CCws)
  DrawY(ccw,VVws)
  W_SetPen(ccw,"blue")
    //  DrawY(ccw,CCtc)
  DrawY(ccw,VVtc)

  W_ShowPixMap(ccw)
 }


proc DrawME()
 { 
  if (!Graphic) return
  W_ClearPixMap(mew)


  W_SetPen(mew,"blue")
  Smest = V_Smooth(MEst,3)
  DrawY(mew,Smest)

  W_SetPen(mew,"lightred")
  DrawY(mew,V_Smooth(TMEst,3))

  W_SetPen(mew,"lightgreen")
  DrawY(mew,V_Smooth(SMEst,3))


  W_SetPen(mew,"lightblue")
  DrawY(mew,V_Smooth(DMso2,1))

    // motion thres

  PlotLine(mew,0,SMotion,nloop,SMotion,"red")
  PlotLine(mew,0,WMotion,nloop,WMotion,"green")

  W_ShowPixMap(mew)

 }

proc ShowPRC()
{
  if (!Graphic) return
     bbin = PR2ESB( Rpr)
     PlotVLine(psw,bbin,0,1,"blue")

     bbin = PR2ESB( Cpr)

     PlotVLine(psw,bbin,1.0,0.8,"yellow")

     bbin = PR2ESB( Tpr)

     PlotVLine(psw,bbin,1.0,0.8,"red")
     PlotVLine(psw,spbstart,1.0,0.8,"black")
     PlotVLine(psw,spbend,1.0,0.8,"black")

#{

     PlotLine(psw,Lcbin2,0,Lcbin2,100,"red")

     PlotLine(psw,Ucbin2,0,Ucbin2,100,"red")
       // plot current pr estimates

     fprbin =(Fpr /60.0)/25.0  * hfftsz

     PlotLine(psw,fprbin,0,fprbin,500,"blue")

     cprbin = (Cpr /60.0)/25.0  * hfftsz

     PlotLine(psw,cprbin,0,cprbin,500,"green")

     tdprbin = (pr /60.0)/25.0  * hfftsz

     PlotLine(psw,tdprbin,0,tdprbin,500,"orange")
#}


}





proc DrawPowerSpec()
     {

      W_ClearPixMap(psw)
       //  mblks0 = CountMemBlocks()

	//  W_SetRS(psw,0,0,hfftsz,1000000.0)

      W_SetRS(psw,lowspbin,0,highspbin,1000000.0)
   
      W_SetPen(psw,"red")

	//      DrawY(psw,Rpowspec[6:specsz],2,1.0)
	//      DrawY(psw,Renerspec[6:specsz],2,1.0)
	//lets see expanded spec - just in the 20-350bpm range


//      DrawY(psw,Renerspec[lowspbin:highspbin],2,1.0,2,lowspbin,highspbin)

	DrawY(psw,srir[lowspbin:highspbin],2,1.0,2,lowspbin,highspbin)

      W_SetPen(psw,"blue")
   

    // plot Vline of peaks

	if (hsbsz >= 1) {
      PlotVLine(psw, hsb[0;2] ,0.8,1,"blue")
        }

     PlotVLine(psw,Minpulsebin,0.9,1,"red")
     PlotVLine(psw,Maxpulsebin,0.9,1,"red")

	//      DrawY(psw,IRpowspec[lowspbin:specsz],2,1.0)

	//      DrawY(psw,IRenerspec[lowspbin:specsz],2,1.0)

	//      DrawY(psw,IRenerspec[lowspbin:specsz],0,1.0,2,lowspbin,specsz)


//  DrawY(psw,IRenerspec[lowspbin:highspbin],0,1.0,2,lowspbin,highspbin)

 showcoff = 1


       if (showcoff) {
     // show LowerCutoff and Upper on Spectrum
      W_SetRS(psw,lowspbin,0,highspbin,500.0)

     PlotLine(psw,Lcbin,0,Lcbin,100,"black")

     PlotLine(psw,Ucbin,0,Ucbin,100,"black")



       }


      W_ShowPixMap(psw)
     //  mblks1 = CountMemBlocks()
     //  dmb = mblks1-mblks0
     //    if (dmb > 0)
     // <<" $cproc  $dmb\n"

}


proc DrawLogSpec(showcoff)
{
     W_ClearPixMap(fdw)


     W_SetRS(fdw,lowspbin,70,highspbin,500)

      W_SetPen(fdw,"red")

      DrawY(fdw,Rlogspec[lowspbin:highspbin],2,1.0,2,lowspbin,highspbin)

       //      DrawY(fdw,Rlogspec[0:specsz])

      W_SetPen(fdw,"blue")
   
     DrawY(fdw,IRlogspec[lowspbin:highspbin],2,1.0,2,lowspbin,highspbin)
       // DrawY(fdw,IRlogspec[0:specsz])



#{
      RIRspec = Rpowspec /IRpowspec

      RIRspec *= (IRdc/Rdc)

      W_SetPen(fdw,"orange")

      DrawY(fdw,RIRspec[0:specsz],1,0.5)
#}


      W_ShowPixMap(fdw)
}



proc DrawCepstrum(tsz)
     {

   W_ClearPixMap(cdw)

   csz = tsz/2 -1
   cepstbin = 7

   cepst = Stats(cepreal[cepstbin :csz])

   ceppeak = cepst[6]
   
     //  <<" $cproc %v $csz  %v $ceppeak \n"

   W_SetPen(cdw,"red")


     //   W_SetRS(cdw,0,0.0,100,ceppeak)

     //   W_SetRS(cdw,0,0.0,100,5*Cpkthres)

   W_SetRS(cdw,0,0.0,100,1.2*ceppeak)


   DrawY(cdw,cepreal[cepstbin:csz],0,0.0,2,cepstbin,csz)

   W_SetPen(cdw,"blue")

     //   DrawY(cdw,IRcepreal[cepstbin:csz],0,0.0,2,cepstbin,csz)

     // what aspect RIR cepstrum can we use for detecting pleth
#{
     RIRcep = (IRcepreal - cepreal) / (IRcepreal + cepreal)

     RIRcep[0:5] = 0.0

     W_SetPen(cdw,"orange")

     //   DrawY(cdw,RIRcep[cepstbin:csz],1,0.5,2,cepstbin,csz)
#}

     PlotHLine(cdw,Cpkthres,0,1,"blue")

   W_ShowPixMap(cdw)
   gsync()


     }

proc DrawFPleth()
   {
  
  W_ClearPixMap(tdw)
  
  W_SetRS(tdw,0,-20000,Fftsz,20000)

      //    <<" %v $Fpl[0:5] \n

    W_SetPen(tdw,"red")

   // but want measure of amp displayed

    DrawY(tdw, Fpl,1,0.75) 

    W_SetPen(tdw,"blue")

    // want to use red settings

    DrawY(tdw, Firpl,0,0.75)

    W_ShowPixMap(tdw)

     }


proc DrawF2Pleth()
  {

    W_ClearPixMap(tdw2)

    W_SetRS(tdw2,0,-20000,255,20000)

    W_SetPen(tdw2,"red")

    DrawY(tdw2, Fpl2,1,0.75) 

    W_SetPen(tdw2,"blue")

    // want to use red settings

    DrawY(tdw2, Firpl2)

    W_ShowPixMap(tdw2)

 }


proc DrawPRE()
{

    W_ClearPixMap(prew)

    MM= Stats(Px)

      //<<" $MM \n"
    xmin = MM[5]

    W_SetRS(prew,xmin,30,(nsecs+10),300)
   
    W_SetPen(prew,"red")

    DrawXY(prew,Px,Py)

    W_SetPen(prew,"blue")

    DrawXY(prew,NPx,NPy)

    W_ShowPixMap(prew)

}


proc DrawO2Spec()
{

    W_ClearPixMap(o2sw)

    w_SetRS(o2sw,lowspbin,65,highspbin,105)

      //    DrawY(o2sw, V_Smooth(SO2[10:highspbin],3)) 

     DrawY(o2sw, GSO2[lowspbin:highspbin]) 

     bbin = PR2ESB( Smpr)

     PlotVLine(o2sw,bbin,0,1,"red")

     cbin = PR2ESB( Fpr)

     PlotVLine(o2sw,cbin,0,1,"green")

     cbin = PR2ESB( Rpr)

     PlotVLine(o2sw,cbin,0,1,"yellow")

      if (msO2 > 85)
     PlotHLine(o2sw,msO2,0,1,"blue")
       else
     PlotHLine(o2sw,msO2,0,1,"red")

    W_ShowPixMap(o2sw)

}


proc DrawSpecPI()
{

  W_ClearPixMap(spiw)

  W_SetPen(spiw,"red")
    DrawY(spiw,SPI)

  W_ShowPixMap(spiw)
}


proc DrawSPV(aw)
{

  W_ClearPixMap(aw)

  W_SetPen(aw,"red")
    DrawY(aw,Spvvec)

  W_ShowPixMap(aw)
}

proc BannerParams(nloop)
 {
		      w_setpen(o2w,"black")
   W_title(o2w,"SPO2 %4.0f $acdcO2 %d  $last_siglock ",1,0)
		      w_setpen(prw,"black")
   W_title(prw,"PulseRate %4.0f $Fpr $pcc",1,0)

 }


float rs[]

proc DrawAxis(ww)
{

      rs = w_getRS(ww)
      
      rx = rs[1] ; ry = rs[2]
      rX = rs[3] ; rY = rs[4]


     rx = start_secs/60
     rX = nsecs/60

		     //      rx = start_secs
		     //      rX = nsecs

      rs[3] = rX
      rs[1] = rx

	    w_setRS(rs)

            dx = (rX - rx )
            dy = (rY - ry )

            ix = get_incr ( dx)
		     if (ix < 1)
                         ix = 1
            iy = get_incr ( dy)

            W_SetPen(ww,"black")

            ticks(ww,1,rx,rX,ix,0.02)
            ticks(ww,2,ry,rY,iy,0.02)

            axnum(ww,1,rx+ix,rX-ix,ix,-2.0,"3.0f")
            axnum(ww,2,ry+iy,rY,iy,1.0,"3.0f")

        w_clipborder(ww)
		     //     w_store(ww)
        gsync()
}




proc DrawSAxis(ww)
{

      rs = w_getRS(ww)
      
      rx = rs[1] ; ry = rs[2]
      rX = rs[3] ; rY = rs[4]

            dx = (rX - rx )
            dy = (rY - ry )

            ix = get_incr ( dx)
            iy = get_incr ( dy)

            W_SetPen(ww,"black")

            ticks(ww,1,rx,rX,ix,0.02)
            ticks(ww,2,ry,rY,iy,0.02)

            axnum(ww,1,rx+ix,rX-ix,ix,-2.0,"3.0f")
            axnum(ww,2,ry+iy,rY,iy,1.0,"3.0f")

        w_clipborder(ww)
		     //     w_store(ww)
        gsync()
}



proc ShowFileN(ww, fn)
{

  W_SetPen(ww,"black")

  Text(ww," $fn ", 0.3, -0.05,1)

  Text(ww," $cwd ", 0.7, -0.05,1)

}




# end  routines





#{
  // plot all bins
  W_SetPen(aw,"red")
    DrawY(aw,V_Smooth(Eso2,nsm))

    col = 2
    nesc = 20
    for (js = 0 ; js < 120 ; js += nesc) {
     W_SetPen(aw,col)
     //     nacdc = SACDC[*][js]


     nacdc = SACDC[*][js:js+nesc]
       //     <<" $nacdc \n"
     nacdc = Sum(Transpose(nacdc)) * 1.0/nesc
       //     <<" $nacdc \n"
     //     nacdc = SumRow(SACDC[*][js:js+nesc])
     
     DrawY(aw,nacdc)
     col++
    }
#}

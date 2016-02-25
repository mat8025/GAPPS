SetDebug(0)


 Pi = 4.0 * Atan(1.0)

 FFTSZ = 1024

 if (! CheckGWM()) {

 SpawnGwm("xxx")

 }




////////////// Window ///////////////////

 aw = cWi(@title,"FFT_DEMO",@resize,0.1,0.1,0.8,0.8,0)

<<"%V$aw \n"

  setgw(aw,@hue,"blue",@bhue,"white",@drawon,@pixmapon)


//////////////// Draw Areas in window ////////
  rinwo= creategwob(aw,@graph,@penhue,"red")
  rfout= creategwob(aw,@graph,@penhue,"black")
  imin= creategwob(aw,@graph,@penhue,"orange")
  imout= creategwob(aw,@graph,@penhue,"yellow")
  magwo= creategwob(aw,@GRAPH,@penhue,"blue")
  phwo= creategwob(aw,@GRAPH,@penhue,"green")


 <<" $rin $phwo \n"
 int allwo[] = {rinwo,imin,rfout,imout,magwo,phwo}

 <<"%v $allwo \n"
// ttyin()
  wo_vtile(allwo,0.1,0.1,0.8,0.9, 0.01)
  

  setgwob(allwo,@clip,0.1,0.1,0.9,0.9)
///////////// Plot ////////////////////
  sWo(allwo,@redraw)
  setgwob(allwo,@drawoff,@save,@pixmapon,@savepixmap)

 float Hzres = 4096.0


 for (j = 0 ; j < 500 ;  j++ ) {

  Hzres *= 0.85

 Real = Sin(Fgen(FFTSZ,0,4*Pi/Hzres))
//<<" $Real \n"

 Imag = Fgen(FFTSZ,0)
//<<" $Imag \n"
 
 setgwob(allwo,@border,@clearpixmap)

 Vdraw(rinwo,Real,1.0.9)
 Vdraw(imin,Imag,1.0.9)


 fft(Real,Imag,FFTSZ,1)

<<"%v $Real[0:10] \n"

<<"%v $Imag[0:10] \n"

// <<"%v $(Caz(Real)) \n"

 Mag = Sqrt (Real * Real + Imag * Imag)

 <<"%v $(Caz(Mag)) \n"

 <<"%v $Mag[0:10] \n"

 <<" $(Caz(Mag)) \n"

 Vdraw(rfout,Real,1,0.9)
 Vdraw(imout,Imag,1,0.9)

 Vdraw(magwo,Mag,1,0.9)

 Ph = Atan( Imag/ Real)

 Vdraw(phwo,Ph,1,0.9)

 <<" $(Caz(Ph)) \n"

 setgwob(allwo,@showpixmap)

 sleep(0.1)

 }

STOP!
SetDebug(1)
SetPCW("writeexe","writepic")

//<<" hello world \n"
OpenDll("math","plot")

 Pi = 4.0 * Atan(1.0)

 FFTSZ = 1024

#{
 if (! CheckGWM()) {

 SpawnGwm("xxx")

 }
#}

////////////// Window ///////////////////
 aw = CreateGw()
<<" $aw \n"

  setgw(aw,"title","DownSample_100_80","hue","blue","bhue","white","drawoff","pixmapon","bhue","white")

//////////////// Draw Areas in window ////////

  rin= creategwob(aw,"GRAPH","hue","red")
  magwo= creategwob(aw,"GRAPH","hue","orange")
  phwo= creategwob(aw,"GRAPH","hue","yellow")


  dsrin= creategwob(aw,"GRAPH","hue","blue")
  dsmagwo= creategwob(aw,"GRAPH","hue","orange")
  dsphwo= creategwob(aw,"GRAPH","hue","yellow")

    setgwob(dsmagwo,"scales",0,0,40.0,3)
    setgwob(magwo,"scales",0,0,40.0,3) // make end pt the same freq

 <<" $rin $phwo \n"
 int allwo[] = {rin,magwo,phwo,dsrin,dsmagwo,dsphwo}

 <<"%v $allwo \n"
// ttyin()
 
  wo_vtile(allwo,0.1,0.1,0.95,0.95)
  setgwob(allwo,"save","pixmapon")
  setgwob(allwo,@clip,0.05,0.05,0.99,0.99)
  setgwob(allwo,@drawclipborder)


float DBSpec[]
float DBTSpec[]
float DSReal[]
float DSImag[]
float DSMag[]
float Y[]


XFREQ80 = Fgen(FFTSZ/2,0,80.0/FFTSZ)
XFREQ100 = Fgen(FFTSZ/2,0,100.0/FFTSZ)


  spec_gl = CreateGline(@wid,dsmagwo,@type,"XY",@xvec,XFREQ80,@yvec,DBSpec,@color,"blue")
  tspec_gl = CreateGline(@wid,magwo,@type,"XY",@xvec,XFREQ100,@yvec,DBTSpec,@color,"red")


///////////// Plot ////////////////////

 float dt = 1.0/100.0 

 freq = 0.5

 dt80 = 1.0/80.0
 dt100 = 1.0/100.0

<<"%V $dt $freq \n"

float Swin[FFTSZ]

  swindow(Swin,FFTSZ,"hamming");


 while (freq < 30.0) { 

  Real = Fgen(FFTSZ,0,dt)

  Real *= (2*Pi*freq)

  Real = Sin(Real)

//<<"$freq $Real[0] \n"

<<"%5\nr $Real \n"

  Imag = Fgen(FFTSZ,0)

//<<" $Imag \n"
 
 setgwob(allwo,"border","clearpixmap")

 Vdraw(rin,Real,1,0.9)

 Real = Real * Swin;

 fft(Real,Imag,FFTSZ,1)

//<<"%v $Real[0:10] \n"
//<<"%v $Imag[0:10] \n"
// <<"%v $(Caz(Real)) \n"

 Mag = Sqrt (Real * Real + Imag * Imag)

 <<"%v $(Caz(Mag)) \n"

  DBTSpec = log10(Mag)


//FIX <<"%v $Mag[0:10] \n"

 <<" $(Caz(Mag)) \n"

// Vdraw(magwo,DBTSpec,1,0.9)

 DrawGline(tspec_gl)

 Ph = Atan( Imag/ Real)

 Vdraw(phwo,Ph,1,0.9)

 //<<" $(Caz(Ph)) \n"

 X = Fgen(FFTSZ,0,dt80)

//<<"%8\nr $X \n"

 Y = trunc(X/dt100)

//<<"%8\nr $Y \n"

 Y *= dt100

  Y->Convert("FLOAT")

//<<"%8\nr $Y \n"
//<<" $(typeof(Y)) \n"
//a=iread("Y")

  DSReal = Y

  DSReal *= (2*Pi*freq)

  DSReal = Sin(DSReal)

  Vdraw(dsrin,DSReal,1,0.9)

 DSReal = DSReal * Swin;

//<<" %5\nr $DSReal \n"
//<<" $(typeof(DSReal)) \n"
//a=iread("DSReal")

  DSImag = Fgen(FFTSZ,0)

// <<"%8\nr $DSImag \n"
// a=iread("DSImag")



  fft(DSReal,DSImag,FFTSZ,1)

  DSMag = Sqrt (DSReal * DSReal + DSImag * DSImag)

//<<"%8\nr  $DSMag \n"
//<<" $(typeof(DSMag)) \n"
//a=iread("DSMag")

// plot VV --- gline since df is different for the different 
// sampling frequencies

  DBSpec = log10(DSMag)

 // Vdraw(dsmagwo,DBSpec,1,0.9)

  DrawGline(spec_gl)

  DSPh = Atan(DSImag/ DSReal)

  Vdraw(dsphwo,DSPh,1,0.9)

  setgwob(allwo,@showpixmap)
  setgwob(allwo,@drawclipborder)
  setgwob(allwo,@store,@save)
  sleep(0.2)

  

//  sleep(10)
<<" %v $freq \n"
 // a= iread()
freq += 0.5
 }


STOP!
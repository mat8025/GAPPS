
#define DBPR  <<
//#define DBPR  ~!

#define DBPROC  <<
//#define DBPROC  ~!




 Graphic = CheckGwm()

 if (!Graphic) {
     X=spawngwm()
  }



 Pi = _PI

//<<"%V$Pi \n"

 FFTSZ = 1024

 Sf = 16000.0

 dt = 1.0/Sf

 frq = 100.0


 Smfunc = "Rectangular"

proc computeFFT()
{
DBPROC" $('PBLUE_') in $_proc $('POFF_')\n"
  dt = 1.0/Sf;

  dft = 2*Pi*frq2*dt

  pip = Fgen(FFTSZ,0,dft)

  Real2 = Sin(pip)

  dft = 2*Pi*frq3*dt

  pip = Fgen(FFTSZ,0,dft)

  Real3 = Sin(pip)

  jf = frq1

  sWo(frq1wo,@value,jf,@update)

  sWo(frq2wo,@value,frq2,@update)

  sWo(frq3wo,@value,frq3,@update)

  dft = 2*Pi*jf*dt

 //Hzres *= 0.25

  pip = Fgen(FFTSZ,0,dft)

  Real = Sin(pip) + Real2 + Real3

  T=swindow(Smfunc,FFTSZ)

//  Real *= T

    Real  = Real * T

  magsc = minmax(Real)

 //<<"$magsc \n"

  sWo(rinwo,@lhbscales,0,magsc[0],FFTSZ,magsc[1])
  
 // sWo(rinwo,@scales,0,magsc[0],FFTSZ,magsc[1],1)

//<<" $Real \n"


  Imag = Fgen(FFTSZ,0)

 sWo(iminwo,@lhbscales,0,-2,FFTSZ,2)

  magsc = minmax(Imag)

// <<"$magsc \n"

  drawGline(imin_gl)

//<<" $Imag[0:10] \n"

//sWo(allwo,@border,@clear,@clearpixmap)

 sWo(allwo,@border,@clearpixmap)

 drawGline(rein_gl)

//Vdraw(rinwo,Real,1,0.9)

 drawGline(imin_gl)

 //Vdraw(imin,Imag,1,0.9)

 sWo(allwo,@border,@showpixmap)

 //fft(Real,Imag,FFTSZ,1)
 fftDit(Real,Imag,FFTSZ,-1)

 //Vdraw(rfout,Real,1,0.9)

  magsc = minmax(Real)
 //<<"$magsc \n"
  sWo(rfout,@lhbscales,0,magsc[0],FFTSZ,magsc[1])


  drawGline(rfout_gl)

  magsc = minmax(Imag)
 //<<"$magsc \n"
  sWo(imout,@lhbscales,0,magsc[0],FFTSZ,magsc[1])
  //drawGline(imout_gl)

  dGl(imout_gl)

 //Vdraw(imout,Imag,1,0.9)

 Mag = Sqrt (Real * Real + Imag * Imag)

 magsc = minmax(Mag)
//<<"Mag $magsc \n"
 sWo(magwo,@lhbscales,0,-100,FFTSZ,magsc[1]*2)
//<<"$Mag\n"
 //Vdraw(magwo,Mag,1,0.9)

 drawGline(mag_gl)

 Ph = Atan( Imag/ Real)

 magsc = minmax(Ph)

 sWo(phwo,@lhbscales,0,-3,FFTSZ,3)

// Vdraw(phwo,Ph,1,0.9)

 drawGline(ph_gl)

 sWo(allwo,@showpixmap)

}



////////////// Window ///////////////////


 aw = cWi(@title,"FFT_DEMO",@resize,0.1,0.1,0.8,0.8,0)

//<<"%V$aw \n"

  setgw(aw,@hue,"blue",@bhue,"white",@drawon,@pixmapon)

//////////////// Draw Area ////////////////////


  rinwo= cWo(aw,@graph,@penhue,"red")
  rfout= cWo(aw,@graph,@penhue,"black")
  iminwo= cWo(aw,@graph,@penhue,"orange")
  imout= cWo(aw,@graph,@penhue,"yellow")
  magwo= cWo(aw,@GRAPH,@penhue,"blue")
  phwo= cWo(aw,@GRAPH,@penhue,"green")

//<<" $rin $phwo \n"
 int allwo[] = {rinwo,iminwo,rfout,imout,magwo,phwo}


//<<"%V$rinwo $rfout $iminwo $imout\n"

  wo_vtile(allwo,0.1,0.1,0.8,0.9, 0.01)



  sWo(allwo,@save,@drawon,@pixmapon)
  sWo(allwo,@clip,0.1,0.1,0.9,0.9,@savepixmap)
  sWo(allwo,"setmod",1)


// name value boxes

     bx = 0.02
     bX = 0.08
     by = 0.5
     bY = 0.85

     sfwo= cWo(aw,@bv,@penhue,"red",@name,"SampleFrq",@value,"$Sf")

     frq1wo= cWo(aw,@bv,@penhue,"blue",@name,"Frq1",@value,"100.0")

     frq2wo= cWo(aw,@bv,@penhue,"green",@name,"Frq2",@value,"440.0")

     frq3wo= cWo(aw,@bv,@penhue,"cyan",@name,"Frq3",@value,"3760.0")


     int frqwo[] = {sfwo, frq1wo, frq2wo, frq3wo }
     int nfrqwo

     sWo(frqwo,@style,"SVB",@func,"inputValue")
     wo_vtile(frqwo,bx,by,bX,bY, 0.03)
     nfrqwo = Csz(frqwo)
     int ifrqwo = 0  // index
//<<"%V$nfrqwo $(Caz(nfrqwo))\n" 

     bx = 0.92
     bX = 0.99
     by = 0.6
     bY = 0.85

 smwo=cWo(aw,"BS",@name,"SmoothWin",@color,"yellow",@resize,bx,by,bX,bY)

 sWo(smwo,@CSV,"Rectangular,Hamming,Hanning,Blackman,Kasier")

 sWo(smwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@STYLE,"SVB", @redraw)
 sWo(smwo,@fhue,"orange",@clipbhue,"steelblue")


//     sWo(frqwo,@style,"SVO",@redraw)  // FIX not clearing





//  sWo(rin,"save")
//  sWo(imout,"save")
//  sWo(rfout,"save")




///////////// Plot ////////////////////
 Setdebug(1,"pline")

 float Hzres = 512.0
 float pip[]

 Sf = 16000.0

 dt = 1.0/Sf


 frq = 100.0

 dft = 2*Pi*frq*dt
 
 float Real[]
 float Imag[]

 float Mag[]
 float Ph[]

 float XV[FFTSZ]

  XV = fgen(FFTSZ,0,1)

   rein_gl = cGl(rinwo,@TY,Real,@color,"red")

   imin_gl = cGl(iminwo,@TY,Imag,@color,"green")

   mag_gl = cGl(magwo,@TY,Mag,@color,"blue")

   rfout_gl = cGl(rfout,@TY,Real,@color,"red")

   imout_gl = cGl(imout,@Ty,Imag,@color,"green")


  frq1 = 10.0


// mag_gl = cGl(magwo,@type,"XY",@XVEC,XV,@YVEC,Mag,@color,"blue")

   sGl(rein_gl,@ltype,"solid",@usescales,0)
   sGl(mag_gl,@ltype,"solid")

   ph_gl = cGl(phwo,@TY,Ph,@color,"green")

  frq2 = 440.0

  dft = 2*Pi*frq2*dt

  pip = Fgen(FFTSZ,0,dft)

  Real2 = Sin(pip)

  frq3 = 1760.0

  dft = 2*Pi*frq3*dt

  pip = Fgen(FFTSZ,0,dft)

  Real3 = Sin(pip)

  sWo(frq2wo,@update)
  sWo(frq3wo,@update)

  sWo(frqwo,@redraw)




////////////////////////GUI/////////////////////////////////////////////////

////////////////////////WONAME CALLBACKS///////////////////////////////////////

proc SampleFrq()
{
//
//    Sf = getWoValue(Woid)
    Sf = atof(getWoValue(Woid))
<<"%V$Sf\n"
    computeFFT()
}


proc Frq1()
{
" $('PBLUE_') in $_proc $('POFF_')\n"


    frq1 = getWoValue(Woid)

<<"%V$frq1 \n"

  computeFFT()
}

proc Frq2()
{
    frq2 = getWoValue(frq2wo)
    computeFFT()
}

proc Frq3()
{

  frq3 = getWoValue(frq3wo)
  computeFFT()
}

proc SmoothWin()
{
DBPROC" in $_proc\n"
  Smfunc = getWoValue(smwo)
  computeFFT()
}

//////////////////////////////////////////////////////////////////////////////

proc processKeys()

{
DBPROC" in $_proc\n"

float val

       switch (keyc) {

       case 'R':
       {

          val = getWoValue(frqwo[ifrqwo])
//<<"%V$val\n"
          val += 10
          sWo(frqwo[ifrqwo],@value,val,@update)
          
       }
       break;

       case 'T':
       {
          val = getWoValue(frqwo[ifrqwo])
          val -= 10
          sWo(frqwo[ifrqwo],@value,val)
          sWo(frqwo[ifrqwo],@highlight,1,@update)

       }
       break;

       case 'S':
       {
          ifrqwo++

          if (ifrqwo >= nfrqwo)
              ifrqwo = 0
<<"$ifrqwo \n"

          sWo(frqwo,@highlight,0,@redraw)
          sWo(frqwo[ifrqwo],@highlight,1,@redraw)
          
       }
       break;

       case 'Q':
       {
          ifrqwo--

          if (ifrqwo < 0)
              ifrqwo = nfrqwo-1
//<<"$ifrqwo \n"
          sWo(frqwo,@highlight,0,@redraw)
          sWo(frqwo[ifrqwo],@highlight,1,@redraw)
       }
       break;

       case 'h':
       {

       }
       break;

       case 's':
       {

       }
       break;

      }

// set the values from the Wobs
      frq1 = getWoValue(frq1wo)

<<"%V$frq1\n"

      frq2 = getWoValue(frq2wo)

      frq3 = getWoValue(frq3wo)

      Sf = getWoValue(sfwo)

      computeFFT()
}
//---------------------------------------------------------------------
proc checkEvents()
{
DBPROC" in $_proc\n"
   E->getEventState(evs)

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   button = E->getEventButton()
   keyc = E->getEventKey()
   keyw = E->getEventKeyW()

<<"%V$Woname $Evtype \n"

//   sWo(two,@clear,@texthue,"black",@textr,"%V$Woid\n$Woname\n $button\n $keyc\n $keyw\n$Woval",-0.9,0.3)

/{
   if (Woid == qwo) {
    //   deleteWin(vp)
    //   exit_gs()
   }
/}

}
//----------------------------------------------

// make this a class

float Rinfo[30]

int evs[16];

 E =1

button = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0

int keyc 

keyw = ""

    computeFFT()

    while (1) {

     msg = E->waitForMsg()

     checkEvents()

      if (Evtype @= "KEYPRESS") {
          processKeys()
      }

       if (Evtype @= "PRESS") {
        if (!(Woname @= "")) {
            DBPR"calling function via $Woname !\n"
            $Woname()
        }
      }


      computeFFT();

  }
















STOP!



///    TBD
///  add direction of transform option
///  option to use fft decimation in Freq vs decimation in Time
///  and a script based FFT version
///

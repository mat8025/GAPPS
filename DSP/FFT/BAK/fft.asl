
SetPCW("writeexe")

//<<" hello world \n"
OpenDll("math")

 Pi = 4.0 * Atan(1.0)

 FFTSZ = 512

 Hzres = 32


 Real = Sin(Fgen(FFTSZ,0,2*Pi/Hzres))

<<" $Real \n"

 Imag = Fgen(FFTSZ,0)
<<" $Imag \n"





////////////// Window ///////////////////
 aw = CreateGw()
<<" $aw \n"

  setgw(aw,"hue","blue","bhue","green")

///////////// Plot ////////////////////
 Vdraw(aw,Real,1.0.9)


  fft(Real,Imag,FFTSZ,1)

<<" $Real[0:10] \n"

  setgw(aw,"hue","red")

 Vdraw(aw,Real,1,0.9)


STOP!
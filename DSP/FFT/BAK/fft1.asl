
 SetPCW("writeexe")

//<<" hello world \n"
 OpenDll("math")

 Pi = 4.0 * Atan(1.0)

 FFTSZ = 1024

////////////// Window ///////////////////

 aw = CreateGw()

<<" $aw \n"

  setgw(aw,"hue","blue","bhue","white","drawoff","pixmapon","bhue","white")

//////////////// Draw Area ////////////////////


  rin= creategwob(aw,"GRAPH","hue","red")
  rfout= creategwob(aw,"GRAPH","hue","red")
  imin= creategwob(aw,"GRAPH","hue","green")
  imout= creategwob(aw,"GRAPH","hue","green")

//  imin= creategwob(aw,"GRAPH")
//  imout= creategwob(aw,"GRAPH")
 int allwo[] = {rin,imin,rfout,imout} 

  wovtile(allwo,0,0.1,0.1,0.9,0.9)

  setgwob(allwo,"save","drawoff","pixmapon")
  setgwob(allwo,"clip",0.1,0.1,0.9,0.9)
  setgwob(allwo,"setmod",1)

//  setgwob(rin,"save")
//  setgwob(imout,"save")
//  setgwob(rfout,"save")




///////////// Plot ////////////////////

 float Hzres = 512.0

 for (j = 0 ; j < 40 ;  j++ ) {

  Hzres *= 0.85

 Real = Sin(Fgen(FFTSZ,0,4*Pi/Hzres))

//<<" $Real \n"

 Imag = Fgen(FFTSZ,0)

//<<" $Imag[0:10] \n"

 setgwob(allwo,"border","clearpixmap")

 Vdraw(rin,Real,1,0.9)
 Vdraw(imin,Imag,1,0.9)

 fft(Real,Imag,FFTSZ,1)



 Vdraw(rfout,Real,1,0.9)
 Vdraw(imout,Imag,1,0.9)

 setgwob(allwo,"showpixmap")


 sleep(0.1)

 }

<<" DONE !! \n"

STOP!
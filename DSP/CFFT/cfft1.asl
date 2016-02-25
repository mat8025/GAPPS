SetDebug(1)
SetPCW("writeexe","writepic")

//<<" hello world \n"
OpenDll("math")

 Pi = 4.0 * Atan(1.0)

 FFTSZ = 1024



////////////// Window ///////////////////
 aw = CreateGw()
<<" $aw \n"

  setgw(aw,"hue","blue","bhue","white","drawoff","pixmapon","bhue","white")

//////////////// Draw Areas in window ////////

  rin= creategwob(aw,"GRAPH","hue","red")
  rfout= creategwob(aw,"GRAPH","hue","red")
  imin= creategwob(aw,"GRAPH","hue","green")
  imout= creategwob(aw,"GRAPH","hue","green")
  magwo= creategwob(aw,"GRAPH","hue","orange")
  phwo= creategwob(aw,"GRAPH","hue","yellow")

 <<" $rin $phwo \n"
 int allwo[] = {rin,imin,rfout,imout,magwo,phwo}

 <<"%v $allwo \n"
// ttyin()
 
  wo_vtile(allwo,0,0.1,0.1,0.9,0.9)
  setgwob(allwo,"save","pixmapon")
 setgwob(allwo,"clip",0.1,0.1,0.9,0.9)

///////////// Plot ////////////////////

 float Hzres = 512.0

 Cmplx C[FFTSZ]

 for (j = 0 ; j < 50 ;  j++ ) {

  Hzres *= 0.85

 C->Real(Sin(Fgen(FFTSZ,0,4*Pi/Hzres)))
//<<" $Real \n"

 C->Imag (Fgen(FFTSZ,0))
//<<" $Imag \n"

 
 setgwob(allwo,"border","clearpixmap")

 Vdraw(rin,C->Real(),1.0.9)

 Vdraw(imin,C->Imag(),1.0.9)

 cfft(C,FFTSZ,1)

// <<"%v $(Caz(Real)) \n"

 Mag =  C->Mag()

 <<"%v $(Caz(Mag)) \n"

 <<"%v $Mag[0:10] \n"

 <<" $(Caz(Mag)) \n"

 Vdraw(rfout,C->Real(),1,0.9)

 Vdraw(imout,C->Imag(),1,0.9)

 Vdraw(magwo,Mag,1,0.9)

 Ph = C->Phase()

 Vdraw(phwo,Ph,1,0.9)

 <<" $(Caz(Ph)) \n"

 setgwob(allwo,"showpixmap")

 sleep(0.05)

 }

STOP!
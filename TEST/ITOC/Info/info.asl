



#include "debug"


if (_dblevel >0) {
   debugON()
}


  filterFileDebug(REJECT_,"store")
  
  chkIn(_dblevel)
  
  void goo()
  {
  
  short c = 3;
  
  c.pinfo()
  
  ci = c->info()
  
  
  <<"%V $c  $ci\n"
  chkN(c,3)
  
  }
  
  int ok;
  int a = 1;
  
  a.pinfo()

  ok = a.checkinfo("INT"); // check for this str in the info

  if (ok) {
<<" $a is an INT\n"

  }

  ok = a.checkinfo("FLOAT");

  if (ok) {
<<" $a is an FLOAT\n"

  }



  ai = a.info()
  
  
  <<"%V $a  $ai\n"


   chkN(1,a)
  
  float b = 2;
  
  b.pinfo()
  
  bi = b.info()
  
  
  <<"%V $b  $bi\n"
  chkN(b,2)
  
  goo()
  
  
  IV = vgen(INT_,10,0,1)
  
  IV.pinfo()
  
  k = IV[3]
  IV[4] = 67;

  chkN(k,3)

  SOF=IV.pinfo()
  <<"SOF:: $SOF\n"
  
  offs = IV.offsets()
  
  <<"%V $offs \n"


chkN(offs[2],4)

  
  IVi = IV->info()
  
  <<"$IVi \n"
  vid = IV.varid()
  <<"%V $vid \n"
  obid = IV.objid()
  <<"%V $obid \n"
  chkN(obid,-1)
  
  
  chkOut()
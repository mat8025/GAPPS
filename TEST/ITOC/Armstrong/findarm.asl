
include "debug.asl"
debugON()
 opendll("uac");



  int np ;
  np = atoi(_clarg[1])

  sdb(1,@trace)

  Armv=findarmstrong(np);

Armv->info(1)
  sz= Caz(Armv);

  <<"%V $sz $Armv[0] \n"
  
<<"\n//// Arms for $np\n"
  sz= Armv[0]
  for (i=0; i <= sz; i++) {
  <<" $Armv[i] \n"
  }

include "debug.asl"
debugON()
 opendll("uac");

  mypid = getAslPid();
	  
  int np ;
  np = atoi(_clarg[1])

  sdb(1,@trace)

  pan begin;
  pan endnum;

  begin = atop(_clarg[2])
  endnum = atop(_clarg[3])
  

<<"%V $np $begin $endnum\n"

	  C= ofw("P_np_${np}_${mypid}.log")
<<[C]"%V $np $begin $endnum\n"


Armv=findarmstrong(np,begin,endnum);

Armv->info(1)
  sz= Caz(Armv);

  <<"%V $sz $Armv[0] \n"
  
<<"\n//// $sz Arms for $np  between $begin $endnum \n"
  sz= Armv[0]
  for (i=1; i <= sz; i++) {
  <<" $Armv[i] \n"
  }

<<[C]"\n//// $sz Arms for $np  between $begin $endnum \n"
  sz= Armv[0]
  for (i=1; i <= sz; i++) {
  <<[C]" $Armv[i] \n"
  }

cf(C);
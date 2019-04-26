
include "debug.asl"
debugON()
 opendll("uac");

  mypid = getAslPid();
	  
  int np ;
  np = atoi(_clarg[1])

  sdb(1,@~trace)

  pan begin;
  pan endnum;
  pan stagenum;  

  begin = atop(_clarg[2])
  endnum = atop(_clarg[3])

  stagenum = begin * 5;

<<"%V $np $begin $endnum $stagenum\n"

C= ofw("P_np_${np}_${mypid}.log")

<<[C]"%V $np $begin $endnum\n"


pan Farms[100];
int Fi = 0;  

int i = 1;

<<"[${i}] %V $np $begin $stagenum\n"


  Armv=findarmstrong(np,begin, stagenum);
<<"$i done findarm\n"
  Armv->info(1)

  sz= Caz(Armv);

<<"%V $sz $Armv[0] \n"
  naf= Armv[1]
<<"\n//// $naf Arms for $np  between $begin $stagenum \n"
  //sz= Armv[0]
  for (i=0; i < sz; i++) {
  <<" $Armv[i] \n"
  <<[C]" $Armv[i] \n"
  }

<<[C]"\n//// $sz Arms for $np  between $begin $stagenum \n"
 // sz= Armv[0]
  if (naf >0) {
  for (i=5; i < sz; i++) {
  <<[C]" $Armv[i] \n"
  Farms[Fi] = Armv[i];
  Fi++;
  }
  }


  begin = stagenum;
  stagenum = endnum;


  Armv2=findarmstrong(np,begin, stagenum);
<<"$i done findarm\n"
  Armv2->info(1)

  sz= Caz(Armv2);

<<"%V $sz $Armv2[0] \n"
  naf= Armv2[1]
<<"\n//// $naf Arms for $np  between $begin $stagenum \n"
  //sz= Armv2[0]
  for (i=0; i < sz; i++) {
  <<" $Armv2[i] \n"
  <<[C]" $Armv2[i] \n"
  }

<<[C]"\n//// $sz Arms for $np  between $begin $stagenum \n"
 // sz= Armv2[0]
  if (naf >0) {
  for (i=0; i < naf; i++) {
     j= i+5;
  <<[C]" $Armv2[j] \n"
  Farms[Fi] = Armv2[j];
  Fi++;
  }
  }
  








cf(C);


naf = Fi-1;
 if (naf <0)
   naf = 0;
<<"%V $Fi $naf \n"

<<"\nThere were $naf arm_nums found for $np place number \n"

for ( i=0; i< naf; i++) {

<<"$Farms[i] \n"
}

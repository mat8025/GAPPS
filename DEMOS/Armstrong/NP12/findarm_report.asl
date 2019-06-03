//%*********************************************** 
//*  @script findarm_report.asl
//* 
//*  @comment find Armstrong numbers pan version 
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                     
//*  @date Thu Apr 18 07:06:11 2019 
//*  @cdate 1/5/2017 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug.asl"

// option to output to a file

  debugOFF()

  
  opendll("uac");

  na = argc()
//  <<"%V $na\n"
/{
  for (i=0;i<na;i++) {

<<"$i  $_clarg[i]\n"
  }
/}

  mypid = getAslPid();
	  
  int np ;
  np = atoi(_clarg[1])



  pan begin;
  pan endnum;
  pan stagenum;  

  pan step;
  step = 5000000;   

  if (np <= 10) {
       step = 500000;   
  }

  begin = atop(_clarg[2])
  endnum = atop(_clarg[3])

  stagenum = begin + step;   



C= ofw("P_np_${np}_${mypid}.log")


<<[C]"%V $np $begin $endnum\n"

pan diff;
pan Farms[100];
int Fi = 0;  
int naf = 0;

/{
pan Armv[10];

Armv[0] = 47;

Armv[1] = 79

Armv[9] = 85
<<"$Armv[0]  $Armv[1] $Armv[9]\n";

Armv->info(1)
/}


  loop =0;

  double pcdone = 0.0;
  pan pcd;
  float eta_hrs = 0.0
  while (1) {
  loop++;
//<<"[${loop}] %V $np $begin $stagenum\n"
  T = FineTime()

  Armv=findarmstrong(np,begin,stagenum);
//<<"$i done findarm\n"
  dt=FineTimeSince(T)
  
  secs = dt/1000000.0;

 // Armv->info(1) ; // needed else crash

  sz= Caz(Armv);

//<<"%V $sz $Armv[0] \n"
  naf= Armv[1]
  diff = stagenum - begin
  rate = Trunc(diff/secs);
  pcd = stagenum/endnum * 100.0 ;

   eta = (endnum - stagenum)/ diff * secs;
   eta /= 60.0;
   eta_hrs = eta/60.0;
   
   nanosleep(5,10); // cool off cpu
//  pcd->info(1)
  pcdone = pcd
 // <<"pcd $pcd %6.4f $pcdone\n"
//  pcdone->info(1)
  
  //sz= Armv[0]
 // for (i=0; i < sz; i++) {
//  <<" $Armv[i] \n"
//  <<[C]" $Armv[i] \n"
//  }

<<[C]"[${loop}] $naf Arms$np  between $begin $stagenum $diff   $Armv[4]  secs  $secs  nps $rate %6.4f $pcdone%% %d %6.2f $eta_hrs "
  fflush(C);
  
 // sz= Armv[0]
  if (naf >0) {
  for (i=0; i < naf; i++) {
   j= i+5;
  //<<[C]" $Armv[j] \n"
  //<<[D]" $Armv[j] \n"
  //fflush(D)
  E= ofw("np_${np}_$Armv[j]")
//  <<[E]" $Armv[j] \n"
  cf(E)
  Farms[Fi] = Armv[j];
  Fi++;
  }
  }
  
   begin = stagenum;
   stagenum = begin + step;   

   

//<<"[${loop}] $naf Arms$np  btw $begin $stagenum $diff  $Armv[4]    $secs secs   $rate nps Found $Fi %6.2f $pcdone%% "
  // <<"%V $np $begin $stagenum $naf $Fi\n"
   if (Fi >0) {
    for ( i=0; i< Fi; i++) {
    //<<"<$Farms[i]> "
    <<[C]" <$Farms[i]> "
    }

   }
    <<[C]"\n"
//<<"\r"
fflush(1)
   if (begin >= endnum) {
        break
   }

//ans=iread("->")
}

cf(C);



D= ofw("P_np_${np}_${mypid}_nums")
<<[D]"There were $Fi arm_nums found \n"

for ( i=0; i< Fi; i++) {
<<[D]"$i $Farms[i] \n"
}

cf(D);
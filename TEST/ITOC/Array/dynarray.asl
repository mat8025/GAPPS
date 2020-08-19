//%*********************************************** 
//*  @script dynarray.asl 
//* 
//*  @comment test dynamic arrays 
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
 
 myScript = getScript()
<<"$myScript\n"

//include "debug.asl"
//include "hv.asl"


proc changeDir(str td)
{
  //<<" $_proc $td\n"
  chdir(td)
  Curr_dir = getDir();
}
//===============================

 
  chkIn(_dblevel); 

Curr_dir = "XYZ"

<<"%V$Curr_dir\n"

  dir = getDir()

<<"%V$dir\n"


   changeDir(dir)

<<"$Curr_dir\n"




int ival;
  
  ival->info(1)

  ival = 3;

 <<"%V $ival \n"

 ival->info(1)





  chkN(ival,3)

 i =0
 na = argc()

while (i < na) {
 wt = _argv[i]
<<"[${i}] $wt\n"
i++
}



  int IVD[];

  sz = Caz(IVD);
  <<"%V $sz\n";


  int IVF[5];

  sz = Caz(IVF);
  <<"%V $sz\n"; 

  IVF->info(1)

 chkN(sz,5);

  IVF[2] = 74;

<<"$IVF\n"
 IVF->info(1)

  int IV[>6];
  sz = Caz(IV);
  <<"%V $sz\n"; 

  IV->info(1)

  chkN(sz,6);


  IV[1] = ptan("AT");
  <<"$IV\n"; 
 
  chkN(IV[1],85);
  IV[5] = ptan("Ac");
  <<"$IV\n"; 
 
  chkN(IV[5],89);
 
  float FV[5];
 
  FV[2] = ptan("Rh");
 
  sz = Caz(FV);
  <<"%V$sz\n"; 
  
  <<"$FV\n"; 
 
  chkR(FV[2],45);
 
  chkOut(); 
 
  exit(); 

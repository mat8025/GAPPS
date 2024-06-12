//%*********************************************** 
//*  @script clargs.asl 
//* 
//*  @comment test clargs  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.98 C-He-Cf]                               
//*  @date Tue Dec 22 20:58:56 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


chkIn()
na= argc()
<<"there are $na Cl args\n"


 k = _clarg[1];
 <<"arg1 is $k\n"

 j = atoi(_clarg[1])
 
 <<"arg1 is $j\n"


  k->info(1)
  j->info(1)


 for (i = 0; i < argc() ; i++) {
<<"$i $_clarg[i] \n"
 }

chkT(1)
chkOut()
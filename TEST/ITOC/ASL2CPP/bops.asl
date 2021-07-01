//%*********************************************** 
//*  @script bops.asl 
//* 
//*  @comment test basic ops  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Thu Mar  7 23:24:30 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
   
//#include "debug"
   
//debugOFF()
   
   chkIn(_dblevel);
   
//prog= GetScript()
   
   int n1 = 1;
   
   <<"%V $n1 \n";
   
   chkN(n1,1);
   
   
   n1++;
   
   <<"%V $n1 \n";
   
   chkN(n1,2);
   
// a comment line
   
   
   ++n1;
   
   <<"%V $n1 \n";
   
   chkN(n1,3);
   
   
   
   n1 += 2;
   
   chkN(n1,5);
   
   
   
   exit();
   
  //////////////////////////////////////////

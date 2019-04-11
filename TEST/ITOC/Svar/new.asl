//%*********************************************** 
//*  @script svar_declare.asl 
//* 
//*  @comment test list declare 
//*  @release CARBON 
//*  @vers 1.40 Zr Zirconium                                              
//*  @date Mon Jan 21 07:00:39 2019 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
#
   
#include "debug.asl"
   
   debugON();
   
   
   setdebug (1, @pline, @~step, @trace, @soe) ;
   
   civ = 0;
   
   cov= getEnvVar("ITEST"); 
   if (! (cov @=""))
   {
     civ= atoi(cov); 
     <<"%V $cov $civ\n"; 
     }
   
   checkIn(civ); 
   
   
   str le;
   
   Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;
   
   <<"$(typeof(Mol)) size $(caz(Mol))  \n"; 
   
   <<"List is $Mol \n"; 
   
   sz = caz(Mol); 
   
   <<"%V$sz\n";
   
   checkNum(sz,12); 
   
   
   <<"first month $Mol[0]\n"; 
   
   <<"second month $Mol[1]\n"; 
   
   <<"twelveth month $Mol[11]\n"; 
   
   le12 = Mol[11];
   
   <<"$(typeof(le12)) %V$le12\n"; 
   
   le = Mol[0]; 
   
   <<"$(typeof(le)) %V$le\n"; 
   
   checkStr(le,"JAN"); 
   
   <<"le checked\n"; 
   
   checkStr(Mol[0],"JAN"); 
   
   <<"Mol[0] checked\n"; 
   
   le = Mol[1]; 
   <<"%V$le $Mol[1] checked\n"; 
   <<"$(typeof(le)) \n"; 
   
   
   checkStr(le,"FEB"); 
   
   <<"$(typeof(le)) %V$le\n"; 
   
   checkStr("FEB",Mol[1]); 
   
   <<"$Mol[1] Mol[1] checked\n"; 
   
   checkStr(Mol[1],"FEB"); 
   
   
//checkProgress()
   
   <<" DONE Lists \n"; 
//////////////////////////////////
   
   
   Svar Mo[] = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }
//Svar Mo = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }
  
  
  <<" Mo $(typeof(Mo)) \n"; 
  
  sz= Caz(Mo); 
  
  <<" Mo %V$sz \n"; 
  
  <<"$Mo[0] \n"; 
  
  <<"$Mo[1] \n"; 
  
  for (i = 0; i < 12 ; i++) {
  
  <<"$i $Mo[i] \n"; 
  
  }
  
  checkStr(Mo[0],"JAN"); 
  
  checkStr(Mo[11],"DEC"); 
  
  
  int A[] = {0,1,2,3,4,5,6,7,8}
  
  <<"$A\n"; 
  
  <<"sz $(Caz(A)) cab $(Cab(A))\n"; 
  
  checkNum(A[1],1); 
  checkNum(A[8],8); 
  
  
  IV= vgen(INT_,20,0,1); 
  
  <<"$IV \n"; 
  
  
  svar S; 
  
  S->info(1); 
  
  T= itoa(IV) ; // does not deliver svar array 
  
  T->info(1); 
  <<"$T\n"; 
  
  M=Split("$IV"); 
  M->info(1); 
  <<"$M \n"; 
  
  <<"$M[3] $M[7]\n"; 
  
  IV2= atoi(M); 
  
  <<"$IV2\n"; 
  
  IV2->Info(1);
  
  
  R= M[3::]; 
  
  <<"$R \n"; 
  R->info(1); 
  
  IV3= atoi(R); 
  
  <<"$IV3\n"; 
  checkNum(IV3[0],3); 
  
  IV3 *= 2;
  
  checkNum(IV3[0],6); 
  
  <<"$IV3\n"; 
  
//M[3::] = atoi(IV3)
  M[0] = 47; 
  <<"$M\n"; 
  checkStr(M[0],"47"); 
  R[0] = 79; 
  R[1] = 80; 
  R[2] = 82; 
  checkStr(R[0],"79"); 
  
  M[3:6:] = R[0:3:]; 
  
  checkStr(M[3],"79"); 
  checkStr(M[4],R[1]); 
  checkStr(M[4],"80"); 
  checkStr(M[5],"82"); 
  
  
  <<"$R\n"; 
  <<"$M\n"; 
  
  
//checkOut();
////////////////////
  
  IV4=vgen(INT_,10,45,1); 
  <<"$IV4\n"; 
  
  checkNum(IV4[0],45); 
  checkNum(IV4[1],46); 
  
  <<"$IV3\n"; 
  
  
  IV3[3:12:1] = IV4[0:9:];
  checkNum(IV3[0],6); 
  
  checkNum(IV3[3],45); 
  checkNum(IV3[4],46); 
  
  
  <<"$IV3\n"; 
  
  IV4 = IV3; 
  IV4[3:12:1] = 52;
  
  <<"$IV4\n"; 
  
  IV3[3:12:1] *= 2;
  
  <<"$IV3\n"; 
  
  
  IV3= atoi(M); 
  
  <<"$IV3\n"; 
  
  IV3->Info(1);
  
  IV3= atoi(M[3::]); 
  
  <<"$IV3\n"; 
  
  IV3->Info(1);
  
  checkNum(IV3[0], 79); 
  
  if (IV3[0] == 79) {
  <<"OK $IV[0:-1:2] \n"; 
  }
  
  
  checkOut(); 

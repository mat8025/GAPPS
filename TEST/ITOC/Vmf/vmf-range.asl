//%*********************************************** 
//*  @script vmf-range.asl 
//* 
//*  @comment  test vmf range set operation 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.51 C-He-Sb]                                
//*  @date Sun May 24 09:12:16 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///
///
   
   checkIn();

   int n;

   n->info(1);

   int M[10];

   M->info(1)

   int  P[>10];

   P->info(1)
   
   int J[]; 


   J->info(1)
   
   <<"$(Cab(J)) \n"; 

   
   <<"$J \n"; 
   checkNum(M[0],0)
   checkNum(M[9],0)   
   checkNum(P[0],0)
   checkNum(P[9],0)   
   checkNum(J[0],0)
  

   J[0:19:2]->set(10,1); 

   J->info(1)

   <<"$J \n"; 
   
   checkNum(J[0],10);
   
//checkOut();exit()
   
   J[0:7] = 6; 
   
   checkNum(J[0],6); 
   checkNum(J[7],6); 
   
   <<"$J \n"; 
   
   
   J[-1:1:-2] = 35;
   
   <<"$J \n"; 
   
   checkNum(J[19],35); 
   checkNum(J[1],35); 
   
   
   checkOut(); 
   
   
//////////////////////////////////
///  TBCDF
///  TBF  pic lic of  J[0:19:2]->set(10,1)  repeats section
///  but xic works?
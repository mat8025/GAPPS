//%*********************************************** 
//*  @script svar.asl 
//* 
//*  @comment test svar dec/assign reassign 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue May 14 09:06:45 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

   include "debug"; 
   debugON(); 
   
   
   checkin(); 
   setdebug(1,@pline,@keep,@trace); 
   
   svar  S = "una larga noche"; 
   
   <<"%V $S\n"; 
   
   <<" $(typeof(S)) $(Caz(S)) \n"; 
   
   S[1] = "el gato mira la puerta"; 
   
   S[2] = "espera ratones"; 
   
   <<"%V $S[2] \n"; 
   
   
   svar E[] = { "the first ten elements are:", "H", "He", "Li", "Be" ,"B" ,"C", "N", "O", "F", "Ne"  };
   
   
   <<"$E\n"; 
   <<"$E[1] \n"; 
   
   checkStr(E[1],"H"); 
   
   <<"$E[2] \n"; 
   
   <<"$E[3:6] \n"; 
   
   
   W= E[3:7];
   
   <<"$(typeof(W)) \n"; 
   <<"$W\n"; 
   
   <<"$W[1]\n"; 
   checkStr(W[1],"Be");
   
   W[3:4] = E[7:8];
   
   
   <<"%V$W \n"; 
   
   T= E[1:9]; 
   
   <<"$T\n"; 
   sz=T->Caz(); 
   <<"$sz\n"; 
   
   checkNum(sz,9); 
   
   T= E[4:9]; 
   
   <<"$T\n"; 
   T->info(1)
   sz=T->Caz(); 


   <<"$sz\n";


   R= E[4:9]; 
   
   <<"$R\n"; 
   R->info(1)
   sz=R->Caz(); 


   <<"$sz\n"; 
   
   checkNum(sz,6); 
   
   
   checkOut(); 

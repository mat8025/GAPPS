//%*********************************************** 
//*  @script rrdyn.asl 
//* 
//*  @comment test record dynamic expansion 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Mon Feb 17 08:12:54 2020 
//*  @cdate Mon Feb 17 08:12:54 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
   include "debug"; 
   debugON(); 
   
   
   filterFuncDebug(ALLOWALL_,"xxx");
   filterFileDebug(ALLOWALL_,"yyy");
   
   setdebug(1,@pline,@trace,@keep); 
   
   checkin(); 
   Record R[>2] ;
   
   
   proc recspecs()
   {
     cb = Cab(R); 
     sz= Caz(R); 
     <<"%V$sz $cb\n"; 
     R->info(1); 
     }
   
   recspecs(); 
   
   R[0] = Split("Ich gehe jeden Tag"); 
   
   recspecs(); 
   
   <<"$R\n"; 

    checkStr(R[0][3],"Tag")
    
    R[1] = Split("Je marche tous les jours")

    recspecs(); 

   <<"$R\n"

    checkStr(R[1][2],"tous")

   R[2] = Split("Camino todos los dias")

    recspecs(); 

   <<"$R\n"
   
    checkStr(R[2][1],"todos")


   R[3] = Split("Gym five days a week")

    recspecs(); 

   <<"$R\n"

   checkStr(R[3][0],"Gym")
   


   R[15] = Split("Necesito correr más")

    recspecs();

   <<"$R\n"
   
   checkStage(); 
   checkProgress("How Good"); 
   checkOut(); 
   

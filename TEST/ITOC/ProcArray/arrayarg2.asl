//%*********************************************** 
//*  @script arrayarg2.asl 
//* 
//*  @comment test proc array args 
//*  @release CARBON 
//*  @vers 1.37 Rb Rubidium                                               
//*  @date Mon Jan 21 06:40:50 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
   
   include "debug.asl"; 
   
   debugON();
   
  // setdebug (1, @pline, @~step, @~trace,@break,57) ;
   setdebug (1, @pline, @~step, @~trace,) ;
   FilterFileDebug(REJECT_,"~storetype_e");
   FilterFuncDebug(REJECT_,"~ArraySpecs",);
   
   civ = 0;
   
   cov= getEnvVar("ITEST"); 
   if (! (cov @="")) {
     civ= atoi(cov); 
     <<"%V $cov $civ\n"; 
     
     }
   
   checkIn(civ); 
aaa: <<"aaa label !\n"

<<"b4 break point !\n"

//~b <<"at my break point !\n"
//~b   <<" this is the  brk_pt \n" ; // needs to stop before executing this statement

~c <<" this is the  brk_pt \n" ; // needs to stop before executing this statement

<<"after break point !\n"

   proc foo(int vec[],k)
   {
     vec->info(1); 
     k->info(1);
     Z->info(1) ;
     
<<"IN $vec \n"; 
<<"IN  %V $Z\n"

      vec[1] = 47; 
      vec[2] = 79;
      vec[3] = 80;      
      vec->info(1); 


/{/*     

     vec[3] = 80
     vec[4] = 78
     vec[5] = 50
/}*/     
     <<"OUT %V $vec \n";
     <<"OUT %V $Z\n"

     rvec = vec;
     //<<"OUT %V $rvec \n"; 
     return rvec; 
     }
   
///////////////  Array name ////////////////////////////////////////
   Z = Vgen(INT_,10,0,1); 
   
   <<"init $Z\n"; 
   
   Z[0] = 36; 
   Z[1] = 53; 
   Z[9] = 28; 
   
  <<"before calling proc $Z\n"; 
   
   Y=foo(Z,3); 
   
   <<"after calling proc $Z\n"; 

    Z->info(1)
   
   checkNum(Z[1],47);
   checkNum(Z[2],79);
   checkNum(Z[3],80);       
   
   checkNum(Z[9],28); 
   
   <<"Array Name return vec $Y\n"; 
   
   checkStage("ArrayName"); 


///////////////  &Array ////////////////////////////////////////
   
//  showStatements(1)
//iread()
   
   
   Z = Vgen(INT_,10,0,1); 
   
   Z[0] = 36;
   Z[1] = 53;    
   Z[9] = 28; 
   
 // Z[0] = 36  // FIX TBD last element offset is being used as function para offset!!
   

   <<"preZ $Z\n"; 

    Z->info(1); 

// Y = foo(&Z,3)  // TBF-------- Y 

    Y = foo(&Z[0],3)  // FIXED -------- Y is now created correctly with the return vector; 
   
   <<"postZ $Z\n"; 

   Z->info(1); 
   
   checkNum(Z[1],47);
   checkNum(Z[2],79);
   checkNum(Z[3],80);      
   checkNum(Z[9],28); 
   
   checkStage("&Array");



   
   Z = vgen(INT_,10,0,1); 

   Z[0] = 36;
   Z[1] = 53;    
   Z[9] = 28; 
   
   <<"preZ $Z\n"; 
   
   Y2= foo(&Z[3],4); 
   
   <<"postZ $Z\n";
   
~c <<" this is the  brk_pt \n" ; // needs to stop before executing this statement   

   checkNum(Z[4],47);
   checkNum(Z[5],79);
   checkNum(Z[6],80);      

   checkNum(Z[9],28);
   
   checkStage("&Array[3]"); 



   <<"return Y2 vec $Y2\n";
   
   checkNum(Y2[1],47);
   checkNum(Y2[2],79);    
   checkNum(Y2[6],28);


   checkStage("ArrayReturn"); 
   
   
   checkOut();    exit(); 

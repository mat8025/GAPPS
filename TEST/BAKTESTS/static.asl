//%*********************************************** 
//*  @script static.asl 
//* 
//*  @comment  test static statement 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.51 C-He-Sb]                                
//*  @date Sun May 24 14:51:20 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
   <<"running $myScript\n"
   
// test static statement
   
   
   checkIn(_dblevel);
//   checkIn(1); 
   
   proc  Foo ( x)
   {
     static int a = 0;
     a->info(1)
     
     <<" entered $_proc %V$a \n"; 
     
     a++;
     A++;
     
     <<"exiting $_proc %V$a $A\n"; 
     checkNum(a,A); 
   }
   
   int A =0;
   
   
   Foo(); 
   
   checkNum(A,1); 
   
   
   Foo(); 
   
   checkNum(A,2); 
   
   
   Foo(); 
   
   checkNum(A,3); 
   
   
   Foo(); 
   
   checkNum(A,4); 
   
   
   checkOut(); 

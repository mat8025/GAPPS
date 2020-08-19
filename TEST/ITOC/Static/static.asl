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
   
   
   chkIn(_dblevel);
//   chkIn(1); 
   
   proc  Foo ( x)
   {
     static int a = 0;
     a->info(1)
     
     <<" entered $_proc %V$a \n"; 
     
     a++;
     A++;
     
     <<"exiting $_proc %V$a $A\n"; 
     chkN(a,A); 
   }
   
   int A =0;
   
   
   Foo(); 
   
   chkN(A,1); 
   
   
   Foo(); 
   
   chkN(A,2); 
   
   
   Foo(); 
   
   chkN(A,3); 
   
   
   Foo(); 
   
   chkN(A,4); 
   
   
   chkOut(); 

//%*********************************************** 
//*  @script static.asl 
//* 
//*  @comment  test static statement 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.98 C-He-Cf]                           
//*  @date Wed Dec 23 10:28:22 2020 020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

   <<"Running $_script\n"
   
// test static statement
   
   
   chkIn(_dblevel);

   
   void  Foo ()
   {
     static int a = 0;

     a->info(1)
     
     <<" entered $_proc %V$a \n"; 
     
     a++;
     A++;


     if (a == A) {
<<"static int has increased correctly %V$a $A\n"; 
     }
     if (a > 1) {
<<"static int has increased  %V$a $A\n"; 
     }

     <<"exiting $_proc %V$a $A\n"; 
     chkN(a,A); 
   }

   int b = 7;

   b->info(1);

   int A =0;

   A->info(1);
   
   Foo(); 




   chkN(A,1); 
   
   
   Foo(); 
   
   chkN(A,2); 
   
   
   Foo(); 
   
   chkN(A,3); 
   
   
   Foo(); 
   
   chkN(A,4); 
   
   
   chkOut(); 

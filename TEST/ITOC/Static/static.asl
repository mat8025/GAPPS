/* 
 *  @script static.asl 
 * 
 *  @comment test static statement 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.61 C-Li-Pm] 
 *  @date 11/23/2021 12:51:01          
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

                                                                   

 //  <<"Running $_script\n"
   
// test static statement
<|Use_=
   Demo  of static statement  ;
///////////////////////
|>

#include "debug"

    if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

ignoreErrors();

   chkIn();

   
   void  Foo ()
   {
     static int a = 0;

     a.pinfo()
     
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

   b.pinfo();

   int A =0;

   A.pinfo();
   
   Foo(); 




   chkN(A,1); 
   
   
   Foo(); 
   
   chkN(A,2); 
   
   
   Foo(); 
   
   chkN(A,3); 
   
   
   Foo(); 
   
   chkN(A,4); 
   
   
   chkOut(); 

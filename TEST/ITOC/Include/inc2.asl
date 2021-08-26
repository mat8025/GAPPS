/* 
 *  @script inc2.asl 
 * 
 *  @comment nested include 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.49 C-Li-In]                                
 *  @date 08/21/2021 16:14:54 
 *  @cdate 08/21/2021 16:14:54 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//


   <<"inc2 including %V $_include $_scope \n"; 
   
   <<"inc2 sees globals %V $A $X\n"; 
   
   float Y = 2.2345;
   
   <<"inc2 adds global %V$Y\n"; 
   
   proc Goo(int a, int b)
   {
     
     c= a*b;
     <<"$_proc $a * $b = $c\n"; 
     return c;
     }
   
   #include "inc3";
   
   <<"included $_include _scope \n"; 
   

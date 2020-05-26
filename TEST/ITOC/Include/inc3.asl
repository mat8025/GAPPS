//%*********************************************** 
//*  @script inc3.asl 
//* 
//*  @comment test nested include 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.50 C-He-Sn]                               
//*  @date Fri May 22 08:12:54 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
   myScript = getScript();
   

   <<"start including  inc3\n"; 
   
   <<"inc3 sees globals %V $A $X $Y\n"; 
   
 #define C_YELLOW 6
   float Z = 3.2345;
   
   <<"inc3 adds global %V$Z\n"; 
   
   proc Hoo(real a, real b)
   {
     
     c= a/b;
     <<"$_proc $a / $b = $c\n"; 
     return c;
     }
   
   
   <<"included $_include  _scope \n"; 
   

   
   <<"ignored repeated include\n"; 

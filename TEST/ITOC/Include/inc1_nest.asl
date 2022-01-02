//%*********************************************** 
//*  @script inc1_nest.asl 
//* 
//*  @comment test nested includes 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium [asl 6.2.50 C-He-Sn]                             
//*  @date Fri May 22 07:59:16 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
;
myScript = getScript();
//////////////

<<"start including  nest \n"

#define C_YELLOW 6

<<"$_include sees global %V$A\n"

float X = 1.2345;
<<"$_include adds global %V$X\n"


proc Doo(int a,int b)
{
   c= a+b;
<<"$_proc $a + $b = $c\n"
  return c;
}


proc Foo(int a,int b)
{
   c= a+b;
<<"$_proc $a + $b = $c\n"
  return c;
}


proc Boo(int a,int b)
{
   c= a-b;
<<"$_proc $a - $b = $c\n"
  return c;
}


#include "inc2" ; // nested include

<<"inc2 added global %V$Y\n"

<<"included $_include \n"


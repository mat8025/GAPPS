/* 
 *  @script tranf.asl 
 * 
 *  @comment test transcendental SF 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.6 C-Li-C]                                 
 *  @date Mon Jan  4 17:38:14 2021 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

//
// test Sin function
//

chkIn()

 a = 1.0;

 a = Sin(0.5)

<<"%V $a = Sin(0.5) \n"
   b = Asin(a)

<<"%V $b = Asin(0.4794) \n"

chkR(0.5,b)

<<"%V $a = $(Sin(0.5)) \n"

 a = Cos(0.5)

<<" $a = $(Cos(0.5)) \n"
 b = Acos(a)

<<"%V $b = Asin(a) \n"


chkR(0.5,b)



 a = Tan(0.5)
<<"Tan $a = $(Tan(0.5)) \n"

 a = Log(0.5)
<<"Log(0.5) $a = $(Log(0.5)) \n"
 a = atan(1.0)
<<"atan(1.0) $a = $(atan(1.0)) $(4*a)\n"
 y = 27.0;
 a = cbrt(y)

<<" cbrt($y) $a = $(cbrt(27.0)) $(cbrt(y))\n"

chkOut()


/*
  add more tests

*/
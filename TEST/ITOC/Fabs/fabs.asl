/* 
 *  @script fabs.asl 
 * 
 *  @comment test fabs function 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.6 C-Li-C]                                  
 *  @date Wed Jan  6 09:10:09 2021 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
///
///



chkIn(_dblevel)

// bug in arg passing??

  double y = 1234.123456

  x= fabs(y)

<<"%V $x  $y\n"

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  chkR(x,y,6)


  y = 123456.123456

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  chkR(x,y,6)


  y = 123456789.123456

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  chkR(x,y,6)

chkOut()
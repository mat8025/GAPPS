/* 
 *  @script ddtodms.asl 
 * 
 *  @comment test decimal degree to dms
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.7 C-Li-N]                                  
 *  @date Wed Jan  6 09:31:44 2021 
 *  @cdate 9/9/2022
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */



double d = 156.742;


 Str dms = ddtodms(d)

<<"%V $d $dms \n"




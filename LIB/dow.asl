//%*********************************************** 
//*  @script dow.asl 
//* 
//*  @comment get day of week for a date 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Sun Mar 24 08:02:49 2019 
//*  @cdate Sun Mar 24 08:01:39 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///



 dt= _clarg[1];


 jd = julian(dt);

 jdt = julmdy(jd);

 day= julday(jd)
 
<<"$dt $jd $jdt $day\n"
/* 
 *  @script ddtodms.asl                                                 
 * 
 *  @comment test decimal degree to dms                                 
 *  @release Beryllium                                                  
 *  @vers 1.3 Li Lithium [asl 6.4.67 C-Be-Ho]                           
 *  @date 09/10/2022 10:23:48                                           
 *  @cdate 9/9/2022                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  


  double d = 156.742;

  Str dms = ddtodms(d);

  double e = dmstodd(dms);

  Str dm = ddtodm(d);

  <<"%V $d $dms $e $dm\n";

   dlat = 38.67252;
  
   dmlat = ddtodm(dlat);

  <<"lat $dlat $dmlat\n";

   dlng = 105.33602;
  
   dmlong = ddtodm(dlng);

  <<"%V $dlat $dlng  $dmlat $dmlong \n";


;//==============\_(^-^)_/==================//;

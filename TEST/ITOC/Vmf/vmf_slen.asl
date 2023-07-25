/* 
 *  @script vmf_slen.asl                                                
 * 
 *  @comment test slen vmf                                              
 *  @release Carbon                                                     
 *  @vers 1.2 He Helium [asl 5.6 : B C]                                 
 *  @date 07/24/2023 21:44:41                                           
 *  @cdate Tue Mar 12 07:50:33 2019                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//           


Str Use_= "Demo  of slen "

                                                               

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


Str s = "just keep trying!"


   len = slen(s)

<<"$len $s \n"

   len = s.slen()


<<"$len $s \n"


exit()

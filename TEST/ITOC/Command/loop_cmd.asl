/* 
 *  @script loop_cmd.asl 
 * 
 *  @comment test command in loop  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.18 C-Li-Ar]                                
 *  @date Mon Feb  8 20:26:33 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"

  chkIn()
  int k = 0;
  while (1) 
  {


  k++;
dc= !!"date "
  

  <<"$dc count is $k\n"

//    T=FineTime()
//    <<" time is : $T\n"
      sleep(0.5)

     if (k > 3 )
           break
  }
  chkN(k,4)
  chkOut()
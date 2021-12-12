/* 
 *  @script task.asl  
 * 
 *  @comment task-planner 
 *  @release CARBON 
 *  @vers 4.19 K Potassium [asl 6.3.66 C-Li-Dy] 
 *  @date 12/11/2021 15:41:26          
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

//        this should stay at line 15


<|Use=
compute task distance
  e.g  asl anytask.asl   gross laramie mtevans boulder  LD 40
///////////////////////
|>

#include "debug"

  ignoreErrors();

  if (_dblevel >0) {

  debugON();

  <<"$Use_\n";

  }

  ignoreErrors();

chkT(1)


chkOut()


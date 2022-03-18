/* 
 *  @script wex.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 2.52 Te Tellurium [asl 6.3.38 C-Li-Sr] 
 *  @date 07/02/2021 15:24:19 
 *  @cdate Fri Jan 1 08:00:00 2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
       

#include "debug"
<<"after debug\n";
#include "hv"
<<"after hv\n";
//if (_dblevel >0) {
//    debugON()
//   }


#include "wex_rates"

allowErrors(-1)
_DB =-1;

//<<"%V$vers $ele_vers\n"




//#define DBPR  ~!

wexdir = "./"

chdir(wexdir)


chkT(1)
chkOut()

exit()
//wherearewe=!!"pwd "

//<<[_DB]"%V$wherearewe \n"

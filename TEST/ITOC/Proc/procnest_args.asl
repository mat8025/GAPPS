/* 
 *  @script procnest_args.asl  
 * 
 *  @comment test arg passing in nested proc calls 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.70 C-Li-Yb]                               
 *  @date 01/10/2022 09:42:49 
 *  @cdate 01/10/2022 09:42:49 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2022 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of test arg passing in nested proc calls 
/////////////////////// 
|>


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

   long sc_startday = 223345;

   long sc_endday =  223375;


  sc_startday.pinfo();
    sc_endday.pinfo();
  


void   drawGoals(int ws)
{

<<"$_proc   $ws \n"

int k = ws;
<<"%v $k\n";

}
//=====================//

void drawScreens()
{
    int ws = 0;
//<<" $_proc \n"
<<"%V $sc_startday  $sc_endday \n"

    sc_startday.pinfo();
    sc_endday.pinfo();

   showWL(sc_startday ,sc_endday )

   drawGoals(0);

    //drawGoals(ws);
   
<<"%V $sc_startday  $sc_endday \n"

    sc_startday.pinfo();
    sc_endday.pinfo();

}
//=====================//

void showWL(long ws, long we)
{

<<"$_proc $ws $we\n"

       computeWL( ws, we);
}

//=====================//

void computeWL(long ws, long we)
{

<<"$_proc $ws $we\n"

   long dur;
   dur = we-ws;
   <<"%V $dur \n"
       
}
//=====================//


  drawScreens();

    sc_startday.pinfo();
    sc_endday.pinfo();

  chkN(sc_startday,223345);
    chkN(sc_endday,223375);

  drawScreens();

    sc_startday.pinfo();
    sc_endday.pinfo();

  chkN(sc_startday,223345);
  chkN(sc_endday,223375);

///
  chkOut( sc_startday, );
  exit();
;///--------(^-^)--------///

/* 
 *  @script ptr.asl 
 * 
 *  @comment test return type vs proc args 
 *  @release CARBON 
 *  @vers 1.1 N Nitrogen [asl 6.3.61 C-Li-Pm] 
 *  @date 11/23/2021 12:16:24          
 *  @cdate Sun Nov 26 07:58:27 AM MST 2023
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///  ptr tests
///


#include "debug"

   if (_dblevel >0) {

      debugON();



     }

 showUsage("Ptr Demo")


chkIn(_dblevel);

  x =7;

  x.pinfo()

   Arglist=testargs(1,"hey",4)
<<"%(1,,,\n)$Arglist\n"


  fileDB(ALLOW_,"spe_declare,spe_func,spe_scopesindex,spe_exp,rdp_store,ds_store");
  
  xp = &x;

  xp.pinfo()


  yp = xp

  yp.pinfo()


   // use $  deref ?


    z = $xp


    z.pinfo()
    chkN(z,7)


   ap = "x"
   ap.pinfo()
   w = $ap

   w.pinfo()

    chkN(w,7)

  chkOut();
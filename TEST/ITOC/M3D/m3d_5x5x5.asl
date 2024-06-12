/* 
 *  @script m3d_5x5x5.asl 
 * 
 *  @comment test multi dim 3 
 *  @release CARBON 
 *  @vers 1.5 B Boron [asl 6.3.59 C-Li-Pr] 
 *  @date 11/14/2021 09:04:56          
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */
 
///
///
///

Str Use_= "   Demo  of MD3";
///////////////////////


#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

// filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
// filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");
// filterFuncDebug(REJECT_,"vrealloc","Svar","init");

   ignoreErrors();

   chkIn();

   N = 5;

   P = 5;

   L = 5;

   int G[] = {1,2,3};

   <<"%V$G\n";

   int M[N][P][L];
   <<"%V $M[0][0][1]  \n";

   <<"%V $M[0][1][1]  \n";

   M[1][0][0] = 65;

   mval =   M[1][0][0];
   

   M.pinfo();

<<"$M\n";



 for (i3 =0; i3 < N ; i3++) {

      j =0;

      for (i2 = 0; i2 < P ; i2++) {

        for (i1 = 0; i1 < L ; i1++) {
             
               M[i3][i2][i1] = j++;
         }

        }


      }


   <<"%2d$M\n";

!a

 M[0:2:1][1:3:1][2:4:2] = 76;
 

 <<"%2d$M\n";

!a


   <<"%V $M[0][1][2]  \n";


<<"//////////////////////////////\n"





   M[2:4:1][1:3:1][2:4:2] = 67;

   <<"%2d$M\n";
!a
   chkOut();

//===***===//

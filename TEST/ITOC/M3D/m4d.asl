/* 
 *  @script m4d_5x5x5x5.asl 
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

Str Use_= "   Demo  of MD4";
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

   chkIn(_dblevel);

   N = 3;

   P = 5;

   L = 5;

   Q = 5;

   int G[] = {1,2,3};

   <<"%V$G\n";

   int M[N][P][L][Q];
   <<"%V $M[0][0][1][2]  \n";

   <<"%V $M[0][1][1][3]  \n";

   M[0:2:1][0][0][0] = 65;
   M[0:2:1][0][0][4] = -65;   
   M[0:2:1][1][0][0] = 66;
   M[0:2:1][1][0][4] = -66;   
   M[0:2:1][2][0][0] = 67;
   M[0:2:1][2][0][4] = -67;   
   M[0:2:1][3][0][0] = 68;
   M[0:2:1][3][0][4] = -68;   
   M[0:2:1][4][0][0] = 69;
   M[0:2:1][4][0][4] = -69;
   
   M[0:2:1][4][4][4] = 57;

   mval =   M[1][4][4][4];
     chkN(mval,57);

   mval = M[2][4][0][0] ;

     chkN(mval,69);

   M.pinfo();


   <<"$M\n";

<<"//////////////////////////////\n"
  mval =  M[1][3][0][0]; 
  chkN(mval,68);

  for (i4 = 0; i4 < N ; i4++) {

     for (i3 =0; i3 < P ; i3++) {

      j =0;

      for (i2 = 0; i2 < L ; i2++) {

        for (i1 = 0; i1 < Q ; i1++) {
             
               M[i4][i3][i2][i1] = j++;
         }

        }


      }

    }


   }
<<"//////////////////////////////\n"

       <<"%2d$M\n";

// !a will alter line numbers

   M[0:1:1][0:1:1][1:3:1][2:4:2] = 76;
<<"//////////////////////////////\n"
   <<"%2d$M\n";

   mval =   M[0][0][1][2];
   <<"M[0][0][1][2]  $mval\n"
     chkN(mval,76);

     mval =   M[0][1][0][2];
   <<"M[0][1][0][2]  $mval\n"     
     chkN(mval,76);


!a
<<"//////////////////////////////\n"
   M[1:2:1][2:4:1][2:3:1][2:4:2] = 71;

   <<"%2d$M\n";
!a


   chkOut();

//===***===//

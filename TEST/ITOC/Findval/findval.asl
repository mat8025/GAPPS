/* 
 *  @script findval.asl                                                 
 * 
 *  @comment test findval SF                                            
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.28 : C Ni]                            
 *  @date 06/13/2024 14:33:19                                           
 *  @cdate 1/1/2002                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

///
///
///
# test ASL function findval
#include "debug.asl";
#include "hv.asl";

   if (_dblevel >0) {

        debugON();

   }

   chkIn();
////  debug ON

   db_allow =0;

   allowDB("ic,spe_proc",db_allow);

   <<"hey mark onward ever upward - $Hdr_vers\n";

   the_ele = vers2ele(Hdr_vers);
//!a

   ans=ask("%V $the_ele",0);

   chkT(1);

   Csum=vgen(FLOAT_,10,0);

   Csum[4] = 1;

   <<"$Csum\n";

   ivec = findVal(Csum,0,0,-1,1,0,LT_);

   le = ivec[0];

   if (le == -1) {

        le = 0;

   }

   <<"%V $ivec $le\n";

   chkN(le,4);

   ivec = findVal(Csum,0,0,-1,1,0,"<");

   le = ivec[0];

   if (le == -1) {

        le = 0;

   }

   <<"%V $ivec $le\n";

   chkN(le,4);

   I= Igen(20,0,1);

   <<" $I \n";
//<<" $I[3:7] \n"

   int fi;

   int si = 0;
//int found[];
//found.info(1)

   found= findval(I,6,si,-1,1,0);

   nd= Cab(found);

   sz = Caz(found);

   <<"%V $nd $sz $(Cab(found))  \n";

   <<"%V $found  \n";

   fi = found[0];

   <<"%V $fi \n";

   chkN(fi,6);
//chkOut(); exit();

   found= findval(I,8,si,-1,1,0);

   nd= Cab(found);

   sz = Caz(found);

   <<"%V $nd $sz $(Cab(found))  \n";

   <<"%V $found  \n";

   fi = found[0];

   <<"%V $fi \n";

   chkN(fi,8);

   found= findval(I,6,si,-1,1,LTE_);

   nd= Cab(found);

   sz = Caz(found);

   <<"%V $nd $sz $(Cab(found))  \n";

   <<"%V $found  \n";

   fi = found[0];

   <<"%V $fi \n";

   chkN(fi,6);

   I.pinfo();

   found= I.findval(7,si,-1,-1,1);

   found.pinfo();

   fi = found[0];

   chkN(fi,7);

   <<"%V $fi \n";
//chkOut(1)

   si = 19;

   I.pinfo();

   found= I.findval(17,si,-1,-1,1);

   <<" $(Cab(found))  \n";

   fi = found[0];

   <<"%V $fi \n";

   chkN(fi,-1);

   si = -1;

   found= I.findval(17,si,0,0);

   fi = found[0];

   <<"%V $fi \n";

   chkN(fi,17);

   si = 19;

   found= I.findval(17,si,-1,0);

   <<"%V $fi \n";

   chkN(fi,17);

   si = 19;
//   found= I.findval(17,-1,-1,1,'>=')

   found= I.findval(17,-1,-1,0,1,GTE_);

   nd= Cab(found);

   sz = Caz(found);

   <<"%V $nd $sz $(Cab(found))  \n";

   <<"%V $found  \n";

   <<"%V $fi \n";

   chkN(fi,17);

   F= Fgen(20,0,1);

   <<" $F \n";

   <<" $F[3:7] \n";

   si = 0;

   found= findval(F,8,si,-1,1,0);

   fi = found[0];

   <<"$found $fi \n";

   chkN(fi,8);

   found= F.findval(7,si,-1,1,0);

   fi = found[0];

   <<"$found $fi \n";

   chkN(fi,7);

   chkOut();

   exit();

//==============\_(^-^)_/==================//

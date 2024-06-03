/* 
 *  @script simpleclass.asl 
 * 
 *  @comment test basic class syntax 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.18 : C Ar]                                   
 *  @date 05/30/2024 11:17:15 
 *  @cdate 05/30/2024 11:17:15 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

///
///
///
<|Use_=
   demo some OO syntax/ops
|>

#include "debug"

   if (_dblevel >0) {

        debugON();

        <<"$Use_\n";

   }

   allowErrors(-1);

   chkIn (_dblevel);

  allowDB("spe_proc,spe_vmf,ic",0)

   class Simple {

        public:

        int sa;

        Str pn;

        void Print()
        {

             <<"$sa\n";

             pn = pt(sa);

             <<"$pn\n";
        }

        void Set (int val)
        {
             sa = val;

        }

        int Get ()
        {

             sa.pinfo();   // VMF should leave OBJ on stack
     //    ans=ask("vmf class mbr",1)
             return sa;

        }

        int Getlocalpv ()
        {
             int new_sa;
             new_sa = sa+1;

             <<"%V $sa $new_sa\n";
             return new_sa;
        }

        cmf Simple()
        {

             sa = 19;

             <<"%V$sa\n";

             pn = pt(sa);

             <<"$pn";

        }

   }
//----------------------------------------------

   Simple S;

   S.Set(67);

   S.Print();

   val = S.Get();

   chkN(val,67);

   S.Set(71);

   S.Print();   //  TBF  - xic has two PUSH_OBJ instructions - only one needed

   mval = 63;

   S.Set(mval);

   S.Print();   

   nval = S.Get();
//!i nval

   Simple oa[5];

   mval = 37;

   oa[1].Set(mval);

   nval = oa[1].Get();

   nval.pinfo();

   mval = 79;

   oa[3].Set(mval);

   nval = oa[3].Get();

   nval.pinfo();

   mval = 82;

   wo = 4;

   oa[wo].Set(mval);

   nval = oa[wo].Get();

   nval = oa[wo].Getlocalpv();

   mval = 33;

   wo = 2;

   oa[wo].Set(mval);

   nval = oa[wo].Get();

   nval = oa[wo].Getlocalpv();

   mval = 33;

   wo = 3;

   oa[wo].Set(34);

   nval = oa[wo].Get();

   nval = oa[wo].Getlocalpv();

   nval.pinfo();

   chkOut(1);

//==============\_(^-^)_/==================//

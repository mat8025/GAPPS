/* 
 *  @script arrayarg1.asl 
 * 
 *  @comment test proc array args 
 *  @release CARBON 
 *  @vers 1.40 Zr Zirconium [asl 6.3.59 C-Li-Pr] 
 *  @date 11/11/2021 22:08:16          
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

   
<|Use_=
   Demo  of args  ;
///////////////////////
|>

#include "debug"


   <<"%V $_dblevel\n";



   if (_dblevel > 0) {

     debugON();

     <<"$Use_\n";

     }

   ignoreErrors();

   chkIn(_dblevel);
   
/////////////////////  simple scalar ///////////////////
  db_ask = 0;

   int doo(int a,int b)
   {

     c= a + b;

     <<"%V$c\n";

     return c;
     }
//======================//

   t=doo(3,4);

   <<"$t\n";

   chkN(t,7);

   t=doo(7,8);

   <<"$t\n";

   chkN(t,15);

   t=doo(27,35);

   <<"$t\n";

   chkN(t,62);

   int voo(int vect[])
   {

     <<"$_proc IN $vect \n";

     vect.pinfo();

     vect[1] = 47;

     <<"add 74 $vect \n";

     vect[2] = 79;

     <<"add Au $vect \n";

     vect[3] = 80;

     vect[4] = 78;

     vect[5] = 50;

     z= vect[5];
vect.pinfo();
     <<"OUT $vect \n";

     return z;

     }
//============================

   int voo2(int vect[])
   {

     <<"$_proc IN $vect \n";

     vect.pinfo();

     <<" U: $U \n";
     <<"%V $vect[0] \n"
     <<"%V $vect[1] \n"
     
     vect[1] = 74;

     <<"add Ag vect: $vect \n";

     <<"add Ag U: $U \n";


     vect[2] = 79;

     <<"add Au vect: $vect \n";

     <<"add Ag U: $U \n";


//ans=ask(DB_prompt,db_ask)

     vect[3] = 80;

     vect[4] = 78;

     vect[5] = 50;

     z= vect[1];

     <<"$z\n";

     vect.pinfo();

     <<"OUT vect: $vect \n";

     U.pinfo();

     <<"OUT U: $U \n";

     return z;

     }
//============================

   int roo(int vect[])
   {

     <<"$_proc IN $vect \n";
//Z->info(1)
//<<"pa_arg2 %V$k\n"
     vecp = vect;  ; // creates local copy of vect 

     vecp[1] = 47;

     <<"add 47 $vect \n";

     vecp[2] = 79;

     <<"add Au $vect \n";

     vecp[3] = 80;

     vecp[4] = 78;

     vecp[5] = 50;

     <<"OUT $vecp \n";

     <<"OUT orig entry $vect \n";

     return vecp;

     }
//============================

   Z = Vgen(INT_,10,0,1);

   wt= Z.typeof();

   <<"$wt $(typeof(Z))\n";

   Z[0] = 36;

   <<"$Z\n";

   Z[6] = 28;

   <<"before calling proc\n";

   <<"%V $Z\n";

   Z.pinfo();


   y = voo(&Z);

   <<"%V $y \n";

   <<"%V $Z\n";

   Z.pinfo();

   chkN(Z[1],47);

   chkN(Z[5],50);

   chkN(Z[6],28);
// reset


   U = Vgen(INT_,10,0,1);

   U[1] = 47;

   <<"$U\n";

   W = U;

   <<"pre proc call $U\n";

 // TBD FIX it does not compute the offset - so proc operates on the third element in
   <<"; //////////////////////////////////\nB4 $U\n"
   
//  allowDB("spe_func,spe_proc,rdp_store,ds_store,array_parse")
//  DBaction((DBSTEP_),ON_)

   y = voo2(&U[3]);

   <<"after call voo2 $U\n";

ans=ask(DB_prompt, db_ask)

   uv= U[4];

   <<"%V $uv $U[4]\n";

   chkN(U[4],74);

   chkN(U[7],78);

   chkN(U[8],50);

//ans=ask(DB_prompt,db_ask)

   voo2(W);
   

//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 
 // FIXED ?-------- Y is now created correctly with the return vector 

   W = vgen(INT_,10,0,-1);

   <<"W $W\n";


   Ptr pv ;

   pv.pinfo();
// allowDB("array_parse,spe_exp,spe_args,spe_declare,spe_scope,ic_")
   pv = &W[2];

   pv.pinfo();

   <<"pv $pv\n";
       
  T= voo(pv)

   <<"%V$T\n";

//ans=ask(DB_prompt,db_ask)


   U= voo(W);

   <<"%V$U\n";
//ptr pv = &W


  U= voo(&W[2])


ans=ask(DB_prompt,db_ask)

    U= voo(&W[3])

ans=ask(DB_prompt,db_ask)

  pv.pinfo()







// TBD FIX it does not compute the offset
// - so proc operates on the third element in




   if (Y[1] == 47) {

     <<"Y correct \n";

     }

   else {

     <<"Y wrong \n";

     }


chkOut()


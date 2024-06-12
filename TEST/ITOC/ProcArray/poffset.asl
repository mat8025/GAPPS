/* 
 *  @script poffset.asl                                                 
 * 
 *  @comment check ptr offset code                                      
 *  @release Boron                                                      
 *  @vers 1.2 He Helium [asl 5.79 : B Au]                               
 *  @date 01/31/2024 07:56:45                                           
 *  @cdate Sat Aug 8 14:05:52 2020                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

///
///
///
<|Use_=
   Demo  of poffset;
///////////////////////
|>
#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }
   allowErrors(-1) ;  // keep going 



   db_ask = 0;
   chkIn();

   int voo(int vect[])
   {

     vect.pinfo();

     <<"IN $vect \n" ;  // debug version alters poffset??;



     vect[1] = 47;

     <<"add Ag $vect \n";

     vect[2] = 79;

     <<"add Au $vect \n";

     vect.pinfo();

     vect[3] = 80;

     vect[4] = 78;

     vect[5] = 50;

     z= vect[5];

     vect.pinfo();

     <<"global $W \n";
      W.pinfo()
      
     <<"OUT $vect \n";

     return z;

     }
//[EP]=================

   void Noo(int ivec[])
   {
    // ivec->info(1);
     //Z->info(1);      
////<<"IN %V $ivec \n"; 
//<<"  %V $Z\n"

     ivec[1] = 47;

     ivec[2] = 79;

     ivec[3] = 80;
   //   ivec->info(1); 

     <<"OUT %V $ivec \n";
//<<"OUT %V $Z\n"

     }
//[EP]=================

   Ptr Roo(int ivec[])
   {

     ivec.pinfo();


     <<"IN $_proc %V $ivec \n";

     ivec[1] = 74;

     ivec[2] = 97;

     ivec[3] = 88;

     ivec[4] = 17;

     ivec.pinfo();

     <<"OUT %V $ivec \n";

      // could return a ptr to the amended array
      // which is passed in
      Ptr rp;
      rp.pinfo()
      rp = &ivec[0]
//     rvec = ivec;
     rp.pinfo();
//     <<"OUT %V $rvec \n";

       return rp;
       
     }
////////////  Array name ////////////////////////////////////////

   Z = Vgen(INT_,10,0,1);

  //allowDB("spe_,rdp_,ds_store,array_,ic_")

//  wdb=DBaction((DBSTEP_| DBSTRACE_),ON_)
//<<"$wdb\n"

   W = Z;

   Z.pinfo()
   
  


   <<"init $Z\n";

   <<"%V $W\n";

    
   W.pinfo();


   voo(&W[3]);

   W.pinfo();

   <<"%V $W\n";

ans=ask(DB_prompt,db_ask)


   chkN(W[4],47);

   chkN(W[5],79);

   chkN(W[6],80);




   chkStage(" &W[3] OK? ");


  // exit(-1);


//   Z[0] = 36; 
//   Z[1] = 53; 
//   Z[9] = 28; 
   name_ref = 1;  ; //  this section did crash now OK 

   if (name_ref) {

     <<"before calling proc $Z\n";
//     voo(&Z);  // crash TBF 10/12/21

     voo(Z);  // name only - want to be equiv with &Z  

     <<"after calling proc $Z\n";

     chkN(Z[1],47);

     chkN(Z[2],79);

     chkN(Z[3],80);

     }

   Z = W;

   <<"B4 calling  Roo $W\n";
   
   Ptr Y;

   Y=Roo(&W[3]);

   <<"%V $W\n";

   <<"Y: $Y \n";



   chkStage("PO correct?");

   <<"$Y[1] $Y[2] $Y[3]\n";

   Y.pinfo()
/*
   y1= Y[1];

   <<"%V $y1\n";
ans=ask(DB_prompt,db_ask)
   chkN(Y[1],47);

   chkN(Y[2],79);

   chkN(Y[3],80);

   chkN(Y[4],7);
   
//   chkStage("return ivec correct?")
*/
   chkOut();



/*
   TBD 
   ptr == > ptr ==> vec 
   deref 
   use to copy section of the vec


*/
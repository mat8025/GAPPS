/* 
 *  @script vmf_range.asl 
 * 
 *  @comment test vmf range set operation 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.50 C-Li-Sn] 
 *  @date 09/02/2021 08:57:31 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                              

///
///
///
<|Use_=
Demo  of vmf range
///////////////////////
|>



#include "debug"

if (_dblevel >0) {
   debugON()
    <<"$Use_\n"
}

//filterFileDebug(REJECT_,"scopesindex_e.cpp","array_parse.cpp");
//filterFuncDebug(REJECT_,"~storeSiv","checkProcFunc");

   chkIn(_dblevel);

   int n;

   n.pinfo();

   int M[10];

   M.pinfo()

   int  P[>10];

   P.pinfo()
   
   int J[]; 


   J.pinfo()
   
   <<"$(Cab(J)) \n"; 

   
   <<"$J \n"; 
   chkN(M[0],0)
   chkN(M[9],0)   
   chkN(P[0],0)
   chkN(P[9],0)   
   chkN(J[0],0)

<<"$J\n"
   J.pinfo()


   J[0:19:2].set(10,1); 

   J.pinfo()

   <<"$J \n"; 


   chkN(J[0],10);
   chkN(J[2],11);
   chkN(J[4],12);   
   
//chkOut();exit()
   
//   J[0:7] = 6; 
      J[0:7:1] = 6; 
   chkN(J[0],6); 
   chkN(J[7],6); 
   
   <<"$J \n"; 
   
   
   J[-1:1:-2] = 35;
   
   <<"$J \n"; 
   
   chkN(J[19],35); 
   chkN(J[1],35); 
   
   
   chkOut(); 
   
   
//////////////////////////////////
/// ? TBCDF
/// ? TBF  pic lic of  J[0:19:2].set(10,1)  repeats section
/// ? but xic works?
/* 
 *  @script caz.asl                                                     
 * 
 *  @comment test Caz func                                              
 *  @release Carbon                                                     
 *  @vers 1.7 N Nitrogen [asl 6.29 : C Cu]                              
 *  @date 06/13/2024 18:16:14                                           
 *  @cdate Tue Mar 12 07:50:33 2019                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//<<"$_clarg[0] $_clarg[1] \n"
#include "debug"

   chkIn();

   if (_dblevel >0) {

        debugON();

   }

   int D[5];

   D[1] = 1;

   D[4] = 4;

   int d;

   d = 79;

   d->info(1);

   <<"$d $(typeof(d))\n";

   <<" $d scalar $(Sizeof(d))\n";

   <<"array size of $d $(typeof(d))   \n";

   asz= Csz(&d);
//d->Info(1)

   <<"array size of $d $(typeof(d))  is: $asz \n";

   d.pinfo();

   nd = Cnd(&d);

   <<"number of dimensions are: $nd \n";

   chkN(nd,0);

   ab = Cab(&d);

   <<"bounds are: $ab \n";

   ab.pinfo();

   chkN(ab[0],0);

   chkN(asz,0);

   D.info(1);

   asz= Csz(&D);
//<<"%V$asz\n"
//D.info(1)

   <<"array size of $D $(typeof(D))  is: $asz \n";

   chkN(asz,5);

   nd = Cnd(&D);

   <<"number of dimensions are: $nd \n";

   chkN(nd,1);

   D.info(1);

   ab = Cab(&D);

   <<"bounds are: $ab \n";

   ab.info(1);

   chkN(ab[0],5);
////////////////////////////////

   <<"\n Svar vector \n";

   Svar S;

   <<"$S scalar $(Sizeof(S))\n";

   S[0] = "hey";

   S[1] = "mark";

   asz= Csz(S);

   <<"$asz  $(Cab(S))\n";

   <<"\n vector \n";

  int A[6]  = { 1,2,4,9,8,6 };

   a= A[0];

   <<"$a\n";

   <<"$A\n";

   asz= Csz(A);

   <<"array size (number of elements) is: $asz \n";

   chkN(asz,6);

   nd = Cnd(A);

   <<"number of dimensions are: $nd \n";

   chkN(nd,1);

   ab = Cab(A);

   <<"bounds are: $ab \n";

   <<" $(Caz(A)) $(typeof(A)) \n";
//<<"%I $A \n"   // will crash why?

   d= Cab(A);

   <<"%V $d \n";
/////////////////////////////////////////

   <<"////\n Two dimensions \n";
// FIXME  -- won't fill in rows

   int  B[6] = { 0,3,2,-1,1,-2} ;

   <<"%V $B\n";

   asz= Csz(B);

   <<"array size (number of elements) is: $asz \n";

   chkN(asz,6);

   nd2 = Cnd(B);

   <<"number of dimensions are: $nd2 \n";

   chkN(nd2,1);

   ab = Cab(B);

   <<"bounds are: $ab \n";

   d= Cab(B);

   <<"%V $d \n";

   B.redimn(2,3);

   asz= Csz(B);

   <<"array size (number of elements) is: $asz \n";

   chkN(asz,6);

   nd2 = Cnd(B);

   <<"number of dimensions are: $nd2 \n";

   chkN(nd2,2);

   ab = Cab(B);

   <<"bounds are: $ab \n";

   d= Cab(B);

   chkOut();
/*


 int C[3][3][3] = { { {0,1,2}, {3,4,5}, {6,7,8} },
                    { {9,10,11}, {12,13,14}, {15,16,17} },
		    { {18,19,20}, {21,22,23}, {24,25,26}}
		    };
                        


int  B[2][3] 
  k= 0;
  for (i = 0; i < 2; i++) {
   for (j = 0; j < 3; j++) {
     B[i][j] = k++;
   }
}


b = B[0][0]
<<"$b\n"

b = B[0][2]
<<"$b\n"




asz= Csz(B)
<<"array size (number of elements) is: $asz \n"

nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"

ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B)

<<"%V $d \n"
*/

//==============\_(^-^)_/==================//

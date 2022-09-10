/* 
   *  @script printvec.asl
   *
   *  @comment print format for vectors
   *  @release CARBON
   *  @vers 1.4 Be Beryllium [asl 6.3.64 C-Li-Gd]
   *  @date 11/29/2021 21:01:31
   *  @cdate 11/29/2021 21:01:31
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------; //
 */ 
   ;//----------------------//;
   

Str Use_ =  "Demo  of print format for vectors";


#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_ \n";

     }

   chkIn(_dblevel);

 //  filterFileDebug(REJECT_,"array","args","exp");


float f = 1.2345;
double d = 123456.789;
char c = 'A';

  printf('f %f d %lf \n',f,d);

  printf("f %f d %lf \n",f,d);


  IV= vgen (INT_,10,0,1);

  <<"$IV\n"


    <<"$IV[0:-1:2]\n"

   k = IV[3];

<<"%V $k $IV[3]\n"

   chkN(k,3);

   k= IV[8];

   chkN(k,8);

   k = IV[-1];

<<"%V $k $IV[-1]\n"


/*
   A=ofw("pr.log");

   float F[];

   F = Fgen(20,0,1);

  // for (i=0; i< 4; i++) {
   for (i=0; i< 4; ) {
    <<" [$i] %V$F[i]\n"
    i++;
   }



  <<"%v6.2f$F \n";

   <<"%v6.2f=$F \n";

   <<"%v=$F[2:7] \n";

   <<"%v= $F[2:7] \n";

   <<[A]"$F[2:7] \n";

   cf(A);

   A=ofr("pr.log");

   V=readline(A);

   <<" $V \n";

   T= split(V);

   <<" $T \n";

   <<"%V$T[1]   $T[5]\n";

   float G[];

   G= atof(T[1:5]);

   sz = Caz(G);

   <<"%v $sz %v $G \n";

   i = 3;

   j = 9;

   <<"%6.2f %v = $F[i:j] \n";

   i++;

   j++;

   <<"$F[i:j] \n";

*/

/*
// FIXME
   float G[] = Igen(20,0,1)
   <<" $G \n"
   <<"$G[2:7] \n"
*/


   chkT(1);

   chkOut();

//===***===//

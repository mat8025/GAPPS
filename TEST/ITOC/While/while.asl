/* 
 *  @script while.asl 
 * 
 *  @comment tests While syntax 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.58 C-Li-Ce] 
 *  @date 11/09/2021 14:47:53          
 *  @cdate Sat Apr 18 21:48:17 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                   
///
///


#include "debug.asl"
#include "hv.asl"

   if (_dblevel >0) {

       debugON();
     }


   <<"$Hdr_comment\n"

   chkIn(_dblevel);

db_allow = 1

   askit(0)


   int k = 0;

   k++;

   ++k;

   --k++;




k.pinfo()



   int Foo()
   {

     int fi =0;

     <<"%V  $Nrecs\n";

     while (fi < Nrecs) {
//<<"%V$fi\n"

       fi.pinfo();

       fi++;

       if (fi < Nrecs) {

         <<"$fi $(Nrecs-fi) to go \n";

         }

       }

     chkN (fi,Nrecs);

     return fi;

     }
//======================================//

   int readData2()
   {

     int tl = 0;

     while (tl < Nrecs) {

       tl++;

       if (tl < Nrecs) {

         <<"$tl $(Nrecs-tl) to go \n";

         }
//<<"EOWHILE $tl $Nrecs\n"

       }

     <<"$Nrecs there were $tl  measurements \n";

     chkN (tl,Nrecs);

     return tl;

     }
//==============================================//

   int readData() 
   {

     int tl = 0;

     while (tl < Nrecs) {
//  tl->info(1)

       tl++;

       if (tl < Nrecs) {
          tl2go = Nrecs-tl
        // <<"$tl $(Nrecs-tl) to go \n";  // TBF 10/17/23
 <<"$tl $tl2go to go \n";
         }

       <<"EOWHILE $tl $Nrecs\n";

       }

     chkN (tl,Nrecs);

     <<"$Nrecs there were $tl  data reads \n";

     return tl;

     }
//==============================================//

   Nrecs = 10;

   nt =readData();

   <<"looped $nt times\n";

   chkN (nt,Nrecs);

   nt =Foo();

   <<"looped $nt times\n";

   chkN (nt,Nrecs);
//chkOut ()
//===========================//



   int ok =0;

   <<"always trying forever \n";

   while (1) {

     if (k++ > 20) {

       <<"break $k\n";

       break;

       }

     k++;

     <<"forever! $k\n";

     }

   k = 0;

   while (1) {

     if (k >=9) {

       break;

       }

     else {

       <<"this while loop $k\n";

       k++;

       }

     };

     <<"%V$k == ? 9 \n";

     chkN (k,9);

     k= 0;

     n = 1;

     while (1) {

       if (k >=10) {

         break;

         }

       k++;

       }

     <<"%V$k == ? 10 \n";

     chkN (k,10);

     k= 0;

     n = 1;

     while (1) {

       if (k >=10) {

         break;

         }

       k += n;

       }

     <<"%V$k == ? 10 \n";

     chkN (k,10);
///
///
///

     N = 10;

     k = 0;

     while ( k < N)  k++;

     <<" DONE $k $N \n";

     chkN (k,N);

     k =0;

     int m = 0;

     while (k++ < N) {

       m++;

       <<" $k $m \n";

       }

     <<" DONE $k $N \n";

     chkN (k,N+1);

     m = 0;

     k = 0;

     N = 3;

//allowDB("while,ic",db_allow)
     while ( ++k < N) {

       m++;

       <<"%V $k $m \n";
       
       // TBF  if (k > 10) break ;   --- needs  {} 10/18/23

       if (k >= 4) break ;  
	   
       }
     
     <<" DONE $k $N \n";

     chkN (k,N);

//chkOut(1)


     chkStage("2");

     tt = 13;

     N = 15;

     M = 2 *N;

     <<"%V $tt $N \n";

     <<" $tt times table \n";
//tt =3

     k = 0;

     kc = 0;

     a = 3;

     b = 3 ; c = a * b;

     <<" %v $c \n";

     while ( k < M ) {

       k++;

       if ( k > N )  {

         <<" attempting continue to end of loop -skipping code lines\n";

         <<" ! $k > $N \n";

         continue ;

         <<" should not see this !\n";

         }
//<<" out of if $k \n"

       a= k * tt;

       kc++;

       <<" $k * $tt = $a \n";

       }

     chkN (kc,N);

     <<" DONE %V $k $kc  $N $M $a\n";

     chkStage("continue");
///////////////////////////////

     int tl = 0;

     while (tl < Nrecs) {

       <<"$tl\n";

       tl++;

       if (tl < Nrecs) {

         <<"$tl $(Nrecs-tl) to go \n";

         }

       }

     chkN (tl,Nrecs);

     Foo();

     readData();

     k = 0;

     N = 4;

     while (1) {

       k++;

       <<"$k \n";

       if (k >= N) {

         <<"breaking out of while $k\n";

         break;

         }

       }

     <<"Out of while $k $N\n";

     chkN(k,N);

     chkOut();

/////////////////////////////////////////////////////////////////////

///    TBF single line if 
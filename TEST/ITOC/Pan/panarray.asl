///
///
///

setdebug(1,@trace,@pline)
N= 10;


pan A[10];
long L[10];
pan Bnum[];

pan j= 0;

<<"$(typeof(A)) $(Caz(A)) $(Cab(A))\n"

<<"$(typeof(Bnum)) $(Caz(Bnum)) $(Cab(Bnum))\n"


  j = 24678050;

<<"%V$j\n"

   L[0]= 88593477;

<<"%V$L[0]\n"

   L[1]= 24678051;

<<"%V$L[1]\n"


   l1 = L[1];

<<"%V$l1\n"



  A[0]= 88593477;

  A[1] =  24678051;

  j = A[1];

<<"%V$j\n"

<<"%V$A[0]\n"
<<"%V$A[1]\n"
<<"%V$A\n"

exit()


//////////////////////////////////////////////////////

   for (i=0; i < N; i++) {

     A[i] = N-i;
<<"<$i> $A[i]  $(N-i)\n"      
    Bnum[i] = N+i;
 <<"<$i> $Bnum[i] $(N+i)\n"      
 }

<<"$(typeof(A)) $(Caz(A)) $(Cab(A))\n"

<<"$A \n"

<<"$(typeof(Bnum)) $(Caz(Bnum)) $(Cab(Bnum))\n"

<<"$Bnum \n"
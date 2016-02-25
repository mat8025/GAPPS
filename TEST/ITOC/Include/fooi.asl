//setdebug(0)
// 


int n = 2
int m = 3

 p = n * m

<<"%V$n $m $p \n"

  for (i = 0; i < 5; i++) {
     m *= 2
       p = n++ * m

//FIXME XIC   printf ("printf  n %d m %d p %d \n",n,m,p);

   <<"asl_print %Vd$n $m $p  \n"
  }


<<" b4 include \n"

include "inc5.h"

<<" after include inc5 \n"


/{ --- start comment block
<<" b4 include \n"
  include "inc2.h"
<<" after include \n"
/} --- end comment block

<<" b4 inc2 \n"
include "inc2.h"
<<" after include inc2 \n"
<<" the last statement in the MAIN script \n"


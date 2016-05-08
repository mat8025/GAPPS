////    test include statement
int n = 0 

setdebug(2,"pline","trace")

<<" before include\n"

include "inc1";

//include "inc2";

 checkin();

 s=foo(2,3)

<<"%V$s\n"

 checknum(s,5)

<<" yellow $(C_YELLOW) \n"

 if (argc() > 1) {
   s=boo(2,3);
   <<"%V$s\n"
   s=boo(47,79);
   <<"%V$s\n"
 }

   g=goo(47,79);
   <<"%V$g\n"

 checkout()

exit()


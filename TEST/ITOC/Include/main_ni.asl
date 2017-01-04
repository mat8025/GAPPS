////
////    test include statement
////

<<"does nested includes\n"


int n = 0 ;

<<"%V$n\n";

//goon = iread("->\n");

//setdebug(1,"pline","trace")

setdebug(0)

<<" before include\n"

include "inc1_nest";



<<"after include \n"
<<"a global %V$X\n"
<<"a global %V$Y\n"
<<"a global %V$Z\n"

 checkin();

 s=foo(2,3)

<<"%V$s\n"

 checknum(s,5)

<<" yellow $(C_YELLOW) \n"

 if (argc() > 1) {
   s=boo(2,3);
   <<"%V$s\n"
 checknum(s,-1)   
   s=boo(47,79);
   <<"%V$s\n"
 checknum(s,-32)      
 }

   g=goo(47,79);
   <<"%V$g\n"
   
 checknum(g,47*79)


     h=hoo(47.0,79);
     
   <<"%V$h\n"
   
 checknum(h,47.0/79)



 checkout()

exit()


//%*********************************************** 
//*  @script main_ni.asl 
//* 
//*  @comment test include refs 
//*  @release CARBON 
//*  @vers 1.11 Na Sodium                                                 
//*  @date Thu Jan 17 09:39:14 2019 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


<<"does nested includes\n"

A= 1;

int n = 0 ;

<<"%V$n\n";

//goon = iread("->\n");

//setdebug(1,"pline","trace")

setdebug(0)

<<" before include\n"

include "inc1_nest";





 checkin();

<<"main sees globals %V $A $X $Y $Z\n"

checkFnum(A,1)
checkFnum(X,1.2345)
checkFnum(Y,2.2345)
checkFnum(Z,3.2345)



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

dd= foo(4,5)
<<"$dd\n"

 checkout()

exit()


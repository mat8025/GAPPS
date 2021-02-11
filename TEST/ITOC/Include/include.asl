//%*********************************************** 
//*  @script include.asl 
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
   

   
   
   <<"does nested includes\n"; 
   
   chkIn(_dblevel); 
   
   ws = getScript(); 
   
   <<"%V $ws\n"; 
   
   A= 1;
   
   int n = 0 ;
   
   <<"%V$n\n";
   
   
   <<" before include\n"; 
   
   #include "inc1_nest";
   
   <<" after include\n"; 
   
   
   chkIn();
   
   <<"main sees globals %V $A $X $Y $Z\n"; 
   
   
   chkR(A,1); 
   chkR(X,1.2345); 
   chkR(Y,2.2345); 
   chkR(Z,3.2345); 
   
   s=Foo(38,33);

   chkN(s,71); 

   s=Doo(2,3); 
   
   <<"%V$s\n"; 
   
   chkN(s,5); 
   
   <<" yellow $(C_YELLOW) \n"; 
   
   if (argc() > 1) {
     s=Boo(2,3);
     <<"%V$s\n"; 
     chkN(s,-1); 
     s=Boo(47,79);
     <<"%V$s\n"; 
     chkN(s,-32); 
     }
   
   g=Goo(47,79);
   <<"%V$g\n"; 
   
   chkN(g,47*79); 
   
   
   h=Hoo(47.0,79);
   
   <<"%V$h\n"; 
   
   chkN(h,47.0/79); 
   
   dd= Doo(4,5); 
   <<"$dd\n"; 
   
   chkOut(); 
   

   

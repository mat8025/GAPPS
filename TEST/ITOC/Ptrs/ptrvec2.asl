//%*********************************************** 
//*  @script ptrvec2.asl 
//* 
//*  @comment test ptr access to vec 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Wed Jun 26 08:46:49 2019 
//*  @cdate Wed Jun 26 08:46:49 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
      
   include "debug"; 
   debugON(); 
   
   sdb(1,@~trace,@pline); 
   
   chkIn();
   
   i = 1;
   
   int  c[] = { 0,1,2,3,4,5,6,7,8,9,77 };
   
   <<"$c\n"; 
   <<"$c[0:3]\n"; 
   
   <<"$c[-1:0:-1]\n" ; ; // BUG  
   
   c[3] = 55; 
   
   <<"$c\n"; 
   c[5] = c[3];
   <<"$c\n"; 
   
   
   ptr z;
   
   z= &c;
   
   <<"%V $(typeof(z)) $z \n"; 
   
   z->info(1); 
sdb(1,@trace)
   f= z[6];
   <<"%V $f \n"
   z->info(1); 
   
   f->info(1);
   
   chkN(f,6); 


   
   f= z[7];
   
   z->info(1); 
   
   f->info(1);
   
   chkN(f,7); 
   <<"%V $f \n"


   
   c[12]= 45;
   
   <<"$(Caz(c)) : $c\n"; 
   
   f= z[1];
   <<"%V$f\n"; 
   chkN(f,1); 
   
   f= z[2];
   <<"%V$f\n"; 
   chkN(f,2); 
   
   f= z[3];
   <<"%V$f\n"; 
   chkN(f,55);
   i =4
   f= z[i];
   <<"%V$f\n"; 
   chkN(f,4); 
   
   
   f= z[12];
   <<"%V $f \n"; 
   c->info(1); 
   z->info(1); 
   
   chkN(f,45); 
   
   i = 12;
   
   
   f= z[i];
   z->info(1)
   <<"%V$i $f \n"; 
   
   chkN(f,45); 
   
   
   sz=Caz(c);
   
   for (i=0;i<sz;i++) {
     
     f= z[i];
     
     <<"<$i> $f \n"; 
     
     }
   
   
   float d[] = vgen(FLOAT_,10,0,1); 
   
   sz=Caz(d);
   
   z = &d;
   
   float fval;
   for (i=0;i<sz;i++) {
     
     fval= z[i];
     
     <<"<$i> $fval \n"; 
     chkN(fval,d[i]); 
     }

checkStage("num vecs - get value")


//================================//
sdb(1,@trace)


     z[5] = 85;
     
<<"%V $d\n"
z->info(1)
d->info(1)

   chkN(d[5],85)


    z[12] = 86;
<<"%V $d\n"
z->info(1)
d->info(1)

   chkN(d[12],86)

DI=d->info()
<<"$DI \n"
DIS= Split(DI)

<<"DIS: <|\n%(1, ,,\n)$DIS\n |>\n"

<<"$DIS[0]\n"

checkStage("num vecs - set value")


///////////////////////////////////////////////////////////////

   svar S;
   
   S[0] = "C'est";
   S[1] = "va";
   S[2] = "tres";
   S[3] = "bien";
   S[4] = "avec";
   
   
   <<"$S[2] \n"; 

   svar sval;
   
   ptr  ps; 
   
   ps = &S;
   
   val = ps[2];
   
   <<"$val\n";
  
   val->info(1); 

   ps->info(1);

   val = ps[3];
   
   <<"$val\n";



   sz=Caz(S);

    i= 1;
   
   sval= ps[i];


     chkStr(sval,"va")
     
   for (i=0;i<sz;i++) {
     
     sval= ps[i];
     
     <<"<$i> $sval \n"; 
          chkStr(sval,S[i])
     }
   
   <<"\n";
      ps->info(1);



     ps[3] = "dancez"

     chkStr(S[3],"dancez")

<<"%V $S[3]\n"


     sval= ps[3];
     nval = S[3];

<<"%V $sval $nval $ps[3]\n"




     sval= ps[4];
     nval = S[4];

<<"%V $sval $nval $ps[4]\n"

     ps[4] = "trop"     
     ps[5] = "merci"


     chkStr(ps[3],"dancez")
     chkStr(ps[5],"merci")          

      sz=Caz(S);
      
     for (i=0;i<sz;i++) {
     
      sval= ps[i];
     
     <<"<$i> $sval  $S[i]\n";

      chkStr(sval,S[i])
  //   sval->info(1); 
     }

     chkStr(ps[1],"va")
     chkStr(ps[3],"dancez")     
     chkStr(S[4],"trop")
     chkStr(S[5],"merci")     


   checkStage("str vecs - get value")

   chkOut(); 
   
   exit(); 
   
   

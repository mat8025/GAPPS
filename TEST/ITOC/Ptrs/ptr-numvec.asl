//%*********************************************** 
//*  @script ptr-numvec.asl 
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

<|Use_=
Demo  of ptrs

///////////////////////
|>




#include "debug"

  if (_dblevel >0) {
    debugON()
    <<"$Use_\n"
   }
   
   chkIn(_dblevel);

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

   z->info(1);

   z = &c;
   
   <<"%V $(typeof(z)) $z \n"; 
   
   z->info(1); 

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
   <<"$c \n"

   c->info(1)
  <<"%V$c\n"
   c[12]= 45;

   <<"%V$c\n"
   c->info(1)
   chkN(c[12],45)


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

   <<"%V$z\n"
   <<"%V$c\n"
   
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

<<"%V $d\n"
   d->pinfo()

   sz=Caz(d);

   c->pinfo()

   z = &d;

   z->pinfo()

   c->pinfo()

   d->pinfo()



   z = &c;

   z->pinfo()

   z = &d;

   z->pinfo()





   float fval;

<<"%V $sz \n"
    d->pinfo()
    

   for (i=0;i<sz;i++) {
     
     fval= z[i];
     z->info(1)
     
     <<"<$i> $fval $d[i]\n"; 

      chkN(fval,d[i]); 
     }

//chkStage("num vecs - get value")


//================================//
d->info(1)

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

//chkStage("num vecs - set value")

chkOut(); 
exit()
///////////////////////////////////////////////////////////////

/* 
 *  @script ptr_numvec.asl 
 * 
 *  @comment test ptr access to vec 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.55 C-Li-Cs] 
 *  @date 10/12/2021 22:10:28 
 *  @cdate Wed Jun 26 08:46:49 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                            

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

   z<-pinfo();

   z = &c;
   
   <<"%V $(typeof(z)) $z \n"; 
   
   z<-pinfo(); 

   f= z[6];
   <<"%V $f \n"
   z<-pinfo(); 
   
   f<-pinfo();
   
   chkN(f,6); 


   
   f= z[7];
   
   z<-pinfo(); 
   
   f<-pinfo();
   
   chkN(f,7); 
   <<"%V $f \n"
   <<"$c \n"

   c<-pinfo()
  <<"%V$c\n"
   c[12]= 45;

   <<"%V$c\n"
   c<-pinfo()
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
   c<-pinfo(); 
   z<-pinfo(); 
   
   chkN(f,45); 

   i = 12;
   
   
   f= z[i];
   z<-pinfo()
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
     z<-pinfo()
     
     <<"<$i> $fval $d[i]\n"; 

      chkN(fval,d[i]); 
     }

//chkStage("num vecs - get value")


//================================//
d<-pinfo()

     z[5] = 85;
     
<<"%V $d\n"
z<-pinfo()
d<-pinfo()

   chkN(d[5],85)


    z[12] = 86;
<<"%V $d\n"
z<-pinfo()
d<-pinfo()

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

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


include "debug"
debugON()

sdb(1,@~trace,@pline)

checkIn();

i = 1;

int  c[] = { 0,1,2,3,4,5,6,7,8,9,77 };

<<"$c\n"
<<"$c[0:3]\n"

<<"$c[-1:0:-1]\n" ; // BUG 

  c[3] = 55

<<"$c\n"
  c[5] = c[3];
<<"$c\n"  


  ptr z;

  z= &c;

<<"%V $(typeof(z)) $z \n"

  z->info(1)


  f= z[6];

  z->info(1)

  f->info(1);

  checkNum(f,6)




   c[12]= 45;

<<"$(Caz(c)) : $c\n"

      f= z[1];
<<"%V$f\n"      
  checkNum(f,1)

      f= z[2];
<<"%V$f\n"      
  checkNum(f,2)

      f= z[3];
<<"%V$f\n"      
  checkNum(f,55)
  



   f= z[12];
<<"%V $f \n"
c->info(1)
z->info(1)

  checkNum(f,45)

   i = 12;


   f= z[i];
<<"%V$i $f \n"

  checkNum(f,45)


   sz=Caz(c);
   
   for (i=0;i<sz;i++) {

      f= z[i];

<<"<$i> $f \n"

   }





float d[] = vgen(FLOAT_,10,0,1)

   sz=Caz(d);

   z = &d;

float fval;
   for (i=0;i<sz;i++) {

      fval= z[i];

<<"<$i> $fval \n"
     checkNum(fval,d[i])
   }


svar S;

  S[0] = "C'est";
  S[1] = "va";
  S[2] = "tres";
  S[3] = "bien";  


<<"$S[2] \n"


ptr  ps

   ps = &S;

 val = ps[2];

<<"$val\n"
    val->info(1)

   sz=Caz(S);
   for (i=0;i<sz;i++) {

      val= ps[i];

<<"<$i> $val \n"

   }

<<"\n"
svar sval;

  
   for (i=0;i<sz;i++) {

      sval= ps[i];

<<"<$i> $sval \n"
      sval->info(1)
   }

checkOut()

exit()



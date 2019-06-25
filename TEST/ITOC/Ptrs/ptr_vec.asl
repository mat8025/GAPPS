///
///
///


include "debug"
debugON()

sdb(1,@~trace)

i = 1;

int  c[] = { 0,1,2,3,4,5,6,7,8,9,77 };

<<"$c\n"

<<"$c[0:3]\n"
<<"$c[-1:0:-1]\n"



  c[3] = 55

<<"$c\n"
  c[5] = c[3];
<<"$c\n"  


 ptr z;

  z->info(1)

  z= &c;

<<"%V $(typeof(z)) $z \n"

  z->info(1)


   f= z[6];

  z->info(1)

   f->info(1);
<<"$c\n"
<<"%V $f \n"

  c[10]= 45;

   f= z[2];

<<"c= $c\n"

   f->info(1);

<<"%V $f \n"


   f= z[3];

<<"%V $f \n"
   sz=Caz(c);
   for (i=0;i<sz;i++) {

      f= z[i];

<<"<$i> $f \n"

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


exit()



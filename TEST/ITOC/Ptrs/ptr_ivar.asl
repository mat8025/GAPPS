

avec = vgen(INT_,10,-5,1)

<<"$avec\n"


iv = "avec"


nuvec = $iv;


<<"%V$nuvec\n"
<<"%V$avec\n"

<<"$iv  $($iv) \n"

ptr p;

   p = &avec;

   sz=Caz(avec);
   for (i=0;i<sz;i++) {

      f= p[i];

<<"<$i> $f \n"

   }

ptr p2;

      p2 = &$iv ;
      i = 2;
      f= p2[i];

  p2->info(1)

<<"<$i> $f \n"

   for (i=0;i<sz;i++) {

      f= p2[i];

<<"<$i> $f \n"

   }

T=p2->info()
<<"$T\n"
T->split()
<<"%(1,,,\n)$T\n"


<<"$T[3]\n"

<<"$T[0:3:]\n"


setDEbug(1,@trace)



N = 500;


int pj = 0;
int pk = 0;
int pm = 17;


       pj = 450;

       rp = (pj % pm);
     dp = (pj / pm);
<<"%V $(typeof(rp))  $rp  $dp\n"

for (i=0; i< 16;i++) {

        pj = 451+i;

       dp = (pj / pm);
       rp = (pj % pm);

<<"%V $(typeof(rp))  $rp  $dp\n"

        if (rp == 0) {

<<"%V $rp  is 0\n" 
         }

        if (rp == 1) {

<<"%V $rp  is 1\n" 
         }
}

exit()


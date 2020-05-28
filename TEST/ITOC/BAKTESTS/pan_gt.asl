
pan j = 0

proc foo()
{
<<"in $_proc \n"
int jj = 30
i = 23.5

   while (1) {


    j = trunc(i)

   if (i >= N) {
 <<"$i >= $N  - $(typeof(i)) break test\n"
    break
   }
   else {
 <<"%V$i $j < $N \n"
   }

   i += 2

   jj += 2


   if (jj > 500) {
<<" int safety break\n"
     break
   }

   }


}




pan i = 23.5

pan N = 258.67


   if (i >= N) {
 <<"$i >= $N \n"
   }
   else {
 <<"$i < $N \n"
   }



   if (N >= i) {
 <<"$N >= $i \n"
   }
   else {
 <<"$N < $i \n"
   }

int ii = 30

   while (1) {


   if (i >= N) {
 <<"$i >= $N  - break test\n"
    break
   }
   else {
 <<"%V$i < $N \n"
   }

   i += 2

   ii += 2


   if (ii > 50) {
     break
   }

   }


  foo()
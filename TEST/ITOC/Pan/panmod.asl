///
///  panmod       ( a % b)
///


//  a pan   b is inttype

//   a and b pan
setDEbug(1,@trace)

setap(10);

N = 50;


pan pj = 0;
pan pk = 0;
pan pm = 5;


       pj = 450;

       rp = (pj % pm);
     dp = (pj / pm);
<<"%V $(typeof(rp))  $rp  $dp\n"

for (i=0; i< 16;i++) {

        pj = 451+i;

       dp = (pj / pm);
       rp = (pj % pm);

<<"%V $(typeof(rp))  %p $rp  $dp\n"

        if (rp == 0) {

<<"%V $rp  is 0\n" 
         }

        if (rp == 1) {

<<"%V $rp  is 1\n" 
         }
}



int j = 0;
int  k = 0;
int  m = pm;

int n = 0;

   while (1) {

        r = (j % m);
        n = r;
	
        q = j / m;

<<"%V $j $m $r $n $q\n"

      //  if ((j % m) == 0) {
      //  if ( r == 0) {
      
       if (n == 0) {
<<"$j is mult of $m \n"
         k++;
         }
	 
<<"<$j> <$k>\n"

        j++;
  if (j > N)
     break;
   }

<<"Done %V $j $k \n"

pj = 0;
pan pr;
pan pq;
   while (1) {

        pr = (pj % pm);
	pq = (pj / pm);

      //  pr -= 1;

<<"%V $pj $pm %p $pr $pq \n"

        if ( pr == 0) {
<<"$pj is mult of $pm \n"
         pk++;
         }
	 
<<"<$pj> <$pk>\n"

        pj++;
  if (pj > N)
     break;
   }

<<"Done %V $pj $pk \n"

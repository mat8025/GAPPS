//
///



checkIn()

setdebug(1,@keep)
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


int k = 0
int ok =0
<<"trying forever \n"
 // ok++;
 // while (k>=0) {
  while (1) {

  if (k++ > 20) {
 // if (k > 20) {
<<"break $k\n"
   break;
  }
 k++
   <<"forever! $k\n"
  }


 k = 0

  while (1) {

   if (k >=10) {
      break;
   }

   k++;
   
  }

<<"%V$k == ? 10 \n"

checkNum(k,10);

k= 0;
n = 1;

  while (1) {

   if (k >=10) {
      break;
   }
   k++;

  }

<<"%V$k == ? 10 \n"

checkNum(k,10);

k= 0;
n = 1;

  while (1) {

   if (k >=10) {
      break;
   }
   k += n

  }

<<"%V$k == ? 10 \n"

checkNum(k,10);



checkOut()
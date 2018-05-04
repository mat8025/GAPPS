///
///
//setdebug(1,"pline");
setdebug(0);

str mans = "fire";
int man = 0;
int k = 0;

 while (1) {

   <<"start loop %V $k $man\n";
   if (man == 0) {
<<"$k 0N FIRE !\n";
   }
   else if (man == 1) {
   
<<"$k  WORK !\n";
   }
   else {

<<"$k TRY \n"

   }

   <<"mid loop $k \n";

   if (k > 3) {

   man = 1;
   
   }


   if (k > 5) {

   man = 5;
   
   }



k++;
   if (k > 10) {
       break;
   }
   <<"end  loop $k $man\n";
 }

 k = 0;


while (1) {

   <<"start loop %V $k $mans\n";
   if (mans @= "fire") {             // ??

<<"$k 0N FIRE !\n";
   }
   else if (mans @= "working") {

  // if (mans @= "working") {
   
<<"$k  WORK !\n";
   }
   else {

<<"$k TRY \n"

   }

   <<"mid loop $k \n";

   if (k > 3) {

   mans = "working";
   
   }


   if (k > 5) {

   mans = "try";
   
   }



k++;
   if (k > 10) {
       break;
   }
   <<"end  loop $k $mans\n";
 }


<<"out $k \n";
  if (k == 11) {

<<"OK bud its working\n";
  }
  else {
<<"bud broken try harder\n";
  }
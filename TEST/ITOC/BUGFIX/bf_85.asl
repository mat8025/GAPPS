
include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");




setdebug(1,@~pline,@trace,@keep)
/// break bug??
checkIn()
proc foo()
{
  k= 0;
  j= 0;
  m =0
while (1) {

   if (j++ > 3) {

    if (k++ > 5) 
         break;
    
   }
   m++;
   <<"%V $m $j $k \n"
   if (m > 10) break;
  }
    <<"%V$j $k break proc-while-if-if\n"
    checkNum(k,7)
}
//=======================


  k= 0;
  while (1) {

    if (++k > 5) {
         break;
    }
<<"%V $k\n"
  }
 checkNum(k,6)
<<"%V$k break while-if\n"
//iread(" break OK?")



  k= 0;
  j= 0;
  m= 0;
  q =0;


  while (1) {

      j++;
      if (j > 2) {
 //  if ((++j) > 2) {
   
<<"1 j> 4%V $k  $j $m \n";
      k++;
      if (k > 5) {
<<"k $k break - should be out now \n"
      q++;
      break
      }
<<"2 j> 4%V $k  $j $m \n";
    }

<<"end loop %V $k  $j $m \n"
   if (m++ > 10)  {break;}
 }

<<"%V$j $k  $m break while-if-if \n"
 checkNum(k,6)
<<"%V$k \n"

//foo();

checkOut()

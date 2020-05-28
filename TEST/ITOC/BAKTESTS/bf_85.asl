
/// break bug??
checkIn()
proc foo()
{
  k= 0;
  j= 0;
  while (1) {

   if (j++ > 3) {

    if (k++ > 5) {
         break;
    }
   }

//iread(" break OK?")
  }
    <<"%V$j $k break proc-while-if-if\n"
    checkNum(k,7)
}
//=======================


  k= 0;
  while (1) {

    if (k++ > 5) {
         break;
    }

  }
 checkNum(k,7)
<<"%V$k break while-if\n"
//iread(" break OK?")

  k= 0;
  j= 0;
  while (1) {

   if (j++ > 3) {

    if (k++ > 5) {
         break;
    }

   }
 
//iread(" break OK?")

 }
  <<"%V$j $k  break while-if-if \n"
 checkNum(k,7)
<<"%V$k \n"

 foo();

checkOut()

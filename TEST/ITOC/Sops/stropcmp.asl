
//  test svar and str cmp operator
//setdebug(1)

checkIn()
ok = 0

   A= "how"

<<"$A\n"
<<"$(typeof(A))\n"

   if (A @= "how") {
     <<" fine\n"
      ok = 1
   }
   else {
<<" scmp not working \n"
   }


CheckNum(1,ok)

checkOut()

exit()
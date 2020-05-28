setdebug(0)

A= 0
proc snooze()
{
  A= 0
  for (i = 0; i < 3200; i++) {

    A += 1
  }


}



     jpid = !!&"asl -o woo keep_at_it.asl  "
     snooze()
<<"%V$jpid\n"

   // nanosleep(1,1)

  for (i = 0 ; i < 4 ; i++) {

     jpid = !!&"asl -o goo$i keep_at_it.asl  "

<<"%V$jpid\n"

   // nanosleep(1,1)
//!!"ps wax "

    snooze()
 }


!!"ps wax "
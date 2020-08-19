
CheckIn()

//
// want to convert number string to a pan when it is outside of double
// representation
//

setdebug(1,"pline")
 pan pnum = 123456789.98765432100;

<<"%V$pnum \n"

  testArgs(pnum,  123456789)

  testArgs(pnum,  123.456)

  testArgs(pnum,  123456789.98765432100)

  checkFnum(pnum,  123456789.98765432100, 5)


checkOut()
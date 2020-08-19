# test ASL function 

CheckIn()

setdebug(0)


 ename = periodicName(1)

//<<" $ename \n"


  for (i = 1; i <= 100; i++) {
   ename = periodicName(i)
   if (ename @= "unknown_element")
     break
   <<"%-16s$(periodicName(i)) \t$i\t%-4s$(periodicSymbol(i)) \t%6.3f$(periodicWt(i)) \n"

  }

  an = periodicNumber("Iron")

CheckNum(an,26)

<<" Iron is $an \n"

  we = "Manganese"
  an = periodicNumber(we)
<<" $we is $an \n"

CheckNum(an,25)

  we = "silver"
  an = periodicNumber(we)
<<" $we is $an \n"

CheckNum(an,47)


  we = "mercury"
  an = periodicNumber(we)
<<" $we is $an \n"

CheckNum(an,80)

  we = "gold"
  an = periodicNumber(we)
<<" $we is $an \n"

CheckNum(an,79)


CheckOut()
;



FailedList = ("",  )  // empty list --- bug first item null?

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"

tname = "debe esforzarse más"

 <<"inserting $tname into failed list \n"
 
  FailedList->Insert(tname)

   flsz = caz(FailedList)

<<"failed list size $flsz \n"


tname = "Camino a cinco kilómetros al día"

 <<"inserting $tname into failed list \n"
            FailedList->Insert(tname)

   flsz = caz(FailedList)

<<"failed list size $flsz \n"

//  flab = cab(FailedList)
//<<"failed list bounds $flab \n"


if (flsz > 1) {
<<" These modules failed! \n"

   FailedList->Sort()

<<" $FailedList \n"
}

 FailedList->Sort()

<<" $FailedList \n"

<<"0 $FailedList[0] \n"

<<"1 $FailedList[1] \n"

<<"2 $FailedList[2] \n"

<<"3 $FailedList[3] \n"

// delete operation
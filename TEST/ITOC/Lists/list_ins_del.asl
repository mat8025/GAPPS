
checkIn()

FailedList = ("x",  )  // empty list --- bug first item null?
//FailedList = (  )  // empty list --- bug first item null?

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"

  FailedList->Delete(0)

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

  tname = "head here"
  FailedList->Insert(tname,0)

  tname = "tail here"
  FailedList->Insert(tname,-1)

  tname = "gracias"
  FailedList->Insert(tname,2)

  tname = "que tal"
  FailedList->Insert(tname,3)

<<" $FailedList \n"

// delete operations


// clear

// delete current, head, tail

  FailedList->Delete(-1)

<<" $FailedList \n"
   flsz = caz(FailedList)

<<"failed list size $flsz \n"

  FailedList->Delete(0)

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"

// delete nth item


  FailedList->Delete(2)

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"


 checkNum(flsz,3)

 checkOut()
  


setdebug(1,"~pline","trace","~stderr");
FilterDebug(0)
FilterFileDebug( 2,"args_e.cpp")


proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }
ans = iread()
}

//#define  ASK ask();
#define  ASK ;



checkIn()

FailedList = ("xxx",  )  // empty list --- bug first item null?
//FailedList = (  )  // empty list --- bug first item null?

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"

  FailedList->LiDelete(0)

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"
ASK

  tname = "debe esforzarse más"

 <<"inserting <$tname> into failed list \n"
 
  FailedList->Insert(tname)

   flsz = caz(FailedList)

<<"failed list size $flsz \n"


<<" $FailedList \n"

ASK
tname = "Camino a cinco kilómetros al día"

 <<"inserting <$tname> into failed list \n"
            FailedList->Insert(tname)

   flsz = caz(FailedList)

<<"failed list size $flsz \n"
<<" $FailedList \n"
ASK

//  flab = cab(FailedList)
//<<"failed list bounds $flab \n"


if (flsz > 1) {
<<" These modules failed! \n"

   FailedList->Sort()

<<" $FailedList \n"
}

 FailedList->Sort()

<<"%V $FailedList \n"

<<"0 $FailedList[0] \n"

<<"1 $FailedList[1] \n"

<<"2 $FailedList[2] \n"

<<"3 $FailedList[3] \n"

  tname = "head here"
  FailedList->Insert(tname,0)
<<"failed list size $flsz \n"
<<" $FailedList \n"
  tname = "tail here"
  FailedList->Insert(tname,-1)
<<"failed list size $flsz \n"
<<" $FailedList \n"
  tname = "gracias"
  FailedList->Insert(tname,2)
<<"failed list size $flsz \n"
<<" $FailedList \n"
  tname = "que tal"
  FailedList->Insert(tname,3)
<<"failed list size $flsz \n"
<<" $FailedList \n"

testargs(1,FailedList)

// delete operations


// clear

// delete current, head, tail

  FailedList->LiDelete(-1)

<<" $FailedList \n"
   flsz = caz(FailedList)

<<"failed list size $flsz \n"

  FailedList->LiDelete(0)

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"

// delete nth item


  FailedList->LiDelete(2)

<<" $FailedList \n"

   flsz = caz(FailedList)

<<"failed list size $flsz \n"


 checkNum(flsz,3)

 checkOut()
  
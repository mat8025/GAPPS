# test object arrays

CheckIn()

//CheckIn()
setDebug(1)

int x = 5

<<" %v $x \n"

float V[10]

V[5] = 7

<<" $V \n"

CLASS building {

 int rooms = 5
 int floors = 2
 int area 

 CMF setrooms(val)
 {
//  <<" $_proc %I $_cobj  $rooms $floors $area \n"
  <<" $_proc  $_cobj  $rooms $floors $area \n"
   rooms = val
   print()

 }

 CMF getrooms()
 {
   return rooms 
 }

 CMF setfloors(val)
 {
   floors = val
// <<" $_cobj %I $_cobj $floors \n"
   area = floors * 200
//   my->print()
 }

 CMF getfloors()
 {
//   <<" $_proc $(cclass()) -> getfloors $floors \n"
   <<" $_proc  -> getfloors $floors \n"
   return floors
 }

 CMF print()
 {
  <<" $_proc $_cobj %V \n $rooms \n $floors \n $area \n"
 }

 CMF building()
 {

    floors = 7
    rooms = 4

 //<<" constructor %I $_cobj setting  $floors  $rooms\n"
<<" constructor setting  $floors  $rooms\n"


   area = floors * 200

 }

}


////////////////////////////////////

  building A


  A->print()

  nf = A->getfloors()

<<" $nf \n"

  building C[10]

<<" done object array[10] declare ! \n"


  C[1]->print()



<<"  return n floors for [1] \n"

   n = 2
  C[n]->setfloors(16)
  C[n]->print()

<<"  return n floors for [${n}] \n"


  nf = C[1]->getfloors()

<<"%V $nf \n"








  CheckNum(nf,7)

  j = 3

  C[j]->setfloors(12)

  C[j]->print()

  nf = C[j]->getfloors()

<<" $nf \n"





//////// FIX ////////////
//  sz= C->Caz()
// <<" %v $sz \n"
///////////////////////


  nrms = C[0]->getrooms()
  <<" C[0] rooms $nrms \n"

  CheckNum(nrms,4)

<<" main refer %i $C   [0] \n"
  C[0]->setrooms(56)

nrms = C[0]->getrooms()




<<" main refer %i $C   [1] \n"
  C[1]->setrooms(12)

<<" main refer %i $C   [2] \n"
  C[2]->setrooms(14)

<<" main refer %i $C   [3] \n"
  C[3]->setrooms(16)

<<" main refer %i $C   [4] \n"
  C[4]->setrooms(14)

  C[0]->setfloors(5)

  C[1]->setfloors(10)

  C[2]->setfloors(15)

/// MF
  nf = C[2]->getfloors()
  CheckNum(nf,15)

  nr = C[4]->getrooms()
  CheckNum(nr,14)


// FIX  CheckNum( C[4]->getfloors(),14)






<<" test  object accessor functions\n"

  nf=   C[0]->getfloors()
<<"  C[0]->floors  $nf \n"
  nf=   C[1]->getfloors()
<<"  C[1]->floors  $nf \n"
 j = 2
  nf=   C[j]->getfloors()
<<"  C[j]->floors  $nf \n"

CheckNum(nf,15)





<<" test  direct public reference\n"

  a=   C[0]->floors
<<"  %I $C[0]->floors  $a \n"
CheckNum(a,5)

  a=   C[1]->floors

<<"  C[1]->floors  $a \n"

  j = 2

  a=   C[j]->floors
<<" %I $C[j]->floors  $a \n"
CheckNum(a,15)





<<" Single object ! \n"

   building b

   b->print()

   nf = b->getfloors()

<<" $nf \n"

<<" setting floors to 17 !\n"
   b->setfloors(17)

   bnf = b->getfloors()

<<" %v $bnf \n"
   b->setrooms(16)
   b->print()




  nrms = C[1]->getrooms()
  <<" C[1] rooms $nrms \n"

  C[2]->setrooms(99)

  C[4]->setrooms(44)


  nrms = C[2]->getrooms()
  <<" C[2] rooms $nrms \n"


  nrms = C[0]->getrooms()
  <<" C[0] rooms $nrms \n"


  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getrooms()
  <<" %V $i $nrms \n"
  }


  nrms = C[2]->getrooms()
  <<" C[2] rooms $nrms \n"

  nrms = C[1]->getrooms()
  <<" C[1] rooms $nrms \n"

  for (i = 0 ; i < 5 ; i++) {
   C[i]->setrooms(i)
   nrms = C[i]->getrooms()
  <<" %V $i $nrms \n"
  }


  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getrooms()
  <<" %V $i $nrms \n"
  }

  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getrooms()
  <<" %V $i $nrms \n"
  }

  for (i = 0 ; i < 5 ; i++) {
   C[i]->setrooms(i+15)
   nrms = C[i]->getrooms()
  <<" %V $i $nrms \n"
  }



   building bz

   bz->print()

   nf = bz->getfloors()

<<" $nf \n"

   bz->setfloors(17)

   bnf = bz->getfloors()

<<" %v $bnf \n"

   bz->print()





   d = bz

   d->setfloors(11)

   d->print()

   c = d

   c->print()

   c->setfloors(12)

   cnf = c->getfloors()

<<" %v $cnf \n"

   dnf = d->getfloors()

<<" %v $dnf \n"

    IF (dnf != bnf )
  <<" object copy fail! \n"
    else
  <<" object copy success! \n"


   dnf = d->getfloors()

<<" %v $dnf \n"

   cnf = c->getfloors()

<<" %v $cnf \n"

   d->setfloors(12)

   dnf = d->getfloors()

<<" %v $dnf \n"

   d->print()

   bz->setfloors(60)

   bz->print()

   d->print()

   cnf = c->getfloors()

<<" %v $cnf \n"

   bz->setfloors(30)

   nf = bz->getfloors()

<<" $nf \n"


//  bptr = &C[0]


//  sz = C->Caz()

// <<" %v $sz \n"

  nf = C[1]->getfloors()

<<" $nf \n"

  C[0]->setfloors(6)

  C[0]->setrooms(12)

//  C[1]->setfloors(9)

  nf = C[1]->getfloors()

<<" $nf \n"



  C[2]->setfloors(96)

  C[3]->setfloors(69)

//  C[3]->setrooms(22)

  C[4]->setfloors(54)

  C[4]->setrooms(100)

  nf = C[2]->getfloors()

<<" $nf \n"


  nf = C[1]->getfloors()

<<" $nf \n"

  nf = C[3]->getfloors()

<<" $nf \n"

  nr = C[4]->getrooms()

<<" %v $nr \n"

  i = 3

  nf = C[i]->getfloors()

<<" $nf \n"
  j = 2
  for (i = 0 ; i < 5 ; i++) {

  C[i]->setfloors(j)
  nf = C[i]->getfloors()
  nr = C[i]->getrooms()

<<" %V $i $nf $nr \n"
   j += 2
  }




  for (i = 0 ; i < 5 ; i++) {

  C[i]->setfloors(i+1)

  C[i]->setrooms(i*4+2)

<<" setfloors $i  \n"

  nf = C[i]->getfloors()
  nr = C[i]->getrooms()

<<" %V $i $nf $nr \n"

  }


  nf = C[2]->getfloors()

<<" $nf \n"


  C[2]->setfloors(8)

  nf = C[2]->getfloors()

<<" $nf \n"


  C[1]->setfloors(7)
  j = 1
 while (j < 4) {
  C[j]->setfloors(66)
  nf = C[j]->getfloors()
<<" $j $nf \n"
  j++
 }



#{
setdebug(-1)
// will cause error -- want to ignore and run on
<<" accessing outside of object array \n"

  nf = C[6]->getfloors()

<<" $nf \n"
#}



CheckOut()
stop!



;
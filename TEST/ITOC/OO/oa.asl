///
/// test object arrays
///


CheckIn()

setDebug(1,@trace,@~soe)

int x = 5;

<<" %v $x \n"

float V[10]

V[5] = 7

<<" $V \n"

int Bid =0;

CLASS Building {

 int rooms = 5;
 int floors = 2;
 int area ;
 int id;
 CMF setRooms(val)
 {
//  <<" $_proc %I $_cobj  $rooms $floors $area \n"
  <<" $_proc  $_cobj  $rooms $floors $area \n"
   rooms = val;
 }

 CMF getRooms()
 {
   return rooms 
 }

 CMF setFloors(val)
 {
 
   floors = val;
<<" $_cobj $_proc $id $val $floors \n"
   area = floors * 200;
//   my->print()
 }

 CMF getFloors()
 {
//   <<" $_proc $(cclass()) -> getFloors $floors \n"
   <<"$_proc  $id  $floors \n"
   return floors;
 }

 CMF Print()
 {
  <<" $_proc $_cobj %V $id \n $rooms \n $floors \n $area \n"
 }

 CMF Building()
 {

    floors = 7;
    rooms = 4;

 //<<" constructor %I $_cobj setting  $floors  $rooms\n"

   area = floors * 200;
   id = Bid++;
<<" constructor setting  $id $floors  $rooms\n"
}

}


////////////////////////////////////


  Building C[10]

<<" done object array[10] declare ! \n"


  C[1]->Print()

  C[2]->setFloors(15);

  C[2]->Print();


/// MF
  nf = C[2]->getFloors()

<<"%V $nf\n"

 CheckNum(nf,15)





<<"  return n floors for [1] \n"

   n = 2;

  C[n]->setFloors(16);
  
  C[n]->Print()

<<"  return n floors for [${n}] \n"

  nf = C[1]->getFloors()

<<"%V $nf \n"

  CheckNum(nf,7)

  nf = C[n]->getFloors()

<<"%V $nf \n"

  CheckNum(nf,16)





  j = 3

  C[j]->setFloors(12)

  C[j]->Print()

  nf = C[j]->getFloors()

<<" $nf \n"


  nrms = C[0]->getRooms()
  <<" C[0] rooms $nrms \n"

  CheckNum(nrms,4)

<<" main refer %i $C   [0] \n"
  C[0]->setRooms(56)

nrms = C[0]->getRooms()




<<" main refer %i $C   [1] \n"
  C[1]->setRooms(12)

<<" main refer %i $C   [2] \n"
  C[2]->setRooms(14)

<<" main refer %i $C   [3] \n"
  C[3]->setRooms(16)

<<" main refer %i $C   [4] \n"

  C[4]->setRooms(14)

  C[0]->setFloors(5)

  C[1]->setFloors(10)



  C[4]->Print();

  nr = C[4]->getRooms()
  
  CheckNum(nr,14)



// FIX  CheckNum( C[4]->getFloors(),14)






<<" test  object accessor functions\n"
  C[2]->setFloors(15);
 
  nf=   C[0]->getFloors()
<<"  C[0]->floors  $nf \n"
  nf=   C[1]->getFloors()
<<"  C[1]->floors  $nf \n"
  j = 2;

 nf=   C[j]->getFloors()
<<"  C[j]->floors  $nf \n"

CheckNum(nf,15)

CheckOut()



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

   Building b

   b->Print()

   nf = b->getFloors()

<<" $nf \n"

<<" setting floors to 17 !\n"
   b->setFloors(17)

   bnf = b->getFloors()

<<" %v $bnf \n"
   b->setRooms(16)
   b->Print()




  nrms = C[1]->getRooms()
  <<" C[1] rooms $nrms \n"

  C[2]->setRooms(99)

  C[4]->setRooms(44)


  nrms = C[2]->getRooms()
  <<" C[2] rooms $nrms \n"


  nrms = C[0]->getRooms()
  <<" C[0] rooms $nrms \n"


  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }


  nrms = C[2]->getRooms()
  <<" C[2] rooms $nrms \n"

  nrms = C[1]->getRooms()
  <<" C[1] rooms $nrms \n"

  for (i = 0 ; i < 5 ; i++) {
   C[i]->setRooms(i)
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }


  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }

  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }

  for (i = 0 ; i < 5 ; i++) {
   C[i]->setRooms(i+15)
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }

  Building A


  A->Print()

  nf = A->getFloors()

<<" $nf \n"


   Building bz

   bz->Print()

   nf = bz->getFloors()

<<" $nf \n"

   bz->setFloors(17)

   bnf = bz->getFloors()

<<" %v $bnf \n"

   bz->Print()





   d = bz

   d->setFloors(11)

   d->Print()

   c = d

   c->Print()

   c->setFloors(12)

   cnf = c->getFloors()

<<" %v $cnf \n"

   dnf = d->getFloors()

<<" %v $dnf \n"

    IF (dnf != bnf )
  <<" object copy fail! \n"
    else
  <<" object copy success! \n"


   dnf = d->getFloors()

<<" %v $dnf \n"

   cnf = c->getFloors()

<<" %v $cnf \n"

   d->setFloors(12)

   dnf = d->getFloors()

<<" %v $dnf \n"

   d->Print()

   bz->setFloors(60)

   bz->Print()

   d->Print()

   cnf = c->getFloors()

<<" %v $cnf \n"

   bz->setFloors(30)

   nf = bz->getFloors()

<<" $nf \n"


//  bptr = &C[0]


//  sz = C->Caz()

// <<" %v $sz \n"

  nf = C[1]->getFloors()

<<" $nf \n"

  C[0]->setFloors(6)

  C[0]->setRooms(12)

//  C[1]->setFloors(9)

  nf = C[1]->getFloors()

<<" $nf \n"



  C[2]->setFloors(96)

  C[3]->setFloors(69)

//  C[3]->setRooms(22)

  C[4]->setFloors(54)

  C[4]->setRooms(100)

  nf = C[2]->getFloors()

<<" $nf \n"


  nf = C[1]->getFloors()

<<" $nf \n"

  nf = C[3]->getFloors()

<<" $nf \n"

  nr = C[4]->getRooms()

<<" %v $nr \n"

  i = 3

  nf = C[i]->getFloors()

<<" $nf \n"
  j = 2
  for (i = 0 ; i < 5 ; i++) {

  C[i]->setFloors(j)
  nf = C[i]->getFloors()
  nr = C[i]->getRooms()

<<" %V $i $nf $nr \n"
   j += 2
  }




  for (i = 0 ; i < 5 ; i++) {

  C[i]->setFloors(i+1)

  C[i]->setRooms(i*4+2)

<<" setFloors $i  \n"

  nf = C[i]->getFloors()
  nr = C[i]->getRooms()

<<" %V $i $nf $nr \n"

  }


  nf = C[2]->getFloors()

<<" $nf \n"


  C[2]->setFloors(8)

  nf = C[2]->getFloors()

<<" $nf \n"


  C[1]->setFloors(7)
  j = 1
 while (j < 4) {
  C[j]->setFloors(66)
  nf = C[j]->getFloors()
<<" $j $nf \n"
  j++
 }



#{
setdebug(-1)
// will cause error -- want to ignore and run on
<<" accessing outside of object array \n"

  nf = C[6]->getFloors()

<<" $nf \n"
#}



CheckOut()

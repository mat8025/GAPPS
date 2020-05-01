# test  inheritance

checkIn()

class building {

 int rooms
 int floors
 int area

 CMF setrooms(int val)
 {
   rooms = val
 }

 CMF getrooms()
 {
   return rooms 
 }

 CMF setfloors(int val)
 {
   floors = val
 }

 CMF getfloors(val)
 {
 <<" in getfloors \n"
   return floors

 }

 CMF print()
 {
   <<"$_cobj has %V $rooms $floors\n"
 }


 CMF building()
 {
  <<"$_proc constructor \n"
  floors = 2
  rooms = 4
 }

}


<<" finished class def building \n"


class house : building {

  int bedrooms;
  int baths

 CMF setbaths(val)
 {
   baths = val
 }

 CMF getbaths()
 {
   return baths
 }


 CMF print()
 {
  
  rr = getrooms()
  ff = getfloors()
  <<"%V $_cobj $bedrooms $baths $ff\n"
  <<"$_cobj has $bedrooms bedrooms $baths bathrooms and $ff floors $rr rooms %V $rooms $floors\n"

 }


 CMF house()
 {
   <<"$_proc  constructor \n"
   bedrooms = 1
   baths = 1
   <<"$_proc  %V $rooms $floors $baths\n"
 }

}


<<" finished class def house \n"

class room : house {

  int chairs;

 CMF setchairs(val)
 {
   chairs = val
 }

 CMF getchairs()
 {
   return chairs
 }

 CMF room()
 {
  <<" $_proc CONS \n"
  chairs = 2
 }

}

<<" finished class def room \n"

   building b

// only initial constructor is called at the moment

   nr = 0

   nr = b->getrooms()

<<" %v $nr \n"

   mr = 25

<<"reset rooms to $mr \n"

   b->setrooms(mr)

   nr = b->getrooms()

<<"%v $nr \n"
   b->setfloors(6)
   b->print()

<<"make a house \n"

   house h


<<"after house $h \n"

   h->print()



   nr = h->getrooms()

<<"%v $nr \n"


   h->setrooms(5)

   h->setfloors(3)

   h->print()




   b->print()


   h->setrooms(7)
   h->setfloors(12)


   h->print()

   hf = h->floors

<<"%v $hf \n"

   hr = h->rooms

<<"%v $hr \n"


   hr = h->getrooms()

<<"%v $hr \n"





   nr = h->getrooms()

<<" %v $nr \n"

   h->setrooms(18)

   nr = h->getrooms()

<<" %v $nr \n"

   h->setbaths(20)

   nbaths = h->getbaths()

<<" %v $nbaths \n"

<<" make house c \n"

   house c

<<" after house c dec !! \n"

   c->print()   


<<" make house d \n"

   house d

   d->print()   


   room r

<<" after room 1\n"

   int nf

   nf = r->getfloors()

  CheckNum(2,nf)

<<" grandparent constructor called %v $nf  from room object\n"



   rnf = 10

<<" now set %v $rnf building member from room object \n"

   r->setfloors(rnf)

// can reach back to grandparent !! ok
// parent constructor is called

   nf = r->getfloors()

<<" %I $nf \n"

  CheckNum(nf,10)

   r->print()

   r->setbaths(3)

   nb = r->getbaths()

   r->print()

<<" baths $nb \n"

  CheckNum(nb,3)

  CheckOut()

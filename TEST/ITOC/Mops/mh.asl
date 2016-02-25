#! /usr/local/GASP/bin/asl
# test multiple inheritance


class building {

 int rooms
 int floors
 int area

 CMF setrooms(val)
 {
   rooms = val
 }

 CMF getrooms()
 {
   return rooms 
 }

 CMF setfloors(val)
 {
   floors = val
 }

 CMF getfloors(val)
 {
   return floors
 }

 CMF building()
 {
  floors =2
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
  nf = getfloors()

  <<" %I $_cobj $bedrooms $baths $nf\n"

 }


 CMF house()
 {
   bedrooms = 1
   baths = 1
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
  <<" $_cproc CONS \n"
  chairs = 2
 }


}


<<" finished class def room \n"



   building b


// only initial constructor is called at the moment

   nr = 0

   nr = b->getrooms()

<<" %v $nr \n"

   b->setrooms(25)

   nr = b->getrooms()

<<" %v $nr \n"

<<" prior to house \n"

   house h

<<" after house 1\n"

<<" after house 2\n"

   nr = h->getrooms()

<<" %v $nr \n"

   h->setrooms(18)

   nr = h->getrooms()

<<" %v $nr \n"

   h->setbaths(20)

   nbaths = h->getbaths()

<<" %v $nbaths \n"

   house c

<<" after house dec !! \n"

   c->print()   

   house d


   d->print()   


   room r

<<" after room 1\n"

<<" after room 2\n"


   nf = r->getfloors()

<<" grandparent constructor called %v $nf  from room object\n"

   rnf = 10

<<" now set %v $rnf building member from room object \n"

   r->setfloors(rnf)

// can reach back to grandparent !! ok
// parent constructor is called

   nf = r->getfloors()

<<" %I $nf \n"


   r->print()

STOP("DONE!\n")

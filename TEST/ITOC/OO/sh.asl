//%*********************************************** 
//*  @script sh.asl 
//* 
//*  @comment test inheritance 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.48 C-He-Cd]                                
//*  @date Tue May 19 07:46:56 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();

checkIn(_dblevel)

class building {

 int rooms
 int floors
 int area

 cmf setrooms(int val)
 {
   rooms = val
 }

 cmf getrooms()
 {
   return rooms 
 }

 cmf setfloors(int val)
 {
   floors = val
 }

 cmf getfloors(val)
 {
 <<" in getfloors \n"
   return floors

 }

 cmf print()
 {
   <<"$_cobj has %V $rooms $floors\n"
 }


 cmf building()
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

 cmf setbaths(val)
 {
   baths = val
 }

 cmf getbaths()
 {
   return baths
 }


 cmf print()
 {
  
  rr = getrooms()
  ff = getfloors()
  <<"%V $_cobj $bedrooms $baths $ff\n"
  <<"$_cobj has $bedrooms bedrooms $baths bathrooms and $ff floors $rr rooms %V $rooms $floors\n"

 }


 cmf house()
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

 cmf setchairs(val)
 {
   chairs = val
 }

 cmf getchairs()
 {
   return chairs
 }

 cmf room()
 {
  <<" $_proc CONS \n"
  chairs = 2
 }

}
//======================================//
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

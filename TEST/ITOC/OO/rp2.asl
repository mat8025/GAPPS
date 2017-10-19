CheckIn()

setdebug(1)

class house {

  int rooms
  int floors
  int area

 CMF setrooms(val)
 {
  <<" $_proc  $_cobj  $rooms $floors  \n"
   rooms = val
   return rooms
 }

 CMF setfloors(val)
 {
   if (floors > 0) {
   floors = val
   area = floors * 200
   }  
   return area
 }

 CMF getrooms()
 {
   return rooms 
 }

 CMF print()
 {
  <<" $_cobj has %V $floors and  $rooms $area\n"
 }


 CMF house()
 {
    floors = 7
    rooms = 4
    area = floors * 200  
 <<" constructor for $_cobj setting  $floors  $rooms $area\n"
 }

}

<<" after our class definition \n"
setdebug(1)
 int IV[7]

IV[3] = 3
<<"$IV\n"

 house C[6]

<<" myhouse is $(typeof(&house)) \n"

<<" myhouse is $(typeof(C)) \n"

<<"sz $(Caz(C)) \n"

 C[1]->print()

 y = C[2]->getrooms()

<<"house 2 has $y rooms \n"

 C[3]->setrooms(15)

 y = C[3]->getrooms()

<<"house 3 has $y rooms \n"

a = 4

 C[a]->setrooms(17)


 y = C[a]->getrooms()

<<"house $a has $y rooms \n"

 x=C[a+1]->setrooms(19)


 y = C[a+1]->getrooms()

<<"house ${a}+1 has $y rooms \n"

 a= 3

 y = C[a]->getrooms()

<<"house $a has $y rooms \n"

 y = C[a-1]->getrooms()

<<"house $a -1 has $y rooms \n"


 x=C[a+1]->setrooms(C[a]->getrooms())

<<"house ${a}+1 has $x rooms \n"

 x=C[a+1]->setrooms(C[a-1]->getrooms())

<<"house ${a}+1 has $x rooms \n"

 x=C[a]->setrooms(C[a-2]->getrooms())

<<"house ${a} has $x rooms \n"

 x=C[a-2]->setrooms(22)




 x=C[a+1]->setrooms(C[a-1]->getrooms()) + C[a]->setrooms(C[a-2]->getrooms()) 

<<"house $(a+1) and $a have $x rooms \n"

CheckNum(x,26)

  C[3]->setfloors(3)
  C[5]->setfloors(9)


  for (a= 0 ; a < 6 ; a++) {
  <<" $a "
    C[a]->print()

  }

CheckOut()


stop!

;

 C[1]->setrooms(8)
 C[1]->setfloors(3)


<<" obj 1 : \n"
 C[1]->print()
<<" obj 2 : \n"
 C[2]->print()


 z= C[1]->getrooms()

<<" obj 1 has  $z rooms \n"


 z= C[2]->getrooms()

<<" obj 2 has  $z rooms \n"

;

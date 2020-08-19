
int I[10]

 a= 1

 I[a] = 5

<<" $I \n"


  y = I[a]

<<"%V $y \n"

 b = 2

 I[a+b] = 65119

<<" $I \n"

  y = I[a+b]

<<"%V $y \n"


class house {

  int rooms
  int floors
  int area

 CMF setrooms(val)
 {
  <<" $_proc  $_cobj  $rooms $floors  \n"
   rooms = val

 }

 CMF setfloors(val)
 {
   if (floors > 0) {
   floors = val
   area = floors * 200
   }  
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
 <<" constructor  $_cobj setting  $floors  $rooms $area\n"
   

 }

}


 house C[5]



 
 C[1]->print()

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

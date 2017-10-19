# test object arrays

//setDebug(1)

CLASS building {

 int rooms 
 int floors = 2
 int area 

 CMF setrooms(val)
 {
  <<" $_proc %I $_cobj  $rooms $floors $area \n"
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
    rooms = 4
    floors = 2
 <<" constructor %I $_cobj $rooms\n"
 }

}


////////////////////////////////////

  building A

<<" moving on \n"

  building B

  building C[3]

  A->setfloors(12)
  B->setfloors(13)
  B->print()
  A->print()


stop!

//  A->print()
//  nf = A->getfloors()

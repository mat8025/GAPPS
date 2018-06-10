# test object arrays

<<" testing object arrays \n"
int x = 5

Setdebug(1)


CLASS building {

 int rooms = 5
 int floors = 10
 int area = 600

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

 CMF getfloors()
 {
//   <<" $_cproc $(cclass()) -> getfloors $floors \n"
   <<" $_cproc  -> getfloors $floors \n"
   return floors
 }

 CMF print()
 {

  <<" $_cproc -> %V $rooms $floors $area \n"
 }

 CMF building()
 {
    floors = 7
 <<" cons setting floors $floors \n"
//  rooms = 4
    area = 1000
 }

}



////////////////////////////////////



  building C[7]

<<"  declare array of buildings !! \n"
<<"%I $C \n"

<<" get size of object array \n"
  sz = Caz(C)

 <<" %v $sz \n"




  nf = C[1]->getfloors()

<<"number of floors on building 1 $nf \n"



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

  for (i = 0 ; i < 5 ; i++) {

    nf = C[i]->getfloors()

    nr = C[i]->getrooms()

    <<" %V $i $nf $nr \n"

  }



  for (i = 0 ; i < 5 ; i++) {

  C[i]->setfloors(i+1)

  C[i]->setrooms(i*4+2)

<<" setfloors $i  \n"

  }

  for (i = 0 ; i < 5 ; i++) {

  nf = C[i]->getfloors()

  nr = C[i]->getrooms()

<<" %V $i $nf $nr \n"

  }




  nf = C[2]->getfloors()

<<" $nf \n"


wo = 4

  nf = C[wo]->getfloors()

<<" %V $wo $nf \n"



<<" completed !! \n"
exit();


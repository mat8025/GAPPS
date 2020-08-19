# test  multiple inheritance

chkIn()

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

 CMF print()
 {
   <<"$_cobj has %V $rooms $floors\n"
 }


 CMF building()
 {
  <<"$_cobj constructor \n"
  floors = 2
  rooms = 4
 }

}


<<" finished class def building \n"

   building b

   b->print()



class A {

 int x;

 CMF setval(val)
 {
   x = val
 }

 CMF getval()
 {
   return x 
 }


 CMF print()
 {
   <<"$_cobj has %V $x\n"
 }


 CMF A()
 {
  <<"$_cobj constructor \n"
   x = 4
 }

}

<<" finished class A  \n"


class B {

 int y

 CMF setval(val)
 {
   y = val
 }

 CMF getval()
 {
   return y 
 }


 CMF print()
 {
   <<"$_cobj has %V $y\n"
 }


 CMF B()
 {
  <<"$_cobj constructor \n"
   y = 4
 }

}


<<" finished class B  \n"


class C : A : B {

  int z;

 CMF print()
 {
  <<"$_cobj has %V $x $y $z\n"

 }


 CMF C()
 {
   <<"$_proc  constructor \n"
   z = 3
 }

}

<<" finished class C  \n"

  A a ;
  
  a->print()

  B bc

  bc->print()

  C c


  c->print()

  c->y = 56

  c->setval(77)

  c->print()

  v = c->getval()

  chkN(c->y,56)
  chkN(v,77)

   chkOut()

//STOP("DONE!\n")



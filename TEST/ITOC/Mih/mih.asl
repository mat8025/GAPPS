//%*********************************************** 
//*  @script mih.asl 
//* 
//*  @comment test ineritance 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.48 C-He-Cd]                                
//*  @date Tue May 19 07:30:42 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
# test  multiple inheritance

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

 cmf getfloors()
 {
   return floors
 }

 cmf print()
 {
   <<"$_cobj has %V $rooms $floors\n"
 }


 cmf building()
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

 cmf setval(int val)
 {
   x = val
 }

 cmf getval()
 {
   return x 
 }


 cmf print()
 {
   <<"$_cobj has %V $x\n"
 }


 cmf A()
 {
  <<"$_cobj constructor \n"
   x = 4
 }

}
//======================================//
<<" finished class A  \n"


class B {

 int y

 cmf setval(int val)
 {
   y = val
 }

 cmf getval()
 {
   return y 
 }


 cmf print()
 {
   <<"$_cobj has %V $y\n"
 }


 cmf B()
 {
  <<"$_cobj constructor \n"
   y = 4
 }

}
//======================================//

<<" finished class B  \n"


class C : A : B {

  int z;

 cmf print()
 {
  <<"$_cobj has %V $x $y $z\n"

 }


 cmf C()
 {
   <<"$_proc  constructor \n"
   z = 3
 }

}
//======================================//
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

  checkNum(c->y,56)

  checkNum(v,77)

  checkOut()





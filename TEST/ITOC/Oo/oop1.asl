#! /usr/local/GASP/bin/asl
# test oop features

//set_debug(1,"pline")


N = $2

int vy = 6;

int mx
int my

proc poo( r)
{

 <<" $_cproc $r \n"
}


  mx = 500

 CLASS fruit  {

#  variable list

   public:

   int x;

   private:
   
   int y;
   
   float z;

   int edible;
  
   public:

   svar color;

#  method list

   CMF fob () {

      <<" fruit_foo \n"

   }

   CMF add () {
     z = x + y
   }

   CMF sub () {
     z = x - y
   }

   CMF mul () {
     z = x * y
   }

   CMF div () {
     z = x / y
   }

   CMF print () {
      <<" $_cproc $_cobj    %V $color  $x $y $z \n"
   }

   CMF foo () {
  
  <<" fruit_foo \n"

     sub()

     x  = z

     mul()

     print()

//    my->mul()

   }


   CMF set_x (val) {
       <<" $_cproc setting x to $val \n"
       x = val

   }

   CMF get_x() {
       <<" $_cproc returning  $x \n"
      return x
   }

   CMF set_color (val) {
       color = val
   }

   CMF set_y (val) {
       y = val
   }

   CMF get_z() {
 
//   <<" $cproc %v $z \n"

   <<" %v $z \n"

   <<" $_cproc \n"

       return z 
   }

// constructor

  CMF fruit()     {

      <<" doing $_cproc fruit constructor for $_cobj \n"

       x = 1
       y = 1
       z = 3

       color = "white"

      <<" fruits %V $color  $x $y $z \n"

    }


 }

# object declaration

 fruit apple

<<" doing class member assign \n"

//  apple->print()


  apple->x = 10


 <<" %V  $apple->x \n"

  apple->print()

  apple->set_x(5)
  apple->set_color("blue")

 <<" %V  $apple->x \n"

  apple->print()

  apple->set_x(7)
  apple->print()

 fruit orange

  orange->x = 7
  orange->set_x(69)
  orange->set_color("orange")
  orange->print()
  apple->print()

  orange->set_y(1771)
  orange->print()
  k = 1776
  orange->set_y(k)
  orange->print()

  k = 0


  while (k < N) {
  <<" $k \n"

  apple->set_x(k)
  apple->print()

  orange->set_x(k)
  orange->print()

  k++

  }


STOP!

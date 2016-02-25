#! /usr/local/GASP/bin/asl
# test oop features
//setdebug(2,"step")

setdebug(0)

<<"%v $_proc \n"
<<"%v $_pstack \n"

# class definition


 CLASS fruit  {

#  variable list

   public:

   int x ;

   private:
   
   int y;
   
   float z;
   int j;
   int edible;
  
   public:

   str color

#  method list

   CMF fob () 
   {

      <<" fruit_foo \n"

   }

   CMF add () {
     z = x + y
   }

   CMF sub () {
     z = x - y
   }

   CMF mul () {
#     <<" doing mul \n"
     z = x * y
   }

   CMF div () {
     z = x / y
   }

   CMF print () {
 
     <<"%V $_proc of $_cobj   %V $color  $x $y $z  $j\n"
      j++
   }

   CMF foo () {
  
  <<" fruit_foo $x $y $z\n"

    my->mul()

    print()

    sub()

    print()

    div()

    print()

// use a main proc inside CMF

    ::sub()

 <<" done foo ! \n"

   }

   CMF set_x (val) {

    //   <<" $_proc setting x to $val \n"
   <<" setting x to $val \n"

       x = val
   }

   CMF get_x() {
       <<" $_proc returning  $x \n"
      return x
   }

   CMF set_color (val) {
       color = val
   }

   CMF set_y (val) {
<<" $_proc %v $val \n"
       y = val
   }

   CMF set_z (val) {
       z = val
   }

   CMF get_z() {
 
//   <<" $cproc %v $z \n"

   <<" %v $z \n"

   <<" $_cproc \n"

       return z 
   }

// constructor

  CMF fruit()
    {
     <<" doing fruit constructor for $_cobj \n"
  <<"%v $_pstack \n"
  //   <<" fruits %V $color  $x $y $z \n"
       x = 5
       y = 1
       z = 3
       j = 1
       color = "white"
      <<" fruits %V $color  $x $y $z \n"
    }

 }

<<" after class definition !\n"
<<"%v $_proc \n"
<<"%v $_pstack \n"


 proc sub()
  {
  <<"%v $_proc IN \n"
  <<"%v $_pstack \n"
    Z += X + Y 
  <<" $_cproc %v $Z \n"
  <<" $_cproc OUT \n"
  }


 proc tree()
 {

 <<"$_proc tree IN\n"
  <<"%v $_pstack \n"
  int pip
  fruit cherry
<<" after $_cobj declare \n"

  cherry->set_y(5)
  cherry->set_color("black")
  cherry->mul()
  cherry->print()
  cherry->set_y(7)
  cherry->print()
 <<"$_proc OUT\n"
 }

<<" after procs \n"
<<"%v $_proc \n"
<<"%v $_pstack \n"

# object declaration

 fruit apple

<<" after object declaration !\n"
 
# set some globals

int Z = 0
X = 1
Y = 2

<<"%I $Z \n"

 <<" %V  $apple->x \n"

<<" doing class member assign \n"
   apple->x = 8

 <<" %V  $apple->x \n"




  apple->set_y(5)
  apple->set_color("green")

  apple->mul()
  apple->print()



  aval = 13

  apple->set_y(aval)
  apple->print()


  apple->foo()
  apple->print()

<<"%I $Z \n"

//<<" finished cclass should be null now !! \n"



  fruit orange
<<" before sub !\n"

  sub()

<<" after sub ! %v $_proc\n"
<<" before tree() !\n"

  tree()

<<" after tree() !\n"

  apple->print()
  apple->print()

<<"%v $_proc \n"
<<"%v $_pstack \n"




// has to be obj references
PROC objcopy(fruit oba,  fruit obb)
{

<<" $oba \n"

    oba->print()

<<" $obb \n"

    obb->print()

<<" copying x \n"

    oba->x = obb->x
    oba->y = obb->y

 //   oba->color = obb->color

    oba->print()
}


PROC salad()
{

  fruit blackberry

  blackberry->print()

  blackberry->set_color("black")

  blackberry->set_x(64)

  blackberry->print()

  blueberry = blackberry

  blueberry->set_color("blue")

  blueberry->set_y(26000)

  blueberry->print()
}


# object declaration

// fruit apple


 fruit orange

# set object vars


  apple->print()


<<" doing class member assign \n"

 apple->x = 4

 <<" %V  ${apple->x} \n"

  apple->set_x(5)

  apple->get_x()

  ax= apple->get_x()

 <<" %v $ax \n"

  apple->print()

  apple->set_color("green")

 apple->print()

  orange->set_y(19)

  orange->set_color("orange")

  apple->print()

  orange->print()



<<" obj copy orange apple \n"

 objcopy( &orange, &apple)

  orange->print()

  orange = apple

<<" orange should be apple now \n"

  orange->print()

STOP!


\\\\\  apple->add()



  salad()


  orange->print()


  apple->set_x(69)

  apple->set_y(71)

  apple->print()

  apple->add()

  apple->print()

  apple->mul()

  apple->print()

  apple->div()

  apple->print()



 <<" %V  $apple->color \n"


  apple->get_z()

  az = apple->get_z()

<<" %v $az \n"



  apple->fob()

  apple->sub()

  apple->print()


  apple->mul()

  apple->print()


  apple->foo()


  apple->set_x(9)

  apple->print()

  apple->mul()

  apple->print()



 //<<" %V $(apple->get_x())  \n"





  apple->add()

// <<" %V $apple->x + $apple->y = $apple->z \n"
  apple->print()

  apple->sub()


  apple->print()

  apple->foo()

 // apple->z = apple->x + apple->y    
// <<" %V  $apple->z \n"

// az = apple->z




# inspect object


// <<" %V $apple->x $apple->z \n"


# class member function

  apple->add()


  apple->print()

STOP!


int ny;


 class veggie {

#  variable list
   public:

   int vx;
   
// ERROR FIX  int vy = 6 ;

   int vy = 9 

   //int vy;
   
   float vz;

#  method list


   PROC div () {
     vz = vx / vy
   }

 }



int oy;

 class cab {

#  variable list
    public:
    int cx;
    int cy;

#  method list


 }


//int py;

 class abc {

#  variable list
// check not error    int vx;
    public:   
   int x;
   int y;

#  method list

   float Y[10+] 

 }





  veggie tomatoe

//  tomatoe->vy += 2

  tomatoe->vx = 5



 <<" %V  $tomatoe->vx   $tomatoe->vy \n" 

  tomatoe->vz = tomatoe->vx / tomatoe->vy

 <<" %V  $tomatoe->vz \n"

  tomatoe->div()

 <<" %V  $tomatoe->vz \n"

STOP!


   cab taxi

   taxi->cx = 4

   taxi->cy = 8

   z= taxi->cx * taxi->cy


<<" %v $z \n"

    abc ltr

    ltr->x = ltr->y = 5

    z = ltr->x + ltr->y

<<" %v $z \n"

    ltr->Y = Fgen(20,0,2)

<<" %v $ltr->Y \n"

  STOP("DONE \n")



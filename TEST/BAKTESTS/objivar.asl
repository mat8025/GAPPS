
# test oop features

CheckIn()
CheckIn()


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
  <<" doing main proc sub \n"
  <<" $_cproc %v $Z \n"
  <<" $_cproc OUT \n"
  }


# set some globals

int Z = 0

    X = 1
    Y = 2

<<"%I $X $Y $Z \n"

# object declaration

 fruit apple
 fruit cherry

<<" after object declaration !\n"

<<" %V  $apple->x \n"

<<" doing class member assign \n"

   apple->x = 8

   apple->print()

// name substitution

   aiv = 43 

   wf = "aiv"

   $wf = 44

<<"%V $wf $aiv \n"

   wf = "apple"


   $wf->x = 9

<<"%I $wf \n"

   apple->print()

   $wf->x = 11

CheckNum(apple->x,11)


   apple->print()

   wf = "cherry"

   $wf->x = 16

   cherry->print()


CheckNum(cherry->x,16)

CheckOut()

stop!

   wf->print()


////////////////////


# test oop features

//chkIn()
//chkIn()

<<"%v $_proc \n"
<<"%v $_pstack \n"

int V = 4     // global 

<<"%I  $V \n"

# class definition


 CLASS fruit  {

#  variable list

   public:

   int x ;
   int V ;

#  method list

   CMF print () {
     <<"%V $_proc of $_cobj   %I $x  $V  \n" 
     <<"%V $_proc of $_cobj    $x  $V  \n" 

//     <<"%V $_proc of $_cobj   %I $x  $V  $_cobj->V\n"

   }

   CMF set_x (val) {

   <<" setting x to $val \n"

       this->x = val
       //my->x = val

   <<" $x \n"

   }

   CMF set_mx (x) {

   <<"%V setting $this->x to $x \n"

       this->x = x
       //my->x = val

   <<"%V $this->x  $x\n"

   }

   CMF set_GV (val) {

   <<" setting global to $val \n"

       ::V = val
   }


   CMF get_x() {

       <<" $_proc returning  $x \n"

      return x
   }

   CMF set_V (val) {
       V = val
   <<" setting V to %I $val $V\n"
   }

   CMF get_V() {

   <<" $_proc \n" 

   <<" %v $V \n"



       return V 
   }

// constructor

  CMF fruit()
    {

  <<" doing fruit constructor for %I $_cobj \n"
  <<"%v $_pstack \n"

       x = 1
       V = 33
    }

 }

<<"%v $_proc \n"
<<"%v $_pstack \n"


# object declaration

<<" %v $V \n"

 fruit apple
 fruit cherry

<<" %v $apple->V \n"

  apple->V = 45

<<" %v $apple->V \n"

  apple->set_x(5)

  apple->print()

  apple->set_mx(7)

  apple->print()


//chkOut()

STOP!

# test oop features

CheckIn()
setDebug(1)
CheckIn()

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

       x = val
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

       x = 5
       V = 33
    }

 }

<<"%v $_proc \n"
<<"%v $_pstack \n"


# object declaration

<<" %v $V \n"

 fruit apple

  apple->print()




 fruit cherry

  cherry->print()



<<" %v $apple->V \n"
  apple->V = 45
<<" %v $apple->V \n"

  CheckNum(45,apple->V)
  CheckNum(4,V)


  apple->print()


<<" after object declaration !\n"
<<" %V $V $apple->V\n"


  apple->print() 

  apple->color = "green"




  apple->V = 48

<<" %v $apple->V \n"

  V = 5

  apple->print() 

<<" %v $apple->V \n"
//    CheckOut()

  av = apple->get_V()

<<" %V $av $apple->V \n"

   apple->set_V(47)

<<" %V $av $apple->V  $V\n"

   apple->set_x(17)

  av = apple->get_V()

<<" %V $av $apple->V $V\n"

<<" %I $V \n"

  cherry->set_V(48)

  CheckNum(48,cherry->V)

  apple->print() 



  cav = cherry->get_V()

<<" %V $cav $cherry->V $V\n"

  cherry->print() 

<<" %V $V $apple->V  $cherry->V \n"

  apple->set_GV(7)

<<" %V $V $apple->V  $cherry->V \n"

  cherry->set_GV(9)


  CheckNum(V,9)

<<" %V $V $apple->V  $cherry->V \n"

CheckOut()


<<" good till here \n"
stop!
STOP!

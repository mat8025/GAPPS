///
/// test oo features
///


setDebug(1,@keep,@soe,@trace)

CheckIn();



int V = 4 ;  // global 



<<"%V $V $::V \n"

  ::V = 74;

<<"%V $V $::V \n"

<<"%I  $V \n"

<<"////////\n"

<<"%v $_proc \n"
<<"%v $_pstack \n"

# class definition


 CLASS fruit  {

#  variable list

   public:
   int x ;
   int V ;

#  method list

   CMF print () {
     <<"$_proc of $_cobj\n"
     <<" %I $x \n  $V  \n" 

     <<"%V $x  $V  \n" 


   }

   CMF set_x (val) {

   <<" setting x to $val \n"

       x = val
   }

   CMF set_GV (val) {
       ::V = val;
   <<" setting global to $val $::V \n"
    }


   CMF get_x() {

       <<" $_proc returning  $x \n"

      return x;
   }

   CMF set_V (val) {
       V = val
   <<" setting class V to %V $val $V\n"
      <<" %I $val $V\n"
   }

   CMF set_VS (val1, val2) {
          V = val1;
	  ::V= val2;
   }
   
   CMF get_V() {

   <<" $_proc \n" 
   <<" %v $V \n"
       return V ;
   }

// constructor

  CMF fruit()
    {
  <<" doing fruit constructor for %I $_cobj \n"
  <<"%v $_pstack \n"
        x = 5;

        V = 33; // should set class V not global V

       ::V= 80;


     }

 }

//===========================//
<<"%v $_proc \n"
<<"%v $_pstack \n"


# object declaration

<<"pre_obj_dec %v $V \n"


 fruit apple;

//<<"post_obj_dec %V $V $apple->V  $(apple->get_V())\n"

<<"post_obj_dec %V $V \n"
<<"%I $V\n";

<<"%V $apple->V  \n"

  apple->print();

<<"%V $apple->V \n"
  apple->set_V(47);
  
<<"%V $apple->V \n"

   apple->set_GV(79);

<<"%V $apple->V \n"
<<"%I $apple->V \n"

<<"global %V $V \n";

<<"%I $V\n"

   apple->set_VS( 88,66);
   
<<"%V $apple->V \n"
<<"global %V $V \n";

  CheckNum(66,V)

 fruit cherry

  cherry->print()



<<" %v $apple->V \n"
  apple->V = 45
<<" %v $apple->V \n"

  CheckNum(45,apple->V)



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


 exit()

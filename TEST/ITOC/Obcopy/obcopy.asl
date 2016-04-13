# test oop features
// want to show that can use &obj as an arg to deliver ptr to that object to a script procedure

setdebug(1)

Checkin()

int xyz = 1;

<<"%V $xyz \n"

  If (xyz) {
   <<" if path followed \n"
  }



<<"%v $_proc \n"
<<"%v $_pstack \n"

int GV = 4    // global
  agv = GV * 2
<<"%V$GV $agv\n"

# class definition

 CLASS fruit  {

#  variable list

   public:

   int x ;
   str color;
   str name;

   private:
   
   int y;
   
   float z;
   int j;
   int edible;

#  method list


   CMF print () {
     <<" in CMF print \n"
    // <<"CMF print %V$_proc of $_cobj   %V$color $x\n $y\n $z\n  $j\n"
 <<"CMF print %V$color $x\n $y\n $z\n  $j\n"
      j++
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
<<" $_proc %V$val \n"
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
// FIXME  <<" doing constructor for %I $_cobj \n"
  <<" doing constructor for %v $_cobj \n"
  <<"%v $_pstack \n"
  //   <<" fruits %V $color  $x $y $z \n"
       x = 5
       y = 1
       z = 3
       j = 1
       color = "white"
//   <<" fruits %I $color  $x $y $z \n"
   <<" fruits %V $color  $x $y $z \n"
    }

 }


proc foo()
{


<<"%v $_pstack \n"

   apple->color = "vermillion"

<<" %v $apple->color \n"

<<" setting $cherry->color  to $apple->color \n"

    cherry->color = apple->color

<<" %v $cherry->color \n"

    cherry->x = apple->x

<<" %v $cherry->x \n"

<<" now a cmf inside a proc \n"

    cherry->print()
}


<<" after class definition !\n"

proc eat(fruit oba)
{

    <<" $_proc $_cobj \n"

    <<" $oba->name \n"
    <<"fruit thine name is $oba->name \n"
    <<" after oba name \n"

//    oba->print()

    <<" leaving $_proc $_cobj \n"
}


proc objcopy(fruit oba,  fruit obb)
{

   // oba->print()
   // obb->print()

<<" copying $obb->color to $oba->color \n"


    oba->x = obb->x
    oba->y = obb->y

    oba->color = obb->color

 //   oba->print()
 //   obb->print()
}


<<"%V$_proc \n"
<<"%V$_pstack \n"


# object declaration

 fruit apple

<<" after object declaration !\n"

  apple->print() 

  apple->color = "green"
  apple->x = 47

//<<" %I $apple->color \n"
<<" %V $apple->color \n"
<<" %V $apple->x \n"

//stop!

  apple->print()

 fruit cherry

<<" after object declaration of $cherry !\n"
//<<" %I $cherry->color \n"
<<"%V $cherry->color \n"
  cherry->print() 
//<<" %I $apple->color \n"
<<"  $apple->color \n"

  cherry->x = 77

  cherry->color = "black"

<<"%V$cherry->color \n"
//<<"%I$cherry->x \n"

  cherry->print()
  cherry->x = 76

  cherry->print()



# set some globals

 <<" %V  $apple->x \n"

<<" doing class member assign \n"

   apple->x = 8

 <<" %V  $apple->x \n"


  apple->set_y(5)

//  apple->set_color("green")

   apple->color = "green"

<<" %v $apple->color \n"

  apple->print()




<<" %v $apple->color \n"

   fruit orange

  orange->set_y(7)

 // orange->set_color("orange")

   orange->color = "orange"

<<" %v $orange->color \n"

  orange->print()

<<" %V$orange->color \n"
<<" %V$apple->color \n"
<<" %v $cherry->color \n"
<<" %v $apple->color \n"

   apple->color = "blue"

<<"%V$apple->color \n"

<<" setting $cherry->color  to $apple->color \n"

    cherry->color = apple->color

<<"%V$cherry->color \n"

   CheckStr(cherry->color,"blue")



   cherry->print()

   foo()

   apple->name = "apple"

    <<"fruit thine name is $apple->name \n"

   eat(apple)

<<" obj now copy orange apple \n"

  apple->color = "green"
  orange->color = "orange"


  apple->print()

  orange->print()


  objcopy( &orange, &apple)  // dont use ref - objs are treated like arrays

  //  objcopy( orange, apple)

  apple->print()

  orange->print()

  CheckStr(orange->color,"green")

  CheckStr(apple->color,"green")

  CheckStr(apple->color,orange->color)

  orange->color = "orange"

  orange->print()

  apple->color = orange->color

  CheckStr(apple->color,"orange")


  apple->color = "blue"

  CheckStr(apple->color,"blue")



  apple->print()
  apple->color = "red"
  cherry->color = "black"

<<" %V $apple->color \n"

<<" %I $xyz \n"

<<" %I $apple->color \n"


//<<" %I$orange->color \n"
//<<" %I$cherry->color \n"

   apple->print()
   cherry->print()



   apple->color = "green"

//<<" %I$apple->color \n"

   apple->print()
   cherry->print()

   Checkout()



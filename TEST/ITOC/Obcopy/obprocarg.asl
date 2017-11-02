///
/// test object proc arg 
///



// want to show that can use  obj name and &obj as an arg to deliver ptr to that object to a script procedure

setdebug(1,"pline","~step","trace")

//#define ASK ans=iread();
#define ASK ;


Checkin()

int Nfruits = 0;

Class fruit  {

#  variable list

   public:

   int x ;
   str color;
   str name;

   private:
   int id;
   int y;
   float z;
   int j;

   char edible;


/////////////////////
#  method list


   CMF print () {
 <<" %V $id $color $x\n $y\n $z\n edible $(Yorn(edible))  \n"
   }


   CMF set_y (val) {
   <<" setting y to $val \n"
       y = val;
   }

   CMF get_x() {
       <<" $_proc returning  $x \n"
      return y;
   }

   CMF get_y() {
       <<" $_proc returning  $y \n"
      return y;
   }


   CMF set_color (val) {
       color = val
   }

   CMF isEdible (e) {
       edible = e;
   }


// constructor

  CMF fruit()
    {

<<" doing constructor for %v $_cobj \n"
<<"%v $_pstack \n"
       id = ++Nfruits;
       x = 5
       y = 1
       z = 3
       j = 1
       color = "white"
       edible = 0;
       name = "xxx";
<<" fruits %V $id  $color  $x $y $z \n";
   
    }
//   destructor is automatic
 }

<<" after class definition !\n"

 /////


ASK


proc eat( fruit oba)
{
    <<" $_proc $_cobj \n"
    <<"fruit thine name is $oba->name \n"
    <<" after oba name \n"
   int k = 47;
   float d = exp(1);
 <<"$k $d\n"; 

    oba->print();

 ans = iread (" is $oba->name edible ? y/n:");

 if (ans @="y") {
  oba->isEdible(1);
 }
 else {
 oba->isEdible(0);
}
   
    oba->print()

    locfruit = oba;  // locfruit is a ptr to passed in fruit

    locfruit->print()

  <<" leaving $_proc $_cobj \n"
}
//////////////

proc objcopy(fruit oba,  fruit obb)
{

<<" copying $obb->color to $oba->color \n"

   int k = 47;
   float d = exp(1);
 <<"$k $d\n";
 ASK

    oba->x = obb->x;

    oba->y = obb->y;  // y is private - should object

    oba->color = obb->color;

}
///

<<" IN MAIN\n"

ASK

# object declaration

 fruit apple;

<<" after object declaration !\n"
  apple->print();
<<"$(examine(apple))\n"


ASK

# set some object memebers

<<" doing class member assign \n"

   apple->x = 8;

 <<" %V  $apple->x \n"

  apple->set_y(5);

  apple->color = "green"
  apple->name = "Apple";

<<" %v $apple->color \n"

  apple->print() 

  eat(&apple);

  eat(apple);


ASK

 fruit cherry

<<" after object declaration of $cherry !\n"
<<"%V $cherry->color \n"

  cherry->x = 77;
  cherry->color = "black"
  cherry->isEdible(1);
  cherry->x = 76
  cherry->name = "Cherry";
  cherry->print()

/////////////////////////////////////////

   fruit orange;

<<"$(Infoof(orange))\n"

<<"$(examine(orange))\n"

  orange->set_y(7);

 // orange->set_color("orange")

   orange->color = "orange"
   orange->name = "Orange"

<<" %v $orange->color \n"
  orange->isEdible(1);
  orange->print()

<<" %V$orange->color \n"
<<" %V$apple->color \n"
<<" %V $cherry->color \n"
<<" %V $apple->color \n"

   apple->color = "blue"

<<"%V$apple->color \n"

<<" setting $cherry->color  to $apple->color \n"

    cherry->color = apple->color

<<"%V$cherry->color \n"

   CheckStr(cherry->color,"blue")


    <<"fruit thine name is $apple->name \n"



<<" obj now copy orange apple \n"

  apple->color = "green"
  orange->color = "orange"

  apple->print()

  orange->print()

// use ref - objs   are not treated like arrays ??

<<"$(examine(apple))\n"
<<"$(examine(&apple))\n"
<<"$(examine(orange))\n"
<<"$(examine(&orange))\n"
ASK


  objcopy( &orange, &apple)
  
   eat(&apple);


//  objcopy( orange, apple)

  apple->print()

  orange->print()

  eat(orange);

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


<<" %I $apple->color \n"


//<<" %I$orange->color \n"
//<<" %I$cherry->color \n"

   apple->print()

   cherry->print()

   apple->color = "green"

//<<" %I$apple->color \n"

   eat(&cherry);

   apple->print()
   cherry->print()
   orange->print()
   
   Checkout()

/{/*
  TBD:

     CMF key word -- should be redundant inside of class
     need to be able to do
     int getX();
     for both proc and cmf

/}*/
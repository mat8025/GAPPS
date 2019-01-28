//%*********************************************** 
//*  @script obcopy.asl 
//* 
//*  @comment use &obj as an arg to deliver ptr 
//*  @release CARBON 
//*  @vers 1.37 Rb Rubidium                                               
//*  @date Mon Jan 21 06:40:50 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"

debugON();

setdebug (1, @~pline, @~step, @trace) ;

#
# test oop features
#

// want to show that can use &obj as an arg
// to deliver ptr to that object to a script procedure



//#define ASK ans=iread();
#define ASK ;

Checkin(1)


proc foo(a)
{

 b= a;

 a +=1

<<"%V $a $b\n"

}
//=========================//

x=1
 foo(x)
checkNum(x,1)
<<"%V $x\n"
 foo(&x)
checkNum(x,2)
<<"%V $x\n"

checkStage("Simple var arg : value and Ref")



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
     //<<" in CMF print \n"
    // <<"CMF print %V$_proc of $_cobj   %V$color $x\n $y\n $z\n  $j\n"
      <<"%V$color $x $y $z  $j\n"
      j++;
   }


   CMF set_x (val) {

    //   <<" $_proc setting x to $val \n"
   <<" setting x to $val \n"
       x = val;
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

   <<" fruits %V $color  $x $y $z \n";
   
    }

/{/*
  CMF ~fruit()
    {
<<" doing destructor   for %v $_cobj \n"
     ASK
   }
/}*/

 }
//==================================//
<<" after class definition !\n"


 /////
proc eat(fruit oba)
{
    <<" $_proc $_cobj \n"
    <<"fruit thine name is $oba->name \n"
   
    //fruit locfruit;
    oba->info(1)   

    oba->color ="red";

    oba->print()

    locfruit = oba;

    locfruit->print()

    <<" leaving $_proc $_cobj \n"
}
//==================================//


fruit apple;

<<" after object declaration !\n"


setdebug (1, @~pline, @~step, @trace) ;

a=1
bs="la apuesta inteligente"

<<"$(bs)\n"

<<"$(testargs(a,bs))\n"


EA= examine(apple)

<<"$EA\n"

<<"class $apple\n"

<<"$(testargs(apple))\n"


<<"$(examine(apple))\n"

  apple->print();

  eat(&apple)
  apple->print();

  eat(apple);

  apple->print();

CheckOut()

exit()





proc foo2 (a)
{
<<"$a\n"

   int k = 47;
   float d = exp(1);
   str s = "hi";
<<"in $_proc $k $d\n";
<<" in foo2\n"
ASK

  fruit loc2fruit;
  loc2fruit->print()


}
///////////




ASK



proc goo()
{

<<"HEY in $_proc\n"
ASK

<<"%v $_pstack \n"

apple->color = "vermillion"

<<" %v $apple->color \n"

<<" setting $cherry->color  to $apple->color \n"

    cherry->color = apple->color

<<" %v $cherry->color \n"

    cherry->x = apple->x;

<<" %v $cherry->x \n"

<<" now a cmf inside a proc \n"

    cherry->print()
}
////////////////////////////////////






proc objcopy(fruit oba,  fruit obb)
{
<<" copying $obb->color to $oba->color \n"

    oba->x = obb->x;
    oba->y = obb->y;
    oba->color = obb->color;
}


<<" IN MAIN\n"

ASK

//<<"%V$_proc \n"
//<<"%V$_pstack \n"






ASK


# object declaration


ASK

   foo2(2);

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

   apple->x = 8;

 <<" %V  $apple->x \n"


  apple->set_y(5);

//  apple->set_color("green")

   apple->color = "green"

<<" %v $apple->color \n"

  apple->print()




<<" %v $apple->color \n"

   fruit orange;

<<"$(Infoof(orange))\n"

//<<"$(examine(orange))\n"

  orange->set_y(7);

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

   goo()

   apple->name = "apple"

    <<"fruit thine name is $apple->name \n"



<<" obj now copy orange apple \n"

  apple->color = "green"
  orange->color = "orange"


  apple->print()

  orange->print()

// use ref - objs   are not treated like arrays ??

<<"$(objinfo(apple))\n"
//<<"$(examine(&apple))\n"
//<<"$(examine(orange))\n"
<<"$(objinfo(&orange))\n"
ASK
  objcopy( &orange, &apple)

 orange->print()

ASK

   eat(&apple);
  //  objcopy( orange, apple)

   apple->print()

ASK

  orange->print()
exit()  
  eat(apple);

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



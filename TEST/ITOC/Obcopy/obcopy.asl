//%*********************************************** 
//*  @script obcopy.asl 
//* 
//*  @comment use &obj as an arg to deliver ptr 
//*  @release CARBON 
//*  @vers 1.38 Sr Strontium [asl 6.2.68 C-He-Er]                          
//*  @date Sun Aug 30 08:12:32 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug"

if (_dblevel >0) {
   debugON()
}


 chkIn(_dblevel)
#
# test oop features
#

// want to show that can use &obj as an arg
// to deliver ptr to that object to a script procedure
int pdef = 0;
proc cart (str aprg)
{

<<"%V $_proc $aprg    \n"  
   sin = aprg
   <<"%V $sin\n"
   Tp = Split(aprg,",");

<<"$Tp \n"

}
pdef++; <<"%V$pdef \n"
//=========================//
proc goo(ptr a)
{

   b = $a;

<<"%V $a $b\n"
   b->info(1)
//   $a +=1
     $a = $a +1
     
<<"%V $a $b\n"

}
pdef++; <<"%V$pdef \n"
//=========================//
proc choo (str s)
{
  // str s = "hi";

<<"$_proc  $s\n";

}
pdef++; <<"%V$pdef \n"
//==================================//


 x = 1;

 y = x;

<<"%V $x $y\n";


 goo(&x)

 x->info(1)
 
 chkN(x,2)

<<"%V $x\n"

 cart("hey,buddy")



goo(&x)

x->info(1)
<<"%V $x\n"

chkN(x,3)


checkStage("Simple var arg : value and Ref")






# class definition
int JuiceyF = 0;
class fruit  {

#  variable list

   public:

   int x ;
   str color;
   str name;
   str state;
   private:
   
   int y;
   float z;
   int j;
   int edible;

#  method list


   cmf print () {
     //<<" in cmf print \n"
      j++;
    <<"$_proc of $_cobj $j\n"
      <<"%V$name $color $state $x $y $z  $j\n"

   }


   cmf set_x (int val) {

    //   <<" $_proc setting x to $val \n"
   <<" setting x to $val \n"
       x = val;
   }

   cmf get_x() {
       <<" $_proc returning  $x \n"
      return x;
   }

   cmf set_color (str val) {
       color = val
   <<" $_proc $color \n"       
   }

   cmf get_color () {
   
    val = color;
   <<" $_proc  $val  $color\n"
       return val;
   }

   cmf set_name (str val) {
       name = val
   }

   cmf set_y (int val) {
<<" $_proc %V$val \n"
       y = val
   }

   cmf set_z (float val) {
       z = val
   }

   cmf get_z() {
 
//   <<" $cproc %v $z \n"

   <<" %v $z \n"

   <<" $_cproc \n"

       return z ;
   }

// constructor

  cmf fruit()
    {

      JuiceyF++;

//<<"%v $_pstack \n"
  
       x = 5;  y = 1;  z = 3;  j = 0;
       color = "white"
       state = "ripe"
       name = "$_cobj"

<<" cons for  $name $color $state $JuiceyF \n"  
   
    }

/{/*
  cmf ~fruit()
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


    oba->info(1)   

    oba->color ="red";
    
    oba->state = "eaten"
    
    oba->print()

 //   locfruit = oba;

 //   locfruit->print()

    <<" leaving $_proc $_cobj \n"

  // ans=query("c_obj?")
}
pdef++; <<"%V$pdef \n"
//==================================//



proc objcopy(fruit oba,  fruit obb)
{
<<"$_proc  copying $obb->color to $oba->color \n"

    oba->x = obb->x;
    oba->y = obb->y;
    oba->color = obb->color;
}
pdef++; <<"%V$pdef \n"
//==================================//


//proc foo2 (int a)
proc roo (str a)
{
   k = a;
 //  float d = exp(1);
 //  float d = 3.4;
 //  str s = "hi";
 int d;
//    d = k;
<<"$_proc $a $d \n";


// local obj
 // apple->print();
  
 // fruit peach;

 //  peach->print()
}
pdef++; <<"%V$pdef \n"
//==================================//
proc roo2 (str a)
{
   k = a;
 //  float d = exp(1);
 //  float d = 3.4;
 //  str s = "hi";
 int d;
//   d = k;
<<"$_proc $a $d \n";


//  local obj
//  apple->print();  // TBF
  
//  fruit peach; // TBF

 //  peach->print() // TBF
}







//proc goo(int noo)
proc goo()
{

<<"HEY in $_proc\n"


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
pdef++; <<"%V$pdef \n";
//==================================//
chkN(pdef,7)

//roo("que")


fruit apple;

//  apple->set_name("apple")
<<" after object declaration !\n"
fruit cherry;

goo()

apple->print()

cherry->print()

fruit orange;

orange->print()


chkStr(orange->color,"white")

//chkOut(); exit()

// test of redef of proc and use
proc goo()
{

<<"HEY2 in $_proc\n"


<<"%v $_pstack \n"

   apple->color = "purple"

<<" %v $apple->color \n"

<<" setting $cherry->color  to $apple->color \n"

    cherry->color = apple->color

<<" %v $cherry->color \n"

    cherry->x = apple->x;

<<" %v $cherry->x \n"

<<" now a cmf inside a proc \n"

    cherry->print()
}
pdef++; <<"%V$pdef \n";
//==================================//

chkN(pdef,8)


goo()

apple->print()
cherry->print()

//chkOut() ; exit();

//setdebug (1, @~pline, @~step, @trace) ;


  apple->print();

  fp = &apple;
  fp->info(1)
  
  fp->print()


a=1
bs="la apuesta inteligente"

<<"$(bs)\n"

<<"$(testargs(a,bs))\n"


EA= examine(apple)

<<"$EA\n"

<<"class $apple\n"

<<"$(testargs(apple))\n"


<<"$(examine(apple))\n"




<<"attempt to eat fruit!\n"
  eat(apple)
  
  apple->print();






<<" IN MAIN\n"



//<<"%V$_proc \n"
//<<"%V$_pstack \n"
# object declaration






  apple->print() 

  apple->color = "green"

  chkStr(apple->color,"green")

  apple->x = 80

  chkN(apple->x,80)
  
//<<" %I $apple->color \n"
<<" %V $apple->color \n"
<<" %V $apple->x \n"

  apple->print()











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

  chkStr(cherry->color,"black")

  cherry->print()
  cherry->x = 76

cherry->set_color("red")

chkStr(cherry->color,"red")

  ccol = cherry->get_color()
  
<<"%V $ccol\n"

  cherry->print()

  eat(cherry)
  
cherry->print()
  chkStr(cherry->state,"eaten")
//chkOut() ; exit();



# set some globals

 <<" %V  $apple->x \n"

<<" doing class member assign \n"

   apple->x = 8;

 <<" %V  $apple->x \n"


  apple->set_y(5);

   apple->set_color("green")

 //  apple->color = "green"

<<" %v $apple->color \n"

  chkStr(apple->color,"green")

  apple->print()




<<"%v $apple->color \n"


<<"apple:\n"
   apple->print()

   chkStr(apple->color,"green")

   apple->color="red"

   chkStr(apple->color,"red")

   apple->print()

   apple->set_color("yellow")

   chkStr(apple->color,"yellow")

   apple->print()

//<<"%v $orange->color \n"
 //  chkStr(orange->color,"white")

    roo("que")

//  orange->set_name("orange")

//<<"$(Infoof(orange))\n"

   orange->print()

   chkStr(orange->color,"white")

 // chkOut() ;  exit()


//<<"$(examine(orange))\n"

  orange->set_y(7);

  orange->set_color("pink")

<<"%v $orange->color \n"
  orange->print()

  ocol = orange->get_color();
  <<"%V $ocol \n"

  ocol = orange->color;
  <<"%V $ocol \n"
  chkStr(orange->color,"pink")

   roo2("cuando")

  //chkOut() ;  exit()

<<"attempt to eat fruit!\n"
  orange->print()

  eat(orange);

  chkStr(orange->state,"eaten")
  chkStr(orange->color,"red")

 //      roo("manana")

  orange->print()

 // chkOut() ;   exit()


     
     choo("focus,man")

//    cart("focus,man")

    cherry->print()

    orange->print()
       
<<" %V$orange->color \n"
<<" %V$apple->color \n"
<<" %V$cherry->color \n"
<<" %V$apple->color \n"

   orange->print()

 // roo("quizas")

   apple->print()

// chkOut(); exit()
  
   apple->color = "blue"

<<"%V$apple->color \n"

<<" setting $cherry->color  to $apple->color \n"

    cherry->color = apple->color

<<"%V$cherry->color \n"

   chkStr(cherry->color,"blue")



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

  //objcopy( orange, apple) ; // TBF should find proc (fruit,fruit)

  //chkStr(apple->color,orange->color)

  orange->print()

   eat(apple);
   
  //  objcopy( orange, apple)

   apple->print()


  orange->print()

  eat(apple);


  orange->print()

  chkStr(orange->color,"orange")

  chkStr(apple->color,"red")



  orange->color = "orange"

  orange->print()

  apple->color = orange->color

  chkStr(apple->color,"orange")


  apple->color = "blue"

  chkStr(apple->color,"blue")

  apple->print()
  apple->color = "red"
  cherry->color = "black"

<<" %V $apple->color \n"

<<" %V $apple->color \n"


//<<" %I$orange->color \n"
//<<" %I$cherry->color \n"

   apple->print()

   cherry->print()

   apple->color = "green"

//<<" %I$apple->color \n"

   apple->print()

   cherry->print()

   chkOut()



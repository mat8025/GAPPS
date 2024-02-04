/* 
 *  @script obprocarg.asl                                               
 * 
 *  @comment test obj proc arg                                          
 *  @release Boron                                                      
 *  @vers 1.4 Be Beryllium [asl 5.81 : B Tl]                            
 *  @date 02/04/2024 00:08:46                                           
 *  @cdate 1/1/2003                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

                                                                

<|Use_=
 Demo want to show that can use  obj name and &obj as an arg
 to deliver ptr to that object to a script procedure
|>


#include "debug"

   if (_dblevel >0) {

     debugON();

     }

  allowErrors(-1);

   chkIn(_dblevel);

   int Nfruits = 0;

   class fruit  {
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

     cmf print () {
 //<<" %V $id $color $x\n $y\n $z\n edible $(Yorn(edible))  \n"
//    str yt;

       yt= Yorn(edible);
//<<" %V $id $color $x\n $y\n $z\n edible $edible $yt  \n"

       <<" %V$id $color $x $y $z is it edible $(yorn(edible))  \n";

       }

     cmf set_y (int val) {

       <<" setting y to $val \n";

       y = val;

       }

     cmf get_x() {

       <<" $_proc returning  $x \n";

       return y;

       }

     cmf get_y() {

       <<" $_proc returning  $y \n";

       return y;

       }

     cmf set_color (int val) {

       color = val;

       }

     cmf isEdible (int e) {

       edible = e;

       }
// constructor

     cmf fruit()  {

       <<" doing constructor for %v $_cobj \n";

       <<"%v $_pstack \n";

       id = ++Nfruits;

       x = 5;

       y = 1;

       z = 3;

       j = 1;

       color = "white";

       edible = 0;

       name = "xxx";

       <<" fruits %V $id  $color  $x $y $z \n";

       }
//   destructor is automatic

     }

   <<" after class definition !\n";
 /////

   proc eat( fruit oba)
   {

     <<" $_proc $_cobj \n";

     <<"fruit thine name is $oba.name \n";

     <<" after oba name \n";
     int k = 47;
     float d = exp(1);
     <<"$k $d\n";

     oba.print();

     oba.isEdible(1);
/*
     ans = iread (" is $oba.name edible ? y/n:");
     if (ans @="y") {
       oba.isEdible(1);
       }
     else {
       oba.isEdible(0);
       }
*/ 

     oba.print();

     obc = oba.color;
     
     //locfruit = &oba;  // locfruit is a ptr to passed in fruit;
     // sclass proc args are always ptrs to objs 
//   BUG - ptr to ptr assignment 11/22/21

     oba.pinfo()

     locfruit = &oba;  // means locfruit is a ptr to passed in fruit;
     // locfruit = oba ; // should be the same 
     locfruit.pinfo()

     locfruit.print();
     locc = locfruit.color;

<<"%V$obc $locc\n"
    chkStr(obc,locc);


     <<" leaving $_proc $_cobj \n";

     }
//////////////

   proc objcopy(fruit oba,  fruit obb)
   {

     <<" copying $obb.color to $oba.color \n";

     int k = 47;

     float d = exp(1);

     <<"$k $d\n";

     oba.x = obb.x;

     oba.y = obb.y;  // y is private - should object;

     oba.color = obb.color;

     }
///

   <<" IN MAIN\n";

   char Edible =1;

   <<" %V  Edible $(Yorn(Edible))  \n";
# object declaration

   fruit apple;

   <<" after object declaration !\n";

   apple.print();

   <<"$(examine(apple))\n";
# set some object memebers

   <<" doing class member assign \n";

   apple.x = 8;

   <<" %V  $apple.x \n";

   apple.set_y(5);

   apple.color = "green";

   apple.name = "Apple";

   <<" %v $apple.color \n";

   apple.print();

<<" eat via ref arg \n"

   eat(&apple);


   eat(apple);

   fruit cherry;

   <<" after object declaration of $cherry !\n";

   <<"%V $cherry.color \n";

   cherry.x = 77;

   cherry.color = "black";

   cherry.isEdible(1);

   cherry.x = 76;

   cherry.name = "Cherry";

   cherry.print();
/////////////////////////////////////////

   fruit orange;

   <<"$(Infoof(orange))\n";

   <<"$(examine(orange))\n";

   orange.set_y(7);
 // orange.set_color("orange")

   orange.color = "orange";

   orange.name = "Orange";

   <<" %v $orange.color \n";

   orange.isEdible(1);

   orange.print();

   <<" %V$orange.color \n";

   <<" %V$apple.color \n";

   <<" %V $cherry.color \n";

   <<" %V $apple.color \n";

   apple.color = "blue";

   <<"%V$apple.color \n";

   <<" setting $cherry.color  to $apple.color \n";

   cherry.color = apple.color;

   <<"%V$cherry.color \n";

   chkStr(cherry.color,"blue");

   <<"fruit thine name is $apple.name \n";

   <<" obj now copy orange apple \n";

   apple.color = "green";

   orange.color = "orange";

   apple.print();

   orange.print();
// use ref - objs   are not treated like arrays ??

   <<"$(examine(apple))\n";

   <<"$(examine(&apple))\n";

   <<"$(examine(orange))\n";

   <<"$(examine(&orange))\n";

    eat(orange);


   objcopy( &orange, &apple);

   eat(&apple);
//  objcopy( orange, apple)

   apple.print();

   orange.print();

   eat(orange);

   chkStr(orange.color,"green");

   chkStr(apple.color,"green");

   chkStr(apple.color,orange.color);

   orange.color = "orange";

   orange.print();

   apple.color = orange.color;

   chkStr(apple.color,"orange");

   apple.color = "blue";

   chkStr(apple.color,"blue");

   apple.print();

   apple.color = "red";

   cherry.color = "black";

   <<" %V $apple.color \n";

   <<" %I $apple.color \n";
//<<" %I$orange.color \n"
//<<" %I$cherry.color \n"

   apple.print();

   cherry.print();

   apple.color = "green";
//<<" %I$apple.color \n"

   eat(&cherry);

   apple.print();

   cherry.print();

   orange.print();

   chkOut();
/*
   TBD:
   cmf key word -- should be redundant inside of class
   need to be able to do
   int getX();
   for both proc and cmf
*/

//===***===//

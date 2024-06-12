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
 to deliver ptr to that object to a script procedure.
 At the moment using obj/class name and obj at call -  is used as reference
 do we need ptr ?
|>


#include "debug"

   if (_dblevel >0) {

     debugON();
<<" $Use_ \n"
     }

  allowErrors(-1);

   chkIn(_dblevel);

   int Nfruits = 0;

   class Fruit  {
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

     void describe () {

      <<"$_proc   \n"

 //<<" %V $id $color $x\n $y\n $z\n edible $(Yorn(edible))  \n"
//    str yt;

       yt= Yorn(edible);
//<<" %V $id $color $x\n $y\n $z\n edible $edible $yt  \n"

       <<" %V $id $color $x $y $z is it edible $(yorn(edible))  \n";

       }

     void set_y (int val) {

       <<" setting y to $val \n";

       y = val;

       }

     int get_x() {

       <<" $_proc returning  $x \n";

       return x;

       }

     int get_y() {

       <<" $_proc returning  $y \n";

       return y;

       }

     void set_color (int val) {

       color = val;

       }

     void isEdible (int e) {

       edible = e;

       }
// constructor
// c++ translate removes the void ? for cons and destr? // do we have destruct?
     void Fruit()  {

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

   void eat(Fruit oba)
   {

     <<" $_proc $_cobj \n";

     <<"fruit thine name is $oba.name \n";

     <<" after oba name \n";
     int k = 47;
     float d = exp(1);
     <<"$k $d\n";

     oba.describe();

     oba.isEdible(1);
/*
     ans = iread (" is $oba.name edible ? y/n:");
     if (ans @="y") {
       oba.isEdible(1);
       }
     else {
q
       oba.isEdible(0);
       }
*/ 

     oba.describe();

     obc = oba.color;
     
     //locfruit = &oba;  // locfruit is a ptr to passed in fruit;
     // sclass proc args are always ptrs to objs 
//   BUG - ptr to ptr assignment 11/22/21

     oba.pinfo()
ans = ask("locfruit Debug [y,n] ",0)
 if (ans == "y") {
stepping=  DBaction(DBSTEP_,1)
<<"$stepping \n"
allowDB("spe,rdp,ic,vmf",1)
}

     //locfruit = &oba;  // means locfruit is a ptr to fruit obj;
     locfruit = oba ; // should be now be  ptr  == oba
     locfruit.pinfo()



     locfruit.describe();
     locc = locfruit.color;

<<"%V$obc $locc\n"
ans = ask("locfruit Debug [y,n] ",0)
    chkStr(obc,locc);


     <<" leaving $_proc $_cobj \n";

     }
//////////////

///  obj arg  acts as a reference
///  Fruit oba   === Fruit  &oba  == Fruit& oba
///  do not use Fruit *oba and oba-> syntax ??  -- allow



   void objcopy(Fruit oba,  Fruit obb)
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

   Fruit apple;

<<" after object declaration !\n";

   apple.describe();

ans = ask(" apple.describe ",0)

   
//stepping=  DBaction((DBSTEP_),1)
stepping=  DBaction(DBSTEP_,0)
<<"$stepping \n"
   apple.describe();

   apple.color = "green";
 
   apc = apple.color;
   
   <<"$(examine(apple))\n";
# set some object memebers

     locfruit = &apple;  // means locfruit is a ptr to fruit obj;
     // locfruit = oba ; // should be the same ?? copy of obj

     locfruit.pinfo()

     locfruit.describe();



     locc = locfruit.color;

<<"%V$apc $locc\n"
ans = ask(" locfruit.describe ",0)

   <<" doing class member assign \n";

   apple.x = 8;

   <<" %V  $apple.x \n";

   apple.set_y(5);

  

   apple.name = "Apple";

   <<" %v $apple.color \n";

   apple.describe();

<<" eat via ref arg \n"

  // eat(&apple);  // default is class as proc arg is a ptr 


   eat(apple);

   Fruit cherry;

   <<" after object declaration of $cherry !\n";

   <<"%V $cherry.color \n";

   cherry.x = 77;

   cherry.color = "black";

   cherry.isEdible(1);

   cherry.x = 76;

   cherry.name = "Cherry";

   cherry.describe();
/////////////////////////////////////////

   Fruit orange;

   <<"$(Infoof(orange))\n";

   <<"$(examine(orange))\n";

   orange.set_y(7);
 // orange.set_color("orange")

   orange.color = "orange";

   orange.name = "Orange";

   <<" %v $orange.color \n";

   orange.isEdible(1);

   orange.describe();

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

   <<"Fruit thine name is $apple.name \n";

   <<" obj now copy orange apple \n";

   apple.color = "green";

   orange.color = "orange";

   apple.describe();

   orange.describe();
// use ref - objs   are not treated like arrays ??

   <<"$(examine(apple))\n";

   <<"$(examine(&apple))\n";

   <<"$(examine(orange))\n";

   <<"$(examine(&orange))\n";

    eat(orange);
 apple.color = "green";

   apple.describe();

   objcopy(orange, apple);

   apple.describe();

   orange.describe();

ans= ask("$apple.color ",0)

   eat(orange);

   chkStr(orange.color,"green");

   apple.describe()
   
   chkStr(apple.color,"green");

  // chkStr(apple.color,orange.color);

   orange.color = "orange";

   orange.describe();

   apple.color = orange.color;

   chkStr(apple.color,"orange");

   apple.color = "blue";

   chkStr(apple.color,"blue");

   apple.describe();

   apple.color = "red";

   cherry.color = "black";

   <<" %V $apple.color \n";

   <<" %I $apple.color \n";
//<<" %I$orange.color \n"
//<<" %I$cherry.color \n"

   apple.describe();

   cherry.describe();

   apple.color = "green";
//<<" %I$apple.color \n"

   eat(cherry);

   apple.describe();

   cherry.describe();

   orange.describe();

   chkOut(1);




//==============\_(^-^)_/==================//

/////////////////  
/*
  TBD:
   cmf key word -- should be redundant inside of class
   need to be able to do
   int getX();
   for both proc and cmf
*/
///



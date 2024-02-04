/* 
 *  @script obcopy.asl                                                  
 * 
 *  @comment use &obj as an arg to deliver ptr                          
 *  @release Boron                                                      
 *  @vers 1.41 Nb Niobium [asl 5.81 : B Tl]                             
 *  @date 02/04/2024 00:07:12                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

                                
                                                                                  




<|Use_=
   Demo  of Object copy ;
   want to show that can use &obj as an arg
   to deliver ptr to that object to a script procedure
///////////////////////
|>

#include "debug"
#include "hv.asl"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   allowErrors(-1);

//   filterFileDebug(REJECT_,"store","tok");

   chkIn(_dblevel);

int Val = 8;
int X = 0;

Str mval = "red";

       <<"%V setting $X to $Val \n";

  <<"%Vsetting $X to $Val \n";
    <<"%dsetting $X to $Val \n";
    <<"%d$X to $Val \n";
       
          X =Val;
chkN(X,8)




   void chkCmfNest()
   {
     if (_cmfnest != -1) {

       <<"Bad $_cmfnest \n";

       listCode(5,6);
 //iread("continue?")

       }

     }

   void pf (float f)
   {

     <<"$_proc $f\n";

     f.pinfo();

     }

   int pdef = 0;
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

     int id;

     int edible;
     
#  method list

     cmf print () {

       <<" in cmf print \n";

       <<"cmf %V $_scope $_cmfnest $_proc $_pnest\n";

       j++;

       <<"%V $name $id $color $state $x $y $z  $j\n";

       <<"%V $_cobj \n";

       }

     cmf set_x (int val) {

       <<"%V setting $x to $val \n";

       x = val;

       <<"%V $x ==  $val ? \n";

       }

     cmf get_x() {

       <<" $_proc returning  $x \n";

       return x;

       }

     cmf set_color (str val) {

       <<"current %V $color \n";
       <<"%V $_scope $_cmfnest $_proc $_pnest $val\n";

       color = val;

       <<"$color == $val \n";

       }

     cmf get_color () {

       val = color;

       <<" $_proc  $val  $color\n";

       return val;

       }

     cmf set_name (str val) {

       name = val;

       }

     cmf set_y (int val) {

       <<" $_proc %V$val \n";

       y = val;

       }

     cmf set_z (float val) {

       z = val;

       }

     cmf get_z() {
//   <<" $cproc %v $z \n"

       <<" %v $z \n";

       <<" $_cproc \n";

       return z ;

       }
// constructor

     cmf fruit() {

       JuiceyF++;

       id = JuiceyF;
//<<"%v $_pstack \n"

       x = 5;  y = 1;  z = 3;  j = 0;

       color = "white";

       state = "ripe";

       name = "$_cobj";

       <<" cons for  $name $color $state $JuiceyF \n";

       }

     cmf ~fruit() {

       <<" doing destructor   for %v $_cobj \n";

       }

     }
//==================================//

   <<" after class definition !\n";

   fruit apple;

   apple.pinfo();
//  apple->set_name("apple")

   <<" after object declaration !\n";

   fruit cherry;

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   apple.print();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   cherry.print();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";
int ns = 4;

    apple.set_x(ns);

<<"%V$apple.x \n";

   chkN(apple.x,4)


    cherry.set_x(7);

<<"%V cherry.x \n";

   chkN(cherry.x,7)


    cherry.set_color("green");

   chkStr(cherry.color,"green");




   cherry.set_color(mval);

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkStr(cherry.color,"red");


   apple.set_color("green");

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkStr(apple.color,"green");

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   <<" can I eat apple $_cobj\n";








   int munch(int a)
   {
     <<"$_proc $a\n";
     b = 2 *a;
     return b;
     }
 /////
 /// fruit is sclass -- all objs passed as ptr to object - not copied

   void eat(fruit oba)
   {

     <<" $_proc $_cobj \n";

     <<"cmf %V $_scope $_cmfnest $_proc $_pnest\n";

     <<"fruit thine name is $oba.name \n";

     oba.pinfo();
//<<"apple $apple.color \n"

     oba.color = "red";
//<<"apple $apple.color \n"

     oba.state = "eaten";

     oba.print();
 //   locfruit = oba;
 //   locfruit.print()
      oba.pinfo()

     <<" leaving $_proc $_cobj \n";
  // ans=query("c_obj?")

     return 1;

     }

   pdef++; <<"%V$pdef \n";
//==================================//

   ok = 1;

   ok=eat(apple);

   <<" $ok after eating apple $_cobj\n";

   apple.print();

   <<" b4 eating cherry $_cobj\n";

   cherry.print();

   ok=eat(cherry);

   <<" $ok after eating cherry $_cobj\n";

   cherry.print();

   proc objcopy(fruit oba,  fruit obb)
   {

     <<"$_proc  copying $obb.color to $oba.color \n";

     oba.x = obb.x;

     oba.y = obb.y;

     oba.color = obb.color;

     }

   pdef++; <<"%V$pdef \n";
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
 // apple.print();
 // fruit peach;
 //  peach.print()

     }

   pdef++; <<"%V$pdef \n";
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
//  apple.print();  // TBF
//  fruit peach; // TBF
 //  peach.print() // TBF

     }

   proc goo()
   {

     <<"HEY in $_proc\n";

     <<"%v $_pstack \n";

     apple.color = "vermillion";

     <<" %v $apple.color \n";

     <<" setting $cherry.color  to $apple.color \n";

     cherry.color = apple.color;

     <<" %v $cherry.color \n";

     cherry.x = apple.x;

     <<" %v $cherry.x \n";

     <<" now a cmf inside a proc \n";

     cherry.print();

     }

   pdef++; <<"%V$pdef \n";
//==================================//

   chkN(pdef,4);

//roo("que")

   goo();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   apple.print();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   cherry.print();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   cherry.set_color("red");

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkStr(cherry.color,"red");

   apple.set_color("green");

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkStr(apple.color,"green");
/////////////////////////////////////////////

   fruit orange;

   orange.print();

   <<" <|$orange.color|> \n";

   orange.color.pinfo();

   clr = orange.color;

   clr.pinfo();

   chkStr(clr,"white");

   chkCmfNest();

   printargs(orange.name,clr,orange.color);

   chkStr(orange.color,"white");

   chkStr("white",orange.color);

   apple.print();

   chkCmfNest();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkCmfNest();

   a=1;

   bs="la apuesta inteligente";

   <<"$(bs)\n";

   <<"$(testargs(a,bs))\n";

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkCmfNest();
//<<"class $apple\n"

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   <<"$(testargs(apple))\n";

   <<"$(examine(apple))\n";

   chkCmfNest();

   <<"attempt to eat fruit!\n";

   eat(apple);

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   apple.print();

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   chkCmfNest();

   ccol = apple.get_color();

   <<"%V $ccol \n";

   chkCmfNest();

   <<" IN MAIN\n";

   <<"Examine apple\n";

   EA= examine(apple);

   <<"$EA\n";

   <<"main %V $_scope $_cmfnest $_proc $_pnest\n";

   fp = &apple;

   chkCmfNest();

   fp.pinfo();
//  fp.print()
//<<"%V$_proc \n"
//<<"%V$_pstack \n"
# object declaration

   apple.print();

   apple.color = "green";

   chkStr(apple.color,"green");

   apple.x = 80;

   chkN(apple.x,80);
//<<" %I $apple.color \n"

   <<" %V $apple.color \n";

   <<" %V $apple.x \n";

   apple.print();

   <<" after object declaration of $cherry !\n";
//<<" %I $cherry.color \n"

   <<"%V $cherry.color \n";

   cherry.print();
//<<" %I $apple.color \n"

   <<"  $apple.color \n";

   cherry.x = 77;

   cherry.color = "black";

   <<"%V$cherry.color \n";
//<<"%I$cherry.x \n"

   chkStr(cherry.color,"black");

   cherry.print();

   cherry.x = 76;

   cherry76 = cherry.x;

   cherry.pinfo();

   <<"%V $cherry76\n";

   <<" %V  $cherry.x \n";

   cherry.set_color("red");

   chkStr(cherry.color,"red");

   ccol = cherry.get_color();

   <<"%V $ccol\n";

   cherry.print();

   eat(cherry);

   cherry.print();

   chkStr(cherry.state,"eaten");

   <<" %V  $cherry.x \n";

   apple.print();
//listCode(5,4)

   <<"now margin call list\n";
# set some globals



   <<"listing ??\n";

   <<" %V  $apple.x \n";

   <<" doing class member assign \n";

   apple.x = 8;

   <<" %V  $apple.x \n";

   apple.set_y(5);

   apple.set_color("green");
 //  apple.color = "green"

   <<" %v $apple.color \n";

   chkStr(apple.color,"green");

   apple.print();

   <<"%v $apple.color \n";

   <<"apple:\n";

   apple.print();

   chkStr(apple.color,"green");

   apple.color="red";

   chkStr(apple.color,"red");

   apple.print();

   apple.set_color("yellow");

   chkStr(apple.color,"yellow");

   apple.print();
//<<"%v $orange.color \n"
 //  chkStr(orange.color,"white")

   roo("que");
//  orange.set_name("orange")
//<<"$(Infoof(orange))\n"

   orange.print();

   chkStr(orange.color,"white");
//<<"$(examine(orange))\n"

   orange.set_y(7);

   orange.set_color("pink");

   <<"%v $orange.color \n";

   orange.print();

   ocol = orange.get_color();

   <<"%V $ocol \n";

   ocol = orange.color;

   <<"%V $ocol \n";

   chkStr(orange.color,"pink");

   roo2("cuando");

   <<"attempt to eat fruit!\n";

   orange.print();

<<"prepare to eat orange\n"
   orange.pinfo();
   

   eat(orange);

   <<"%V$orange.state\n"
   chkStr(orange.state,"eaten");
   <<"%V$orange.color\n"
   chkStr(orange.color,"red");


   orange.print();

   cherry.print();

   orange.print();

   <<" %V$orange.color \n";

   <<" %V$apple.color \n";

   <<" %V$cherry.color \n";

   <<" %V$apple.color \n";

   orange.print();
 // roo("quizas")

   apple.print();

   apple.color = "blue";

   <<"%V$apple.color \n";

   <<" setting $cherry.color  to $apple.color \n";

   cherry.color = apple.color;

   <<"%V$cherry.color \n";

   chkStr(cherry.color,"blue");

   cherry.print();

   goo();

   apple.name = "apple";

   <<"fruit thine name is $apple.name \n";

   <<" obj now copy orange apple \n";

   apple.color = "green";

   orange.color = "orange";

   apple.print();

   orange.print();
// use ref - objs   are not treated like arrays ??

   <<"$(objinfo(apple))\n";
//<<"$(examine(&apple))\n"
//<<"$(examine(orange))\n"

   <<"$(objinfo(&orange))\n";
  //objcopy( orange, apple) ; // TBF should find proc (fruit,fruit)
  //chkStr(apple.color,orange.color)

   orange.print();

   eat(apple);
  //  objcopy( orange, apple)

   apple.print();

   orange.print();

   eat(apple);

   orange.print();

   chkStr(orange.color,"orange");

   chkStr(apple.color,"red");

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

   <<" %V $apple.color \n";
//<<" %I$orange.color \n"
//<<" %I$cherry.color \n"

   apple.print();

   cherry.print();

   apple.color = "green";
//<<" %I$apple.color \n"

   apple.print();

   cherry.print();
////////////////////////////////////////////////////////////////////
// test of redef of proc and use
/*
   proc goo()
   {

     <<"HEY2 in $_proc\n";

     <<"%v $_pstack \n";

     apple.color = "purple";

     <<" %v $apple.color \n";

     <<" setting $cherry.color  to $apple.color \n";

     cherry.color = apple.color;

     <<" %v $cherry.color \n";

     cherry.x = apple.x;

     <<" %v $cherry.x \n";

     <<" now a cmf inside a proc \n";

     cherry.print();

     }

   pdef++; <<"%V$pdef \n";
//==================================//

   chkN(pdef,5);
*/

   goo();

   apple.print();

   cherry.print();

     apple.color = "purple";

     <<" %v $apple.color \n";


   chkOut();
/////////////////////////

//===***===//

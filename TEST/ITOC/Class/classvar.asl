//%*********************************************** 
//*  @script classvar.asl 
//* 
//*  @comment test OO get/set 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.48 C-He-Cd]                                
//*  @date Tue May 19 08:25:16 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
#include "debug";

   if (_dblevel >0) {

     debugON();

     }

   allowErrors(-1) ; // keep going;

   chkIn(_dblevel);

//allowDB("ic_,oo_,spe_exp,spe_proc,spe_state,spe_cmf,spe_scope,ds_sivbounds")

//   wdb=DBaction((DBSTEP_),ON_) ;

   int V = 4 ;  // global;

   V.pinfo();

   pinfo(V);

   <<"%V $V $::V \n";

   ::V = 74;

   <<"%V $V $::V \n";
//<<"%I  $V \n"

   <<"; ////////\n";

   <<"%v $_proc \n";

   <<"%v $_pstack \n";
# class definition

   class fruit  {
   
#  variable list

     public:

     int x ;

     int V ;
#  method list

     void Print () {

       <<"$_proc of $_cobj\n";

           pinfo(x)
	   pinfo(V)

       }

     void set_x (int val) {

       <<" setting x to $val \n";

       x = val;

       }

     void set_GV (int val) {
       ::V = val;

       <<" setting global to $val $::V \n";
       }

     int get_x() {

       <<" $_proc returning  $x \n";

       return x;
       }

     void set_V (int val) {

       V = val;

       <<" setting class V to %V $val $V\n";

       <<" %V $val $V\n";
       }

     void set_VS (int val1, int val2) {
       V = val1;
       ::V= val2;
       }

     int get_V() {
     
 <<" $_proc returning  $V \n";
 //      <<" %v $V \n";
       //V.pinfo()
       
       return V ;
       }

// constructor

     cmf fruit()
     {

     <<" doing fruit constructor for  $_cobj \n";

     <<"%V $_pstack \n";
     x = 5;

     V = 33; // should set class V not global V;

     ::V= 80;

      V.pinfo()

     }

   }
//===========================//

  <<"%v $_proc \n";

  <<"%v $_pstack \n";
# object declaration

  <<"pre_obj_dec %v $V \n";

  fruit apple;
//<<"post_obj_dec %V $V $apple.V  $(apple.get_V())\n"

  <<"post_obj_dec %V $V \n";

  <<"$V\n";

  <<"%V $apple.V  \n";

  apple.pinfo();

  mx = apple.get_x();

  <<" %V mx \n"

  chkN(mx,5)

  apple.set_V(47);

  <<"%V $apple.V \n";

  apple.set_GV(79);

  <<"%V $apple.V \n";
//<<"%I $apple.V \n"

  <<"global %V $V \n";

  apple.set_VS( 88,66);

  <<"%V $apple.V \n";

  <<"global %V $V \n";

  chkN(66,V);

  fruit cherry;

  cherry.Print();


  mx = cherry.get_x();

  <<" %V mx \n"

  chkN(mx,5)


  <<" %v $apple.V \n";

  apple.V = 45;

  <<" %v $apple.V \n";

  chkN(45,apple.V);

  apple.Print();

  <<" after object declaration !\n";

  <<" %V $V $apple.V\n";

  apple.Print();

  apple.color = "green";

  apple.V = 50;

  <<" %v $apple.V \n";

  V = 5;

  apple.Print();

  <<" %V $apple.V \n";

  av = apple.get_V();

  chkN(av,50)

  <<" %V $av $apple.V \n";

  apple.set_V(47);

  <<" %V $av $apple.V  $V\n";

  av = apple.get_V();

  chkN(av,47)


  apple.set_x(17);

  av = apple.get_x();

 chkN(av,17)

  av = apple.get_V();

  <<" %V $av $apple.V $V\n";

 chkN(av,47)

  <<"%v $V \n";

  cherry.set_V(48);

  chkN(48,cherry.V);

  apple.Print();



  cav = cherry.get_V();

  <<" %V $cav $cherry.V $V\n";

 chkN(cav,48)


  cherry.Print();

  <<" %V $V $apple.V  $cherry.V \n";

  apple.set_GV(7);
  chkN(V,7);
  <<" %V $V $apple.V  $cherry.V \n";

  cherry.set_GV(9);

  chkN(V,9);

  <<" %V $V $apple.V  $cherry.V \n";

  chkOut();

//==============\_(^-^)_/==================//

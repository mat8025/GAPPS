/* 
 *  @script mih.asl                                                     
 * 
 *  @comment test ineritance                                            
 *  @release Carbon                                                     
 *  @vers 1.3 Li Lithium [asl 6.18 : C Ar]                              
 *  @date 05/30/2024 13:19:28                                           
 *  @cdate 1/1/2003                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

<|Use_=
   Demo  of multiple inheritance
///////////////////////
|>

#include "debug"
//#include "hv.asl"

   if (_dblevel >0) {

        debugON();

        <<"$Use_\n";

   }

   allowErrors(-1);

   chkIn();

   allowDB("spe_proc,spe_vmf,ic",1);

   int barns = 2;

   barns = 10;

   <<"%V $barns \n";

   class building {

        int rooms;

        int floors;

        int area;

        void setrooms(int val)
        {

             rooms = val;
        }

        int getrooms()
        {

             return rooms;
        }

        void setfloors(int val)
        {

             floors = val;
        }

        int getfloors()
        {

             return floors;
        }

        void print()
        {

             <<"$_cobj has %V $rooms $floors\n";
        }

         cmf building()
        {

             <<"$_cobj constructor \n";

             floors = 2;

             rooms = 4;
        }

   }

   <<" finished class def building \n";

   building b;

   b.print();

   class A {

        int x;

        void setval(int val)
        {

             x = val;
        }

        int getval()
        {

             return x;
        }

        void print()
        {

             <<"$_cobj has %V $x\n";
        }

        cmf A()
        {

             <<"$_cobj constructor \n";

             x = 4;
        }

   }
//======================================//

   <<" finished class A  \n";

   class B {

        int y;

        void setval(int val)
        {

             y = val;
        }

        int getval()
        {

             return y;
        }

        void print()
        {

             <<"$_cobj has %V $y\n";
        }

        cmf B()
        {

             <<"$_cobj constructor \n";

             y = 4;
        }

   }
//======================================//

   <<" finished class B  \n";

   class C : A : B {

        int z;

        void print()
        {

             <<"$_cobj has %V $x $y $z\n";

        }

        cmf C()
        {

             <<"$_proc  constructor \n";

             z = 3;
        }

   }
//======================================//

   <<" finished class C  \n";

   A a ;

   a.print();

   B bc;

   bc.print();

   C c;

   c.print();

   c.y = 56;

   c.setval(77);

   c.print();

   v = c.getval();

   chkN(c.y,56);

   chkN(v,77);

   chkOut(1);

//==============\_(^-^)_/==================//

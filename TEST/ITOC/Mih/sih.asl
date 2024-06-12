/* 
 *  @script sih.asl                                                     
 * 
 *  @comment test inheritance                                           
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.18 : C Ar]                            
 *  @date 05/30/2024 14:12:51                                           
 *  @cdate 1/1/2003                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

<|Use_=
   Demo  of inheritance
///////////////////////
|>

#include "debug"
//#include "hv.asl"

   if (_dblevel >0) {

        debugON();

        <<"$Use_\n";

   }

   allowErrors(-1);

   db_ask =0;

   db_allow =0;

   allowDB("spe_proc,spe_vmf,ic",db_allow);

   chkIn();
//chkIn(1)
//sdb(1,@trace)

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

             <<" in getfloors \n";

             return floors;

        }

        void print()
        {

             <<"$_cobj has %V $rooms $floors\n";
        }

        cmf building()
        {

             <<"$_proc constructor \n";

             floors = 2;

             rooms = 4;
        }

   }

   <<" finished class def building \n";

   class house : building {

        int bedrooms;

        int baths;

        void setbaths(int val)
        {

             baths = val;
        }

        int getbaths()
        {

             return baths;
        }

        void print()
        {
  //rr = getrooms(); // ERROR TBF 9/3/21

             rr = rooms;

             ff = floors;

             <<"%V $_cobj $bedrooms $baths $ff\n";

             <<"$_cobj has $bedrooms bedrooms $baths bathrooms and $ff floors $rr rooms %V $rooms $floors\n";

        }

        cmf house()
        {

             <<"$_proc  constructor \n";

             bedrooms = 1;

             baths = 1;

             <<"$_proc  %V $rooms $floors $baths\n";
        }

   }

   <<" finished class def house \n";

   class Room : house {

        int chairs;

        int carpets;

        void setchairs(int val)
        {

             chairs = val;
        }

        int getchairs()
        {

             return chairs;
        }

        void setcarpets(int val)
        {

             carpets = val;
        }

        int getcarpets()
        {

             return carpets;
        }

        cmf Room()
        {

             <<" $_proc CONS \n";

             chairs = 2;
             carpets = 1;
        }

   }
//======================================//

   <<" finished class def room \n";

   building b;
// only initial constructor is called at the moment

   nr = 0;

   nr = b.getrooms();

   <<" %v $nr \n";

   mr = 25;

   <<"reset rooms to $mr \n";

   b.setrooms(mr);

   nr = b.getrooms();

   <<"%v $nr \n";

   b.setfloors(6);

   b.print();

   <<"make a house \n";

   house h;

   <<"after house $h \n";

   h.pinfo();

   h.print();

   nr = h.getrooms();

   <<"%v $nr \n";

   h.setrooms(5);

   h.setfloors(3);

   h.print();

   b.print();

   h.setrooms(7);

   h.setfloors(12);

   h.print();

   hf = h.floors;

   <<"%v $hf \n";

   hr = h.rooms;

   <<"%v $hr \n";

   hr = h.getrooms();

   <<"%v $hr \n";

   nr = h.getrooms();

   <<" %v $nr \n";

   h.setrooms(18);

   nr = h.getrooms();

   <<" %v $nr \n";

   h.setbaths(20);

   nbaths = h.getbaths();

   <<" %v $nbaths \n";

   <<" make house c \n";

   house c;

   <<" after house c dec !! \n";

   c.print();

   <<" make house d \n";

   house d;

   d.print();

   Room r;

   ans=ask(" after Room 1",db_ask);

   int nf;

   nc = r.getchairs();

   ans=ask(" Room r has $nc chairs",db_ask);

   ncpt = r.getcarpets();

   ans=ask(" Room r has $ncpt carpets ",db_ask);

   nf = r.getfloors();

   ans=ask(" Room r is in a building that has $nf floors ?",db_ask);

   chkN(2,nf);

   <<" grandparent constructor called %V $nf  from room object\n";

   rnf = 10;

   <<" now set %v $rnf building member from room object \n";

   r.setfloors(rnf);
// can reach back to grandparent !! ok
// parent constructor is called

   nf = r.getfloors();

   ans=ask(" Room r is in a building that now has $nf floors ?",db_ask);

   chkN(nf,10);

   r.print();

   r.setbaths(3);

   nb = r.getbaths();

   r.print();

   <<" baths $nb \n";

   chkN(nb,3);

   chkOut(1);

//==============\_(^-^)_/==================//

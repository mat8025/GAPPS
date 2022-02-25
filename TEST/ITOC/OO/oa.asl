/* 
 *  @script oa.asl 
 * 
 *  @comment test object array; 
 *  @release CARBON; 
 *  @vers 1.3 Li 6.3.87 C-Li-Fr 
 *  @date 02/22/2022 15:59:57          
 *  @cdate Tue Apr 28 19:55:38 2020; 
 *  @author Mark Terry; 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                


Str Use_="   demo some OO syntax/ops";


#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   allowErrors(-1);

   chkIn (_dblevel);

   //debugON();

   int x = 5;

   int Bid =0;

   void checkRooms(int i, int k)
   {

     irm = C[i]->rooms;

     iid =   C[i]->id;

     krm = C[k]->rooms;

     kid =  C[k]->id;

     <<"%V $i $irm $iid $k $krm $kid\n";

     }

   //================;

   void pfloors(int r)
   {
     int prf = 0;

     prf = r +1;

     return prf;

     }

   //================;

   nr = pfloors(7);

   <<"%V $nr\n";

   nr = pfloors(8);

   <<"%V $nr\n";

   //=====================;

   class Building {

     int rooms;

     int floors;

     int area ;

     int id;

     void setRooms(int val)
     {

       <<" $_proc  $_cobj  [${id}]  $rooms $floors $area \n";

       rooms = val;

       }

     int getRooms()
     {

       <<" $_proc  $_cobj [${id}]  $rooms $floors $area \n";

       nr = rooms;

       return rooms;
       }

     //========================;

     void setFloors(int val)

     {

       floors = val;

       <<" $_cobj $_proc %V $id $val $floors \n";

       area = floors * 200;

       //   my->print();

       }

     int getFloors()

     {

       int rnf = 0; // TBF crash;

       <<" $_proc  $_cobj [${id}]$rooms $floors $area \n";

       rnf = floors;

       <<"$rnf \n";

       //return rnf;
       // TBF 9/3/21 returning local -- deleted does not remain on stack for assignment?;

       return floors;

       }

     void Print()
     {

       <<" $_proc $_cobj  [${id}] \n %V $rooms \n $floors \n $area \n";

       }

     //======================================//;

     cmf Building()

     {

       id = Bid;

       <<"%V $id\n";

       Bid++;

       <<"%V $Bid\n";

       floors = 7 + id;

       <<"%V $floors\n";

       rooms = 4 +id ;

       area = floors * 200;

       <<"Cons $_cobj %V $id  $Bid $floors  $rooms $area\n";

       }

     }

   ////////////////////////////////////

   Building C[10];

   <<" done object array  declare ! \n";

   b6 = 6;

   b6rooms = C[b6].rooms;

   <<"%V $b6rooms \n";

   b7 = 7;

   b7rooms = C[b7].rooms;

   b7id = C[b7].id;

   <<"%V $b7rooms $b7id\n";

   checkRooms(5,7);

   checkRooms(0,9);

   Building A;


   nrooms = A.getRooms();

<<"A has $nrooms rooms \n";


   a_rooms = A.rooms;

   a_rooms.pinfo();
   
   <<"A has $a_rooms rooms \n";

   Building B;

   Building D;

   a_rooms = A.getRooms();

   <<"%V $a_rooms \n";

   chkN (a_rooms,14);

   Afloors = A.getFloors();

   <<"%V $Afloors \n";

   Brooms = B.getRooms();

   <<"%V $Brooms \n";

   chkN (Brooms,15);

   Bfloors = B.getFloors();

   <<"%V $Bfloors \n";

   chkN (Bfloors,18);

   Drooms = D.getRooms();

   <<"%V $Drooms \n";

   D.setFloors(7);

   Dfloors = D.getFloors();

   <<"%V $Dfloors \n";

   chkN (Dfloors,7);

   C[1].Print();

   b1rooms = C[1].getRooms();

   <<"%V $b1rooms \n";

   chkN (b1rooms,5);

   C[2].Print();

   b2rooms = C[2].getRooms();

   <<"%V $b2rooms \n";

   b0rooms = C[0].getRooms();

   <<"%V $b0rooms \n";

   C[3].Print();

   C[0].Print();

   b0rooms = C[0].getRooms();

   <<"%V $b0rooms \n";

   chkN (b0rooms,4);

   b2rooms = C[2].getRooms();

   <<"%V $b2rooms \n";

   chkN (b2rooms,6);

   C[5].Print();

   b5rooms = C[5].getRooms();

   <<"%V $b5rooms \n";

   chkN (b5rooms,9);

   C[6].Print();

   b6rooms = C[6].getRooms();

   <<"%V $b6rooms \n";

   chkN (b6rooms,10);

   C[2].setFloors(15);

   C[2].Print();

   b2floors = C[2].getFloors();

   <<"%V $b2floors \n";

   chkN (b2floors,15);

   n = 2;

   C[n].setFloors(16);

   C[n].Print();

   <<"  return n floors for [${n}] \n";

   nf = C[2].getFloors();

   <<"%V $nf \n";

   chkN (nf,16);

   nf = C[n].getFloors();

   <<"%V $nf \n";

   chkN (nf,16);

   chkStage();

   /////////

   // j = 3; // TBF ---;

   j = 9;

   C[j].setFloors(12); // this has to set C offset first time through;

   C[j].Print();

   nf = C[j].getFloors();

   <<"floors $nf \n";

   chkN (nf,12);



   nrms = C[0].getRooms();

   <<" C[0] rooms $nrms \n";

   chkN (nrms,4);

   <<" main refer %i $C   [0] \n";

   C[0].setRooms(56);

   nrms = C[0].getRooms();

   <<" main refer %i $C   [1] \n";

   C[1].setRooms(12);

   C[4].setRooms(14);

   nr = C[4].getRooms();

   chkN (nr,14);

   // FIX  chkN ( C[4].getFloors(),14);

   <<" test  object accessor functions\n";

   C[2].setFloors(15);

   <<" test  direct public reference\n";

   a=   C[2].floors;

   <<"  %I $C[0].floors  $a \n";

   chkN (a,15);

   j = 2;

   a=   C[j].floors;

   <<" %I $C[j].floors  $a \n";

   chkN (a,15);

   <<" Single object ! \n";

   for (i = 0 ; i < 5 ; i++) {

     nrms = C[i].getRooms();

     <<" %V $i $nrms \n";

     }

   for (i = 0 ; i < 5 ; i++) {

     C[i].setRooms(i);

     nrms = C[i].getRooms();

     <<" %V $i $nrms \n";

     }

   for (i = 0 ; i < 5 ; i++) {

     nrms = C[i].getRooms();

     <<" %V $i $nrms \n";

     }

   for (i = 0 ; i < 5 ; i++) {

     nrms = C[i].getRooms();

     <<" %V $i $nrms \n";

     }

   for (i = 0 ; i < 5 ; i++) {

     C[i].setRooms(i+15);

     nrms = C[i].getRooms();

     <<" %V $i $nrms \n";

     }

   A.Print();

   nf = A.getFloors();

   <<" $nf \n";

   Building bz;

   bz.Print();

   nf = bz.getFloors();

   <<" $nf \n";

   bz.setFloors(17);

   bnf = bz.getFloors();

   <<" %v $bnf \n";

   bz.Print();

   bz.pinfo();

   <<" making copy of obj bz \n";

   d = bz;

   d.pinfo();

   d.Print();

   d.setFloors(11);

   d.Print();

   dr = d.getRooms();

   <<"%V $dr\n";

   d.pinfo();

   <<"d: $d\n";

   c = d;

   c.pinfo();

   c.Print();

   c.setFloors(12);

   cnf = c.getFloors();

   <<" %v $cnf \n";

   dnf = d.getFloors();

   <<" %v $dnf \n";

   if (dnf != bnf ) {

     <<" object copy fail! \n";

     }

   else {

     <<" object copy success! \n";

     }

   dnf = d.getFloors();

   <<" %v $dnf \n";

   cnf = c.getFloors();

   <<" %v $cnf \n";

   d.setFloors(12);

   dnf = d.getFloors();

   <<" %v $dnf \n";

   d.Print();

   bz.setFloors(60);

   bz.Print();

   d.Print();

   cnf = c.getFloors();

   <<" %v $cnf \n";

   bz.setFloors(30);

   nf = bz.getFloors();

   <<" $nf \n";

   //  bptr = &C[0];

   //  sz = C.Caz();

   // <<" %v $sz \n";

   nf = C[1].getFloors();

   <<" $nf \n";

   C[0].setFloors(6);

   C[0].setRooms(12);

   //  C[1].setFloors(9);

   nf = C[1].getFloors();

   <<" $nf \n";

   C[2].setFloors(96);

   C[3].setFloors(69);

   //  C[3].setRooms(22);

   C[4].setFloors(54);

   C[4].setRooms(100);

   nf = C[2].getFloors();

   <<" $nf \n";

   nf = C[1].getFloors();

   <<" $nf \n";

   nf = C[3].getFloors();

   <<" $nf \n";

   nr = C[4].getRooms();

   <<" %v $nr \n";

   i = 3;

   nf = C[i].getFloors();

   <<" $nf \n";

   j = 2;

   for (i = 0 ; i < 5 ; i++) {

     C[i].setFloors(j);

     nf = C[i].getFloors();

     nr = C[i].getRooms();

     <<" %V $i $nf $nr \n";

     j += 2;

     }

   for (i = 0 ; i < 5 ; i++) {

     C[i].setFloors(i+1);

     C[i].setRooms(i*4+2);

     <<" setFloors $i  \n";

     nf = C[i].getFloors();

     nr = C[i].getRooms();

     <<" %V $i $nf $nr \n";

     }

   nf = C[2].getFloors();

   <<" $nf \n";

   C[2].setFloors(8);

   nf = C[2].getFloors();

   <<" $nf \n";

   C[1].setFloors(7);

   j = 1;

   while (j < 4) {

     C[j].setFloors(66);

     nf = C[j].getFloors();

     <<" $j $nf \n";

     j++;

     }

   checkRooms(1,7);

   //Building BD[30];

   chkOut();

//===***===//

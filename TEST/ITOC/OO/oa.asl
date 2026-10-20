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
int db_action = 0;
int db_step = 0;

   int x = 5;
   int li = 0;
   float TC[3];
   int Bid =0;

   printf("x is %d\n",x);

   printf("\t%6.0f ",TC[li]); 


 ans=ask(DB_prompt,db_action)

//wdb=  DBaction((DBSTEP_),db_step)
//<<"$wdb \n"

//allowDB("spe,ic,rdp,oo")

//   Define a class 

   class Building {

     int rooms; // public class member

     int id;

     void setRooms(int val)
     {

       <<" $_proc  $_cobj  [${id}]  \n";

       rooms = val;

       }

     int getRooms()
     {

       <<" $_proc  $_cobj [${id}]  $rooms \n";

       nr = rooms;

       return rooms;
       }

     //========================;

     void Print()
     {

       <<" $_proc $_cobj  [${id}]  %V $rooms   \n";

       }

     //======================================//;

  cmf   Building()

     {

       id = Bid++;

       <<"%V $id $Bid\n";
       rooms = 4 + id;
       <<"Cons $_cobj %V $id  $Bid $rooms\n";
ans=ask("OK $ok",0)
       }

    cmf   ~Building()
         {
          <<"destructing \n";
         }
     }

   ////////////////////////////////////
   int ok =0;

   int CI[10];

   CI.pinfo();

//sdb(1,"step")

   Building A;

   A.Print();

   nr=A.getRooms()

  ok= chkN(nr,4);
<<"%V $ok\n"
 if (!ok) {
   exit()
 }

   Building B;

   B.Print();

   nr=B.getRooms()

  ok= chkN(nr,5);
<<"%V $ok\n"
 if (!ok) {
   exit()
 }

   Building Z;

   Z.Print();

   nr=Z.getRooms()

  ok= chkN(nr,6);
<<"%V $ok\n"


   Building C[3];

   C.pinfo()
   
   <<"\n DONE object array  declare ! \n";

  <<"C[0] "
   C[0].Print();
  <<"C[1] "
   C[1].Print();
  <<"C[2] "
   C[2].Print();

ans=ask("OK $ok",0)

int b0rooms = -1;


   C[0].Print();

   b0rooms = C[0].getRooms();

   <<"%V $b0rooms on C[0] \n";


   C[1].Print();

   b1rooms = C[1].getRooms();

   <<"%V $b1rooms on C[1] \n";

   C[2].Print();

   b2rooms = C[2].getRooms();

   <<"%V $b2rooms on C[2] \n";


   tot_rooms = b0rooms + b1rooms + b2rooms;



  get_tot_rooms =C[0].getRooms()+C[1].getRooms() + C[2].getRooms();

<<"%V $tot_rooms $get_tot_rooms\n"

   checkOut()
   

//===***===//

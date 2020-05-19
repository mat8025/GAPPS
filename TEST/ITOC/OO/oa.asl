//%*********************************************** 
//*  @script oa.asl 
//* 
//*  @comment test object array 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.48 C-He-Cd]                              
//*  @date Tue May 19 07:06:21 2020 
//*  @cdate Tue Apr 28 19:55:38 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


//sdb(1,@trace)
checkIn(_dblevel)


include "debug"

debugON()

int x = 5;

int Bid =0;

proc pfloors(int r)
{
 int prf = 0;

 prf = r +1;

 return prf;
}
//================

 nr = pfloors(7);

<<"%V $nr\n"


 nr = pfloors(8);

<<"%V $nr\n"







//=====================
class Building {

 int rooms;
 int floors;
 int area ;
 int id;
 
 cmf setRooms(int val)
 {
  <<" $_proc  $_cobj [${id}]  $rooms $floors $area \n"
   rooms = val;
 }

 cmf getRooms()
 {
<<" $_proc  $_cobj [${id}]  $rooms $floors $area \n"
   nr = rooms;
   return rooms; 
 }
//========================
 cmf setFloors(int val)
 {
    floors = val;
<<" $_cobj $_proc %V $id $val $floors \n"
   area = floors * 200;
//   my->print()
 }

 cmf getFloors()
 {
   int rnf = 0; // TBF crash
<<" $_proc  $_cobj [${id}]$rooms $floors $area \n"
   rnf = floors;
<<"$rnf \n"   
   return rnf;  // TBF returning local -- deleted does not remain on stack for assignment?
  // return floors;
 }

 cmf Print()
 {
  <<" $_proc $_cobj  [${id}] \n %V $rooms \n $floors \n $area \n"
 }
//======================================//
 cmf Building()
 {
 <<"Cons $_cobj $Bid\n"
    id = Bid;
    <<"%V $id\n"
    Bid++;
   <<"%V $Bid\n"
    floors = 7 + id;
   <<"%V $floors\n" 
    rooms = 4 +id ;
    area = floors * 200;
   
 <<"cons $_cobj %V $id  $Bid $floors  $rooms $area\n"
  }

}


////////////////////////////////////
  Building A;
  Building B;
  Building D;  

   Arooms = A->getRooms();

<<"%V $Arooms \n"

   checkNum(Arooms,4);
   Afloors = A->getFloors();

<<"%V $Afloors \n"

   Brooms = B->getRooms();

<<"%V $Brooms \n"
 checkNum(Brooms,5);
   Bfloors = B->getFloors();

<<"%V $Bfloors \n"
 checkNum(Bfloors,8);

   Drooms = D->getRooms();

<<"%V $Drooms \n"
    D->setFloors(7)

   Dfloors = D->getFloors();

<<"%V $Dfloors \n"

    checkNum(Dfloors,7)


  Building C[10]

<<" done object array  declare ! \n"

 
   C[1]->Print()


   b1rooms = C[1]->getRooms();

<<"%V $b1rooms \n"

 checkNum(b1rooms,8);

   C[2]->Print()

   b2rooms = C[2]->getRooms();

<<"%V $b2rooms \n"

   b0rooms = C[0]->getRooms();

<<"%V $b0rooms \n"


   C[3]->Print()

  C[0]->Print()


   b0rooms = C[0]->getRooms();

<<"%V $b0rooms \n"


   checkNum(b0rooms,7);
   


   b2rooms = C[2]->getRooms();

<<"%V $b2rooms \n"

  checkNum(b2rooms,9);

  




   C[5]->Print()

   b5rooms = C[5]->getRooms();

<<"%V $b5rooms \n"

   checkNum(b5rooms,12);

   C[6]->Print()

   b6rooms = C[6]->getRooms();

<<"%V $b6rooms \n"

   checkNum(b6rooms,13);


   C[2]->setFloors(15);

   C[2]->Print();

   b2floors = C[2]->getFloors();

<<"%V $b2floors \n"
  checkNum(b2floors,15)

  n = 2;

  C[n]->setFloors(16);
  
  C[n]->Print()

<<"  return n floors for [${n}] \n"


  nf = C[2]->getFloors()

<<"%V $nf \n"

  checkNum(nf,16)


  nf = C[n]->getFloors()

<<"%V $nf \n"

  checkNum(nf,16)

  checkStage();


/////////

 // j = 3; // TBF ---
  j = 9;

  C[j]->setFloors(12); // this has to set C offset first time through

  C[j]->Print();

  nf = C[j]->getFloors();

<<"floors $nf \n"

  checkNum(nf,12);

//checkOut()

  nrms = C[0]->getRooms()
  <<" C[0] rooms $nrms \n"

  checkNum(nrms,7)

<<" main refer %i $C   [0] \n"
  C[0]->setRooms(56)

nrms = C[0]->getRooms()


<<" main refer %i $C   [1] \n"
  C[1]->setRooms(12)

  C[4]->setRooms(14)


  nr = C[4]->getRooms()
  
  checkNum(nr,14)



// FIX  checkNum( C[4]->getFloors(),14)






<<" test  object accessor functions\n"
  C[2]->setFloors(15);
 

<<" test  direct public reference\n"

  a=   C[2]->floors
<<"  %I $C[0]->floors  $a \n"
checkNum(a,15)


  j = 2

  a=   C[j]->floors
<<" %I $C[j]->floors  $a \n"
checkNum(a,15)


<<" Single object ! \n"


  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }




  for (i = 0 ; i < 5 ; i++) {
   C[i]->setRooms(i)
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }


  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }

  for (i = 0 ; i < 5 ; i++) {
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }

  for (i = 0 ; i < 5 ; i++) {
   C[i]->setRooms(i+15)
   nrms = C[i]->getRooms()
  <<" %V $i $nrms \n"
  }




  A->Print()

  nf = A->getFloors()

<<" $nf \n"


   Building bz

   bz->Print()

   nf = bz->getFloors()

<<" $nf \n"

   bz->setFloors(17)

   bnf = bz->getFloors()

<<" %v $bnf \n"

   bz->Print()





   d = bz

   d->setFloors(11)

   d->Print()

   c = d

   c->Print()

   c->setFloors(12)

   cnf = c->getFloors()

<<" %v $cnf \n"

   dnf = d->getFloors()

<<" %v $dnf \n"

    if (dnf != bnf ) {
  <<" object copy fail! \n"
  }
    else {
  <<" object copy success! \n"
  }

   dnf = d->getFloors()

<<" %v $dnf \n"

   cnf = c->getFloors()

<<" %v $cnf \n"

   d->setFloors(12)

   dnf = d->getFloors()

<<" %v $dnf \n"

   d->Print()

   bz->setFloors(60)

   bz->Print()

   d->Print()

   cnf = c->getFloors()

<<" %v $cnf \n"

   bz->setFloors(30)

   nf = bz->getFloors()

<<" $nf \n"


//  bptr = &C[0]


//  sz = C->Caz()

// <<" %v $sz \n"

  nf = C[1]->getFloors()

<<" $nf \n"

  C[0]->setFloors(6)

  C[0]->setRooms(12)

//  C[1]->setFloors(9)

  nf = C[1]->getFloors()

<<" $nf \n"



  C[2]->setFloors(96)

  C[3]->setFloors(69)

//  C[3]->setRooms(22)

  C[4]->setFloors(54)

  C[4]->setRooms(100)

  nf = C[2]->getFloors()

<<" $nf \n"


  nf = C[1]->getFloors()

<<" $nf \n"

  nf = C[3]->getFloors()

<<" $nf \n"

  nr = C[4]->getRooms()

<<" %v $nr \n"

  i = 3

  nf = C[i]->getFloors()

<<" $nf \n"
  j = 2
  for (i = 0 ; i < 5 ; i++) {

  C[i]->setFloors(j)
  nf = C[i]->getFloors()
  nr = C[i]->getRooms()

<<" %V $i $nf $nr \n"
   j += 2
  }

  for (i = 0 ; i < 5 ; i++) {

  C[i]->setFloors(i+1)

  C[i]->setRooms(i*4+2)

<<" setFloors $i  \n"

  nf = C[i]->getFloors()
  nr = C[i]->getRooms()

<<" %V $i $nf $nr \n"

  }


  nf = C[2]->getFloors()

<<" $nf \n"


  C[2]->setFloors(8)

  nf = C[2]->getFloors()

<<" $nf \n"


  C[1]->setFloors(7)
  j = 1
 while (j < 4) {
  C[j]->setFloors(66)
  nf = C[j]->getFloors()
<<" $j $nf \n"
  j++
 }




checkOut()

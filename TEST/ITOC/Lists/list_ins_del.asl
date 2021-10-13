/* 
 *  @script list_ins_del.asl 
 * 
 *  @comment test list insert delete 
 *  @release CARBON 
 *  @vers 1.38 Sr Strontium [asl 6.3.54 C-Li-Xe] 
 *  @date 10/12/2021 09:43:17 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                     
   
#include "debug.asl"; 
   
   debugON();
   


chkIn(_dblevel)

ShoppingList = ("xxx",  )  // empty list --- bug first item null?

<<" $ShoppingList \n"

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"

  ShoppingList<-LiDelete(0)

<<" $ShoppingList \n"

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"


  //tname = "debe esforzarse más"
  tname = "debe esforzarse mas"

 <<"inserting <$tname> into Shopping list \n"

  ShoppingList<-pinfo()


preval = ShoppingList<-getPrevLitem();
 <<"preval  <|$preval|>\n"


  ShoppingList<-Insert(tname)

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"

preval = ShoppingList<-getPrevLitem();
 <<"preval  <|$preval|>\n"



<<" $ShoppingList \n"



tname = "Camino a cinco kilometros al dia"

 <<"inserting <$tname> into Shopping list \n"
            ShoppingList<-Insert(tname)

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"
<<" $ShoppingList \n"
preval = ShoppingList<-getPrevLitem();
 <<"preval  <|$preval|>\n"

//  flab = cab(ShoppingList)
//<<"Shopping list bounds $flab \n"
 ShoppingList<-Insert("Debo organizar mi vida")
 ShoppingList<-Insert("Irse a tiempo","leave on time"); // multiple inserts
  ShoppingList<-Insert("lost in  space"); //  same initial letter -cause a swop

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"

if (flsz > 1) {
<<" These modules added! \n"

   ShoppingList<-Sort() ; // TBF 10/12/21

<<" $ShoppingList \n"
}



<<"%V $ShoppingList \n"

<<"0 $ShoppingList[0] \n"

<<"1 $ShoppingList[1] \n"

<<"2 $ShoppingList[2] \n"

<<"3 $ShoppingList[3] \n"

  tname = "head here"
  ShoppingList<-Insert(0,tname)
   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"
<<" $ShoppingList \n"
  tname = "tail here"
  ShoppingList<-Insert(-1,tname)
     flsz = caz(ShoppingList)
<<"Shopping list size $flsz \n"
<<" $ShoppingList \n"
  tname = "gracias"
  ShoppingList<-Insert(2,tname)
<<"Shopping list size $flsz \n"
<<" $ShoppingList \n"
  tname = "que tal"
  ShoppingList<-Insert(3,tname)
     flsz = caz(ShoppingList)
<<"Shopping list size $flsz \n"

 ShoppingList<-Sort()
<<" $ShoppingList \n"

testargs(1,ShoppingList)

// delete operations


// clear

// delete current, head, tail

  ShoppingList<-LiDelete(-1)

<<" $ShoppingList \n"
   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"

  ShoppingList<-LiDelete(0)

<<" $ShoppingList \n"

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"

// delete nth item


  ShoppingList<-LiDelete(2)

<<" $ShoppingList \n"

   flsz = caz(ShoppingList)

<<"Shopping list size $flsz \n"


 chkN(flsz,7)

<<" %(1,<|, ,|>\n)$ShoppingList \n"
 lhead = ShoppingList[0];
 ltail = ShoppingList[-1];


 

 lval = ShoppingList<-getLitem();

<<"%V $lhead $ltail $lval\n"

 nxtval = ShoppingList<-getNextLitem();

<<"%V  $nxtval\n"

 nxtval = ShoppingList<-getNextLitem();

<<"%V  $nxtval\n"

 preval = ShoppingList<-getPrevLitem();
 <<"%V  $preval\n"


// for (i=0;i < (flsz+10); i++) {
 for (i=0;i < (flsz-1); i++) {
 preval = ShoppingList<-getPrevLitem();
 <<"$i  $preval\n"
}

 for (i=0; i < (flsz+10); i++) {
  nxtval = ShoppingList<-getNextLitem();
  <<"$i   $nxtval\n"
}

  ShoppingList<-Insert(0,"top item")
   flsz = caz(ShoppingList)


 hval = ShoppingList<-getLitem(0);

<<"%V $lhead $ltail $hval\n"

 chkStr(hval,"top item")

<<" $ShoppingList \n"


  ShoppingList<-Insert(-1,"bottom item")
   flsz = caz(ShoppingList)


 tval = ShoppingList<-getLitem(-1);

<<"%V  <|$tval|>\n"

 chkStr(tval,"bottom item")

<<" $ShoppingList \n"


AList = ("0","1","2","3"  )  // empty list --- bug first item null?

<<" $AList \n"

flsz = caz(AList)

<<"size $flsz\n"

 hval = AList<-getLitem(0);
 tval = AList<-getLitem(-1);

<<"%V $hval $tval\n"
 AList<-Insert(0,"top item")
   flsz = caz(AList)


<<"size $flsz\n"

 hval = AList<-getLitem(0);
 tval = AList<-getLitem(-1);

<<"%V $hval $tval\n"
<<" $AList \n"

AList<-Insert(-1,"bottom item")
   flsz = caz(AList)

 hval = AList<-getLitem(0);
 tval = AList<-getLitem(-1);

<<"%V $hval $tval\n"
<<" $AList \n"
chkOut()
  
/* 
 *  @script list_ins_del.asl 
 * 
 *  @comment test list insert delete 
 *  @release CARBON 
 *  @vers 1.39 Y Yttrium [asl 6.3.63 C-Li-Eu] 
 *  @date 11/27/2021 23:43:10          
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug.asl"

   debugON();

 if (_dblevel >0) {

     debugON();

     }

   

   chkIn(_dblevel);

   db_ask = 0;

 //allowDB("spe,ds,ic_call,pex,vmf", 1)
 allowDB("spe_declare,pex,vmf,list,ds_sivlist,spil", 1)

    // empty list --- bug first item null?;

 //  List  ShoppingList(STRV_);

    ShoppingList = ("xxx","abc","exp_e"  )  ;



 //  ShoppingList.insert(LIBEG_,"xxx","abc","exp_e"  )  ;

   ShoppingList.pinfo();


   <<" $ShoppingList \n";

ans= ask("debe ...  OK?",db_ask)

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   chkN(flsz,3)

   ShoppingList.pinfo();


   //chkOut(1)


   ShoppingList.Insert(LIEND_,"list_ops");

   <<" $ShoppingList \n";
    ShoppingList.pinfo();

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   chkN(flsz,4)


   ShoppingList.Insert(LIBEG_,"vmf_list");

   <<" $ShoppingList \n";
    ShoppingList.pinfo();

  // ShoppingList.Delete(0);
  
   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

     chkN(flsz,5)
     
 ShoppingList.deleteStr("abc",LIBEG_,1);

 ShoppingList.pinfo();

    <<" $ShoppingList \n";

   flsz = caz(ShoppingList);

        chkN(flsz,4)


 ShoppingList.deleteStr("list_ops",LIBEG_,1);

 ShoppingList.pinfo();

    <<" $ShoppingList \n";

   flsz = caz(ShoppingList);

        chkN(flsz,3)

  //tname = "debe esforzarse más"


   //chkOut(1)


   tname = "debe esforzarse mas";



   ShoppingList.pinfo();

   preval = ShoppingList.getPrevLitem();

   <<"preval  <|$preval|>\n";

   ShoppingList.Insert(LIBEG_,tname);

   <<"inserting <$tname> into Shopping list \n";

   ShoppingList.pinfo();

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   <<" $ShoppingList \n";

   ans= ask("debe ...  OK?",db_ask)

   preval = ShoppingList.getPrevLitem();

   <<"preval  <|$preval|>\n";



   ShoppingList.Insert(LIBEG_,"declare_e");

   tname = "Camino a cinco kilometros al dia";

   <<"inserting <$tname> into Shopping list \n";

   ShoppingList.Insert(LIHOT_,tname);

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   <<" $ShoppingList \n";

   preval = ShoppingList.getPrevLitem();

   <<"preval  <|$preval|>\n";
//  flab = cab(ShoppingList)
//<<"Shopping list bounds $flab \n"

   ShoppingList.Insert(LIHOT_,"Debo organizar mi vida");

   ShoppingList.Insert(LIHOT_,"Irse a tiempo","leave on time"); // multiple inserts;

   ShoppingList.Insert(LIEND_,"lost in  space"); //  same initial letter -cause a swop;

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   if (flsz > 1) {

     <<" These modules added! \n";

     ShoppingList.Sort() ; // TBF 10/12/21;

     <<" $ShoppingList \n";

     }

   <<"%V $ShoppingList \n";

   <<"0 $ShoppingList[0] \n";

   <<"1 $ShoppingList[1] \n";

   <<"2 $ShoppingList[2] \n";

   <<"3 $ShoppingList[3] \n";

   tname = "head here";

   ShoppingList.Insert(0,tname);

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   <<" $ShoppingList \n";

   tname = "tail here";

   ShoppingList.Insert(LIEND_,tname);

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   <<" $ShoppingList \n";

   tname = "gracias";

   ShoppingList.Insert(2,tname);

   <<"Shopping list size $flsz \n";

   <<" $ShoppingList \n";

   tname = "que tal";

   ShoppingList.Insert(3,tname);

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   ShoppingList.Sort();

   <<" $ShoppingList \n";

   testargs(1,ShoppingList);
// delete operations
// clear
// delete current, head, tail

   ShoppingList.Delete(-1);

   <<" $ShoppingList \n";

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";

   ShoppingList.Delete(0);

   <<" $ShoppingList \n";

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";
// delete nth item

   ShoppingList.Delete(2);

   <<" $ShoppingList \n";

   flsz = caz(ShoppingList);

   <<"Shopping list size $flsz \n";
   ShoppingList.pinfo()

   chkN(flsz,11);

   <<" %(1,<|, ,|>\n)$ShoppingList \n";

   lhead = ShoppingList[0];

   ltail = ShoppingList[-1];

   lval = ShoppingList.getLitem(0);

   <<"%V $lhead $ltail $lval\n";

   nxtval = ShoppingList.getNextLitem();

   <<"%V  $nxtval\n";
      ans= ask("next $nxtval  OK?",db_ask)

   nxtval = ShoppingList.getNextLitem();

   <<"%V  $nxtval\n";

      ans= ask("next $nxtval  OK?",db_ask)

   nxtval = ShoppingList.getNextLitem();

   <<"%V  $nxtval\n";

      ans= ask("next $nxtval  OK?",db_ask)
      


   preval = ShoppingList.getPrevLitem();

   <<"%V  $preval\n";
// for (i=0;i < (flsz+10); i++) {

    
        flsz = caz(ShoppingList);
   lval = ShoppingList.getLitem(-1);

<<"%V $lval\n"

     for (i=0; i < (flsz-1); i++) {

       ShoppingList.pinfo()

       preval = ShoppingList.getPrevLitem();

       preval.pinfo()
       
       <<"$i  $preval\n";
       ans= ask("$i $preval  OK?",db_ask)
       }


  fval = ShoppingList.getLitem(0);

<<"%V $fval\n"

     for (i=0; i < flsz; i++) {

       ShoppingList.pinfo()

       nxtval = ShoppingList.getNextLitem();

       nxtval.pinfo()
       
       <<"$i   $nxtval\n";
  ans= ask("next $nxtval  OK?",db_ask)
       }

     ShoppingList.Insert(0,"top item");

     flsz = caz(ShoppingList);
    ShoppingList.pinfo();

<<"$ShoppingList \n"

   ans= ask("List OK?",db_ask)

     Str hval;

     hval = ShoppingList.getLitem(0);

     <<"%V $lhead $ltail $hval\n";

     chkStr(hval,"top item");

     <<" $ShoppingList \n";

     ShoppingList.Insert(-1,"bottom item");

     flsz = caz(ShoppingList);

     tval = ShoppingList.getLitem(-1);

     <<"%V  <|$tval|>\n";

     chkStr(tval,"bottom item");

     <<" $ShoppingList \n";

//     AList = ("0","1","2","3"  )  ; // empty list --- bug first item null?;

       List AList(STRV_);

 AList.insert( LIEND_,"0","1","2","3"  )  ; // empty list --- bug first item null?;

     <<" $AList \n";

     flsz = caz(AList);

     <<"size $flsz\n";

     hval = AList.getLitem(0);

     tval = AList.getLitem(-1);

     <<"%V $hval $tval\n";

     AList.Insert(0,"top item");

     flsz = caz(AList);

     <<"size $flsz\n";

     hval = AList.getLitem(0);

     tval = AList.getLitem(-1);

     <<"%V $hval $tval\n";

     <<" $AList \n";

     AList.Insert(-1,"bottom item");

     flsz = caz(AList);

     hval = AList.getLitem(0);

     tval = AList.getLitem(-1);

     <<"%V $hval $tval\n";

     <<" $AList \n";

     chkOut();




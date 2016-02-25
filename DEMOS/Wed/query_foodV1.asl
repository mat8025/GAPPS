// Menus -
// maybe XML versions later

setdebug(1)

////////////  CREATE SIMPLE CHOICE MENU /////////////
A=ofw("Food.m")
<<[A],"title Food\n"
<<[A],"item Meat C_MENU Meats Pork\n"
<<[A],"help which meat\n"
<<[A],"item Fish C_Menu Fish\n"
<<[A],"help \n"
<<[A],"item Eggs C_Menu Eggs\n"
<<[A],"help \n"
<<[A],"item Fruit C_Menu Fruits\n"
<<[A],"help \n"
<<[A],"item Vegetable C_MENU Vegs\n"
<<[A],"help \n"
<<[A],"item Bread C_MENU Bread\n"
<<[A],"help \n"
<<[A],"item Pizza C_MENU Pizza\n"
<<[A],"help \n"
<<[A],"item Snack C_MENU Snack\n"
<<[A],"help \n"
cf(A)


A=ofw("Meats.m")
<<[A],"title Meat\n"
<<[A],"item Pork M_VALUE Pork\n"
<<[A],"help type of meat\n"
<<[A],"item Beef M_VALUE Beef\n"
<<[A],"help \n"
//<<[A],"item Poultry C_MENU Poultry Chicken\n"
<<[A],"item Chicken M_VALUE Chicken\n"
<<[A],"help type of meat\n"
<<[A],"item Duck M_VALUE Duck\n"
<<[A],"help \n"
<<[A],"item Goose M_VALUE Goose\n"
<<[A],"help \n"
cf(A)

A=ofw("Fish.m")
<<[A],"title Fish\n"
<<[A],"item Salmon M_VALUE Salmon\n"
<<[A],"item Tuna M_VALUE Tuna\n"
<<[A],"item Cod M_VALUE Cod\n"
<<[A],"help type of fish\n"
<<[A],"item SwordFish M_VALUE SwordFish\n"
<<[A],"help \n"
cf(A)

A=ofw("Eggs.m")
<<[A],"title Eggs\n"
<<[A],"item Fried M_VALUE Fried,Egg\n"
<<[A],"item Scrambled M_VALUE Scrambled,Egg\n"
<<[A],"item Hard Boiled M_VALUE Hard_Boiled,Egg\n"
<<[A],"help \n"
cf(A)



A=ofw("Fruits.m")
<<[A],"title Fruits\n"
<<[A],"item Apple M_VALUE Apple\n"
<<[A],"help \n"
<<[A],"item Banana M_VALUE Banana\n"
<<[A],"help \n"
<<[A],"item Peach M_VALUE Peach\n"
<<[A],"help \n"
<<[A],"item Pear M_VALUE Pear\n"
<<[A],"help \n"
<<[A],"item Plum M_VALUE Plum\n"
<<[A],"help \n"
<<[A],"item Orange M_VALUE Orange\n"
<<[A],"help \n"
<<[A],"item Raspberry M_VALUE Raspberry\n"
<<[A],"help \n"
<<[A],"item Strawberry M_VALUE Strawberry\n"
<<[A],"help \n"

cf(A)

A=ofw("Vegs.m")
<<[A],"title Vegetable_per_Oz\n"
<<[A],"item Mushroom M_VALUE Mushroom\n"
<<[A],"help \n"
<<[A],"item Potato M_VALUE Potato\n"
<<[A],"help \n"
<<[A],"item Tomato M_VALUE Tomato\n"
<<[A],"help \n"
cf(A)


A=ofw("Bread.m")
<<[A],"title Breads\n"
<<[A],"item White M_VALUE White\n"
<<[A],"help \n"
<<[A],"item Wheat M_VALUE Wheat\n"
<<[A],"help \n"
<<[A],"item Rye M_VALUE Rye\n"
<<[A],"help \n"
cf(A)



A=ofw("Pizza.m")
<<[A],"title Pizza\n"
<<[A],"item Pepporoni M_VALUE Pepperoni\n"
<<[A],"help type of meat\n"
<<[A],"item Cheese M_VALUE Cheese\n"
<<[A],"help \n"
<<[A],"item Hawaiian M_VALUE Hawaiian\n"
<<[A],"help \n"
cf(A)

A=ofw("Soup.m")
<<[A],"title Soups\n"
<<[A],"item Tomato M_VALUE TomatoSoup\n"
<<[A],"help type of meat\n"
<<[A],"item ChickenSoup M_VALUE ChickenSoup\n"
<<[A],"help \n"
<<[A],"item Mushroom_VALUE MushroomSoup\n"
<<[A],"help \n"
cf(A)

A=ofw("Snack.m")
<<[A],"title Snack\n"
<<[A],"item Popcorn M_VALUE Popcorn\n"
<<[A],"help type of meat\n"
<<[A],"item HotPocket M_VALUE Hotpocket\n"
<<[A],"help \n"
<<[A],"item CandyBar M_VALUE CandyBar\n"
<<[A],"help \n"
cf(A)




/////////////////////////////////////////////////////////////////////////
//setdebug(0)


//<<"#                          Fat  Carbohydrate Protein  Cholesterol  Weight Saturated_Fat Calories \n"
//<<"#                          (Grams) (Grams) (Grams) (Milligrams)    (Grams)  (Grams)     (cals) \n"
//<<"#  computed from food_log.dat  and food_table.dat   via getfpc.asl \n"


//  food class

class Food {

 public:


    svar descr;
    svar unit ; //could be 1/2
    svar amt ;
    svar ans ;

 // per unit

    float wt     // grams
    float satfat
    int fat    
    int carbs
    float prot
    int chol   // mgrams
    int cals


  CMF setval(fdsc,rs)
    {


      if (slen(rs) < 40) {
     // <<"$fdsc \n"
     // <<"$rs \n"
        <<"too short $rs \n"
        //stop!

      }


         nsa=sscan(rs,'%s %s %d %d %d %f %d %f %f',&amt,&unit,&fat,&cals,&carbs,&prot,&chol,&wt,&satfat)

 // <<"$nsa %V$descr $unit $amt $fat %4.2f $prot %d$cals $carbs $wt\n"

        if (nsa <= 0) {
      <<"ERROR $fdsc \n"
      <<"$rs \n"
        stop!

        }

         //nsa =sscan(rs,'%s %s %d %d %d %d %d %f %f',unit,amt,fat,cals,carbs,prot,chol,wt,satfat)
//      <<"%V$nsa \n"
         descr = fdsc
//      <<"$descr $unit $amt $fat $cals $carbs $wt\n"

      return nsa
    }


  CMF check (edsc, fw)
    {

     // find desc anywhere with table desc?
     // want word initial search so white-space then word " PEAR" searches for pear won't get spear
     // like to use regex

     fd_len = slen(edsc)

     ok = 0

     descr_w = split(descr)

//     <<"$descr_w[0]  $edsc \n"


     rind = sstr(descr_w[0],edsc, 1)

//<<">>> $descr $descr_w[0] $edsc $rind $fw \n"

     if (fw != 1) {

       if (rind != 0) {

        needle = "$edsc"

        rind = sstr(descr, needle, 1)

//<<"$descr $needle $rind\n"

       }

    }

     if (rind != -1) {
        if (scmp(descr_w[0],edsc,0,0)) {
 <<" perfect!\n"
<<">>> $descr $descr_w[0] $edsc $rind $fw \n"
           ok = 2 // perfect fit
        }
        else 
         ok =1
     }

    yn = ok


    if (ok == 1) {
//<<"is $edsc within  $descr ?? $ok $rind\n"
//iread()
    }

      return (ok)
    }

///////////////////////

  CMF checkQualifier (edsc)
    {

     // find qualifier edesc anywhere with table desc?
     // want word initial search so white-space then word " PEAR" searches for pear won't get spear


     fd_len = slen(edsc)

     ok = 0

     descr_w = split(descr)

  <<" Qualifier  ? $descr_w[1]  $edsc \n"


     rind = sstr(descr_w[1],edsc, 1)

//<<">>> $descr $descr_w[0] $edsc $rind  \n"



       if (rind != 0) {

        needle = "$edsc"

        rind = sstr(descr, needle, 1)

//<<"$descr $needle $rind\n"

       }



     if (rind != -1) {
        if (scmp(descr_w[1],edsc,0,0)) {
// <<" Qualifier perfect!\n"
<<">>> $descr $descr_w[1] $edsc $rind $fw \n"
           ok = 2 // perfect fit
        }
        else 
         ok =1
     }

    yn = ok



    if (ok >= 1) {
//<<" $edsc is within  $descr ?? $ok $rind\n"
    }

      return (ok)
    }


///////////////



  CMF query()
    {

     ans ="$descr[0] $amt[0] $unit[0] %V$cals $carbs $fat ${chol} mg %4.1f $prot $satfat $wt"

     return ans
    }


  CMF print()
    {

     <<"$descr[0] $amt[0] $unit[0] %V$cals $carbs $fat ${chol} mg %4.1f $prot $satfat  $wt  \n"

    }


  CMF getdescr()
    {

      return descr

    }

  CMF getans()
    {

      return ans

    }

  CMF getamt()
    {
     //<<" getting  amt $amt\n"

      return amt

    }

  CMF getunit()
    {
     //<<" getting  unit $unit\n"

      return unit
    }

  CMF getcarbs()
    {
//<<" getting carbs $carbs\n"
      return carbs
    }

  CMF getcals()
    {
      return cals
    }

  CMF getprot()
    {
      return prot
    }

  CMF getfat()
    {
      return fat
    }

  CMF getsatfat()
    {
      return satfat
    }


}




int txtwo = 0

the_carbs = 0
the_cals = 0
the_prot = 0
the_fat = 0
the_satfat = 0.0

query_res = ""
the_descr = ""

proc checkFood()
{

str the_amt
str the_unit

int nfd



<<" looking for $f_amt $f_unit of $myfood \n"

the_unit = "1";

//the_carbs = 0
//the_cals = 0
//the_prot = 0
//the_fat = 0
//the_satfat = 0.0
// split myfood into words via commas (so WS can be part of search string - no commas in database string!) 
// check for presence of each word (partial word is ok) but all of search string has to be present
// any order of search strings is ok
// lets check for commas - use that to split
// else use WS to split


   food_d = split(myfood,',')

//<<"%V$food_d \n"

nfd = Caz(food_d)

//<<"$nfd : $food_d[0] \n"

 food_d[0] = ssub(food_d[0],"y","",-1)

ynqual = 0

do_first_word = 1

looked_twice =0

  while (1) {

     the_unit = "oz"
     the_amt = "1"


    for (i = 0 ; i < jf ; i++) {

//<<"$i  $food_d[0]\n"

      ynfood = Fd[i]->check(food_d[0], do_first_word)

// got to check other qualifiers


      if (ynfood) {

        ynqual = 1

        Fd[i]->print()

         if (nfd > 1) {

         qual = food_d[1]

         // <<"$nfd now  checking qualifier $qual\n"

          ynqual = Fd[i]->checkQualifier(qual)

          if (ynqual) {
                   if (nfd > 2) {
                   qual = food_d[2]
                   <<"$nfd now  checking qualifier $food_d[2] $qual\n";
                   ynqual = Fd[i]->check(qual,0)
                   }
                 if (ynqual) {  
               //  <<"Qualifier FOUND $food_d[0] $food_d[1] $food_d[2]\n";
                Fd[i]->print()
                 }
          }
          else {
<<"$qual not in \n"
          }


         }


//<<"%V$the_unit \n"       

        if (ynqual) {

        the_amt = Fd[i]->getamt()
        the_amt = Fd[i]->amt

<<"$i setting the_amt to $the_amt \n"

        the_unit = Fd[i]->getunit()

//<<"setting the_unit $the_unit \n"

        the_unit = Fd[i]->unit

//<<"setting the_unit $the_unit \n"

        the_carbs = Fd[i]->getcarbs()

        the_cals = Fd[i]->getcals()

        the_prot = Fd[i]->getprot()

        the_fat = Fd[i]->getfat()

        the_satfat = Fd[i]->getsatfat()

//<<"%V$myfood $the_unit $Fd[i]->unit $the_amt $the_cals $the_carbs\n"
//<<"%V$myfood $the_unit $the_amt $the_carbs $the_cals $the_prot\n"

        query_res = "%V$myfood $the_unit $the_amt $the_carbs $the_cals $the_prot"
        
        the_descr = Fd[i]->getdescr()


        fit = 0
        amt_fit = 0
        unit_fit = 0

//i_read()

//<<"%V$the_amt $f_amt \n"

        if (sstr(the_amt,f_amt,1) != -1) {
           amt_fit = 1
        }

        if (f_amt @= "*") {
           amt_fit = 0
        }

        if (sstr(the_unit,f_unit,1) != -1) {
           unit_fit = 1
        }

        if (f_unit @= "*") {
           unit_fit = 0
        }

        if (amt_fit && unit_fit) {

<<"AMT  and UNIT FITS \n"
<<"%V$the_amt $f_amt \n"

//         Fd[i]->print()
           wans = Fd[i]->query()
           //<<"$wans \n"

<<"$myfood $the_unit $the_amt carbs  $Fd[i]->carbs  cals $Fd[i]->cals  fat $Fd[i]->fat chol $Fd[i]->chol %4.1f prot $Fd[i]->prot satfat $Fd[i]->satfat\n"

//         break

        }
      }
     }
   }

    if (ynqual) {

//          break
 
   }

    if (looked_twice) {
         break
    } 

   looked_twice =1
   do_first_word = 0
 }

}


proc listFoods(n)
{

    for (i = 0 ; i < n ; i++) {
           Fd[i]->print()
    }
}


//////////////////////////////////////////////////////////////////////////

ftfile = "food_tableV2.dat" 

//ftfile = "food_table_test.dat" 

A=  ofr(ftfile)

if (A == -1) {

<<" can't open food table $ftfile \n"
exit()

}

  S=readfile(A)


  nlines = Caz(S)

<<"%v$nlines\n"

 Nfoods  = nlines + 10

 Food Afd

<<" one food is good!\n"
<<" now for $Nfoods foods\n"

 int n_f = 950
 Food Fd[n_f]

 str fline

 jf = 0
f_unit = "*"
f_amt = "1"


///////////////////////////////////////  PARSE FOOD TABLE //////////////////////////////

 k = 0

 jf = 0

 int err = 0



 k= 0



 while (1) {

   fline = S[k]

   if (fline @="") {
        break
   }

   k++

   if (!scmp(fline,"#",1)) {


// split line into first 30 chars and rest

// <<"[${k}] $nlines %V$fline \n"

    fd = sele(fline,0,30)

// <<"%V$fd \n"

//<<"trying sele \n"

    rs = sele(fline,31,-1)

//<<"%V$jf $rs \n"

//<<"trying setval \n"

     err= Fd[jf]->setval(fd,rs)

//<<"ret setval $err\n"
//<<"trying print \n"

//   Fd[jf]->print()

    jf++


//<<"$k $jf <${fd}> $unit $amt $fat $cals $carbs $wt\n"
//i_read()

   if (err <= 0) { 
       break
   }

   }


  if (k >= (nlines-1))
     break

 }



//<<" we have $jf foods \n"
   //listFoods(jf)
//////////////////////////////////////////////////////



  myfood = "strawberr,raw"
  f_unit = "*"
  f_amt = "1"

  wans = Fd[0]->query()


//////////////////////////  PARSE THE COMMAND LINE //////////////////////////////
 do_loop = 0 // default - single shot query via CL args

 na = argc()

 wa = _clarg[1]

 if (! (wa @= "")) {
  myfood = wa
//<<" looking for $myfood \n"
 }

 if (na > 1) {
  f_unit = _clarg[2]
 }

 if (na > 2) {
  f_amt = _clarg[3]
 }


 if (na > 3) {
  val = _clarg[4]
  if (val @= "loop") {
     do_loop = 1
  }
}
 






 checkFood()



//<<" FOUND ?\n"






/////////////////////////////// GUI /////////////////////////////////


Graphic = CheckGwm()

do_loop = 0


if (!Graphic) {



// entering query loop !

 if (do_loop ) {

  while (1) {

<<" New Query\n"

//  ok=reload_src(1)
// <<"reload_src ? $ok \n"

 //  foo()
//<<" doing foo \n"

  ans=i_read("food $myfood ? : ")

  if (! (ans @="") ) {
    myfood = ans
<<"new food is $myfood\n"
  }

  if (myfood @= "quit") {
    break;
  }

  uans = i_read("unit $f_unit ?: ")

  if (! (uans @="")) {
    f_unit = uans
  }

  aans = i_read("amt $f_amt ?: ")

  if (! (aans @="")) {
    f_amt = aans
  }

  checkFood()

 }

}
;
          stop!
}


proc getWoMsg()
{
<<"getting MSG \n"
   Woproc = ""

   msg = E->waitForMsg()

   <<"msg $msg \n"

//   setgwob(two,@redraw)
//   setgwob(two,@textr,"$msg",0.1,0.8)

   E->geteventstate(evs)
   keyw = E->getEventKeyw()
   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   
<<"%V$Woproc \n"
<<"%V$Woname $Evtype $Woid $Woaw $Woval\n"
<<" callback ? $Woproc\n"
}
//----------------------------------------------------------


if (Graphic) {

// make a window

    vp2 = cWi(@title,"DailyDiet",@resize,0.1,0.1,0.6,0.7,0)

    sWi(vp2,@resize,0.1,0.1,0.7,0.5,@clip,0.1,0.1,0.7,0.9,@redraw)

    sWi(vp2,@pixmapon,@drawoff,@save,@bhue,"white")

// make a Wob 

 gwo=cWo(vp2,@MENU,@name,"When",@color,"green",@resize,0.1,0.8,0.2,0.9)

 sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"When",@STYLE,"SVB")
 sWo(gwo,@bhue,BLUE,@clipbhue,"skyblue")
 sWo(gwo,@menu,"Breakfast,AM-Snack,Lunch,PM-Snack,Dinner,Supper,MN-Snack")

 gwo2=cWo(vp2,@MENU_FILE,@name,"FoodTypes",@color,"green",@resize,0.21,0.8,0.3,0.9)
 // does value remain or reset by menu?
 sWo(gwo2,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue",@VALUE,"Meat",@STYLE,"SVB",@menu,"Food.m")
 sWo(gwo2,@bhue,"red",@clipbhue,"skyblue")


 cookedwo=cWo(vp2,@menu,@name,"Cooked",@color,"green",@resize,0.31,0.8,0.4,0.9)
 sWo(cookedwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"Cooked",@STYLE,"SVB")
 sWo(cookedwo,@bhue,BLUE,@clipbhue,"skyblue")
 sWo(cookedwo,@menu,"raw,fried,baked,boiled,sauted,curried")


 portwo=cWo(vp2,@menu,@name,"Amount",@color,"green",@resize,0.31,0.8,0.4,0.9)
 sWo(portwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"When",@STYLE,"SVB")
 sWo(portwo,@bhue,BLUE,@clipbhue,"skyblue")
 sWo(portwo,@menu,"1,2,3,4,5,6,7,8,9,10")



 qtywo=createGWOB(vp2,@menu,@name,"Quantity",@color,"green",@resize,0.31,0.8,0.4,0.9)
 sWo(qtywo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"When",@STYLE,"SVB")
 sWo(qtywo,@bhue,BLUE,@clipbhue,"skyblue")
 sWo(qtywo,@menu,"oz,floz,cup,tbsp,slice,link,pie,large,medium,small")


 querywo=createGWOB(vp2,"BN",@name,"QUERY",@color,"green",@resize,0.41,0.8,0.5,0.9)
 sWo(querywo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"QUERY",@STYLE,"SVB")
 sWo(querywo,@bhue,BLUE,@clipbhue,"skyblue")

 int bvec[] = {gwo,gwo2,cookedwo,portwo,qtywo,querywo}

 wo_htile(bvec,0.1,0.8,0.5,0.9)


 tvwo=createGWOB(vp2,"BV",@name,"MYFOOD",@VALUE,"apple",@color,"green",@resize,0.51,0.85,0.65,0.95)

 sWo(tvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVB")
 sWo(tvwo,@bhue,"teal",@clipbhue,"magenta",@FUNC,"inputValue")

//<<"make a sheet \n"

 gwo3=createGWOB(vp2,@sheet,@name,"DailyDiet",@color,"green",@resize,0.1,0.15,0.95,0.78)
 // does value remain or reset by menu?

 sWo(gwo3,@setrowscols,12,12,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"SSWO")
 sWo(gwo3,@bhue,"cyan",@clipbhue,"skyblue")

 sWo(gwo3,@sheetrow,0,0,"When,Food,Cooked,Amount,Qty,Cals,Carbs,Fat_g,Prot_g,Satfat_g")
 sWo(gwo3,@sheetrow,1,0,"Breakfast,egg,fried,2,20,90,1,7,6")


 txtwo=createGWOB(vp2,@text,@name,"Text",@VALUE,"howdy",@color,"orange",@resize,0.1,0.01,0.9,0.14)

 sWo(txtwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff)
 sWo(txtwo,@SCALES,0,0,1,1)
 sWo(txtwo,@help," Mouse & Key Info ")




 when = "Breakfast"
 amt = "2"
 food = "egg"

myfood ="POTATO"
f_unit = "*"
f_amt = "*"
cooked = "raw"
qty = "oz"





// GUI interactive loop



// enable a menu
// event loop to process menu's


      setgwindow(vp2,@redraw)



//include "event"




E =1 // event handle

Svar msg
int evs[16];
keyw = "xxx"
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0


int ssr_i = 1

f_cooked = "raw"

   while (1) {

          getWoMsg()

          if (! (keyw @= "NO_MSG")) {

          <<"keyw $keyw name $Woname value $Woval\n"

          if (keyw @= "When") {
             when = Woval
             sWo(gwo3,@sheetrow,1,0,"$when,$food,$f_cooked,$f_amt,$the_cals,$the_carbs,$the_fat,$the_prot,0")
             sWo(gwo3,@redraw)
          }
          else if (keyw @= "Cooked") {
             f_cooked = Woval
             sWo(gwo3,@sheetrow,2,0,"$when,$food,$f_cooked,$f_amt,$qty,$the_cals,$the_carbs,$the_fat,$the_prot,0")
             sWo(gwo3,@clear,@redraw)
          }

          else if (keyw @= "Amount") {
             f_amt = Woval
             sWo(gwo3,@sheetrow,2,0,"$when,$food,$f_cooked,$f_amt,$qty,$the_cals,$the_carbs,$the_fat,$the_prot,0")
             sWo(gwo3,@clear,@redraw)
          }
          else if (keyw @= "Quantity") {
             qty = Woval
             sWo(gwo3,@sheetrow,3,0,"$when,$food,$f_cooked,$f_amt,$qty,$the_cals,$the_carbs,$the_fat,$the_prot,0")
             sWo(gwo3,@clear,@redraw)
          }

          else if (keyw @= "FoodTypes") {
             food = Woval
             sWo(gwo3,@sheetrow,4,0,"$when,$food,$f_cooked,$f_amt,$qty,$the_cals,$the_carbs,$the_fat,$the_prot,$the_satfat")
             sWo(gwo3,@redraw)
          }
          else if (Woname @= "QUERY") {
          <<"run query with $food $amt \n" 
           myfood = food
           checkFood()
           sWo(gwo3,@sheetrow,ssr_i,0,"$when,$food,$f_cooked,$f_amt,$qty,$the_cals,$the_carbs,2,8,5")
           sWo(gwo3,@redraw)
           sWo(txtwo,@textr,"$when,$food,$amt,$qty,$the_cals,$the_carbs,$the_fat,$the_prot,$the_satfat",0.1,0.5)
           ssr_i++
          }
          else if (Woname @= "MYFOOD") {

            food = Woval

          <<"Use text input $food for query \n" 

           myfood = food

           w_food = split(food,',')
           f_unit = qty

           checkFood()

           sWo(txtwo,@clear,@redraw)

           sWo(txtwo,@textr,"$query_res\n",0.1,0.6)
           // fix sheetrow > 1

           sWo(gwo3,@sheetrow,1,0,"$when, $w_food[0],$f_cooked, $f_amt, $f_unit, $the_cals,$the_carbs,$the_fat,$the_prot,$the_satfat")
  
           sWo(gwo3,@redraw)

           sWo(txtwo,@textr,"$when,$food,$amt,$the_cals,$the_carbs,$the_fat,$the_prot",0.1,0.4)

           sWo(txtwo,@textr,"$the_descr",0.1,0.2)

           ssr_i++ ; // next row


          }
        }
   
    }

<<"end of graphic\n"

}

<<"OUT \n"
stop!

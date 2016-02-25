
///  GUI for food query


// Menus -
// maybe XML versions later



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




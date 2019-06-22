//%*********************************************** 
//*  @script menus.asl 
//* 
//*  @comment test menus 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Tue Jun 18 15:15:44 2019 
//*  @cdate Tue Jun 18 15:15:44 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

////////////  CREATE SIMPLE CHOICE MENU /////////////

include "debug"
 
 scriptDBON();
 debugON();
 sdb(1,@~keep,@~pline)


 include "gevent"
 include "hv.asl"


A=ofw("FoodTypes.m")
<<[A],"title FoodTypes\n"
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
<<[A],"item ? C_INTER xx\n"
<<[A],"help \n"
cf(A)

// maybe XML versions
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
<<[A],"item Fried M_VALUE Fried_Egg\n"
<<[A],"item Scrambled M_VALUE Scrambled_Egg\n"
<<[A],"item Hard Boiled M_VALUE Hard_Boiled_Egg\n"
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




     Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }

include "tbqrd.asl" 

// make a window

    vp = cWi(@title,"DailyDiet")

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)
  titleButtonsQRD(vp);

// make a Wob 

 gwo=cWo(vp,@MENU,@name,"When",@color,GREEN_,@resize,0.1,0.8,0.2,0.9)
 sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,WHITE_,@VALUE,"When",@STYLE,"SVB")
 sWo(gwo,@bhue,BLUE_,@clipbhue,"skyblue",@value,"Lunch",@MESSAGE,1)
 sWo(gwo,@menu,"Breakfast,AM-Snack,Lunch,PM-Snack,Dinner,Supper,MN-Snack");
 <<" made menu wo %V $gwo \n"


 gwo2=cWo(vp,@MENUFILE,@name,"FoodTypes",@color,"green",@resize,0.21,0.8,0.3,0.9)
 // does value remain or reset by menu?
 sWo(gwo2,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,WHITE_,@VALUE,"Meat",@STYLE,"SVB")
 sWo(gwo2,@bhue,BLUE_,@clipbhue,"skyblue");
sWo(gwo2,@func,"wo_menu",@menu,"FoodTypes.m")
 <<" made menu_file wo %V $gwo2 \n"


 portwo=cWo(vp,@MENU,@name,"Portion",@color,"green",@resize,0.31,0.8,0.4,0.9)
 sWo(portwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,WHITE_,@VALUE,"medium",@STYLE,"SVB")
 sWo(portwo,@bhue,BLUE_,@clipbhue,"skyblue")
 sWo(portwo,@menu,"1,2,3,Tiny,Small,Medium,Large,Huge");

 <<" made menu wo %V $portwo \n"


 querywo=cWo(vp,@BN,@name,"QUERY",@color,GREEN_,@resize,0.41,0.8,0.5,0.9)
 sWo(querywo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,WHITE_,@VALUE,"QUERY",@STYLE,"SVB")
 sWo(querywo,@bhue,BLUE_,@clipbhue,"skyblue");
 
 <<" made query wo %V $querywo \n"

 gwo3=cWo(vp,"SHEET",@name,"DailyDiet",@color,"green",@resize,0.1,0.1,0.8,0.5)
 // does value remain or reset by menu?
 sWo(gwo3,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"SSWO",@FUNC,"inputValue")
 sWo(gwo3,@bhue,"cyan",@clipbhue,"skyblue")

 <<" made sheet wo %V $gwo3 \n"

//////

 rows = 8
 cols = 10
 
 sWo(gwo3,@setrowscols,rows,cols);
 sWo(gwo3,@sheetrow,0,0,"When,Food,Portion,Qty_Oz,Cals,Carbs,Fat_g,Prot_g")
 sWo(gwo3,@sheetrow,1,0,"Breakfast,egg,2,20,90,1,7,6")

 sWo(gwo3,@selectrowscols,0,7,0,9);

 when = "Breakfast"
 portion = "2"
 food = "egg"

// enable a menu
// event loop to process menu's

   sWi(vp,@redraw)

   

//wu = choice_menu("Units.m",0,0)
   the_row = 1;



   while (1) {

         eventWait();



         if (_erow > 0) {
            the_row = _erow;
         }

<<" $_emsg %V $_ekeyw  $_ewoname $_ewoval $_erow $_ecol\n"
         
  
        if (! (_ekeyw @= "NO_MSG")) {
         
	  if (_ewoname @= "When") {
             when = _ewoval;
	     when = _ekeyw;
             sWo(gwo3,@sheetrow,the_row,0,"$when,$food,$portion,20,90,1,7,6")
             sWo(gwo3,@redraw)
          }
          else if (_ewoname @= "Portion") {
             portion = _ewoval;
	     portion = _ekeyw;
	     
	     <<"%V$portion\n"	     
              sWo(gwo3,@sheetrow,the_row,0,"$when,$food,$portion,20,90,1,7,6")
             sWo(gwo3,@clear,@redraw)
          }
          else if (_ewoname @= "FoodTypes") {
             food = _ewoval;
	    // food = _ekeyw;
	     <<"%V$food\n"
	     food = "$_ekeyw $_ewoval"
             sWo(gwo3,@sheetrow,the_row,0,"$when,$food,$portion,20,90,1,7,6")
             sWo(gwo3,@redraw)
          }
          else if (_ewoname @= "QUERY") {

          <<"run query with $food $portion \n" 

          }
        }
   }




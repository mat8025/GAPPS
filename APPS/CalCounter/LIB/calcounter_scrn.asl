//%*********************************************** 
//*  @script calcounter_scrn.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.8 O Oxygen                                                   
//*  @date Wed Dec 26 07:34:23 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
///   ddc screen
///
//int Fcols = 10;

 CFx= 0.74 + 0.01
 CFX= 0.99

    vp = cWi(@title,"S2D:$day_name")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@resize,0.01,0.01,0.95,0.99,@clip,0.1,0.1,0.98,0.99)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

    //  readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);


//      int ssmods[] = { savewo };
//      sWo(ssmods,@font,F_TINY_)

      sortffwo = cWo(vp,@BN,@name,"SORT_FF",@color,CYAN_);

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVB");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)


      int ffmods[] = {sortffwo, pguwo,pgdwo,pgnwo,savewo };


      wohtile(ffmods,CFx,0.9,0.99,0.99,0.05);

   //   wovtile(ssmods,0.71,0.1,Modsx,0.2,0.05);

      sWo(ffmods,@font,F_TINY_)


///////////////////////////// MENU - FoodTypes //////////////////////////////

 mwo=cWo(vp,@MENU,@name,"FoodType",@color,GREEN_,@resize,CFx,0.81,0.9,0.89,@style,"SVR")
 sWo(mwo,@border,@drawon,@clipborder,@fonthue,WHITE_,@value,"WhatFoods")
 sWo(mwo,@bhue,BLUE_,@clipbhue,"skyblue",@value,"Breakfast",@message,1)
 sWo(mwo,@menu,"Breakfast,Favorites,Meals,Meats-Fowl,Meats-Beef,Breads,Veg,Cheese,Fruits,Fish,Cereals,Cakes,Pies,Soups,Juices,Sodas,Drinks");
 sWo(mwo,@redraw)


 Fx =0.01
 FX=0.73
 cellwo=cWo(vp,@SHEET,@name,"DailyCalCnt",@color,GREEN_,@resize,Fx,0.12,FX,0.96)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,BLACK_,@value,"1");

 sWo(cellwo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);


 totalswo = cWo(vp,@sheet,@name,"Totals",@color,BLUE_,@resize,Fx,0.02,FX,0.11)
 <<"%V$totalswo \n"
// sWo(totalswo,@border,@drawon,@clipborder,@fonthue,ORANGE_,@value,"1",@func,"xxx")
 sWo(totalswo,@border,@drawon,@clipborder,@fonthue,BLACK_,@value,"1")

 sWo(totalswo,@bhue,RED_,@font,F_SMALL_,@clipbhue,SKYBLUE_,@redraw);




 foodswo=cWo(vp,@sheet,@name,"FoodFavorites",@color,GREEN_,@resize,CFx,0.30,CFX,0.79)
 sWo(foodswo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")
 sWo(foodswo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);


  searchwo =cWo(vp,"BV",@name,"FoodSearch",@color,GREEN_,@resize,CFx,0.2,CFX,0.29)
  sWo(searchwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"Apple Pie",@func,"inputValue");
  sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVB_, @redraw);


 choicewo=cWo(vp,@sheet,@name,"FoodChoice",@color,GREEN_,@resize, CFx,0.01,CFX,0.19)

 sWo(choicewo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")
 sWo(choicewo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);




  sWo(ssmods,@redraw);
  sWo(ffmods,@redraw);  


  sWo(choicewo,@redraw);
  sWo(totalswo,@redraw);  
  sWo(foodswo,@redraw);

  titleVers();
  sWi(vp,@redraw);
 <<"%V$totalswo \n"

//=====================================

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

    vp = cWi(@title,"S2D:$day_name")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@resize,0.01,0.01,0.95,0.99,@clip,0.1,0.1,0.98,0.99)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

     // swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);
    
      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      //arwo = cWo(vp,@BN,@name,"Addrow",@color,ORANGE_,@bhue,"lightblue");

      int ssmods[] = { readwo,savewo,sortwo,delrwo };
      sWo(ssmods,@font,F_TINY_)

      sortffwo = cWo(vp,@BN,@name,"SORT_FF",@color,CYAN_);

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)


      int ffmods[] = {sortffwo, pguwo,pgdwo,pgnwo };

      Modsx= 0.74
      wovtile(ssmods,0.71,0.5,Modsx,0.8,0.05);

      wovtile(ffmods,0.71,0.1,Modsx,0.4,0.05);

      sWo(ffmods,@font,F_TINY_)


///////////////////////////// MENU - FoodTypes //////////////////////////////

 mwo=cWo(vp,@MENU,@name,"FoodType",@color,GREEN_,@resize,0.72,0.81,0.8,0.88)
 sWo(mwo,@border,@drawon,@clipborder,@fonthue,WHITE_,@value,"WhatFoods",@STYLE,"SVB")
 sWo(mwo,@bhue,BLUE_,@clipbhue,"skyblue",@value,"Breakfast",@message,1)
 sWo(mwo,@menu,"Breakfast,Meals,Meats-Fowl,Meats-Beef,Breads,Veg,Cheese,Fruits,Fish,Cereals,Cakes,Pies,Soups,Juices,Sodas,Drinks");
 sWo(mwo,@redraw)


 Fx =0.01
 FX=0.70
 cellwo=cWo(vp,@SHEET,@name,"DailyCalCnt",@color,GREEN_,@resize,Fx,0.12,FX,0.96)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,BLACK_,@value,"1");

 sWo(cellwo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);


 totalswo = cWo(vp,@sheet,@name,"Totals",@color,BLUE_,@resize,Fx,0.02,FX,0.11)
 <<"%V$totalswo \n"
// sWo(totalswo,@border,@drawon,@clipborder,@fonthue,ORANGE_,@value,"1",@func,"xxx")
 sWo(totalswo,@border,@drawon,@clipborder,@fonthue,BLACK_,@value,"1")

 sWo(totalswo,@bhue,RED_,@font,F_SMALL_,@clipbhue,SKYBLUE_,@redraw);


 CFx= Modsx + 0.01
 CFX= 0.99

  searchwo =cWo(vp,"BV",@name,"FoodSearch",@color,GREEN_,@resize,0.72,0.90,75,0.98)
  
  sWo(searchwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"Apple Pie",@func,"inputValue");
  sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVB_, @redraw);

 choicewo=cWo(vp,@sheet,@name,"FoodChoice",@color,GREEN_,@resize, CFx,0.51,CFX,0.80)

 sWo(choicewo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(choicewo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);


 foodswo=cWo(vp,@sheet,@name,"FoodFavorites",@color,GREEN_,@resize,CFx,0.01,CFX,0.50)


 sWo(foodswo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(foodswo,@bhue,CYAN_,@font,F_TINY_,@clipbhue,SKYBLUE_,@redraw);

  sWo(ssmods,@redraw);
  sWo(ffmods,@redraw);  


  sWo(choicewo,@redraw);
  sWo(totalswo,@redraw);  
  sWo(foodswo,@redraw);

  titleVers();
  sWi(vp,@redraw);
 <<"%V$totalswo \n"

//=====================================

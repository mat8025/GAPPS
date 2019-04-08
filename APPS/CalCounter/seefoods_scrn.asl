//%*********************************************** 
//*  @script seefoods_scrn.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Jan  1 10:20:10 2019 
//*  @cdate Tue Jan  1 10:20:10 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


    vp = cWi(@title,"SeeFoods:$fname")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modify functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      swpcwo = cWo(vp,@BN,@name,"SWOPCOLS",@color,RED_);

      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      delcwo = cWo(vp,@BN,@name,"DELCOL",@color,ORANGE_,@bhue,YELLOW_);

      arwo = cWo(vp,@BN,@name,"ADDROW",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)

      int ssmods[] = { readwo,savewo,sortwo,swprwo,swpcwo,delrwo, delcwo, arwo,pguwo,pgdwo,pgnwo }


      wovtile(ssmods,0.05,0.1,0.1,0.9,0.01);




 cellwo=cWo(vp,"SHEET",@name,"Stuff2Do",@color,GREEN_,@resize,0.12,0.2,0.9,0.95)
 // does value remain or reset by menu?

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

  searchwo =cWo(vp,"BV",@name,"FoodSearch",@color,GREEN_,@resize,0.12,0.05,0.5,0.19)
  sWo(searchwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"Type in food name",@func,"inputValue");

   sWi(vp,@redraw)
 sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVR_, @redraw);
   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);


//=======================
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

    vp = cWi(@title,"S2D:$day_name")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.95,0.9)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);
    
      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      //arwo = cWo(vp,@BN,@name,"Addrow",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)


      int ssmods[] = { readwo,savewo,sortwo,swprwo,delrwo, pguwo,pgdwo,pgnwo };


      wovtile(ssmods,0.05,0.2,0.1,0.9,0.05);

 Fx =0.20
 
 cellwo=cWo(vp,@SHEET,@name,"DailyCalCnt",@color,GREEN_,@resize,Fx,0.52,0.98,0.96)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1");

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);

 favorwo=cWo(vp,"SHEET",@name,"FoodFavor",@color,GREEN_,@resize,Fx,0.24,0.98,0.51)

 sWo(favorwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(favorwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);



 choicewo=cWo(vp,"SHEET",@name,"FoodChoice",@color,GREEN_,@resize,Fx,0.01,0.98,0.23)

 sWo(choicewo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(choicewo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);


  searchwo =cWo(vp,"BV",@name,"FoodSearch",@color,GREEN_,@resize,0.02,0.01,Fx-0.01,0.14)
  
  sWo(searchwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"Type in food name",@func,"inputValue");

//sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVL_, @redraw);
  sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVB_, @redraw);

  sWo(ssmods,@redraw);

 // sWo(cellwo,@redraw);

  sWo(choicewo,@redraw);
  sWo(favorwo,@redraw);

  titleVers();
  sWi(vp,@redraw);


//=====================================
//%*********************************************** 
//*  @script editfoods_scrn.asl 
//* 
//*  @comment add/edit a food entry 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Wed Jan 16 18:08:31 2019 
//*  @cdate Wed Jan 16 18:08:31 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


    vp = cWi(@title,"S2D:$fname")

//    sWi(vp,@resize,0.1,0.01,0.95,0.95,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@resize,0.1,0.01,0.95,0.95,0)

  

    sWi(vp,@clip,0.1,0.1,0.95,0.95)

    sWi(vp,@redraw)


  //clk=getMouseClick()

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);
    
      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      addrwo = cWo(vp,@BN,@name,"Addrow",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)


      int ssmods[] = { readwo,savewo,sortwo,swprwo,delrwo, addrwo, pguwo,pgdwo,pgnwo };


      wovtile(ssmods,0.05,0.2,0.1,0.9,0.05);


 cellwo=cWo(vp,@SHEET,@name,"EditFoods",@color,GREEN_,@resize,0.12,0.42,0.98,0.96)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1");

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);

 choicewo=cWo(vp,"SHEET",@name,"FoodChoice",@color,GREEN_,@resize,0.12,0.2,0.98,0.40)

 sWo(choicewo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(choicewo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);


  searchwo =cWo(vp,"BV",@name,"FoodSearch",@color,GREEN_,@resize,0.12,0.05,0.5,0.19)
  
  sWo(searchwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"Type in food name",@func,"inputValue");

//sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVL_, @redraw);
  sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVR_, @redraw);

  sWo(ssmods,@redraw);

 // sWo(cellwo,@redraw);

  sWo(choicewo,@redraw);

  titleVers();
  sWi(vp,@redraw);


//=====================================
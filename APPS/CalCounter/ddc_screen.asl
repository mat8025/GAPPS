///
///   ddc screen
///

    vp = cWi(@title,"S2D:$fname")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

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
      

      int ssmods[] = { readwo,savewo,sortwo,swprwo,delrwo, pguwo,pgdwo };


      wovtile(ssmods,0.05,0.2,0.1,0.9,0.05);


 cellwo=cWo(vp,"SHEET",@name,"DailyCalCnt",@color,GREEN_,@resize,0.12,0.51,0.9,0.95)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);

 choicewo=cWo(vp,"SHEET",@name,"FoodChoice",@color,GREEN_,@resize,0.12,0.2,0.9,0.40)

 sWo(choicewo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1",@func,"xxx")

 sWo(choicewo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);


  searchwo =cWo(vp,"BV",@name,"FoodSearch",@color,GREEN_,@resize,0.12,0.05,0.5,0.19)
  sWo(searchwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"Type in food name",@func,"inputValue");

//sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVL_, @redraw);
  sWo(searchwo,@bhue,CYAN_,@clipbhue,LIGHTGREEN_,@style, SVR_, @redraw);

  sWo(ssmods,@redraw);

 // sWo(cellwo,@redraw);

  sWo(choicewo,@redraw);

  sWi(vp,@redraw);


//=====================================
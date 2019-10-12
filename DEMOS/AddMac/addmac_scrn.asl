//%*********************************************** 
//*  @script addmac_scrn.asl 
//* 
//*  @comment screen setup for addmac 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Thu Oct  3 05:03:39 2019 
//*  @cdate Thu Oct  3 05:03:39 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
///
///



    vp = cWi(@title,"S2D:$bill_name")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.98,0.98)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

     // swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);
    
      delwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      addwo = cWo(vp,@BN,@name,"AddItem",@color,ORANGE_,@bhue,"lightblue");

      int ssmods[] = { readwo,savewo,sortwo,addwo,delwo };

      sortffwo = cWo(vp,@BN,@name,"SORT_FF",@color,CYAN_);

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)


      int ffmods[] = {sortffwo, pguwo,pgdwo,pgnwo };

      wovtile(ssmods,0.05,0.55,0.1,0.9,0.05);

      wovtile(ffmods,0.05,0.2,0.1,0.5,0.05);

 Fx =0.20
 
 cellwo=cWo(vp,@SHEET,@name,"DailyCalCnt",@color,GREEN_,@resize,Fx,0.25,0.98,0.96)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"1");

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);

  //sWo(choicewo,@redraw);


 totalwo=cWo(vp,@BV,@name,"TOTAL",@color,GREEN_,@resize,0.1,0.01,0.3,0.20)

 sWo(totalwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"0.0",@style, SVR_)

 sWo(totalwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw);





  titleVers();
  sWi(vp,@redraw);


//=====================================
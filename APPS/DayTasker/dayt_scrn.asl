//%*********************************************** 
//*  @script dayt_scrn.asl 
//* 
//*  @comment  screen setup for daytasker
//*  @release CARBON 
//*  @vers 1.1 H.H 
//*  @date Sat Dec 22 10:34:57 2018 
//*  @author Mark Terry 
//*  @CopyRight  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


include "tbqrd.asl"

    vp = cWi(@title,"S2D:$fname")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modify functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      arwo = cWo(vp,@BN,@name,"ADDTASK",@color,ORANGE_,@bhue,"lightblue");

      favwo = cWo(vp,@BN,@name,"ADDFAV",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)

      int ssmods[] = { readwo,savewo,sortwo,swprwo,delrwo, arwo, favwo,pguwo,pgdwo,pgnwo };

      wovtile(ssmods,0.05,0.1,0.1,0.9,0.01);


 cellwo=cWo(vp,"SHEET",@name,"Stuff2Do",@color,GREEN_,@resize,0.12,0.25,0.9,0.95)
 // does value remain or reset by menu?

 //sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")
 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

 txtwo=cWo(vp,"TEXT",@name,"edit",@color,GREEN_,@resize,0.12,0.05,0.8,0.24)

 scorewo = cWo(vp,@BV,@name,"SCORE",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");

 sWo(scorewo,@resize,0.82,0.05,0.9,0.24);

   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

<<" %V $_include \n"
//=======================//
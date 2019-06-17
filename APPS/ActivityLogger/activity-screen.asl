//%*********************************************** 
//*  @script activity-screen.asl 
//* 
//*  @comment screen windows/buttons setup  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Jun 17 12:42:47 2019 
//*  @cdate Mon Jun 17 12:42:47 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///

    vp = cWi(@title,"S2D:$fname",@resize,0.1,0.1,0.9,0.8)

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.1,0.9,0.80)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///  GSS  modify functions

      openwo = cWo(vp,@BN,@name,"OPEN",@color,YELLOW_);

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);
      
      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);


      int ssmods[] = { openwo, readwo,savewo,sortwo};

      wovtile(ssmods,0.05,0.5,0.1,0.75,0.01);

 cellwo=cWo(vp,@SHEET,@name,"Stuff2Do",@color,BLUE_,@resize,0.12,0.25,0.9,0.95)

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

 txtwo=cWo(vp,@TEXT,@name,"edit",@color,GREEN_,@resize,0.12,0.05,0.8,0.24)

 scorewo = cWo(vp,@BV,@name,"SCORE",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");

 sWo(scorewo,@resize,0.82,0.05,0.9,0.24);

  sWi(vp,@title,"S2D:$fname")

   titleVers();

   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

//=======================================//

wkwo=cWo(vp,@BV,@name,"Week",@value," $wkn",@color,BLUE_,@fonthue,RED_,@penhue,BLACK_)
 sWo(wkwo,@help," This Week")

 yrwo=cWo(vp,@BV,@name,"Year",@value," $yrn",@color,YELLOW_,@fonthue,BLACK_)
 sWo(yrwo,@help," This Year")

 monwo=cWo(vp,@BV,@name,"Month",@value," $mon",@color,GREEN_,@fonthue,WHITE_)
 sWo(monwo,@help," This Month")


 int dmywos[] = { wkwo,monwo,yrwo}

 sWo(dmywos,@border,@drawon,@clipborder,@STYLE,"SVR")
 wovtile (dmywos, 0.02,0.76,0.1,0.95)
 
 sWo(dmywos,@redraw);
 /////////////////////////////////////////////////////////////

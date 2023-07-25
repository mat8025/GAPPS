///
///   gss screen
///

    vp = cWi("GSS:$fname")

    sWi(_WOID,vp,_Wpixmap,0,_Wdraw,0,_Wsave,ON_,_Wbhue,WHITE_)

    sWi(_WOID,vp,_Wclip,wbox(0.1,0.2,0.9,0.9))

    sWi(_WOID,vp,_Wredraw)

    titleButtonsQRD(vp);

///    GSS  modifiy functions

      readwo = cWo(vp,WO_BN_)
      sWo(_WOID,readwo,_Wname,"READ",_Wcolor,"lightgreen");
      
      
      savewo = cWo(vp,WO_BN_);
      sWo(_WOID,savewo,_Wname,"SAVE",_Wcolor,LILAC_);

      sortwo = cWo(vp,WO_BN_)
      sWo(_WOID,sortwo,_Wname,"SORT",_Wcolor,CYAN_);

      swprwo = cWo(vp,WO_BN_)
      sWo(_WOID,swprwo,_Wname,"SWOPROWS",_Wcolor,GREEN_);

      swpcwo = cWo(vp,WO_BN_)
      sWo(_WOID,swpcwo,_Wname,"SWOPCOLS",_Wcolor,RED_);

      delrwo = cWo(vp,WO_BN_)
      sWo(_WOID,delrwo,_Wname,"DELROWS",_Wcolor,RED_);

      delcwo = cWo(vp,WO_BN_)
      sWo(_WOID,delcwo,_Wname,"DELCOL",_Wcolor,ORANGE_,_Wbhue,YELLOW_);

      arwo = cWo(vp,WO_BN_)
      sWo(_WOID,arwo,_Wname,"ADDROW",_Wcolor,ORANGE_,_Wbhue,"lightblue");

      pgdwo = cWo(vp,WO_BN_)
      sWo(_WOID,pgdwo,_Wname,"PGDWN",_Wcolor,ORANGE_,_Wbhue,"pink");

      pguwo = cWo(vp,WO_BN_)
      sWo(_WOID,pguwo,_Wname,"PGUP",_Wcolor,ORANGE_,_Wbhue,"golden");

      pgnwo = cWo(vp,WO_BV_)

      sWo(_WOID,pgnwo,_Wname,"PGN",_Wcolor,ORANGE_,_Wbhue,"cyan",_Wvalue,0,_Wstyle,"SVR");
      
      sWo(_WOID,pgnwo,_Wbhue,WHITE_,_Wclipbhue,RED_,_WFUNC,"inputValue",_Wcallback,"PGN",_WMESSAGE,1)

      int ssmods[] = { readwo,savewo,sortwo,swprwo,swpcwo,delrwo, delcwo, arwo,pguwo,pgdwo,pgnwo }


      wovtile(ssmods,0.05,0.1,0.1,0.9,0.01);




     cellwo=cWo(vp,"SHEET");
 
 sWo(_WOID,cellwo,_Wname,"GSS",_Wcolor,GREEN_,_Wresize,wbox(0.12,0.1,0.9,0.95))
 // does value remain or reset by menu?

 sWo(_WOID,cellwo,_Wborder,BLACK_,_Wdraw,ON_,_Wclipborder,RED_,_Wfonthue,RED_,_Wvalue,"SSWO",_Wfunc,"bell")

 sWo(_WOID,cellwo,_Wbhue,CYAN_,_Wclipbhue,SKYBLUE_,_Wredraw,ON_)


   sWi(_WOID,vp,_Wredraw,ON_)

   sWo(_WOID,ssmods,_Wredraw,ON_)

   sWo(_WOID,cellwo,_Wredraw,ON_)

   titleVers("1.1");
<<"DONE gss_screen\n"
//=======================
///
///   stuff2Do screen
///

/{
proc colorRows(r,c)
{
int icr=0;
int jcr = c -1;

   for(icr = 0; icr < r ; icr++) {
	
        if ((icr%2)) {
          sWo(cellwo,@cellbhue,icr,1,icr,jcr,LILAC_);

	}
	else {
	    sWo(cellwo,@cellbhue,icr,1,icr,jcr,YELLOW_);
	 }
     }

<<[_DB]"$_proc done\n"
}
//============================================//
/}






//==============================================//
<<"in stuff2do_scrn\n"

    vp = cWi(@title,"S2D:$fname",@resize,0.1,0.1,0.9,0.8)

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modify functions

      openwo = cWo(vp,@BN,@name,"OPEN",@color,"lightgreen");

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      swpcwo = cWo(vp,@BN,@name,"SWOPCOLS",@color,BLUE_);

      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      atwo = cWo(vp,@BN,@name,"ADDTASK",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)

      int ssmods[] = { openwo,readwo,savewo,sortwo,swprwo,swpcwo,delrwo,  atwo,pguwo,pgdwo,pgnwo };


    wovtile(ssmods,0.05,0.05,0.1,0.9,0.01);


    cellwo=cWo(vp,"SHEET",@name,"Stuff2Do",@color,GREEN_,@resize,0.12,0.25,0.9,0.95)
 // does value remain or reset by menu?

    //sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")
   sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO")

   sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

// txtwo=cWo(vp,"TEXT",@name,"edit",@color,GREEN_,@resize,0.12,0.05,0.8,0.24)
 txtwo=cWo(vp,@GRAPH,@name,"edit",@color,YELLOW_,@resize,0.12,0.05,0.8,0.24)


//            sWo(txtwo,@clip,@save,@savepixmap,@drawon,@pixmapon,@pixmapdrawon)
 sWo(txtwo,@clipsize,0.1,0.05,0.9,0.95,@save,@savepixmap,@drawon,@pixmapon,@pixmapdrawon)
 sWo(txtwo,@font,"medium")

 scorewo = cWo(vp,@BV,@name,"SCORE",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");

 sWo(scorewo,@resize,0.82,0.05,0.9,0.24);

 titleVers();
   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);


//=======================
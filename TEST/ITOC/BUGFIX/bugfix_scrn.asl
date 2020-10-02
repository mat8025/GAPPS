///
///   bugfix screen
///

<<"inc bugfix screen $_include\n"


///
///    more than one xgs running - can cause second to fail
///    SHM  resource is starved?? --- need a error report
///



proc colorRows()
{
int i;
int j;
<<"%V $rows $cols $cellwo \n"
     j = cols-1;
     for (i = 0; i< rows ; i++) {
   // <<"$i $cellwo\n"
       if ((i%2)) {
           sWo(cellwo,@cellbhue,i,0,i,j,LILAC_);         
 	}
       else {
	   sWo(cellwo,@cellbhue,i,0,i,j,TURQUOISE_);         
 	 }
      }
 <<[_DB]"done colorRows\n"

 
}
//==================================//



    vp = cWi(@title,"S2D:$fname",@resize,0.01,0.02,0.5,0.9,0)

<<"%V $vp\n"


    ret=sWi(vp,@resize,0.01,0.02,0.9,0.9,0)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

    sWi(vp,@redraw)

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    gflush()



//    vp2 = cWi(@title,"S2D:$fname",@resize,0.51,0.02,0.9,0.9,0)
//<<"%V $vp2\n"
    titleButtonsQRD(vp);


    sWi(vp2,@redraw)

///    GSS  modfiy functions

     // readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);


      arwo = cWo(vp,@BN,@name,"ADDBR",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)

      int ssmods[] = { savewo,sortwo,swprwo,delrwo,  arwo,pguwo,pgdwo,pgnwo }


      wovtile(ssmods,0.05,0.1,0.1,0.9,0.01);


    cellwo=cWo(vp,@SHEET,@name,"BugFix",@color,GREEN_,@resize,0.12,0.1,0.9,0.95)
 // does value remain or reset by menu?

   //sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")
   sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO")

   sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

   titleVers();
   
   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);


//=======================
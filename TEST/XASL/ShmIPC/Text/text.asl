//%*********************************************** 
//*  @script text.asl 
//* 
//*  @comment test fonts and text 
//*  @release CARBON 
//*  @vers 1.9 F Fluorine                                                  
//*  @date Fri May 10 11:49:12 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


/// make sure rotated fonts are loaded!

/// check
/// xlsfonts | grep rot

/// TBD ?? use XSetFontPath --- in ms/mc_font setup??





  envdebug()

int Graphic = 0;



 if (!Graphic) {
    Xgm_pid = spawnGWM("Text")
<<"xgs pid ? $Xgm_pid \n"
  }

       int our_pid = getpid();
       printf("our pid %d\n",our_pid);
  Graphic = checkGWM()

<<"%V $Graphic \n"

//ans=ask("¿Es eso correcto?  [y,n,q]",DB_action);


//!!"xset fp+ /home/mark/gasp-CARBON/fonts "


<<"xset fp+ /home/mark/gasp-CARBON/fonts "
<<" do this prior to launch ??? interferes with graphic setup??\n"
//ans=query("-->")



#include "debug.asl"
#include "hv.asl"
#include "tbqrd.asl"

int two;
int txtwin;



  ignoreErrors()


 txtwin = cWi("TextWins")

  <<"%V $txtwin\n"



 sWi(_woid,txtwin,_wpixmap,off_,_wdraw,on_,_wsave,on_,_wbhue,YELLOW_,_wresize,wbox(0.1,0.1,0.9,0.9),_wsticky,on_)

 sWi(_woid,txtwin,_wclip,wbox(0.1,0.2,0.9,0.9),_wbhue,WHITE_,_wredraw,ON_)

  //ans=ask("¿Es eso correcto?  [y,n,q]",DB_action);

 titleButtonsQRD(txtwin);


// wpt


  sWi(_woid,txtwin,_wsetgrid,wpt(20,20));

// setting a grid on parent window for positioning of Wobs
 // wpt is an SF which returns A siv float vector of three floats
 // wpt(n,m,[o=1])

 // using grid positions for Wo boxes
 
 two=cWo(txtwin,WO_TEXT_)
 <<"%V $two \n"
 sWo(_woid,two,_wname,"TextR",_wvalue,"howdy",_wcolor,MAGENTA_,_wresize,wbox(1,10,10,19,WGRID_))



 sWo(_woid,two,_wborder,on_,_wdraw,on_,_wclipborder,RED_,_wfonthue,BLACK_,_wpixmap,OFF_)
 sWo(_woid,two,_wscales,wbox(0,0,1.0,1.0),_wclipbhue,LILAC_,_wcolor,GREEN_,_wredraw,on_);
 sWo(_woid,two,_whelp," Mouse & Key Info ")


 sWi(_woid,txtwin,_wredraw,ON_);

  

ans = i_read("->")


 stwo=cWo(txtwin,WO_TEXT_)

 sWo(_woid,stwo,_wname,"PrintText",_wvalue,"howdy this is the first line",_wcolor,BLUE_,_wresize,wbox(2,10,6,19,WGRID_))
 sWo(_woid,stwo,_wborder,RED_,_wdraw,on_,_wclipborder,BLUE_,_wfonthue,BLACK_ )
 
 sWo(_woid,stwo,_wscales,wbox(0,0,1,1),_wbhue,MAGENTA_)
 sWo(_woid,stwo,_wfont,F_MEDIUM_)
 
 sWo(_WOID,stwo,_Whelp," Mouse & Key Info ",_wredraw,ON_);


<<"MOuseClick\n"

  getMouseClick()

ans = i_read("->")

 bigwo=cWo(txtwin,WO_GRAPH_)
 sWo(_woid,bigwo,_wname,"bigtext",_wvalue,"big font?",_wcolor,GREEN_,_wresize,wbox(9,13,18,19,WGRID_)))
 sWo(_woid,bigwo,_wborder,BLACK_,_wdraw,on_,_wclipborder,RED_,_wfonthue,BLACK_ ,_wpixmap,off_,_wdraw,on_,_wsave,on_)
 sWo(_woid,bigwo,_wbhue,WHITE_,_wscales,wbox(0,0,1,1))
 sWo(_woid,bigwo,_wfont,F_BIG_,_wredraw,ON_)

ans = i_read("->")
 ipwo= cWo(txtwin,WO_TEXT_)

 sWo(_woid,ipwo,_wname,"InputText",_wvalue,"",_wcolor,RED_,_wresize,wbox(6,1,12,12,WGRID_))
 sWo(_woid,ipwo,_wclip,wbox(0.1,0.1,0.9,0.9),_wclipbhue,YELLOW_)
 sWo(_woid,ipwo,_wborder,BLACK_,_wdraw,on_,_wclipborder,RED_,_wfonthue,BLACK_,_wfunc,"editValue")
 sWo(_woid,ipwo,_wfont,F_MEDIUM_,_wredraw,ON_)

ans = i_read("->")

ipwo2=cWo(txtwin,WO_GRAPH_)
 sWo(_WOID,ipwo2,_wname,"InputText2",_wvalue,"abc",_wcolor,RED_,_wresize,wbox(14,2,19,12,WGRID_))
 sWo(_WOID,ipwo2,_wclip,wbox(0.1,0.1,0.9,0.9),_wclipbhue,MAGENTA_)
 sWo(_WOID,ipwo2,_wborder,GREEN_,_wdraw,ON_, _wfonthue,BLACK_, _wdraw,ON_,_wfunc,"editValue")
 sWo(_WOID,ipwo2,_wfont,F_ITALIC_,_wredraw,ON_)

//ans=query("--> italic font F_ITALIC_")
//sWo(_WOID,ipwo,_Wfont,F_ITALIC_)

ans = i_read("->")


// resize fractional 0, pixel offset 1, real scales 2, grid pos 3






 lvwo=cWo(txtwin,WO_TEXT_)
 sWo(_woid,lvwo,_wname,"PrintText",_wvalue,"lvtext",_wcolor,BLUE_,_wresize,wbox(2,1,3,9,WGRID_))
 sWo(_woid,lvwo,_wborder,RED_,_wdraw,ON_,_wclipborder,RED_,_wfonthue,BLACK_ ,_wdraw,ON_,_wsave,ON_)
 sWo(_woid,lvwo,_wscales,wbox(0,0,1,1))
 
 sWo(_woid,lvwo,_wfont,F_ROTATE_)

 rvwo=cWo(txtwin,WO_TEXT_)

 sWo(_WOID,rvwo,_wname,"PrintText",_wvalue,"rvtext",_wcolor,GREEN_,_wresize,wbox(4,1,5,9,WGRID_))

 sWo(_WOID,rvwo,_wborder,GREEN_,_wdraw,ON_,_wclipborder,BLUE_,_wfonthue,BLACK_,_wdraw,ON_,_wsave,ON_)

 sWo(_WOID,rvwo,_wscales,wbox(0,0,1,1))
 
 sWo(_WOID,rvwo,_wfont,F_ROTATE90_)





 


  int txwos[] = {lvwo,rvwo,bigwo,two};

  sWo(_WOID,txwos,_wredraw,ON_);
 
  //titleVers();
 
//////////////////////////////////////////////////

//ans=query("-->")


#include "gevent.asl"



xp = 0.1
yp = 0.5

char txtip[512];


mnum = 0

str txt ="WXYZ";

int do_txt_stuff = 1;

while (1) {




   if (do_txt_stuff) {


    sWo(_woid,two,_wtextr,"$GEV_msg",0.1,0.8)

    sWo(_woid,stwo,_wprint,"$GEV_msg\n") ;
    
    sWo(_woid,stwo,_wprint,"%V$GEV_woname $GEV_button\n");

<<"  $ipwo gotit ?\n"



//      sWo(_WOID,txwos,_Wclear);

     txt=woGetText(ipwo);
 <<" got $txt  \n";
      // rotated text??
      deftxt ="says me";

      //txt = woGetValue(ipwo)
      <<"ipwo_txt: $txt \n"


   //  sWo(_WOID,lvwo,_wfont,F_ROTATE90_,_wtextr,"$deftxt",0.3,0.1,0,-90,RED_);
     sWo(_WOID,lvwo,_wfont,F_ROTATE90_,_wtextr,"$deftxt",0.3,0.1,0,-90,BLACK_);
      sWo(_WOID,rvwo,_wfont,F_ROTATE_,_wtextr,"$txt",0.5,0.9,0,90,BLUE_);

     // sWo(_WOID,bigwo,_wfont,F_BIG_,_wtextr,Textr("$deftxt",0.0,0.6,0,0,BLACK_);
      sWo(_WOID,bigwo,_wfont,F_BIG_,_wtextr,"$deftxt",0.0,0.6,0,0,BLACK_);
      sWo(_WOID,bigwo,_wtextr,"$deftxt",0.0,0.6,0,0,BLACK_);
     sWo(_WOID,bigwo,_wfont,F_MEDIUM_,_wtextr,"$txt",0.0,0.4,0,0,MAGENTA_);
      sWo(_WOID,bigwo,_wfont,F_SMALL_,_wtextr,"$txt",0.0,0.5,0,0,BLACK_);

      sWo(_WOID,lvwo,_Wfont,F_SMALL_,_wprint,"$txt");            

      mnum++;
      //sWo(_WOID,ipwo,_Wvalue,"");
    }

     eventWait()


    if (_ekeyw ==  "EXIT_ON_WIN_INTRP") {
     <<"WIN_INTRP\n";
     break;
    }


  }

exit()

////////////////////////////////
/// text starts space in?
///
/// italic, bold
///
/// text input/edit
/// needs to process mouse cursor position 
/// repaint line cntrl L  adds a return 
///  rentry to page - paints lines wrong position
///  font change per line?
///  default insert -- action to change to over write?
///  click outside page wo - will exit input/edit --- done
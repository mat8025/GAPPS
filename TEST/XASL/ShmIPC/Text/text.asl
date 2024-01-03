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

#include "tbqrd.asl"

 if (!Graphic) {
    Xgm_pid = spawnGWM("Text")
<<"xgs pid ? $Xgm_pid \n"
  }

       int our_pid = getpid();
       printf("our pid %d\n",our_pid);
  Graphic = checkGWM()

<<"%V $Graphic \n"

ans=ask("¿Es eso correcto?  [y,n,q]",DB_action);


//!!"xset fp+ /home/mark/gasp-CARBON/fonts "


<<"xset fp+ /home/mark/gasp-CARBON/fonts "
<<" do this prior to launch ??? interferes with graphic setup??\n"
//ans=query("-->")



#include "debug.asl"
#include "hv.asl"


int two;
int txtwin;

 Gevent Gev ;

  Gev.pinfo();

  ignoreErrors()


 txtwin = cWi("TextWins")

  <<"%V $txtwin\n"


 //sWi(_WOID,txtwin,_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_,_WBHUE,YELLOW_,_WRESIZE,wbox(0.1,0.1,0.9,0.9),_WSTICKY,ON_)
 sWi(_WOID,txtwin,_WPIXMAP,OFF_,_WDRAW,ON_,_WSAVE,ON_,_WBHUE,YELLOW_,_WRESIZE,wbox(0.1,0.1,0.9,0.9))

 sWi(_WOID,txtwin,_WCLIP,wbox(0.1,0.2,0.9,0.9),_WREDRAW,ON_)


  ans=ask("¿Es eso correcto?  [y,n,q]",DB_action);

   //titleButtonsQRD(txtwin);



 sWi(_WOID,txtwin,_WSETGRID,wpt(20,20));  // setting a grid on parent window for position


 // using grid positions for Wo boxes
 
 two=cWo(txtwin,WO_TEXT_)
 <<"%V $two \n"
 sWo(_WOID,two,_WNAME,"TextR",_WVALUE,"howdy",_WCOLOR,ORANGE_,_WRESIZE,wbox(0.1,0.1,0.9,0.9))


// two=cWo(txtwin,"TEXT",_Wname,"TextR",_WVALUE,"howdy",_Wcolor,ORANGE_,_Wresize,0.1,0.7,0.5,0.9)
 sWo(_WOID,two,_WBORDER,ON_,_WDRAW,ON_,_WCLIPBORDER,RED_,_WFONTHUE,BLACK_,_WPIXMAP,OFF_)
 sWo(_WOID,two,_WSCALES,wbox(0,0,1,1),_WREDRAW,ON_);
 sWo(_WOID,two,_WHELP," Mouse & Key Info ")


 sWi(_WOID,txtwin,_WREDRAW,ON_);

  




 stwo=cWo(txtwin,WO_TEXT_)

 sWo(_WOID,stwo,_WNAME,"PrintText",_WVALUE,"howdy this is the first line",_WCOLOR,BLUE_,_WRESIZE,(2,10,6,15,3))
 sWo(_WOID,stwo,_WBORDER,BLACK_,_WDRAW,ON_,_WCLIPBORDER,BLUE_,_WFONTHUE,BLACK_ )
 
 sWo(_WOID,stwo,_WSCALES,wbox(0,0,1,1))
 sWo(_WOID,stwo,_WFONT,F_SMALL_)
 sWo(_WOID,stwo,_Whelp," Mouse & Key Info ",_Wredraw);

  ans=iread("->");

//getMouseClick()



 bigwo=cWo(txtwin,WO_TEXT_)
 sWo(_WOID,bigwo,_WNAME,"BigText",_WVALUE,"Big Font?",_WCOLOR,"orange",_Wresize,wbox(9,13,18,19,3)))
 sWo(_WOID,bigwo,_WBORDER,BLACK_,_WDRAW,ON_,_WCLIPBORDER,RED_,_WFONTHUE,BLACK_ ,_WPIXMAP,OFF_,_Wdraw,ON_,_WSAVE,ON_)
 sWo(_WOID,bigwo,_Wbhue,WHITE_,_WSCALES,wbox(0,0,1,1))
 sWo(_WOID,bigwo,_Wfont,F_BIG_)


 ipwo= cWo(txtwin,WO_TEXT_)

sWo(_WOID,ipwo,_WNAME,"InputText",_WVALUE,"",_WCOLOR,RED_,_WRESIZE,wbox(6,1,12,12,3))


  //sWo(_WOID,ipwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_,_Wpixmapoff,_Wdrawon,_Wfunc,"inputText")
  //sWo(_WOID,ipwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_,_Wpixmapoff,_Wdrawon,_Wfunc,"inputValue",_Wstyle,SVO_)

 sWo(_WOID,ipwo,_WCLIP,wbox(0.1,0.1,0.9,0.9),_WCLIPBHUE,YELLOW_)
 sWo(_WOID,ipwo,_WBORDER,BLACK,_WDRAW,ON_,_WCLIPBORDER,RED_,_WFONTHUE,BLACK_,_WDRAW,ON_,_WFUNC,"editValue")
 sWo(_WOID,ipwo,_Wfont,F_MEDIUM_)
//ans=query("--> italic font F_ITALIC_")
//sWo(_WOID,ipwo,_Wfont,F_ITALIC_)




// resize fractional 0, pixel offset 1, real scales 2, grid pos 3






 lvwo=cWo(txtwin,WO_TEXT_)
 sWo(_WOID,lvwo,_Wname,"PrintText",_WVALUE,"lvtext",_Wcolor,"orange",_Wresize,wbox(2,1,3,9,3))
 sWo(_WOID,lvwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_ ,_WDRAW,ON,_WSAVE,ON_)
 sWo(_WOID,lvwo,_WSCALES,wbox(0,0,1,1))
 sWo(_WOID,lvwo,_Wfont,"rotated")

 rvwo=cWo(txtwin,WO_TEXT_)
 sWo(_WOID,rvwo,_Wname,"PrintText",_WVALUE,"rvtext",_Wcolor,ORANGE_,_Wresize,4,1,5,9,3)
 sWo(_WOID,rvwo,_WBORDER,GREEN_,_WDRAW,ON_,_WCLIPBORDER,BLUE_,_WFONTHUE,BLACK_,_WDRAW,ON_,_WSAVE,ON_)
 sWo(_WOID,rvwo,_Wscales,wbox(0,0,1,1))
 sWo(_WOID,rvwo,_Wfont,"rotated90")





 ipwo2=cWo(txtwin,WO_TEXT)
 sWo(_WOID,ipwo2,_Wname,"InputText2",_WVALUE,"abc",_Wcolor,RED_,_Wresize,wbox(12.1,1,19,12,3))
  //sWo(_WOID,ipwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_,_Wpixmapoff,_Wdrawon,_Wfunc,"inputText")
  //sWo(_WOID,ipwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_,_Wpixmapoff,_Wdrawon,_Wfunc,"inputValue",_Wstyle,SVO_)

 sWo(_WOID,ipwo2,_Wclip,wbox(0.1,0.1,0.9,0.9),_Wclipbhue,MAGENTA_)
 sWo(_WOID,ipwo2,_WBORDER,GREEN_,_WDRAW,ON_, _WFONTHUE,BLACK_, _WDRAW,ON_,_Wfunc,"editValue")
 sWo(_WOID,ipwo2,_Wfont,F_ITALIC_)


  int txwos[] = {lvwo,rvwo,bigwo,two};
//  int txwos[] = {two, bigwo,ipwo};

 sWo(_WOID,txwos,_Wredraw);
 
 titleVers();
 
//////////////////////////////////////////////////

//ans=query("-->")


#include "gevent"



xp = 0.1
yp = 0.5

char txtip[512];


mnum = 0

str txt ="WXYZ";

int do_txt_stuff = 1;

while (1) {




   if (do_txt_stuff) {

//   msgw= split(_emsg)

//<<"%V$msgw \n"

<<" textr <|$_emsg|> \n"

    sWo(_WOID,two,_Wtextr,"$_emsg",0.1,0.8)

    sWo(_WOID,stwo,_Wprint,"$_emsg\n") ;
    
    sWo(_WOID,stwo,_Wprint,"%V$_ewoname $_ebutton\n");

<<"$_ewoid  $ipwo gotit ?\n"



//      sWo(_WOID,txwos,_Wclear);

     txt=woGetText(ipwo);
 <<" got $txt  \n";
      // rotated text??
      deftxt ="says me";

      //txt = woGetValue(ipwo)
      <<"ipwo_txt: $txt \n"


      sWo(_WOID,lvwo,_Wfont,"rot90",_Wtextr,"$deftxt",0.3,0.1,0,-90,RED_);
      sWo(_WOID,rvwo,_Wfont,"rot",_Wtextr,"$deftxt",0.5,0.9,0,90,BLUE_);

      sWo(_WOID,bigwo,_Wfont,F_BIG_,_Wtextr,"$deftxt",0.0,0.6,0,0,BLACK_);
      sWo(_WOID,bigwo,_Wfont,F_MEDIUM_,_Wtextr,"$txt",0.0,0.4,0,0,MAGENTA_);
      sWo(_WOID,bigwo,_Wfont,F_SMALL_,_Wtextr,"$txt",0.0,0.5,0,0,BLACK_);

      sWo(_WOID,lvwo,_Wfont,F_SMALL_,_Wprint,"$txt");            

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
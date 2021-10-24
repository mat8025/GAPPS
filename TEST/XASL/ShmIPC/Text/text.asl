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

  Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }



!!"xset fp+ /home/mark/gasp-CARBON/fonts "
<<"xset fp+ /home/mark/gasp-CARBON/fonts "

//ans=query("-->")



#include "debug.asl"
#include "hv.asl"
#include "tbqrd"


ignoreErrors()

  txtwin = cWi("title","MK_INFO")

 sWi(txtwin,@pixmapon,@drawon,@save,@bhue,"teal",@sticky,1)
 

   titleButtonsQRD(txtwin);

 // TITLE BUTTON QUIT
// tbqwo=cWo(txtwin,@TB,@name,"tb_q",@color,RED_,@VALUE,"QUIT",@func,"window_term",@resize,0.95,0,0.99,1)
// sWo(tbqwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,RED_@FONTHUE,RED_, @symbol,"triangle", \
// @symsize, 10, @redraw)

sWi(txtwin,@setgrid,20,20);  // setting a grid on parent window for position


 // using grid positions for Wo boxes
 
two=cWo(txtwin,"TEXT",@name,"TextR",@VALUE,"howdy",@color,ORANGE_,@resize,1,16,8,19,3)

// two=cWo(txtwin,"TEXT",@name,"TextR",@VALUE,"howdy",@color,ORANGE_,@resize,0.1,0.7,0.5,0.9)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff )
 sWo(two,@SCALES,0,0,1,1)
 sWo(two,@help," Mouse & Key Info ",@redraw);





 stwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"howdy this is the first line",@color,BLUE_,@resize,2,10,6,15,3)
 sWo(stwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_ ,@pixmapoff,@drawon,@save)
 sWo(stwo,@SCALES,0,0,1,1)
 sWo(stwo,@font,F_SMALL_)
 sWo(stwo,@help," Mouse & Key Info ",@redraw);

getMouseClick()



 bigwo=cWo(txtwin,@TEXT,@name,"BigText",@VALUE,"Big Font?",@color,"orange",@resize,9,13,18,19,3)
 sWo(bigwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_ ,@pixmapoff,@drawon,@save)
 sWo(bigwo,@bhue,WHITE_,@SCALES,0,0,1,1)
 sWo(bigwo,@font,F_BIG_)


 ipwo=cWo(txtwin,@TEXT,@name,"InputText",@VALUE,"",@color,RED_,@resize,6,1,12,12,3)
  //sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputText")
  //sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputValue",@style,SVO_)

 sWo(ipwo,@clipsize,0.1,0.1,0.9,0.9,@clipbhue,LILAC_)
 sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"editValue")
 sWo(ipwo,@font,"small")
//ans=query("--> italic font F_ITALIC_")
sWo(ipwo,@font,F_ITALIC_)




// resize fractional 0, pixel offset 1, real scales 2, grid pos 3






 lvwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"lvtext",@color,"orange",@resize,2,1,3,9,3)
 sWo(lvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_ ,@pixmapoff,@drawon,@save)
 sWo(lvwo,@SCALES,0,0,1,1)
 sWo(lvwo,@font,"rotated")

 rvwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"rvtext",@color,ORANGE_,@resize,4,1,5,9,3)
 sWo(rvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@save)
 sWo(rvwo,@SCALES,0,0,1,1)
 sWo(rvwo,@font,"rotated90")





 ipwo2=cWo(txtwin,@TEXT,@name,"InputText2",@VALUE,"abc",@color,RED_,@resize,12.1,1,19,12,3)
  //sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputText")
  //sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputValue",@style,SVO_)

 sWo(ipwo2,@clipsize,0.1,0.1,0.9,0.9,@clipbhue,MAGENTA_)
 sWo(ipwo2,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"editValue")
 sWo(ipwo2,@font,"italic")





  int txwos[] = {lvwo,rvwo,bigwo,two};
//  int txwos[] = {two, bigwo,ipwo};

 sWo(txwovs,@redraw);
 
 titleVers();
 
//////////////////////////////////////////////////

//ans=query("-->")


include "gevent"



xp = 0.1
yp = 0.5

char txtip[512];





mnum = 0

while (1) {

    eventWait()

   sWo(two,@redraw)

 if (_ekeyw == "EXIT_ON_WIN_INTRP") {
     <<"break exit on WIN_INTR\n"
     break;
   }




   msgw= split(_emsg)

<<"%V$msgw \n"

    sWo(two,@textr,"$_emsg",0.1,0.8)

    sWo(stwo,@print,"$_emsg\n") ;
    
    sWo(stwo,@print,"%V$_ewoname $_ebutton\n");

     if (_ewoid == ipwo) {

//      sWo(txwos,@clear);

      woGetText(ipwo,txtip,512);
       
  <<" got %s < $txtip >  \n as input \n";
      // rotated text??

      txt = woGetValue(ipwo)
      <<" $txt \n"
      //sWo(lvwo,@font,6,@textr,"$txt",0.3,0.1,0,-90,RED_);
      //sWo(rvwo,@font,"rotated90",@textr,"$txt",0.5,0.9,0,90,BLUE_);

      sWo(bigwo,@font,BIG_,@textr,"$txt",0.0,0.6,0,0,BLACK_);
      sWo(bigwo,@font,MEDIUM_,@textr,"$txt",0.0,0.4,0,0,MAGENTA_);
      sWo(bigwo,@font,SMALL_,@textr,"$txt",0.0,0.5,0,0,BLACK_);

      sWo(lvwo,@font,SMALL_,@print,"$txt");            

      mnum++;
      //sWo(ipwo,@value,"");
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
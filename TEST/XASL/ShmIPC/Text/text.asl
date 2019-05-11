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
/// xset fp+ /usr/local/GASP/gasp/fonts
/// check
/// xlsfonts | grep rot

/// TBD ?? use XSetFontPath --- in ms/mc_font setup??


envdebug()

  Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

include "debug.asl"
include "hv.asl"
include "tbqrd"

 txtwin = cWi("title","MK_INFO")

 sWi(txtwin,@pixmapon,@drawon,@save,@bhue,"teal",@sticky,1)
 sWo(txtwin,@grid,20,20);  // setting a grid on parent window for position

   titleButtonsQRD(txtwin);

 // TITLE BUTTON QUIT
// tbqwo=cWo(txtwin,@TB,@name,"tb_q",@color,RED_,@VALUE,"QUIT",@func,"window_term",@resize,0.95,0,0.99,1)
// sWo(tbqwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,RED_@FONTHUE,RED_, @symbol,"triangle", \
// @symsize, 10, @redraw)




 // using grid positions for Wo boxes
 
 two=cWo(txtwin,"TEXT",@name,"TextR",@VALUE,"howdy",@color,"orange",@resize,1,16,8,19,3)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black","pixmapoff")
 sWo(two,@SCALES,0,0,1,1)
 sWo(two,@help," Mouse & Key Info ")


 stwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"howdy this is the first line",@color,"orange",@resize,2,10,8,15,3)
 sWo(stwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(stwo,@SCALES,0,0,1,1)
 sWo(stwo,@font,"small")
 sWo(stwo,@help," Mouse & Key Info ");


 bigwo=cWo(txtwin,@TEXT,@name,"BigText",@VALUE,"Big Font?",@color,"orange",@resize,9,10,18,15,3)
 sWo(bigwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(bigwo,@bhue,WHITE_,@SCALES,0,0,1,1)
 sWo(bigwo,@font,"big")


 lvwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"lvtext",@color,"orange",@resize,2,1,3,9,3)
 sWo(lvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(lvwo,@SCALES,0,0,1,1)
 sWo(lvwo,@font,"rotated")

 rvwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"rvtext",@color,"orange",@resize,4,1,5,9,3)
 sWo(rvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(rvwo,@SCALES,0,0,1,1)
 sWo(rvwo,@font,"rotated90")
// resize fractional 0, pixel offset 1, real scales 2, grid pos 3

 ipwo=cWo(txtwin,@BV,@name,"InputText",@VALUE,"esta bien ",@color,WHITE_,@resize,9,1,18,5,3)
  //sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputText")
  sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputValue",@style,SVR_)
 sWo(ipwo,@font,"italic")

  int txwos[] = {lvwo,rvwo,bigwo,two};


 titleVers();
 


include "gevent"



xp = 0.1
yp = 0.5

char txtip[256];

!!"xset fp+ /home/mark/gasp-CARBON/fonts "
<<"xset fp+ /home/mark/gasp-CARBON/fonts "
mnum = 0
   while (1) {

    eventWait()

   sWo(two,@redraw)

   msgw= split(_emsg)

<<"%V$msgw \n"

    sWo(two,@textr,"$_emsg",0.1,0.8)

    sWo(stwo,@print,"$_emsg\n") ;
    
    sWo(stwo,@print,"%V$_ewoname $_ebutton\n");

     if (_ewoid == ipwo) {

      sWo(txwos,@clear);

   //   woGetText(ipwo,txtip,512);
       
  <<" got %s < $txtip >  as input \n";
      // rotated text??
      txt = woGetValue(ipwo)      
      sWo(lvwo,@font,6,@textr,"$txt",0.3,0.1,0,-90,RED_);
      sWo(rvwo,@font,"rotated90",@textr,"$txt",0.5,0.9,0,90,BLUE_);

      sWo(bigwo,@font,BIG_,@textr,"$txt",0.0,0.6,0,0,BLACK_);
      sWo(bigwo,@font,MEDIUM_,@textr,"$txt",0.0,0.4,0,0,MAGENTA_);
      sWo(bigwo,@font,SMALL_,@textr,"$txt",0.0,0.5,0,0,BLACK_);            
      mnum++;
      sWo(ipwo,@value,"");
    }

  }


////////////////////////////////
/// text starts space in?
///
/// italic, bold
///
///
///
///
///
///
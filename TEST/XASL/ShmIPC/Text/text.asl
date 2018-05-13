//////// text.asl ////////////////////


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


 stwo=cWo(txtwin,"TEXT",@name,"PrintText",@VALUE,"howdy this is the first line",@color,"orange",@resize,2,10,8,15,3)
 sWo(stwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(stwo,@SCALES,0,0,1,1)
 sWo(stwo,@font,3)
 sWo(stwo,@help," Mouse & Key Info ");


 bigwo=cWo(txtwin,"TEXT",@name,"BigText",@VALUE,"Big Font?",@color,"orange",@resize,9,10,18,15,3)
 sWo(bigwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(bigwo,@bhue,WHITE_,@SCALES,0,0,1,1)
 sWo(bigwo,@font,"big")


 lvwo=cWo(txtwin,"VTEXT",@name,"PrintText",@VALUE,"rvtext",@color,"orange",@resize,2,1,3,9,3)
 sWo(lvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(lvwo,@SCALES,0,0,1,1)


 rvwo=cWo(txtwin,"VTEXT",@name,"PrintText",@VALUE,"rvtext",@color,"orange",@resize,4,1,5,9,3)
 sWo(rvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(rvwo,@SCALES,0,0,1,1)

// resize fractional 0, pixel offset 1, real scales 2, grid pos 3

 ipwo=cWo(txtwin,"TEXT",@name,"InputText",@VALUE,"howdy input line ",@color,WHITE_,@resize,9,1,18,9,3)
 //sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputValue")
  sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputText")


  int txwos[] = {lvwo,rvwo,bigwo,two};





include "gevent"



xp = 0.1
yp = 0.5

char txtip[256];


<<"xset fp+ /usr/local/GASP/gasp/fonts \n"

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

     woGetText(ipwo,txtip,512);
      
  <<" got %s < $txtip >  as input \n";
      // rotated text??
      sWo(lvwo,@textr,"%s $txtip",0.3,0.1,0,-90,RED_);
      sWo(rvwo,@textr,"%s $txtip",0.5,0.9,0,90,BLUE_);

      sWo(bigwo,@font,"big",@textr,"%s$txtip",0.0,0.6,0,0,BLACK_);
      sWo(bigwo,@font,"medium",@textr,"%s$txtip",0.0,0.4,0,0,MAGENTA_);
      sWo(bigwo,@font,"small",@textr,"%s$txtip",0.0,0.5,0,0,BLACK_);            
      
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
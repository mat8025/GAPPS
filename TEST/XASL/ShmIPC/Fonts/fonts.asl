/* 
 *  @script fonts.asl 
 * 
 *  @comment  test fonts and placement
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.56 C-Li-Ba]                               
 *  @date 10/24/2021 11:34:32 
 *  @cdate 10/24/2021 11:34:32 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//----------------------//;


<|Use_= 
Demo    test fonts and placement
/////////////////////// 
|>

#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)
///
////

ignoreErrors()



envdebug()

  Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


include "hv.asl"
include "tbqrd"

 txtwin = cWi("title","MK_INFO")

 sWi(txtwin,@pixmapon,@drawon,@save,@bhue,"teal",@sticky,1)
 sWo(txtwin,@grid,20,20,@redraw);  // setting a grid on parent window for position

   titleButtonsQRD(txtwin);

   A=ofr("sel-fonts")
   SF=readFile(A,1)


 stwo=cWo(txtwin,@TEXT,@name,"PrintText",@VALUE,"howdy this is the first line",@color,BLACK_,@resize,2,2,18,15,3)

sWo(stwo,@border,@drawon,@clipborder,@fonthue,BLACK_ ,@pixmapoff,@drawon,@save)

  sWo(stwo,@print," abcdefghijklmnopqrstuvwxzy \n ABCDEFGHIJKLMNOPQRSTUVXYZ\n") ;

//ans=iread("->")

<<" $SF[1] \n"

<<" $SF[2] \n"

<<" $SF[4] \n"

   wf= loadFont("lucidasans-18");

<<"lucidasans-18 $wf \n"

   wf2= loadFont("lucidasans-24");

<<"lucidasans-24    $wf2 \n"

  // wf3=loadFont("-adobe-helvetica-bold-o-normal--25-180-100-100-p-138-iso8859-1");
//wf3 = loadFont("-adobe-helvetica-medium-r-normal--11-80-100-100-p-56-iso8859-1");


wf3 = loadFont("-misc-fixed-bold-r-normal--13-120-75-75-c-70-iso8859-8")
<<"%v$wf3 \n"
//wf4=loadFont("-adobe-times-bold-r-normal--20-140-100-100-p-100-iso8859-1");

wf4=loadFont("$SF[2]");
<<"%v$wf4 \n"



//sWo(stwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_ ,@pixmapon,@drawoff,@save)
//sWo(stwo,@border,@drawon,@clipborder,@fonthue,BLACK_ ,@pixmapon,@drawoff,@save)

use_pixmap = 0;

if (use_pixmap) {
  sWo(stwo,@border,@drawon,@clipborder,@fonthue,BLACK_ ,@pixmapon,@drawoff,@save,@savepixmap)
}
else {
   sWo(stwo,@border,@drawon,@clipborder,@fonthue,BLACK_ ,@pixmapoff,@drawon,@save)
}

 sWo(stwo,@SCALES,0,0,1,1)

//sWo(stwo,@font,wf4)

// sWo(stwo,@font,wf3)


 sWo(stwo,@help," Mouse & Key Info ");



  sWo(stwo,@print," abcdefghijklmnopqrstuvwxzy \n ABCDEFGHIJKLMNOPQRSTUVXYZ\n") ;

  sWo(stwo,@print,"0123456789\n") ;

  sWo(stwo,@print,"!@#\$%^&\n") ;

//ans=iread("->")
  sWo(stwo,@redraw);


#include "gevent"

mnum = 0
int kf = 1;


while (1) {

    eventWait()



   msgw= split(_emsg)

 if (_ekeyw == "EXIT_ON_WIN_INTRP") {
     <<"break exit on WIN_INTR\n"
     break;
   }


<<"%V$msgw \n"
<<"$kf  $SF[kf]\n" 
  wf4=loadFont("$SF[kf]");

 <<"%v$wf4 \n"
    if (wf4 != 0) {
  if (use_pixmap) {    
        sWo(stwo,@clearpixmap) ;
  }
        sWo(stwo,@clearclip) ;
    sWo(stwo,@font,wf4,@fonthue,RED_);
    sWo(stwo,@font,wf4,@textr,"$SF[kf]",0.2,0.9,0,0,BLUE_);

    sWo(stwo,@print,"$kf $wf4 $SF[kf] \n\n") ;
    //sWo(stwo,@font,wf2,@fonthue,BLACK_);
    sWo(stwo,@print," abcdefghijklmnopqrstuvwxyz \n") ;
    sWo(stwo,@font,wf4,@textr,"abcdef",0.0,0.6,0,0,BLACK_);
// sWo(stwo,@showpixmap) ;
    
    sWo(stwo,@textr," ABCDEFGHIJKLMNOPQRSTUVWXYZ",0.1,0.3) ;
    sWo(stwo,@print," 0123456789 \n") ;
if (use_pixmap) {
  sWo(stwo,@showpixmap) ;
}
}


    kf++;

}

chkT(1)
chkOut()

exit()


//%*********************************************** 
//*  @script symbol.asl 
//* 
//*  @comment test sybols 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Fri Feb 22 15:29:50 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"
include "gevent.asl"
include "hv.asl"
include "tbqrd";
debugON()


    vp = cWi(@title,"SYMBOL",@resize,0.01,0.01,0.5,0.5,0)

    sWi(vp,@pixmapon,@drawon,@bhue,WHITE_)

   titleButtonsQRD(vp);
   titleVers();



    msgwo=cWo(vp,"TEXT",@name,"COOR",@VALUE,"0.0 0.0",@color,WHITE_,@resize,0.35,0.81,0.9,0.99)

    sWo(msgwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_, @pixmapoff,@drawon,@redraw,@save)

    rwo=cWo(vp,@symbol,@resize,0.1,0.1,0.3,0.3,@NAME,RED_,@VALUE,1.0)

    sWo(rwo,@color,"red",@penhue,"black",@symbol,"diamond")

    sWo(rwo,@drawoff,@pixmapon,@redraw,@save)


    gwo=cWo(vp,@symbol,@resize,0.5,0.1,0.9,0.6,@NAME,GREEN_,@VALUE,1.0)

    sWo(gwo,@color,GREEN_,@penhue,"black",@symbol,"diamond")

    sWo(gwo,@drawon,@pixmapon,@redraw,@save)




sym_size = 7

// message info
symbol_name = "diamond"
int ang = 0
int symbol_num = 0
uint n_msg = 0

while (1) {

      eventWait();
     
      n_msg++
<<"%V$n_msg $_emsg  $_etype $_button\n"

     if (_etype  == PRESS_) {

     sWo(msgwo,@clear,@clipborder,BLUE_,@textr,_emsg,0.0,0.7)
    
     if (symbol_num > 20) {
         symbol_num = 0
     }

     if (symbol_num < 0) {
         symbol_num = 1
     }

     if (_ebutton == 3) {
        ang += 10
        if (ang > 360) {
            ang = 0
        }
     }
     else if (_ebutton == 2) {
       symbol_num--
       symbol_name = "diamond"
     }
     else if (_ebutton == 4) {
       sym_size--
     }
     else if (_ebutton == 5) {
       sym_size++
     }
     else if (_ebutton == 1) {
       symbol_num++
       if (sym_size > 99) {
           sym_size = 3
       }

       symbol_name = getSymbolName(symbol_num);

     }

     sWo(rwo,@drawoff,@clearpixmap)
     sWo(rwo,@color,"red",@penhue,BLUE_,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
    // sWo(rwo,@showpixmap)

     sWo(gwo,@drawon,@clearpixmap)
     sWo(gwo,@color,"red",@penhue,GREEN_,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
    // sWo(gwo,@showpixmap)

     sWo(msgwo,@textr,"%V$symbol_num $symbol_name $ang",0.0,0.1)


     }
}
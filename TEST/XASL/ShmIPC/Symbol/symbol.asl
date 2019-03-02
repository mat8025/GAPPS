//%*********************************************** 
//*  @script symbol.asl 
//* 
//*  @comment show symbols
//*  @release CARBON 
//*  @vers 1.14 Si Silicon                                                
//*  @date Wed Feb  6 14:53:24 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug.asl"
include "hv.asl"
include "tbqrd";
include "gevent.asl"
debugON()

Graphic = CheckGwm();

  if (!Graphic) {
    Xgm = spawnGwm()
  }


   vp = cWi(@title,"SYMBOL",@resize,0.05,0.2,0.9,0.9,0);

   sWi(vp,@pixmapon,@drawon,@bhue,WHITE_);

   titleButtonsQRD(vp);
   titleVers();
   
    msgwo=cWo(vp,@text,@name,"COOR",@VALUE,"0.0 0.0",@color,WHITE_,@resize,0.35,0.81,0.9,0.99)

    sWo(msgwo,@border,@drawon,@clipborder,@fonthue,RED_, @pixmapoff,@drawon,@redraw,@save)

    rwo=cWo(vp,@symbol,@resize,0.1,0.1,0.4,0.4,@name,"RED",@value,1.0,@clip,0.01,0.01,0.99,0.99)

    sWo(rwo,@color,"red",@penhue,"black",@symbol,"diamond")

    sWo(rwo,@drawoff,@pixmapon,@redraw,@save)


    gwo=cWo(vp,@symbol, @resize,0.5,0.1,0.9,0.6,@name,"green",@value,1.0)

 //sWo(gwo,@color,GREEN_,@penhue,"black",@symbol,"diamond")
    sWo(gwo,@color,GREEN_,@penhue,BLACK_,@symbol,"diamond")

    sWo(gwo,@drawon,@pixmapon,@redraw,@save)





sym_size = 7;

// message info
symbol_name = "diamond"
int ang = 0
int symbol_num = 0;
uint n_msg = 0;


     while (1) {

      eventWait();
      n_msg++

<<"%V$_ewoname  $_ekeyw $_etype\n";


   if (_etype  == PRESS_) {


       sWo(msgwo,@clear,@clipborder,BLUE_,@textr,_emsg,0.0,0.7)

         
     if (symbol_num > 20) {
         symbol_num = 0
     }
   
     if (symbol_num < 0) {
         symbol_num = 0;
     }

     if (_ebutton == 3) {
        ang += 10;
        if (ang > 360) {
            ang = 0;
        }
     }
     else if (_ebutton == 2) {
       symbol_num--
       //symbol_name = "diamond"
     }
     else if (_ebutton == 4) {
       sym_size-- ;
     }
     else if (_ebutton == 5) {
       sym_size++ ;
     }
     else if (_ebutton == 1) {
       symbol_num++;
       if (sym_size > 99) {
           sym_size = 1;
       }

       symbol_name = getSymbolName(symbol_num);
<<"%V$symbol_name\n";
     if (symbol_num > 20) {
         symbol_num = 1;
     }



     }
     

     sWo(rwo,@drawoff,@clearpixmap)
     sWo(rwo,@color,"yellow",@penhue,"black",@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
     sWo(rwo,@showpixmap)

     sWo(gwo,@drawon,@clear)
     sWo(gwo,@color,"magenta",@penhue,"brown",@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
     //sWo(gwo,@showpixmap)

     sWo(msgwo,@textr,"%V$symbol_num $symbol_name $ang  $sym_size",0.0,0.1)

     }
}
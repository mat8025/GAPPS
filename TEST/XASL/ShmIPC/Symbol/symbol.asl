///
/// test symbol
///

Graphic = CheckGwm();

  if (!Graphic) {
    Xgm = spawnGwm()
  }

setdebug(1,@keep,@filter,0);

  vp = cWi(@title,"SYMBOL",@resize,0.05,0.2,0.9,0.9,0);


 //////////////// TITLE BUTTON QUIT
 tbqwo=cWo(vp,@TB,@name,"tb_q",@color,RED_,@VALUE,"QUIT",@func,"xwindow_term",@resize,0.95,0,0.97,1)
 sWo(tbqwo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,11,  @symsize, 3,\
 @clip,0,0,1,1,@redraw)

 tb2wo=cWo(vp,@TB,@name,"tb_2",@color,WHITE_,@VALUE,"QUIT",@func,"window_resize",@resize,0.92,0,0.94,1)
 sWo(tb2wo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,PLUS_,  @symsize, 2, \
 @clip,0,0,1,1,@redraw)w

 tb3wo=cWo(vp,@TB,@name,"tb_3",@color,GREEN_,@VALUE,"QUIT",@func,"window_move",@resize,0.89,0,0.91,1)
 sWo(tb3wo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,12,  @symsize, 2,\
 @clip,0,0,1,1,@redraw)

    sWi(vp,@pixmapon,@drawon,@bhue,WHITE_);

    msgwo=cWo(vp,@TEXT,@name,"COOR",@VALUE,"0.0 0.0",@color,WHITE_,@resize,0.35,0.81,0.9,0.99)

    sWo(msgwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_, @pixmapoff,@drawon,@redraw,@save)

    rwo=cWo(vp,@SYMBOL,@resize,0.1,0.1,0.4,0.4,@NAME,"RED",@VALUE,1.0,@clip,0.01,0.01,0.99,0.99)

    sWo(rwo,@color,"red",@penhue,"black",@symbol,"diamond")

    sWo(rwo,@drawoff,@pixmapon,@redraw,@save)


    gwo=cWo(vp,@SYMBOL,@resize,0.5,0.1,0.9,0.6,@NAME,"GREEN",@VALUE,1.0)

    sWo(gwo,@color,GREEN_,@penhue,BLACK_,@symbol,"diamond")

    sWo(gwo,@drawon,@pixmapon,@redraw,@save)


include "gevent"

sym_size = 45;

// message info
symbol_name = "diamond"
int ang = 0
int symbol_num = 5;
uint n_msg = 0;


     while (1) {

      eventWait();
      n_msg++

<<"%V$_ewoname $_ekeyw $_etype\n";

      if (scmp(_ename,"PRESS",5)) {

       sWo(msgwo,@clear,@clipborder,BLUE_,@textr,_emsg,0.0,0.7)

         
   
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
     
      sWo(tbqwo, @symbol,symbol_num,  @symsize, sym_size, @symang,ang,@redraw);
      sWo(tb2wo, @symbol,symbol_num+1,  @symsize, sym_size, @redraw);
      sWo(tb3wo, @symbol,symbol_num-1,  @symsize, sym_size, @symang,ang,@redraw);      



     sWo(rwo,@drawoff,@clearpixmap)
     sWo(rwo,@color,RED_,@penhue,BLUE_,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
   //  sWo(rwo,@showpixmap)

     sWo(gwo,@drawoff,@clearpixmap)
     sWo(gwo,@color,RED_,@penhue,GREEN_,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
   //  sWo(gwo,@showpixmap)

     sWo(msgwo,@textr,"%V$symbol_num $symbol_name $ang  $sym_size",0.0,0.1)

     }
}
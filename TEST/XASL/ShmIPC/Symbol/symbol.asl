// test symbol

Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

setdebug(1);

    vp = cWi(@title,"SYMBOL",@resize,0.01,0.01,0.5,0.5,0)

    sWi(vp,@pixmapon,@drawon,@bhue,WHITE_);

    msgwo=cWo(vp,@TEXT,@name,"COOR",@VALUE,"0.0 0.0",@color,WHITE_,@resize,0.35,0.81,0.9,0.99)

    sWo(msgwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_, @pixmapoff,@drawon,@redraw,@save)

    rwo=cWo(vp,@SYMBOL,@resize,0.1,0.1,0.3,0.3,@NAME,"RED",@VALUE,1.0)

    sWo(rwo,@color,"red",@penhue,"black",@symbol,"diamond")

    sWo(rwo,@drawoff,@pixmapon,@redraw,@save)


    gwo=cWo(vp,@SYMBOL,@resize,0.5,0.1,0.9,0.6,@NAME,"GREEN",@VALUE,1.0)

    sWo(gwo,@color,GREEN_,@penhue,BLACK_,@symbol,"diamond")

    sWo(gwo,@drawoff,@pixmapon,@redraw,@save)


include "gevent"

sym_size = 7;

// message info
symbol_name = "diamond"
int ang = 0
int symbol_num = 0
uint n_msg = 0;


     while (1) {

      eventWait();
      n_msg++

<<"%V$ev_woname $ev_keyw $ev_type\n";

      if (scmp(ev_type,"PRESS",5)) {

       sWo(msgwo,@clear,@clipborder,BLUE_,@textr,ev_msg,0.0,0.7)

         
     if (symbol_num > 20) {
         symbol_num = 0;
     }

     if (symbol_num < 0) {
         symbol_num = 1;
     }

     if (ev_button == 3) {
        ang += 10;
        if (ang > 360) {
            ang = 0;
        }
     }
     else if (ev_button == 2) {
       symbol_num--
       symbol_name = "diamond"
     }
     else if (ev_button == 4) {
       sym_size-- ;
     }
     else if (ev_button == 5) {
       sym_size++ ;
     }
     else if (ev_button == 1) {
       symbol_num++
       if (sym_size > 99) {
           sym_size = 3;
       }

       symbol_name = getSymbolName(symbol_num);
<<"%V$symbol_name\n";

     }

     sWo(rwo,@drawoff,@clearpixmap)
     sWo(rwo,@color,RED_,@penhue,BLUE_,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
   //  sWo(rwo,@showpixmap)

     sWo(gwo,@drawoff,@clearpixmap)
     sWo(gwo,@color,RED_,@penhue,GREEN_,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
   //  sWo(gwo,@showpixmap)

     sWo(msgwo,@textr,"%V$symbol_num $symbol_name $ang",0.0,0.1)

     }
}
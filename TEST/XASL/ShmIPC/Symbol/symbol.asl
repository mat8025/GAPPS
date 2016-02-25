// test symbol

Graphic = CheckGwm()

  if (!Graphic) {
    Xgm = spawnGwm()
  }

    vp = cWi(@title,"SYMBOL",@resize,0.01,0.01,0.5,0.5,0)

    sWi(vp,@pixmapon",@drawon,@bhue,"white")

    msgwo=cWo(vp,"TEXT",@name,"COOR",@VALUE,"0.0 0.0",@color,WHITE,@resize,0.35,0.81,0.9,0.99)

    sWo(msgwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED, @pixmapoff,@drawon,@redraw,@save)

    rwo=cWo(vp,SYMBOL,@resize,0.1,0.1,0.3,0.3,@NAME,"Red",@VALUE,1.0)

    sWo(rwo,@color,"red",@penhue,"black",@symbol,"diamond")

    sWo(rwo,@drawoff,@pixmapon,@redraw,@save)


    gwo=cWo(vp,SYMBOL,@resize,0.5,0.1,0.9,0.6,@NAME,"Green",@VALUE,1.0)

    sWo(gwo,@color,GREEN,@penhue,"black",@symbol,"diamond")

    sWo(gwo,@drawoff,@pixmapon,@redraw,@save)


include "event"

Event E

sym_size = 7

// message info
symbol_name = "diamond"
int ang = 0
int symbol_num = 0
uint n_msg = 0
     while (1) {

     E->waitForMsg()
      n_msg++
<<"%V$n_msg\n"
     if (scmp(E->woname,"PRESS",5)) {

     setgwob(msgwo,@clear,@clipborder,"blue",@textr,E->emsg,0.0,0.7)

     setgwob(msgwo,@textr,"$E->minfo ",0.0,0.5)
     setgwob(msgwo,@textr,"$E->rinfo ",0.0,0.3)
    
     if (symbol_num > 20) {
         symbol_num = 0
     }

     if (symbol_num < 0) {
         symbol_num = 1
     }

     if (E->button == 3) {
        ang += 10
        if (ang > 360) {
            ang = 0
        }
     }
     else if (E->button == 2) {
       symbol_num--
       symbol_name = "diamond"
     }
     else if (E->button == 4) {
       sym_size--
     }
     else if (E->button == 5) {
       sym_size++
     }
     else if (E->button == 1) {
       symbol_num++
       if (sym_size > 99) {
           sym_size = 3
       }

       symbol_name = getSymbolName(symbol_num);

     }

     sWo(rwo,@drawoff,@clearpixmap)
     sWo(rwo,@color,"red",@penhue,BLUE,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
     sWo(rwo,@showpixmap)

     sWo(gwo,@drawoff,@clearpixmap)
     sWo(gwo,@color,"red",@penhue,GREEN,@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
     sWo(gwo,@showpixmap)

     sWo(msgwo,@textr,"%V$symbol_num $symbol_name $ang",0.0,0.1)


     }
}
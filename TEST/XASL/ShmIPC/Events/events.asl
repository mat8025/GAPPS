///
///
///

#define RELEASE 4
setdebug(1);

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

//ans=iread("wait for comms\n");

vp = cWi(@title,"Events")


    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@clip,0.1,0.2,0.9,0.9,@redraw)

/////////////// TITLE BUTTON QUIT
 tbqwo=cWo(vp,@TB,@name,"tb_q",@color,RED_,@VALUE,"QUIT",@func,"window_term",@resize,0.95,0,0.97,1)
 sWo(tbqwo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,11,  @symsize, 3,\
 @clip,0,0,1,1,@redraw)

 tb2wo=cWo(vp,@TB,@name,"tb_2",@color,WHITE_,@VALUE,"QUIT",@func,"window_resize",@resize,0.92,0,0.94,1)
 sWo(tb2wo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,PLUS_,  @symsize, 2, \
 @clip,0,0,1,1,@redraw)w

 tb3wo=cWo(vp,@TB,@name,"tb_3",@color,GREEN_,@VALUE,"MOVE",@func,"window_move",@resize,0.89,0,0.91,1)
 sWo(tb3wo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,12,  @symsize, 2,\
 @clip,0,0,1,1,@redraw)

 bx = 0.1
 bX = 0.4
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht
 
 bwo=cWo(vp,@ONOFF,@name,"CLICK_ONOFF",@color,GREEN_,@resize,bx,by,bX,bY)
  sWo(bwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@VALUE,"OFF",@STYLE,"SVB")
  sWo(bwo,@bhue,RED_,@clipbhue,BLACK_,@fhue,"teal")

 bx = bX + 0.1
 bX = 0.9;
 gwo=cWo(vp,@GRAPH,@name,"SKETCH",@color,BLUE_,@resize,bx,by,bX,bY)
  sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@VALUE,"OFF")
  sWo(gwo,@bhue,RED_,@clipbhue,BLACK_,@fhue,"teal")
  Swo(gwo,@scales,-2,-2,2,2);

 two=cWo(vp,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.1,0.8,0.5)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@redraw)
 sWo(two,@SCALES,-1,-1,1,1)
 sWo(two,@help," Mouse & Key Info ")

// event loop

include "gevent"

 while (1 ) {

    eventWait()   

   <<"%V  $_eloop  $_eid $_ename $_etype $_ewoid $_erx $_ery\n"
   <<"%V  $Cev->id   $Cev->button \n"


   if (!(_emsg @= "NO_MSG")) {
   
   sWo(two,@clear,@textr," $_emsg ",0.1,0.2)
  }

 if (ev_type @= "KEYPRESS") {
   <<"%V  $_ekeyw %c $_ekeyc\n"
      sWo(two,@textr,"%V$_ekeyw %c $_ekeyc \n",0.1,0.4)
   }



  if ( (_etype == PRESS_) ||  (_etype == RELEASE_ )) {

   sWo(two,@textr,"%V$_eloop  $_emsg $_etype \n",0.1,0.3)

<<"%V $_ebutton $_ewoproc $_ewoaw  $_ewoval  $_erx $_ery\n"

   sWo(two,@textr,"%V$_ewoid $_ebutton $_erx $_ery \n",0.1,0.4)

   }
   
   
  // sWo(gwo,@redraw)
   
    
}

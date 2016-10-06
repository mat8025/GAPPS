
Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }



vp = cWi(@title,"Events")


    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@clip,0.1,0.2,0.9,0.9,@redraw)
    
 bx = 0.1
 bX = 0.4
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht
 
 gwo=cWo(vp,@ONOFF,@name,"CLICK_ONOFF",@color,GREEN_,@resize,bx,by,bX,bY)
 
 sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@VALUE,"OFF",@STYLE,"SVB")
 
 sWo(gwo,@bhue,RED_,@clipbhue,BLACK_,@fhue,"teal")

 two=cWo(vp,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.1,0.8,0.5)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@redraw)
 sWo(two,@SCALES,-1,-1,1,1)
 sWo(two,@help," Mouse & Key Info ")

// event loop

int Ev ; // handle
Ebutton = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Etype = ""
int Woaw = 0
char Ekeyc = 0;
Ekeyw = ""
Erx =0.0;
Ery = 0.0;



int kloop =0

 while ( ++kloop ) {

  // msg = Ev->waitForMsg()
   msg = Ev->readMsg();
   

   if (!(msg @= "NO_MSG")) {
   
   sWo(two,@clear,@textr," $msg ",0.1,0.2)

   Etype = Ev->getEventType()
   




 if (Etype @= "KEYPRESS") {
    Ekeyc = Ev->getEventKey()
    Ekeyw = Ev->getEventKeyW()
   <<"%V  $Ekeyw %cEkeyc\n"
      sWo(two,@textr,"%V$Ekeyw %cEkeyc \n",0.1,0.4)
   }

  if (Etype @= "PRESS") {

   Woname = Ev->getEventWoName()    

<<"%V$kloop  $msg $Etype \n"
   sWo(two,@textr,"%V$kloop  $msg $Etype \n",0.1,0.3)
   Woid = Ev->getEventWoId()

<<"%V$Woid \n"

   Woproc = Ev->getEventWoProc()

<<"%V$Woproc \n"

   Woaw =  Ev->getEventWoAw()

<<"%V$Woaw \n"

   Woval = getWoValue(Woid)

<<"%V$Woval \n"

   Ebutton = Ev->getEventButton()
<<"%V $Ebutton \n"
   Ev->geteventRxy(Erx,Ery)

   <<"%V $Erx $Ery \n"

   sWo(two,@textr,"%V$Woid $Ebutton $Erx $Ery \n",0.1,0.4)

   }
   
   sleep(1)
   sWo(gwo,@redraw)
   
  }
  
}

//////// text.asl ////////////////////

setdebug(0)

  Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


 txtwin = cWi("title","MK_INFO")

 sWi(txtwin,@pixmapon,@drawon,@save,@bhue,"teal",@sticky,1)
 sWo(txtwin,@grid,20,20);


 // using grid positions for Wo boxes
 
 two=cWo(txtwin,"TEXT",@name,"TextR",@VALUE,"howdy",@color,"orange",@resize,1,16,8,19,3)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black","pixmapoff")
 sWo(two,@SCALES,0,0,1,1)
 sWo(two,@help," Mouse & Key Info ")


 stwo=cWo(txtwin,"TEXT",@name,"PrintText",@VALUE,"howdy this is the first line",@color,"orange",@resize,2,10,8,15,3)
 sWo(stwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(stwo,@SCALES,0,0,1,1)
 sWo(stwo,@font,2)
 sWo(stwo,@help," Mouse & Key Info ");


 bigwo=cWo(txtwin,"TEXT",@name,"BigText",@VALUE,"Big Font?",@color,"orange",@resize,9,10,18,15,3)
 sWo(bigwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(bigwo,@SCALES,0,0,1,1)
 sWo(bigwo,@font,"big")


 lvwo=cWo(txtwin,"VTEXT",@name,"PrintText",@VALUE,"rvtext",@color,"orange",@resize,2,1,3,9,3)
 sWo(lvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(lvwo,@SCALES,0,0,1,1)


 rvwo=cWo(txtwin,"VTEXT",@name,"PrintText",@VALUE,"rvtext",@color,"orange",@resize,4,1,5,9,3)
 sWo(rvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 sWo(rvwo,@SCALES,0,0,1,1)


 ipwo=cWo(txtwin,"TEXT",@name,"InputText",@VALUE,"howdy input line ",@color,WHITE_,@resize,9,1,18,4,3)
 sWo(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@pixmapoff,@drawon,@func,"inputValue")


  int txwos[] = {lvwo,rvwo,bigwo,two};

Svar msg

E =1 // event handle

int evs[16];
button = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0


xp = 0.1
yp = 0.5

char txtip[256];

   while (1) {

   msg = E->waitForMsg()

//<<"msg $msg \n"


   E->geteventstate(evs)

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   button = E->getEventButton()

<<"%V$Woid \n"

   sWo(two,@redraw)

   msgw= split(msg)


<<"%V$msgw \n"

    sWo(two,@textr,"$msg",0.1,0.8)

    sWo(stwo,@print,"$msg\n") ;
    
    sWo(stwo,@print,"%V$Woname $button\n");

    

     if (Woid == ipwo) {
      sWo(txwos,@clear);
      getWoText(ipwo,txtip,120);
  <<" got %s < $txtip >  as input \n";
      sWo(lvwo,@textr,"%s $txtip",0.3,0.1,0,-90,RED_);
      sWo(rvwo,@textr,"%s $txtip",0.5,0.9,0,90,BLUE_);
      sWo(bigwo,@font,"big",@textr,"%s$txtip",0.0,0.1,0,0,LILAC_);
      sWo(bigwo,@font,"medium",@textr,"%s$txtip",0.0,0.4,0,0,MAGENTA_);
      sWo(bigwo,@font,"small",@textr,"%s$txtip",0.0,0.5,0,0,WHITE_);            
      

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
//////// text.asl ////////////////////

setdebug(0)

  Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


 txtwin = CreateGwindow("title","MK_INFO")

 SetGwindow(txtwin,@pixmapon,@drawon,@save,@bhue,"teal",@sticky,1)
 setgwob(txtwin,@grid,10,20)
 two=createGWOB(txtwin,"TEXT",@name,"TextR",@VALUE,"howdy",@color,"orange",@resize,1,5,8,9,3)
 setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black","pixmapoff")
 setgwob(two,@SCALES,0,0,1,1)
 setgwob(two,@help," Mouse & Key Info ")

 stwo=createGWOB(txtwin,"TEXT",@name,"PrintText",@VALUE,"howdy this is the first line",@color,"orange",@resize,1,1,8,4,3)
 setgwob(stwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@drawon,@save)
 setgwob(stwo,@SCALES,0,0,1,1)
 setgwob(stwo,@font,2)

 setgwob(stwo,@help," Mouse & Key Info ")



 ipwo=createGWOB(txtwin,"TEXT",@name,"InputText",@VALUE,"howdy this is the first line",@color,WHITE,@resize,9,1,18,4,3)
 setgwob(ipwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@pixmapoff,@drawon,@func,"inputValue")




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

   setgwob(two,@redraw)

   msgw= split(msg)


<<"%V$msgw \n"

    setgwob(two,@textr,"$msg",0.1,0.8)

    setgwob(stwo,@print,"$msg\n") 
    setgwob(stwo,@print,"%V$Woname $button\n") 





  }

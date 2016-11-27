////////////////////////////

setdebug(1,"pline")

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

    txtwin = CWi("title","Info_text_window")

    sWi(txtwin,@pixmapoff,@drawon,@save,@bhue,"white",@sticky,0)

    vp = CWi(@title,"Buttons1")

<<"%V$vp \n"

    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@clip,0.1,0.2,0.9,0.9)


    int fswins[] =  {txtwin,vp};


       wrctile( fswins, 0.05,0.5,0.95,0.95, 1, 2,-1,2) // tile windows in 2,2 matrix on  current screen 

       sWi(fswins, @redraw @save)


//////// Wob //////////////////

 bx = 0.1
 bX = 0.4
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 two=cWo(txtwin,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.1,0.9,0.9)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@redraw)
 sWo(two,@SCALES,-1,-1,1,1)
 sWo(two,@help," Mouse & Key Info ")


 bY = by - ypad
 by = bY - yht


 gvwo=cWo(vp,"BV",@name,"GMYVAL",@VALUE,0,@color,"green",@resize,0.5,by,0.9,bY)
 sWo(gvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVB")
 sWo(gvwo,@bhue,"teal",@clipbhue,"magenta",@FUNC,"inputValue")

<<"%V$two  $gvwo $lwo\n"

 bY = by - ypad
 by = bY - yht


 bY = 0.95
 by = bY - yht


 bY = by - ypad
 by = bY - yht


 qwo=cWo(vp,"BN",@name,"QUIT",@VALUE,"QUIT",@color,"orange",@resize_fr,bx,by,bX,bY)
 sWo(qwo,@help," click to quit")
 sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

<<"%V$qwo \n"


 sWi(txtwin,"woredrawall")

// omy = sWi( {vp,txtwin} ,@woredrawall)
 omy = sWi( fswins ,@woredrawall)

 

//  now loop wait for message  and print


   xp = 0.1
   yp = 0.5

//---------------------------------------------------------------------
proc processKeys()
{
       switch (keyc) {

       case 'R':
       {
       sWo(symwo,@move,0,2,@redraw)
       sWo(two,@textr,"R RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'T':
       {
       sWo(symwo,@move,0,-2,@redraw)
       sWo(two,@textr,"T RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'Q':
       {
       sWo(symwo,@move,-2,0,@redraw)
       sWo(two,@textr,"Q RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'S':
       {
       sWo(symwo,@move,2,0,@redraw)
       sWo(two,@textr,"S RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'h':
       {
       sWo(symwo,@hide)
       setgwindow(vp2,@redraw)
       }
       break;

       case 's':
       {
       sWo(symwo,@show)
       setgwindow(vp2,@redraw)
       }
       break;

      }
}
//---------------------------------------------------------------------

proc checkEvents()
{
//   Mf = Split(msg)
   <<"msg $msg \n"
  // E->getEventState(evs)

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
<<"%V$Woid \n"
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()

   Woval = getWoValue(Woid)
<<"%V$Woval \n"
   button = E->getEventButton()
   keyc = E->getEventKey()
   keyw = E->getEventKeyW()

//<<"%V$Woid $qwo \n"
  

   if (Woid == qwo) {
    //   deleteWin(vp)
    //   exit_gs()
   }
}
//----------------------------------------------


proc QUIT()
{
  wid = getAslWid()

<<"ASL wid is $wid \n"

//  sWi(vp,@detach) // will detach from asl and thus window will persist

//  wdelete(wid)

//  sleep(10)
  //wdelete(vp,vp2,vp3)

  exitsi()

}

 //sWi(vp,@detach)
// exitsi()


Svar msg

E =1 // event handle

int evs[20];

button = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0
keyc = ""
keyw = ""

int kloop =0


//ans = iread(":>")

   while (1) {

     msg = E->waitForMsg()

 <<"%V$kloop  $msg \n"

     checkEvents()
 
     // Woname = E->getEventWoName()    

     //E->getEventState(evs)

     sWo(two,@texthue,"black",@clear,@textr,"$msg $Woval",-0.9,0)

      if (Evtype @= "PRESS") {

        if (!(Woname @= "")) {
            DBPR"calling function via woname $woname !\n"
            $Woname()
            continue
        }

       }

  }

 exit_gs()

;

////////////////////   TBD -- FIX //////////////////////

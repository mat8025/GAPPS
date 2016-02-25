//////// button.asl ////////////////////

setdebug(1)

Graphic = checkGWM()

// Socket handshake

     rmsg = readgwmsock();
     <<"got $rmsg \n"

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

// sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"ON",@STYLE,"SVB",@FUNC,"ringBell")

 gwo=cWo(vp,"BV",@name,"B_V",@color,"green",@resize,bx,by,bX,bY)
 sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"ON",@STYLE,"SVB")
 sWo(gwo,@bhue,"red",@clipbhue,"skyblue")

 bY = by - ypad
 by = bY - yht
 

 hwo=cWo(vp,@ONOFF,@name,"ENGINE",@VALUE,"OFF",@color,"green",@resize,bx,by,bX,bY)

 sWo(hwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVR")
 sWo(hwo,@bhue,"teal",@clipbhue,"magenta")

 gvwo=cWo(vp,"BV",@name,"GMYVAL",@VALUE,0,@color,"green",@resize,0.5,by,0.9,bY)

 sWo(gvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @STYLE,"SVB")
 sWo(gvwo,@bhue,"teal",@clipbhue,"magenta",@FUNC,"inputValue")

<<"%V$two $hwo $gwo $gvwo $lwo\n"



 bY = by - ypad
 by = bY - yht

 lwo=cWo(vp,"ONOFF",@name,"PLAY",@VALUE,"ON",@color,"red",@resize,bx,by,bX,bY)
 sWo(lwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue", @STYLE,"SVL", @redraw)
 sWo(lwo,@fhue,"teal",@clipbhue,"violet")

 bY = 0.95
 by = bY - yht



 sWi(vp,@redraw)


 sWi( {vp,txtwin} ,@woredrawall)

//  now loop wait for message  and print



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
  
   // sWo(two,@redraw)
  
//   sWo(two,@clear,@texthue,"black",@textr,"%V$Woid\n$Woname\n $button\n $keyc\n $keyw\n$Woval",-0.9,0.3)

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

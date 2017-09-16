///
/// $(nvd)
///





envDebug()


Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"

}

    rsig=checkTerm();
    <<"%V$rsig \n";



    txtwin = CWi("title","Info_text_window")

    sWi(txtwin,@pixmapoff,@drawon,@save,@bhue,"white",@sticky,0)

    vp = CWi(@title,"Buttons1")

<<"%V$vp \n"

    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

    vp2 = CWi(@title,"Buttons2")

<<"%V$vp2 \n"

    sWi(vp2,@pixmapon,@drawoff,@save,@bhue,"white")

    sWi(vp2,@clip,0.1,0.2,0.9,0.9)

     vp3 = CWi("title","Buttons3")  

    sWi(vp3,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp3,@clip,0.1,0.2,0.9,0.9)

<<"%V$vp3 \n"


       int fswins[] =  {txtwin,vp,vp2,vp3};

//       wrctile( {txtwin,vp,vp2,vp3}, 0.05,0.05,0.95,0.95, 2, 2,-1,0) // tile windows in 2,2 matrix on  screen zero
       wrctile( fswins, 0.05,0.05,0.95,0.95, 2, 2,-1,2) // tile windows in 2,2 matrix on  current screen 

//       sWi({txtwin,vp,vp2,vp3}, @redraw)

       sWi(fswins, @redraw @save)


       vp4 = cWi(@title,"Buttons4")
       sWi(vp4,@resize,0.1,0.1,0.8,0.8,1) on screen 1

//       wrctile(vp1, 0.05,0.05,0.95,0.95, 1, 1,1,0) 

<<"%V$vp4 \n"

//////// Wob //////////////////
// setdebug(1);
 
 bx = 0.1
 bX = 0.4
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 two=cWo(txtwin,@TEXT,@name,"Text",@VALUE,"howdy",@color,ORANGE_,@resize_fr,0.1,0.1,0.9,0.9)
 sWo(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@pixmapoff,@redraw)
 sWo(two,@SCALES,-1,-1,1,1)
 sWo(two,@help," Mouse & Key Info ")

// sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"ON",@STYLE,"SVB",@FUNC,"ringBell")
 gwo=cWo(vp,@BV,@name,"ColorTeal",@color,"green",@resize,bx,by,bX,bY)
 sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"color is teal",@STYLE,"SVB")
 sWo(gwo,@bhue,TEAL_,@clipbhue,"skyblue",@redraw )

 bY = by - ypad
 by = bY - yht
 

// hwo=cWo(vp,@ONOFF,@name,"ENGINE",@VALUE,0,@color,GREEN_,@resize,bx,by,bX,bY)
 hwo=cWo(vp,@ONOFF,@name,"ENGINE",@VALUE,"ON",@color,GREEN_,@resize,bx,by,bX,bY)

 sWo(hwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_, @STYLE,"SVR")
 sWo(hwo,@bhue,"white",@clipbhue,"magenta");


 // GetValue after entering text
 gvwo=cWo(vp,@BV,@name,"GMYVAL",@VALUE,0,@color,GREEN_,@resize,0.5,by,0.9,bY)
 sWo(gvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_, @STYLE,"SVB")
 //sWo(gvwo,@bhue,"teal",@clipbhue,MAGENTA_,@FUNC,"inputValue",@MESSAGE,1)
 //sWo(gvwo,@bhue,"teal",@clipbhue,MAGENTA_,@FUNC,"inputValue",@MESSAGE,1)
 sWo(gvwo,@bhue,"white",@clipbhue,"red",@FUNC,"inputValue",@MESSAGE,1)





 bY = by - ypad
 by = bY - yht

 lwo=cWo(vp,@ONOFF,@name,"PLAY",@VALUE,"ON",@color,"red",@resize,bx,by,bX,bY)
// sWo(lwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue", @STYLE,"SVL", @redraw)
 sWo(lwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue", @STYLE,"SVL", "redraw")
 sWo(lwo,@fhue,"teal",@clipbhue,"violet")


<<"%V$two $hwo $gwo $gvwo $lwo\n"

 bY = 0.95
 by = bY - yht

 rwo=cWo(vp2,"BS",@name,"FRUIT",@color,"yellow",@resize,bx,by,bX,bY)
 sWo(rwo,@CSV,"mango,cherry,apple,banana,orange,Peach,pear")

 sWo(rwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@STYLE,"SVR", @redraw )
 sWo(rwo,@fhue,"orange",@clipbhue,"steelblue")

 boatwo=cWo(vp3,"BS",@name,"BOATS",@color,"yellow",@resize_fr,bx,by,bX,bY)
 sWo(boatwo,@CSV,"sloop,yacht,catamaran,cruiser,trawler,ketch")
 sWo(boatwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@STYLE,"SVR", "redraw")
 sWo(boatwo,@help," click to choose a boat ")
 bY = by - ypad
 by = bY - yht

<<"%V$boatwo \n"

 bsketchwo=cWo(vp3,@GRAPH,@name,"sketch",@color,"yellow",@resize,bx,0.1,0.9,bY)
 sWo(bsketchwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red", @redraw )
 sWo(bsketchwo,@clip,0.1,0.15,0.95,0.85,@bhue,"lime")
 sWo(bsketchwo,@SCALES,-1,-1,1,1)

<<"%V$bsketchwo \n"


 grwo=cWo(vp2,@GRAPH,@name,"pic",@color,"yellow",@resize,bx,by,bX,bY)
 sWo(grwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_, @redraw )
 sWo(grwo,@SCALES,0,0,1,1)

<<"%V$grwo \n"

 bY = by - ypad
 by = bY - yht


 qwo=cWo(vp2,@BN,@name,"QUIT",@VALUE,"QUIT",@color,MAGENTA_,@resize_fr,bx,by,bX,bY)
 sWo(qwo,@help," click to quit")
 sWo(qwo,@BORDER ,@DRAWON ,@CLIPBORDER, @FONTHUE,BLUE_, @redraw ,@DRAWON)
 //sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER ,@FONTHUE,"black", "redraw")

<<"%V$qwo \n"

// tbwo=cWo(vp2,@TB,@name,"tb_q",@color,"yellow",@VALUE,"QUIT",@func,"window_intrp",@resize,0.9,by,0.99,bY)
 tbwo=cWo(vp2,@TB,@name,"tb_q",@color,"yellow",@VALUE,"QUIT",@func,"window_term",@resize,0.9,by,0.99,bY)
 sWo(tbwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,@FONTHUE,"red", @symbol,"triangle", @symsize, 120, @redraw)

<<"%V$tbwo \n"

 symwo=cWo(vp2,"SYMBOL",@name,"sym",@color,"lime",@resize,0.5,0.5,0.8,0.9)
 sWo(symwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,@FONTHUE,"red", @symbol,"triangle", @symsize, 50, @redraw ,@foo)
 sWo( symwo, @setmove,1 )

<<"%V$symwo \n"

 sWi(vp,@redraw)
 sWi(vp2,@redraw)
 sWi(vp3,"woredrawall")
 sWi(txtwin,"woredrawall")

 int allwins[] = {vp,vp2,vp3,txtwin};
 
 //omy = sWi( {vp,vp2,vp3,txtwin} ,@woredrawall)
// BUG anonymous array as func argument
// sWi( {vp,vp2,vp3,txtwin} ,@woredrawall)

sWi( allwins ,@woredrawall)

//  now loop wait for message  and print


   xp = 0.1
   yp = 0.5
/{
//   plotline(vp2,0,0,1,1,"blue")

   plotline(vp2,0,0,1,1,"blue")
   plotline(vp2,0,1,1,0,"red")

   plotline(vp2,0.5,0,0.5,1,"green")
   for (rx  = 0 ; rx < 1.0; rx += 0.1) 
   plotline(vp2,rx,0,rx,1,"red")
   for (ry  = 0 ; ry < 1.0; ry += 0.1) 
   plotline(vp2,0,ry,1,ry,"red")

   setGwindow(vp2,@save)

   setGwindow(vp4,@pixmapon,@redraw)
   plotline(vp4,0,0,1,1,"blue")
   plotline(vp4,0,1,1,0,"red")
   plotline(vp4,0.5,0,0.5,1,"green")

   setGwindow(vp2,@clipborder,"red")
   setGwindow(vp3,@clipborder,"blue")
   setGwindow(vp4,@save)
/}


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



proc do_sketch()
{
   sWo(bsketchwo,@clear,@clearclip,@clipborder,@plotline,0.1,0.1,0.8,yp,"red")
   sWo(bsketchwo,@plotline,0.1,yp,0.8,0.1,"blue")
   axnum(bsketchwo,1)
   axnum(bsketchwo,2)

   sWo(grwo,@clearclip,@clipborder,@plotline,xp,0.1,0.5,0.5,"green")
   sWo(grwo,@plotline,xp,0.5,0.5,0.1,"black")

   xp += 0.05
   yp += 0.05

   zp = xp + yp

   if (xp > 0.7) { 
       xp = 0.1
   }

   if (yp > 0.9) {
      yp = 0.1
   }
 } 
//--------------------------------------------------------

proc QUIT()
{
  wid = getAslWid()

<<"ASL wid is $wid \n"

//  sWi(vp,@detach) // will detach from asl and thus window will persist

//  wdelete(wid)

//  sleep(10)
  //wdelete(vp,vp2,vp3)

  exit()

}

proc tb_q()
{

<<"expecting sig1 signal\n";
}

////////////////////////////////////

gevent E;  // our Gevent variable - holds last message
           // could use another or an array to compare events

   while (1) {

      //eventWait();
      
      E->waitForMsg();
      wid = E->getEventWoid();
<<"gevent %V $wid\n"
      eb = E->getEventButton();
<<"gevent %V $eb\n"

      if (E->getEventkeyw() @= "EXIT_ON_WIN_INTRP") {
<<"have win interp -- exiting!\n"
      break;
      }

      sWo(two,@texthue,"black",@clear,@textr,"$E->getEventWoValue()",-0.9,0)

      if (E->getEventType() @= "PRESS") {
            ev_woname = E->getEventWoName();
	    <<"%V $ev_woname";
        if (!(ev_woname @= "")) {
            DBPR"calling function via woname $ev_woname !\n"
            $ev_woname()
            continue;
        }

       }

  }

 //exitgs() // should close xgs if a child -- and exit
<<" killing xgm $Xgm_pid \n";
// sendsig(Xgm_pid, 12);


 exitgs();
 <<"kill xgs now exit!\n";
 exit();
 





;

////////////////////   TBD -- FIX //////////////////////

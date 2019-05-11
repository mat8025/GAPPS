//%*********************************************** 
//*  @script buttons.asl 
//* 
//*  @comment test buttons 
//*  @release CARBON 
//*  @vers 1.14 Si Silicon                                                
//*  @date Wed Feb  6 14:53:24 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



setdebug(1,@keep)

Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"

}

    rsig=checkTerm();
    <<"%V$rsig \n";

    txtwin = cWi("title","Info_text_window")

    sWi(txtwin,@pixmapoff,@drawon,@save,@bhue,"white",@sticky,0)

    vp = cWi(@title,"Buttons1")

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

 gwo=cWo(vp,@BV,@name,"ColorTeal",@color,"green",@resize,bx,by,bX,bY)
 sWo(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"color is teal",@STYLE,SVB_)
 sWo(gwo,@bhue,TEAL_,@clipbhue,"skyblue",@redraw )

 bY = by - ypad
 by = bY - yht
 


 hwo=cWo(vp,@ONOFF,@name,"ENGINE",@VALUE,"ON",@color,GREEN_,@resize,bx,by,bX,bY)

 sWo(hwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_, @STYLE,SVR_)
 sWo(hwo,@bhue,"white",@clipbhue,"magenta");


 // GetValue after entering text
 gvwo=cWo(vp,@BV,@name,"GMYVAL",@VALUE,0,@color,GREEN_,@resize,0.5,by,0.9,bY)
 sWo(gvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_, @STYLE,SVR_)
 sWo(gvwo,@bhue,"white",@clipbhue,"red",@FUNC,"inputValue",@MESSAGE,1)


 bY = by - ypad
 by = bY - yht

 lwo=cWo(vp,@ONOFF,@name,"PLAY",@VALUE,"ON",@color,"red",@resize,bx,by,bX,bY)
 sWo(lwo,@border,@drawon,@clipborder,@fonthue,"blue", @style,"SVL", "redraw")
 sWo(lwo,@fhue,"teal",@clipbhue,"violet")


<<"%V$two $hwo $gwo $gvwo $lwo\n"

 bY = 0.95
 by = bY - yht

 rwo=cWo(vp2,"BS",@name,"FRUIT",@color,"yellow",@resize,bx,by,bX,bY)
 sWo(rwo,@CSV,"mango,cherry,apple,banana,orange,Peach,pear")

 sWo(rwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@STYLE,SVR_, @redraw )
 sWo(rwo,@fhue,"orange",@clipbhue,"steelblue")

 boatwo=cWo(vp3,"BS",@name,"BOATS",@color,"yellow",@resize_fr,bx,by,bX,bY)
 sWo(boatwo,@CSV,"sloop,yacht,catamaran,cruiser,trawler,ketch")
 sWo(boatwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@STYLE,SVR_, "redraw")
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




include "tbqrd";

titleButtonsQRD(vp);

 sWi(vp,@redraw)
 sWi(vp2,@redraw)
 sWi(vp3,@woredrawall)
 sWi(txtwin,@woredrawall)

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

  exit()

}

proc tb_q()
{
<<"expecting sig1 signal\n";
}

////////////////////////////////////

include "gevent" ;   // our Gevent variable - holds last message
                            // could use another or an array to compare events

   while (1) {

      eventWait();

      if (_ekeyw @= "EXIT_ON_WIN_INTRP") {
<<"have win interup -- exiting!\n"
      break;
      }

      sWo(two,@texthue,"black",@clear,@textr,"$_ekeyw",-0.9,0)

      if (_ename @= "PRESS") {
	    <<"%V $_ewoname";
//        if (!(_ewoname @= "")) {
            DBPR"calling function via woname $ev_woname !\n"
            $_ewoname()
            continue;
  //      }

       }

  }


<<" killing xgm $Xgm_pid \n";
// sendsig(Xgm_pid, 12);


 exitgs();
 <<"kill xgs now exit!\n";
 exit();
 





;

////////////////////   TBD -- FIX //////////////////////

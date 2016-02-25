//////// wo.asl ////////////////////

setdebug(1)

Graphic = CheckGwm()

<<" %v $Graphic \n"
spawn_it = 1
 if (Graphic) {
   spawn_it = 0;
 }

<<" %v $spawn_it \n"

     if (spawn_it) {
       X=spawngwm()
       spawn_it  = 0;
     }

    vp = CreateGwindow(@title,"Button",@resize,0.01,0.2,0.49,0.49,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,LILAC)
    setgwob(vp,@grid,9,18)


//////// Wob //////////////////

 bx = 0.1
 bX = 0.3
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht


 gwo=createGWOB(vp,"BV",@name,"B_V",@color,GREEN,@resize,0,0,3,3,3)

 setgwob(gwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED,@VALUE,"ON",@STYLE,"SVB",@FUNC,"ringBell")


 setgwob(gwo,@grid,9,18)

 setgwob(gwo,@redraw)

 bx = 0.4
 bX = 0.7

 hwo=createGWOB(vp,@BV,@name,"Hello",@color,RED,@resize,3,5,5,7,3)

// FIXME ip_wo_value crashes
// setgwob(hwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"ON",@STYLE,"SVB",@FUNC,"ip_wo_value")
setgwob(hwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black",@VALUE,"Red",@STYLE,"SVB",@FUNC,"cycleHue")

 setgwob(hwo,@redraw)

 bx = 0.8
 bX = 0.9

 qwo=createGWOB(vp,"BV",@name,"QUIT",@color,BLUE,@resize,7,4,9,6,3)

 setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@VALUE,"ON",@STYLE,"SVB")

 setgwob(qwo,@redraw)




////////////////////   EVENT PROCESSING ////////////////////////////

CLASS Event
{

 public:

   Svar emsg ;
   Svar kws ;
   Str keyw ;
   Str woname ;

   char keyc ;

   int minfo[];
   float rinfo[];
   float wms[];


   int woid
   int button
   int wo_ival

 #  method list


   CMF getMsg()
   {
     emsg = ""
     keyc = 0
     emsg= MessageWait(minfo,rinfo)

//<<"reading msg \n"

       // emsg= MessageRead(minfo,rinfo)

    <<"<|$emsg|> \n"

     keyw = "NO_MSG"

     if ( !(emsg[0] @= "NO_MSG")) { 


//<<"%V$minfo \n"
//<<"%V$rinfo \n"
//<<"%V$emsg \n"

      kws = Split(emsg)

//<<"%V$kws \n"

      keyw = kws[0]
      woname = kws[1]

//<<"%V$keyw\n"

      keyc = pickc(kws[2],0)

//      wms=GetMouseState()

//<<"%V$wms\n"

      woid = minfo[3]

      button = minfo[8]

      wo_ival = minfo[13]
//      button = wms[2]
    }
     // sleep(0.1)
   }   
}

Event E



xp = 0.1
yp = 0.5

   while (1) {


    E->getMsg()


     setgwob(hwo,@redraw)

  if (scmp(E->woname,"QUIT",4)) {
       break
  }

  }

 exit_gs()

;
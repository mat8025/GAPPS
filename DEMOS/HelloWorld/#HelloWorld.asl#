#/* -*- c -*- */

SetDebug(0)

HW_MSG = " HelloWorld! "
<<" $HW_MSG \n"

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
 //   float wms[];


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

<<"%V$kws \n"

      keyw = kws[0]
      woname = kws[1]

<<"%V$keyw\n"

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

////////////////////////////////////////////////////////////////////////////////////////////////
// an enum to hold wo values

enum Woval {

  WLUP = 1,
  WUP,
  WRUP,
  WLEFT,
  WCEN,
  WRIGHT,
  WLDWN,
  WDOWN,
  WRDWN,

}

// use these to switch on when event is a WOEVENT


///////////////////////////////////////////////////////////////////////////////////////////////
Graphic = CheckGwm()

  spawn_it = 1

 if (Graphic) {
   spawn_it = 0;
 }

 if (spawn_it) {
     X=spawngwm()
  }


   // create the window
   // create the wob's
   // plot the test  message


    vp = CreateGwindow(@title,HW_MSG,@resize,0.1,0.1,0.9,0.95,0)

    SetGwindow(vp,@pixmapon,@drawon,@bhue,"white")


 two=createGWOB(vp,"TEXT",@name,"Text",@VALUE,HW_MSG,@color,"orange",@resize,0.1,0.6,0.9,0.88)
 
 fowo=createGWOB(vp,"TEXT",@name,"Font",@VALUE,HW_MSG,@color,"white",@resize,0.1,0.3,0.9,0.59)


 setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw,@pixmapoff,@drawon,@font,"big")
 setgwob(fowo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"white", @redraw,@pixmapoff,@drawon,@font,"big")

 coorwo=createGWOB(vp,"TEXT",@name,"COOR",@VALUE,"0.0 0.0",@color,"orange",@resize,0.05,0.91,0.3,0.99)

 setgwob(coorwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @pixmapoff,@drawon,@redraw)

  msgwo=createGWOB(vp,"TEXT",@name,"COOR",@VALUE,"0.0 0.0",@color,"white",@resize,0.35,0.89,0.9,0.99)

  setgwob(msgwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @pixmapoff,@drawon,@redraw,@save)

 lx = -2
 ly = -1

 setgwob(two,@scales, -1 , -1 , 1, 1)
 setgwob(fowo,@scales, -1 , -1 , 1, 1)

 bpad = 0.05
 bw = 0.1
 bx = 0.1
 bX = bx + bw
 yht = 0.2
 ypad = 0.05

 bY = 0.28
 by = bY - yht


 qwo=createGWOB(vp,BUTTON_VALUE,@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,bx,by,bX,bY)

 setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

 cwo=createGWOB(vp,BUTTON_NAME,@name,"SHOW?",@VALUE,"SHOW",@color,"orange",@resize,bx,by,bX,bY)

 setgwob(cwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")



 upwo=createGWOB(vp,SYMBOL,@name,"UP",@IVALUE,WUP,@color,"green",@symbol,"tri",@resize,bx,by,bX,bY)

 setgwob(upwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

 dwnwo=createGWOB(vp,SYMBOL,@name,"DOWN",@IVALUE,WDOWN,@color,"green",@symbol,"i_tri",@resize,bx,by,bX,bY)

 setgwob(dwnwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw")

  ltwo=createGWOB(vp,SYMBOL,@name,"LEFT",@IVALUE,WLEFT,@color,"green",@symbol,"tri",@rotate,90,@resize,bx,by,bX,bY)

  setgwob(ltwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,90)

 rtwo=createGWOB(vp,SYMBOL,@name,"RIGHT",@IVALUE,WRIGHT,@color,"green",@symbol,"tri",@resize,bx,by,bX,bY)

  setgwob(rtwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,-90)

 ruwo=createGWOB(vp,SYMBOL,@name,"RU",@IVALUE,WRUP,@color,"green",@symbol,"tri",@resize,bx,by,bX,bY)

  setgwob(ruwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,-45)

   rdwo=createGWOB(vp,SYMBOL,@name,"RD",@VALUE,"1",@IVALUE,WRDWN@color,"green",@symbol,"tri",@resize,bx,by,bX,bY)

  setgwob(rdwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,-135)

   luwo=createGWOB(vp,SYMBOL,@name,"LU",@VALUE,"1",@IVALUE,WLUP,@color,"green",@symbol,"tri",@resize,bx,by,bX,bY)

  setgwob(luwo,@BORDER,@DRAWON,@PIXMAPON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,45)

   ldwo=createGWOB(vp,SYMBOL,@name,"LD",@VALUE,"1",@IVALUE,WLDWN,@color,"green",@symbol,"tri",@resize,bx,by,bX,bY)

  setgwob(ldwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,135)

   cenwo=createGWOB(vp,SYMBOL,@name,"CEN",@VALUE,"1",@IVALUE, WCEN,@color,"orange",@symbol,"dia",@resize,bx,by,bX,bY)

 setgwob(cenwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@symang,0)



  int wo_array[] = {qwo, cwo}

    wo_htile(wo_array,0.1, 0.05, 0.35, 0.2)

  int pos_array[] = { luwo, upwo, ruwo,  ltwo,  cenwo, rtwo, ldwo, dwnwo, rdwo }

    wo_rctile(pos_array,0.5, 0.05, 0.7, 0.28,3,3)


setgwin(vp ,"woredrawall")

float xp = 0.0
float yp = 0.0
lly = -1

int hue = 1


   setgwin(vp ,@redraw)

   setGwob(rdwo,@drawon,@pixmapon,@redraw)


   hd = 1

   while (1) {

 
    E->getMsg()
    msg = E->woname

     //<<" $msg \n"
     //setgwob(msgwo,@clear,@clipborder,"blue",@textr,msg,0.0,0.5,@redraw)
     //   setgwob(msgwo,@clearpixmap,@clipborder,"blue",@textr,msg,0.0,0.5,@redraw)
     //     setgwob(msgwo,@clearpixmap,@clipborder,"blue",@textr,msg,0.0,0.5,@showpixmap)

     setgwob(msgwo,@clear,@clipborder,"blue",@textr,msg,0.1,0.7)
     setgwob(msgwo,@textr,"$E->minfo ",0.05,0.5)
     setgwob(msgwo,@textr,"$E->wo_ival ",0.2,0.2)

     //     setgwob(coorwo,@clear,@clipborder,"green",@textr,"$xp $yp",0.0,0.0,@redraw)

     setgwob(coorwo,@clearclip,@clipborder,"green",@textr,"$xp $yp",0.0,0.0)

     <<"$coorwo $xp $yp \n"
    if (scmp(msg,"QUIT",4)) {
         break
      }


    //    can use woname
    //    woval
    //    or wo_ival
    //    or the wo_id
    //    if (scmp(msg,"UP",2) ) {
    //    if (E->wo_ival == WUP) {


/{
    else if (scmp(msg,"Q",1)) {
        xp -= 0.05
    }
    else if (scmp(msg,"S",1)) {
      //   xp += 0.05
    }
/}


    switch (E->wo_ival) {

    case WUP:
        yp += 0.05
        hd = 1
    break;
    case WDOWN:
    case 'T':
        yp -= 0.04
        hd = -1
    break;
    case WRIGHT:
        xp += 0.05
        hd = 1
    break;
    case WLEFT:
        xp -= 0.04
        hd = -1
    break;
    case WLUP:
        xp -= 0.04
        yp += 0.05
        hd = -1
    break;
    case WRUP:
        xp += 0.04
        yp += 0.05
        hd = 1
    break;
    case WLDWN:
        xp -= 0.04
        yp -= 0.05
        hd = -1
    break;
    case WRDWN:
        xp += 0.04
        yp -= 0.05
        hd = 1
    break;
    case WCEN:
        xp = 0
        yp = 0
    break;

    }
    

     //     xp += 0.05
     // yp -= 0.04


     if (xp > 0.95) {
         xp = -1.0
     }
	   //FIXME    if (yp < -0.95)
	   if (yp < -1.0) {
              yp = 1.0
	   }

	   if (yp > 1.0) {
              yp = -1.0
	   }

	   if (xp > 1.2) {
              xp = -1.0
	   }

	   if (xp < -1.0) {
              xp = 0.9
	   }

     cname = getColorName(hue)

     //     setgwob(two,@clear,@textr,HW_MSG,xp,yp,@redraw)
     HW_MSG = " Hello $cname World! $hue"

    setgwob(two,@bhue,hue,@texthue,"black",@clearclip,hue,@clipborder,"red",@textr,HW_MSG,xp,yp)
     setgwob(two,@fonthue,"white",@textr,HW_MSG,xp+0.01,yp+0.01)

     setgwob(fowo,@clear,@clipborder,"green",@fonthue,hue,@textr,HW_MSG,-0.5,0)

     //     <<" $HW_MSG \n"
     
     //     setgwob(two,@textr,cname,0,yp)
     hue += hd
     if (hue < 0) {
         hue = 150
     }
   }


      w_delete(vp);
      exit_gs(1);

  ;

STOP!



////////////////////////////////////   TDB ///////////////////////////////
// Font changer
// separate coor 
// hold-down repeat click mode for button
//
//

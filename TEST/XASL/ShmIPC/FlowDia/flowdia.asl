//%*********************************************** 
//*  @script flowdia.asl 
//* 
//*  @comment draw flow diagram 
//*  @release CARBON 
//*  @vers 1.14 Si Silicon                                                
//*  @date Wed Feb  6 14:53:24 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"
include "hv.asl"
include "tbqrd";
include "gevent.asl"

debugON();



Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"

}

    rsig=checkTerm();
    <<"%V$rsig \n";

vp = cWi(@title,"Diagram_1")

<<"%V$vp \n"

    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@clip,0.1,0.2,0.9,0.9)


//////// Wob //////////////////

 
 bx = 0.1
 bX = 0.4
 yht = 0.18
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 gwo=cWo(vp,@BV,@name,"ColorTeal",@color,"green",@resize,bx,by,bX,bY)
 sWo(gwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"color is teal",@style,"SVB")
 sWo(gwo,@bhue,TEAL_,@clipbhue,"skyblue",@redraw )

 bY = by - ypad
 by = bY - yht
  // GetValue after entering text

 gvwo=cWo(vp,@BV,@name,"GMYVAL",@VALUE,0,@color,GREEN_,@resize,0.5,by,0.9,bY)
 sWo(gvwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_, @STYLE,"SVR")
 sWo(gvwo,@bhue,"white",@clipbhue,"red",@FUNC,"inputValue",@MESSAGE,1)


 bY = by - ypad
 by = bY - yht

 lwo=cWo(vp,@ONOFF,@name,"PLAY",@VALUE,"ON",@color,"red",@resize,bx,by,bX,bY)
 sWo(lwo,@border,@drawon,@clipborder,@fonthue,"blue", @style,"SVL", "redraw")
 sWo(lwo,@fhue,"teal",@clipbhue,"violet")

 bY = by - ypad
 by = bY - yht

sym_size = 10;
 swo=cWo(vp,@symbol,@name,"Symbol",@value,"ON",@color,RED_,@resize,bx,by,bX,bY)
 sWo(swo,@drawon,@pixmapon,@fonthue,"blue", @symbol,"diamond",@symsize,sym_size)
 sWo(swo,@fhue,"teal",@clipbhue,WHITE_,@clip,0.01,0.01,0.99,0.99)



   titleButtonsQRD(vp);
   titleVers()

 sWi(vp,@redraw)


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


////////////////////////////////////
int ang = 0
int symbol_num = 3;
   while (1) {

      eventWait();
<<"$_emsg $_eloop $_ewoid  $_ewid $_ebutton $_etype $(PRESS_)\n"
      
     if (symbol_num > 20) {
         symbol_num = 0
     }
   
     if (symbol_num < 0) {
         symbol_num = 0;
     }
      symbol_num++;
      
      if (_etype == PRESS_) {
	    <<"%V $_ewoname";
            DBPR"calling function via  $_ewoname !\n"
            //$_ewoname()
   // sWo(swo,@drawon)
     sWo(swo,@color,"black",@penhue,"brown",@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@update)
     //sWo(gwo,@showpixmap)


       }

  }


<<" killing xgm $Xgm_pid \n";
// sendsig(Xgm_pid, 12);


 exitgs();
 <<"kill xgs now exit!\n";
 exit();
 
////////////////////   TBD -- FIX //////////////////////

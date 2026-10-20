//%*********************************************** 
//*  @script symbol.asl 
//* 
//*  @comment show symbols
//*  @release CARBON 
//*  @vers 1.14 Si Silicon                                                
//*  @date Wed Feb  6 14:53:24 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

#include "debug.asl"
//#include "hv.asl"
#include "tbqrd.asl"
#include "wevent.asl"

   debugON()

Graphic = CheckGwm();

  if (!Graphic) {
    Xgm_pid = spawnGwm("WOINWO")
    <<"%V $Xgm_pid \n" 
 }



   pi = 4.0*atan(1.0)

   vp = cWi("WoInWo")

<<" %V $pi $vp\n"

   sWi(_woid,vp,_wresize,wbox(0.05,0.2,0.9,0.9,0)) 

   sWi(_woid,vp,_wpixmap,ON_,_wdraw, ON_,_wbhue,PINK_,_wcolor,BLACK_,_wsave,ON_,_wsavepixmap,ON_);

   sWi(_woid,vp,_wclip,wbox(0.1,0.1,0.9,0.9));
   
   sWi(_woid,vp,_wredraw,ON_);

   
   titleButtonsQRD(vp);
   titleVers();

ans = ask("CONTINUE $vp?",1)

    msgwo=cWo(vp,WO_TEXT_)

    sWo(_woid,msgwo,_wname,"COOR",_wvalue,"0.0 0.0",_wcolor,WHITE_,_wresize,wbox(0.35,0.81,0.9,0.99))

    sWo(msgwo,_wfonthue,RED_, _wdraw, ON_,_wsave,ON_,_wredraw,ON_)


ans = ask("CONTINUE %V $msgwo?",1)

    gwo=cWo(vp,WO_SYMBOL_)

    sWo(_woid,gwo,_wresize,wbox(0.1,0.1,0.8,0.8),_wname,"green",_wvalue,1.0)

    sWo(_woid,gwo,_wcolor,GREEN_,_wpenhue,BLACK_,_wsymbol,DIAMOND_)

    sWo(_woid,gwo,_wdraw, ON_,_wscales,wbox(0,0,1,1), _wpixmap, ON,_wpenhue,BLACK_,_wredraw, ON_)

ans = ask("CONTINUE %V $gwo?",1)

    /////////////////////////////////////////


    rwo=cWo(gwo,WO_SYMBOL_)

    sWo(_woid,rwo,_wresize,wbox(0.1,0.1,0.2,0.2),_wname,"RED",_wvalue,1.0,_wclip,wbox(0.01,0.01,0.99,0.99))

    sWo(rwo,_wcolor,RED_,_wpenhue,BLACK_,_wsymbol,DIAMOND_,_whvmove,ON_)

    sWo(rwo,_wdraw,ON_,_wpixmap, ON_,_wredraw,ON_,_wsave,ON,_wsavepixmap,ON_)

ans = ask("CONTINUE %V $rwo?",1)


/*
    bwo=cWo(gwo,@symbol,@resize,0.5,0.1,0.6,0.2,@name,"BLUE",@value,1.0,@clip,0.01,0.01,0.99,0.99)

    sWo(bwo,@color,RED_,@penhue,BLACK_,@symbol,DIAMOND_,@hvmove,ON_)

    sWo(bwo,@drawoff,@pixmapon,@redraw,@save,@savepixmap)

   // sWi(vp,@pixmapon,@drawon,@bhue,PINK_,@redraw,@savepixmap);

   // sWo(gwo,@scales,-1.2,-1.2,1.2,1.2,@savescales,0,@font,F_SMALL_,@redraw,@savepixmap_)
*/





sym_size = 50;

// message info
symbol_name = "diamond"
int ang = 0
int symbol_num = 0;
uint n_msg = 0;

    rx = 0.1
    ry = 0.1
    rxstep = 0.02;
        rystep = 0.02;

     Text(gwo, "Weight (lbs)",0.5,0.7,4,-90)

ans = ask("CONTINUE move WOS within WOS?",1)





     while (1) {


      
      eventWait(1);

      n_msg++

//<<"%V$_ewoname  $_ekeyw $_etype\n";
    // AxText(gwo, 1, "XX", 0.5,  0.25, BLUE_);

    // AxText(vp, 1, "XX", 0.5,  0.25, BLUE_);
     
       AxText(gwo, 1, "YY", 0.5,  -2, BLACK_);

   if (_etype  == PRESS_) {


       sWo(msgwo,@clear,@clipborder,BLUE_,@textr,_emsg,0.0,0.7)

         
     if (symbol_num > 20) {
         symbol_num = 0
     }
   
     if (symbol_num < 0) {
         symbol_num = 0;
     }

     if (_ebutton == 3) {
        ang += 10;
        if (ang > 360) {
            ang = 0;
        }
     }
     else if (_ebutton == 2) {
       symbol_num--
       //symbol_name = "diamond"
     }
     else if (_ebutton == 4) {
      // sym_size-- ;
     }
     else if (_ebutton == 5) {
       //sym_size++ ;
     }
     else if (_ebutton == 1) {
       symbol_num++;
       if (sym_size > 99) {
           sym_size = 20;
       }

/*
       symbol_name = getSymbolName(symbol_num);
<<"%V$symbol_name\n";
     if (symbol_num > 20) {
         symbol_num = 1;
     }
*/


     }

/*

     sWo(rwo,@drawon,@clearpixmap)
     sWo(rwo,@color,"yellow",@penhue,"black",@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)


     sWo(bwo,@drawon,@clearpixmap)
     sWo(bwo,@color,BLUE_,@penhue,"black",@symbolshape,symbol_num+1,@symsize,sym_size,@symang,ang,@redraw)

    sWo(rwo,@showpixmap)
   //  sWo(gwo,@drawon,@clear)
   //  sWo(gwo,@color,"magenta",@penhue,"brown",@symbolshape,symbol_num,@symsize,sym_size,@symang,ang,@redraw)
     //sWo(gwo,@showpixmap)

     sWo(msgwo,@textr,"%V$symbol_num $symbol_name $ang  $sym_size",0.0,0.1)

    sWo(gwo,@axnum,2,-1,1,0.1,-2,"2.1f");
    sWo(gwo,@axnum,1,-1,1,0.25,2,"2.1f");
    sWo(gwo,@axnum,4,-1,1,0.25,2,"2.1f");
    sWo(gwo,@axnum,3,-1,1,0.25,-2,"2.1f");

    sWo(rwo,@move,rx,0.0,gwo)
    
    sWo(bwo,@move,rx,sin(rx*pi),gwo)
*/


    rx += rxstep
    ry += rystep

    if (rx > 0.9) {
       rxstep *= -1;
    }

    if (rx < -0.9) {
       rxstep *= -1;
    }
    
    if (ry > 0.9) {
       rystep *= -1;
    }

    if (ry < -0.9) {
       rystep *= -1;
    }



  }

}
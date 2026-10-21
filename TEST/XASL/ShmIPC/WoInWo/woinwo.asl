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
//#include "hv.asl"  // BAD?
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


//wans = wask("CONTINUE $vp?","y", "WOINWO")

//<<" %V $wans\n"

    msgwo=cWo(vp,WO_TEXT_)

    sWo(_woid,msgwo,_wname,"COOR",_wvalue,"0.0 0.0",_wcolor,WHITE_,_wresize,wbox(0.35,0.81,0.9,0.99))

    sWo(msgwo,_wfonthue,RED_, _wdraw, ON_,_wsave,ON_,_wredraw,ON_)


//ans = wask("CONTINUE %V $msgwo?","GO_ON")

    gwo=cWo(vp,WO_SYMBOL_)

    sWo(_woid,gwo,_wresize,wbox(0.1,0.1,0.8,0.8),_wname,"green",_wvalue,1.0)

    sWo(_woid,gwo,_wcolor,GREEN_,_wpenhue,BLACK_,_wsymbol,DIAMOND_)

    sWo(_woid,gwo,_wdraw, ON_,_wscales,wbox(0,0,1,1), _wpixmap, ON,_wpenhue,BLACK_,_wredraw, ON_)

//ans = wask("CONTINUE %V $gwo?")

    /////////////////////////////////////////


    rwo=cWo(gwo,WO_SYMBOL_)

    sWo(_woid,rwo,_wresize,wbox(0.1,0.1,0.2,0.2),_wname,"RED",_wvalue,1.0,_wclip,wbox(0.01,0.01,0.9,0.9))

    sWo(rwo,_wcolor,RED_,_wpenhue,BLACK_,_wsymbol,DIAMOND_,_whmove,ON_)

   // sWo(rwo,_wdraw,ON_,_wpixmap, ON_,_wredraw,ON_,_wsave,ON,_wsavepixmap,ON_)


    bwo=cWo(gwo,WO_SYMBOL_)
    
    Swo(_woid,bwo,_wresize,wbox(0.5,0.1,0.6,0.2),_wname,"BLUE",_wvalue,1.0,_wclip,wbox(0.01,0.01,0.99,0.99))

    sWo(_woid,bwo,_wcolor,RED_,_wpenhue,BLACK_,_wsymbol,DIAMOND_,_wvmove,ON_)


    sym_size = 10;

    sWo(_woid,gwo,_wscales,wbox(-1.2,-1.2,1.2,1.2),_wsavescales,0,_wfont,F_SMALL_,_wsymsize,sym_size,_wredraw,ON_)








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

     wans = wask("CONTINUE move WOS within WOS?")

<<"%V $wans \n"



     while (1) {


      
      eventWait(1);

      n_msg++

<<"%V $ewoname_  $ekeyw_ $etype_ \n";
     AxText(gwo, 1, "XX", 0.5,  0.25, BLUE_);

    // AxText(vp, 1, "XX", 0.5,  0.25, BLUE_);
     
       AxText(gwo, 1, "YY", 0.5,  -2, BLACK_);

     if (etype_  == PRESS_ ) {


       sWo(msgwo,_wclear,ON_,_wclipborder,BLUE_)
     
         
     if (symbol_num > 20) {
         symbol_num = 0
     }
   
     if (symbol_num < 0) {
         symbol_num = 0;
     }

     if (ebutton_ == 3) {
        ang += 10;
        if (ang > 360) {
            ang = 0;
        }
     }
     else if (ebutton_ == 2) {
      // symbol_num--
       symbol_num = 2;
       //symbol_name = "diamond"
     }
     else if (ebutton_ == 4) {
      // sym_size-- ;
     }
     else if (ebutton_ == 5) {
       //sym_size++ ;
     }
     else if (ebutton_ == 1) {
       symbol_num++;
       if (sym_size > 99) {
           sym_size = 20;
       }


       symbol_name = getSymbolName(symbol_num);
         <<"%V$symbol_name\n";
        if (symbol_num > 20) {
         symbol_num = 1;
        }
     }


     sWo(_woid,rwo,_wclearpixmap,ON_)
     sWo(_woid,rwo,_wcolor,YELLOW_,_wsymbol,symbol_num,_wvmove,ON_,_wredraw,ON_)
     sWo(_woid,rwo,_wcolor,PINK_,_wpenhue, BLACK_,_wsymbol,symbol_num,_wsymsize,sym_size,_wsymang,ang,_wredraw, ON_)
     sWo(_woid, rwo,_wmove,wbox(rx+0.1,ry+0.1,gwo,0))



     sWo(_woid,bwo,_wdraw, ON_,_wclearpixmap, ON_)
     sWo(_woid,bwo,_wcolor,BLUE_,_wpenhue, BLACK_,_wsymbol,symbol_num+1,_wsymsize,sym_size,_wsymang,ang,_wredraw, ON_)
     sWo(_woid, bwo,_wmove,wbox(rx,ry,gwo,0))


    Text("%V $symbol_num $symbol_name $ang  $sym_size",0.0,0.1)

/*
    sWo(gwo,@axnum,2,-1,1,0.1,-2,"2.1f");
    sWo(gwo,@axnum,1,-1,1,0.25,2,"2.1f");
    sWo(gwo,@axnum,4,-1,1,0.25,2,"2.1f");
    sWo(gwo,@axnum,3,-1,1,0.25,-2,"2.1f");
*/
    rx += rxstep
    ry += rystep

<<"%V $rx $ry \n"


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

}




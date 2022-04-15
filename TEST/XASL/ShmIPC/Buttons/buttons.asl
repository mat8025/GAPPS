/* 
 *  @script buttons.asl 
 * 
 *  @comment test buttons 
 *  @release CARBON buttons 
 *  @vers 1.15 P 6.3.90 C-Li-Th 
 *  @date 03/01/2022 11:01:10          
 *  @cdate 1/1/2001 Feb 6 14:53:24 2019 
 *  @author Mark Terry 6 14:53:24 2019 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                   



Str Use_= "  test the buttons";


#include "debug"


if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}



Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"
  }

//ask=iread("wait?")

    rsig=checkTerm();
    <<"%V$rsig \n";

    txtwin = cWi("Info_text_window")
<<"%V $txtwin \n"

    sWi(txtwin,_wpixmapoff,_wdrawon,_wsave,_wbhue,WHITE_,_wsticky,0)

    vp = cWi("Buttons1")

<<"%V$vp \n"

    sWi(vp,_Wpixmapon,_Wdrawon,_Wsave,_Wbhue,"white")

    sWi(vp,_Wclip,0.1,0.2,0.9,0.9)

    vp2 = cWi("Buttons2")

<<"%V$vp2 \n"

    sWi(vp2,_Wpixmapon,_Wdrawoff,_Wsave,_Wbhue,"white")

    sWi(vp2,_Wclip,0.1,0.2,0.9,0.9)

     vp3 = cWi("Buttons3")  

    sWi(vp3,_Wpixmapon,_Wdrawon,_Wsave,_Wbhue,"white")

    sWi(vp3,_Wclip,0.1,0.2,0.9,0.9)

<<"%V$vp3 \n"


       int fswins[] =  {txtwin,vp,vp2,vp3};

//       wrctile( {txtwin,vp,vp2,vp3}, 0.05,0.05,0.95,0.95, 2, 2,-1,0) // tile windows in 2,2 matrix on  screen zero
       wrctile( fswins, 0.05,0.05,0.95,0.95, 2, 2,-1,2) // tile windows in 2,2 matrix on  current screen 

//       sWi({txtwin,vp,vp2,vp3}, _Wredraw)

       sWi(fswins, _Wredraw _Wsave)
       vp4= -1;
       //? puts this on screen 1?
      // vp4 = cWi("Buttons4")
      // sWi(vp4,_Wresize,0.1,0.1,0.8,0.8,1)// on screen 1
     //<<"%V$vp4 \n"
//       wrctile(vp1, 0.05,0.05,0.95,0.95, 1, 1,1,0) 



//////// Wob //////////////////

 
 bx = 0.1
 bX = 0.4
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 two=cWo(txtwin,WO_TEXT_,_Wname,"Text",_WVALUE,"howdy",_Wcolor,ORANGE_,_Wresize_fr,0.1,0.1,0.9,0.9,_WEO)

 sWo(two,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,"black",_Wpixmapoff,_Wredraw)
 sWo(two,_WSCALES,-1,-1,1,1,_WEO)
 sWo(two,_Whelp," Mouse & Key Info ",_WEO)

 gwo=cWo(vp,WO_BV_,_Wname,"ColorTeal",_Wcolor,GREEN_,_Wresize,bx,by,bX,bY,_WEO)
 
 sWo(gwo,_Wborder,_Wdrawon,_Wclipborder,_Wfonthue,RED_,_WVALUE,"color is teal",_WSTYLE,SVB_)
 sWo(gwo,_Wbhue,TEAL_,_Wclipbhue,"skyblue",_Wredraw )

 bY = by - ypad
 by = bY - yht
 


 hwo=cWo(vp,WO_ONOFF_,_Wname,"ENGINE",_WVALUE,"ON",_Wcolor,RED_,_Wresize,bx,by,bX,bY,_WEO)

 sWo(hwo,_Wborder,_Wdrawon,_Wclipborder,_Wfonthue,WHITE_, _WSTYLE,SVR_)
 sWo(hwo,_Wfhue,LILAC_,_Wbhue,BLUE_,_Wclipbhue,MAGENTA_);


 // GetValue after entering text
 gvwo=cWo(vp,WO_BV_,_Wname,"GMYVAL",_WVALUE,0,_Wcolor,GREEN_,_Wresize,0.5,by,0.9,bY,_WEO)
 
 sWo(gvwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_, _WSTYLE,SVR_)
 sWo(gvwo,_Wbhue,WHITE_,_Wclipbhue,RED_,_Wfunc,"inputValue",_Wmessage,1,_WEO)


 bY = by - ypad
 by = bY - yht

 lwo=cWo(vp,WO_ONOFF_,_Wname,"PLAY",_WVALUE,"ON",_Wcolor,RED_,_Wresize,bx,by,bX*0.5,bY,_WEO)
 sWo(lwo,_Wborder,_Wdrawon,_Wclipborder,_Wfonthue,WHITE_, _Wstyle,SVB_, _Wredraw)
 sWo(lwo,_Wfhue,TEAL_,_Wclipbhue,PINK_)


<<"%V$two $hwo $gwo $gvwo $lwo\n"

 bY = 0.95
 by = bY - yht

 rwo=cWo(vp2,WO_BS_,_Wname,"FRUIT",_Wcolor,YELLOW_,_Wresize,bx,by,bX,bY,_WEO)
 sWo(rwo,_WCSV,"mango,cherry,apple,banana,orange,Peach,pear",_WEO);

 sWo(rwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,"red",_WSTYLE,SVR_, _Wredraw )
 sWo(rwo,_Wfhue,"orange",_Wclipbhue,"steelblue")

 boatwo=cWo(vp3,WO_BS_,_Wname,"BOATS",_Wcolor,YELLOW_,_Wresize_fr,bx,by,bX,bY,_WEO);
 sWo(boatwo,_WCSV,"sloop,yacht,catamaran,cruiser,trawler,ketch",_WEO);
 sWo(boatwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,RED_,_WSTYLE,SVR_, _Wredraw,_WEO);
 sWo(boatwo,_Whelp," click to choose a boat ",_WEO);

 bY = by - ypad
 by = bY - yht

<<"%V$boatwo \n"

 bsketchwo=cWo(vp3,WO_GRAPH_,_Wname,"sketch",_Wcolor,YELLOW_,_Wresize,bx,0.1,0.9,bY,_WEO)
 sWo(bsketchwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,"red", _Wredraw )
 sWo(bsketchwo,_Wclip,0.1,0.15,0.95,0.85,_Wbhue,CYAN_)
 sWo(bsketchwo,_WSCALES,-1,-1,1,1,_WEO)

<<"%V$bsketchwo \n"


 grwo=cWo(vp2,WO_GRAPH_,_Wname,"pic",_Wcolor,YELLOW_,_Wresize,bx,by,bX,bY,_WEO)
 sWo(grwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,RED_, _Wredraw )
 sWo(grwo,_WSCALES,0,0,1,1,_WEO)

<<"%V$grwo \n"

 bY = by - ypad
 by = bY - yht


 qwo=cWo(vp2,WO_BN_,_Wname,"QUIT",_WVALUE,"QUIT",_Wcolor,MAGENTA_,_Wresize_fr,bx,by,bX,bY,_WEO)
 sWo(qwo,_Whelp," click to quit",_WEO)
 sWo(qwo,_WBORDER ,_WDRAWON ,_WCLIPBORDER, _WFONTHUE,BLUE_, _Wredraw ,_WDRAWON)
 //sWo(qwo,_WBORDER,_WDRAWON,_WCLIPBORDER ,_WFONTHUE,"black", "redraw")

<<"%V$qwo \n"




include "tbqrd";

titleButtonsQRD(vp);

 sWi(vp,_Wredraw)
 sWi(vp2,_Wredraw)
 sWi(vp3,_Wworedrawall)
 sWi(txtwin,_Wworedrawall)

 int allwins[] = {vp,vp2,vp3,txtwin};
 
 //omy = sWi( {vp,vp2,vp3,txtwin} ,_Wworedrawall)
// BUG anonymous array as func argument
// sWi( {vp,vp2,vp3,txtwin} ,_Wworedrawall)

sWi( allwins ,_Wworedrawall)

//  now loop wait for message  and print


   xp = 0.1
   yp = 0.5
/*
//   plotline(vp2,0,0,1,1,"blue")

   plotline(vp2,0,0,1,1,"blue")
   plotline(vp2,0,1,1,0,"red")

   plotline(vp2,0.5,0,0.5,1,"green")
   for (rx  = 0 ; rx < 1.0; rx += 0.1) 
   plotline(vp2,rx,0,rx,1,"red")
   for (ry  = 0 ; ry < 1.0; ry += 0.1) 
   plotline(vp2,0,ry,1,ry,"red")

   setGwindow(vp2,_Wsave)

   setGwindow(vp4,_Wpixmapon,_Wredraw)
   plotline(vp4,0,0,1,1,"blue")
   plotline(vp4,0,1,1,0,"red")
   plotline(vp4,0.5,0,0.5,1,"green")

   setGwindow(vp2,_Wclipborder,"red")
   setGwindow(vp3,_Wclipborder,"blue")
   setGwindow(vp4,_Wsave)
*/


//---------------------------------------------------------------------
proc processKeys()
{
       switch (keyc) {

       case 'R':
       {
       sWo(symwo,_Wmove,0,2,_Wredraw)
       sWo(two,_Wtextr,"R RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'T':
       {
       sWo(symwo,_Wmove,0,-2,_Wredraw)
       sWo(two,_Wtextr,"T RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'Q':
       {
       sWo(symwo,_Wmove,-2,0,_Wredraw)
       sWo(two,_Wtextr,"Q RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'S':
       {
       sWo(symwo,_Wmove,2,0,_Wredraw)
       sWo(two,_Wtextr,"S RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'h':
       {
       sWo(symwo,_Whide)
       setgwindow(vp2,_Wredraw)
       }
       break;

       case 's':
       {
       sWo(symwo,_Wshow)
       setgwindow(vp2,_Wredraw)
       }
       break;

      }
}
//---------------------------------------------------------------------



void do_sketch()
{
   sWo(bsketchwo,_Wclear,_Wclearclip,_Wclipborder,_Wplotline,0.1,0.1,0.8,yp,RED_,_WEO)
   sWo(bsketchwo,_Wplotline,0.1,yp,0.8,0.1,"blue")
   axnum(bsketchwo,1)
   axnum(bsketchwo,2)

   sWo(grwo,_Wclearclip,_Wclipborder,_Wplotline,xp,0.1,0.5,0.5,GREEN_,_WEO)
   sWo(grwo,_Wplotline,xp,0.5,0.5,0.1,"black")

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

void FRUIT()
{

  <<"want a fruit?\n"

}


void BOATS()
{

  <<"want to sail a boat?\n"

}





void QUIT()
{
 exitgs();
 <<"kill xgs now exit!\n";
  exit()

}

void tb_q()
{
<<"expecting sig1 signal\n";
}

////////////////////////////////////

#include "gevent" ;   // our Gevent variable - holds last message
                            // could use another or an array to compare events

sWi( allwins ,_Wredraw)

   while (1) {

      eventWait();

      if (_ekeyw _W= "EXIT_ON_WIN_INTRP") {
<<"have win interup -- exiting!\n"
      break;
      }

      sWo(two,_Wtexthue,BLACK_,_Wclear,_Wtextr,"$_ekeyw",-0.9,0,_WEO)
/*
      if (_ename == "PRESS") {
	    <<"%V $_ewoname \n";

 if (_ewoname != "") {
            <<"calling function via woname $_ewoname !\n"
            $_ewoname()
            continue;
        }

       }
*/
  }


<<" killing xgm $Xgm_pid \n";
// sendsig(Xgm_pid, 12);


 exitgs();
 <<"kill xgs now exit!\n";
 exit();
 







////////////////////   TBD -- FIX //////////////////////

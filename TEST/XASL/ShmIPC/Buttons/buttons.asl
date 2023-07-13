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

#define ASL 1

Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"
  }

//ask=iread("wait?")

    rsig=checkTerm();
    <<"%V$rsig \n";

    txtwin = cWi("Info_text_window")


    sWi(_WOID,txtwin,_WPIXMAP,OFF_,_WDRAW,ON_,_WSAVE,ON_,_WBHUE,WHITE_,_WSTICKY,0N_)

    vp = cWi("Buttons1")



    sWi(_WOID,vp,_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_,_WBHUE,WHITE_)

    sWi(_WOID,vp,_WCLIP,wbox(0.1,0.2,0.9,0.9))

    vp2 = cWi("Buttons2")



    sWi(_WOID,vp2,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_)

    sWi(_WOID,vp2,_WCLIP,0.1,0.2,0.9,0.9)

     vp3 = cWi("Buttons3")  

    sWi(_WOID,vp3,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_)

    sWi(_WOID,vp3,_WCLIP,wbox(0.1,0.2,0.9,0.9))


       int fswins[] =  {txtwin,vp,vp2,vp3,-1};

//       wrctile( {txtwin,vp,vp2,vp3}, 0.05,0.05,0.95,0.95, 2, 2,-1,0) // tile windows in 2,2 matrix on  screen zero
       wrctile( fswins, 0.05,0.05,0.95,0.95, 2, 2,-1,2) // tile windows in 2,2 matrix on  current screen 
       for(i = 0; i < 10; i++) {
       if (fswins[i] < 0) {
            break
       }
      sWi(_WOID, fswins[i], _Wredraw,ON_)

       }

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

 two=cWo(txtwin,WO_TEXT_)

 sWo(_WOID,two,_Wname,"Text",_WVALUE,"howdy",_Wcolor,ORANGE_,_Wresize,wbox(0.1,0.1,0.9,0.9))

 sWo(_WOID,two,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_,_Wredraw)
 sWo(_WOID,two,_WSCALES,wbox(-1,-1,1,1))
 sWo(_WOID,two,_Whelp," Mouse & Key Info ")

 gwo=cWo(vp,WO_BV_)

 sWo(_WOID,gwo,_Wname,"ColorTeal",_Wcolor,GREEN_,_Wresize,wbox(bx,by,bX,bY))
 
 sWo(_WOID,gwo,_Wborder,_Wdrawon,_Wclipborder,_Wfonthue,RED_,_WVALUE,"color is teal",_WSTYLE,SVB_)
 sWo(_WOID,gwo,_Wbhue,TEAL_,_Wclipbhue,"skyblue",_Wredraw )

 bY = by - ypad
 by = bY - yht
 


 hwo=cWo(vp,WO_ONOFF_)

 sWo(_WOID,hwo,_Wname,"ENGINE",_WVALUE,"ON",_Wcolor,RED_,_Wresize,wbox(bx,by,bX,bY))

 sWo(_WOID,hwo,_Wborder,_Wdrawon,_Wclipborder,_Wfonthue,WHITE_, _WSTYLE,SVR_)
 sWo(_WOID,hwo,_Wfhue,LILAC_,_Wbhue,BLUE_,_Wclipbhue,MAGENTA_);


 // GetValue after entering text
 gvwo=cWo(vp,WO_BV_)
 sWo(_WOID,gvwo,_Wname,"GMYVAL",_WVALUE,0,_Wcolor,GREEN_,_Wresize,wbox(0.5,by,0.9,bY))
 
 sWo(_WOID,gvwo,_WBORDER,_WDRAWON,_WCLIPBORDER,_WFONTHUE,BLACK_, _WSTYLE,SVR_)
 sWo(_WOID,gvwo,_Wbhue,WHITE_,_Wclipbhue,RED_,_Wfunc,"inputValue",_Wmessage,1)


 bY = by - ypad
 by = bY - yht

 lwo=cWo(vp,WO_ONOFF_)

 sWo(_WOID,lwo,_Wname,"PLAY",_WVALUE,"ON",_Wcolor,RED_,_Wresize,wbox(bx,by,bX*0.5,bY))
 sWo(_WOID,lwo,_Wfonthue,WHITE_, _Wstyle,SVB_, _Wredraw,ON_)
 sWo(_WOID,lwo,_Wfhue,TEAL_,_Wclipbhue,PINK_)


<<"%V$two $hwo $gwo $gvwo $lwo\n"

 bY = 0.95
 by = bY - yht

 rwo=cWo(vp2,WO_BS_)
 
 sWo(_WOID,rwo,_Wname,"FRUIT",_Wcolor,YELLOW_,_Wresize,wbox(bx,by,bX,bY))
 sWo(_WOID,rwo,_WCSV,"mango,cherry,apple,banana,orange,peach,pear,lime,lemon");

 sWo(_WOID,rwo,_WFONTHUE,"red",_WSTYLE,SVR_, _Wredraw )
 sWo(_WOID,rwo,_Wfhue,ORANGE_,_Wclipbhue,"steelblue")

 boatwo=cWo(vp3,WO_BS_)
 sWo(_WOID,boatwo,_Wname,"BOATS",_Wcolor,YELLOW_,_Wresize,wbox(bx,by,bX,bY));
 sWo(_WOID,boatwo,_WCSV,"sloop,yacht,catamaran,cruiser,trawler,ketch");
 sWo(_WOID,boatwo,_WFONTHUE,RED_,_WSTYLE,SVR_, _Wredraw,ON_);
 sWo(_WOID,boatwo,_Whelp," click to choose a boat ");

 bY = by - ypad
 by = bY - yht

<<"%V$boatwo \n"

 bsketchwo=cWo(vp3,WO_GRAPH_)
 sWo(_WOID,bsketchwo,_Wname,"sketch",_Wcolor,YELLOW_,_Wresize,wbox(bx,0.1,0.9,bY))
 sWo(_WOID,bsketchwo,_WBORDER,ON_,_WDRAW,ON_,_WCLIPBORDER,ON_,_WFONTHUE,"red", _Wredraw,ON_ )
 sWo(_WOID,bsketchwo,_Wclip,wbox(0.1,0.15,0.95,0.85),_Wbhue,CYAN_)
 sWo(_WOID,bsketchwo,_WSCALES,wbox(-1,-1,1,1))

<<"%V$bsketchwo \n"


 grwo=cWo(vp2,WO_GRAPH_)

 sWo(_WOID,grwo,_Wname,"pic",_Wcolor,YELLOW_,_Wresize,wbox(bx,by,bX,bY))
 sWo(_WOID,grwo,_WFONTHUE,RED_, _Wredraw,ON_ )
 sWo(_WOID,grwo,_WSCALES,wbox(0,0,1,1))

<<"%V$grwo \n"

 bY = by - ypad
 by = bY - yht


 qwo=cWo(vp2,WO_BN_)
 sWo(_WOID,qwo,_Wname,"QUIT",_WVALUE,"QUIT",_Wcolor,MAGENTA_,_Wresize,wbox(bx,by,bX,bY))
 sWo(_WOID,qwo,_Whelp," click to quit",_WEO)
 sWo(_WOID,qwo, _WFONTHUE,BLUE_, _Wredraw ,ON_)



#include "tbqrd";

titleButtonsQRD(vp);


 int allwins[] = {vp,vp2,vp3,txtwin,-1};
 
 //omy = sWi( {vp,vp2,vp3,txtwin} ,_Wworedrawall)
// BUG anonymous array as func argument
// sWi( {vp,vp2,vp3,txtwin} ,_Wworedrawall)

  sWi( allwins ,_WWOREDRAWALL,ON_)

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
void processKeys()
{

<<" key $_GEV_keyc \n"
       switch (_GEV_keyc) {

       case 'R':
       {
       sWo(_WOID,symwo,_Wmove,wpt(0,2),_Wredraw)
       sWo(_WOID,two,_Wtextr,"R RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'T':
       {
       sWo(_WOID,symwo,_Wmove,wpt(0,-2),_Wredraw)
       sWo(_WOID,two,_Wtextr,"T RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'Q':
       {
       sWo(_WOID,symwo,_Wmove,wpt(-2,0),_Wredraw)
       sWo(_WOID,two,_Wtextr,"Q RMOVE -2 ",0.1,0.2)
       }
       break;

       case 'S':
       {
       sWo(_WOID,symwo,_Wmove,wpt(2,0,)_Wredraw)
       sWo(_WOID,two,_Wtextr,"S RMOVE 2 ",0.1,0.2)
       }
       break;

       case 'h':
       {
       sWo(_WOID,symwo,_Whide,ON_)
       setgwindow(vp2,_Wredraw)
       }
       break;

       case 's':
       {
       sWo(_WOID,symwo,_Wshow,ON_)
       setgwindow(vp2,_Wredraw)
       }
       break;

      }
}
//---------------------------------------------------------------------



void do_sketch()
{
   sWo(_WOID,bsketchwo,_Wclear,ON_,_Wplotline,wbox(0.1,0.1,0.8,yp,RED_))
   sWo(_WOID,bsketchwo,_Wplotline,wbox(0.1,yp,0.8,0.1,BLUE_))
   axnum(bsketchwo,1)
   axnum(bsketchwo,2)

   sWo(_WOID,grwo,_Wclearclip,ON_,_Wclipborder,ON_,_Wplotline,wbox(xp,0.1,0.5,0.5,GREEN_))
   sWo(_WOID,grwo,_Wplotline,wbox(xp,0.5,0.5,0.1,BLACK_))

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

#include "gevent.asl" ;   // our Gevent variable - holds last message
                            // could use another or an array to compare events

//sWi( allwins ,_Wredraw,ON_)

   while (1) {

      eventWait();

      if (_GEV_ekeyw= "EXIT_ON_WIN_INTRP") {
<<"have win interup -- exiting!\n"
      break;
      }

      sWo(_WOID,two,_Wtexthue,BLACK_,_Wclear,ON_)

      Textr(two, "$_GEV_keyw $_GEV_woname $_GEV_button ",-0.9,0);

     b = getEventButton()
      
      Textr(two, "$b ",-0.9,0.5);

      processKeys()

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

/* 
 *  @script cursor.asl                                                        
 * 
 *  @comment test cursors
 *  @release Carbon                                                           
 *  @vers 1.2 He Helium [asl 6.67 : C Ho]                                     
 *  @date 02/21/2026 19:39:29                                                 
 *  @cdate Wed Feb 6 15:00:37 2019 
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 




#include "debug.asl"
#include "hv.asl"

Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"

 }

    rsig=checkTerm();


    vp = cWi("Cursors")

<<"%V$vp \n"

    sWi(_woid,vp,_wpixmap,ON_,_wdraw,ON_,_wsave,ON_,_wbhue,WHITE_)

    sWi(_woid,vp,_wclip,wbox(0.05,0.1,0.95,0.95))

    sWi(_woid,vp,_wscales,wbox(0.0,0.0,1.0,1.0),_wsavesales,0)

    gwo=cWo(vp,WO_BV_,)
    sWo(_woid,gwo,_wtitle,"Cursors",_wcolor,GREEN_,_wresize,wbox(0.2,0.1,0.9,0.9));

    sWo(_woid,gwo,_wclip,wbox(0.1,0.1,0.9,0.9),_wscales,wbox(-10.0,-10.0,10,10),_wsavescales,0);



   timwo= cWo(vp,WO_BV_);

   sWo(_woid,timwo,_wname,"TIME",_wcolor,WHITE_,_wstyle,SVB_,_wdraw,ON_,_wpixmap,ON);

   bpmwo= cWo(vp,WO_BV_);

   sWo(_woid,bpmwo, _wname,"BPM",_wcolor,GREEN_,_wfonthue,RED_,_wstyle,SVB_);

   elevwo= cWo(vp,WO_BV_);

   sWo(_woid,elevwo,_wname,"ELEV",_wcolor,RED_,_wfonthue,BLACK_,_wdraw,ON_,_wstyle,SVB_);

   spdwo= cWo(vp,WO_BV_);

   sWo(_woid,spdwo,_wname,"SPD",_wcolor,BLUE_,_wfonthue,BLACK_,_wstyle,SVB_);

   distwo= cWo(vp,WO_BV_);

   sWo(_woid,distwo,_wname,"DIST",_wcolor,BLUE_,_wfonthue,BLACK_,_wdraw,ON_,_wstyle,SVB_,_wredraw,ON_);

  int measwos[] = {timwo, distwo, elevwo, bpmwo, spdwo,-1 };

   wovtile(measwos,0.05,0.05,0.15,0.95,0.02);


#include "tbqrd";

 titleButtonsQRD(vp);
 titleVers();
 
 sWi(_woid,vp,_wredraw,ON_)
  sWo(_woid,gwo,_wredraw,ON_)


 mousecursor(vp,"spider",0.5,0.1)

#include "wevent.asl" ;

curs_id = 34

 while (1) {


   eventWait();

<<"%V $curs_id $ewoid_ $ewoname_ $etype_ $ebutton_ $erx_ $ery_\n"
  curs_id++;
  
   if (ekeyw_ == "EXIT_ON_WIN_INTRP") {
<<"have win interup -- exiting!\n"
      break;
   }


  <<"mousecursor $curs_id\n"
    mousecursor(vp,curs_id,0.5,0.5);
sWo(_woid,gwo,_wredraw,ON_)
   //
 }


//    Cursor does not stick

exit()
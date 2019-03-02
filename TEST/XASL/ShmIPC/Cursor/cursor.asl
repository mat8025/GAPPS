//%*********************************************** 
//*  @script cursor.asl 
//* 
//*  @comment test cursors 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Wed Feb  6 15:00:37 2019 
//*  @cdate Wed Feb  6 15:00:37 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



include "debug.asl"
include "hv.asl"

Graphic = checkGWM()

  if (!Graphic) {
    Xgm_pid = spawnGWM()
<<"xgs pid ? $Xgm_pid \n"

}

    rsig=checkTerm();


    vp = cWi(@title,"Cursors")

<<"%V$vp \n"

    sWi(vp,@pixmapon,@drawon,@save,@bhue,"white")

    sWi(vp,@clip,0.05,0.1,0.95,0.95)

    sWi(vp,@scales,0.0,0.0,1.0,1.0)

 gwo=cWo(vp,@BV,@name,"Cursors",@color,GREEN_,@resize,0.1,0.1,0.9,0.9);

 sWo(gwo,@clip,0.1,0.1,0.9,0.9,@scales,0.0,0.0,1.0,1.0);

include "tbqrd";

 titleButtonsQRD(vp);
 titleVers();
 
 sWi(vp,@redraw)


 mousecursor("spider",vp,0.5,0.1)

include "gevent" ;

curs_id = 34


 while (1) {


   eventWait();

<<"%V$curs_id \n"
  curs_id++;
  
   if (_ekeyw @= "EXIT_ON_WIN_INTRP") {
<<"have win interup -- exiting!\n"
      break;
   }

/{/*
  if ((curs_id % 2) == 0) {
   <<"mousecursor spider\n"
   mousecursor("spider",-1)
  }
/}*/

  <<"mousecursor $curs_id\n"
    mousecursor(curs_id,vp,0.5,0.5);


 }

exit()
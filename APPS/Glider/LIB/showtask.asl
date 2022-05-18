/* 
 *  @script showtask.asl 
 * 
 *  @comment show/create glider task 
 *  @release CARBON 
 *  @vers 3.4 Be Beryllium [asl 6.3.45 C-Li-Rh] 
 *  @date 07/30/2021 09:02:34 
 *  @cdate 7/21/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                         
///
/// "$Id: showtask.asl,v 1.5 1997/07/21 15:01:08 mark Exp mark $"
///


#define ASL 1
#define ASL_DB 0
#define GT_DB   0
#define CPP 0



Str Use_= "  view and select turnpts  create read tasks ";

#include "debug"

//Str Qans_ = "xyz";

if (_dblevel >0) {
    debugON()
    <<"$Use_\n"   
}

chkIn(_dblevel);

#include "hv.asl"



 ignoreErrors(-1);
//setMaxICerrors(-1) // ignore - overruns etc

//#define DBG <<
#define DBG ~!


uplegs = 0;  // needed?


#include "conv.asl"

#include "tpclass.asl"

#include "ootlib"

#include "graphic_glide.asl"




int WH[100][2];

int main_chk =1;
int Maxtaskpts = 13;

//======================================//
void drawTrace()
{
     if (Have_igc) {
         sWo(mapwo,_WSCALES, wbox(LongW, LatS, LongE, LatN),_WEO );
	 
         sWo(mapwo,_WCLEARPIXMAP);
         sWo(vvwo,_WCLEARPIXMAP);

         
          DrawMap(mapwo);
	  
  	 if (Ntpts > 0) {
            sWo(vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, Max_ele + 500),_WEO )
              dGl(igc_tgl);
	    sWo(vvwo,_WCLEARPIXMAP);
	      dGl(igc_vgl);
            sWo(mapwo,_WSHOWPIXMAP,_WCLIPBORDER);
            sWo(vvwo,_WSHOWPIXMAP,_WCLIPBORDER);
	 }
	sWo(mapwo,_WSHOWPIXMAP,_WCLIPBORDER);

      }
}

//======================================//
///////////////////// SETUP GRAPHICS ///////////////////////////


/////////////  Arrays : Globals //////////////

LatS= 37.5;

LatN = 42.0;

LongW= 108.5;

LongE= 104.8;

 MidLong = (LongW - LongE)/2.0 + LongE;
 MidLat = (LatN - LatS)/2.0 + LatS;

float LoD = 35.0;

TaskType = "TRI"; 

int Nlegs = 3;


int Taskpts[20];

Turnpt  Wtp[300]; //

Tleg  Wleg[20];


Record RX[10];


/// open turnpoint file lat,long 

int use_cup = 1;



if (use_cup) {

    tp_file = "CUP/bbrief.cup"

}
else {

  tp_file = "DAT/turnptsA.dat"  // open turnpoint file TA airports

  if (tp_file == "") {
    tp_file = "DAT/turnptsSM.dat"  // open turnpoint file 
   }
}


  int AFH =  ofr(tp_file);

 if (AFH == -1) {
  <<" can't open file   \n";
    exit();
 }

if (use_cup) {

  Nrecs=RX.readRecord(AFH,_RDEL,44,_RLAST);  // no back ptr to Siv?
  //RF= readRecord(A,@del,',',@comment,"#");
  
}
else {
// RF= readRecord(A);
}

  cf(AFH);


  Nrecs = Caz(RX);
  Ncols = Caz(RX,1);

<<"num of records $Nrecs  num cols $Ncols\n";

/*
for (i= 0; i <30 ; i++) {
<<"$i $RX[i] \n"
}
*/

WH=searchRecord(RX,"AngelFire",0,0)

<<"AngelFire @ $WH \n"
  WH.pinfo();


/*
index = WH[0][0]
<<"%V $index\n"

place = RX[index][0]
lat = RX[index][2]
longv = RX[WH[0][0]][3]

<<"$RX[index][0] \n"
<<"$RX[index][2] \n"
<<"%V $place $lat $longv\n"


<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
*/

main_chk++;

//ans=query("??");

//================================//
 svar Wval;


  AFH =ofr(tp_file)
  

  if (AFH == -1) {
    exit(-1," can't find turnpts file \n");
  }




 

  Ntp = 0;


  if (!use_cup) {
         C=readline(AFH);
	 C=readline(AFH);
   }

int c1 = 0;
long before;
long after;

int KAFH = AFH;

while (1) {



   before = ftell(AFH);
    c1 = fgetc(AFH,-1);
    after = ftell(AFH);


//<<"%V $AFH $Ntp $before $c1 $after\n"

    if (use_cup) {
    

       nwr = Wval.ReadWords(AFH,0,',')

       //<<"%V $nwr  $AFH $Wval\n";

        main_chk++;

	       
    }
    else {
            nwr = Wval.ReadWords(AFH)
    }
            if (nwr == -1) {
	      break;
            }
	    
    if (nwr > 6) {



     if ( c1 != '#') {
     
      if (use_cup) {


         Wtp[Ntp].TPCUPset(Wval);
	 

         main_chk++;
      }
      else {
         Wtp[Ntp].TPset(Wval);
      }


             Ntp++;
//<<"$Ntp $AFH \n $Wval \n"

        }
      }


   if (AFH != KAFH) {
<<"fix file handle $AFH != $KAFH\n";
    AFH = KAFH;

   }

    if (Ntp >= 500)
       break;
}

<<" Read $Ntp turnpts \n"

 if (Ntp < 3) {
  exit("BAD turnpts");
 }
////////////////////////////////////



//ans=query("? $main_chk");

// Nlegs = Ntp -1;
//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;


int is_an_airport = 0;


main_chk++;


/*
    for (k = 1 ; k <=  5 ; k++) {

        is_an_airport = Wtp[k].is_airport;
if (is_an_airport) {
        mlab = Wtp[k].Place;

<<"TP $k $mlab  $is_an_airport\n"
//       if (mlab == "Jamestown") {
//         <<"SF\n"
//       }
}

   }
*/

main_chk++;



/////////////////// TASK DEF ////////////





Task_update =1
Units = "KM"

int tp_wo[20];
int gtp_wo[20];
int ltp_wo[20];




char MS[240];
char Word[128];
char Long[128];
num_tpts = 700;

float R[10];


    Have_igc = 0;



//  Read in a Task via command line

float min_lat;
float max_lat;
float longW =0.0;



//////////////// PARSE COMMAND LINE ARGS ///////////////////////

long posn = 0;
Svar Tskval;
Str targ;
Str igc_fname ="xyz";
na = argc()
 <<"na $na\n";
 int ai =0;


main_chk++;

// while (AnotherArg()) {  // TBC 


 while (1) {

//<<"$ai $_clarg[ai]\n"

          ai++;
          targ = getArgStr()
//<<"%V $ai $targ \n"	  
	  if (targ == "task") {
            TaskType = GetArgStr();
	    ai++;
//	    <<"set %V $TaskType \n"
          }
      else if (targ == "igc") {
           igc_fname = getArgStr();
	   ai++;
	   
        Have_igc = 1;
  //      <<"IGC file $igc_fname \n"

       if (issin(igc_fname,"igc")) {
        Have_igc = 1;

       }
       
      }
          else {
	  if (slen(targ) > 1) {
          WH=searchRecord(RX,targ,0,0)
	 // <<"%V $targ $WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RX[index];

//<<"$ttp \n"

          Taskpts[Ntaskpts] = index;
<<" $Ntaskpts found $targ  $index  $Taskpts[Ntaskpts]\n"
           Ntaskpts++;

           }
          else {
<<"Warning can't find $targ as a TP - skipping \n"

           }
       }
//<<" $Ntaskpts  \n"


          }
	  
      if (ai >= na) {
               break;
      }
}
//======================================//

//ans=query("%V $Ntaskpts\n");

//exit(-1);


// home field
// set a default task
if (Ntaskpts == -1) {

svar targ_list = {"eldorado","casper","rangely","eldorado"}
    sz= Caz(targ_list);
<<"$sz : $targ_list \n"

//<<" $targ_list[1] \n"
        targ = targ_list[2]
//<<" $targ \n"

    for (i= 0; i < sz; i++) {

       targ = targ_list[i]
       //<<"$i  <|$targ|> \n"
          WH=searchRecord(RX,targ,0,0)
	 // <<"$WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RX[index];
          //<<"$ttp \n"
          Taskpts[Ntaskpts] = index;

           <<"%V $index $Taskpts[Ntaskpts] \n";
           Ntaskpts++;
          }
    }
}
//======================================//

//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"

main_chk++;

Nlegs = Ntaskpts;
                 listTaskPts();		 
//<<"%V $Ntaskpts \n"

//Taskpts.pinfo()

   for (k= 0; k < Ntaskpts; k++) {
       index = Taskpts[k];
<<"%V $k $index $Taskpts[k] \n";
   }

//   for (k= 1; k < 15; k++) {
//             Wtp[k].Print()
//    }
<<"//////////\n"
//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;
//Taskpts.pinfo()


<<" Now print task\n"
//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;



      for (i = 0; i < Ntaskpts ; i++) {
         MSL = Wleg[i].msl;
       <<"Stat $i $MSL $Wleg[i].dist   $Wleg[i].fga\n"
      }



 TaskDist();


/**
<<"after include  proc \n"

   for (k= 0; k < Ntaskpts; k++) {
       index = Taskpts[k];
<<"%V $k $index $Taskpts[k] \n";
   }
*/


//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;

<<"%V $Have_igc\n"



  if (Have_igc) {
      Igcfn = ofr(igc_fname);
      if (Igcfn != -1) {
       processIGC();
      }
  }


       //      Wtp[3].Print()


#include "showtask_scrn"

Str place;




//===========================================//
 if (Ntaskpts > 1) {
  int alt;
  
  for (i = 0; i < Ntaskpts ; i++) {

        k= Taskpts[i];
	
        place =   Wtp[k].Place;
	
        alt = Wtp[k].Alt;  
      
      <<"$i   $place  $tpwo[i]\n"


        woSetValue(tpwo[i],place);
       
        sWo(tpwo[i],_WUPDATE,_WREDRAW);  
       // woSetValue(tpwo[i],k,1)
       // display alt?
//	woSetValue(tpwo[i],alt,1)   
       if (i >= MaxSelTps) {
         <<"$i > $MaxSelTps \n"
          break;
        }
   }

<<"%V $i $Ntaskpts \n"

 }
//======================================//



    sWo(tpwos,_Wredraw);
    sWo(tpwo[1],_Wredraw);
    sWo(tpwo[2],_Wredraw);


     c= "EXIT"

     sWi(vp,_WREDRAW); // need a redraw proc for app


    sWo(mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN),_WEO );

//  set up the IGC track for plot
    igc_tgl = cGl(mapwo);
    sGl(igc_tgl, _GLTXY,IGCLONG,IGCLAT,_GLHUE,BLUE_,_GLEO);

    igc_vgl = cGl(vvwo);
    sGl(igc_vgl, _GLTY,IGCELE,_GLHUE,RED_,_GLEO);



   if (Ntpts > 0) {
    dGl(igc_tgl);  // plot the igc track -- if supplied
    sWo(vvwo, _WSCALES, wbox(0, 0, Ntpts, Max_ele +500),_WEO)
    dGl(igc_vgl);  // plot the igc climb -- if supplied
   }

# main


#include  "gevent";

 Gevent gev;

int dindex;
int Witp = 0;
int drawit = 0;
msgv = "";

float d_ll = Margin;

Str wcltpt="XY";

  DBG"%V $vvwo $Ntpts\n"
 // sWo(vvwo,@clear,@clearpixmap,@savepixmap,@clipborder);
 // sWo(vvwo, _Wscales, 0, 0, Ntpts, Max_ele +500);

  DBG"%V $LongW \n"
  DBG"%V $LongE \n"

  TaskDist();


   if (uplegs) {
    updateLegs();
   }

  sWo(tdwo,_WVALUE,"$totalK km",_WUPDATE);
 
  drawTrace();

  zoom_to_task(mapwo,1)

  sWo(mapwo,_WSCALES,wbox( LongW, LatS, LongE, LatN),_WEO );
  sWo(TASK_wo,_WVALUE,TaskType,_WREDRAW);

  DrawMap(mapwo);
//ans=query("see map?");

  drawTask(mapwo,"green");
  drawTrace();

int ekey;
Str WoName = "xyz";
Str wc = "Salida";
int wtpwo;
Str wway="P";
int ok =0;

//ans=query("listTask?");
<<"%V $Ntaskpts\n"


            showTaskPts();
<<"now list them \n";		 
                 listTaskPts();
		 

  while (1) {
 //   zoom_to_task(mapwo,1)
    ok = 0;
    drawit = 1;
    Task_update =0
  
    //eventWait();
    emsg =gev.eventWait();
    ekey = gev.getEventKey();
    
    WoName = gev.getEventWoName();

<<"%V $ekey $WoName \n"

    //Text(vptxt," $_ekeyw   ",0,0.05,1)

       if ( gev.getEventKey() >= 65) {
       
       d_ll = (LatN-LatS)/ 10.0 ;
<<"%V $LongW $LatS $LongE $LatN   $d_ll\n"


       if (ekey == 'Q') {
           LongW += d_ll
           LongE += d_ll
       }

       if (ekey == 'S') {
           LongW -= d_ll
           LongE -= d_ll
       }

       if (ekey == 'R') {
           LatN += d_ll
           LatS += d_ll
       }

       if (ekey == 'T') {
           LatN -= d_ll
           LatS -= d_ll
       }


       if (ekey == 'X') {
     //  <<"expand \n"
           LatN += d_ll
           LatS -= d_ll
           LongW += d_ll
           LongE -= d_ll
       }

       if (ekey == 'x') {
       <<"Zoom IN\n"
           LatN -= (d_ll * 0.9)
           LatS += (d_ll * 0.9)
           LongW -= (d_ll * 0.9)
           LongE += (d_ll * 0.9)
       }
              drawit = 1;
<<"%V $LongW $LatS $LongE $LatN\n"
 sWo(mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WEO);

      }

       else if (WoName == "_Start_") {
             Task_update =1
             sWo(_ewoid, _WCXOR)
              wc=choice_menu("STP.m")
            //   showTaskPts();	
            if (wc == "M") { // replace
	    
             wtp = PickaTP(0)
             if (wtp >= 0) {
                wcltpt = Wtp[wtp].Place;
                sWo(tpwo[0],_WVALUE,wcltpt,_WREDRAW)
             }

            }
	    else {
                Atarg = wc;
                wtp=PickTP(wc,0);
		if (wtp != -1) {
                  wcltpt = Wtp[wtp].Place;
                  sWo(tpwo[0],_WVALUE,wcltpt,_WREDRAW);
                }
	     sWo(tpwo[0], _WCXOR)
          }
	  
       }

       else if (scmp(WoName,"_TP",3)) {
       
             Task_update =1;
             np = spat(WoName,"_TP",1)
             np = spat(np,"_",-1)

              Witp = atoi(np);
              wtpwo = tpwo[Witp]

            // sWo(wtpwo, _WCXOR);
	     
	     gflush();

             wc = choice_menu("TP.m")
<<"menu choice  name or action  %V $wc\n";

           //  showTaskPts();
	       
             if (wc == "R") { // replace

//<<"$wc  REPLACE\n";
printf("REPLACE TP \n");
               wc=choice_menu("CTP.m");

             if (wc == "M") { // replace
	    
             wtp = PickaTP(Witp)
             if (wtp >= 0) {
                wcltpt = Wtp[wtp].Place;
                sWo(tpwo[0],_WVALUE,wcltpt,_WREDRAW)
             }

            }
	    else {
                Atarg = wc;
                wtp=PickTP(wc,Witp);
		if (wtp != -1) {
                  wcltpt = Wtp[wtp].Place;
                  sWo(tpwo[0],_WVALUE,wcltpt,_WREDRAW);
                }
	     sWo(tpwo[0], _WCXOR)
          }

             }
             else if (wc == "D") {
                <<"delete and move lower TPs up!\n"
               delete_tp(Witp); // 
             }

             else if (wc == "I") {
	          wc=choice_menu("CTP.m")
printf("choose how? %s\n",vtoa(wc));		
               if (wc == M) {
                  insert_tp(Witp);
		 }
		 else {
                 insert_name_tp(Witp);
		 }
             }
             else if (wc == "A")  {  // this is add

//                              wc=choice_menu("CTP.m")
//printf("choose how? %s\n",wc.cptr());
//printf("choose how? %s\n",vtoa(wc));		
		 <<"getting name $wc\n"
		  ok=PickViaName(Witp);
		  if (ok) {
                   <<"added TP\n"
		    Ntaskpts++;
                  }
		  DrawMap(mapwo);
             }
             else if (wc == "P")  {  // this is add


                  insert_tp(Witp);
                  Ntaskpts++;
		  DrawMap(mapwo);
             }	     
             
             Task_update =1;
                 sWo(tpwos,_WREDRAW);
                 sWo(legwos,_WREDRAW,_WEO);		 
                // sWo(wtpwo,_Wcxor);
                 showTaskPts();

		 
       }
       else if (WoName == "ALT") {

         drawit = 0;
         dindex = rint(_erx)

<<" index $_erx, alt $_ery  $dindex $IGCELE[dindex] $IGCLAT[dindex] $IGCLONG[dindex] \n"
         symx = IGCLONG[dindex]
	 symy = IGCLAT[dindex]
	 
	 <<"$symx $symy $mapwo \n"
	 
       
	 
	 swo(mapwo,_WCLEAR,_WCLEARCLIP,BLUE_,_WCLEARPIXMAP);
	 
	 plot(mapwo,_WSYMBOL,symx,symy, 11,2,RED_);

         plot(mapwo,_WCIRCLE,symx,symy, 0.01,GREEN_,1);
	 
	 swo(mapwo,_WSHOWPIXMAP);
	 
       }
       
       else if (WoName == "MAP") {

               drawit = 0;

               ntp = ClosestLand(_erx,_ery);

             if (ntp >= 0) {

               Wtp[ntp].Print()
               nval = Wtp[ntp].GetPlace()
	       
              <<" found %V $ntp $nval \n"
                Text(  vptxt," $ntp $nval   ",0,0.05,1)
                msl = Wtp[ntp].Alt;
                mkm = HowFar(_erx,_ery, Wtp[ntp].Longdeg, Wtp[ntp].Ladeg)
                ght = (mkm * km_to_feet) / LoD;
                sa = msl + ght + 2000;
          	sWo(sawo,_WVALUE,"$nval %5.1f $msl $mkm $sa",_WREDRAW)

             }

        }

       else if (WoName == "TaskMenu") {

             //task_menu(mapwo)
    //          read_task()
  task_file = "XXX";
  task_file = navi_w("TASK_File","task file?",task_file,".tsk","TASKS")
  <<"%V$task_file\n"
  
             readTaskFile (task_file);
	     
<<"after readTaskFile (task_file) $SetWoT \n";

         setWoTask()
<<"done  setWoTask() $SetWoT \n"
             Task_update =1;

       }
       
       else if ( _ekeyw == "Menu") {
           <<" task type is $_ekeyw \n"
           TaskType = _ekeyw;
           <<" Set %V$TaskType \n"
       }


        if (drawit || Task_update) {
	      DrawMap(mapwo)
  	      drawTrace();
              drawTask(mapwo,"green");
        }

     if ( Task_update ) {

<<"main %V $_scope $_cmfnest $_proc $_pnest\n"
     
      TaskDist();

      sWo(tdwo,_WVALUE,"$totalK km",_WUPDATE);
      Task_update = 0;

      for (i = 0; i < Ntaskpts ; i++) {
         MSL = Wleg[i].msl;
       <<"Stat $i $MSL $Wleg[i].dist   $Wleg[i].fga\n"
      }


// scope  cmf_nest proc nest check ??
          <<"main %V $_scope $_cmfnest $_proc $_pnest\n"


      TaskStats();
          <<"main %V $_scope $_cmfnest $_proc $_pnest\n"


         if (uplegs) {
           updateLegs();
         }
      sWo(tpwos,_WREDRAW);
       sWo(legwos,_WREDRAW);		 
      }

     sWi(vp,_WREDRAW,_WEO);
    DrawMap(mapwo);
  }


exit_gs(1);
chkOut()
exit();

///

//////////////////////////// TBD ///////////////////////////////////////////
/*


 BUGS:  
        not showing all WOS -- title button


 Task definition : intial via CL  type{OB,TRI,SO, W, OLC}   tp1,tp2,tp3 ...

 Task definition : via WO click

 should show TP,TA info when click on map

 scroll map buttons


 ADD:

  readIGC - C++ function  done

  can we plot on top sectional image - where to get those?
  use cursors on time graph to zoom to map 

  button to switch to 3D projection (DEMS) already had that working once
  where is that code (tiles) 
 ?? what happed to viewterrain and elevation - magic carpet viewer??

  projection  --  square degrees - square map window --- conical??

  plot plane position as scroll in vvwo


  need task distance ---
  and task plotting to work


  request 300,500,1000 K triangles , W, OAR,  given start, first turn


  menus

*/









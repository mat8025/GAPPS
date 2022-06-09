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


#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "/home/mark/gasp-CARBON/include/compile.h"
#define PXS  <<
#endif

#if CPP
#include <iostream>

#include <ostream>

using namespace std;

#include "si.h"
#include "parse.h"
#include "codeblock.h"
#include "sproc.h"
#include "sclass.h"
#include "declare.h"
#include "gthread.h"
#include "paraex.h"
#include "scope.h"
#include "record.h"
#include "debug.h"

#include "uac.h"

#define PXS  cout<<

#endif



#if ASL
Str Use_= "  view and select turnpts  create read tasks ";

#include "debug"

//Str Qans_ = "xyz";

if (_dblevel >0) {
    debugON()
   // <<"$Use_\n"   
}

chkIn(_dblevel);

#include "hv.asl"

 ignoreErrors();
//setMaxICerrors(-1) // ignore - overruns etc

//#define DBG <<
#define DBG ~!

#endif

int uplegs = 0;  // needed?
int  Ntp = 0; //



// different behavior on earth versus neptune machines
// local var not inited cpp and referenced with being set!!

//#include "conv.asl"
#include "showtask_globals.asl"

#include "tpclass.asl"

#include "ootlib.asl"


Turnpt  Wtp[300]; //
Tleg  Wleg[20];

#include "graphic_glide.asl"

//int WH[100][2];
Mat  WH(INT_,100,2);  //rows expandable
int main_chk =1;
int Maxtaskpts = 13;
int i;

//======================================//

//======================================//
///////////////////// SETUP GRAPHICS ///////////////////////////


/// open turnpoint file lat,long

#if CPP

void
Uac::showTask(Svarg * sarg)  
{

int run_asl = runASL();
 cout <<"CPP  ASL?  " << run_asl << endl;

 Str a0  = sarg->getArgStr(0) ;

//a0.pinfo();
 Svar sa;

cout << " paras are:  "  << a0.cptr(0) << endl;
 sa.findWords(a0.cptr());

cout << " The glider Task turnpts and  parameters are:  "  << sa << endl;

cout << " para[0] is:  "  << sa.cptr(0) << endl;

cout << " para[1] is:  "  << sa.cptr(1) << endl;

//cout << " para[2] is:  "  << sa.cptr(2) << endl;
#endif

 int na;
 
#if ASL

 Svar sa;

// <<" na $_clargc \n"
 na = _clargc;
// <<" na $_clarg[1]  $_clarg[2] \n"
 Str wsa="mno";
 sa = _clarg;

<<"args are $sa \n"
<<"0 $sa[0] \n"
 wsa = sa.cptr(1);
<<"1 $sa[1] $wsa \n"

<<"2 $sa[2] \n"

#endif


Str tp_file;
int use_cup = 1;
int Nrecs;


if (use_cup) {

    tp_file = "CUP/bbrief.cup";

}
else {

  tp_file = "DAT/turnptsA.dat";  // open turnpoint file TA airports

  if (tp_file == "") {
    tp_file = "DAT/turnptsSM.dat" ; // open turnpoint file 
   }
   
}


  int AFH =  ofr(tp_file);

 if (AFH == -1) {
  printf(" can't open file   \n");
    exit(-1);
 }

if (use_cup) {
cout <<"SRX.readRecord\n";
   Nrecs=SRX.readRecord(AFH,_RDEL,44,_RLAST);  // no back ptr to Siv?
 
  // SRX=readRecord(AFH,_RDEL,44,_RLAST);  // no back ptr to Siv?
   
  //RF= readRecord(A,@del,',',@comment,"#");
  
}
else {
// RF= readRecord(A);
}

  cf(AFH);


//  Nrecs = Caz(SRX);
//  Ncols = Caz(SRX,1);

//<<"num of records $Nrecs  num cols $Ncols\n";


/*
for (i= 0; i <= 10 ; i++) {
<<"$i $SRX[i] \n"
}
*/

//WH=searchRecord(SRX,"AngelFire",0,0);

  r_index= SRX.findRecord("AngelFire",0,0);

  printf("AngelFire @ %d\n",r_index);








//ans=query("??");

//================================//
 Svar Wval;
 Str Cfr;

  AFH =ofr(tp_file);

  VCOUT(tp_file, AFH);

//ans=query("??","goon",__LINE__,__FILE__);

  if (AFH == -1) {
    printf(" can't find turnpts file \n");
    exit(-1);
    
  }
 




  if (!use_cup) {
         Cfr=readLine(AFH);
	 Cfr=readLine(AFH);
   }

int c1 = 0;
long before;
long after;

int KAFH = AFH;
int nwr;


while (1) {



    before = ftell(AFH);
    
    c1 = getNextC(AFH,-1);

    after = ftell(AFH);

  VCOUT(Ntp,before,c1,after);

printf(" $AFH %d $Ntp %d $before %d $c1 %c $after %d\n", AFH ,Ntp ,before ,c1 ,after);

//<<"%V $AFH $Ntp $before $c1 $after\n"

    if (use_cup) {

       nwr = Wval.readWords(AFH,0,',');

       //<<"%V $Ntp $nwr  $AFH $Wval\n";

printf("Ntp %d nwr %d  %s\n",Ntp,nwr,Wval.cptr(0));


	       
    }
    else {
            nwr = Wval.readWords(AFH);
    }
            if (nwr == -1) {
	      break;
            }
	    
    if (nwr > 6) {



     if ( c1 != '#') {
     
      if (use_cup) {


         Wtp[Ntp].TPCUPset(Wval);

      }
      else {
         Wtp[Ntp].TPset(Wval);
      }

//<<"$Ntp $AFH  $Wval \n"
             Ntp++;


        }
      }


   if (AFH != KAFH) {
//<<"fix file handle $AFH != $KAFH\n";
    AFH = KAFH;

   }

    if (Ntp >= 500)
       break;
}

printf(" Read $Ntp %d turnpts \n",Ntp);

 if (Ntp < 3) {
  exit("BAD turnpts");
 }
////////////////////////////////////



//ans=query("? $main_chk");

// Nlegs = Ntp -1;






#if CPP
  na = sa.getNarg();
#else
  na = _clargc;
#endif
 printf("na %d\n",na);

 int ai =0;




// while (AnotherArg()) {  // TBC 


 while (1) {

//<<"$ai $_clarg[ai]\n"

          ai++;

	  targ = sa.cptr(ai);
//<<"%V $sa[ai]  $ai $targ \n"

	  if (targ == "task") {
            TaskType = sa.cptr(ai);
	    ai++;
//	    <<"set %V $TaskType \n"
          }
          else if (targ == "igc") {
           ai++;
           igc_fname = sa.cptr(ai);


	   ai++;
	   
        Have_igc = 1;
//  <<"IGC file $igc_fname \n"

       if (issin(igc_fname,"igc")) {
        Have_igc = 1;

       }
       
      }
       else {
	  if (targ.slen() > 1) {
          r_index=SRX.findRecord(targ,0,0);
	 // <<"%V $targ $WH\n"

          if (r_index >=0) {

           ttp = SRX[r_index];

//<<"$ttp \n"

          Taskpts[Ntaskpts] = r_index;

PXS" $Ntaskpts found $targ  $r_index  $Taskpts[Ntaskpts]\n";

           Ntaskpts++;
#if ASL_DB	   
	   Taskpts.pinfo();
#endif

           }
          else {
printf("Warning can't find $targ as a TP - skipping \n");

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

//
    


// home field
// set a default task
if (Ntaskpts == -1) {

    //		    // dbt("WHELP %s\n",name);

//Svar targ_list[] = {"eldorado","casper","rangely","eldorado"};

  // Svar targ_list = {"eldorado","casper","rangely","eldorado"};

     Svar targ_list;
     targ_list.findCommaTokens("eldorado,casper,rangely,eldorado");


      int sz = targ_list.getSize();
//<<"$sz : $targ_list \n"

//<<" $targ_list[1] \n"
        targ = targ_list[2];
//<<" $targ \n"

    for (i= 0; i < sz; i++) {

       targ = targ_list[i];
       //<<"$i  <|$targ|> \n"
         r_index=SRX.findRecord(targ,0,0);

          if (r_index >=0) {
    //      ttp = SRX[r_index];
          //<<"$ttp \n"
          Taskpts[Ntaskpts] = r_index;

           //<<"%V $r_index $Taskpts[Ntaskpts] \n";
           Ntaskpts++;
          }
    }
}
//======================================//





Nlegs = Ntaskpts;

//Taskpts.pinfo()
int k;
   for (k= 0; k < Ntaskpts; k++) {
       r_index = Taskpts[k];
//<<"%V $k $r_index $Taskpts[k] \n";
   }

  for (k= 1; k < 15; k++) {
             Wtp[k].Print();
	     cval =  Wtp[k].Place;
	     
    }

//ans = query("see wtp");


//<<"//////////\n"




//Taskpts.pinfo()



//<<" Now print task\n"



      for (i = 0; i < Ntaskpts ; i++) {
         ST_msl = Wleg[i].msl;
      // <<"Stat $i $ST_msl $Wleg[i].dist   $Wleg[i].fga\n"
      }


printf(" Have_igc\n");



  if (Have_igc) {
      Igcfn = ofr(igc_fname);
      if (Igcfn != -1) {
       processIGC();
      }
  }


       //      Wtp[3].Print()


#include "showtask_scrn.asl"




Str place;


//ans=query("?1","hey",__LINE__);

//===========================================//
 if (Ntaskpts > 1) {
  int alt;
  
  for (i = 0; i < Ntaskpts ; i++) {

        k= Taskpts[i];
	
        place =   Wtp[k].Place;
	
        alt = Wtp[k].Alt;  
      
//      <<"$i $k  $place  $tpwo[i]\n"


        woSetValue(tpwo[i],place);
       
        sWo(tpwo[i],_WUPDATE,_WREDRAW,_WEO);  
       // woSetValue(tpwo[i],k,1)
       // display alt?
//	woSetValue(tpwo[i],alt,1)   
       if (i >= MaxSelTps) {
//         <<"$i > $MaxSelTps \n"
          break;
        }
   }

//<<"%V $i $Ntaskpts \n"

 }
//======================================//
//ans=query("?2","hey",__LINE__);


    sWo(tpwo,_WREDRAW);



     Str c= "EXIT";

     sWi(Vp,_WREDRAW); // need a redraw proc for app


    sWo(mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN),_WEO );



//  set up the IGC track for plot
    igc_tgl = cGl(mapwo);
    IGCLONG.pinfo();



   sGl(igc_tgl, _GLTXY , &IGCLONG, &IGCLAT,_GLEO);
    



    igc_vgl = cGl(vvwo);

    VCOUT(_GLTXY, _GLTY);
        VCOUT(igc_vgl, igc_tgl);
    
    sGl(igc_vgl, _GLTY , &IGCELE,_GLHUE, GREEN_, _GLEO);







   if (Ntpts > 0) {
    dGl(igc_tgl);  // plot the igc track -- if supplied
    sWo(vvwo, _WSCALES, wbox(0, 0, Ntpts, Max_ele +500),_WEO);
    dGl(igc_vgl);  // plot the igc climb -- if supplied
   }

   sWo(ZOOM_wo,_WREDRAW,_WEO);
   sWo(vptxt,_WREDRAW,_WEO);
   



#if CPP
#include  "gevent.h";
#else
#include  "gevent.asl";
#endif

 Gevent gev;




int dindex;

int drawit = 0;
Str msgv = "";

float d_ll = Margin;

Str wcltpt="XY";


  taskDist();


   if (uplegs) {
    updateLegs();
   }

 
  woSetValue(tdwo,totalK);
 sWo(tdwo,_WVALUE,_WUPDATE);



  drawTrace();

//  zoom_to_task(mapwo,1)

  sWo(mapwo,_WSCALES,wbox( LongW, LatS, LongE, LatN),_WEO );

  woSetValue(TASK_wo,TaskType);
  //sWo(TASK_wo,_WVALUE,TaskType,_WREDRAW);
  
  //sdb(2,"pline");
  
  DrawMap();
//ans=query("see map?");


  drawTrace();
  drawTask(mapwo,GREEN_);


//ans=query("listTask?");
//<<"%V $Ntaskpts\n"


            showTaskPts();

                 listTaskPts();
		 
   updateLegs();
   
  while (1) {
 //   zoom_to_task(mapwo,1)
    ok = 0;
    drawit = 0;
    Task_update =0;
  
    //eventWait();
    emsg =gev.eventWait();
    ekey = gev.getEventKey();
    gev.getEventRxy( &erx,&ery);

    WoName = gev.getEventWoName();
    Ev_button = gev.getEventButton();
    Ev_keyw = gev.getEventKeyWord();
#if ASL    
<<"%V $Ev_keyw $ekey $WoName \n"
#endif
    if (Ev_keyw == "REDRAW" || WoName == "REDRAW") {

       Task_update =1;
       
    }

    //Text(vptxt," $_ekeyw   ",0,0.05,1)

       if ( gev.getEventKey() >= 65) {
       
       d_ll = (LatN-LatS)/ 10.0 ;
//<<"%V $LongW $LatS $LongE $LatN   $d_ll\n"


       if (ekey == 'Q') {
           LongW += d_ll;
           LongE += d_ll;
	    drawit = 1;
       }

       if (ekey == 'S') {
           LongW -= d_ll;
           LongE -= d_ll;
	    drawit = 1;
       }

       if (ekey == 'R') {
           LatN += d_ll;
           LatS += d_ll;
	    drawit = 1;
       }

       if (ekey == 'T') {
           LatN -= d_ll;
           LatS -= d_ll;
	    drawit = 1;
       }


       if (ekey == 'X') {
     //  <<"expand \n"
           LatN += d_ll;
           LatS -= d_ll;
           LongW += d_ll;
           LongE -= d_ll;
	    drawit = 1;
       }

       if (ekey == 'x') {
    //   <<"Zoom IN\n"
           LatN -= (d_ll * 0.9);
           LatS += (d_ll * 0.9);
           LongW -= (d_ll * 0.9);
           LongE += (d_ll * 0.9);
	    drawit = 1;
       }

              if (ekey == 'f') {
                   dindex += 5;
                   showPosn(dindex);


                }
               else if (ekey == 'r') {
                   dindex -= 5;
                   showPosn(dindex);
              }

         if (drawit) {
//<<"%V $LongW $LatS $LongE $LatN\n"
 sWo(mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WEO);
        }
      }

       else if (WoName == "_Start_") {
             Task_update =1;
           //  sWo(_ewoid, _WCXOR);
              wc=choiceMenu("STP.m");
            //   showTaskPts();	
            if (wc == "M") { // replace
             wtp = PickaTP(0);
             if (wtp >= 0) {
                wcltpt = Wtp[wtp].Place;
                sWo(tpwo[0],_WVALUE,wcltpt,_WREDRAW);
             }

            }
	    else {
                Atarg = wc;
                wtp=PickTP(wc,0);
		if (wtp != -1) {
                  wcltpt = Wtp[wtp].Place;
               //   sWo(tpwo[0],_WVALUE,wcltpt,_WREDRAW);
                 woSetValue(tpwo[0],wcltpt);
               }
	    // sWo(tpwo[0], _WCXOR);
          }
	  
       }

       else if (scmp(WoName,"_TP",3)) {
       
             Task_update =1;
	     
             np = spat(WoName,"_TP",1);
             np = spat(np,"_",-1);

              Witp = atoi(np);
              wtpwo = tpwo[Witp];

            // sWo(wtpwo, _WCXOR);
	     
	     gflush();

            cval = getWoValue(wtpwo);
 // <<"%V $np <|$cval|>  \n"
             if (cval != "") {

             wc = choiceMenu("TP.m");
//<<"menu choice  name or action  %V $wc\n";

           //  showTaskPts();
	       
             if (wc == "R") { // replace

               printf("REPLACE TP \n");
               wc=choiceMenu("CTP.m");

                  if (wc == "M") { // replace
                    printf("REPLACE TP via Map select\n");
                     replace_tp(Witp);
                   }
	          else {
                     printf("REPLACE TP via Name select\n");	    
                     PickViaName(Witp);
                  }
             }
             else if (wc == "D") {
                printf("delete and move lower TPs up %d !\n",Ntaskpts);
                delete_tp(Witp); //
	        Task_update =1;
                //<<"Done delete  $Ntaskpts!\n"		
             }
             else if (wc == "I") {
             printf("INSERT TP $wc \n");
             wc=choiceMenu("ITP.m");
//printf("choose how? %s\n",vtoa(wc));		

            if (wc == "M") {
                  insert_tp(Witp);
		 }
		 else {
                 insert_name_tp(Witp);
		 }
              }
	      Task_update =1;
	     }
             else if (Witp == Ntaskpts)  {
	     //<<"this is add to end of current task list\n"

                   wc=choiceMenu("ATP.m");

//printf("choose how? %s\n",vtoa(wc));
                if (wc == "A") {
		 //<<"getting name $wc\n"
		  ok=PickViaName(Witp);
		  if (ok) {
                  // <<"added TP\n"
		    Ntaskpts++;
                  }
		  DrawMap();
             }
             else if (wc == "P")  {  // this is add
                  insert_tp(Witp);
                  Ntaskpts++;
		  DrawMap();
             }	     
                Task_update =1;
          }
	   

                 sWo(tpwo,_WREDRAW);
                 sWo(legwo,_WREDRAW,_WEO);		 
                // sWo(wtpwo,_Wcxor);
                 showTaskPts();
       }
       else if (WoName == "ALT") {
       
       	 wfr=sWo(mapwo,_WSHOWPIXMAP,_WEO); // should erase precious target position
	 
         drawit = 0;
         dindex = rint(erx);

//<<"%V $erx, alt $ery  $dindex $IGCELE[dindex] $IGCLAT[dindex] $IGCLONG[dindex] \n";
         symx = IGCLONG[dindex];
	 symy = IGCLAT[dindex];
	 symem = IGCELE[dindex] ;
	 syme = IGCELE[dindex] *  3.280839;
	// <<"%V $symx $symy $syme  \n"

          wfr =sWo(mapwo,_WPIXMAPOFF,_WDRAWON,_WEO); // just draw but not to pixamp
       if (Ev_button == 1 || Ev_button == 4) {

	  sGl(lc_gl,_GLCURSOR,rbox(erx,0,erx,20000, CL_init),_GLEO);
	  dGl(lc_gl);
	  CL_init = 0;
	   zoom_begin = erx;

           plotSymbol(mapwo,symx,symy,CROSS_,symsz,MAGENTA_,1);



         }

       if (Ev_button == 3 || Ev_button == 5) {

 //  sGl(lc_gl,_GLCURSOR,lcpx,0,lcpx,300, CL_init,_GLEO);
	  sGl(rc_gl,_GLCURSOR,rbox(erx,0,erx,20000, CR_init),_GLEO);
          dGl(rc_gl);
	  CR_init = 0;
	  
          plotSymbol(mapwo,symx,symy,DIAMOND_,symsz,LILAC_,1,90);		  
	  
           zoom_end = erx;
	   
	  // Task_update = 1;
	   
          // save end time  for zoomin
       }

//	 swo(mapwo,_WCLEAR,_WCLEARCLIP,BLUE_,_WCLEARPIXMAP);
	 
         wfr = sWo(mapwo,_WPIXMAPON,_WEO);
	 drawAlt();


//<<"%V $zoom_begin $zoom_end  $mapwo $vvwo \n"
	 sWo(sawo,_WVALUE,"$symx $symy $syme ",_WREDRAW);
	 
       }
       else if (WoName == "ZOOM") {
        // find LatN,LatS,LongW,LongE for the time range zoom_begin , zoom_end
        // add margin
	// set and update map
	zoomMap(zoom_begin, zoom_end);
	 
        Task_update =1;

       }
       else if (WoName == "MAP") {

               drawit = 0;

               ntp = ClosestLand(erx,ery);

             if (ntp >= 0) {

               Wtp[ntp].Print();
               nval = Wtp[ntp].GetPlace();
	       
            //  <<" found %V $ntp $nval \n"
                Text(  vptxt," $ntp $nval   ",0,0.05,1);
                ST_msl = Wtp[ntp].Alt;
                mkm = HowFar(erx,ery, Wtp[ntp].Longdeg, Wtp[ntp].Ladeg);
                ght = (mkm * km_to_feet) / LoD;
                sa = ST_msl + ght + 2000;
          	sWo(sawo,_WVALUE,"$nval %5.1f $ST_msl $mkm $sa",_WREDRAW);
               // DrawMap();
             }

        }

       else if (WoName == "TaskMenu") {

             //task_menu(mapwo)
    //          read_task()
  task_file = "XXX";
  task_file = naviWindow("TASK_File","task file?",task_file,".tsk","TASKS");
  //<<"%V$task_file\n"
  
             readTaskFile (task_file);
	     
//<<"after readTaskFile (task_file) $SetWoT \n";

         setWoTask();
//<<"done  setWoTask() $SetWoT \n"
             Task_update =1;

       }
       
       else if (Ev_keyw == "Menu") {
          // <<" task type is $_ekeyw \n"
           TaskType = Ev_keyw;
           //<<" Set %V$TaskType \n"
       }


        if (drawit || Task_update) {
	     DrawMap();
  	     drawTrace();
             drawTask(mapwo,GREEN_);
        }

     if ( Task_update ) {

//<<"main %V $_scope $_cmfnest $_proc $_pnest\n"
     
      taskDist();

      sWo(tdwo,_WVALUE,"$totalK km",_WUPDATE);
      Task_update = 0;
      //int i;
      for (i = 0; i < Ntaskpts ; i++) {
         ST_msl = Wleg[i].msl;
       //<<"Stat $i $ST_msl $Wleg[i].dist   $Wleg[i].fga\n"
      }


// scope  cmf_nest proc nest check ??
 //         <<"main %V $_scope $_cmfnest $_proc $_pnest\n"


      TaskStats();
//          <<"main %V $_scope $_cmfnest $_proc $_pnest\n"

       updateLegs();

       sWo(tpwo,_WREDRAW);
       sWo(legwo,_WREDRAW);		 
      }

   //  sWi(vp,_WREDRAW,_WEO);


    //drawTrace();
   // drawTask(mapwo,RED_);
 
//	 sWo(mapwo,_WSHOWPIXMAP,_WEO);
}



exitGWM();

exit(0);

#if CPP
}
////////////////////////////////////////////////////////////////////////////////////////


extern "C" int show_task(Svarg * sarg)  {

 Str a0 = sarg->getArgStr(0) ;
 Str ans;
 a0.pinfo();

Str Use_ ="compute task distance\n  e.g  showtask  gross laramie mtevans boulder  LD 40";


 printf(" showTask app %s ",Use_.cptr() );
 //cout << " paras are: "  << " a0 " <<  a0 << endl;

    Uac *o_uac = new Uac;



    o_uac->showTask(sarg);

   //cout << "total D " << ::totalD    <<endl ;

  }

#endif





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









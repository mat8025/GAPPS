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






int main_chk =1;
int Maxtaskpts = 13;

//======================================//
void drawTrace()
{
     if (Have_igc) {
         sWo(mapwo, @scales, LongW, LatS, LongE, LatN )
         sWo(mapwo,@clearpixmap);
         sWo(vvwo,@clearpixmap);

         
          DrawMap(mapwo);
	  
  	 if (Ntpts > 0) {
            sWo(vvwo, @scales, 0, Min_ele, Ntpts, Max_ele + 500 )
              dGl(igc_tgl);
	    sWo(vvwo,@clearpixmap);
	      dGl(igc_vgl);
            sWo(mapwo,@showpixmap,@clipborder);
            sWo(vvwo,@showpixmap,@clipborder);
	 }
	sWo(mapwo,@showpixmap,@clipborder);

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

LoD = 35.0;

TaskType = "TRI"; 

int Nlegs = 3;


int Taskpts[20];

Turnpt  Wtp[300]; //

Tleg  Wleg[20];
Record RX;

index = 7;
for (i= 0; i <5; i++) {

  Taskpts[Ntaskpts] = index;

  index++;
  Ntaskpts++;
  
}





 



/// open turnpoint file lat,long 

int use_cup = 1;



if (use_cup) {

    tp_file = "CUP/bbrief.cup"
}
else {

  tp_file = "DAT/turnptsA.dat"  // open turnpoint file TA airports

  if (tp_file @= "") {
    tp_file = "DAT/turnptsSM.dat"  // open turnpoint file 
   }
}


A=  ofr(tp_file);

 if (A == -1) {
  <<" can't open file   \n";
    exit();
 }

if (use_cup) {

  Nrecs=RX.readRecord(A,_RDEL,-1,_RLAST);  // no back ptr to Siv?
  //RF= readRecord(A,@del,',',@comment,"#");
}
else {
// RF= readRecord(A);
}
cf(A);


 



  Nrecs = Caz(RX);
  Ncols = Caz(RX,1);

<<"num of records $Nrecs  num cols $Ncols\n";


  WH=searchRecord(RX,"jamest",0,0)

<<"$WH \n"
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


  A=ofr(tp_file)
  

  if (A == -1) {
    exit(-1," can't find turnpts file \n");
  }


 
  Ntaskpts = 0;
  Ntp = 0;


  if (!use_cup) {
         C=readline(A);
	 C=readline(A);
   }

int c1;

while (1) {

    before = ftell(A);
   c1 = fgetc(A,-1);
    after = ftell(A);


<<"$Ntp $before $after\n"    
    if (use_cup) {
               nwr = Wval.ReadWords(A,0,',')

<<"%V $nwr\n";
<<"%V $Wval\n";

        main_chk++;

	       
    }
    else {
            nwr = Wval.ReadWords(A)
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
//<<"$Ntp $wd1 $Wval[0] $Wval[1]\n"
        }
      }

if (Ntp >=100) break;
//<<"while_end main postcmf %V $_scope $_cmfnest $_proc $_pnest\n"
   <<"%V $Ntp \n"

}

<<" Read $Ntp turnpts \n"

 if (Ntp < 1) {
  exit("BAD turnpts");
 }
////////////////////////////////////

chkT(1)




// Nlegs = Ntp -1;
//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;


int is_an_airport = 0;

//<<"pre_pinfo() %V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;



    for (k = 1 ; k <=  5 ; k++) {

        is_an_airport = Wtp[k]->is_airport;
if (is_an_airport) {
        mlab = Wtp[k]->Place;

<<"TP $k $mlab  $is_an_airport\n"
//       if (mlab @= "Jamestown") {
//         <<"SF\n"
//       }
}

   }

<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;

chkT(1)

/////////////////// TASK DEF ////////////





Task_update =1
Units = "KM"

int tp_wo[20];
int gtp_wo[20];
int ltp_wo[20];




char MS[240]
char Word[128]
char Long[128]
num_tpts = 700;

float R[10];


    Have_igc = 0;



//  Read in a Task via command line

float min_lat;
float max_lat;
float longW =0.0;

Ntaskpts = 0;

//////////////// PARSE COMMAND LINE ARGS ///////////////////////

long posn = 0;
svar Tskval;
  na = argc()
 <<"na $na\n"
 int ai =0;


main_chk++;
 while (AnotherArg()) {
//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
//<<"$ai $_clarg[ai]\n"

          ai++;
          targ = GetArgStr()
	  if (targ @= "task") {
            TaskType = GetArgStr()
	    <<"set %V $TaskType \n"
          }
      else if (targ @= "igc") {
           igcfn = getArgStr();

       if (issin(igcfn,"igc")) {
        Have_igc = 1;
        <<"IGC file $igcfn \n"
       }
      }
          else {
          WH=searchRecord(RX,targ,0,0)
	  <<"%V $WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RX[index];

<<"$ttp \n"

          Taskpts[Ntaskpts] = index;
<<" $Ntaskpts found $targ  $index  $Taskpts[Ntaskpts]\n"
           Ntaskpts++;

           }
	  
          }
      if (main_chk > 20) {
               break;
      }
}
//======================================//

//ans=query("2?");

chkT(1)
//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;

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

<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;

Nlegs = Ntaskpts;
<<"%V $Ntaskpts \n"
Taskpts.pinfo()

   for (k= 0; k < Ntaskpts; k++) {
       index = Taskpts[k];
<<"%V $k $index $Taskpts[k] \n";
   }

//   for (k= 1; k < 15; k++) {
//             Wtp[k]->Print()
//    }
<<"//////////\n"
<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;
Taskpts.pinfo()


<<" Now print task\n"
<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;



      for (i = 0; i < Ntaskpts ; i++) {
         MSL = Wleg[i]->msl;
       <<"Stat $i $MSL $Wleg[i]->dist   $Wleg[i]->fga\n"
      }

//<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;
//<<"main  pre TaskDist %V $_scope $_cmfnest $_proc $_pnest\n"	       

 TaskDist();


/**
<<"after include  proc \n"

   for (k= 0; k < Ntaskpts; k++) {
       index = Taskpts[k];
<<"%V $k $index $Taskpts[k] \n";
   }
*/


<<"%V $main_chk $_scope $_cmfnest $_proc $_pnest\n"
main_chk++;

<<"%V $Have_igc\n"



  if (Have_igc) {
      processIGC()
  }

chkT(1)





       //      Wtp[3]->Print()


#include "showtask_scrn"






//===========================================//
 if (Ntaskpts > 1) {
  int alt;
  for (i = 0; i < Ntaskpts ; i++) {

        k= Taskpts[i];
	
        tpl =   Wtp[k]->Place;
	
        alt = Wtp[k]->Alt;  
      
      <<"$i   $tpl  $tpwo[i]\n"

       
        sWo(tpwo[i],_WVALUE,"$tpl",_WUPDATE,_WREDRAW);  
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


    sWo(mapwo, _WSCALES, LongW, LatS, LongE, LatN );

//  set up the IGC track for plot
    igc_tgl = cGl(mapwo,@TXY,IGCLONG,IGCLAT,@color,BLUE_);

    igc_vgl = cGl(vvwo,@TY,IGCELE,@color,RED_);

 DBG"%V $mapwo \n"

   if (Ntpts > 0) {
    dGl(igc_tgl);  // plot the igc track -- if supplied
    sWo(vvwo, _WSCALES, 0, 0, Ntpts, Max_ele +500)
    dGl(igc_vgl);  // plot the igc climb -- if supplied
   }

# main


#include  "gevent";

int dindex;
int Witp = 0;
int drawit = 0;
msgv = "";

float d_ll = Margin;

str wcltpt="XY";

  DBG"%V $vvwo $Ntpts\n"
 // sWo(vvwo,@clear,@clearpixmap,@savepixmap,@clipborder);
 // sWo(vvwo, @scales, 0, 0, Ntpts, Max_ele +500);

  DBG"%V $LongW \n"
  DBG"%V $LongE \n"

  TaskDist();
   if (uplegs) {
    updateLegs();
   }

  sWo(tdwo,@value,"$totalK km",@update);
 
  drawTrace();

  zoom_to_task(mapwo,1)

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN );
  sWo(TASK_wo,@value,TaskType,@redraw);

  DrawMap(mapwo);


  drawTask(mapwo,"green");




  while (1) {
 //   zoom_to_task(mapwo,1)

    drawit = 1;
    Task_update =0
  
    eventWait();

<<"%V $_ekeyw $_ekeyc $_ewoname  %c $_ekeyc \n"; 

    //Text(vptxt," $_ekeyw   ",0,0.05,1)

       if ( _ekeyc >= 65) {
       
       d_ll = (LatN-LatS)/ 10.0 ;
<<"%V $LongW $LatS $LongE $LatN   $d_ll\n"


       if (_ekeyc == 'Q') {
           LongW += d_ll
           LongE += d_ll
       }

       if (_ekeyc == 'S') {
           LongW -= d_ll
           LongE -= d_ll
       }

       if (_ekeyc == 'R') {
           LatN += d_ll
           LatS += d_ll
       }

       if (_ekeyc == 'T') {
           LatN -= d_ll
           LatS -= d_ll
       }


       if (_ekeyc == 'X') {
       <<"expand \n"
           LatN += d_ll
           LatS -= d_ll
           LongW += d_ll
           LongE -= d_ll
       }

       if (_ekeyc == 'x') {
       <<"Zoom IN\n"
           LatN -= (d_ll * 0.9)
           LatS += (d_ll * 0.9)
           LongW -= (d_ll * 0.9)
           LongE += (d_ll * 0.9)
       }
              drawit = 1;
<<"%V $LongW $LatS $LongE $LatN\n"
 sWo(mapwo, @scales, LongW, LatS, LongE, LatN);

      }

       else if (_ewoname @= "_Start_") {
             Task_update =1
             sWo(_ewoid, @cxor)
              wc=choice_menu("STP.m")
               listTaskPts()	
            if (wc @= "R") { // replace
          wtp = PickaTP(0)
             if (wtp >= 0) {
                wcltpt = Wtp[wtp]->Place;
                sWo(tpwo[0],@value,wcltpt,@redraw)
             }
           }
	    else {
                Atarg = wc;
                wtp=PickTP(wc,0)
		if (wtp != -1) {
                  wcltpt = Wtp[wtp]->Place;
                  sWo(tpwo[0],@value,wcltpt,@redraw);
                }
	     sWo(tpwo[0], @cxor)
          }
       }

       else if (scmp(_ewoname,"_TP",3)) {
       
             Task_update =1
             np = spat(_ewoname,"_TP",1)
             np = spat(np,"_",-1)

              Witp = atoi(np);
              wtpwo = tpwo[Witp]

             sWo(wtpwo, @cxor);
	     
	     gflush();

             wc=choice_menu("TP.m")
               listTaskPts()	
             if (wc == "R") { // replace

             wtp = PickaTP(Witp)
             if (wtp >= 0) {
              wcltpt = Wtp[wtp]->Place;
              sWo(wtpwo,@value,wcltpt,@redraw);
             }
             }
             else if (wc == "D") {
                <<"delete and move lower TPs up!\n"

               delete_tp(Witp); // 
	      // delete_tp();

             }

             else if (wc == "I") {
                 insert_tp(Witp);
	//	 insert_tp();
             }
             else if (wc == "N") {
                 insert_name_tp(Witp);
             }	     
             else {
                Atarg = wc;
                wtp=PickTP(wc,Witp)
		if (wtp != -1) {
                  wcltpt = Wtp[wtp]->Place;
                  sWo(wtpwo,@value,wcltpt,@redraw);
                }
             }




                 sWo(tpwos,@redraw);
                 sWo(legwos,@redraw);		 
                 sWo(wtpwo,@cxor);
                 listTaskPts()	

       }


       else if (_ewoname @= "ALT") {

         drawit = 0;
         dindex = rint(_erx)

<<" index $_erx, alt $_ery  $dindex $IGCELE[dindex] $IGCLAT[dindex] $IGCLONG[dindex] \n"
         symx = IGCLONG[dindex]
	 symy = IGCLAT[dindex]
	 
	 <<"$symx $symy $mapwo \n"
	 
       
	 
	 swo(mapwo,@clear,@clearclip,BLUE_,@clearpixmap)
	 
	 plot(mapwo,@symbol,symx,symy, 11,2,RED_)

         plot(mapwo,@circle,symx,symy, 0.01,GREEN_,1)
	 
	 swo(mapwo,@showpixmap)
	 
       }
       
       else if (_ewoname @= "MAP") {

               drawit = 0;

               ntp = ClosestLand(_erx,_ery);

             if (ntp >= 0) {

               Wtp[ntp]->Print()
               nval = Wtp[ntp]->GetPlace()
	       
              <<" found %V $ntp $nval \n"
                Text(  vptxt," $ntp $nval   ",0,0.05,1)
                msl = Wtp[ntp]->Alt;
                mkm = HowFar(_erx,_ery, Wtp[ntp]->Longdeg, Wtp[ntp]->Ladeg)
                ght = (mkm * km_to_feet) / LoD;
                sa = msl + ght + 2000;
          	sWo(sawo,@value,"$nval %5.1f $msl $mkm $sa",@redraw)

             }

        }

       else if (_ewoname == "TaskMenu") {
            sdb(1)
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
       
       else if ( _ekeyw @= "Menu") {
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

      sWo(tdwo,@value,"$totalK km",@update);
      Task_update = 0;

      for (i = 0; i < Ntaskpts ; i++) {
         MSL = Wleg[i]->msl;
       <<"Stat $i $MSL $Wleg[i]->dist   $Wleg[i]->fga\n"
      }


// scope  cmf_nest proc nest check ??
          <<"main %V $_scope $_cmfnest $_proc $_pnest\n"


      TaskStats();
          <<"main %V $_scope $_cmfnest $_proc $_pnest\n"


         if (uplegs) {
           updateLegs();
         }
      sWo(tpwos,@redraw);
       sWo(legwos,@redraw);		 
      }
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


  projection  --  square degrees - square map window --- conical??

  plot plane position as scroll in vvwo


  need task distance ---
  and task plotting to work


  ?? what happed to viewterrain and elevation - magic carpet viewer??


  menus

*/









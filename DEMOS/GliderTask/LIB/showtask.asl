//%*********************************************** 
//*  @script showtask.asl 
//* 
//*  @comment show/create glider task 
//*  @release CARBON 
//*  @vers 3.3 Li Lithium [asl 6.2.60 C-He-Nd]                             
//*  @date Tue Jun 23 07:05:33 2020 
//*  @cdate 7/21/1997 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
/// "$Id: showtask.asl,v 1.5 1997/07/21 15:01:08 mark Exp mark $"
///

# map of turn_points

<|Use_=
 view and select turnpts  ;
///////////////////////
|>


                                                                        
#include "debug"

if (_dblevel >0) {
  debugON()
    <<"$Use_\n"   
}


#include "hv.asl"

ignoreErrors()
setMaxICerrors(-1) // ignore - overruns etc

//#define DBG <<
#define DBG ~!


float Max_ele = 18000.0
float Min_ele  = 0.0;
float Margin = 0.05;

int Ntpts = 1000;

#include "ootlib"

int Maxtaskpts = 10;





//======================================//
proc drawTrace()
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





TaskType = "TRI"; 

int Nlegs = 3;

Turnpt  Wtp[800]; // 

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
  RF= readRecord(A,@del,',');
}
else {
 RF= readRecord(A);
}
cf(A);


recinfo = info(RF);
<<"$recinfo \n"


  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

<<"num of records $Nrecs  num cols $Ncols\n";


WH=searchRecord(RF,"jamest",0,0)

<<"$WH \n"
index = WH[0][0]
<<"%V $index\n"

place = RF[index][0]
lat = RF[index][2]
longv = RF[WH[0][0]][3]

<<"$RF[index][0] \n"
<<"$RF[index][2] \n"
<<"%V $place $lat $longv\n"




//================================//

  A=ofr(tp_file)
  

  if (A == -1) {
    exit(-1," can't find turnpts file \n");
  }


 
  Ntaskpts = 0;
  Ntp = 0;

 svar Wval;
  if (!use_cup) {
         C=readline(A);
	 C=readline(A);
   }
   
  while (1) {

    if (use_cup) {
               nwr = Wval->ReadWords(A,0,',')
    }
    else {
            nwr = Wval->ReadWords(A)
    }
            if (nwr == -1) {
	      break
            }
	    
            if (nwr > 6) {
	    


    if (use_cup) {
             Wtp[Ntp]->TPCUPset(Wval);
    }
    else {
            Wtp[Ntp]->TPset(Wval);
    }


             Ntp++;
            }

      //  if (Ntp > 10) {
      //       break; // DEBUG
      //  }
      }

<<" Read $Ntp turnpts \n"

 if (Ntp < 1) {
  exit("BAD turnpts");
 }
////////////////////////////////////

// Nlegs = Ntp -1;

int is_an_airport
//sdb(1,@trace)
    for (k = 0 ; k < 5  ; k++) {

        is_an_airport = Wtp[k]->is_airport;

        mlab = Wtp[k]->Place;

//<<"<|$k|> $mlab  $is_an_airport\n"
       if (mlab @= "Jamestown") {
 //         <<"SF\n"
       }
   }




/////////////////// TASK DEF ////////////

int Taskpts[>10]; 

Task_update =1
Units = "KM"


/////////////  Arrays : Globals //////////////

LatS= 37.5;

LatN = 42.0;

LongW= 108.5;

LongE= 104.8;

 MidLong = (LongW - LongE)/2.0 + LongE;
 MidLat = (LatN - LatS)/2.0 + LatS;


int tp_wo[>20];
int gtp_wo[>20];
int ltp_wo[>20];


LoD = 35.0;

char MS[240]
char Word[128]
char Long[128]
num_tpts = 700

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
 while (AnotherArg()) {

<<"$ai $_clarg[ai]\n"
          ai++;
          targ = GetArgStr()
	  if (targ @= "task") {
            TaskType = GetArgStr()
	    <<"set %V $TaskType \n"
          }
      else if (targ @= "igc") {
           igcfn = getArgStr();

       if (isin(igcfn,"igc")) {
        Have_igc = 1;
        <<"IGC file $igcfn \n"
       }
      }
          else {
          WH=searchRecord(RF,targ,0,0)
	  <<"%V $WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RF[index];
<<" found $targ  $index\n"
<<"$ttp \n"
          Taskpts[Ntaskpts] = index;
          Ntaskpts++;
          }
	  
          }

}
//======================================//

// home field
// set a default task
if (Ntaskpts == -1) {

svar targ_list = {"eldorado","casper","rangely","eldorado"}
    sz= Caz(targ_list);
<<"$sz : $targ_list \n"

<<" $targ_list[1] \n"
        targ = targ_list[2]
<<" $targ \n"
sz->info(1)
    for (i= 0; i < sz; i++) {
    targ = targ_list[i]
    <<"$i  <|$targ|> \n"
          WH=searchRecord(RF,targ,0,0)
	  <<"$WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RF[index];
<<"$ttp \n"
          Taskpts[Ntaskpts] = index;
          Ntaskpts++;
          }
    }
}
//======================================//
Nlegs = Ntaskpts;
<<"%V $Ntaskpts \n"

<<" Now print task\n"


      TaskDistance();


<<"%V $Have_igc\n"
  if (Have_igc) {

      Ntpts=IGC_Read(igcfn);

<<"sz $Ntpts $(Caz(IGCLONG))   $(Caz(IGCLAT))\n"

      k = Ntpts - 30;

//<<"%(10,, ,\n) $IGCLONG[0:30] \n"
//<<"%(10,, ,\n) $IGCLONG[k:Ntpts-1] \n"


     sslng= Stats(IGCLONG)

     for (i=0; i < Ntpts; i += 5) {
     
      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";

     }

     <<"%V $sslng \n"

     sslt= Stats(IGCLAT)

<<"%V $sslt \n"

    ///
    sstart = Ntpts /10;

    sfin = Ntpts /5;
    
    //sstart = 1000;
   // sfin = 1500;

//     for (i=sstart; i < sfin; i++) {
     
//      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";

//     }



     ssele= Stats(IGCELE,">",0)

<<"%V $ssele \n"

      Min_ele = ssele[5];
      Max_ele = ssele[6];
<<" min ele $ssele[5] max $ssele[6] \n"

      min_lng = sslng[5];
      max_lng = sslng[6];

<<"%V $min_lng $max_lng \n"


      min_lat = sslt[5];
      max_lat = sslt[6];


<<"%V $min_lat $max_lat \n"



  
     LatS = min_lat -Margin;
     LatN = max_lat+Margin;

     MidLat = (LatN - LatS)/2.0 + LatS;

  <<"%V $MidLat \n"

    dlat = max_lat - min_lat;

  <<"%V $dlat \n"

  <<"%V $LongW \n"
  <<"%V $LongE \n"



    LongW = max_lng + Margin;

    LongE = min_lng - Margin;


    MidLong = (LongW - LongE)/2.0 + LongE;

  DBG"%V $MidLong \n"


    dlng = max_lng - min_lng;

    da = dlat;
  DBG"%V $da $dlng $dlat \n"
// TBF if corrupts following expression assignment
    if ( dlng > dlat )
    {
        da = dlng
	DBG"da = dlng\n"
    }
    else {
  	DBG"da = dlat\n"
    }

  DBG"%V $da $dlng $dlat \n"
////////////////////// center //////////

//  longW = MidLong + da;

//  DBG"%V $longW $MidLong $da \n"
  
  latWB = MidLat + da/2.0;
  LongW = MidLong + da/2.0;
  <<"%V $latWB $MidLat $da \n"

  LongW = MidLong + da/2.0;

  <<"%V $longW $MidLong $da \n"


  LongE = MidLong - da/2.0;


  <<"%V $LongW \n"
  <<"%V $LongE \n"

  }
  

   for (k= 0; k < 5; k++) {
             Wtp[k]->Print()
    }
<<"//////////\n"
       //      Wtp[3]->Print()




///////////////////// SETUP GRAPHICS ///////////////////////////
#include "showtask_scrn"




//===========================================//
 if (Ntaskpts > 1) {
  int alt;
  for (i = 0; i < Ntaskpts ; i++) {

        k= Taskpts[i];
	
        tpl =   Wtp[k]->Place;
	
        alt = Wtp[k]->Alt;  
      
      <<"$i   $tpl  $tpwo[i]\n"

       
        sWo(tpwo[i],@value,"$tpl",@update,@redraw);  
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



    sWo(tpwos,@redraw);
    sWo(tpwo[1],@redraw);
    sWo(tpwo[2],@redraw);


     c= "EXIT"

     sWi(vp,@redraw); // need a redraw proc for app


    sWo(mapwo, @scales, LongW, LatS, LongE, LatN );

//  set up the IGC track for plot
    igc_tgl = cGl(mapwo,@TXY,IGCLONG,IGCLAT,@color,BLUE_);

    igc_vgl = cGl(vvwo,@TY,IGCELE,@color,RED_);

 DBG"%V $mapwo \n"

   if (Ntpts > 0) {
    dGl(igc_tgl);  // plot the igc track -- if supplied
    sWo(vvwo, @scales, 0, 0, Ntpts, Max_ele +500)
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

  TaskDistance();
  sWo(tdwo,@value,"$totalK km",@update);
 
  drawTrace();

  zoom_to_task(mapwo,1)

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN );
  sWo(TASK_wo,@value,TaskType,@redraw);

  DrawMap(mapwo)


  DrawTask(mapwo,"green");


  //DrawTask(mapwo,"yellow")

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

       if (_ewoname @= "_Start_") {
             Task_update =1
             sWo(_ewoid, @cxor)

             wtp = PickaTP(0)
             if (wtp >= 0) {
                wcltpt = Wtp[wtp]->Place;
               sWo(tpwo[0],@value,wcltpt,@redraw)
             }
	     sWo(tpwo[0], @cxor)
       }


       if (scmp(_ewoname,"_TP",3)) {
       
             Task_update =1
             np = spat(_ewoname,"_TP",1)
             np = spat(np,"_",-1)

              Witp = atoi(np);
              wtpwo = tpwo[Witp]

             sWo(wtpwo, @cxor);
	     
	     gflush();

             wc=choice_menu("TP.m")
               listTaskPts()	
             if (wc @= "R") { // replace

             wtp = PickaTP(Witp)
             if (wtp >= 0) {
              wcltpt = Wtp[wtp]->Place;
              sWo(wtpwo,@value,wcltpt,@redraw);
             }
             }
             else if (wc @= "D") {
                <<"delete and move lower TPs up!\n"

               delete_tp(Witp); // 
	      // delete_tp();

             }

             else if (wc @= "I") {
                 insert_tp(Witp);
	//	 insert_tp();
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
                 sWo(wtpwo,@cxor);
                 listTaskPts()	

       }


       if (_ewoname @= "ALT") {

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

       else if (_ewoname @= "TaskMenu") {
              task_menu(mapwo)
	      drawit = 0;
       }
       
       if ( _ekeyw @= "Menu") {
           <<" task type is $_ekeyw \n"
           TaskType = _ekeyw;
           <<" Set %V$TaskType \n"
       }


        if (drawit || Task_update) {
	      DrawMap(mapwo)
  	      drawTrace();
              DrawTask(mapwo,"green");
        }

     if ( Task_update ) {
      TaskDistance();
      sWo(tdwo,@value,"$totalK km",@update);
      Task_update = 0;
      }
  }
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









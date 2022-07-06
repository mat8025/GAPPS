/* 
 *  @script showtask.asl                                                
 * 
 *  @comment show/create glider task                                    
 *  @release Beryllium                                                  
 *  @vers 3.8 O Oxygen [asl 6.4.35 C-Be-Br]                             
 *  @date 06/22/2022 08:56:24                                           
 *  @cdate 7/21/1997                                                    
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  



///
/// "$Id: showtask.asl,v 1.5 1997/07/21 15:01:08 mark Exp mark $"
///


#define ASL 1
#define ASL_DB 0
#define GT_DB   0
#define CPP 0


#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.h" // rework
#define PXS  <<
#define VCOUT //
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
#include "winargs.h"

#include "uac.h"

#define PXS  cout<<

#undef  ASL
#define ASL 0
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

 openDll("uac");
#endif

int uplegs = 0;  // needed?
int  Ntp = 0; //



// different behavior on earth versus neptune machines
// local var not inited cpp and referenced with being set!!

//#include "conv.asl"


#include "tpclass.asl"

#include "ootlib.asl"


#include "globals_showtask.asl"

Turnpt  Wtp[300]; //
Tleg  Wleg[20];

#include "draw_showtask.asl"

//int WH[100][2];
Mat  WH(INT_,100,2);  //rows expandable
int main_chk =1;
int Maxtaskpts = 13;
int i;
float safealt = 10000;
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
 openDll("plot");

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

  r_index= SRX.findRecord("AngelFire",0,0,0);

  printf("AngelFire @ %d\n",r_index);

//ans=query("?","angel",__LINE__);







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

  //VCOUT(Ntp,before,c1,after);

//printf(" $AFH %d $Ntp %d $before %d $c1 %c $after %d\n", AFH ,Ntp ,before ,c1 ,after);

//<<"%V $AFH $Ntp $before $c1 $after\n"

    if (use_cup) {

       nwr = Wval.readWords(AFH,0,',');

       //<<"%V $Ntp $nwr  $AFH $Wval\n";

//printf("Ntp %d nwr %d  %s\n",Ntp,nwr,Wval.cptr(0));


	       
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


 while (1) {

//<<"$ai $_clarg[ai]\n"

          //ai++;

	  targ = sa.cptr(ai);

   pa(ai, " targ ",targ);
//ans=query("?","TP",__LINE__);

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
	  
          r_index=SRX.findRecord(targ,0,0,0);

//pa("targ ",targ," @row ", r_index);

          if (r_index >=0) {

           ttp = SRX[r_index];

//<<"$ttp \n"

          Taskpts[Ntaskpts] = r_index;

PXS" $Ntaskpts found $targ  $r_index  $Taskpts[Ntaskpts]\n";

//ans=query("?","TP",__LINE__);


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

       ai++;
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
         r_index=SRX.findRecord(targ,0,0,0);

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





int Nlegs = Ntaskpts;

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


      for (i = 0; i < Ntaskpts ; i++) {
         ST_msl = Wleg[i].msl;
      // <<"Stat $i $ST_msl $Wleg[i].dist   $Wleg[i].fga\n"
      }






  if (Have_igc) {
pa(" Have_igc", igc_fname);

Igcfn = ofr(igc_fname);

      if (Igcfn != -1) {
       processIGC();
      }
      
  }


       //      Wtp[3].Print()


#include "scrn_showtask.asl"


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
       
        sWo(_WOID,tpwo[i],_WREDRAW,ON_);  
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


    //sWo(tpwo,_WREDRAW);

pa("Ntaskpts ", Ntaskpts);

    taskDist(); // should extract Coors to show task -- or default

pa( " Coors ", LongW, LatS, LongE, LatN);

     Str c= "EXIT";

     sWi(_WOID,Vp,_WREDRAW,ON_); // need a redraw proc for app

 Mapcoors= woGetPosition (mapwo);

  COUT(Mapcoors);

//ans=query("?","Mapcoors",__LINE__);

  dMx = Mapcoors[5];
  dMy = Mapcoors[6];


  // adjust the  X  & Y to be  same angluar scale
  // fix the Y
  Latval = LatN - LatS;
  Dang = Latval / (dMy*1.0);
  // adjust LongW
  Latval = LongE + (dMx * Dang);

  printf("dMx %d dMy %d LongW %f lat %f LongE %f\n",dMx,dMy,LongW,Latval,LongE);  
  LongW = Latval;



    sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN));



    if (Have_igc) {

//  set up the IGC track for plot
    igc_tgl = cGl(mapwo);
    
   // IGCLONG.pinfo();
   //         IGCLONG.minfo();

  //  IGCLAT.pinfo();
    //    IGCLAT.minfo();

//COUT(IGCLAT);

//ans=query("?","LAT",__LINE__);

//COUT(IGCLONG);

//ans=query("?","LONG",__LINE__);

//COUT(IGCELE);

//ans=query("?","ELE",__LINE__);

    igc_vgl = cGl(vvwo);

//    VCOUT(_GLTXY, _GLTY);
//        VCOUT(igc_vgl, igc_tgl);
    
    sGl(_GLID,igc_vgl, _GLTY, IGCELE,_GLHUE, GREEN_);

   sGl(_GLID,igc_tgl, _GLXVEC, IGCLONG, _GLYVEC, IGCLAT,_GLHUE,BLUE_); // TBF tag args remove white space

  //sGl(_GLID,igc_tgl, _GLXVEC, IGCLONG, _GLHUE,BLUE_); // TBF tag args remove white space

/// sGl(_GLID,igc_tgl,  _GLYVEC,IGCLAT,_GLHUE,RED_); // TBF tag args remove white space


//COUT(IGCELE);

//ans=query("?","ELE",__LINE__);





//ans=query("?2","_GLTXY",__LINE__);





//ans=query("?","_GLTY",__LINE__);

   if (Ntpts > 0) {
   
    //dGl(igc_tgl);  // plot the igc track -- if supplied
	
 //   sGl(_GLID,igc_tgl,_GLDRAW,BLUE_);  // DrawGline;

    pa(Ntpts," mAx ele ", Max_ele);
    
    //sWo(_WOID,vvwo, _WSCALES, wbox(0, 0, Ntpts, Max_ele +500));
    sWo(_WOID,vvwo, _WSCALES, wbox(0, 0, Ntpts, 5000));

    sGl(_GLID,igc_vgl,_GLDRAW,RED_);  // DrawGline;

  //  dGl(igc_vgl);  // plot the igc climb -- if supplied

   sWo(_WOID,vvwo,_WSHOWPIXMAP,ON_);
//ans=query("?","igc",__LINE__);
   }



   }
   sWo(_WOID,ZOOM_wo,_WREDRAW,ON_);


//ans=query("?3","see trace?",__LINE__);



#if CPP
//#include  "gevent.h";
#else
#include  "gevent.asl";
#endif

 Gevent gev;




int dindex;

int drawit = 0;
Str msgv = "";

float d_ll = Margin;

Str wcltpt="XY";




//ans=query("?3","see dist?",__LINE__);
   if (uplegs) {
    updateLegs();
   }

 
  woSetValue(tdwo,totalK);
  
  sWo(_WOID,tdwo,_WREDRAW,ON_);

//ans=query("?4","b4 trace?",__LINE__);
  drawTrace();

//ans=query("?5","after trace?",__LINE__);

//  zoom_to_task(mapwo,1)

  sWo(_WOID,mapwo,_WSCALES,wbox( LongW, LatS, LongE, LatN) );

//ans=query("?6"," ",__LINE__);

  woSetValue(TASK_wo,TaskType);
  //sWo(TASK_wo,_WVALUE,TaskType,_WREDRAW);
  
  //sdb(2,"pline");

//ans=query("?7","b4 map?",__LINE__);

  DrawMap();

//ans=query("?8","after map?",__LINE__);


  drawTrace();
  
  drawTask(mapwo,GREEN_);


//ans=query("listTask?");
//<<"%V $Ntaskpts\n"


                showTaskPts();

                 listTaskPts();
		 
   updateLegs();

    taskDist();
 //sWo(tdwo,_WUPDATE);

  while (1) {
 //   zoom_to_task(mapwo,1)
    ok = 0;
    drawit = 0;
    Task_update =0;
  
    //eventWait();
    Gemsg =gev.eventWait();
    Gekey = gev.getEventKey();
    gev.getEventRxy( &Gerx,&Gery);

    WoName = gev.getEventWoName();
    Ev_button = gev.getEventButton();

#if ASL    
<<"%V $Ev_keyw $gekey $WoName \n"
#endif

    Ev_keyw = gev.getEventKeyWord();

    pa("pa Ev_keyw ", Ev_keyw);
  
  // printf("Ev_keyw <|%s|> ", Ev_keyw.cptr());



  if (Ev_keyw == "EXIT_ASL" ) {
         //ans=query("?","EXIT_ASL QUIT?",__LINE__);
         break;
   }


    if (Ev_keyw == "REDRAW" || WoName == "REDRAW") {

       Task_update =1;
       
    }

    //Text(vptxt," $_gekeyw   ",0,0.05,1)

       if ( gev.getEventKey() >= 65) {


       printf("IN  W %f E %f N %f S %f\n",LongW, LongE,LatN, LatS);

//ans=query("1","hey",__LINE__);

       d_ll = (LatN-LatS)/ 10.0 ;
//<<"%V $LongW $LatS $LongE $LatN   $d_ll\n"
        if (Gekey == 'q') {
             ans=query("?","QUIT",__LINE__);

           exit(-1);
       }


       if (Gekey == 'Q') {
           LongW += d_ll;
           LongE += d_ll;
	   printf("Q  W %f E %f\n",LongW, LongE);
	   drawit = 1;
       }

       if (Gekey == 'S') {
           LongW -= d_ll;
           LongE -= d_ll;
	   printf("S  W %f E %f\n",LongW, LongE);	   
	    drawit = 1;
       }

       if (Gekey == 'R') {
           LatN += d_ll;
           LatS += d_ll;
	   printf("R  N %f S %f\n",LatN, LatS);	   
	   drawit = 1;
       }

       if (Gekey == 'T') {
           LatN -= d_ll;
           LatS -= d_ll;
	   printf("T  N %f S %f\n",LatN, LatS);	   	   
	    drawit = 1;
       }


       if (Gekey == 'X') {
     //  <<"expand \n"
           LatN += d_ll;
           LatS -= d_ll;
           LongW += d_ll;
           LongE -= d_ll;
	   printf("X  W %f E %f N %f S %f\n",LongW, LongE,LatN, LatS);	   	   
	    drawit = 1;
       }

       if (Gekey == 'x') {
    //   <<"Zoom IN\n"
           LatN -= (d_ll * 0.9);
           LatS += (d_ll * 0.9);
           LongW -= (d_ll * 0.9);
           LongE += (d_ll * 0.9);
	   printf("x  W %f E %f N %f S %f\n",LongW, LongE,LatN, LatS);	   	   	   
	    drawit = 1;
       }

              if (Gekey == 'f') {
                   dindex += 5;
                   showPosn(dindex);


                }
               else if (Gekey == 'r') {
                   dindex -= 5;
                   showPosn(dindex);
              }

         if (drawit) {
//<<"%V $LongW $LatS $LongE $LatN\n"
 printf("OUT W %f E %f N %f S %f\n",LongW, LongE,LatN, LatS);
 sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN));
 
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
                sWo(_WOID,tpwo[0],_WVALUE,wcltpt,_WREDRAW,ON_);
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
           //  np = spat(np,"_",-1);
//np.pinfo();
              Witp = atoi(np);
//	      <<"%V $np $Witp \n"
              wtpwo = tpwo[Witp];

            // sWo(wtpwo, _WCXOR);
	     


            cval = getWoValue(wtpwo);
 // <<"%V $np <|$cval|>  \n"
 
             if (cval != "") {

             wc = choiceMenu("TPC.m");
//<<"menu choice  name or action  %V $wc\n";

           //  showTaskPts();

//pa("wc ", wc);
//ans=query("?",wc,__LINE__);

              if (wc == "M") { // replace

               printf("REPLACE TP \n");
	       
          //     wc=choiceMenu("CTP.m");

               
                    printf("REPLACE TP via Map select\n");
                     replace_tp(Witp);
               
               }
	       else if (wc == "N") { // replace

         printf("REPLACE TP via Name select\n");	    
//ans=query("?","N",__LINE__);
                 PickViaName(Witp);
//		     <<"DONE REPLACE via name\n"
	     
               }
            
               else if (wc == "D") {
                printf("delete and move lower TPs up Witp %d nt %d !\n",Witp,Ntaskpts);
                delete_tp(Witp); //
	        Task_update =1;
                //<<"Done delete  $Ntaskpts!\n"		
              }
              else if (wc == "P") {
             printf("INSERT TP $wc \n");
            // wc=choiceMenu("ITP.m");
//printf("choose how? %s\n",vtoa(wc));		
                  insert_tp(Witp);
              }
              else if (wc == "I") {
	         printf("INSERT TP vian name \n");
                 insert_name_tp(Witp);
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
	   

                 //sWo(tpwo,_WREDRAW);
                 //sWo(legwo,_WREDRAW);		 
                // sWo(wtpwo,_Wcxor);
                 showTaskPts();
       }
       else if (WoName == "ALT") {
       
       	 sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_); // should erase precious target position
	 
         drawit = 0;
         dindex = rint(Gerx);

//<<"%V $erx, alt $ery  $dindex $IGCELE[dindex] $IGCLAT[dindex] $IGCLONG[dindex] \n";
         symx = IGCLONG[dindex];
	 symy = IGCLAT[dindex];
	 symem = IGCELE[dindex] ;
	 syme = IGCELE[dindex] *  3.280839;
	// <<"%V $symx $symy $syme  \n"

          sWo(_WOID,mapwo,_WPIXMAP,OFF_,_WDRAW,ON_); // just draw but not to pixamp
       if (Ev_button == 1 || Ev_button == 4) {

	  sGl(_GLID,st_lc_gl,_GLCURSOR,rbox(Gerx,0,Gerx,20000, CL_init));
	 // dGl(lc_gl);
	  CL_init = 0;
	   zoom_begin = Gerx;

           plotSymbol(mapwo,symx,symy,CROSS_,symsz,MAGENTA_,1);
           plotSymbol(mapwo,symrx,symry,DIAMOND_,symsz,LILAC_,1,90);		  


         }

       if (Ev_button == 3 || Ev_button == 5) {


	  sGl(_GLID,st_rc_gl,_GLCURSOR,rbox(Gerx,0,Gerx,20000, CR_init));
          //dGl(rc_gl);
	  CR_init = 0;


         symrx = IGCLONG[dindex];
	 symry = IGCLAT[dindex];
	 
	 symem = IGCELE[dindex] ;
	 syme = IGCELE[dindex] *  3.280839;

          plotSymbol(mapwo,symx,symy,CROSS_,symsz,MAGENTA_,1);
          plotSymbol(mapwo,symrx,symry,DIAMOND_,symsz,LILAC_,1,90);		  
	  
           zoom_end = Gerx;
	   
	  // Task_update = 1;
	   
          // save end time  for zoomin
       }

//	 swo(mapwo,_WCLEAR,_WCLEARCLIP,BLUE_,_WCLEARPIXMAP);
	 

	 drawAlt();


//<<"%V $zoom_begin $zoom_end  $mapwo $vvwo \n"
	 sWo(_WOID,sawo,_WVALUE,"$symx $symy $syme ",_WREDRAW,ON_);
	 
       }
       else if (WoName == "ZOOM") {
        // find LatN,LatS,LongW,LongE for the time range zoom_begin , zoom_end
        // add margin
	// set and update map

        VCOUT(zoom_begin, zoom_end);
	zoomMap(zoom_begin, zoom_end);
	 
        Task_update =1;

       }
       else if (WoName == "MAP") {
       pa("in map", Gerx, Gery);

               drawit = 0;

               ntp = ClosestLand(Gerx,Gery);

             if (ntp >= 0) {

               Wtp[ntp].Print();
               nval = Wtp[ntp].GetPlace();
	       pa(ntp, nval);
            //  <<" found %V $ntp $nval \n"
	         sprintf(Gpos,"%d %s",ntp,nval.cptr());
                Text(  vptxt,Gpos,0,0.05,1);
		
                ST_msl = Wtp[ntp].Alt;
                mkm = HowFar(Gerx,Gery, Wtp[ntp].Longdeg, Wtp[ntp].Ladeg);
                ght = (mkm * km_to_feet) / LoD;
//		<<"%V $ght $mkm $km_to_feet  $LoD \n" 
		
                safealt = ST_msl + ght + 2000;


	         sprintf(Gpos,"%s %f",nval.cptr(), safealt);
          	//sWo(sawo,_WVALUE,"$nval %5.1f $ST_msl $mkm $safealt",_WREDRAW);
		woSetValue(sawo,_WVALUE,Gpos);
		
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
          // <<" task type is $_Gekeyw \n"
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

   //   woSetValue(tdwo,totalK);
   //   sWo(_WOID,tdwo,_WUPDATE,ON_);

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

       //sWo(tpwo,_WREDRAW);
       //sWo(legwo,_WREDRAW);		 
      }

   //  sWi(vp,_WREDRAW);

 taskDist();
    //drawTrace();
   // drawTask(mapwo,RED_);
 
//	 sWo(mapwo,_WSHOWPIXMAP);
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









///
/// "$Id: showtask.asl,v 1.5 1997/07/21 15:01:08 mark Exp mark $"
///

# map of turn_points

//envDebug()

#define DBG <<

include "ootlib"


TaskType = "TRI"; 

int Nlegs = 1;

Turnpt  Wtp[500];


/// open turnpoint file lat,long 

tp_file = GetArgStr()

  if (tp_file @= "") {
    tp_file = "turnpts.dat"  // open turnpoint file 
   }

  A=ofr(tp_file)
  

  if (A == -1) {
    exit(-1," can't find turnpts file \n");
   
  }



 //  Read in a Task via command line
  Ntaskpts = 0;
  Ntp = 0;

 svar Wval;

// nwr = Wval->Read(A)
// nwr = Wval->Read(A);  // clear the header on this file

//<<"%V $nwr $Wval\n"

         C=readline(A);
	 C=readline(A);

  while (1) {

            nwr = Wval->Read(A)

            //nwr = Wtp[Ntp]->Read(A);
	    
//<<"%V $nwr $Wval\n"

            if (nwr == -1) {
	      break
            }
	    
            if (nwr > 6) { 
//<<"$Wval[0]\n";
             Wtp[Ntp]->Set(Wval);

             //Wtp[Ntp]->Print()

             Ntp++;
            }
      }

<<" Read $Ntp turnpts \n"

 if (Ntp < 1) {
  exit("BAD turnpts");
 }
////////////////////////////////////


/////////////////// TASK DEF ////////////
Taskpt Tasktp[50];

Units = "KM"


/////////////  Arrays : Globals //////////////

LatS= 39.5;

LatN = 41.0;

LongW= 105.5;

LongE= 104.8;

MidLat = (LatN - LatS)/2.0 + LatS;
MidLong = (LongW - LongE)/2.0 + LongE;


int tp_wo[20];
int gtp_wo[20];
int ltp_wo[20];




LoD = 30;

char MS[240]
char Word[128]
char Long[128]
num_tpts = 700

float R[10];


//////////////// PARSE COMMAND LINE ARGS ///////////////////////
  while (AnotherArg()) {

    Fseek(A,0,0)
    targ = GetArgStr()
<<" looking for  $targ \n"
    i=Fsearch(A,targ,-1,1,0)
    if (i == -1)
        break
<<" found $targ \n"
    Tasktp[Ntaskpts]->cltpt = targ
    nwr = Tasktp[Ntaskpts++]->Read(A)
  }



///////////////////// SETUP GRAPHICS ///////////////////////////

Graphic = CheckGwm();

  if (!Graphic) {
    Xgm = spawnGwm("ShowTask")
  }

// create window and scale

  vp = cWi("title","vp","resize",0.1,0.01,0.9,0.95,0)

  sWi(vp,"scales",-200,-200,200,200,0, @drawoff,@pixmapon,@save,@bhue,WHITE_); // but we dont draw to a window!

  sWi(vp,"clip",0.01,0.1,0.95,0.99);

  vptxt= cWo(vp,@TEXT,@resize_fr,0.55,0.01,0.95,0.1,@name,"TXT",@color,WHITE_,@save,@drawon,@pixmapoff);

  tdwo= cWo(vp,@BV,@resize_fr,0.01,0.01,0.14,0.1,@name,"TaskDistance",@color,WHITE_,@style,"SVB");

  sawo= cWo(vp,@BV,@resize_fr,0.15,0.01,0.54,0.1,"name","SafetyAlt",@color,WHITE_,@style,"SVB");

  vvwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.11,0.95,0.25,@name,"MAP",@color,WHITE_);

  sWo(vvwo, @scales, 0, 0, 86400, 3000, @save, @redraw, @drawon, @pixmapon);

  mapwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.26,0.95,0.95,@name,"MAP",@color,WHITE_);

<<"%V $mapwo \n"

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon);


  int tpwo[20];
  
  tpwo[0]=cWo(vp,@BV,"name","_Start_",@style,"SVB",@drawon)

  tpwo[1] =cWo(vp,@BV,"name","_TP1_",@style,"SVB",@drawon)

  tpwo[2] =cWo(vp,@BV,"name","_TP2_",@style,"SVB", @drawon)

  tpwo[3] =cWo(vp,@BV,"name","_TP3_",@style,"SVB", @drawon)

  tpwo[4] =cWo(vp,@BV,"name","_TP4_",@style,"SVB", @drawon)

  tpwo[5] =cWo(vp,@BV,"name","_TP5_",@style,"SVB", @drawon)

  tpwos = tpwo[0:5];

  <<"%V $tpwos\n"
  wovtile(tpwos, 0.02, 0.4, 0.15, 0.95)

  sWo(tpwos,@redraw);

  TASK_wo=cWo(vp,@TB_MENU,@resize,0.1,0.9,0.2,0.99);
  
<<"%V$TASK_wo\n"

  sWo(TASK_wo, @help, "Set Task Type", @name, "TaskType", @func,  "wo_menu",  @menu, "SO,TRI,OAR,W,MT",  @value, "W")


 if (Ntaskpts > 1) {
  sWo(tpwo[0],"value",Tasktp[0]->cltpt)
  sWo(tpwo[1],"value",Tasktp[1]->cltpt)
 }

 if (Ntaskpts > 2) {
  sWo(tpwo[2],"value",Tasktp[2]->cltpt)
 }


  for (k = 0; k < Ntaskpts ; k++) {
      Tasktp[k]->Print()
  }


/{/*

start_key = "sal"
key[1] = "saf"
finish_key = "sal"

tpt[0] = find_key(start_key)
tpt[1] = find_key(key[1])
tpt[2] = find_key(finish_key)

ntpts = 2

total = task_dist()

w_set_wo_value (tw,td_wo,total,1)
w_set_wo_value (tw,start_wo,start_key,1)

tp_wo[0] = start_wo

w_set_wo_value (tw,tp_wo[1],key[1],1)
ff=w_set_wo_value (tw,finish_wo,finish_key,1)


TT="tri"

  if ( !(TT @= ""))  {
    w_set_wo_value(tw,tclass_wo,TT)
  }

tfile= "cfi/TASKS/K300.tsk"

read_task(tfile,0)

set_task()

#grid_label(tw)


      zoom_to_task(tw,0)
      zoom_out(tw,0)
      zoom_out(tw,1)


/}*/

   c= "EXIT"

   sWi(vp,@redraw); // need a redraw proc for app

   //igcfn = "spk.igc"

  igcfn = "bike_4_23.igc"

   Ntpts=IGC_Read(igcfn);

<<"sz $Ntpts $(Caz(IGCLONG))   $(Caz(IGCLAT))\n"

      k = Ntpts - 30;

<<"%(10,, ,\n) $IGCLONG[0:30] \n"
<<"%(10,, ,\n) $IGCLONG[k:Ntpts-1] \n"

//<<"%(10,, ,\n) $IGCLAT[0:30] \n"
//<<"%(10,, ,\n) $IGCELE[0:30] \n"
//<<"%(10,, ,\n) $IGCTIM[0:30] \n"

     sslng= Stats(IGCLONG)
<<"%V $sslng \n"

     sslt= Stats(IGCLAT)
<<"%V $sslt \n"

     ssele= Stats(IGCELE)
<<"%V $ssele \n"


//  set up the IGC track for plot
    igc_tgl = cGl(mapwo,@TXY,IGCLONG,IGCLAT,@color,BLUE_);

    igc_vgl = cGl(vvwo,@TY,IGCELE,@color,RED_);

    DrawMap(mapwo);   // show the turnpts

   if (Ntpts > 0) {
    DrawGline(igc_tgl);  // plot the igc track -- if supplied

    sWo(vvwo, @scales, 0, 0, Ntpts, 3000 )
    DrawGline(igc_vgl);  // plot the igc climb -- if supplied
   }

# main
setdebug(0,"proc");

int wwo = 0;
int witp = 0;
int drawit = 0;
msgv = "";

float d_ll = 0.05;

keyw = "";

float mrx;
float mry;
str wcltpt="XY";

gevent E;

  while (1) {

    drawit = 1

    E->waitForMsg()

    keyw = E->getEventKeyw();
    keyc = E->getEventKey();
    woname = E->getEventWoName();    
    wwo = E->getEventWoid();
    
    E->getEventRXY(mrx,mry);    


<<"%V $keyw $keyc $woname\n"; 

    Text(vptxt," $keyw   ",0,0.05,1)

       if ( ! (keyc @= "")) {

       d_ll = (LatN-LatS)/ 10.0 

       if (keyc @= "Q") {
           LongW += d_ll
           LongE += d_ll
       }

       if (keyc @= "S") {
           LongW -= d_ll
           LongE -= d_ll
       }

       if (keyc @= "R") {
           LatN += d_ll
           LatS += d_ll
       }

       if (keyc @= "T") {
           LatN -= d_ll
           LatS -= d_ll
       }


       if (keyc @= "x") {
           LatN += d_ll
           LatS -= d_ll
           LongW += d_ll
           LongE -= d_ll

       }

       if (keyc @= "z") {
           LatN -= (d_ll * 0.9)
           LatS += (d_ll * 0.9)
           LongW -= (d_ll * 0.9)
           LongE += (d_ll * 0.9)
       }

       if (keyw @= "_Start_") {
             sWo(wwo, @cxor)
             if (PickaTP(0)) {
	     wcltpt = Tasktp[0]->cltpt;
               sWo(tpwo[0],@value,wcltpt,@redraw)
             }
	     sWo(wwo, @cxor)
       }


       if (scmp(keyw,"_TP",3)) {

             np = spat(keyw,"_TP",1)
             np = spat(np,"_",-1)

             witp = atoi(np);
             wwo = tpwo[witp]

             wcltpt = Tasktp[witp]->cltpt

<<" %V $keyw $np $witp $wwo $wcltpt\n"

             sWo(wwo, @cxor);
	     gflush();

             if (PickaTP(witp)) {

              wcltpt = Tasktp[witp]->cltpt;

<<"%V $wwo $wcltpt\n"

              sWo(wwo,@value,wcltpt,@redraw);
    
             }

           sWo(wwo,@cxor);

       }


       if (keyw @= "MAP") {

               drawit = 0;

               ntp = ClosestLand(mrx,mry);

             if (ntp >= 0) {

               Wtp[ntp]->Print()
               nval = Wtp[ntp]->GetPlace()
	       
              <<" found %V $ntp $nval \n"
                Text(  vptxt," $ntp $nval   ",0,0.05,1)
                msl = Wtp[ntp]->Alt;
                mkm = HowFar(mrx,mry, Wtp[ntp]->Longdeg, Wtp[ntp]->Ladeg)
                ght = (mkm * km_to_feet) / LoD;
                sa = msl + ght + 2000;
          	sWo(sawo,@value,"$nval %5.1f $msl $mkm $sa",@redraw)

             }

        }



       if ( keyw @= "Menu") {
           <<" task type is $keyw \n"
           TaskType = keyw;
           <<" Set %V$TaskType \n"
       }


        if (drawit) {
	
        sWo(mapwo, @scales, LongW, LatS, LongE, LatN )
        sWo(mapwo,@clearpixmap,@clipborder);

        //DrawTask(mapwo,"orange")
        DrawMap(mapwo);
	if (Ntpts > 0) {
        sWo(vvwo, @scales, 0, 0, Ntpts, 6000 )
        DrawGline(igc_tgl);
	sWo(vvwo,@clearpixmap,@clipborder);
	DrawGline(igc_vgl);
        sWo(mapwo,@showpixmap);
        sWo(vvwo,@showpixmap);
	}
        }

      }

  }
///

//////////////////////////// TBD ///////////////////////////////////////////
/{/*


 BUGS:  
        not showing all WOS -- title button


 Task definition : intial via CL  type{OB,TRI,SO, W, OLC}   tp1,tp2,tp3 ...

 Task definition : via WO click

 should show TP,TA info when click on map

 scroll map buttons


 ADD:

  readIGC - C++ function  done

  can we plot on top sectional image - where to get those?


  projection  --  square degress - square map window --- conical??

  plot plane position as scroll in vvwo


  need task distance ---
  and task plotting to work


  ?? what happed to viewterrain and elevation - magic carpet viewer??


  menus



/}*/









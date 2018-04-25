///
/// "$Id: showtask.asl,v 1.5 1997/07/21 15:01:08 mark Exp mark $"
///

# map of turn_points

//envDebug()


include "ootlib"




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

  sWo(vvwo, @scales, 0, 0, 86400, 8000, @save, @redraw, @drawon, @pixmapon);

  mapwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.26,0.95,0.95,@name,"MAP",@color,WHITE_);

<<"%V $mapwo \n"

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon);





   c= "EXIT"

   sWi(vp,@redraw); // need a redraw proc for app

   //igcfn = "spk.igc"


igcfn = GetArgStr()

  if (igcfn @= "") {
  igcfn = "spk.igc"
   }


  

   Ntpts=IGC_Read(igcfn);

<<"sz $Ntpts $(Caz(IGCLONG))   $(Caz(IGCLAT))\n"

      k = Ntpts - 30;

<<"%(10,, ,\n) $IGCLONG[0:30] \n"
<<"%(10,, ,\n) $IGCLONG[k:Ntpts-1] \n"

//<<"%(10,, ,\n) $IGCLAT[0:30] \n"
//<<"%(10,, ,\n) $IGCELE[0:30] \n"
//<<"%(10,, ,\n) $IGCTIM[0:30] \n"

     sslng= Stats(IGCLONG,">",0)
<<"%V $sslng \n"

      min_lng = sslng[5];
      max_lng = sslng[6];
<<"%V $min_lng $max_lng \n"

     sslt= Stats(IGCLAT,">",0)
<<"%V $sslt \n"

      min_lat = sslt[5];
      max_lat = sslt[6];
<<"%V $min_lat $max_lat \n"

     ssele= Stats(IGCELE,">",0)
<<"%V $ssele \n"
       min_ele = ssele[5];
      max_ele = ssele[6];
<<" min ele $ssele[5] max $ssele[6] \n"

  LatS = min_lat -0.1;
  LatN = max_lat+0.1;

  LongW = max_lng +0.1;
    LongE = min_lng -0.1;




  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon);


//  set up the IGC track for plot
    igc_tgl = cGl(mapwo,@TXY,IGCLONG,IGCLAT,@color,BLUE_);

    igc_vgl = cGl(vvwo,@TY,IGCELE,@color,RED_);

    DrawMap(mapwo);   // show the turnpts

   if (Ntpts > 0) {
    DrawGline(igc_tgl);  // plot the igc track -- if supplied

    sWo(vvwo, @scales, 0, min_ele, Ntpts, (max_ele+50) )
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




       if (keyw @= "MAP") {

               drawit = 0;

               ntp = ClosestLand(mrx,mry);



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









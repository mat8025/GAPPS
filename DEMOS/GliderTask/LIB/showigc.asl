/* 
 *  @script showigc.asl 
 * 
 *  @comment show igc trace 
 *  @release CARBON 
 *  @vers 2.2 He Helium [asl 6.3.30 C-Li-Zn] 
 *  @date 03/10/2021 09:50:10 
 *  @cdate 7/21/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                            
///
/// "$Id: showigc.asl,v 1.5 1997/07/21 15:01:08 mark Exp mark $"
///


// map of turn_points


#include "debug"
#include "hv.asl"


#include "ootlib"




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


igcfn = GetArgStr()

  if (igcfn @= "") {
      igcfn = "IGC/spk.igc"
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



///////////////////// SETUP GRAPHICS ///////////////////////////
#include "graphic"
#include "showigc_scrn"


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


int wwo = 0;
int witp = 0;
int drawit = 0;
msgv = "";

float d_ll = 0.05;

keyw = "";

int m_num =0;
str wcltpt="XY";

#include "gevent"

  while (1) {

    drawit = 1
    msg =eventWait();
    m_num++;
    
<<"%V $m_num $msg  $_ename $_ewoname $_ekeyc \n"


    Text(vptxt," $_ekeyw   ",0,0.05,1)

       if ( ! (_ekeyc @= "")) {

       d_ll = (LatN-LatS)/ 10.0 

       if (_ekeyc @= "Q") {
           LongW += d_ll
           LongE += d_ll
       }

       if (_ekeyc @= "S") {
           LongW -= d_ll
           LongE -= d_ll
       }

       if (_ekeyc @= "R") {
           LatN += d_ll
           LatS += d_ll
       }

       if (_ekeyc @= "T") {
           LatN -= d_ll
           LatS -= d_ll
       }


       if (_ekeyc @= "x") {
           LatN += d_ll
           LatS -= d_ll
           LongW += d_ll
           LongE -= d_ll

       }

       if (_ekeyc @= "z") {
           LatN -= (d_ll * 0.9)
           LatS += (d_ll * 0.9)
           LongW -= (d_ll * 0.9)
           LongE += (d_ll * 0.9)
       }
    }
    
       if (_ekeyw @= "_Start_") {
             sWo(wwo, @cxor)
             if (PickaTP(0)) {
	     wcltpt = Tasktp[0]->cltpt;
               sWo(tpwo[0],@value,wcltpt,@redraw)
             }
	     sWo(wwo, @cxor)
       }

       if (_ekeyw @= "MAP") {

    //

               ntp = ClosestLand(_erx,_ery);
        }


        if (drawit) {
	<<"drawing !\n"
        sWo(mapwo, @scales, LongW, LatS, LongE, LatN )
        sWo(mapwo,@clearpixmap,@clipborder,@savepixmap);

        //DrawTask(mapwo,"orange")
        DrawMap(mapwo);
	if (Ntpts > 0) {
        sWo(vvwo, @scales, 0, 0, Ntpts, 6000 )
        DrawGline(igc_tgl);
	sWo(vvwo,@clearpixmap,@clipborder,@savepixmap);
	DrawGline(igc_vgl);
        sWo(mapwo,@showpixmap);
        sWo(vvwo,@showpixmap);
	}
    }

     

  }
///

//////////////////////////// TBD ///////////////////////////////////////////
/*


 BUGS:  
        not showing all WOS -- title button


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









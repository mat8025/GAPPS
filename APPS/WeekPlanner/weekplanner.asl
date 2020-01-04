//%*********************************************** 
//*  @script weekplanner.asl 
//* 
//*  @comment plan/log the week 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sat Nov  2 12:37:08 2019
//*  @cdate Sat Nov  2 12:21:49 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
/// Track activities for a day
///
/// show summaries/stats for week/last month
///




include "debug.asl"
include "gevent.asl"
//include "gss.asl";
include "hv.asl"

debugOFF()

include "weekplanner_menus.asl";
//include "calcounter_ssp.asl";



/////////////////////////////
proc Save ()
{
          <<" saving_the_week \n"	       
         sWo(awo,@sheetmod,1);
	 sWi(aw,@tmsg,"saving_the_week ");
          <<" week sheet saved \n"
}
//=======================================//







//=======================================//

activ = "idle"

  dstr= !!"date "
<<"$dstr \n"
  wks = split(dstr);
  ys = wks[5];
  yrn = atoi(ys)

  //mon = wks[1];
  mon = !!"date +\%B";
  
  dayname = wks[0];
  daydate = atoi(wks[2]);
  
  wks= !!"date +\%V"
<<"$wks $(typeof(wks)) $(Caz(wks))\n";
<<"%V $wks\n"
 ws0=wks[0];
 wkn = atoi(ws0);


  dstr= !!"date +\%w"
  dow = atoi(dstr);




///////////////////////
<<"-------------\n"
ds = date(2);
jd = julian(ds);
<<"%V$ds $jd\n"
dow2 = !!"date +\%u"
dn= atoi(dow2);
<<"%V$dow2 $dn\n"
dn--;

int wdn[8];
int nd = 1;

for (wd = jd-dn; wd < (jd+(7-dn)) ; wd++) {

dstr = julmdy(wd);
<<"$wd $dstr\n"
dt = Split(dstr,"/");
wdn[nd] = atoi(dt[1]);
nd++;
}

<<"$wdn \n";

////////////////////////




<<" we are in week $wkn $yrn mon $mon $dayname $daydate\n";

  sheet_name = scat("Journal/WeekPlan_","$wkn","_","$yrn");
  <<"%V $sheet_name\n"
  //sfname = scat(sheet_name,".sst");
  sfname = "Journal/WeekPlan_${wkn}_${yrn}.sst");
<<"%V $sfname\n"


  Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }

 rows = 15; // set row and log row per day
 cols = 52;




 // check find and read in sheet_wk_year - 
 // what week are we in?
 // is Week_#_yr  sst there ?
 // yes -read it in

  need_new =1;

  isok = 0;

	 
include "weekplanner_scrn"

int nada = 0;

   loopon = 1;

   while (loopon) {
   
         nada = 0;
         eventWait();

<<"%V $_ewoid \n"


        if (_ewoid == savewo) {
               Save();
        }

        if (_ewoid == qwo) {
	 //sWo(awo,@sheetmod,1);

         <<"need to save !?!\n"
	 
	 sWi(aw,@tmsg,"quit_the_week ");
            <<" save first ? quit \n"
	    ans = popamenu("Quit.m")
	    <<"save $ans\n"
	    if (ans @="Yes") {
	        loopon = 0;
               break;
            }
         }

        if (_ewoid == amwo) {
	 sWi(aw,@tmsg,"morning");
	 <<" display morning cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);

         sWo(awo,@displaycols,0,51,0); // clear
	 sWo(awo,@displaycols,0,0,1);  // select
         sWo(awo,@displaycols,15,26,1);
	 sWo(awo,@displaycols,49,51,1);

         sWo(awo,@redraw);
        }

        if (_ewoid == oowo) {
	 sWi(aw,@tmsg,"good morning");
	 <<" display morning cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);

         sWo(awo,@displaycols,0,51,0); // clear
	 sWo(awo,@displaycols,0,0,1);  // select
         sWo(awo,@displaycols,1,16,1); // seite ahoras 
	 sWo(awo,@displaycols,49,51,1);

         sWo(awo,@redraw);
        }

        if (_ewoid == pmwo) {
	 sWi(aw,@tmsg,"afternoon");
	 <<" display pm cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);
         sWo(awo,@displaycols,0,51,0);
	 sWo(awo,@displaycols,25,39,1);
         sWo(awo,@displaycols,0,0,1);
	 sWo(awo,@displaycols,49,51,1);
	 sWo(awo,@redraw);
         }


        if (_ewoid == evewo) {
	 sWi(aw,@tmsg,"buenas noches");
	 <<" display evening cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);
         sWo(awo,@displaycols,0,51,0);
	 sWo(awo,@displaycols,37,51,1);
         sWo(awo,@displaycols,0,0,1);
	 sWo(awo,@redraw);
         }


        if (_ewoid == daywo) {
	 sWi(aw,@tmsg,"wholeday");
	 <<" display pm cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);
	 sWo(awo,@displaycols,0,51,0);
	 sWo(awo,@displaycols,0,0,1);	 
         sWo(awo,@displaycols,15,51,1);
	 sWo(awo,@redraw);
         }

// which row col should be an event
// erow,ecol

    wrow = _erow;
    wcol = _ecol;
    
    last_hue = BLACK_;
    <<"%V $_erx $_ery $wrow $wcol\n"
    
    if ( (wrow > 0) && (wrow <= 14) && (wcol > 0) && ( wcol <= 51)) {
        appt = 0;
        if ((wrow % 2) == 0) {
//	 sWi(aw,@tmsg,"stuff done! ");
	 sWi(aw,@tmsg,com_done);
        }
	else {
         //sWi(aw,@tmsg,"set appt? task?");
	 sWi(aw,@tmsg,com_appt);
	 appt = 1;
        }

       mans = popamenu("Activity.m")

       // <<"%V$mans\n"

	
        if (!(mans @= null_choice)) {
	   sWi(aw,@tmsg,"adding activity $mans");
         if ((mans @= "Bike")) {
           last_hue = RED_;
	 }
         else if ((mans @= "Wtrain")) {
           last_hue = RED_;
	 }	 
	 else if ((mans @= "Walk") ) {
             last_hue = BLACK_

         }
	 else if ((mans @= "Ski") ) {
             last_hue = RED_
	 }	 
	 else if ((mans @= "Guitar") ) {
            last_hue = GREEN_;
	 }
	 else if ((mans @= "Piano") ) {
            last_hue = MAGENTA_;
	 }	 
        else if ((mans @= "Francais") ) {
            last_hue = RED_;
	 }
        else if ((mans @= "Russian") ) {
            last_hue = RED_;
	 }	 
        else if ((mans @= "Flying") ) {
            last_hue = BLUE_;
	 }
        else if ((mans @= "Sleep") ) {
            last_hue = BLUE_;
	 }
        else if ((mans @= "Espanol") ) {
            last_hue = BLACK_;
	 }	 	 	 
	 else {
	   <<"work $mans \n"
	   sWo(awo,@cellhue,wrow,wcol,BLACK_);
	 }
	 

         if ((mans @= "nada") ) {
             mans = " ";
	     nada =1;
	     <<" should be null string but <|$mans|>\n"
	 }
	 else {
	 <<" adding $mans to sheet $wrow $wcol\n"

	 }

         sWo(awo,@redraw);
   
         if (! (mans @= null_choice)) {

         nans = popamenu("Howlong.m");
	 //nans = popamenu(how_long_menu);
         n_extra = atoi(nans);
	 // these are selected row and col as displaeyd

         stuff = "$mans"; // no comma
         if (appt) {
	   if (!nada) {  
           stuff = scat(stuff,"?");
           }
         }


         for (i = 0; i < n_extra; i++) {
	  sWo(awo,@cellhue,wrow,wcol+i,last_hue);
          sWo(awo,@sheetcol,wrow,wcol+i,"$stuff,");
//<<"$i %V $stuff $wrow $(wcol+i) \n"
         }
	  
//	  sWo(awo,@redraw);
	}
        }
    }
        sWi(aw,@redraw);
        sWo(awo,@redraw);
    } // loop end

//===================================================  

 exit(); // takes down XGS as well
 



//////////// TBD ////////////////
/{/*

 quit button DONE
 title message
 sheetwo -- should have wo cell per spreadsheet cell - 
 save  sheet -- done
 read sheet

 score day
 score week
 now have day as two rows -- top appointments/tasks  --- bottom stuff done
 score can check performance of set tasks and stuff accomplished
 also amount of activity

  am/pm view 
  day/eve view

  highlite today - done

  save dialog - save changes

  add dates - done
  check for current week

  weight entry -done

  rudimentary score

  add last actvity  whereever selected

/}*/

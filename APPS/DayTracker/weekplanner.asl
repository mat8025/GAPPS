///
/// Track activities for a day
///
/// show summaries/stats for week/last month
///
setdebug(1,"~trace")

vers = "1.3"
////////////// Menus /////////////

A=ofw("Activity.m")
<<[A],"title Activity\n"
<<[A],"item Exercise C_MENU Exer\n"
<<[A],"help what exercise\n"
<<[A],"item Code M_VALUE Code\n"
<<[A],"help \n"
<<[A],"item Gapp M_VALUE Gapp\n"
<<[A],"help gasp app dev\"
<<[A],"item ASR M_VALUE ASR\n"
<<[A],"help \n"
<<[A],"item DSP M_VALUE DSP\n"
<<[A],"help \n"
<<[A],"item Guitar M_VALUE Guitar\n"
<<[A],"help \n"
<<[A],"item Piano M_VALUE Piano\n"
<<[A],"help \n"
<<[A],"item Lang C_MENU Lang French\n"
<<[A],"help \n"
<<[A],"item Yard M_VALUE YardW\n"
<<[A],"help \n"
<<[A],"item Barn M_VALUE BarnW\n"
<<[A],"help fixing our barn\n"
<<[A],"item House M_VALUE HouseW\n"
<<[A],"help \n"
<<[A],"item Flying M_VALUE Flying\n"
<<[A],"help \n"
<<[A],"item Nap M_VALUE Nap\n"
<<[A],"help \n"
<<[A],"item Sleep M_VALUE Sleep\n"
<<[A],"help must sleep now\n"
<<[A],"item Nothing M_VALUE nada\n"
<<[A],"help nothing to see here\n"
<<[A],"item ? C_INTER que\n"
<<[A],"help type the activity\n"
cf(A)

////////////////////////////////


A=ofw("Lang.m")
<<[A],"title Lang\n"
<<[A],"item Spanish M_VALUE Espanol\n"
<<[A],"help learn Spanish\n"
<<[A],"item German M_VALUE Deutsch\n"
<<[A],"help learn German\n"
<<[A],"item French M_VALUE Francais\n"
<<[A],"help learn French\n"
<<[A],"item Russian M_VALUE Russian\n"
<<[A],"help learn Russian\n"
cf(A)

/////////////////////////////

A=ofw("Exer.m")
<<[A],"title Exercise\n"
<<[A],"item Bike M_VALUE Bike\n"
<<[A],"help on your bike\n"
<<[A],"item Walk M_VALUE Walk\n"
<<[A],"help Walking\n"
<<[A],"item Gym M_VALUE Gym\n"
<<[A],"help Gym weight training\n"
<<[A],"item Ski M_VALUE Ski\n"
<<[A],"help downhill excitement\n"
cf(A)

/////////////////////////////

A=ofw("Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"help half-hour\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"help 1 hour\n"
<<[A],"item 3 M_VALUE 3\n"
<<[A],"help hour and half\n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"help two hours\n"
<<[A],"item 5 M_VALUE 5\n"
<<[A],"help two and half hours\n"
<<[A],"item 6 M_VALUE 6\n"
<<[A],"help three hours\n"
<<[A],"item 7 M_VALUE 7\n"
<<[A],"help three and half hours\n"
<<[A],"item 8 M_VALUE 8\n"
<<[A],"help  four hours\n"
cf(A)

//////////////////////////


////////////////////
activ = "idle"

  dstr= !!"date "
<<"$dstr \n"
  wks = split(dstr);
  yrn = atoi(wks[5])
  mon = wks[1];
  dayname = wks[0];
  daydate = atoi(wks[2]);
  
  wks= !!"date +\%V"
<<"$wks $(typeof(wks)) $(Caz(wks))\n";
  wkn = atoi(wks[0]);


  dstr= !!"date +\%w"
  dow = atoi(dstr);
  



<<" we are in week $wkn $yrn mon $mon $dayname $daydate\n";

  Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }

 rows = 15; // set row and log row per day
 cols = 52;

 // check find and read in sheet_wk_year - 
 // what week are we in?
 // is Week_#_yr.txt there ?
 // yes -read it in

  need_new =1;

  isok = 0;
  sheet_name = "WeekPlan_${wkn}_${yrn}";
  sfname = "WeekPlan_${wkn}_${yrn}.txt";

// make a window

    aw = cWi(@title,"DailyTracker_$vers",@resize,0.05,0.02,0.97,0.99)

    sWi(aw,@pixmapon,@drawoff,@save,@bhue,LILAC_)

    sWi(aw,@clip,0.05,0.1,0.95,0.97)

    lbp = 0.09;

    awo=cWo(aw,"SHEET",@name,"$sheet_name",@color,GREEN_,@resize,lbp,0.01,0.98,0.99)
 // does value remain or reset by menu?

    sWo(awo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_,@VALUE,"SSWO")
    sWo(awo,@bhue,CYAN_,@clipbhue,"skyblue")


  tfz = fexist(sfname);

<<"$sfname $tfz\n"
  if (tfz > 0) {
     // handshake this - via srs

     isok =sWo(awo,@sheetread,sfname);
     
     <<"sheetRead of $sfname is $isok\n"

     if (isok) {
         need_new = 0;
	 // how many rows & cols do we have?
     }
  }

//===============================================================

 //need_new =1;

 <<"%V$need_new\n"

  if (need_new) {
  
  <<"creating cells\n"

  sWo(awo,@setrowscols,rows,cols);
  // fill cols left legend
  sWo(awo,@sheetcol,0,0,"D/H,Mon,+>,Tue,+>,Wed,+>,Thu,+>,Fri,+>,Sat,+>,Sun_9,+>");

// TBF continue line  not correct

// fill top row - top legend
  sWo(awo,@sheetrow,0,1,"0,:30,1,:30,2,:30,3,:30,4,:30,\
5,:30,6,:30,\
7,:30,08,:30,\
09,:30,10,:30,11,:30,12,:30,\
13,:30,14,:30,15,:30,16,:30,\
17,:30,18,:30,19,:30,20,:30,\
21,:30,22,:30,23,:30,Wt,H, Score")

  }

  // label the days' dates


  sWo(awo,@sheetcol,0,0,"D/H,Mon,+>,Tue,+>,Wed,+>,Thu,+>,Fri,+>,Sat,+>,Sun ,+>");

/{
 mwo=cWo(aw,"MENU_FILE",@name,"Activities",@color,"green",@resize,0.21,0.8,0.3,0.9)
 // does value remain or reset by menu?
 sWo(mwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue",@VALUE,"Code",@STYLE,"SVB",@menu,"Activity.m")
 sWo(mwo,@bhue,RED_,@clipbhue,"skyblue");
/}


 
 savewo=cWo(aw,"BN",@name,"SAVE",@value,"SAVE",@color,MAGENTA_,@resize_fr,0.02,0.15,lbp,0.30)
 sWo(savewo,@help," click to save sheet")
 sWo(savewo,@border,@drawon,@clipborder,@fonthue,BLACK_, @redraw)


 qwo=cWo(aw,"BN",@name,"QUIT?",@value,"QUIT",@color,"orange",@resize_fr,0.02,0.01,lbp,0.14)
 sWo(qwo,@help," click to quit")
 sWo(qwo,@border,@drawon,@clipborder,@fonthue,BLACK_, @redraw)
 sWi(aw,@redraw)


 wkwo=cWo(aw,@BV,@name,"Week",@value," $wkn",@color,BLUE_,@fonthue,RED_,@penhue,BLACK_)
 sWo(wkwo,@help," This Week")

 yrwo=cWo(aw,@BV,@name,"Year",@value," $yrn",@color,YELLOW_,@fonthue,BLACK_)
 sWo(yrwo,@help," This Year")

 monwo=cWo(aw,@BV,@name,"Month",@value," $mon",@color,GREEN_,@fonthue,WHITE_)
 sWo(monwo,@help," This Month")


 int dmywos[] = { wkwo,monwo,yrwo}
 sWo(dmywos,@border,@drawon,@clipborder,@STYLE,"SVR")
 wovtile (dmywos, 0.02,0.85,lbp,0.95)
 
 sWo(dmywos,@redraw);
 /////////////////////////////////////////////////////////////

 amwo=cWo(aw,@BV,@name,"A.M.",@value,"",@color,BLUE_,@fonthue,RED_,@penhue,BLACK_)
 sWo(amwo,@help," Show a.m.")

 pmwo=cWo(aw,@BV,@name,"P.M.",@value,"",@color,YELLOW_,@fonthue,BLACK_)
 sWo(pmwo,@help," Show pm")

 daywo=cWo(aw,@BV,@name,"Day",@value,"",@color,YELLOW_,@fonthue,BLACK_)
 sWo(daywo,@help," Show day")

 int timewos[] = { amwo,pmwo,daywo}

 wovtile (timewos, 0.02,0.55,lbp,0.70,0.01)
 
 sWo(timewos,@redraw);




/////////////////

include "gevent.asl";

int wrow = 0;
int wcol = 0;
int appt = 0;
str mans = "nos";

 //sWo(awo,@selectrowscols,0,8,0,51);
//sWo(awo,@selectrowscols,0,8,16,51);

sWo(awo,@selectrowscols,0,14,0,51);
//sWo(awo,@displaycols,15,51,1);
sWo(awo,@displaycols,0,51,0);
sWo(awo,@displaycols,0,0,1);
sWo(awo,@displaycols,15,25,1);
//sWo(awo,@displaycols,25,51,1);

com_done = "stuff done";
com_appt = "set appt?";

act_menu = "Activity.m";
how_long_menu = "Howlong.m";
null_choice ="NULL_CHOICE";

sWo(awo,@cellhue,(((dow+6)%7)*2+1),0,"yellow");



 sWo(awo,@redraw);
 sWi(aw,@tmsg,"weekplanner $vers");

   while (1) {

         eventWait();

<<"%V $ev_woid  $qwo\n"

        if (ev_woid == qwo) {
	 sWi(aw,@tmsg,"Quit");
	 <<" exit planner \n"
         break;
        }

        if (ev_woid == savewo) {
	 sWo(awo,@sheetmod,1);
	 sWi(aw,@tmsg,"saving_the_week ");
            <<" saving_the_week \n"
        }

        if (ev_woid == amwo) {
	 sWi(aw,@tmsg,"morning");
	 <<" display morning cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);

         sWo(awo,@displaycols,0,51,0); // clear
	 sWo(awo,@displaycols,0,0,1);  // select
         sWo(awo,@displaycols,15,25,1);
	 sWo(awo,@displaycols,49,51,1);

         sWo(awo,@redraw);
        }

        if (ev_woid == pmwo) {
	 sWi(aw,@tmsg,"afternoon");
	 <<" display pm cols\n"
         sWo(awo,@selectrowscols,0,14,0,51);
         sWo(awo,@displaycols,0,51,0);
	 sWo(awo,@displaycols,25,51,1);
         sWo(awo,@displaycols,0,0,1);
	 sWo(awo,@redraw);
         }


        if (ev_woid == daywo) {
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

    wrow = ev_row;
    wcol = ev_col;
    
    last_hue = BLACK_;
    <<"%V $ev_rx $ev_ry $wrow $wcol\n"
    
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
             last_hue = ORANGE_

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
            last_hue = YELLOW_;
	 }
        else if ((mans @= "Russian") ) {
            last_hue = RED_;
	 }	 
        else if ((mans @= "Flying") ) {
            last_hue = BLUE_;
	 }
        else if ((mans @= "Sleep") ) {
            last_hue = PINK_;
	 }
        else if ((mans @= "Espanol") ) {
            last_hue = YELLOW_;
	 }	 	 	 
	 else {
	   <<"work $mans \n"
	   sWo(awo,@cellhue,wrow,wcol,BLACK_);
	 }
	 

         if ((mans @= "nada") ) {
             mans = " ";
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

         stuff = "$mans";
         if (appt) {
           stuff = scat(stuff,"?");
         }

         for (i = 0; i < n_extra; i++) {
	  sWo(awo,@cellhue,wrow,wcol+i,last_hue);
          sWo(awo,@sheetcol,wrow,wcol+i,"$stuff");
          }
	    sWo(awo,@redraw);
	}
        }
    }
        sWi(aw,@redraw);
        sWo(awo,@redraw);
    } // loop end

//===================================================  

 exit_gs(); // takes down XGS as well
 

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

  add dates

/}*/

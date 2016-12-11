///
/// Track activities for a day
///
/// show summaries/stats for week/last month
///
setdebug(1,"~trace")

////////////// Menus /////////////

A=ofw("Activity.m")
<<[A],"title Activity\n"
<<[A],"item Exercise C_MENU Exer\n"
<<[A],"help what exercise\n"
<<[A],"item Code M_VALUE Code\n"
<<[A],"help \n"
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
cf(A)



A=ofw("Lang.m")
<<[A],"title Lang\n"
<<[A],"item Spanish M_VALUE Espanol\n"
<<[A],"help learn Spanish\n"
<<[A],"item German M_VALUE Deutsch\n"
<<[A],"help learn German\n"
<<[A],"item French M_VALUE Francais\n"
<<[A],"help learn French\n"
cf(A)

A=ofw("Exer.m")
<<[A],"title Exercise\n"
<<[A],"item Bike M_VALUE Bike\n"
<<[A],"help on your bike\n"
<<[A],"item Walk M_VALUE Walk\n"
<<[A],"help Walking\n"
<<[A],"item Gym M_VALUE Gym\n"
<<[A],"help Gym weight training\n"
cf(A)

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




////////////////////
activ = "idle"

  wks= !!"date +\%V"
<<"$wks $(typeof(wks)) $(Caz(wks))\n";
  wkn = atoi(wks[0]);
<<" we are in week $wkn\n";

  yrn = date(8);
  mon = date(18);

 Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }

 rows = 50;
 cols = 8;

 // check find and read in sheet_wk_year - 
 // what week are we in?
 // is Week_#_yr.txt there ?
 // yes -read it in

  need_new =1;

  isok = 0;
  sheet_name = "Week_${wkn}_${yrn}";
  sfname = "Week_${wkn}_${yrn}.txt";



// make a window

    aw = cWi(@title,"DailyTracker",@resize,0.1,0.02,0.98,0.99)

    sWi(aw,@pixmapon,@drawoff,@save,@bhue,LILAC_)

    sWi(aw,@clip,0.1,0.1,0.9,0.95)


 awo=cWo(aw,"SHEET",@name,"$sheet_name",@color,GREEN_,@resize,0.1,0.01,0.98,0.99)
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

<<"%V$need_new\n"

  if (need_new) {
  
         <<"creating cells\n"

  sWo(awo,@setrowscols,rows,cols);
  sWo(awo,@sheetrow,0,1,"Mo,Tu,We,Th,Fr,Sa,Su");

// TBF continue line  not correct

  sWo(awo,@sheetcol,0,0,"Hour,0,0:30,1,1:30,2,2:30,3,3:30,4,4:30,\
5,5:30,6,6:30,\
7,7:30,8:0,8:30,\
9,9:30,10,10:30,11,11:30,12,12:30,\
13,13:30,14,14:30,15,15:30,16,16:30,\
17,17:30,18,18:30,19,19:30,20,20:30,\
21,21:30,22,22:30,23,23:30, Score")



//sWo(awo,@sheetcol,0,0,"Hour,0,0:30,1,1:30,2,2:30,3,3:30,4,4:30,5,5:30,6,6:30,7,7:30,8:0,8:30,9,9:30,10,10:30,11,11:30,12,12:30,13,13:30,14,14:30,15,15:30,16,16:30,17,17:30,18,18:30,19,19:30,20,20:30,21,21:30,22,22:30,23,23:30, Score")
  }


/{
 mwo=cWo(aw,"MENU_FILE",@name,"Activities",@color,"green",@resize,0.21,0.8,0.3,0.9)
 // does value remain or reset by menu?
 sWo(mwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue",@VALUE,"Code",@STYLE,"SVB",@menu,"Activity.m")
 sWo(mwo,@bhue,RED_,@clipbhue,"skyblue");
/}


 savewo=cWo(aw,"BN",@name,"SAVE",@value,"SAVE",@color,MAGENTA_,@resize_fr,0.02,0.15,0.1,0.30)
 sWo(savewo,@help," click to save sheet")
 sWo(savewo,@border,@drawon,@clipborder,@fonthue,BLACK_, @redraw)



 qwo=cWo(aw,"BN",@name,"QUIT?",@value,"QUIT",@color,"orange",@resize_fr,0.02,0.01,0.1,0.14)
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
 wovtile (dmywos, 0.02,0.85,0.1,0.95)
 
 sWo(dmywos,@redraw)

/////////////////

include "gevent.asl";

int wrow = 0;
int wcol = 0;

str mans = "nos";

 sWo(awo,@selectrowscols,0,49,0,7);
 
 sWo(awo,@redraw);
 
   while (1) {

         eventWait();


        if (ev_woid == qwo) {
	 sWi(aw,@tmsg,"Quit");
	 
         break;
        }

        if (ev_woid == savewo) {
	 sWo(awo,@sheetmod,1);
	  sWi(aw,@tmsg,"saving_the_day ");
            <<" saving_the_day \n"
        }



// which row col should be an event
// erow,ecol

    wrow = ev_row;
    wcol = ev_col;
    last_hue = BLACK_;
    <<"%V $ev_rx $ev_ry $wrow $wcol\n"
    
    if ( (wrow > 0) && (wrow <= 48) && (wcol > 0) && ( wcol <= 8)) {
    
       mans = popamenu("Activity.m")
       
       //mans = choice_menu("Activity.m")

        <<"%V$mans\n"

        if (!(mans @= "NULL_CHOICE")) {
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
	 else if ((mans @= "Guitar") ) {
            last_hue = GREEN_;
	 }
	 else if ((mans @= "Piano") ) {
            last_hue = MAGENTA_;
	 }	 
        else if ((mans @= "Francais") ) {
            last_hue = YELLOW_;
	 }
        else if ((mans @= "Flying") ) {
            last_hue = BLUE_;
	 }
        else if ((mans @= "Sleep") ) {
            last_hue = PINK_;
	 }
        else if ((mans @= "Espanol") ) {
            last_hue = RED_;
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
         if (! (mans @= "NULL_CHOICE")) {
         nans = popamenu("Howlong.m")
         n_extra = atoi(nans);
	 for (i = 0; i < n_extra; i++) {
	  sWo(awo,@cellhue,wrow+i,wcol,last_hue);
          sWo(awo,@sheetcol,wrow+i,wcol,"$mans");
         }
	    sWo(awo,@redraw);
	}
        }
    }

        sWo(awo,@redraw);
    } // loop end

//===================================================  

 //exit_gs(); // takes down XGS as well
 
 exit();


//////////// TBD ////////////////
/{
/*

 quit button
 title message
 sheetwo -- should have wo cell per spreadsheet cell - 
 save  sheet -- done
 read sheet

 score day
 score week

*/
/}

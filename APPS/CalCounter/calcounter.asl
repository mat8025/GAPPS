/////////////////////////////////////////////////////////////
///  calcounter
///
///  uses a food_table database - food_type cals,carbs,fat ...
///  The query looks for primary food then qualifiers and cooking
///  method.
///  Followed by amount (slice,cup,item) and the number of pieces,cups.
///  The query result presents a short list of 'hits' - in order of 
///  goodness of fit. If perfect fit just one item is shown.
/// 
///  User then can accept, reject and adjust the amount of food.
///  The accepted result is written to a daily log and the current
///  totals are shown.
///  
///  User can reset daily log.
///  The query loops until user quits.
///
///
///
///
///
///
///
/////////////////////////////////////////////////////////////
//


setdebug(1) ;

version = "1.5";

ele = spat( pt(atoi(spat(version,".",1))) ,",");

<<"$_clarg[0] $version $ele \n"

adjust_day = 0;

//#define DBPR <<
#define DBPR ~!

 f_unit = "item";
 
 float f_amt = 1.0;


include "foodclass";

include "parsefood" ;

include "checkFood";


//////////////////////////////////////////////////////////////////////////

ftfile = "food_table.dat" 

 A=  ofr(ftfile)

 if (A == -1) {
  <<" can't open food table $ftfile \n"
    exit();
 }

  S=readfile(A)
  nlines = Caz(S)

DBPR"%v$nlines\n"


 Nfoods  = nlines + 10;

 DBPR" now for $Nfoods foods\n"

 int n_f = Nfoods;

 Food Fd[n_f];

 Nfoods=parseFoodTable();

  myfood = "pie,apple"
  f_unit = "slice"
  f_amt = 1.0;

  //checkFood()

//////  PARSE THE COMMAND LINE //////

 do_loop = 0; // default - single shot query via CL args

 na = argc()

 wa = _clarg[1]

 if (! (wa @= "")) {
   if (scmp(wa,"dd_",3)) {
     adjust_day = 1;
     the_day = wa;
   }
   else {
  myfood = wa
<<" checking cals/carbs for $myfood \n";
  }
 }

 if (na > 1) {
  f_unit = _clarg[2]
 }

 if (na > 2) {
  f_amt = atof(_clarg[3])
 }


 if (na > 3) {
  val = _clarg[4]
  if (val @= "loop") {
     do_loop = 1
  }
}

//<<"$myfood  $f_unit  $f_amt\n"


 if (na > 1 && !adjust_day) {

 fnd= checkFood();

<<"again? %V$fnd \n"

 if (!fnd) {
   <<"Sorry could not find a match for $myfood\n";
 }

  exit()
 }


/////////////////////////////// UI /////////////////////////////////
#include "loopquery"


///////// dd_log_file ////////////
if (!adjust_day) {
 ds= date(2)
 ds=ssub(ds,"/","-",0);

 the_day = "dd_${ds}";
}

 ok=fexist(the_day,0);

<<"checking this day $the_day summary exists? $ok\n";

found_day = 0;

 if (ok >0) {
<<"$('PRED_') found the day $('POFF_')\n"
 B= ofile(the_day,"r+");
 readDD(B);
 cf(B);
 found_day =1;
 //fseek(B,0,2);
 }

 if (found_day) {
   showFitems();
 }


do_loop = 1;

 if (do_loop ) {
 
    fnd =queryloop();
<<" qloop exit $fnd\n"
  if (fnd) {

// write to daily log
// post the total
<<" post the total save to today $the_day\n"
!!"cp $the_day today"
    }
 }




Graphic = CheckGwm()
if (Graphic) {
 include "gui_query.asl"
}


stop!
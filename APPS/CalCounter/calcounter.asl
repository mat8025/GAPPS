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


setdebug(0) ;


version = "1.3";

<<"$_clarg[0] $version \n"


#define PGREEN '\033[1;32m'
#define PRED '\033[1;31m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'

//#define DBPR <<
#define DBPR

 f_unit = "item";
 
 float f_amt = 1.0;


include "food_class";

include "parse_foodtable" ;

include "checkFood";

// <<"$(PBLACK) yum \n"

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
  myfood = wa
//<<" looking for $myfood \n"
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

<<"$myfood  $f_unit  $f_amt\n"



 fnd= checkFood();

<<"again? %V$fnd \n"




 if (!fnd) {
   <<"Sorry could not find a match for $myfood\n";
 }




/////////////////////////////// UI /////////////////////////////////
include "loopquery"


///////// dd_log_file ////////////
 ds= date(2)
 ds=ssub(ds,"/","-",0)

 ok=fexist("dd_${ds}",0)
 if (ok >0) {
 B= ofile("dd_${ds}","r+")
 fseek(B,0,2);
 }
 else {
  B= ofile("dd_${ds}","w")
  <<[B]"#Food             Amt Unit Cals Carbs Fat Protein Chol(mg) SatFat Wt\n" 
 }




do_loop = 1;

 if (do_loop ) {
    fnd =queryloop();

  if (fnd) {

// write to daily log
// post the total

    }
 }




Graphic = CheckGwm()
if (Graphic) {
 include "gui_query.asl"
}


stop!
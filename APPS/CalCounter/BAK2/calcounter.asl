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


setdebug(1,"keep","~pline","steponerror") ;

#define  ASK ans=iread(()
//#define  ASK ;


version = "1.5";

ele = spat( pt(atoi(spat(version,".",1))) ,",");

<<"$_clarg[0] $version $ele \n"


svar Fdwords;

adjust_day = 0;

//#define DBPR <<
#define DBPR ~!

 f_unit = "item";
 
 float f_amt = 1.0;

include "parsefood" ;

include "checkFood";


//////////////////////////////////////////////////////////////////////////


 A=  ofr("foodtable.csv")

 if (A == -1) {
  <<" can't open food table $ftfile \n"
    exit();
 }

   RF= readRecord(A,@del,',')
   cf(A);
  Nrecs = Caz(RF);
  Ncols = Caz(RF[0]);


<<"num of records $Nrecs  num cols $Ncols\n"


   for (i= 0; i < 10; i++) {
       nc = Caz(RF[i]);
<<"<$i> $nc $RF[i] \n";
    }

    for (i= Nrecs -10; i < Nrecs; i++) {
    nc = Caz(RF[i]);
<<"<$i> $nc $RF[i] \n";
    }

  Nfoods  = Nrecs -1;

  DBPR" now for $Nfoods foods\n"

  //parseFoodTable();

  myfood = "pie apple"
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
int fnd = 0;
int bpick;
int Bestpick[5][2];

 if (na > 1 && !adjust_day) {

while (1) {

    Bestpick = -1;
   <<"$Bestpick\n"
   bpick= checkFood();

   if (bpick == -1) {
   <<"Sorry could not find a match for $myfood\n";
   }


ans= iread("search again? : [y]/n ")

if ((ans @="n") ) {
  exit()
 }

  ans=i_read("food $myfood ? : ")

  if (scmp(ans,"quit",4)) {
    exit()
  }

  if (! (ans @="") ) {
    myfood = ans;
    <<"nowsearching for %V$myfood \n"
  }
 
 }



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
 <<" in doloop \n"
    fnd =queryloop();

<<" qloop exit $fnd\n"


  if (fnd) {

// write to daily log
// post the total
<<" post the total save to today $the_day\n"
!!"cp $the_day today"
    }

 }



/{
Graphic = CheckGwm()
if (Graphic) {
 include "gui_query.asl"
}
/}

exit()
/* 
 *  @script ootlib.asl 
 * 
 *  @comment task-planner library 
 *  @release CARBON 
 *  @vers 4.5 B 6.3.83 C-Li-Bi 
 *  @date 02/17/2022 08:34:41          
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                      

///
///
#ifndef OOTLIB_

#define OOTLIB_ 1

  int Ntpts = 0;
  
  int Igcfn = -1;
  
  Str task_file = "XXX";

  float MSL=0;

  int Ntaskpts = 0;

   float Min_lat = 90.0;

   float Max_lat = 0.0;

   float Min_ele = 0.0;

   float Max_ele = 0.0;

   float Min_W = 109.0;

   float Max_W = 105.0;
//DBG"%V $nm_to_km $km_to_sm  \n"


  float LatS = 37.5;

  float LatN = 42.0;

  float LongW= 108.5;

  float LongE= 104.8;


   float MidLat = (LatN - LatS)/2.0 + LatS;


   float Margin = 0.05;

   float MidLong = (LongW - LongE)/2.0 + LongE;
 


  Str Units = "KM";

  Str lat = "A";

  Str longit = "B";

  float LegK =  0.5 * (7915.6 * 0.86838);
  //DBG" %v $LegK \n"
  //  Main_init = 0
//DBG" read in unit conversions \n"

  int n_legs = 0;
//float Leg[20];
// conversion routines

float  km_to_feet = 3281.0;
float   km_to_nm = 3281.0/6080.0;
float   km_to_sm = 3281.0/5280.0;
float   nm_to_sm = 6080.0/5280.0;
float   nm_to_km = 6080.0/3281.0;






//============================================


  Vec<float> IGCLONG(500);

  Vec<float> IGCLAT(500);

  Vec<float> IGCELE(500);

  Vec<float> IGCTIM(500);



  float computeGCD(float la1,float la2,float lo1,float lo2)
  {
///  input lat and long degrees - GCD in km
  float rL1,rL2,rlo1,rlo2,D,km;
  rL1 = d2r(la1);

  rL2 = d2r(la2);

  rlo1 = d2r(lo1);

  rlo2 = d2r(lo2);

  D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));

  km = LegK * D  * nm_to_km;
  printargs ("km ",km);
  return km;

  }
//==================================================

#if 0
  float ComputeTPD(int j, int k)
  {
//<<" $_proc %V $j $k \n"
// needs Wtp as arg!! - but we use library version anyway
int N;
  float km = 0.0;
  float km1,km2;
  float L1,L2,lo1,lo2,rL2,rL1,rlo1,rlo2,D;
  L1 = Wtp[j].Ladeg;

  L2 = Wtp[k].Ladeg;
   //DBG"%V $L1 $L2 \n"

  lo1 = Wtp[j].Longdeg;

  lo2 = Wtp[k].Longdeg;
   //DBG"%V $lo1 $lo2 \n"

  rL2 = d2r(L2);

  rL1 = d2r(L1);
   //DBG" %V $rL1 $rL2 \n"

  rlo1 = d2r(lo1);

  rlo2 = d2r(lo2);
    //DBG" %V $rlo1 $rlo2 \n"

  D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));
    //DBG"%V $D\n"

  N = LegK * D;

  km1 = N * nm_to_km;
   // km2 = Gcd(L1,lo1 , L2, lo2 );

  km2 = HowFar(L1,lo1 ,L2, lo2);

  km = km2;
    //km->info(1)
  //<<" %V   $LegK   $nm_to_km $km1 $km2\n" ;

  return km;

  }
//====================================//
#endif



  void processIGC()
  {

   Vec<double> sslng(12);
   Vec<double> sslat(12);
   Vec<double> ssele(12);   

  pa("processIGC Igcfn   ",Igcfn);
  
  Ntpts= readIGC(Igcfn, IGCTIM, IGCLAT, IGCLONG, IGCELE);
  
#if ASL
   <<"sz $Ntpts $(Caz(IGCLONG))   $(Caz(IGCLAT))\n"
#endif
  
//<<"%(10,, ,\n) $IGCLONG[0:30] \n"
//<<"%(10,, ,\n) $IGCLONG[k:Ntpts-1] \n"

  sslng= IGCLONG.stats();

/*
     for (i=0; i < Ntpts; i += 5) {
     
      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";
     }
*/

  int i = 10;
 //     <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";

//cout  <<" sslng " << sslng  << endl;

  
  sslat= IGCLAT.stats();
  sslat.pinfo();
//<<"%V $sslt \n"
    ///

  int sstart = Ntpts /10;

  int sfin = Ntpts /5;
    //sstart = 1000;
   // sfin = 1500;
//     for (i=sstart; i < sfin; i++) {
//      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";  // BUG FIXIT 9/20/21
//     }

  ssele= IGCELE.stats();

 //<<"%V $ssele \n"

  Min_ele = ssele[5];

  Max_ele = ssele[6];
//<<" min ele $ssele[5] max $ssele[6] \n"

  float min_lng = sslng[5];

  float max_lng = sslng[6];
//<<"%V $min_lng $max_lng \n"

  float min_lat = sslat[5];

  float max_lat = sslat[6];

#if ASL
//<<"%V $min_lat $max_lat \n"
#endif
  LatS = min_lat -Margin;

  LatN = max_lat+Margin;

  MidLat = (LatN - LatS)/2.0 + LatS;
  //<<"%V $MidLat \n"

  float dlat = max_lat - min_lat;
  //<<"%V $dlat \n"
  //<<"%V $LongW \n"
  //<<"%V $LongE \n"

  LongW = max_lng + Margin;

  LongE = min_lng - Margin;

  MidLong = (LongW - LongE)/2.0 + LongE;
  //DBG"%V $MidLong \n"

  float dlng = max_lng - min_lng;

  float da = dlat;
  //DBG"%V $da $dlng $dlat \n"
// TBF if corrupts following expression assignment

  if ( dlng > dlat )
  {

  da = dlng;
	//DBG"da = dlng\n"

  }

  else {
  	//DBG"da = dlat\n"

  }
  //DBG"%V $da $dlng $dlat \n"
////////////////////// center //////////
//  longW = MidLong + da;
//  DBG"%V $longW $MidLong $da \n"



  LongW = MidLong + da/2.0;
  //<<"%V $latWB $MidLat $da \n"

  LongW = MidLong + da/2.0;
  //<<"%V $longW $MidLong $da \n"

  LongE = MidLong - da/2.0;
#if ASL  
//  <<"%V $LongW \n"
//  <<"%V $LongE \n"
#endif
  }
//===============================//
//<<"$_include %V$Ntp_id\n"

  Str nameMangle(Str aname)
  {

//<<"$_proc $aname \n";

  Str fname;

  Str nname=aname;

//  <<" %V $nname $aname \n";  // TBF

  int kc = nname.slen();

  if (kc >7) {

     nname.svowrm();

  }

  //fname.scpy(nname);
  fname = nname;

// <<"%V $kc  $nname --> $fname \n"

// is this going to work as cpp 

  return fname;

  }
//======================================//

  float totalK = 0;

  float getDeg (Str the_ang)
  {
  Str the_dir;
  float la;
  float y;
  Str wd;
//DBG"in $_proc $the_ang \n"

  Svar the_parts;
  the_parts.split(the_ang,',');

  int sz = the_parts.caz();
//DBG"sz $sz $(typeof(the_parts))\n"
    //DBG"%V $the_parts[::] \n"
//FIX    float the_deg = atof(the_parts[0])

  wd = the_parts[0];

  float the_deg = atof(wd);
        //DBG"%V $wd $the_deg \n"
//    float the_min = atof(the_parts[1])

  wd = the_parts[1];

  float the_min = atof(wd);
        //DBG"%V $wd $the_min \n"
    //DBG"%V$the_deg $the_min \n"
      //  sz= Caz(the_min);
      //DBG" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

  the_dir = the_parts[2];

  y = the_min/60.0;

  la = the_deg + y;

  if ((the_dir == "E") || (the_dir == "S")) {

  la *= -1;

  }


  return (la);

  }
//===============================//
/*
  void get_word(Str defword)
  {

  Svar h;
    //    DBG" %V $defword $via_keyb $via_cl \n"

  if (via_keyb) {
	// DBG"via keybd \n"
	// DBG"$defword "

  h = irs(Stat);

  if ( h > 1) {

  sscan(Stat,&h);

  }

  else {

  h = defword;

  }

  }

  if (via_file) {

     h.readFile(TF);

  }
      //          DBG" $_cproc exit with $h \n"

  return h;

  }
//==================================================
*/


  void nearest (int tp)
  {
  // compute distance from tp to others
  // if less than D
  // print

  }
//====================//
/*
  float IGCLONG[];
  float IGCLAT[];
  float IGCELE[];
  float IGCTIM[];
*/
  void IGC_Read(Str igc_file)
  {
//DBG"%V $igc_file \n"

  //T=fineTime();

  int fh=ofr(igc_file);

  if (fh == -1) {
     //DBG" can't open IGC file $igc_file\n"

  return 0;

  }
  int ntps =0;
 ntps = readIGC(fh,&IGCTIM,&IGCLAT,&IGCLONG,&IGCELE); // vec siv base

  IGCELE *= 3.280839 ;
  
  //  IGCLONG = -1 * IGCLONG;
//DBG"read $ntps from $igc_file \n"

 // dt=fineTimeSince(T);
//<<[_DB]"$_proc took $(dt/1000000.0) secs \n"

  cf(fh);

  return ntps;

  }
//========================


  float ComputeTC(Turnpt wtp[],int j, int k)
  {

  float km = 0.0;
  float tc = 0.0;
  float L1,L2,lo1,lo2;

  
  L1 = wtp[j].Ladeg;

  L2 = wtp[k].Ladeg;

  lo1 = wtp[j].Longdeg;

  lo2 = wtp[k].Longdeg;
//  tc = TrueCourse(L1,lo1,L2,lo2);

tc = TrueCourse(lo1,L1,lo2,L2);

  //printargs(j, k ,L1 ,lo2 ,"tc=", tc);

  return tc;

  }
//===========================//


;//==============\_(^-^)_/==================//;
#endif
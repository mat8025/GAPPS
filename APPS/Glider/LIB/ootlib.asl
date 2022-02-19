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
  int Ntpts =0;
  int igcfn = -1;
  
  Str task_file = "XXX";

  float totalD = 0;

  float totalDur = 0.0;

  int Ntaskpts = 0;

   float Min_lat = 90.0;

   float Max_lat = 0.0;

   float Min_W = 109.0;

   float Max_W = 105.0;
//DBG"%V $nm_to_km $km_to_sm  \n"

  Str Units = "KM";

  Str lat = "A";

  Str longit = "B";

  float LegK =  0.5 * (7915.6 * 0.86838);
  //DBG" %v $LegK \n"
  //  Main_init = 0
//DBG" read in unit conversions \n"

  int n_legs = 0;
//float Leg[20];

  float TC[20];

  float Dur[20];
//============================================



  Vec IGCLONG(FLOAT,10);

  Vec IGCLAT(FLOAT,10);

  Vec IGCELE(FLOAT,10);

  Vec IGCTIM(FLOAT,10);






  void processIGC()
  {

   Vec sslng(FLOAT,10);


  Ntpts=readIGC(igcfn,&IGCLONG, &IGCLAT,&IGCELE,&IGCTIM);
//<<"sz $Ntpts $(Caz(IGCLONG))   $(Caz(IGCLAT))\n"

  int k = Ntpts - 30;
//<<"%(10,, ,\n) $IGCLONG[0:30] \n"
//<<"%(10,, ,\n) $IGCLONG[k:Ntpts-1] \n"

  sslng= Stats(IGCLONG);
      // BUG FIXIT 9/20/21
/*
     for (i=0; i < Ntpts; i += 5) {
     
      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";
     }
*/

  i = 10;
 //     <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";

  <<"%V $sslng \n";

  sslt= Stats(IGCLAT);
//<<"%V $sslt \n"
    ///

  sstart = Ntpts /10;

  sfin = Ntpts /5;
    //sstart = 1000;
   // sfin = 1500;
//     for (i=sstart; i < sfin; i++) {
//      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";  // BUG FIXIT 9/20/21
//     }

  ssele= Stats(IGCELE,">",0);
//<<"%V $ssele \n"

  Min_ele = ssele[5];

  Max_ele = ssele[6];
//<<" min ele $ssele[5] max $ssele[6] \n"

  min_lng = sslng[5];

  max_lng = sslng[6];
//<<"%V $min_lng $max_lng \n"

  min_lat = sslt[5];

  max_lat = sslt[6];
//<<"%V $min_lat $max_lat \n"

  LatS = min_lat -Margin;

  LatN = max_lat+Margin;

  MidLat = (LatN - LatS)/2.0 + LatS;
  //<<"%V $MidLat \n"

  dlat = max_lat - min_lat;
  //<<"%V $dlat \n"
  //<<"%V $LongW \n"
  //<<"%V $LongE \n"

  LongW = max_lng + Margin;

  LongE = min_lng - Margin;

  MidLong = (LongW - LongE)/2.0 + LongE;
  //DBG"%V $MidLong \n"

  dlng = max_lng - min_lng;

  da = dlat;
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

  latWB = MidLat + da/2.0;

  LongW = MidLong + da/2.0;
  //<<"%V $latWB $MidLat $da \n"

  LongW = MidLong + da/2.0;
  //<<"%V $longW $MidLong $da \n"

  LongE = MidLong - da/2.0;
  //<<"%V $LongW \n"
  //<<"%V $LongE \n"

  }
//===============================//
//<<"$_include %V$Ntp_id\n"

  void nameMangle(Str aname)
  {
  // FIXIT --- bad return

  Str fname;

  nname=aname;
 //<<" %V $nname $aname \n"

  kc =slen(nname);

  if (kc >7) {

  nname=svowrm(nname);

  }

  scpy(fname,nname,7);
   // <<"%V$nname --> $fname \n"

  return fname;

  }
//======================================//

  float totalK = 0;

  void TaskDist()
  {
   // is there a start?
//<<"$_proc  $Ntaskpts \n"
//<<"in TaskDist  %V $_scope $_cmfnest $_proc $_pnest\n"	       

  int tindex =0;

  Taskpts<-pinfo();

  totalK = 0.0;
 //<<"%V $_scope $_cmfnest $_proc \n"

  for (k= 0; k < Ntaskpts; k++) {

  tindex = Taskpts[k];
//<<"%V $k $tindex $Taskpts[k] \n";

  }

  float la1   = 1000.0;

  float lon1 = 1000.0;

  float la2   = 1000.0;

  float lon2 = 1000.0;

  float msl;

  float fga;

  Min_lat = 90.0;

  Max_lat = 0.0;

  Min_W = 109.0;

  Max_W = 105.0;

  Str tpl;

  int adjust = 0;
   // num of taskpts
//<<"%V $Ntaskpts \n"

  Taskpts<-pinfo();

  for (i = 0; i < Ntaskpts ; i++) {

  index = Taskpts[i];

  kmd = 0.0;
//<<"%V $i $index $Taskpts[k] \n";

  tpl = Wtp[index]->Place;
//     <<"%V  $tpl \n"

  la2 = Wtp[index]->Ladeg;

  msl = Wtp[index]->Alt;

  if (la2 > Max_lat) {

  Max_lat = la2;

  }

  if (la2 < Min_lat) {

  Min_lat = la2;

  }

  lon2 = Wtp[index]->Longdeg;

  if (lon2 > Max_W) {

  Max_W = lon2;

  }

  if (lon2 < Min_W) {

  Min_W = lon2;

  }

  if (la1 != 1000.0) {

  kmd = computeGCD(la1,la2,lon1,lon2);

  }

  la1 = la2;

  lon1 = lon2;

  adjust++;

  totalK += kmd;
// add in the fga to reach this turnpt from previous
 //    Wleg->pinfo()

  Wleg[i]->msl = msl;

  Wleg[i]->Place = tpl;

  if (i > 0) {

  Wleg[i-1]->dist = kmd;

  Wleg[i-1]->Tow = tpl;

  ght = (kmd * km_to_feet) / LoD;

  fga = ght + 1200.0 + msl;
      //<<"%V$i $fga $msl\n"

  Wleg[i-1]->fga = fga;

  }

  }

  Wleg[Ntaskpts]->dist = 0.0;
//<<"%V $Min_lat $Min_W $Max_lat $Max_W \n"
//<<"%V $LongW $LatS $LongE $LatN   \n"

  if (adjust >=2) {

  LongW= Max_W +1.0;

  LatS = Min_lat -1;

  LongE = Min_W -1;

  LatN = Max_lat +1;

  }
//<<"%V $totalK\n"
//<<"%V $LongW $LatS $LongE $LatN   \n"

  Task_update = 1;
//<<"DONE $_proc  $totalK \n"

  }
//==============================//

  void TaskStats()
  {
 //<<"%V $_scope $_cmfnest $_proc $_pnest\n"

  float amsl = 0.0;

  for (i = 0; i < Ntaskpts ; i++) {

  amsl = Wleg[i]->msl;
     //<<"Stat $i $amsl $Wleg[i]->dist   $Wleg[i]->fga\n"

  }

  }

  void  computeHTD()
  {
//  <<"$_proc $n_legs \n"

  totalD = 0;
//totalD->info(1)

  for (nl = 0; nl < n_legs ; nl++) {

  tkm = ComputeTPD(nl, nl+1);

  Leg[nl] = tkm;
       //Leg[nl] = ComputeTPD(nl, nl+1)

  tcd =  ComputeTC(nl, nl+1);

  TC[nl] = tcd;

  Dur[nl] = Leg[nl]/ Cruise_speed;
//<<"$Leg[nl] $tkm \n"

  totalDur += Dur[nl];

  totalD += Leg[nl];
//<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"

  }

  }
//==============================//

  void getDeg (Str the_ang)
  {
  Str the_dir;
  float la;
  float y;
  Str wd;
//DBG"in $_proc $the_ang \n"

  the_parts = Split(the_ang,",");

  sz = Caz(the_parts);
//DBG"sz $sz $(typeof(the_parts))\n"
    //DBG"%V $the_parts[::] \n"
//FIX    float the_deg = atof(the_parts[0])

  wd = the_parts[0];

  the_deg = atof(wd);
        //DBG"%V $wd $the_deg \n"
//    float the_min = atof(the_parts[1])

  wd = the_parts[1];

  the_min = atof(wd);
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
//DBG"%V $la  $y  \n"

  return (la);

  }
//===============================//

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

  h = r_file(TF);

  if ((h == "EOF") || si_error()) {

  h = "done";

  }

  }
      //          DBG" $_cproc exit with $h \n"

  return h;

  }
//==================================================

  void compute_leg(int leg)
  {
  float km;

  if (leg < 0)

  return 0;

  kk = leg + 1;
	    // DBG" compute %V $leg $kk \n"

  L1 = LA[leg];

  L2 = LA[kk];
	    // DBG" %V $L1 $L2 \n"

  lo1 = LO[leg];

  lo2 = LO[kk];
	    //DBG" %V $lo1 $lo2 \n"

  km = computeGCD(L1,L2,lo1,lo2);

  return km;

  }
//==================================================

  void computeGCD(float la1,float la2,float lo1,float lo2)
  {
///  input lat and long degrees - GCD in km

  rL1 = d2r(la1);

  rL2 = d2r(la2);

  rlo1 = d2r(lo1);

  rlo2 = d2r(lo2);

  D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));

  N = LegK * D ;

  km = N * nm_to_km;

  return km;

  }
//==================================================

  void compute_leg2(int t_1,int t_2)
  {

  leg = t_1;

  kk = t_2;

  L1 = LA[leg];

  L2 = LA[kk];

  if (L1 < Min_lat)      Min_lat = L1

  if (L1 > Max_lat)      Max_lat = L1

  if (L2 > Max_lat)      Max_lat = L2

  if (L2 < Min_lat)      Min_lat = L2
    //  DBG"lats are $L1 $L2 \n"

  lo1 = LO[t_1];

  lo2 = LO[t_2];

  if (lo1 < Min_W)      Min_W = lo1

  if (lo1 > Max_W)      Max_W = lo1
    //  DBG"longs are $lo1 $lo2 \n"

  rL1 = d2r(L1);

  rL2 = d2r(L2);

  rlo1 = d2r(lo1);

  rlo2 = d2r(lo2);

  D= Sin(rL1) * Sin(rL2) + Cos(rL1) * Cos(rL2) * Cos(rlo1-rlo2);
			  //  DBG" $D $(typeof(D)) \n"

  D= Acos(D);

  dD= r2d(D);
			  //print(D," ",dD,"\n")

  N = 0.5 * (7915.6 * 0.86838) * D;

  print("dist = ",N," nm","\n");

  sm = N * nm_to_sm;

  print("dist = ",sm," sm","\n");

  km = N * nm_to_km;
    //DBG"dist = km $km \n"

  return (km);

  }
//============================//

  void conv_lng(Str lng)
  {

  lngdeg = spat(lng,",",-1,1);

  lngmin = spat(lng,",",1,1);

  WE = spat(lngmin,",",1,-1);

  lngmin = spat(lngmin,",","<",">");

  lngmin = lngmin/60.00;

  lngdec = lngdeg + lngmin + 0.00001;

  if (WE == "W") {

  lngdec *= -1.0;

  }

  }
//=========================

  void conv_lat (Str lat)
  {

  latdeg = spat(lat,",",-1,1);

  latmin = spat(lat,",",1,1);

  NS = spat(latmin,",",1,-1);

  latmin = spat(latmin,",","<",">");

  latmin = latmin/60.00;

  latdec = latdeg + latmin;

  }
//=========================

  void nearest (int tp)
  {
  // compute distance from tp to others
  // if less than D
  // print

  }
//====================//

  void spin()
  {

  static int k = 0;

  i = k % 4;

  if (i == 0)

  <<" \\ \r ";

  else if (i == 1);

  <<" | \r ";

  else if (i == 2);

  <<" -- \r ";

  else;

  <<" / \r ";

  k++;

  }
//===============================================

  float IGCLONG[];

  float IGCLAT[];

  float IGCELE[];

  float IGCTIM[];

  void IGC_Read(Str igc_file)
  {
//DBG"%V $igc_file \n"

  T=fineTime();

  a=ofr(igc_file);

  if (a == -1) {
     //DBG" can't open IGC file $igc_file\n"

  return 0;

  }

  ntps =readIGC(a,IGCTIM,IGCLAT,IGCLONG,IGCELE);

  IGCELE *= 3.280839 ;
  //  IGCLONG = -1 * IGCLONG;
//DBG"read $ntps from $igc_file \n"

  dt=fineTimeSince(T);
//<<[_DB]"$_proc took $(dt/1000000.0) secs \n"

  cf(a);

  return ntps;

  }
//========================

  void ClosestTP (float longx, float laty)
  {
///

  T=fineTime();

  float mintp = 30;

  int mkey = -1;

  float ctp_lat;

  int k = 3;
//DBG"%V $Wtp[0]->Ladeg \n"
//DBG"%V $Wtp[k]->Ladeg \n"

  ctp_lat = Wtp[k]->Ladeg;
//DBG"%V $ctp_lat \n"

  for (k = 0 ; k < Ntp ; k++) {

  ctp_lat =   Wtp[k]->Ladeg;

  longi = Wtp[k]->Longdeg;

  dx = Fabs(longx - longi);

  dy = Fabs(laty - ctp_lat);

  dxy = dx + dy;

  if (dxy < mintp) {

  mkey = k;

  mintp = dxy;
//DBG"%V $Wtp[k]->Ladeg $ctp_lat $longi $laty $longx  $dx $dy $Wtp[k]->Place \n"

  }

  }

  if (mkey != -1) {
//DBG" found $mkey \n"

  Wtp[mkey]->Print();

  }

  dt=fineTimeSince(T);
//DBG"$_proc took $(dt/1000000.0) secs \n"

  return  mkey;

  }
//=============================================

  void ClosestLand(float longx,float laty)
  {
  float mintp = 18000;
  int mkey = -1;
  int isairport = 0;

  float sa;

  float longa;

  float lata;
  float msl;
  float mkm;
  float ght;
  float sa;

  longa = longx;

  lata = laty;

  for (k = 0 ; k < Ntp ; k++) {

  isairport = Wtp[k]->GetTA();
//DBG"$_proc %V $isairport \n"

  if (isairport) {

  msl = Wtp[k]->Alt;

  mkm = HowFar(lata,longa, Wtp[k]->Ladeg,Wtp[k]->Longdeg);

  ght = (mkm * km_to_feet) / LoD;
//FIX_PARSE_ERROR                sa = Wtp[k]->Alt + ght + 2000

  sa = msl + ght + 2000;
//DBG" $k $mkm $ght $sa \n"

  if (sa < mintp) {

  mkey = k;

  mintp = sa;

  }

  }

  }

  if (mkey != -1) {
//DBG" found $mkey \n"

  Wtp[mkey]->Print();

  }

  return  mkey;

  }
//=============================================

  float ComputeTC(int j, int k)
  {

  float km = 0.0;
  float tc = 0.0;

  L1 = Wtp[j]->Ladeg;

  L2 = Wtp[k]->Ladeg;

  lo1 = Wtp[j]->Longdeg;

  lo2 = Wtp[k]->Longdeg;

  tc = trueCourse(L1,lo1,L2,lo2);
      //DBG"%V$tc \n"

  return tc;

  }
//===========================//

  float ComputeTPD(int j, int k)
  {
//<<" $_proc %V $j $k \n"

  float km = 0.0;

  L1 = Wtp[j]->Ladeg;

  L2 = Wtp[k]->Ladeg;
   //DBG"%V $L1 $L2 \n"

  lo1 = Wtp[j]->Longdeg;

  lo2 = Wtp[k]->Longdeg;
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

  km2 = Howfar(L1,lo1 , L2, lo2 );

  km = km2;
    //km->info(1)
  //<<" %V   $LegK   $nm_to_km $km1 $km2\n" ;

  return km;

  }
//====================================//

;//==============\_(^-^)_/==================//;

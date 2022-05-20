///
///  obsolete/ used / not cpp compliant
///
  void  computeHTD()
  {
//  <<"$_proc $n_legs \n"

  float totalD = 0;
  float tkm;
  float tcd;

  for (int nl = 0; nl < n_legs ; nl++) {

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

  void spin()
  {

  static int k = 0;

  int i = k % 4;

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


  float compute_leg2(int t_1,int t_2)
  {
  float L1,L2,lo1,lo2,rL2,rL1,rlo1,rlo2,D;
  float Nm,Sm,Km;
   int leg = t_1;

  int kk = t_2;

  L1 = LA[leg];

  L2 = LA[kk];

  if (L1 < Min_lat)      Min_lat = L1;

  if (L1 > Max_lat)      Max_lat = L1;

  if (L2 > Max_lat)      Max_lat = L2;

  if (L2 < Min_lat)      Min_lat = L2;
    //  DBG"lats are $L1 $L2 \n"

  lo1 = LO[t_1];

  lo2 = LO[t_2];

  if (lo1 < Min_W)      Min_W = lo1;

  if (lo1 > Max_W)      Max_W = lo1;
    //  DBG"longs are $lo1 $lo2 \n"

  rL1 = d2r(L1);

  rL2 = d2r(L2);

  rlo1 = d2r(lo1);

  rlo2 = d2r(lo2);

  D= sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2);
			  //  DBG" $D $(typeof(D)) \n"

  D= acos(D);

  //dD= r2d(D);
			  //print(D," ",dD,"\n")

  Nm = 0.5 * (7915.6 * 0.86838) * D;



  Sm = Nm * nm_to_sm;


  Km = Nm * nm_to_km;

  printf("Nm %f Sm %f Km %f\n",Nm,Sm,Km);

  return (Km);

  }
//============================//

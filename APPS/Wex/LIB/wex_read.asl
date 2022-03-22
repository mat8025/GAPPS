/* 
 *  @script wex_read.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.6 C 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 09:08:56          
 *  @cdate Fri Jan 01 08:00:45 2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                

  
  void fillInObsVec()
  {

  if (Yd >= 0) {

 int j = 1;

  float mywt = atof(col[j++]);

  if (mywt > 0.0) {  // we have an entry = not all days are logged

  WTVEC[Yd] = mywt;
//<<"$k  mywt  $WTVEC[Nobs] \n"

  if (mywt > 0.0) {

  last_known_wt = mywt;

  last_known_day = Yd;

  }

  else {

  WTVEC[Yd] = last_known_wt;

  }

   float walk =  atof(col[j++]);

   float hike = atof(col[j++]);

   float    run = atof(col[j++]);

   float cycle =  atof(col[j++]);

   float swim =  atof(col[j++]);

   float yardwrk =  atof(col[j++]);

   float wex = atof(col[j++]);

  EXTV[Yd] =  ( walk + hike + run + cycle + swim + yardwrk + wex);

  CARDIO[Yd] = ( walk + hike + run + cycle + swim );

  STRENGTH[Yd] = (yardwrk + wex);

  tot_exetime = tot_exetime + EXTV[Yd];

  SEVEC[Yd] =  wex;

  BPVEC[Yd] =  atof(col[j++]);
// any extra activities ?

  float tex = EXTV[Yd];

  float  exer_burn =   walk * w_rate;

  exer_burn += hike * h_rate;

  exer_burn += run * run_rate;

  exer_burn +=  cycle * c_rate;

  exer_burn += swim * swim_rate;

  exer_burn += yardwrk * yard_rate;

  exer_burn += wex * wex_rate;

  EXEBURN[Yd] =  exer_burn;

  tot_exeburn += exer_burn;

   float wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  ;

  CALBURN[Yd] =  wrk_sleep + exer_burn ;

  Nobs++;

  }

  }

  }
//====================================================//



  int readData()
  {

  int tl = 0;
  long jday;
  Str day;
 // RX->info(1)
  long sday;
  
  int got_start = 0;
  
  while (tl < Nrecs) {


  col= RX[tl];
 //<<"<$tl> $RX[tl]\n"

  day = col[0];

  jday = Julian(day);


  if (!got_start) {

  sday = jday;

  got_start = 1;

  }

  Yd = jday - Jan1;
//<<"%V $jday  $Yd\n"

  lday = Yd;

  if (Yd < 0) {

  cout << " $Yd neg offset ! \n";

  }


//<<[_DB]" what day $k\n"
   // will need separate day vector for the food carb/protein/fat/calorie totals
   // -( we count/estimate those) 
   // variables are plotted against dates (juldays - birthday)

  fillInObsVec();

  tl++;
//<<"%V $tl\n"

  if (tl >= Nrecs) {

  break;

  }

  }
//<<[_DB]"$Nrecs there were $tl $Nobs measurements \n"

  return tl;

  }
//==============================================//



  void fillInCCObsVec()
  {

  if (Yd >= 0) {

  CALSCON[Yd] =  atof(col[1]);

  CARBSCON[Yd] = atof(col[2]);

  NCCobs++;
//<<"Yd $NCCobs $CALSCON[Yd] $CARBSCON[Yd] \n"

  }

  }
//====================================================//

  void readCCData()
  {

  int tl = 0;
  long jday;
  Str day;
  
  while (tl < NCCrecs) {
  
    //ccol = RCC[tl];
//<<[_DB]"$RCC[tl]\n"
//<<[_DB]"$tl  $NCCobs $NCCrecs\n"
    //day = ccol[0];

  day = RCC.getRC(tl,0);
//<<"%V $day\n"

  jday = Julian(day);

  Yd = jday - Jan1;  // so 0 - 364;

  lday = Yd;

  float cals = atof(RCC.getRC(tl,6));

  CALSCON[Yd] = cals;

  float ccals =  CALSCON[Yd];
//<<"calscon $Yd   $CALSCON[Yd]  cals <|$cals|>  ccals $ccals \n"

  float carbs = atof(RCC.getRC(tl,3));

  CARBSCON[Yd] = carbs;

  float fat = atof(RCC.getRC(tl,2));

  FATCON[Yd] = fat;

  float prot = atof(RCC.getRC(tl,5));

  PROTCON[Yd] = prot;

  float fiber = atof(RCC.getRC(tl,4));

  FIBRCON[Yd] = fiber;
//<<"%V $day $cals $carbs $fat $prot $fiber\n"

  NCCobs++;

  tl++;

  if (tl >= NCCrecs) {

  break;

  }

  }

  }
//=======================================//

  ;//==============\_(^-^)_/==================//;

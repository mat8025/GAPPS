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
//----------------<v_&_v>-------------------------//

allowDB("prep,opera_,spe,rdp_,ic,pex_,parse,array,ds",1)
  
void fillInObsVec()
{

  int iyd = Yd;
  float tex;
  float mywt;
  float wrk_sleep  ;



if (Yd >= 0) {

 int j = 1;
  //wt = Col[j]
  
  mywt = atof(Col[j++]);
  

 // <<" %V $mywt \n"

  if (mywt > 0.0) {  // we have an entry = not all days are logged

  WTVEC[Yd] = mywt;
  
  //<<"mywt $Yd  $WTVEC[Yd] \n";

  if (mywt > 0.0) {

  last_known_wt = mywt;

  last_known_day = Yd;

  }

  else {

  WTVEC[Yd] = last_known_wt;

  }

   float walk =  atof(Col[j++]);

   float hike = atof(Col[j++]);

   float    run = atof(Col[j++]);

   float cycle =  atof(Col[j++]);

   float swim =  atof(Col[j++]);

   float yardwrk =  atof(Col[j++]);

   float wex = atof(Col[j++]);

   tex = ( walk + hike + run + cycle + swim + yardwrk + wex);

//  <<"%V $tex \n"
//COUT(tex);

  EXTV[Yd] = tex; 

//COUT(EXTV[iyd]);

  CARDIO[Yd] = ( walk + hike + run + cycle + swim );

  STRENGTH[Yd] = (yardwrk + wex);

  tot_exetime = tot_exetime + EXTV[Yd];

  SEVEC[Yd] =  wex;

  BPVEC[Yd] =  atof(Col[j++]);
// any extra activities ?

  tex = EXTV[Yd];

  float  exer_burn =   walk * w_rate;

  exer_burn += hike * h_rate;

  exer_burn += run * run_rate;

  exer_burn +=  cycle * c_rate;

  exer_burn += swim * swim_rate;

  exer_burn += yardwrk * yard_rate;

  exer_burn += wex * wex_rate;

  EXEBURN[Yd] =  exer_burn;

  tot_exeburn += exer_burn;



  // float wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  ;

   wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  ;

  CALBURN[Yd] =  wrk_sleep + exer_burn ;

  Nobs++;

   //printf("Nobs %d  exer_burn %f\n",Nobs ,exer_burn);
  }

  }



  }
//====================================================//



  int readData()
  {

  int tl = 0;
  long jday;
  Str day;
  Str mywt;
 // RX->info(1)
  long sday;
  
  int got_start = 0;

//  <<"get data from record Wex_Nrecs \n";

// access of record row Rx(i)
// access of record Col Rx(i,j)
  int max_n =3;
  
  while (tl < Wex_Nrecs) {


  Col= RX.getRecord(tl);
  


  day = Col[0];
  mywt = Col[1];


//  VCOUT(tl,day);

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

//ans=ask("%V $tl  $day $mywt $Wex_Nrecs\n",1)

  if (tl >= Wex_Nrecs) {

     break;

  }

  }

 //ans=ask("readDATA proceed?",1);
  printf("Wex_Nrecs %d there were Nobs %d measurements ",Wex_Nrecs,Nobs);

  return tl;

  }
//==============================================//



  void fillInCCObsVec()
  {

  if (Yd >= 0) {

  CALSCON[Yd] =  atof(Col[1]);

  CARBSCON[Yd] = atof(Col[2]);

  NCCobs++;
//<<"Yd $NCCobs $CALSCON[Yd] $CARBSCON[Yd] \n"

  }

  }
//====================================================//

  int readCCData()
  {

  int tl = 0;
  
  long jday;
  Str day;
  int jn = 5;
  //<<"%V $tl $NCCrecs \n"
  while (tl < NCCrecs) {
  

  day = RCC.getRC(tl,0);

  if (day != "") {

//cout <<" day " << day << endl;

  jday = Julian(day);

  Yd = jday - Jan1;  // so 0 - 364;

  lday = Yd;

  float cals = atof(RCC.getRC(tl,6));



  CALSCON[Yd] = cals;

  float ccals =  CALSCON[Yd];
//<<"calscon $Yd   $CALSCON[Yd]  cals <|$cals|>  ccals $ccals \n"

  float carbs = atof(RCC.getRC(tl,3));

<<"$day $carbs\n"



  CARBSCON[Yd] = carbs;

  float fat = atof(RCC.getRC(tl,2));

  FATCON[Yd] = fat;

  float prot = atof(RCC.getRC(tl,5));

  PROTCON[Yd] = prot;

  float fiber = atof(RCC.getRC(tl,4));

  FIBRCON[Yd] = fiber;
<<"%V $day $cals $carbs $fat $prot $fiber\n"

  NCCobs++;
  }
//
  tl++;

  //<<"%V $tl $NCCrecs \n"
  if (tl >= NCCrecs) {

    break;

  }



 //ans=ask("readCC proceed?",0);

  }


   return tl;
  }
//=======================================//

//==============\_(^-^)_/==================//

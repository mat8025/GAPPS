///
///
///
Vec<float> WTVEC(20);


#include "debug"


   if (_dblevel >0) {

     debugON();

     }

int Nobs =0;
long Yd = 0;

 


void fillInObsVec()
{

 float tex;
 int iyd = Yd;
 float wrk_sleep  ;

 float mywt;

Yd = 1
if (Yd >= 0) {

 int j = 1;
  //wt = Col[j]
//allowDB("spe,opera_,array_parse,parse,rdp_,ds,pex,ic")
  int k = 1
  badwt = atof(Col[k++]);


  mywt = atof(Col[j++]);


  //j++;

<<" %V $k $j $badwt $mywt \n"

<<"mywt $mywt Col $Col \n"

  ans=ask("readDATA proceed?",1);



  if (mywt > 0.0) {  // we have an entry = not all days are logged

  WTVEC[Nobs] = mywt;
  
  <<"$mywt  $WTVEC[Nobs] \n";

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

  <<"%V $tex \n"


  Nobs++;

   printf("Nobs %d  exer_burn %f\n",Nobs ,exer_burn);
  }

  }



  }
//====================================================//

Svar Col;

int readData()
  {

  int tl = 0;
  long jday;
  Str day;
  Str mywt;

  long sday;
  
  int got_start = 0;

  <<"get data from record Wex_Nrecs \n";

// access of record row Rx(i)
// access of record Col Rx(i,j)
  int max_n =3;
  
 // while (tl < Wex_Nrecs) {

  while (tl < 5) {


  Col = RX.getRecord(tl);

  <<"$tl Col $Col \n"
 ans=ask("readDATA proceed?",1);

  day = Col[0];
  mywt = Col[1];

  jday = Julian(day);


  if (!got_start) {

  sday = jday;

  got_start = 1;

  }

 // Yd = jday - Jan1;
  
<<"%V $jday  $Yd\n"

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

  <<"%V $tl  $day $mywt $Wex_Nrecs\n"

  if (tl >= Wex_Nrecs) {

     break;

  }

  }

  ans=ask("readDATA proceed?",1);
  printf("Wex_Nrecs %d there were Nobs %d measurements ",Wex_Nrecs,Nobs);

  return tl;

  }
//==============================================//



int db_allow = 0; // set to zero for internal debug print



chkIn (_dblevel);


chkT(1)

Record RX

 int A=ofr("~/gapps/DAT/wex2024.tsv");

 Wex_Nrecs=RX.readRecord(A,_RDEL,-1,_RLAST);  // no back ptr to Siv?

if (db_allow) {
 allowDB("spe,opera_,array_parse,parse,rdp_,ds,pex,ic")
}




  readData()

<<" $WTVEC \n"

chkOut(1)

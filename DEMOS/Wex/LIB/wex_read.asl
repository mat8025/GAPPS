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

_DB = -1;

float last_known_wt = 208.8;
long last_known_day = 0;

float tot_exeburn =0
float tot_exetime = 0

Nobs = 0;
nxobs = 0;

int Nxy_obs = 0

long wday;
//=========================================


void isData()
{
   dok = 1

   fword=""

   sscan(S,'%s',&fword) // get first word -non WS

   if (scmp(fword,"#",1)) {
       dok = 0;
   }

 //  <<[_DB]"$fword $dok\n"

   return dok
}
//===========================================================

void fillInObsVec()
{
 
 if (Yd >= 0) {

   j = 1;

   mywt = atof(col[j++]);

   if (mywt > 0.0) {  // we have an entry = not all days are logged
   
   // LDVEC[Nobs] = jday;
    

    WTVEC[Yd] = mywt;

//<<"$k  mywt  $WTVEC[Nobs] \n"
    if (mywt > 0.0) {
       last_known_wt = mywt;
       last_known_day = Yd;
    }
    else {
      WTVEC[Yd] = last_known_wt;
    }


   walk =  atof(col[j++])
   hike = atof(col[j++]) 
   run = atof(col[j++]) 
   cycle =  atof(col[j++])
   swim =  atof(col[j++])
   yardwrk =  atof(col[j++])
   wex = atof(col[j++])

   EXTV[Yd] =  ( walk + hike + run + cycle + swim + yardwrk + wex)

   CARDIO[Yd] = ( walk + hike + run + cycle + swim )

   STRENGTH[Yd] = (yardwrk + wex)

      
   tot_exetime = tot_exetime + EXTV[Yd];


   SEVEC[Yd] =  wex;
   
   BPVEC[Yd] =  atof(col[j++]);

// any extra activities ?

   tex = EXTV[Yd];

   exer_burn =   walk * w_rate; 
   exer_burn += hike * h_rate
   exer_burn += run * run_rate
   exer_burn +=  cycle * c_rate
   exer_burn += swim * swim_rate
   exer_burn += yardwrk * yard_rate
   exer_burn += wex * wex_rate;


   EXEBURN[Yd] =  exer_burn;


   tot_exeburn += exer_burn;


   wrk_sleep  = (sleep_burn + (16 * 60 - tex) * office_rate )  ;

    CALBURN[Yd] =  wrk_sleep + exer_burn ;

    Nobs++;
      }
   }
 }
//====================================================//


long Yd;
svar col;


void readData()
{

  int tl = 0;

  col= RX[tl];

//<<"$col\n"

  day = col[0];

//<<"%V $day $Nrecs\n"

// data has already been read into Record array RX
 // RX->info(1)
      
   

  while (tl < Nrecs) {

  //tl->info(1)     // ? bad
  

      col= RX[tl];

 //<<"<$tl> $RX[tl]\n"

    day = col[0];
 //   day->info(1);

     jday = julian(day) 

//   jday->info(1)
    
    if (!got_start) {
        sday = jday
        got_start = 1;
    }

    Yd = jday - Jan1;

<<"%V $jday  $Yd\n"

    lday = Yd;


   if (Yd < 0) {
       <<" $Yd neg offset ! \n";
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



<<[_DB]"$Nrecs there were $tl $Nobs measurements \n"
     return tl;
}


//==============================================//

int NCCobs =0;

proc fillInCCObsVec()
{
 
 if (Yd >= 0) {


  CALSCON[Yd] =  atof(col[1]);
  CARBSCON[Yd] = atof(col[2]);

   NCCobs++;
<<"Yd $NCCobs $CALSCON[Yd] $CARBSCON[Yd] \n"



   }
}
//====================================================//


void readCCData()
{

  tl = 0;

//svar ccol;


  while (tl < NCCrecs) {


    //ccol = RCC[tl];

//<<[_DB]"$RCC[tl]\n"
//<<[_DB]"$tl  $NCCobs $NCCrecs\n"

    //day = ccol[0];

    day = RCC[tl][0];
//<<"%V $day\n"
    jday = julian(day) 

    Yd = jday - Jan1;  // so 0 - 364

    lday = Yd;
   


  cals = atof(RCC[tl][6]);
  
  CALSCON[Yd] = cals;
  ccals =  CALSCON[Yd];
  
<<"calscon $Yd   $CALSCON[Yd]  cals <|$cals|>  ccals $ccals \n"

  carbs = atof(RCC[tl][3]);

  CARBSCON[Yd] = carbs;

  fat = atof(RCC[tl][2]);
  FATCON[Yd] = fat;

  prot = atof(RCC[tl][5]);  
  PROTCON[Yd] = prot;

  fiber = atof(RCC[tl][4]);  
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
<<[_DB]"$_include \n"
;//==============\_(^-^)_/==================//;
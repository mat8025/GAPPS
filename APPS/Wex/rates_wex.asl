/* 
 *  @script rates_wex.asl 
 * 
 *  @comment rates 
 *  @release CARBON 
 *  @vers 1.2 He 6.3.97 C-Li-Bk 
 *  @date 03/17/2022 21:57:39          
 *  @cdate Sat Dec 29 08:54:39 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//----------------<v_&_v>-------------------------//                                                  




float rpm = 0.0166667;
float w_rate = 350.0 * rpm; // 3 miles an hour ? 180 lbs
float h_rate = 477.0 * rpm;
float c_rate = 636.0 * rpm;
float run_rate = 795.0 * rpm;
float gym_rate = 350.0 * rpm;
float swim_rate = 477.0 * rpm;
float yard_rate =  318.3 *rpm;

//  metabolic rate slowdown ??

float metaf = 0.95;

float office_rate =  119.3 * rpm * metaf;
float sleep_rate = 71.5 * rpm  * metaf;


float sleep_burn = 8 * 60 * sleep_rate;
float office_burn = 16 * 60 * office_rate;
float day_burn = sleep_burn + office_burn;

//<<"%V $day_burn \n"

float out_cal = day_burn * 5/4;
float in_cal =  day_burn * 3/4;

//<<"%V$out_cal $in_cal \n"

//<<"Including wex_rates.asl \n"

;//==============\_(^-^)_/==================//;
//%*********************************************** 
//*  @script wex_rates.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sat Dec 29 08:53:12 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

;


rpm = 0.0166667
w_rate = 397.0 * rpm
h_rate = 477.0 * rpm
c_rate = 636.0 * rpm
run_rate = 795.0 * rpm
wex_rate = 350.0 * rpm
swim_rate = 477.0 * rpm
yard_rate =  318.3 *rpm

//  metabolic rate slowdown ??

metaf = 0.95

office_rate =  119.3 * rpm * metaf
sleep_rate = 71.5 * rpm  * metaf


sleep_burn = 8 * 60 * sleep_rate
office_burn = 16 * 60 * office_rate
day_burn = sleep_burn + office_burn

<<"%V $day_burn \n"

out_cal = day_burn * 5/4
in_cal =  day_burn * 3/4

//<<"%V$out_cal $in_cal \n"

<<"Including wex_rates.asl \n"

;//==============\_(^-^)_/==================//;
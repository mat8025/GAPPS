//%*********************************************** 
//*  @script enum_val_from_name.asl 
//* 
//*  @comment test enum 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%

/{/*

/}*/

include "debug.asl";
  debugON();
  setdebug(1,@keep,@pline,@~trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);

svar S
i= 0
S[i++]="MON"
S[i++]="TUE"
S[i++]="WED"
S[i++]="THU"
S[i++]="FRI"
S[i++]="SAT"
S[i++]="SUN"



for (i= 0; i < 7; i++) {
<<"$S[i] \n"
}


<<" $(typeof(S))  $(Caz(S))\n"
<<"//////////// \n"
include "days_enum"

<<" $(typeof(days))  $(Caz(days))\n"

<<"$days \n"

<<"$days[0] \n"

for (i= 0; i <=13; i++) {
<<"$days[i] \n"
}

<<"%V $(MON) $days->MON \n"




 wv = days->enumValueFromName("TUE")
 th = days->enumValueFromName("THU")
 wd = days->enumNameFromValue(2)
<<"$wv  $(TUE) $wd $th\n"
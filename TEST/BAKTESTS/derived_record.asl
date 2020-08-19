///
///
///


setdebug(1,@keep,@trace,@pline);
FilterDebug(ALLOWALL_)
FilterFileDebug(ALLOWALL_,"args_e.cpp")

  int Vec[20];


     Vec = 100;

<<"$Vec \n"



 Record R[10];

 R[0] = Split("80,1,2,3,40,5,6,7,8,9",",");


  <<"$R[0] \n"


exit();
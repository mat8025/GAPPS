///
///  subrange vector assign
///

filterFuncDebug(ALLOWALL_,"varArraySpec","varArrayIndex");
filterFileDebug(ALLOW_,"array_parse","array_range","ds_storevar","~ds_storesvar","~ic_wic");

setdebug(1,@keep,@trace);



checkIn()

 I = Vgen(INT_,40,0)

<<"$I \n"

 I[5:8] = 10;

 <<" $(info(I)) \n"
<<"$I\n"

checkFnum(I[0],0)
checkFnum(I[5],10)
checkFnum(I[8],10)

checkOut()

 I[20:28:2] = 79;

<<"$I\n"

 I[16:14:-1] = 47;

<<"$I\n"

 I[13:13] = 80;

<<"$I\n"


 I = 0;
<<"$I\n"
<<"all zero ??\n"
checknum(I[0],0)
checknum(I[1],0)

 I[::] = 79;

<<"$I\n"
<<"all gold ??\n"
checknum(I[8],79)
<<"/////////\n"
 I = 47;
<<"$I\n"
<<"all silver ??\n"
checknum(I[9],47)
<<"/////////\n"
 I[::] = 80;

<<"$I\n"
<<"all fast ??\n"
checknum(I[10],80)

<<"/////////\n"

 I[0:5:] = 47;
  I[6:10:] = 79;
checknum(I[9],79)


  I[11:15:] = 28;

checknum(I[15],28)
<<"$I\n"
  I[30:30] = 30;
checknum(I[0],47)

checknum(I[30],30)
checknum(I[31],80)
<<"$I\n"


checkOut();
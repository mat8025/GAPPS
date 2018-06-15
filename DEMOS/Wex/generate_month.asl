///
///
///

svar Mo[] = { "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC"}


mn = -8015123457898;

mon = itoa(mn,10);

<<"$mon\n"



mn = 8;

mon = itoa(mn,10);



if (mn<10) {

mon = scat("0",mon);
}
yr = 2017;
/// leap ?
leap_yr = 0;

days_in_month = 31;

// num of days
/// 30 days sep april,june, & nov
ndays = 31;
<<"# $Mo[mn]  $yr\n"
<<"#   date       Wt      walk  hike run  bike  swim Ydwk Exer Bpress\n"
//WEX 08/01/2017 0        0.0   0    0     0.0    0   0    0   0
  
  for (i = 1 ; i <= ndays; i++) {
  if (i <10) 
<<"WEX ${mon}/0${i}/$yr 0        0.0   0    0     0.0    0   0    0   0\n"
  else
<<"WEX ${mon}/${i}/$yr 0        0.0   0    0     0.0    0   0    0   0\n"
}
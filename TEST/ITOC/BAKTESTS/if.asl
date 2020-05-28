//%*********************************************** 
//*  @script if.asl 
//* 
//*  @comment test ifnest 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Apr  8 09:07:32 2019 
//*  @cdate Mon Apr  8 09:07:32 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
checkIn()



i = 2
j = 0;


 if (i == 2) {
   <<" $i == 2 \n"
   j = 1;
 }
 else if (i > 2) {
  <<" $i > 2 \n"
 }
 else {
  <<" $i < 2 \n"
 }



checkNum(j,1)

i = 3
j = 0;


 if (i == 2) {
   <<" $i == 2 \n"
   j = 1;
 }
 else if (i > 2) {
  <<" $i > 2 \n"
  j = 2
 }
 else {
  <<" $i < 2 \n"
  j = -1
 }

checkNum(j,2)


i = 0
j = 0;


 if (i == 2) {
   <<" $i == 2 \n"
   j = 1;
 }
 else if (i > 2) {
  <<" $i > 2 \n"
  j = 2
 }
 else {
  <<" $i < 2 \n"
  j = -1
 }

checkNum(j,-1)


checkOut()
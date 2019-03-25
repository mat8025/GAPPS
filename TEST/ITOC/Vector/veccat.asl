//%*********************************************** 
//*  @script veccat.asl 
//* 
//*  @comment test concat of vectors using @+ operator 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Fri Feb  8 20:22:01 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl";

  debugON();
  setdebug(1,@keep,@pline,@trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);



checkIn()
int vec1[]  = { 1,2,3};

<<"$vec1 \n"

vec1->info(1)

int vec2[] = {7,8,9}

<<"%V $vec2\n"

vec2->info(1)

int vec3 []  = vec1 @+  vec2;

<<"%V $vec3 \n"
<<"$vec3[1] $vec3[2] $vec3[4] \n"

vec4 = vec1 @+  vec2;

<<"%V $vec4 \n"


checkNum(vec4[5],9)
checkNum(vec4[1],2)

vec4 = vec4 @+  vec2;

<<"%V $vec4 \n"

checkNum(vec4[8],9)
checkNum(vec4[1],2)

vec5 = vec1 @+  vec2 @+ vec3 ;

<<"%V $vec5 \n"

checkNum(vec5[1],2)

checkOut()

//%*********************************************** 
//*  @script colors_enum.asl 
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



#define AG 47

CheckIn()

int gold = 79

<<"%V $gold \n"

<<"type $(typeof(gold))  sz $(Caz(gold)) \n";


int silver = AG ;

<<"$silver $(typeof(silver))  \n";


// can't use runtime vars to initialize
// enum is done on the first pass


checkNum(gold,79)


enum colors  {   // all the colors 
             BC_COL = 1,
             WC_COL  	     
};


c_type = typeof(colors)

//enum drinks { TEA, COFFEE, MILK, BEER };

enum drinks {
    TEA,
    COFFEE,
    MILK,
    BEER
};

CheckOut()

exit()

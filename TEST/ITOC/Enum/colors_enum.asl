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

 ci (_dblevel)




int gold = 79

<<"%V $gold \n"

<<"type $(typeof(gold))  sz $(Caz(gold)) \n";





// can't use runtime vars to initialize
// enum is done on the first pass


#define AG 47

svar names = {"billy", "bob" ,"joe"}


<<"type $(typeof(names))  $(Caz(names)) \n";



enum colors  {   // all the colors 
              BLACK_COL, 
              WHITE_COL,
              RED_COL,               // rainbow plus
              ORANGE_COL,
              YELLOW_COL,
              GREEN_COL,
              BLUE_COL,
              VIOLET_COL,
              GREY_COL,
              GOLD_COL  = 79,
              SILVER_COL = AG,   // rgb --- 
              PLATINUM_COL = 78,
              MERCURY_COL = (2*35+10)            
};


red = RED_COL
violet = VIOLET_COL


<<"$(typeof(RED_COL)) $(typeof(red))\n"

<<"RED $red   %V$violet  $(GOLD_COL)  $(SILVER_COL)\n"
<<" $colors \n"



c_type = typeof(colors)

<<"$c_type \n"

sz= Caz(colors);

<<"type $(typeof(colors))  $sz \n";

<<"$sz  $colors[0] $colors[1] \n"

exit()


if (sz < 100) {
<<"%(2,, ,\n)$colors\n"
}
<<"type $(typeof(colors))  sz $(Caz(colors)) \n";



<<" $(typeof(colors)) \n"
bc = colors[3]
<<"%V$bc \n"

red = RED_COL
violet = VIOLET_COL

<<"RED $red   %V$violet  $(GOLD_COL)  $(SILVER_COL)\n"




CheckNum(2,RED_COL)
CheckNum(79,GOLD_COL)
CheckNum(GOLD_COL,79)
CheckNum(PLATINUM_COL,78)

CheckNum(SILVER_COL,47)
CheckNum(MERCURY_COL,80)

<<"  $(MERCURY_COL)\n"

CheckNum(violet,7)

enum drinks {
   TEA,
   COFFEE,
   MILK,
   BEER
};

sz= Caz(drinks);

<<"%V $sz \n"

sz= Caz(&drinks);

<<"%V $sz \n"

<<" $(TEA), $(COFFEE), $(MILK), $(BEER) \n"

<<"%V $drinks[0] \n"

proc foo()
{
yt = BEER
<<"%V $yt should be $(BEER)\n"
<<" $(TEA), $(COFFEE), $(MILK), $(BEER) \n"
CheckNum(yt,3)
}

proc goo()
{
yt = COFFEE
<<"%V $yt \n"
<<" $(TEA), $(COFFEE), $(MILK), $(BEER) \n"
CheckNum(yt,1)
}

foo()

goo()


CheckNum(3,BEER)

CheckOut()


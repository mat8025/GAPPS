CheckIn()

setdebug(1)

#define AG 47

int gold = 79

<<"%V $gold \n"

<<"type $(typeof(gold))  sz $(Caz(gold)) \n";


// can't use runtime vars to initialize
// enum is done on the first pass

enum colors  {   // all the colors 
              BLACK_COL, 
              WHITE_COL,
              RED_COL,               // rainbow plus
              ORANGE_COL,
              YELLOW_COL,
              GREEN_COL,
              BLUE_COL,
              INDIGO_COL,
              VIOLET_COL,
              GREY_COL,
              GOLD_COL  = 79,
              SILVER_COL = AG,   // rgb --- 
              PLATINUM_COL = 78,
              MERCURY_COL = (2*35+10)            
};


c_type = typeof(colors)

<<"$c_type \n"

<<"type $(typeof(colors))  sz $(Caz(colors)) \n";

<<"%(2,, ,\n)$colors\n"

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

CheckNum(violet,8)

enum drinks { TEA, COFFEE, MILK, BEER };

<<" $(TEA), $(COFFEE), $(MILK), $(BEER) \n"



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


stop!

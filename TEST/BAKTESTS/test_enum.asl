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
};


c_type = typeof(colors)

<<"$c_type \n"


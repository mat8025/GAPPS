//%*********************************************** 
//*  @script svar_range.asl 
//* 
//*  @comment test svar range use 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Apr  7 08:51:31 2019 
//*  @cdate Sun Apr  7 08:51:31 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



include "debug.asl"; 
debugON();

   setdebug (1, @pline, @~step, @~trace,) ;
   FilterFileDebug(REJECT_,"~storetype_e");
   FilterFuncDebug(REJECT_,"~ArraySpecs",);


CheckIn()

IV = vgen(INT_,10,0,1)

S= Split("$IV")

S->info(1)

<<"$S\n"

checkStr(S[1],"1")
checkStr(S[2],"2")
checkStr(S[3],"3")

checkStage ("assign via Split")


T= Split("%6.2f$(vgen(FLOAT_,10,0,0.5))")

<<"$T\n"

checkStr(T[1],"0.50")
checkStr(T[2],"1.00")
checkStr(T[3],"1.50")

checkStage ("assign via Split print")

// 
<<"$S[1:7]\n"

T= S[1:7:]

<<"$T\n"

R= Split("47 79 80 81 82 83 84 85 86 87")

<<"$R\n"

   setdebug (1, @trace) ;

S[1:4:] = R


<<"$S\n"

checkStr(S[1],"47")
checkStr(S[2],"79")
checkStage ("lh range assign")

S= Split("$IV")

<<"$S\n"

S[1:8:2] = R


<<"$S\n"

checkStr(S[1],"47")
checkStr(S[3],"79")
checkStr(S[5],"80")

checkStage ("lh range stride 2 assign")


S= Split("$IV")

S[1:4:] = R[1:4]

<<"$S\n"

checkStr(S[1],"79")
checkStr(S[2],"80")
checkStage ("lh range assign and rh range")


S= Split("$IV")

S[1:8:2] = R[1:8:2]


checkStr(S[1],"79")
checkStr(S[3],"81")

<<"$S\n"

checkStage ("lh range assign and rh range -both stride 2")

checkOut() ; 




//////////////////////////////////////////

Svar W;


W[0] = "hey"


<<"%v $W[0] \n"

 W[1] = "marcos"

<<"%v $W[1] \n"

<<"%v $W[0] \n"

 W[2] = "puedes"

<<" $W \n"

 W[3] = "hacer"


<<"%v $W[0] \n"


 W[4] = "tus"

 W[5] = "metas"

 W[6] = "amigo"


 W[7] = "?"

// W[8] = "?"

<<"W[0::]  $W[0::] \n"



<<"W[2::]  $W[2::]\n"


T= W[2::]

<<"T $T\n"

<<"T[0] $T[0]\n"

<<"T[1] $T[1]\n"

checkStr(T[0],"puedes")
checkStr(T[0],W[2])

checkOut()
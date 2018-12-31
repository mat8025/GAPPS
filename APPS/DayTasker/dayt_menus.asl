//%*********************************************** 
//*  @script dayt_menus.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Tue Dec 25 08:04:48 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

 //=============== MENUS=================//
 A=ofw("Howlong.m")
 <<[A],"title HowLong\n"
 <<[A],"item 0m M_VALUE 0\n"
 <<[A],"item 5m M_VALUE 5\n"
 <<[A],"item 10m M_VALUE 10\n"
 <<[A],"item 15m M_VALUE 15\n"
 <<[A],"item 30m M_VALUE 30\n"
 <<[A],"item 45m M_VALUE 45\n"
 <<[A],"help 45m\n"
 <<[A],"item 1hr M_VALUE 60\n"
 <<[A],"help 1 hour\n"
 <<[A],"item 90m M_VALUE 90\n"
 <<[A],"help hour and half\n"
 <<[A],"item 2hr M_VALUE 120\n"
 <<[A],"help two hours\n"
 <<[A],"item ? C_INTER "?"\n"
 <<[A],"help set mins\n"
 cf(A)
 //=================================//
 
 A=ofw("Favorites.m")
 <<[A],"title Favorites\n"
 <<[A],"item Guitar M_VALUE 1\n"
 <<[A],"help play/practice\n"
 <<[A],"item Language M_VALUE 2\n"
 <<[A],"help converse\n"
 <<[A],"item Exercise M_VALUE 3\n"
 <<[A],"help burn fat\n"
 <<[A],"item PR/DSP M_VALUE 4\n"
 <<[A],"help learn/code\n"
 cf(A)
 //==============================//
 
 A=ofw("PCdone.m")
 <<[A],"title PCdone\n"
 <<[A],"item 0% M_VALUE 0\n"
 <<[A],"item 5% M_VALUE 5\n"
 <<[A],"item 10% M_VALUE 10\n"
 <<[A],"item 25% M_VALUE 25\n"
 <<[A],"item 50% M_VALUE 50\n"
 <<[A],"item 75% M_VALUE 75\n"
 <<[A],"item 90% M_VALUE 90\n"
 <<[A],"item 100% M_VALUE 100\n"
 <<[A],"item ? C_INTER "?"\n"
 <<[A],"help set pcdone\n"
 cf(A)
 //==============================//
 A=ofw("Priority.m")
 <<[A],"title Priority 1-7\n"
 <<[A],"item 1 M_VALUE 1\n"
 <<[A],"item 2 M_VALUE 2\n"
 <<[A],"item 3 M_VALUE 3\n"
 <<[A],"item 4 M_VALUE 4\n"
 <<[A],"item 5 M_VALUE 5\n"
 <<[A],"item 6 M_VALUE 6\n"
 <<[A],"item 7 M_VALUE 7\n"
 <<[A],"item 8 M_VALUE 8\n"
 <<[A],"item 9 M_VALUE 9\n"
 <<[A],"item 10 M_VALUE 10\n"   
 cf(A)
 //==============================//
 A=ofw("Difficulty.m")
 <<[A],"title Difficulty\n"
 <<[A],"item 1 M_VALUE 1\n"
 <<[A],"item 2 M_VALUE 2\n"
 <<[A],"item 3 M_VALUE 3\n"
 <<[A],"item 4 M_VALUE 4\n"
 <<[A],"item 5 M_VALUE 5\n"
 <<[A],"item 6 M_VALUE 6\n"
 <<[A],"item 7 M_VALUE 7\n"
 cf(A)
 //==============================//
 A=ofw("Attributes.m")
 <<[A],"title Attributes\n"
 <<[A],"item X M_VALUE X\n"
 <<[A],"item G M_VALUE G\n"
 <<[A],"item F M_VALUE F\n"
 <<[A],"item C M_VALUE C\n"
 <<[A],"item L M_VALUE L\n"
 <<[A],"item Y M_VALUE Y\n"
 <<[A],"item H M_VALUE H\n"
 <<[A],"item B M_VALUE B\n"
 <<[A],"item ? C_INTER "?"\n"
 <<[A],"help set task attribute\n"
 cf(A)
 //==============================//
 
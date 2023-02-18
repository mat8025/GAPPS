//%*********************************************** 
//*  @script stuff2do_menus.asl 
//* 
//*  @comment menus for stuff2do 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Tue Feb 25 21:35:51 2020 
//*  @cdate Tue Feb 25 21:35:51 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%




//////   create MENUS here  /////
A=ofw("MENUS/Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 0 M_VALUE 0\n"
<<[A],"help no time yet\n"
<<[A],"item 0.25 M_VALUE 0.25\n"
<<[A],"help 1/4-hour\n"
<<[A],"item 0.5 M_VALUE 0.5\n"
<<[A],"help half-hour\n"
<<[A],"item 0.75 M_VALUE 0.75\n"
<<[A],"help 3/4-hour\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"help 1 hour\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"help hour \n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"help 4 hours\n"
<<[A],"item 8 M_VALUE 8\n"
<<[A],"help 8 hours\n"
<<[A],"item 16 M_VALUE 16\n"
<<[A],"help 16 hours\n"
<<[A],"item 24 M_VALUE 24\n"
<<[A],"help 24 hours\n"
<<[A],"item 40 M_VALUE 40\n"
<<[A],"help 40 hours\n"
<<[A],"item ? C_INTER ?\n"
<<[A],"help set howlong\n"
cf(A)
//=============================
A=ofw("MENUS/PCdone.m")
<<[A],"title PCdone\n"
<<[A],"item 5% M_VALUE 5\n"
<<[A],"item 10% M_VALUE 10\n"
<<[A],"item 25% M_VALUE 25\n"
<<[A],"item 50% M_VALUE 50\n"
<<[A],"item 75% M_VALUE 75\n"
<<[A],"item 90% M_VALUE 90\n"
<<[A],"item 100% M_VALUE 100\n"
<<[A],"item ? C_INTER ?\n"
<<[A],"help set pcdone\n"
cf(A)
//==============================//
A=ofw("MENUS/Priority.m")
<<[A],"title Priority 1-10\n"
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
A=ofw("MENUS/Difficulty.m")
<<[A],"title Difficulty\n"
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

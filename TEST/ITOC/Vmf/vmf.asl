//%*********************************************** 
//*  @script vmf.asl 
//* 
//*  @comment test vmf - var member function 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat Apr 11 23:11:04 2020 
//*  @cdate Sat Apr 11 23:11:04 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_");

setdebug(1,@pline,@trace)


// test cut array

CheckIn()

int I[] ;

I= Igen(20,0,1)

<<" $I \n"

 I[14]->Set(747)

<<" $I\n"

I[5:13:2]->Set(50,1)

<<"$I \n"




C = Igen(4,12,1)

<<" $C \n"

I->cut(C)



<<" $I \n"

CheckNum(I[12],16)




float F[]

F= Fgen(20,0,1)

sz = Caz(F)
<<"$sz $F \n"
//<<"%,j%{5<,\,>\n}%6.1f$F\n"

<<"%6.1f $F\n"

C = Igen(4,12,1)

<<"%V $C \n"

F->cut(C)


<<"%6.1f  $F \n"
CheckFNum(I[12],16,6)


<<" $I[::] \n"

I[3:8]->cut()

<<" $I[::] \n"
CheckNum(I[3],52)

F[3:8]->cut()

<<" %6.1f $F[::] \n"
CheckFNum(F[3],9,6)

F[3]->cut()

<<" %6.1f $F[::] \n"

F[3]->obid()

id = F[3]->obid()

<<" $id \n"


CheckOut()

//%*********************************************** 
//*  @script svar_table.asl 
//* 
//*  @comment svar as lookup table 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue May  7 17:49:28 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

sdb(1)
checkin()
Svar S

S->table("LUT",30,2) //   table

key = "mat"
val = "303 712 1066"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"


key = "ron"
val = "303 642 1234"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"

key = "sally"
val =  "719 229 2001"

index=S->addkeyval(key,val) // returns index

<<"%V$key $val $index\n"


key = "jan"
val =  "615 123 4567"

index=S->addkeyval(key,val) // returns index


key = "mat"
val = S->lookup(key)
<<"$key $val \n"


key = "ron"
val = S->lookup(key)
<<"$key $val \n"

key = "sally"
val = S->lookup(key)
<<"$key $val \n"


key = "jan"
val = S->lookup(key)
<<"$key $val \n"

checkstr(val,"615 123 4567")

checkOut()
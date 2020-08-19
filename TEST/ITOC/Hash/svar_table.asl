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
myScript = getScript();


include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn (_dblevel)
Svar S

S->table("LUT",2,2) //   table

key = "mat"
val = "303 712 1066"

windex = 0;

index=S->addkeyval(key,val, windex) // returns index


windex++;
<<"%V$key $val $index\n"


key = "ron"
val = "303 642 1234"

index=S->addkeyval(key,val,windex) // returns index
windex++;
<<"%V$key $val $index\n"

key = "sally"
val =  "719 229 2001"

index=S->addkeyval(key,val,windex) // returns index

<<"%V$key $val $index\n"


key = "jan"
val =  "615 123 4567"

index=S->addkeyval(key,val) // returns index
<<"%V$key $val $index\n"

key = "lauren"
val =  "709 123 4567"

index=S->addkeyval(key,val) // returns index
<<"%V$key $val $index\n"



key = "mat"
val = S->lookup(key)
<<"$key $val \n"

chkStr (val,"303 712 1066")


key = "ron"
val = S->lookup(key)
<<"$key $val \n"

chkStr (val,"303 642 1234")



key = "sally"
val = S->lookup(key)
<<"$key $val \n"

chkStr (val,"719 229 2001")

key = "jan"
val = S->lookup(key)
<<"$key $val \n"

chkStr (val,"615 123 4567")

key = "lauren"
val = S->lookup(key)
<<"$key $val \n"

chkStr (val,"709 123 4567")

chkOut ()
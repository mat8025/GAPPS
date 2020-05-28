//%*********************************************** 
//*  @script svar_hash.asl 
//* 
//*  @comment svar as hash table 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue May  7 19:17:52 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

include "debug"
debugON()
sdb(1,@pline)

checkin()
Svar S

tsz = 30;
nplace = 2

S->table("HASH",tsz,nplace) // makes Svar a hash type -- could extend table

key = "Hastings"
ival = 1066
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"



key = "Agincourt"
ival =  1415
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key = "Waterloo"
ival =  1815
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key = "Gettysburg"
ival =  1863
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"


key= "Trafalgar"
ival = 1805
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key= "Somme"
ival = 1916
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key= "Verdun"
ival = 1916
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key= "Midway"
ival = 1942
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"


key= "Stalingrad"
ival = 1942
index=S->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"



val = S->lookup(key)

<<"$key  $val\n"

key= "Hastings"
val = S->lookup(key)

<<"$key  $val\n"

key= "Gettysburg"
val = S->lookup(key)

<<"$key  $val\n"

sz= S->caz()
<<"$sz $S[0] \n"
sdb(1,@~pline)
 for (i=0; i <sz; i += 2) {
    // if (scmp(S[i],"") == 0) {
     if (!scmp(S[i],"") ) {
       <<"$i $S[i] $S[i+1]\n"
    }
  }

checkStr(val,"1863")
key= "Stalingrad"
val = S->lookup(key)
checkStr(val,"1942")

checkOut()


uchar SV[]

SV= "ABC"


<<"$SV\n"
<<"%s $SV\n"

SV= "ABC@"

<<"$SV\n"
<<"%s $SV\n"
 for (i=0; i <sz; i += 2) {
 if (!(S[i] @= "")) {
<<"<$i> $S[i] @= ?\n"
 }
 }

exit()





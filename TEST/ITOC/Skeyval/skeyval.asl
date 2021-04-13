/* 
 *  @script skeyval.asl 
 * 
 *  @comment test sort of lookup table via value,num 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.7 C-Li-N]                                  
 *  @date Sun Jan 10 10:17:47 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */
 
// key-val pairs via Svar

<|Use=
Demo key-value pairs use of Svar
kv->addKeyVal("smarter","pushed")
  
|>

proc showUse()
{
  <<"$Use\n"
}


#include "debug"

if (_dblevel >0) {
   debugON()
}

chkIn(_dblevel)


Svar S

S[0] = "ele 0"
S[1] = "ele 1"
S[5] = "ele 5"

sz=Caz(S)
<<"%V$sz $S\n"
S->info(1)
chkStr(S[5],"ele 5");



Svar kv
kv->table(LUT_,1,2)

  kv->addKeyVal("mark","is",0)
  kv->addKeyVal("terry","good")
  kv->addKeyVal("work","when")
  kv->addKeyVal("smarter","pushed")

<<"%V $kv[0] $kv[1] \n"
<<"%V $kv[2] $kv[3] \n"
<<"%V $kv[4] $kv[5] \n"

  iv = kv->lookup("smarter")

<<"%V$iv \n"


  iv = kv->lookup("work")

<<"%V$iv \n"



chkStr(iv,"when")

 wi = kv->findVal("work")

<<"%V $wi \n"
wi->info(1)


chkN(wi[0],4)



wi = kv->keySort()

<<"key sort \n"
<<"$kv \n"

<<"%(2,, ,\n)$kv \n"
<<"value sort\n"


wi = kv->Sort(1)

<<"%(2,<,\, ,>\n)$kv \n"

<<"///////////////////\n"
chkStr(kv[1],"good")
Svar kvn

kvn->table(LUT_,1,2)

  kvn->addKeyVal("mark",1,0)
  kvn->addKeyVal("terry",3)
  kvn->addKeyVal("work",7)
  kvn->addKeyVal("smarter",0)

//wi = kvn->valueNumSort()
wi = kvn->sortNum(1)


<<"$kvn\n"

<<"%(2,, ,\n)$kvn \n"

<<"\n$kvn\n"

kvn->info(1)

sz=Caz(kvn);

ws= kvn[1]
<<"%V$sz $ws\n"
ws->info(1);
kvn->info(1)

ws= kvn[4]
<<"%V$ws\n"
for (i=0;i<sz;i++) {
ws= kvn[i]
<<"$i <|$ws|>\n"
}


<<"%V$sz <|$kvn[0]|> $kvn[1] $kvn[1]\n"

<<"%(2,, ,\n)$kvn \n"


chkStr(kvn[0],"smarter")

chkOut()
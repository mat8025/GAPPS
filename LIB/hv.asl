//%*********************************************** 
//*  @script hv.asl 
//* 
//*  @comment parse @vers from script header 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Fri Feb 22 15:49:47 2019 
//*  @cdate 12/15/2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


//  examines header
//  any @var that is found is added to _HV table e.g.
//  @hvar  word1 word2 ...
//  and can be retrieved via
//  key = "@varname" ; val = _HV->lookup(key);
//  val will contain word1 word2 ... till the end of that header line
//  so you can retrieve @vers,@author,@date values that are in the header

Svar _HV

_HV->table("HASH",50,2) //  
svar L;
int found =0;
str fl;
int sz;
for (wln = 1; wln <= 40;wln++) {
 fl = getcodeln(wln,0);
 if (! (fl @= "")) {
 L=split(fl)
//<<"$wln $fl "
//<<"$L \n"
sz=Caz(L)
//<<"sz $sz L[] $L \n"
if (sz > 1) {
 if (scmp(L[0],"//",2)) {
//<<"fl <|$fl|> L1 <|$L[1]|> \n"
if (!(L[1] @= "")) {

   if (scmp(L[1],"@",1)) {


   val = spat(fl,L[1],1)
//<<"$val\n"
    if (!found) {
      if (!(L[1] @="@script")) {
<<"no header found!\n"
        break;
      }
      found = 1;
    }

    index=_HV->addkeyval(L[1],val); // returns index
// <<"$index $L[1] $val \n"
  }
  }
  }
  }
 }
}

//============================//
_ele_vers = "H";
_ele = 1;
if (found) {
key = "@vers" ;
vers = _HV->lookup(key);
vw= split(vers)
_ele_vers = vw[2]
_ele = ptAN(_ele_vers)
//<<"%V $_ele_vers $_ele \n"
<<[_DB]"%V$vers $_ele_vers\n"
}
//=============================//
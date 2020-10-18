//%*********************************************** 
//*  @script hv.asl 
//* 
//*  @comment parse @vers from script header 
//*  @release CARBON 
//*  @vers 1.5 B Boron [asl 6.2.77 C-He-Ir]                                
//*  @date Sat Oct 17 17:21:11 2020 
//*  @cdate 12/15/2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


//  examines header
//  any @var that is found is added to _HV table e.g.
//  @hvar  word1 word2 ...
//  and can be retrieved via
//  key = "@varname" ; _val = _HV->lookup(key);
//  _val will contain word1 word2 ... till the end of that header line
//  so you can retrieve @vers,@author,@date values that are in the header

Svar _HV

_HV->table("HASH",50,2) //

int hv_found =0;

proc hv_func()
{
svar L;

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


    _val = spat(fl,L[1],1)
//<<"$_val\n"
    if (!hv_found) {
      if (!(L[1] @="@script")) {
<<"no header found!\n"
        break;
      }
      hv_found = 1;
    }

    index=_HV->addkeyval(L[1],_val); // returns index
// <<"$index $L[1] $_val \n"
  }
  }
  }
  }
 }
}
   
}

hv_func();



//============================//
_ele_vers = "H";
_ele = 1;
if (hv_found) {
key = "@vers" ;
_vers = _HV->lookup(key);
_vw= split(_vers)
_ele_vers = _vw[2]
_ele = ptAN(_ele_vers)
//<<"%V $_ele_vers $_ele \n"
<<[_DB]"%V$vers $_ele_vers\n"
}
//=============================//
delete(hv_found);

/////////////////////////// DEV //////////////////////////
/{/*

 make proc and call
 otherwise have globals 
 delete any tmp? globals

/}*/
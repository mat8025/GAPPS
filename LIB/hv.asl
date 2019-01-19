//%***********************************************
//  @script             hv.asl 
//
//  @comment test to get access to header vars
//  @release CARBON 
//  @vers 1.3 H.Li
//  @date Thu Dec 20 20:56:59 2018    
//  @author Mark Terry      
//  @CopyRight  RootMeanSquare  2014,2018 --> 
// 
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


for (wln = 1; wln <= 40;wln++) {
 fl = getcodeln(wln,0);
 if (! (fl @= "")) {
 L=split(fl)
//<<"$wln $fl "
 if (scmp(L[0],"//",2)) {
  if (scmp(L[1],"@",1)) {
    val = spat(fl,L[1],1)

    index=_HV->addkeyval(L[1],val); // returns index
// <<"$index $L[1] $val \n"
  }
  }
 }
}

//============================//

key = "@vers" ;
vers = _HV->lookup(key);
vw= split(vers)
_ele_vers = vw[2]
_ele = ptAN(_ele_vers)
<<"%V $_ele_vers $_ele \n"
<<[_DB]"%V$vers $_ele_vers\n"

//=============================//
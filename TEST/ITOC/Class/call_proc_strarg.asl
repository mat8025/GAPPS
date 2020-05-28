


include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_");

setdebug(1,@pline,@trace)


  proc Vers2ele(str vstr)
  {
  
   pmaj = atoi(spat(vstr,"."))
   pmin = atoi(spat(vstr,".",1))
  <<[2]"%V $pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  //<<"$ele $(typeof(ele))\n";
  //<<"$ele";
   return ele;
   
  }


str cvers = "1.1"


nele = Vers2ele(cvers)


<<"found_vers $cvers $nele\n"

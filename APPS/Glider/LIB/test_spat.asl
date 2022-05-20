
Str NL;
int match[2]

NL = "//<<\"sz Ntpts (Caz(IGCLONG))   (Caz(IGCLAT))\n"


  rem=spat(NL,"Nt",0,-1,match);

<<"$rem $match \n"
  rem= spat(NL,"//",0,-1,match);

<<"$rem $match \n"


exit();

////

checkIn()

  S= " a  word";
  <<"$S\n"

  S->Splice("missing",3)

<<"$S\n"

  S->Splice("Begin",0)

<<"$S\n"
  len = slen(S)

  S->Splice(" End",len)

<<"$S\n"

Wd = split(S)

<<"$Wd\n"

<<"$Wd[4]\n"
checkStr(Wd[2],"missing")
checkStr(Wd[4],"End")
checkStr(Wd[0],"Begin")

checkOut()
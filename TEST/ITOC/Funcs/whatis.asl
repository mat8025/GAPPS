///
///
///



S=whatis("mapvec")
len=slen(S)
<<"<$len> $S\n"


posn=regex(S,"maps ")

<<"$posn"

posn=regex(S,"  +")

<<"$posn\n"

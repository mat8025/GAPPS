///
///  file ops
///

chkIn(1)

sz=fexist("ftest.asl")

<<"$sz  \n"


ftyp=ftype("ftest.asl")

<<"$ftyp\n"

chkStr(ftyp,"regular")


att= fstat( "ftest.asl","uid")

<<"$att\n"


att= fstat( "ftest.asl","ctime")

<<"$att\n"
dt=time2date(att)

<<"$dt\n"

chkOut()
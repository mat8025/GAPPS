///
///  file ops
///


sz=fexist("ftest.asl")

<<"$sz  \n"


typ=ftype("ftest.asl")

<<" $typ\n"

att= fstat( "ftest.asl","uid")

<<"$att\n"


att= fstat( "ftest.asl","ctime")

<<"$att\n"
dt=time2date(att)

<<"$dt\n"
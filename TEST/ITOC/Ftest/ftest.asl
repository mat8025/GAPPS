///
///  file ops
///


sz=fexist("ftest.asl")

<<"$sz  \n"

a=ftest("ftest.asl","reg")

<<" $a\n"

typ=ftype("ftest.asl","type")

<<" $typ\n"


a=ftest("ftest.asl","dir")

<<" $a\n"


a=ftest("../Ftest","dir")

<<" $a\n"
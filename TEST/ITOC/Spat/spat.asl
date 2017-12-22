
checkIn()

fname = "mt_20100422_112017.txt"

mat = 0
index = 0
ss = "."

fstem = spat(fname,ss,-1,1,&mat,&index)

cc = slen(fname)
stem_len = slen(fstem)
<<"%V$fname $cc $stem_len $ss $fstem $mat $index \n"

checkNum(mat,1);

checkStr(fstem,"mt_20100422_112017");

checkOut();

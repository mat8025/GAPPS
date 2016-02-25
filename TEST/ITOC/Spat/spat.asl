

fname = "mt_20100422_112004.txt"

mat = 0
index = 0
ss = "."
fs = spat(fname,ss,-1,1,&mat,&index)
cc = slen(fname)

<<"%V$fname $cc $ss $fs $mat $index \n"

//int K[60]= Igen(60,1,1)

K= Igen(30,1,1)


<<" $K \n"
<<" ////////////// \n"

<<"%(10,\t, ,\n)$K \n"
<<"%(10,\t,\,,\n)$K \n"
<<"%(10,\t,\",\n)$K \n"
<<"%(10,\t,\',\n)$K \n"

<<"%(10,a b c ,\',\n)$K \n"

<<"%(10,<,|,>\n)$K \n"

<<"%(10,<,\s,>\n)$K \n"








stop!

// FIX <<"%(10,<,\,,>\n)$K \n"

<<"%(10,<,|,>\n)$K \n"
<<"%(10,x,oxo,x\n)$K \n"

<<"%(10,<,\,,>\n)$K \n"
a = 10
<<"%($a,<,\,,>\n)$K \n"

a = 5
<<"%($a,<,\,,>\n)$K \n"

pre = "<---"
post = "--->\n"
asep = "|"
a = 4
<<"%($a,$pre,$asep,$post)$K \n"

// FIXME printing extra empty row

a= 3
asep = ","
<<"%($a,$pre,$asep,$post)$K \n"

a= 2
asep = "#"
pre = "\$\$"
post = "\$\n"
<<"%($a,$pre,$asep,$post)$K \n"


stop!

a = 6

<<"%($a, , ,\n) $K \n"

a = 5

<<"%($a,\n) $K \n"



for (a = 10 ; a >= 2; a--) {
<<"$a \n"
<<"%($a,<<,\s\t>>\n) $K \n"
<<"//////////\n"

}


for (a = 10 ; a >= 2; a--) {
<<"$a \n"
<<"%($a,<<,\s\t>>\n) $K \n"
<<"//////////\n"

}



stop!

b="xx"
c="y\n"

<<"%($rowcnt,$prerow,$asep,$postrow)$V\n"

;


n = periodicNumber("mercury")
<<" $n \n"

<<" $(periodicNumber('mercury')) \n"
pname="silver"
// FIXED
str rname= supper("mercury")
<<"%V $rname \n"

str qname

qname= supper("mercury")

<<"%V $qname \n"

qname= slower('mercury')

<<"%V $qname \n"

<<" $pname @+ $qname \n"

rname = pname @+ "_FIXED"
<<"%V $rname \n"

<<"$(pname @+ 'mercury')\n"
<<"$(pname @+ (' mercury'))\n"
// FIXED
<<"$(pname @+ \"mercury\")  \"HELP\" \n"


// FIXED 
<<" $(periodicNumber(\"mercury\")) \n"

char a = scnt('A')
<<" $a \n"

uint M = scnt("Learning")

w1 = "STOP"
w2 = "POST"


<<" $w1 is $(w1) of $w2 \n"

 if (scnt(w1) == scnt(w2)) {

<<" $w1 is $(\"anagram\") of $w2 \n"

 }

<<"%V $M \n"

char b = scnt('a') + scnt('B')
<<"%V $b \n"

uchar e = scnt('a')
<<" %V $e \n"

uchar d 
d = scnt('a')
<<" %V $d \n"

char c = 2 + 3
<<" $c \n"



//int k = 'A' + 'B'
int k 

 k = atoi('1') + atoi('2')

<<" $k \n"

stop!
;

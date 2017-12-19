#

CheckIn()

setdebug(1,"pline","trace","stoponerror")

char c = 65;
char p = 'q';

<<"%I $c $p \n"
<<"%I %c$c %c$p \n"

<<"%V $c\n"
<<"%V $p\n"


str s = "abc"

<<"%I $s %s$s \n"

str tease = "a b c "

//FIXIT missing varname

<<"<%i$tease> %v<%s$tease> \n"
<<"<%i$tease> <%s$tease> \n"

uchar cv[] = { 65,47,79,0xBA };


 sz= Caz(cv)
 
<<"%V$sz $cv \n"

 cve = cv[0]

<<"%V$cve\n"
<<"%V$cv[0]\n"

 CheckNum(cve,65)

 cv[0] = 'M';
 
 cve = cv[0]

<<"%V$cve\n"
<<"%V$cv[0]\n"

 CheckNum(cv[0],77)

 str ls = 'abc'

 CheckNum(cv[3],0xBA)



<<"%I %hx $cv \n"
<<"%I %s $cv \n"

wc = scnt('G')

<<"%V $wc $(typeof(wc))\n"

char dv[] = { 'G', 25, 28, 78, 'O', '0', 69, 75,76,77 }

<<"%I $dv \n"
<<"$dv \n"



char a = 'G';

<<"%I $a \n"

<<"%V $dv[0] $a \n"

 CheckNum(dv[0],a)


 CheckNum(dv[0], wc )

 CheckNum(dv[0], 'G' )



<<"%V $dv  \n"

<<"%V $dv[1]  \n"

 CheckNum(dv[1],25)

  char b = dv[4];

<<"%V $b %d $b\n"
<<"%V $dv[4]\n";

//iread()

 CheckNum(dv[4], 'O' )


<<" whaat is happenning here $dv[5] \n"

 tc = scnt('0');
 <<"%V $tc\n";
 CheckNum(dv[5], scnt('0') )
<<" Imm not really cleaaaaaaar \n" 


 CheckNum(dv[5], '0' )

S="hey";

char lv[] = { 'ABCDEF MARK$S TERRY NEEDS TO FOCUS ' }

sz = Caz(lv)
<<"%v $sz \n"
<<"%V $lv \n"

<<" $lv[0] \n"
<<" $lv[1] \n"
//iread("->");

char ev[] = { "ABCDEF MARK$S TERRY NEEDS TO FOCUS " }


<<"%V$ev \n"
sz = Caz(ev)
<<"%v $sz \n"


<<"%V $ev \n"

//iread("->");

 CheckNum(ev[0],'A')
 CheckNum(ev[7],'M')

<<"%I %s $lv \n"

 CheckNum(lv[0],'A')
 CheckNum(lv[7],'M')
 CheckNum(lv[11],'$')

 CheckOut()

STOP!


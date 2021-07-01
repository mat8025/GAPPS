///
///  S string but should be able to be accessed like a dynamic char array
///
<|Use_=
S string but should be able to be accessed like a dynamic char array
|>


#include "debug"


if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

chkIn(_dblevel)

int a = 79;

a->info(1)




Str S = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


len= slen(S)

<<"<|$S|>\n"


<<"%V$len\n"

char c

c = 65;
c->info(1)

<<"%V %c$c \n"
c= S[2]
c->info(1)
<<"%V %c$c \n"

chkC(c,'C')

char CV[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
CV->info(1)
<<"CV %s $CV\n"

char d;
d = CV[2]
d->info(1)
<<"%V $d %c $d \n"

chkC(d,'C')

<<"S[3] $S[3]\n"


s = S[2:10:2]
s->info(1)

<<"s: <|$s|> \n"

chkStr(s,"CEGIK")

<<"s: %c <|$s|> \n"

e = CV[3:9:2]

e->info(1)

<<"%c <|$e|> \n"



<<"%s <|$e|> \n"

t= s;
chkStr(t,"CEGIK")
<<"t: $t\n"

t->info(1)

/*

c = S[-1]  // last element in str
c = S[-2]  // last but one element in str

S[3] = 'X'


S[3:7] = 'x'


*/
chkOut()
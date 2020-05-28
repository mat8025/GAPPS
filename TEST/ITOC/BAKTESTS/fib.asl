

use_long =0;

if (use_long) {
ulong a = 1;
ulong b = 0;
}
else {

pan a = 1.0;
pan b = 0;

}
pan t = a;
<<"%V $a $b $t\n"

for (i=0;i<1000;i++) {
<<"$i <|$b|> $t $a  \n";

t= a
//a= a +b   // BUG pan version
a= t +b 
b = t 

}
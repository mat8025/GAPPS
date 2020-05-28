///
///
///


setdebug(0,@keep,@trace,@pline)


checkIn()

str s = "hi there";
 

<<"%V $s \n"

checkStr(s,"hi there")

s= Supper(s,0,1);

<<"%V $s \n"

s->reverse()

<<" $s \n"

s[4] = 'A'; // TBF

<<"%V $s \n"

s[2:3]->cut() // TBF

<<" $s \n"



char c;

c = s[3];

<<"%V %c $c  $c     $s\n"


d= sele(s,2,3)

<<"%V %c $c %d $c $d    $s\n"

str name = "johndoe"


char C[];

     scpy(C,name);

<<"%V $name \n"
char R[]
<<"%V $C \n"

   len = slen(name)

<<"%V $len\n"


for (i= 0; i < len; i++)
{
  R[i] = C[i] + i;
}

<<"%V $R\n"

<<"%V %s $R\n"



es = s[3];

<<"%V $s $es\n"

checkOut()






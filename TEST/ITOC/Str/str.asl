setdebug(0)



str s = "hi there"
//str s 

 s = "hi there"

<<"%I $s \n"

<<"$s \n"


s->reverse()

<<" $s \n"

s[4] = 'A';

<<"%V $s \n"

s[2:3]->cut()

<<" $s \n"

char c;

c = s[3];
//d= s->sele(0,1)
d= sele(s,3,1)

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

STOP("DONE")





setdebug(0)


int i = 3

<<"%I $i \n"

#{
str s = "hi"

<<"%I $s \n"

STOP!

#}

//str s 



s= "hi "


<<"%I $s \n"

s->cat(" there"," baby!")

<<"%I $s \n"

s->reverse()

<<"%I $s \n"

a = "hello world"

<<"%I $a \n"

// TBD element ops on str
//<<"  $a[1] \n"

b = "move"


c=  a @+ b

<<"%I $c \n"




// S is svar

S = { "hello", "world", "this", "is", "a", "crazy", "time" }


<<"%i $S \n"

<<" $S[0] \n"

<<" $S[1] \n"



<<"orig: $S \n"

S->reverse()

<<"reversed: $S \n"

S->shuffle(10)

<<"shuffled: $S \n"

S->sort()

<<"sorted: $S \n"

S[2:5]->cut()

<<" cut out 2:5 elements of the string \n"
<<" $S \n"

S[2] = b


STOP!




proc poo( av )
{
  <<"$_cproc %i $av \n"
  av = "over"
  <<"%i $av \n"
}



poo (a)

<<"%i $a \n"



poo (S)


<<"%i $S \n"

STOP("DONE")

<<" $a[0] \n"

<<" $a[1] \n"



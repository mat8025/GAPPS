
setDebug(1)

//str s_lit;

s_lit = 'hey\|there'

<<"%V$s_lit $(typeof(s_lit))\n"


 s_dq = "hey\|there"

<<"%V$s_dq $(typeof(s_dq))\n"

exit()
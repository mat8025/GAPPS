

 k = 79

 g = cast(k,FLOAT)

 <<"%V $k $g \n"


 i = cast(g,INT)

 <<"%V $k $g $i\n"

<<"$i $(typeof(i)) \n"



 s = cast(g,SHORT)

 <<"%V $k $g $i $s\n"

<<"$s $(typeof(s)) \n"


 c = cast(g,CHAR)

 <<"%V $k $g $i $s\n"

<<"$c $(typeof(c)) \n"

;
//b = 1/115200.0
d = 115200
<<"$(typeof(d)) $d \n"
c = cast(d,FLOAT)
<<"$(typeof(c)) $c \n"
b = 1.0/cast(d,FLOAT)
// FIX b should FLOAT type
<<"$(typeof(b)) $b \n"
 retype(b,DOUBLE)

<<"$(typeof(b)) $b \n"



b = 1/(115200.0/8.0)

<<"$(typeof(b)) %12.9f$b \n"


 e = cast(123,FLOAT)

<<"$(typeof(e)) $e \n"
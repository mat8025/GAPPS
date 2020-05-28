
// use an int for 3 * 10 bit words


int I = 0

val = 256

a = val
b = val
c = val

<<"$(decbin(a))\n"

<<"$I $a $b $c \n"

// careful with precedence
I = ((a << 20) |( b << 10) | (c))

<<"%u$I %x$I \n"
<<"$(decbin(I))\n"

d = ((I >> 20) & 0x3FF)

e = ((I >> 10) & 0x3FF)

f = (I &  0x3FF)


<<"$d $e $f \n"


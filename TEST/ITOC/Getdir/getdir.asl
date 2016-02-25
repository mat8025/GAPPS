
setdebug(1)
dir=getDir()

sz = Caz(dir)

<<"%V$sz\n"

<<"%V<$dir|>\n"
<<"<<$dir>>\n"

name="mt"

<<"%V${dir[0]}/foo\n"

<<"%V$name/foo\n"

str sdir
sdir=getDir()

sz = Caz(sdir)

<<"%V$sz\n"

<<"%V<$sdir|>\n"
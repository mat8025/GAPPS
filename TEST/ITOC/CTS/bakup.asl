#
#
sig = getAlias("signals")
<<"$sig\n"

home = getAlias("home")
<<"$home\n"

tools = getAlias("tools")
<<"%V$tools\n"

wdir= !!"pwd"
<<" $wdir\n"
home2 = getEnv("HOME")

<<" $home  $home2\n"

//putmem("lauren-name","Zeeck")
sn=getMem("lauren-name")
//<<"$sn\n"

for (i=0; i< argc(); i++) {

<<"$i $_clarg[i]\n"
}
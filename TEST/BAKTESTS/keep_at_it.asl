
mypid = getpid()
for (i= 1; i <= 10; i++) {

nanosleep(1,1)
<<"$V one-thousand and $i\n"
}

exit("$mypid done")


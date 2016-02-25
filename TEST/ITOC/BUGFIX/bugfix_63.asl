

today=getDate(2, '/')    // FIX anon char arg ???

<<"$today \n"

char sep = '/'

today=getDate(2, sep)    // FIX anon char arg ???

<<"$today \n"


for (i = 1; i <=17 ; i++) {
     today=getDate(i,sep)
<<"form $i $today\n" 
}

for (i = 1; i <=17 ; i++) {
     today=getDate(i,'.')
<<"form $i $today\n" 
}



for (i = 1; i <=17 ; i++) {
     today=getDate(i,'/')
<<"form $i $today\n" 
}
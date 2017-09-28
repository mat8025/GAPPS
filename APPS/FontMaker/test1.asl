
 fname = "A";

 s= sele(fname,0,1);
 
 char c;

 c = pickc(fname,0);

 <<"%V $s $c\n"

 c++;

 <<"%V $s $c %d $c\n"

 s = "%c$c"

 <<"%V $s $c\n"


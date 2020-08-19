setdebug(1,@keep,@trace,@showresults,@filter,0)

pan totn=2;

<<"%V$totn \n"

pan Anum[100];

int np =  3;

<<"%V$np \n"

na = argc();
<<"%V $na \n"
if (argc() > 1) {
 np =  atoi (_clarg[1])
}

a = np * 2;

<<"%V $a\n"

pan begin = 1;
pan end = 10;
<<"%V $begin $end\n"

for (i=0; i < (np-1) ; i++) {
    begin *= 10;
<<"<$i> %V $begin\n"
}



<<"%V$np \n"


      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
<<"%V $totn  $i\n"
     }



exit()




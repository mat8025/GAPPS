
dir = _clargs[1]
prog = _clargs[0]

<<"$_clargs   \n"

<<"$_clargs[0:-1]   \n"


<<"$prog $dir \n"



fnames = !!"ls \"$dir/\"*.JPG "

<<"%1R $fnames \n"

sz = Caz(fnames)

<<"%v $sz \n"




  for (i = 0; i < 5 ; i++) {

   <<"$i \"$fnames[i]\" \n"

  <<"wc \"$fnames[i]\" \n"


 
 !!"ls -l \"$fnames[i]\" "
// !!"ls -l \'$fnames[i]\' "

 //  ans=!!"wc \'$fnames[i]\' "

 //  <<" $ans \n"


//<<"$i \n"

  }

<<"exit loop @ $i \n"

stop!




;	
///
///
///
setdebug(1,"trace")

svar svn;
i = 1;

  vn = "a_$i"
  $vn = i*2
  y = $vn
<<"$vn $y $($vn)\n"
i = 2
  vn = "a_$i"
  $vn = i*2
  y = $vn
<<"$vn $y $($vn)\n"


  i = 0
  svn[i] = "c_$i";
  i = 1
  svn[i] = "c_$i";
  i = 2;
  svn[i] = "c_$i";
  i = 3;
  svn[i] = "c_$i";  
  i = 1;
  
  $svn[i] = 47
  y = $svn[i]

<<"%V$svn \n"

<<"%V$i $svn[i] \n"

<<"%V$y \n"

<<"$svn[i] $y $($svn[i])\n"

i = 2;
  $svn[i] = 79
  y = $svn[i]

<<"%V$i $svn[i] \n"

<<"%V$y \n"

<<"$svn[i] $y $($svn[i])\n"
   c_2 = 80;
  y = $svn[i]

<<"%V$i $svn[i] $y\n"

<<"%V $i $svn[i] $($svn[i]) $c_2  $(c_2) $y\n"

<<"%V $svn[i]=   $($svn[i]) \n"
<<"%V $svn[i]=  ${c_2}=\n"   





for (i = 0; i < 5; i++) {
  vn = "a_$i"
  $vn = i*2
  y = $vn
<<"%V$vn $y\n"
}


<<"$a_1 $a_4\n"



for (i = 0; i < 5; i++) {
  svn[i] = "b_$i"
//<<"svn[${i}] $svn[i]\n"  
  $svn[i] = i*2

<<"$svn[i] =  $($svn[i])\n"

}
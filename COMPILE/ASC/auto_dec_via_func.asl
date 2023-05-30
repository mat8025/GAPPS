///
///  auto_dec_via_func
/// 




  ignoreErrors()

  x = atan(1.0)

  p = 4 * x

  y = sin( p/2.0)



<<"%V $x $p $y \n"

 S= functions() ; S.sort(); <<"%(1, , ,\n)$S\n"

// S.pinfo()

 F= search(S," atan (");
 <<"%(1, , ,\n)$F\n"


 F= search(S," sin (");
 <<"%(1, , ,\n)$F\n"


 F= search(S," search (");
 <<"%(1, , ,\n)$F\n"

///////////////////////////////////////

 


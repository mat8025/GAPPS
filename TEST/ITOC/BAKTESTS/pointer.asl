
///
/// pointer ops
///

 D= igen(20,0,1)
 <<"$D\n"
 

  p = &D;

// should  PoINT -- ptr to int
<<"%V %ld$p $(typeof(p)) \n"

// p[0] should first element 
// *p++   operations
// *p--   does this keep within the memory ranges

<<"D[] = $D\n"

<<" $p[0] \n"
<<" $p[1] \n"
k = 2
<<" $p[k] \n"

<<" $p \n"

// dv = *p;
 dv = p[0];
 dv2 = p[2];

<<"$dv $dv2\n"
<<"$p[0:-1]\n"

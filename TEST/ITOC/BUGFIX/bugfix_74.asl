//
//  bug print out with :
//


a = 47

<<"%V$a\n"

<<"A: $a\n"     // BUG won't print!!!
<<"A : $a\n"
<<"; $a\n"  
<<": $a\n"  // BUG won't print!!!
<<":: $a\n"  // BUG won't print!!!
<<"-:: $a\n"  // BUG won't print!!!
<<" :: $a\n"  // BUG won't print!!!

<<":- $a\n"     

<<"A; $a\n"

<<"A%V $a\n"


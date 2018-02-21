// armstrong number -ASL version
  a = 0 ;  n= 0  
  do {
     b= 0
    do {
     c= 0
     do {
       d= a*100 + b * 10 + c
       int e = a^3 + b^3 + c^3
       if (e == d)        <<"$(++n) $d $e\n"
    c++    
   } while (c <= 9)
//<<" end innermost  do \n"
   b++
   } while (b <= 9)
<<" end inner do \n"
   a++
   } while (a <= 9)
STOP!
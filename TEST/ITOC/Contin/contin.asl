//
// continue line test
//

Checkin()

a = 5.0
b = 57

float c = a + b

<<" $a + $b = $c \n"

CheckFNum(c,62,6)

  c = a * \
  b ;

<<" $a * $b = $c \n"

CheckFNum(c,285,6)


  c = a / \
  b ;

CheckFNum(c,0.087719,6)


<<" $a / $b = $c \n"

  c  = ( a+ b) / \
        (a - b);

<<" ($a + $b) / ($a - $b) = $c \n"

CheckFNum(c,-1.192308,6)

  c  = ( a+ b)  \
       / (a - b);

<<" ($a + $b) / ($a - $b) = $c \n"

CheckFNum(c,-1.192308,6)


   w1= scat("hey",\
   " buddy")
   <<"$w1\n"

checkStr(w1,"hey buddy")

   w2= scat("hey"," buddy ", "what's", \
                   " going ", \
		   " on ");
   <<"$w2\n"


CheckOut()
stop!

;
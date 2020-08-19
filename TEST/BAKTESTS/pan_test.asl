setdebug(1)


pan a = 1

<<"%V$a $(typeof(a)) \n"


int k = 3


 k += 2

<<"%V$k\n"

    k = 1

    while (k < 12) {

//  k++
//  c = a * 12
//  c = k

<<"$k $(typeof(k)) $a $(typeof(a)) \n"

//<<"$k $c $(typeof(c)) \n"

    d=i_read()

    if (++k > 6) {
      break
    }

      a++
   }

////////////////////////////////////////////


pan p
pan b



<<"%V$p $(typeof(p)) \n"

a++

<<"$a $(typeof(a)) \n"

p++

<<"%V$p $(typeof(p)) \n"

b = a

<<"%V$b $(typeof(b)) \n"

<<"$b += $k \n"

  b += k

<<"$b $(typeof(b)) $k $(typeof(k))\n"

b += 2

<<"$b $(typeof(b)) \n"

 c = a + b

<<"$c $(typeof(c)) \n"

    a= 1

    k = 1

    while (k < 12) {

//  k++
//  c = a * 12
//  c = k

<<"$k $(typeof(k)) $a $(typeof(a)) \n"


//<<"$k $c $(typeof(c)) \n"

    d=i_read()

    k++

    if (k > 6) {
      break
    }

      a++
   }

//////////////////////////////////



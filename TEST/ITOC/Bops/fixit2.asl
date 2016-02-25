

int k = 0

<<"%V $k \n"

++k


<<"%V $k \n"

  if (++k >=2 ) {
<<"%V $k >= 2\n"

  }
  else {

<<"%V $k < 2\n"

  }

z = k


N = 7
 while (z < N) {
 z = k++
<<"%V $z < $N\n"

 }

N = -7
 while ((--k > N)) {

<<"%V $k > $N\n"

 }

stop!


//
// it is too slow
// unless the operation is vectors - using C++ lib

N = 100

F= fgen (N,0,0.125)

float fsum = 0 

Tm = FineTime()
float a;
float b = 1.0
float c = 10.0;

  for (i= 0; i < N ; i++) {

    a = b * c;
    b += 0.01;
    c -= 0.01;

  }

dt = FineTimeSince(Tm)

<<"%V$N muls $a $b $c  in $dt microsecs \n"

Tm = FineTime()

  for (i= 0; i < N ; i++) {

    fsum += F[i];

  }

dt = FineTimeSince(Tm)

<<"%V$N %$fsum  in $dt microsecs \n"
#! /usr/local/GASP/bin/asl

N = $2

<<" supplied arg is [ $N ] testing for <,=, or > than 1\n"
nwr = 4
j = 1
M = N + 3
while (j < M) {

  if (nwr == 4) {
  if (N > j ) {
    <<"$N > $j \n"
    j++
    <<"%v $j do we see this if true line ?\n"
  }
  else {
    <<"$N < $j \n"
    j++
    <<"%v $j do we see this else line ?\n"
  }
  }
}

STOP!

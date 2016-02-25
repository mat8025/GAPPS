#! /usr/local/GASP/bin/asl

// test svar indexing

S = $2
<<" $S \n"

short d = $3
<<"  $d %x $d\n"


STOP!
char c = 234
<<" $c \n"

c = 255
<<" $c \n"

c = 129
<<" $c \n"
  d =0
  int i
  c = 0
  for (i = 0 ; i < 65537; i++) {
    d += 1
    c += 1
  <<" $i $d $c \n"
  }


d = hexdec(S)

<<" $d \n"


<<" DONE \n"
STOP!

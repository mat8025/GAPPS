

int k = 80

sz= Caz(k)

b = Cab(k)
<<"$k $sz b $b \n"

int K[3] = {1,2,3}

sz = Caz(K)

<<"$K $sz\n"

b = Cab(K)

<<"$K $b\n"

int I[3][4]

b = Cab(I)
sz = Caz(I)
<<"b $b \n"
<<" $sz\n"

stop!

float t
float r
float c

double  f = -1.1

  for (j = 0; j < 30; j++) {
  k = f
  t = trunc(f)
  r = round(f)
  flr = floor(f)
  c = ceil(f)

<<"%V$j $k $t $r $flr $c $f\n"
   f += 0.05

  }
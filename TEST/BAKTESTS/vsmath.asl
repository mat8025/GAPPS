//  test vector scalar math
//  main and in procs

proc foo()
{
<<"$_proc \n"
  for (i = 0; i < 10 ; i++) {
  bin = i
  r = (12 - bin) * 2
  m = (12 - V[bin]) * 2

  <<"$m  = $r  ?\n"
  }

}

proc goo()
{
<<"$_proc \n"
int j
int r
int bin
int m

  for (j = 0; j < 10 ; j++) {
  bin = j
  r = (12 - bin) * 2
  m = (12 - V[bin]) * 2

  <<"$m  = $r  ?\n"
  }

}

proc moo()
{
<<"$_proc \n"
   foo()

   goo()


}


V = vgen(INT_,10,0,1)

<<"$V \n"

int bin = 2


for (i = 0; i < 10 ; i++) {
  bin = i
  r = (12 - bin) * 2
  m = (12 - V[bin]) * 2

  <<"$m  = $r  ?\n"
}




 foo()

 goo()


 moo()




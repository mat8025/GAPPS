checkIn()


N = 24

k = 2
ok =0
  if (k <= N) {
<<" $k  <= $N \n"
   ok = 1
<<" <= op  working!\n"
  }
  else {
<<" <= op not working! %V$k\n"
  }

CheckNum(1,ok)

ok = 0
k = 25

  if (k >= N) {
<<" $k  >= $N \n"
   ok = 1
<<" >= op  working!\n"
  }
  else {
<<" >= op not working! %V$k\n"
  }


CheckNum(1,ok)


checkOut()
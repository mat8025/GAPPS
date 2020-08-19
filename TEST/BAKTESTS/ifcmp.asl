int ok = 0
int bad = 0
int ntest = 0

int M[10]
SetPCW("writepic","writeexe")
SetDebug(1)

  M = 8

<<" $M[0] \n"

<<" $M \n"

b=Cab(M)
<<" $b \n"

<<"%V $(Caz(M)) $(Cab(M))\n"

sz = Caz(M)

    if (sz == 10) {
<<"PASS %v $sz == 10 \n"
    ok++

    }
   ntest++

    if ( Caz(M) == 9) {
<<"PASS func %v $(Caz(M)) == 9 \n"
      ok++
    }
    elif ( Caz(M) == 10) {
<<"PASS elif func %v $(Caz(M)) == 10 \n"
      ok++
    }
    elif ( Caz(M) == 0) {
      bad++
    }
    else {
     <<"fail $(Caz(M)) != 10 \n"
     bad++
    }

 ntest++

<<"$ntest $ok $bad \n"

STOP!
# test ASL function 

chkIn()




 ename = periodicName(1)

//<<" $ename \n"


  for (i = 1; i <= 100; i++) {
    ename = periodicName(i)
   if (ename @= "unknown_element")
     break
   <<"%-16s$(periodicName(i)) \t$i\t%-4s$(periodicSymbol(i)) \t%6.3f$(periodicWt(i)) \n"

  }

  an = periodicNumber("Iron")

chkN(an,26)

<<" Iron is $an \n"

  we = "Manganese"
  an = periodicNumber(we)
<<" $we is $an \n"

chkN(an,25)

  we = "silver"
  an = periodicNumber(we)
<<" $we is $an \n"

chkN(an,47)


  we = "mercury"
  an = periodicNumber(we)
<<" $we is $an \n"

chkN(an,80)

  we = "gold"
  an = periodicNumber(we)
<<" $we is $an \n"

chkN(an,79)

  we = "silver"
  ans = ptsym(we)

<<"$we $ans\n"

chkOut()

/*
 I 53
 Snag 5047
 iron 7787
 poof 84 8 8 9
 Nag  7 47
 close 17 8 34
 pair  91 77
 pace  91 58
 bite  83 52
 woof  74 8  8 9
 At    85
 coat  2785
 feat 26 85
 cute 29 85
 beat  5 85
 acute 89 92 52
*/
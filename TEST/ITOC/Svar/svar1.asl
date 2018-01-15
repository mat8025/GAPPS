
setdebug(1);

CheckIn()

//Svar msg[];

Svar msg[] = { "we all have to try harder", " yes indeed" }

<<"$msg \n"

<<"%V$msg[0] $msg[1] \n"

<<"%I$msg \n"

msgstr = "we all have to try still harder"

<<"%I$msgstr \n"

 wmsg = Split(msg)

<<" $wmsg \n"

<<" $wmsg[0] \n"
<<" $wmsg[1] \n"
<<" $wmsg[*] \n"



   if (wmsg[1] @= "all") {
    <<" correct!\n"
   }
   else {
    <<" incorrect! <$wmsg[1]> != all\n"

   }
  CheckStr(wmsg[1],"all")
  CheckStr(wmsg[5],"harder")

 vmsg = Split(msgstr)

<<"$vmsg[*] \n"

  CheckStr(vmsg[1],"all")
  CheckStr(vmsg[6],"harder")

  sa1 = getArgStr()
  sa2 = getArgStr()

<<"%I $sa1 \n"
<<"%I $sa2 \n"

  sargv = _clarg

<<" $sargv \n"
<<"%(1,<, ,>\n) $sargv \n"


svar S = Split("how did we get here")


 r00 = S[0];

 r01 = S[1];


<<"%V $r00 $r01\n"

  CheckStr(r00,"how")
  CheckStr(r01,"did")


Svar wval[];


Svar asv;


     wval[0] = "mark"
     wval[1] = "terry"
      wval[2] = "step"
       wval[3] = "by"

<<"wval $(caz(wval)) :: $wval[::] \n"


     wval[4] = "increase elements?";

<<"wval $(caz(wval)) :: $wval[::] \n"

     wval[7] = "working to skip elements?";



    asv = wval[0];

    CheckStr(asv,"mark")

   asv2 = wval[1]



 <<"%V $asv2 \n"

    CheckStr(asv2,"terry")

<<"wval $(caz(wval)) :: $wval[::] \n"


CheckOut()


STOP!







 <<" $asv \n"

 

    CheckStr(asv,wval[1])












lib="/usr/local/GASP/gasp-3.2.3/LIB"
<<"%V$lib \n"


 Svar CLTPT
 int cltpt = 0

    CLTPT[cltpt++] = "first"

   sz = Caz(CLTPT)

<<"%V $CLTPT[*] $sz $cltpt\n"

    fv = CLTPT[0]

<<"%V $fv $CLTPT[0] \n"

   lib = CLTPT[cltpt-1]
<<" %v $lib \n"

    CheckStr(lib,"first")

    CLTPT[cltpt++] = "second"



   sz = Caz(CLTPT)
<<"%V $CLTPT[*] $sz $cltpt\n"

    sv = CLTPT[1]

<<"%V $sv $CLTPT[1] \n"

<<"%V $CLTPT[*] $sz $cltpt\n"

    fv = CLTPT[0]

<<"%V $fv $CLTPT[0] \n"

   lib = CLTPT[cltpt-1]
<<" %v $lib \n"

    CheckStr(lib,"second")

    CLTPT[cltpt++] = "third"

   sz = Caz(CLTPT)

<<"%V $CLTPT[*] $sz $cltpt\n"

   lib = CLTPT[cltpt-1]
<<" %v $lib \n"

    CheckStr(lib,"third")


    CLTPT[cltpt++] = "fourth"

   sz = Caz(CLTPT)

<<"%V $CLTPT[*] $sz $cltpt\n"

   lib = CLTPT[cltpt-1]
<<" %v $lib \n"

    CheckStr(lib,"fourth")


<<" $CLTPT[0] \n"

    fv = CLTPT[0]

<<"%V$fv $CLTPT[0] \n"


   for (j = 0; j < 4; j++) {
<<"[${j}] $CLTPT[j] \n"
   }

    CheckOut()

    STOP("DONE")



  while (AnotherArg()) {

    targ = GetArgStr()

    CLTPT[cltpt] = targ

     <<" %V $targ  $cltpt  $CLTPT[cltpt] \n"
        cltpt++
   sz = Caz(CLTPT)
<<"%v $CLTPT[*] $sz\n"
  }


<<"%V$CLTPT \n"

<<"%V$CLTPT[0] \n"

<<"%V$CLTPT[1] \n"


<<"%V$CLTPT[*] \n"



STOP!

int cnttpt = 0

   while (1) {

	 the_start = CLTPT[cnttpt]

	  <<"%V  $the_start $cnttpt $CLTPT[cnttpt] \n"

         cnttpt++
       if (cnttpt >= cltpt)
          break
   }


STOP("DONE")


na = Caz(_clarg)
<<"%v $na \n"

yourclargs = _clarg

<<"%v $yourclargs \n"

<<"clargs are  $_clarg \n"

<<"clargs are  $_clarg[*] \n"

<<" $_clarg[0:na-1:] \n"

      for (i = 0 ; i < na ; i++) {

           <<"arg [${i}]  ${_clarg[i+1]} \n"

      }


  k = 0

    while (AnotherArg(k)) {

    s= getArgStr(k)

<<"arg $k was $s \n"

       k++

    }

  s= getArgStr(2)

<<"arg 2 was $s \n"

STOP!


sv= "mark is doings lists a lot"

<<" $sv \n"

      lv = split(sv)

<<" $lv[0] \n"

<<" $lv[2] \n"

<<" $lv[*] \n"

<<"indexing 0:4:1 $lv[0:4:1] \n"

<<"indexing 0:4:2 $lv[0:4:2] \n"


STOP!

ntest = 0
ok = 0
k =1
 while (1) {

    na = AnotherArg()
    sa = GetArgStr()
<<" $sa $k \n"
    if (sa @= "$k") {
        ok++
    }

    if (na <= 0)
         break
    ntest++
    k++
<<" $na left  $sa \n"
 }



 na = argc()

 svar av

 for (i = 1; i < na ; i++) {
   av = $i
  <<" $i $av  $(typeof(av))\n"
 }


 pcc= (100.0 * ok)/ntest
<<" $pcc \n"

prog=$0
<<"%-24s: $prog :asl_verify_count %3d $ntest :success %3d $ok %4.1f $pcc\% \n"
STOP("DONE \n")


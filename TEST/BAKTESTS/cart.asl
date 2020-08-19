

aprg = "bops"

CFLAGS = "-dcwl"

a1 = "10"

<<"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"

!!"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"
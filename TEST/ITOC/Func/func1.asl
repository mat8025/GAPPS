
CheckIn()

// foota returns arg values into double array

//dv = testargs(1,2)

jal = 0

j = 4

fva= testargs(2*3,4+1,j*2)

<<"%(1,,,\n)$fva \n"

jal = 2
fvs = fva[jal]

<<"%V $fvs\n"


Checkstr(fvs,"6")




jal++

jal += (2 * 10)


int A[]

  A=igen(5,0,1)

jal += 9

dv= testargs(A,1,2,3)

<<"%(1,,\s,\n)$dv \n"

 F = vgen(FLOAT_,6,0,1)

<<"$F\n"

fva2= testargs(F)

<<"%(1,,,\n)$fva2 \n"

jal = 2
fvs = fva2[jal]
col = split(fvs)


<<"%V$jal \n"
<<"$fvs\n"
<<"$col\n"

   checkstr(col[1],"0.000000")

jal = 3
fvs = fva2[jal]
col = split(fvs)

checkstr(col[1],"5.000000")

   CheckOut()


STOP!

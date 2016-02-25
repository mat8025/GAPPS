
CheckIn()

// foota returns arg values into double array

dv = testargs(1,2)

jal = 0

j = 4

fva= testargs(2*3,4+1,j*2)

<<"%(1,,,\n)$fva \n"

jal = 8
fvs = fva[jal]
col = split(fvs)
<<"$fvs\n"
<<"$col\n"


Checkstr(col[1],"6")
jal++

jal += (2 * 10)

//dv= testargs(j*3,j+1, j-2, j *3, 12/j)

//<<"%(1,,,\n)$dv \n"

//   CheckNum(dv[0],12)
//   CheckNum(dv[4],3)

int A[]

  A=igen(5,0,1)

jal += 9

dv= testargs(A,1,2,3)

<<"%(1,,,\n)$dv \n"

 F = fgen(6,0,1)

fva= testargs(F)

<<"%(1,,,\n)$fva \n"
jal = 14
fvs = fva[jal]
col = split(fvs)
<<"%V$jal \n"
<<"$fvs\n"
<<"$col\n"

   checkstr(col[1],"0.000000")
jal++
fvs = fva[jal]
col = split(fvs)
<<"$fvs\n"
<<"$col\n"

   checkstr(col[1],"1.000000")
jal++
fvs = fva[jal]
col = split(fvs)
<<"$fvs\n"
<<"$col\n"

   checkstr(col[1],"2.000000")

   CheckOut()


STOP!

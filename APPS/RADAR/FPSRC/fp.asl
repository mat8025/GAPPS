
opendll("uac")

// test harness for flightphase
setdebug(1)
float TA[10]

// read in a flight TA's

A = 0

fp_log_file = 0
fname = _clarg[1]

if (scmp(fname,"fp_log",6)) 
  fp_log_file = 1



A= ofr(_clarg[1])
if (fp_log) {
  R = ReadRecord(A,@type,FLOAT,@del,',')
}
else {
  R = ReadRecord(A,@type,FLOAT,@del)
}
     sz = Caz(R)
  
     nrows = sz[1]

<<"%V$nrows \n"
<<"%V$sz $dmn\n"

  ncols = sz[2]

  <<"%V$ncols \n"

if (fp_log_file) {
  TA = R[::][1,6]
}
else {
// test_case
 TA = R[::][0,1]
}

if (fp_log_file) {
  // extract tim and alt
for (j = 0; j < 10 ; j++) {
<<"$R[j][1] $R[j][6] $R[j][7] \n"
}
}
else {
for (j = 0; j < 10 ; j++) {
<<"$R[j][0] $R[j][1]  \n"
}

}

for (j = 0; j < 10 ; j++) {
<<"$TA[j][0] $TA[j][1] \n"
}





FP = flightphase(TA)

sz = Caz(FP)
<<"%V$sz \n"
if (fp_log_file)
new_name = sele(fname,0,-4)
else
new_name = sele(fname,0,-3)

new_name = ssub(new_name,"fp_log_","")
<<"$fname $new_name\n"
nrows = sz[1]
B=ofw("${new_name}_rfp.txt")
<<[B],"# $new_name\n"
<<[B],"# tim alt SimFp RadFP\n"
for (j = 0; j < nrows ; j++) {
<<[B],"$TA[j][0],$TA[j][1],$FP[j][0],$FP[j][1] \n"
}

cf(B)
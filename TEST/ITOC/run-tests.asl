///
///
///

A=ofr("good")

 nt = argc()
 where = getDir();
 
while (1) {

    L=readline(A)
    if (feof(A)) {
     break;
    }
S= split(L)
  
  //  dir = _clarg[i];
    dir = S[0];
    
    chdir(dir)

    test = slower(dir)
    <<"$i $dir $test\n"
   if (fexist("${test}.asl")) {
    <<"asl -cwl ${test}.asl\n"
    !!"asl -cwl -o ${test}.out -t ${test}.tst -e ${test}.err ${test}.asl"
//    !!"asl -x $test"    
   }
    chdir(where);
 }
 
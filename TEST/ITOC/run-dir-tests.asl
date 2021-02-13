///
///
///

// in ITOC dir read file of required asl tests (not all present)

A=ofr("tests-todo.txt")

 where = getDir();

int kt = 0;

while (1) {

    L=readline(A)
    if (feof(A)) {
     break;
    }
    S= split(L)
  
  //  dir = _clarg[i];

    test = S[0];
    <<"$kt $where $test\n"
   if (fexist("${test}.asl")) {
    <<"asl -cwl ${test}.asl\n"
    !!"asl -cwl -o ${test}.out -t ${test}.tst -e ${test}.err ${test}.asl"
    !!"asl -o ${test}.xout -e ${test}.xerr  -t ${test}.xtst  -x $test"    
   }
   kt++;
   //if (kt > 3)       break;
 }
 
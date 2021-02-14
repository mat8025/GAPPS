///
///
///

// in ITOC dir read file of required asl tests (not all present)

A=ofr("tests-todo.txt")

// if no file - make it   -  ls *.asl > tests-todo.txt
if (A == -1) {
!!"ls *.asl > tests-todo.txt"
A=ofr("tests-todo.txt")
}

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
    iv= sstr(test,".asl")
    if (iv != -1) {
      test->trim(-4)
    }

    arg = S[1];
    <<"$kt $where $test <|$arg|>\n"
   if (fexist("${test}.asl")) {
    <<"asl -cwl ${test}.asl $arg\n"
    !!"asl -cwl -o ${test}.out -t ${test}${arg}.tst -e ${test}.err ${test}.asl $arg"

    !!"asl -o ${test}.xout -e ${test}.xerr  -t ${test}${arg}.xtst  -x $test $arg"    
   }
   kt++;
   //if (kt > 3)       break;
 }
 
///
///
///

setDebug(1,"pline","trace","~step")

k = 1;
<<"$k\n"
k++;

<<"$k\n"






A = testargs(79);
<<"$A\n"



A = testargs(3);
<<"$A\n"
<<"%(1, , ,,\n)$A\n"




A=testargs(k,"pline","trace","step");
<<"%(1, , ,,\n)$A\n"


<<"///////////////\n"
<<"%(1, , ,,\n)$A\n"
//ans = iread();
//<<"$ans\n"

ms= "fine"

<<"$ms\n"

Tcf = ofw("test_crashes");

<<"$Tcf \n"
<<[Tcf]"oh come on!!\n"

cf(Tcf)


<<"$k \n";

q =79;


Z = vgen(INT_,10,0,1)


A = testargs(1,k,&q, Z, &Z[2]);
<<"///////////////\n"
<<"%(1, , ,,\n)$A\n"



B = testargs("fine",ms, "a very long goodbye");
<<"%(1, , ,,\n)$B\n"

C = testargs("test_crashes");
<<"%(1, , ,,\n)$C\n"


wr=typeof(C)
<<"%V$wr\n"

<<"%V$(typeof(C))\n"


D= testargs("$wr $k");
<<"%(1, , ,,\n)$D\n"

D= testargs("$(k+1)");
<<"%(1, , ,,\n)$D\n"


D= testargs("$(pow(k,2))");
<<"%(1, , ,,\n)$D\n"

E= testargs("$(caz(C))");
<<"%(1, , ,,\n)$E\n"

E= testargs("$(typeof(C))");
<<"%(1, , ,,\n)$E\n"
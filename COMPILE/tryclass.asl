
str a0 = getArgStr(0);
str a1 = getArgStr(1);
str a2 = getArgStr(2);
str a3 = getArgStr(3);
<<"%V $a0 $a1 $a2 $a3\n"
opendll("uac");
opendll("plot");
test_class(a0,a1,a2,a3);


exit();



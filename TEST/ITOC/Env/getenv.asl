

proc moo()
{

scope=showScope()

<<"%V $scope\n"

}

///

my_xsize = getenv("GS_XSIZE")

<<"%v= $my_xsize \n";

my_evar = getenv("GS_L")

<<"%v= <|${my_evar}|> \n";
<<" <|${my_evar}|> \n";

my_evar = getenv("GS_DEBUG")

<<"%v= $my_evar \n";

scope=showScope()

<<"%V $scope\n"

moo()

scope=showScope()

<<"%V $scope\n"


exit()
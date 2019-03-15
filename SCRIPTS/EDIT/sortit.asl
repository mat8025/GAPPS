///
///
///
svar T;
//A=ofr("2sort")
A=0
T=readfile(A);

S=Sort(T)
S->dewhite()
S->trim(-4)
//S->trim(4)

//<<"$S\n"
<<"%(1,                  ,  , \\\n)$S\n"

//<<"<|$S[0]|> <|$S[1]|> \n"
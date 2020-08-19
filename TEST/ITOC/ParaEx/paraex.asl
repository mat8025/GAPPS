
chkIn()


w="a"

a="Happy New"

<<"$($w) Year \n"

se = "$($w) Year"

<<"$se \n"


B= "A\"B\"C\n"

<<"$B"



chkStr(se,"Happy New Year")

<<" a\ssimple\tstring\n %% \n"


<<" a\ssimple\vstring\v\b\b\a\%\"P \n"

A="internal\sstring\n"

<<"$A"

v="oow.asl"
<<"grep \"DONE: :$v\" "
<<"\n"

char C[]
char E[]

//C[0] = 47

sz= Caz(C)
<<"C sz $sz\n"

scpy(C,"Mark")

<<"Char array C contains $C[0] %s$C\n"

<<"m %d$C[0]\n"

chkN(C[0],'M')

<<"%d$C\n"



scpy(C,"\tmark\bK\%\b\"EFX\"")

<<"%d$C\n"
<<"%c$C\n"

<<"DQ? %d$C[9] %c$C[9]\n"
<<"tab %d$C[0]\n"

chkN(C[0],'\t')  // FIXIT 

chkN(C[0],9)




//chkN(C[9],'\"')

chkN(C[9],34)

<<"%d$C\n"
<<"%c$C\n"
<<"%s$C\n"

ws = scat("\"Mark\"","\s\"Terry\"")
<<"$ws \n"

ws=scat("\tmark\bK\%\b\"EFX\"","\tterry\bL\%\b\"AMP\"")
<<"$ws \n"



C=scat("\tmark\bK\%\b\"EFX\"","\tterry\bL\%\b\"AMP\"")

<<"%d$C\n"
<<"%c$C\n"
<<"%s$C\n"


E=scat("Happy"," Hols")
<<"%Vs$E\n"

chkOut()



;

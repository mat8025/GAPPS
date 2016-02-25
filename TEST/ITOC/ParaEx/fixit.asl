
setdebug(1)
S= "ABC"

<<"$S\n"



B= "A\"B\"C";

<<"$B\n"

<<"A\"B\"C\n"


C =  scat("A\"B\"C","D\"E\"F")

<<"$C\n"



C =  "A\"B\"C" @+ "D\"E\"F"

<<"$C\n"


char CV[3]

CV[0] = 'm'
CV[1] = '\t'

<<"$CV[0] $CV[1] \n"

if (CV[0] == 'm') {
 <<"$CV[0] is a m\n"
}

if (CV[1] == '\t') {
 <<"$CV[1] is a tab\n"
}


 tc = checkNum(CV[1],'\t')

<<"$tc \n"

 tc = checkNum(CV[1],9)

<<"$tc \n"

 tc = checkNum(CV[0],'m')

<<"$tc \n"

stop!



char CV2[] = "abcde\t"


<<"$CV2\n"
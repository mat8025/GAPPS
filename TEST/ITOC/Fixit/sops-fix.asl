


//char E[>3]
//char E[]

EC= vgen(CHAR_,10,60,1)

<<"$EC\n"

ac= EC[1]

<<"$EC[0] $EC[1] $EC[2] $ac\n"

exit()


str s = scat("Happy"," Hols")
<<"$s\n"
char C[] = scat("Happy"," Hols")
<<"%Vs$C\n"

<<"%Vd$C\n"


char E[] = scat("Happy"," Hols") ; // should cpy into start?
char D[] = scpy("Happy"," Hols") ; // should init
char G[] = {'Happy Hols'} ; // correct

str fs = "les vacances sont"
char H[] = {"$fs finies"} ; // correct

//char J[] = { "$(scat(\"Happy\",\" Hols\"))" } ; // should init


E->info(1)

<<"$(typeof(E))\n"
<<"$(Caz(E)) \n"


<<"%d$E[0] \n"
<<"%d$E[1] \n"



<<"%Vd$E\n"

<<"%Vs$E\n"


<<"%Vs$D\n"
<<"%Vs$G\n"
<<"%s H:$H\n"

//<<"%s J:$J\n"

<<"$(scat(\"Happy\",\" Hols\"))\n"
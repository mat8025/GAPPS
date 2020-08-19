


proc GetMsg (ws)
{

   Svar emsg;

     emsg = ws

<<" scmp testing of $ws $emsg[0] \n"

     if (emsg[0] @= "NO_MSG") {

<<"%V $emsg[0] is @= NO_MSG  $ws\n"


     }

     if (!(emsg[0] @= "NO_MSG")) {

        <<"%V $emsg[0] is ! @= NO_MSG  $ws\n"


     }
}





  GetMsg("NO_MSGX")

  GetMsg("NO_MSG")

  GetMsg("NO_MSGX")



stop!
